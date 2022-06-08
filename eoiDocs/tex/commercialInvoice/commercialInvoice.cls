\ProvidesClass{commercialInvoice}
\NeedsTeXFormat{LaTeX2e}
%\LoadClass{article}
\LoadClass[landscape]{memoir}
\usepackage{tcolorbox}
\usepackage{lastpage}
\usepackage[mmddyyyy]{datetime}
\usepackage[letterpaper,landscape,left=.5in,right=.5in,top=.5in,bottom=1in]{geometry}
\graphicspath{{../images/}}

\iffalse
%--------------------------------------------------------
% Our Information
\newcommand\email{info@hobbs-eo.com}
\newcommand\website{http://hobbs-eo.com}
\newcommand\company{Hobbs ElectroOptics}
\newcommand\logo{eoiLogo}
\fi

\newcommand\shipper{Simon Hobbs}
\newcommand\phone{(914) 236-3005}
\newcommand\city{Briarcliff Manor}
\newcommand\state{New York}
\newcommand\addressA{160 N. State Road}
\newcommand\addressB{Suite 203}
\newcommand\addressC{\city, \state, 10510}
\newcommand\country{United States of America}
\newcommand\contactC{\phone}
\newcommand\contactA{\website}
\newcommand\contactB{\email}

\iffalse
%------------------------------------------------------
% Order Info
\newcommand\shipMethod{USPS Priority}
\newcommand\orderNumber{1}
\newcommand\invoiceNumber{1}
\newcommand\orderDate{\today}
\newcommand\termsOfSale{NET 30}
\newcommand\documentDate{\today}
\newcommand\items{1}
\newcommand\authorizedBy{Frodo}
\newcommand\lbs{1}
\newcommand\ounces{14}
\newcommand\TIN{}
\newcommand\purpose{Destroy the one ring}
\newcommand\subtotal{\$0 USD}
\newcommand\packingCost{\$0 USD}
\newcommand\postageCost{\$0 USD}
\newcommand\insuranceCost{\$0 USD}
\newcommand\totalCost{\$0 USD}

%------------------------------------------------------
% Billing Info
\newcommand\billingName{Smeagol}
\newcommand\billingCompany{Mordor, LLC.}
\newcommand\billingAddressA{1 Mount Doom}
\newcommand\billingAddressB{Mordor, Middle Earth}
\newcommand\billingAddressC{}
\newcommand\shippingCountry{Baradure}


%------------------------------------------------------
% Shipping Info
\newcommand\shippingName{\billingName}
\newcommand\shippingCompany{\billingCompany}
\newcommand\shippingAddressA{\billingAddressA}
\newcommand\shippingAddressB{\billingAddressB}
\newcommand\shippingAddressC{\billingAddressC}

\fi

\usepackage{xcolor}%
\definecolor{webblue}{rgb}{0, 1, 1}  % less intense blue
\definecolor{webred}{rgb}{2, 0.4, 0}   % less intense red
\definecolor{eoibg}{RGB}{250,250,230}
\definecolor{eoibgDark}{RGB}{235,235,216}
\definecolor{eoilogo}{RGB}{23,121,107}
\definecolor{white}{RGB}{255,255,255}
\definecolor{darkblue}{RGB}{0,0,150}



\newcommand\lineColor{eoilogo}

\newcommand\templateLineLengthPt{\textwidth}

%\pagestyle{empty}
% ****************************************
\makepagestyle{pageWithLine}
\makeevenfoot{pageWithLine}{\vspace{-11pt}\includegraphics[width=.1\paperwidth]{\logo}}{}{Page \thepage/\pageref{LastPage}}
\makeoddfoot{pageWithLine}{\textbf{Page \thepage/\pageref{LastPage}}}{}{\vspace{-11pt}\includegraphics[width=.1\paperwidth]{\logo}}
\makeevenhead{pageWithLine}{}{}{}
\makeoddhead{pageWithLine}{}{}{}

\makeheadfootruleprefix{pageWithLine}{\centering\color{\lineColor}}{\color{\lineColor}}
\makefootrule{pageWithLine}{\templateLineLengthPt}{2pt}{\footruleskip}

\pagestyle{pageWithLine}
\linespread{1}
%-------------------------------------------
% make top
\newcommand{\makeTop}{
	\begin{minipage}{.15\textwidth}
	\includegraphics[width=.8\textwidth]{\logo}
	\end{minipage}
	\begin{minipage}{.25\textwidth}
	\centering
	\textbf{\addressA\\
	\addressB\\
	\addressC}
	\end{minipage}
	\begin{minipage}{.25\textwidth}
    \centering
	\textbf{\contactA\\
	\contactB\\
	\contactC}
	\end{minipage}
	\begin{minipage}{.25\textwidth}
	\begin{tabular}{|l |l|}
	\hline
	\textbf{Order: }\orderNumber & \textbf{Ship Method: }\shipMethod\\
	\hline
	\end{tabular}
	\end{minipage}
	\newline
}

	\newenvironment{infoBox}{\begin{minipage}{.3\textwidth}
		\begin{tcolorbox}[height = 110pt, width=\textwidth,colback={white}, colbacktitle=white,boxrule=1pt,toprule=1pt,coltitle = black, outer arc=0mm, arc = 0mm]
		}
	{\end{tcolorbox}\end{minipage}}
	\newenvironment{halfBox}[1][90pt]{\begin{minipage}{.5\textwidth}
		\begin{tcolorbox}[height = #1, width=\textwidth,colback={white}, colbacktitle=white,boxrule=1pt,toprule=1pt,coltitle = black, outer arc=0mm, arc = 0mm]
		}
	{\end{tcolorbox}\end{minipage}}


%-------------------------------------------
% shipInfo
\newcommand{\shipInfo}{
	\begin{infoBox}
		\textbf{Shipper:}
		\vspace{5pt}\hrule\@width .4\linewidth \vspace{5pt}
		\shipper\\
		\company\\
		\addressA, \addressB\\
		\addressC\\
        \country\\
        \addShipLineA\\
        \addShipLineB\\
	\end{infoBox}
	\begin{minipage}{.04\textwidth}
	~
	\end{minipage}
	\begin{infoBox}
		\textbf{Buyer:}
		\vspace{5pt}\hrule\@width .4\linewidth \vspace{5pt}
		\billingName\\
		\billingCompany\\
		\billingAddressA\\
		\billingAddressB\\
		\billingAddressC\\
        \addBillLineA\\
        \addBillLineB\\
	\end{infoBox}
	\begin{minipage}{.04\textwidth}
	~
	\end{minipage}
	\begin{infoBox}
		\textbf{Recipient:}
		\vspace{5pt}\hrule\@width .4\linewidth \vspace{5pt}
		\shippingName\\
		\shippingCompany\\
		\shippingAddressA\\
		\shippingAddressB\\
		\shippingAddressC\\
        \addReceiveLineA\\
        \addReceiveLineB
	\end{infoBox}
}


%-------------------------------------------
% customerInfo


\newcommand{\customerInfo}{
    \begin{minipage}{\textwidth}
	\begin{halfBox}[70pt]
		\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}l l}
		\textbf{Order Number: }&\orderNumber\\
		\textbf{Invoice: }&\invoiceNumber\\
		\textbf{Order Date: }&\orderDate\\
		\textbf{Document Date: }&\documentDate\\
		\textbf{Line Items: }&\items\\
		\end{tabular*}
	\end{halfBox}
	\begin{halfBox}[70pt]
		\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}l l}
		\textbf{Terms of Sale: }&\termsOfSale\\
		\textbf{Purpose of Shipment: }&\purpose\\
		\textbf{Country of Destination: }&\shippingCountry\\
		\textbf{Gross Weight: }&\lbs\textbf{lb}~~\ounces\textbf{oz}\\
		\end{tabular*}
	\end{halfBox}
    \end{minipage}
}

