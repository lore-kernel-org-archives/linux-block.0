Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43E31E826
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778323080; cv=fail; b=aZH079aMxhqfmoR/ZAKaUOWqizsSOXuEgnnGB5uLnQdIsh513Sb4a/nrnRKgCFhDPpx+SYFM/JxxLbmCbSasmEvI70LL0hDaqbWr3VT6/2DLKKwXfcXx9CUDICLbvwRT64gjtMsRIMR41YmEPWoTTNGI9Nii9Eml2Xhn9+RWa54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778323080; c=relaxed/simple;
	bh=mNKI4RhojdYVFTvygYkpmfhCSMtD6YafNCiIZL/AUGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uuxJU6iiXs0Mk9gjF0N4VbBL92HTa2XDc9IyBYsoG6/e2pAb+DJXFmpg/+nKTM1O+5ptch4/2sS4MN2pdj4ygLktklVV3DHDT5LjfiRcG0BhNr+a8KOvmSs7cn8jhUAOBz30kTG4fUAxdzTWDGv7UU9V7xDBbfRi/o0XZ23Nkog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZcXlvx/2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zwUd5wdE; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZcXlvx/2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zwUd5wdE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778323078; x=1809859078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mNKI4RhojdYVFTvygYkpmfhCSMtD6YafNCiIZL/AUGM=;
  b=ZcXlvx/2skMnTFI2/61U3jPDcy/A3lcPEPqWBrp1wxJajwnQcqWIz8FP
   RMOShpzLNgYusFMJEESrD0i43mzj3HoJ3ebmAli/MxrKnBmpk0cUNfXGD
   AKKxt3dAex13G0UEGBYCh00bcUEwdvUUSWzrAw3ttaBzvC2BalBQxF1f0
   NhPnU/gwpawvg2667mFwp5wtMdgniwHcoms2vHygbxhwEz/0+938+ENL4
   D+edQbcQlJkvy3MFLqrMok+U/yqyhr2H3P1TeXonmvW9HZXyn+5xd/Tdz
   /fQA5R7OAsjyn4i4+HF7CC1SjTHCcnGTvsYkKOPeyWk1pPYzAVXTtp4Rz
   A==;
X-CSE-ConnectionGUID: qQ+bHG8wSb61VjmH2uLlcA==
X-CSE-MsgGUID: QVAJbL43R7Oi8BTk2sz0hg==
X-IronPort-AV: E=Sophos;i="6.23,225,1770566400"; 
   d="scan'208";a="147386849"
Received: from mail-northcentralusazon11012016.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.16])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2026 18:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZY2oPuvD6wjJ2zVaJblOdPCHp5QrejHoGmvzLadWaSW+BfH3EmmA3QVwyjCgVqng7MFp8Ga8HT/SqK7mazSbKTAg5z74+GYIZMCSxygA9L4UODSRp6yiYIOu+NqbE5n7BKbjoEDY0tTZsjIR60O9+Rl7U9DMYABBeo7szel0jOGDxPHA8RXFzqi4oOdbQPQ/G0l1GOfSqYPzxvqXO9Xb89ItT6ZdJg+d3dszewasdHOAk+G8Cf12ce7mg0CfYmyx2AgepdWzPYufB/KYqUZfRTbXq5YhUhAtVAEek6LOklM4TviQs6ldi3+j8aCeOSzzdZRoQ0LSLSUsLmUKsqZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwS6jRmFZyjiifHR/LjztGmXIY94TZae0YE0UxBwRiM=;
 b=kmEAKdn5HXQDVvIWWIvu57vHIFvPq3PuUqM6ktYGsuIEtVzcPW8tGsGPL27znCbrN4GaW4deEjVZqDekLF8pM+DZ6c6H22nKPn3OByPnyph6KfKVK2HP+usTtUGeadkFxVj+E//bIP61PoJ7U4a9NOFjfY+j0Ac26U13dW3jtaMRDJlNJLfCYnbFCtMHGq0kJnZgrTLML5opu9CxVPrGDLm3tYUPL0oQ322yAtJgjxgjkWGU3VDrMGewIjMayIM5iDjcYKJi6EMm0clchJwVMWSjeACr1GW+LPGBvJUgjajyvHgbTxfxgdvHYisaLbn0bSgQToZx01qR9Ef2Kry1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwS6jRmFZyjiifHR/LjztGmXIY94TZae0YE0UxBwRiM=;
 b=zwUd5wdEl9GbYkdQVodDcBJlF++pJSJ13j/cvNqOnT65rGgfKLDET1cCuiq4H8ZB0Z35iYbXvT4d18oq5Sjv1tc9O+GM271FIOWrAjdQkz0P7NMxl8CT72t1wLjJD9BlEkI80//txvyjqZwHzkbw1PHUFbh3olaGgHmm4cSWXzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LVWPR04MB10073.namprd04.prod.outlook.com (2603:10b6:408:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 10:35:47 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:35:47 +0000
