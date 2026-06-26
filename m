Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602A19DF6A
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782448277; cv=fail; b=aZ6m4wTJWTmG5cSsvk2ynMjwGYFKqELLET20kG3vF3Ulbaadp4ehtj+RBwTMMDbQZLl+QA9jjG31bVgrmyxG2d13QulivqWZm7xw5K9AJUgailUIwJneYa6AtK1998gVWptEyGCHTID3BtEQtK0Zw5na1ImdmrmQt5XgMgoQyXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782448277; c=relaxed/simple;
	bh=JHoc9RpAzm14CPf5YROMm+KgXyE60EQSorhNGlPIPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3oI8JSIhYZ7TQEyL3u+zD9DQ82CZQl3LguC+729bEFHy4Q9BX0itd7YvsATl9bFq0EhxrgsGfq1f5x0MlNzjAPzSjJfxfUWe4V0v7IfMz1UdrWI4mVPzlNbe19tDNjZOFl18CdcfP1zYwXkuZevD+4c6rKbuY5m/4fRPXy7N34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ur9HqsdT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TkEr/ILP; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ur9HqsdT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TkEr/ILP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782448275; x=1813984275;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JHoc9RpAzm14CPf5YROMm+KgXyE60EQSorhNGlPIPA4=;
  b=Ur9HqsdTpANcxTPtLggORYYBRAlRNi3lKEUjYEALrNBIlEUF2bdXiEun
   CmF1G9Egva6b288lcwINTv0cQUkvcln7fc6Oji+TNqNY1cTR4iS7FTTJC
   ukyXmGo2ewQG5pqNVAYgvDTu9hNXrw/DkFjstU0qv/VO0l1jfznXDo2+q
   sPhBplR3jpS4bmraEPhqZ1JWuniY7gTlSdZ87ZmCEsDHZkimaErnQ666i
   b8WoOTeeo5GNNEBhynCZ9Tc+lTLp/Adrz7eDzIZbaeCC/QD7yLffco46v
   KSlJkfy9h/KkJ3JS1KT30veU2iCr+ztyj3fLHWvdy5eamNjc+y5BDzHUO
   g==;
X-CSE-ConnectionGUID: dv7a1JP5T7KsiuMd3rciyQ==
X-CSE-MsgGUID: yC3sS8wHSNWWbWg368RPww==
X-IronPort-AV: E=Sophos;i="6.24,225,1774281600"; 
   d="scan'208";a="150761426"