%-------------------------------------------
% orderItem
\newenvironment{orderItem}{
	\begin{tabular*}{\textwidth}{|p{.04\textwidth}|p{.35\textwidth}|p{.2\textwidth}|p{.1\textwidth}|p{.1\textwidth}|p{.107\textwidth}|}
	\hline
    \centering
	\textbf{Line Item}& \textbf{Description}& \textbf{Country of Manufacture}&  \textbf{Quantity}& \textbf{Unit Value}& \textbf{Total Value}\\\hline
	}
{\end{tabular*}}

%-------------------------------------------
% packagingList
\newcommand{\makePackagingList}{
	\centering
	\makeTop

	\vspace{11pt}
    \shipInfo
	\vspace{11pt}
	\customerInfo
	}

%-------------------------------------------
% summary Lines
\newcommand{\makeSignatures}{
	\vfill
    \begin{minipage}{\textwidth}
    \begin{halfBox}[115pt]
    \small These commodities, technologies, or software were exported from the United States of America in accordance with the Export
    Administration regulations. It is hereby certified that this invoice shows: (1) the actual price of the goods described,
    and (2) that all particulars are true and correct.

    \normalsize
    \textbf{Authorized By:}\\

    \noindent\rule{.9\linewidth}{0.4pt}\\
    \authorizedBy, \documentDate\\
    \city, \state, USA
    \vspace{-10pt}\\
    \end{halfBox}
    \begin{halfBox}[115pt]
    \begin{tabular}{rl}
    \textbf{Subtotal:} & \subtotal\\
    \textbf{Packing Cost:} & \packingCost\\
    \textbf{Postage Cost:} & \postageCost\\
    \textbf{Insurance Cost:} & \insuranceCost\\
    \textbf{Total Invoice Value:} & \totalCost\\
    \end{tabular}
    \end{halfBox}
    \end{minipage}
	}