Date: Sat, 9 May 2026 12:35:41 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
Message-ID: <af8NJQLWj1lfjoUF@shinmob>
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
 <afIGq_uV-l9_98Px@shinmob>
 <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
X-ClientProxiedBy: TYCP301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::6) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|LVWPR04MB10073:EE_
X-MS-Office365-Filtering-Correlation-Id: 44135463-2911-456e-3533-08deadb6bb26
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	boToyCc6HIcb2A51NO6cOp++SRZiBd+CPloKwvIABSTTxKiIEV/R10qo/PnAVbcC7P8VR3WHy/TAgobisWHs4YDgAlIBT15EDf3LsUI2AZPFYLJwOErG8az8InTaSJuENFw9sVSdKb9srdXf+LsNypyhsHpTJRz5xFi/S7okgwwfPFmEQsAi+6oY0ZwRxj2Xf9g2OdjS9rBlHnbmsmfcQI+ElJqafH6rckhggR+n29r7pWhR1mpacdJ9mUNtXvSPpPeT6DSeD1NZqTk8fNDWnNrePZGjhMimoOOyKzmcG6ob7elsUV6CIcnALhVpOfBY3IEciLWqPxHdW6udyqUqKRj3TbNdnmZycVlUTUjj2sVkB7isZh46qPFvFO3ceqmACUEivGXeZo9AIlC6VQ7Y2sYoiXCmEOUJodEHphh+8g/UF9NvaYn3+pCiCaNsmqb1aq1/NKmjade0hfZ7p1Pm5kp5PFbywwY6+BwOV7Dl9YwdWzFi0JuR+/I8MXsPLfqZsgzobzFz8XeXV9I8DN0k0R4YlAj4aRxlWorRrE64ouc1RS0s5tlWlTliNM2z/EShRxoH0/SdFaEQ4wZJ0CHsvOCle6eJdqHd9bmrNNfD9ZKLM8voks1y5qfn3jS5ELmF0zuxax9wBECPhlORQvDW6laY1KZ3/GHLubmmCD0CaAXJvEHYJqX7c5ncdPcDYIGd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgcNhmX2JSdxTwa6lqJIqMROzR+nXY1wu/icYctIuVKy+Y+r2FVJWOSdTXIR?=
 =?us-ascii?Q?xXKzuR93FsQJpZeatTBsibBtE7LszrqHKIVTDUtveKX3BuIdWNN484w83IBm?=
 =?us-ascii?Q?CCo4JORvOeGYnTwIpoFCdNcvehlUc81bAkfQ+FWvqDG+mncl9hjqgdhz0cls?=
 =?us-ascii?Q?kt1pVnBxdWfGvKJcvG3tMCwT8L32oWllaRXG7analof53P5ma9h8GWob6RwQ?=
 =?us-ascii?Q?LYdBmqG9gMLNREt2655jie7kFp1dDpxvHxQxgrJGh1VI+eVrKMHv1Le2rcoP?=
 =?us-ascii?Q?7tF6lg7oaHM5SGAE1K4Ty5vjhIDWTu2zgJptkGxqt/1rzoBWQ3BmMvbH+d8P?=
 =?us-ascii?Q?htP94SrVZLCo5DG/rNoEU/Gv1GNnzU27Op4tjgf16oVVN4hRC/kFM5+6HmEX?=
 =?us-ascii?Q?VcRrRU18BZjldXUAhoQhsdGaEUcQcJc4eAm9ICb9lrWssM4KTxxy4LVsLxTu?=
 =?us-ascii?Q?ceLJYYpvWCcQh70zl7x8L+w5asEED5WbdScf6iXeMzy6U+Sej4CgJmd/SpDk?=
 =?us-ascii?Q?vhmVHIP55LVUuGcsNme19x2QA2xrOVwiZDQWu0BnDIojtp2WAl8JFH3WUU/5?=
 =?us-ascii?Q?qfzEO08OuZKi71l45DMizKt/IJCf3wpJqtRJc7unF7aHERep4KxlpuUZ/p69?=
 =?us-ascii?Q?NXUILWtXevziyeNMK7A1Ec8i3/ZTQRHaWvSaELmsRur74sikA3EeKUC77Z4j?=
 =?us-ascii?Q?DnnC6+FKcB7YaO7ru4mI3+Vx2Y4yh48VriCfuFd7SNtHs1by2//Rb08NM2Xy?=
 =?us-ascii?Q?ofqL27MccnKBIiMCr8eGECia7khY+Q5AbPzn1fAhAm24Ob4fV0Kdi/criFq/?=
 =?us-ascii?Q?gut7VLf7j6pLRAoW/asOJdkIq+/c5uia/ybJkNqvzjNYDf0RxmKaGxF+iaCD?=
 =?us-ascii?Q?Y11BEf2UTWy/LQ8lxQEEhBO7rqvsX0k5pjkgtbjH/ZVVunGj769y90fBfj0+?=
 =?us-ascii?Q?dXtQbpIt9tuleLBTgJkB95BQl7s74lsUM1GKBk47Oh5CoQieZQHIL2Y7q7BL?=
 =?us-ascii?Q?sjegIivvmhnaJD6Cc4f53NZzfkUMXHB1VxLUZsS7RBcISILDd3X0sDzcmaxs?=
 =?us-ascii?Q?mROoM2oSJ6n2xnyJNRAr5EGH+c3RiQ6ik/WE9Ng/+nNHD4add+aOvdSBRdma?=
 =?us-ascii?Q?hmpj+7C2zmgCrP0y34tK7DvhNR8zj2hQLgNJ3NSF97qXq63e+XZyR5lrfT7f?=
 =?us-ascii?Q?/nJqSD/SYDQfbn79x1BoSREVupwETlhk7SOS2CtLODS2MOU4hHWaTvMjdWXQ?=
 =?us-ascii?Q?5MCVCVZwglZ0QULNDwuSF9mL1OmtMz9MhJ88B108clO4CXw7h/cKf84aZQGB?=
 =?us-ascii?Q?Um3mqYUS4i//MnqHRgzZdtUHHclUub+nLLzQRxWeQJwZtv6UGzerTbxtmiVQ?=
 =?us-ascii?Q?yhfHuFWUKqYB1cL7ojGWd6T9UWwd/+/Y/apKOEE0XxLI9MUK8Gq6Crar1+tI?=
 =?us-ascii?Q?6JkAJi2if7Lxh7KVnUs4MHFbxv0QDZ4jG1Gc6eLscZv/hM0nUPsnTbftMc5n?=
 =?us-ascii?Q?v/se5eFlqPg17LSSZeQxdWtNqezWDOknbfHAzRApcOklQ9GkglSgHmCOytBw?=
 =?us-ascii?Q?QR4XAJnLstjdh0fCQsNq+m9ZJA7myxHLfZ++KBH9cdhvcCcqdjst126PgN9f?=
 =?us-ascii?Q?a9yR4wEWnX2EIoMbYZuYFyuug7btLdiKAfD0A0R5e42y6nckXmtLljp3kDVX?=
 =?us-ascii?Q?Tvh/YJmE/jYyfjcdu656lD+5HAv5/ztsKJJrzOFj+v2W6uoAGX60Meu0uzM8?=
 =?us-ascii?Q?yba+4wDlS2Itv8RFLmWFiDF3MHj7ryIwjYHgq8CnCBCIk2J7aLOU9Ks2CD2W?=