Received: from mail-eastusazon11012003.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2026 12:31:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6t4vNKmlTw3KTRjm5d3rxcUhrf8Bl9VGWNCeyRJbubTAlWYOcZcjY8pnZd+pOMf0MiugdmiXpcZnIbfXempLcBFGpUF2XiBKXaruIf54K4VgJm42ZivYTgH/naDzXqMsiKRFdffiaq5Gl4G+lyJzqcTx0cijcaPHZGBjFpRULxRWCN1Td8Q/U3qavsMi6I//LrQkm9VRFrQxODX7UGzFnmIoe4aFjgJDpiR5hDCHa3by7wSD/xLdghJZVzaEDeddd7eNJOEGtrtWrXwYmbFDvDqH2rsnlifFNO/kBJpp2U8XHRpdFZMdMzf3NbCIsljv05WVtJMWGPwRy0jouROqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogH76AtfL5ilnLN+XvpfY3QF5TFZLYqmoN9IsHOGnQI=;
 b=RCV24SOiuyoBpxQfpY96RL2Exn1xT1Dh3+Gl6CX3qRObK8vnMRUbHPco9YLCysCPnEDerZTeGECHmhZfYR8WZcAUNMCARMObeGEFGIaPGkX56H5IHNtx2dSj1Bq7vFCBzepMoi3jbL/hiLEmWKq29mAdrHlEQ11+HIFAZPzORGQ5Q6ZB2tM60lpwmH0sWxZVftNsWWAEJerp0nflU+FJugxg+IvS4jsIG4kbvFrEQ+W54i/zURoKBkD9+eEcNSBP9yerQzP7kv2eMSzZbopVdVOWPOnGPwJQhX/Ko+D6x9BNHrVFUvkbbidylCXHFWSmvtGP1g8jHBrb8qvldqvgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogH76AtfL5ilnLN+XvpfY3QF5TFZLYqmoN9IsHOGnQI=;
 b=TkEr/ILPzVQpFVSo22CcU0f0cvFEakwsrp1rcGzUTlSZTqaEpeZ+FrNJO4VTDTVdqgWwlV9bHkSRQ4xGAFvOwjbPSalQpzQJJLVPrTRLrN0Iq54UiSLpZnLjEm+X4ZxHrhDpLEl8oYRMcfV1za6E7XszByjcH3sJneSNHTmuEVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA6PR04MB9141.namprd04.prod.outlook.com
 (2603:10b6:806:40d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 04:31:13 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 04:31:13 +0000
Date: Fri, 26 Jun 2026 13:31:06 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <aj3_nKfmUFj67jX6@shinmob>
References: <20260622160808.1552568-1-hch@lst.de>
 <ajzJiWqsQc2EgR3I@shinmob>
 <20260625115422.GA18348@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625115422.GA18348@lst.de>
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA6PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6bbcc7-040f-4cd1-a7ff-08ded33bc126
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ri9YJXyomAye6dEeLkpSHNXEH0zmC3SrdwBrDI8tnHkqoS7N/P7E5npoosfpBWVsDXy/zF/E40MXRedDxiTdB6PXv2UsiXdhUyqqksLkAA7GBxvfwK6ky/QWNHK4WdkgyYZlJU0DYs6NHMRiTd23sHi0m+A+sW/fFu8qdQCUNRNEjVPgxjS75uiGRRCqhB9KtP+S6EFVJhXquWTxl5iglp6ngaSEy5mgKKmi6bMsunH/Ec/+AFVxpLRZuwJej6Hax69Ksc/bvVLfHTnZn3PHJE050fNjoaHn3wieAUwBHL5/PvMAV55BG01tLoq7iAjUL/TOVMxziWsoLfqt9ifLBQMaK/cEhBeOI5hiyVZmuJVKJ+j6RskYxn1Nn6gvoGbUZzMMS52gao0VnJpAxjg7zR4YeV0+nRjW9itF2SvfRYYvWoeAxL6bWApf2Kjr24J9n5fChdqj2GY1zZGlvHvjk81dLpdjCUSogZq3iWWzmHsYwyRZOTGWk9cuh/LfxJQoF8IhkiNvK8bnHIcZSp8K2NRzz0cHYVG5pwFbrjPX6xn++FM2xHoFA4H6ABqbjuidLY2+8le2w+EXava2EKaINC2fQote3m0YhevAkw3sBfUmhtgGOuKvGLIM+4wNdsOF8XyosEkuH1+90aZxSaqMdD1lS2Z0fSmFxtN1MYZznE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSfD86zJWBRHIqmVREUnRWD0iRNPctJjdyws0F8VxfnwAg41ucoByX5dXgtv?=
 =?us-ascii?Q?agY7+q9e8jwPoj7WPfukIrD96+MLv7/rNvJX6WMWFf2sHq5d9wshgTcPnFrE?=
 =?us-ascii?Q?5lVKoeEK8XDzAUcwXEduBow3v5+B+xn9jcM0EItGOXOm0Hf7ayGYT9dMPVf4?=
 =?us-ascii?Q?JpWLVsCSzSvrsx9bn+d28RKWT3BbivWg6pPve1ZQs/nSotb3SUD4Hr+U+JaT?=
 =?us-ascii?Q?YBH109qlk0wy2fItyKg51CxiinVV54oGM+YDUyRmEe+MophanxdL9+BcHSl1?=
 =?us-ascii?Q?KJCsITtEm63I7PJDn0RIZuit5xlgjMYlWPcdQQtz1BH2kepnNMfwMFqTbluf?=
 =?us-ascii?Q?pYZT6E5qZO85sB2CBKSLEkCbWiKB8h419YgtqMqyQ+8RzCE99G1kq8uHS1hS?=
 =?us-ascii?Q?+U8kVi8yDmljzIGVzIxlth8/p6VV7X/0yQv7JxSUVxz6W6G9wen8jM6s7jX7?=
 =?us-ascii?Q?tFsTRcfUirx0qa0dKmvwlcoFZTOaK7V52HNqJa/L0n35wJtaYOMZOGVuC16/?=
 =?us-ascii?Q?myIPmUYtahgDdLUY5U80ienHl7/vE5GAZW6/9QWOG39Hg9hxLlSDYArqlS7g?=
 =?us-ascii?Q?+Qzp8mLs/bAldkdk1Jcg7MCzaMKXXMSqifggwD1HTlXabIyVh/QO42Y9qYfM?=
 =?us-ascii?Q?F3g5YUM2zBoISfQ8kts+ax6Q15vxHkcTE3pHTDOcxL7PC9yylwZ7XQWj9Tat?=
 =?us-ascii?Q?9MZ8N2ZXvJzR9zNRMM2NuGsYQBgMLuEVlrwtw2SoBCbwecwpeUfWzi0oh8fo?=
 =?us-ascii?Q?81Ju+O8ez8rUFouriYB9l8j3gu5RuTy1FhVp8gLUtdJuTr9K37HaWerQwvo0?=
 =?us-ascii?Q?4X2bNczmQz9lrnMFCR1ge3fuIGpuhP5uuCpoInN8VDTlaS4AqcoGigx9KBcZ?=
 =?us-ascii?Q?58pKIVd/R8KJWKcJJTYjB+XqxidGf4R4vHVGeQaIuSYuWSMxsV7JglcpzaXQ?=
 =?us-ascii?Q?d1o85AfaHXCOYzRTgCaO05yTKJD7Io4uqgiXHq0jpFx1Or5oOS3C6FV9h9s7?=
 =?us-ascii?Q?pWdqocnLWqsowCgn8lhQzWDf6NFWe61Y7CiY2TSmcTUrU4GROml42roKVkKZ?=
 =?us-ascii?Q?BjTvdRaZuWZU3e4kDUMXdyTLAY0mUgO7S9RjwaGdl76i+Jjf95dwREFwjx11?=
 =?us-ascii?Q?Zf6plt6zhfXuohHMXCBSzRViUCyubNl2m1ln+lYXl2wKddj4AK6dTE3mKOjL?=
 =?us-ascii?Q?+32jdRwvLNvgrVlOy57yDbl3Lb1M9ht9xxqomSR8gusqIrcbjx8F4mhmUlK8?=
 =?us-ascii?Q?MeoK0KrqDL8er1e9hxrbAUXmPq9XY7o+ZcqpPBb4thuh+xTdmNdBN16rO02t?=
 =?us-ascii?Q?P6fjx7pO8smsBKxF7ceqATYwSwGMCytEGtaxD0YTvEGQObEPY4MwX6qgcHtV?=
 =?us-ascii?Q?q3ahwUYgYVn4bJHeAzgvkfnnbrQlFvJvJzHyp8slqjLe8JLizvexSdU471Oq?=
 =?us-ascii?Q?A2055eHhJvlm/6D0fapzp6HvwWn8V5H53UP8x6pxEvVy++yHqqMEMbz7h+T6?=
 =?us-ascii?Q?nZy8ecF+Gr/3zrQ5c816MHGuwVV4Sis4vH7QjKmSLbUGZmcFuA348JIaUbuf?=
 =?us-ascii?Q?QY4d1hCMtewB9R4eQTz3a3fKwczuAtwMM2lKoYev69nVG0dHpWyN28nwVBDe?=
 =?us-ascii?Q?ALQdfBcDTpr5LD+BZ4FzuRFe7OEzBmX5Q9mo6EPc43NTrbPU23ozHJSLcphc?=
 =?us-ascii?Q?euLWAUZHxW0nc1mEtAYaF3bUWOMMAC/d1hX6x4F0a0I9J2LU7uJuOFNkonh1?=
 =?us-ascii?Q?kgU6Cflo4T9yMt+8IQoWor64/CBLFsk=3D?=
X-Exchange-RoutingPolicyChecked:
	Y+ttk7c6LXnPmXEOh9R5HK+5GXGNhVIwdqku4hVJl3tGibdZKswGOVTBpH7vSCw1pob14uluFuoRjQlBSoVkSms97pV9RRpcioJk2XXKo35NA+LSOnDL3g/6TBhK29OB47/XWDG0Ztw4CbQ7sB6zjNB2QVRuPrlPzNFmipsSs1+bvpRTC/iKMStvMbNYM5XJTTQP3RP9Mu7cDY5eYusIZZv1g49Pgdo/d4NRTGrkaoHgTyL6S7SE7Bgz/F/L2eSY+CyZcuAaVEJEtIpRgYt/ZcQAWK+F5loOBDzzedXel7uYipGygUIQ6UtU7SeuYx9CTqGCSyPmtcO3z+eSogaHxA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZNVkXZ1F7w26ADL4UBGaTrjNruMdWqLxm6Uq91T5V2CZc4oMWXiQRK5XB52NbYhtjnTMA1O3FG0GUasfs05solIyQ3fmc34TOCDrcEW3gezCbssDAse/PmPG4u4t0wMbaOf3I5daE22H7XL2gQi/zPAWOK7+I6RJRX+UwS/5Fa5BUJwdyK/S4k1k8Ar4JY5DPt+7WCO2looLLSujeQUMNgMmyMt94CQ38ixdL0IxHULgvEXMbS2qu5Iq7K6EK+KNDIOfqqEnLx+V4EPpQtzyf5+1Qhla7nEqoycL3pbP9XxQNLJmRxB5cxb8yAq07kTQVwNdys5arrr0W1Q5WTeUiHTaVp/R7htgfw1kdW/SUKJ7QDWuXe+OWKWUCaYthLa0ut/iWfkWafbKHMj4CvXwNyxaCFCahqrY7O1XUIyu/wr0zl6U+lEplsIAdDAGNsfevf4zB9oU6WOWskZWxbrxZ14V8RCJ+3xfldf7zirdsBbZ8QG6UIG9tBhdxNLx7+sb1WJCoZyYp0jpJY887sg1o/P3RWyZGFKrqynOT60mQ8b5N5h9uxbM+4mqzP9lXykuPJH2Vhb72iXlAPx7CUytVjfdqEy7hqLiRtO/9WEKzzG/tP2qSNkUyRVXK1qC6BCW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6bbcc7-040f-4cd1-a7ff-08ded33bc126
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 04:31:13.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8zWZaHyUvacwppUp9wPE/1g61hlL5qiGpGeWIqY3dvJD8cfdLiAe6LqXOye2SUmaNnDQ5fCQ/+rrp41IECgmhdl4gXq/8dRQ0GTQ3ABxt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9141

On Jun 25, 2026 / 13:54, Christoph Hellwig wrote:
> On Thu, Jun 25, 2026 at 03:36:19PM +0900, Shin'ichiro Kawasaki wrote:
> > Hi Christoph, thanks for the patch. I ran the test case with block/for-next
> > kernel branch tip and confirmed that it is working as expected.
> > 
> > Please find my comments in line. FYI, I atttach the patch which reflects my
> > comments. If you are fine with the changes, please let me know so that I can
> > fold in the change and apply this patch.
> 
> > > +# SPDX-License-Identifier: GPL-2.0
> > 
> > Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
> > I suggest GPL-3.0+.
> 
> Well a mix of licenses is obviously bad, although I hate the GPL 3 with
> passion.

I see, I respoect author's choice.

> 
> > I suggest to add the line below.
> > 
> >        _have_kernel_option BLK_ERROR_INJECTION
> > 
> > This way, we can confirm the kernel has the required changes and
> > the dependent feature is enabled.
> 
> Sounds good, although this assumes we actually have /proc/config.gz?

Blktests checks both /proc/config.gz and /boot/config-$(uname -r), then I
think this to work on all test systems.

> 
> Otherwise the changes looks fine.
