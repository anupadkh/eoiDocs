import os, click, datetime
from pylatex.base_classes import Environment
from pylatex.document import Document
from pylatex import Section, Subsection, Command, UnsafeCommand
from pylatex.table import Tabular, Tabu, LongTabu
from pylatex.utils import italic, NoEscape, bold
import pkg_resources, readline

TEX_PATH = pkg_resources.resource_filename('eoiDocs', 'tex/')
class OrderItems(Environment):
    _latex_name = 'orderItems'


class Doc(object):
    defaultImagePath = os.path.join(TEX_PATH, "images")
    def make(self, company = 'heo'):
        #Get doc to enter
        #ask for a place to save the output
        #make doc
        while(True):
            savePath = click.prompt("Enter a directory to save to")
            if(os.path.isdir(savePath)):
                os.chdir(savePath)
                break
            else:
                print("Directory {} does not exist".format(savePath))
        
        doc = Document(documentclass = self.docClass)
        doc.set_variable('graphicsPath', "{%s}, {%s}"%(self.imagePath, self.defaultImagePath))
        #doc.set_variable('images', self.imagePath)
        if company == 'eoi':
            context = {
                'company':'ElectroOptical Innovations, LLC',
                'website':'https://electrooptical.net',
                'email':'info@electrooptical.net',
                'logo':os.path.join(self.defaultImagePath, 'eoiLogo.png')
            }
        else:
            context = {
                'company':'Hobbs ElectroOptics',
                'website':'https://hobbs-eo.com',
                'email':'info@hobbs-eo.com',
                'logo':os.path.join(self.defaultImagePath, 'heoRightJust.pdf')
            }
        self.genDoc(doc, context)
        doc.generate_pdf(clean_tex=False)

    def genDoc(self, doc, context):
        pass


class PackingList(Doc):
    texBase = "packingList"
    docClass = os.path.join(TEX_PATH, texBase, "packingList")
    imagePath = os.path.join(TEX_PATH, texBase, "images")

    def genDoc(self, doc, context):
        shipMethod = click.prompt('Shipping Method', default = 'USPS Priority')
        orderNumber = click.prompt('Order Number', default = '1')
        invoiceNumber = click.prompt('Invoice Number', default = '1')
        today = datetime.date.today().strftime('%B %d, %Y')
        orderDate = click.prompt('Order Date', default = today)
        documentDate = click.prompt('Document Date', default = today)

        name = click.prompt('Billing Name')
        company = click.prompt('Company')
        addressA = click.prompt('Address Line 1')
        addressB = click.prompt('Address Line 2')
        addressC = click.prompt('Address Line 3')
        if(click.confirm("Different Shipping Address?")):
            shippingName = click.prompt('Shipping Name')
            shippingCompany = click.prompt('Company')
            shippingAddressA = click.prompt('Address Line 1')
            shippingAddressB = click.prompt('Address Line 2')
            shippingAddressC = click.prompt('Address Line 3')
        else:
            shippingName = name
            shippingCompany = company
            shippingAddressA = addressA 
            shippingAddressB = addressB
            shippingAddressC = addressC 
        
        doc.set_variable('logo', context['logo'])#os.path.join(self.defaultImagePath, 'heoRightJust.pdf'))
        doc.set_variable('company', context['company'])
        doc.set_variable('email', context['email'])
        doc.set_variable('website', context['website'])


        doc.set_variable('shipMethod', shipMethod)
        doc.set_variable('orderNumber', orderNumber)
        doc.set_variable('invoiceNumber', invoiceNumber)
        doc.set_variable('orderDate', orderDate)
        doc.set_variable('documentDate', documentDate)
        doc.set_variable('billingName', name)
        doc.set_variable('billingCompany', company)
        doc.set_variable('billingAddressA', addressA)
        doc.set_variable('billingAddressB', addressB)
        doc.set_variable('billingAddressC', addressC)

        doc.set_variable('shippingName', shippingName)
        doc.set_variable('shippingCompany', shippingCompany)
        doc.set_variable('shippingAddressA', shippingAddressA)
        doc.set_variable('shippingAddressB', shippingAddressB)
        doc.set_variable('shippingAddressC', shippingAddressC)

        doc.append(Command('makePackagingList'))
        
        items = self.getItems(doc)
        doc.set_variable('items', items)

    def getItems(self, doc):
        count = 0
        "X[r] X[r] X[r] X[r] X[r] X[r]"
        a = "X[1,c] X[1,c] X[2,c] X[6,l] X[1,c] X[1,c]"
        "\textwidth}{@{\extracolsep{\fill}}|p{.08\textwidth}|p{.08\textwidth}|p{.08\textwidth}|l|p{.08\textwidth}|p{.08\textwidth}|"
        with doc.create(LongTabu(a)) as data_table:
            header = ['Ordered', 'Line Item', 'Location', 'Item', 'Shipped', 'Backordered']
            data_table.add_row(header, mapper=[bold])
            data_table.add_hline()
            data_table.add_empty_row()
            data_table.end_table_header()

            while(click.confirm('Add item?')):
                count += 1
                name = click.prompt('Item Name')
                descrip = click.prompt('Description')
                loc = click.prompt('Location', default = '')
                ordered = click.prompt('Number Ordered', type = float)
                shipped = click.prompt('Number Shipped', default = ordered, type = float)
                backordered = click.prompt('Number Back Ordered', default = ordered - shipped, type = float)

                data_table.add_row([ordered, count, loc, "{}: {}".format(name, descrip), shipped, backordered])
                data_table.add_hline()
        return count