X-MS-Exchange-AntiSpam-MessageData-1: y/WsZcVEKgLO+w8hVFcxVir1QB0Rub0OQqs=
X-Exchange-RoutingPolicyChecked:
	fEaCbGlsGSSai2Fxkl20om9NyMIqeLrp/RFApr+lM8wt4PXAlM5DI11ttBJF/2sTUxdzQbiYdPocrOaHh8uLX+gUBJ9Mj6M+i0r2gYTvjJqIP1InOh+txZzmN9JkMB9Lt0kyS1DEJbD4IhtpGfQjpSpINROXl/+JY//w29VNm+P2crRSeQ+64O3kcznMbtXvKMX9sUIbCQ9UqjFC8keTCSCDRQhXChTZAlMzdUuQOioPDAJL66KzZRgPEVxmbvv/Ln+dRY6YOHdwbaZov1M519vqAhEIcIUvOyZ4+Y93gRDvGdJup0MvOBpn/y8JMVooeazBRGj2ckvU57sTpwBJFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t9RZknr0BEgU57mC6llWmXArXk7Kk97pFTgcAfnf2Mk486M9qFg4TyFtY2uI3hTn5Cx7uKZPMc5nOO7bjUWRlrUvCizR6YtyizK1AxFF/zmX2IdTlbfckRNy5/OU66GLUAefsxoQu9DW2QKHENgzfI+O535mRMlvBNf8oH6MlfT412fDz8SCOM65uAqebpgQSX7OqMXxz5bqQjJflOyzHSP1mIcItbClm4Fj8QariGA7/MJiWR1L6/AiZolBl/dwG4LiY5Atavsns4NiPpKZkwpDnIPbJDdh7Cuu+kuP9SsAXoU0/AzS0nFHNmEvQyW6evIYqEBVZLQ2RRWRa8Il1l3u9M6O3inPCamXNXtSFHvbzoonI42XPtKGmrQOuMN5o2Cm0+kKyDN7c9ZJUUVnH99wwuqzEDmSrsHoNzwB+uBIEhA61bM3GFygAV7XPtH4e07uSk0s/5Tg4XdilJtT/7YN/1B/Jrtt0NqlZ28PLziE3J7EBhhI3Ov6hDEX7Qr5IUTdPbTl1K0F1cUz2y5q3ow3U3AtAoXAVvgQyhVD9L+Ga/mIdha80StnEaIc4SpRTrvHfKhQdNCjKZjgOu7+IJ47BqcaWBEfh+yhld08tDwDdkMTTXJS9eoUBt7IEvzV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44135463-2911-456e-3533-08deadb6bb26
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:35:47.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFBXZQAcRe0SkFBbSvQBBdVUetP7UWaf6MWjZGNshoJgxTWNAUtVbZO9Tr2Oy1EyXvwrXP/OVR49nTuferLEiZueKiTqe3TFqliYueacF0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR04MB10073

On May 08, 2026 / 16:51, Disha Goel wrote:
> On 29/04/26 7:22 pm, Shin'ichiro Kawasaki wrote:
[...]
> > I would like to understand why the blktrace error happens in your environment
> > and does not happen in my environment. It will affect how to judge the skip of
> > the test case blktrace/001.
> > 
> > Could you share your system set up conditions? FYI, I used Fedora 43, QEMU VM,
> > Intel server and v7.1-rc1 kernel for the trial above. I'm guessing any
> > difference between the two environments causes the blktrace behavior difference.
> > 
> 
> Hi Shin'ichiro,
> 
> Thank you for the detailed testing and feedback.
> 
> After further investigation, I've identified the root cause. This
> failure is seen on SLES 16.x and RHEL 10.x with 6.12-based kernels when
> Secure Boot is enabled (kernel lockdown active).
> 
> I tested on upstream kernel v7.1.0-rc1 with lockdown enabled, and the
> test ran fine. My apologies for not testing with upstream earlier.
> 
> The issue is caused by missing debugfs fixes in the distro kernels.
> I'll work with SUSE and Red Hat to get these patches backported to their
> 6.12-based kernels.
> 
> I'm withdrawing this patch as it's a kernel bug, not a test framework issue.
> Thank you for the thorough review.

No worries, and thanks to you. This patch post revealed and shared the problem,
which is great :)
