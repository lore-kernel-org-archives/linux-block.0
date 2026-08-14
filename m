Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27C33A6E9
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708096; cv=fail; b=QZGK2370HZbS3B268yRglqHItwcMcFzaOGcY6xic0gcMCdDW//BJgAPC0JL2/dEhpbRjWuaKjdiVzys3tjGqb90XBJGV0R4MHbXy6IBie30G2459tcQUFN8VJS7v8rXFbZi/8p6MB8zMVK4yiSF5sD2yNEHX+yjPnsqKUajfaug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708096; c=relaxed/simple;
	bh=1XfZwbrTiriw/YYxnwWrqDRRvH/jTazbh1JeuAbjk1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3snv48VanjkdpsfWFq3t07aJWw/Z80QRn7CYdYstr+S1aj38QiHqyKHIK+PBhdY+idXTXuylGMqmVEkffPiQxRMEEdIIJJLgDikFhYNiWpE/tqY+EQQjUWJkQ0Wx4cjD2p/WP1xk6sOgOnOEaVujGJjR+hADoLJs82axpwu5mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HXGYGjsw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V659wnHn; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HXGYGjsw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V659wnHn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786708094; x=1818244094;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1XfZwbrTiriw/YYxnwWrqDRRvH/jTazbh1JeuAbjk1c=;
  b=HXGYGjswE6j5jMGXL/z5aOiRe7rndO2NRoKfznO2O8f8XbPVG2mIan+z
   xhklYKegduPXYzJc73aaKSk67Igc8XK9kAwRiJcqeETj641nm0K9FReW9
   E2LpklnQT/Uhslbm+FbEFd11y2MOkZnEUjZBGy/3vn981tU7oTV2U1U64
   Nk6gHNeAFia7I0BTKeNRHBBepmXe1usokSW6tgryQJR9gfGk+G7Qm2x7N
   sto81wgZ9w9LfhJlIyyR04SFdcXELyZlkztf3AzCf6BxVuRyMlXdknA4J
   2w6ylB32Xw92oR0x0fDDyQ+fAqhwuV/GrtbxlCO3SzWTpxbn/VATX5Mcl
   A==;
X-CSE-ConnectionGUID: i4pScHoHQu64wrHr+Zy/cA==
X-CSE-MsgGUID: jCjTygZtTPyl5LtHgSP5PA==
X-IronPort-AV: E=Sophos;i="6.25,222,1779120000"; 
   d="scan'208";a="152909990"
Received: from mail-eastusazon11012006.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2026 19:48:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUshoZSW/jRNDA/d/KFSjyUHEbEwgNOK6KlWGZhXn44AoplCmSUysUB+TNw+RaNhUTaFNuGrh9weBt5qGoaC21LPX71VSK/1kvdFChPds9vt6P50xka8iOjqsgIKzmNhp2Kinq+d34zgZVvVpIolmQeF+NSeQSb1oZ6Z5RJBduPV2m/J/zvUOpf0czb/bDcJUlKKzzzew5QTYyqyGsyaz2PrcZ7nk4SuuAe6MEBw6AbZI5hQ6cWZG8imaJQKGIhPcnJGyVUKdeiQRmw0c3ui/KuFLz5wHW9uXMn0KizU9VS9yonr8Wmgrh7CWToGjp39dIbstDFAXw3/Uw80kzdryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkB4V12eTA821GdTJvZQBmdDFYbVNvj1BDpgM9Oyh6o=;
 b=k4CG4SB6bp52g3iADp64RccVds+ccCcZdzqyXHc41z9hAWe+xDvrVJ1DqX7IZNkUtxLPvMFa6jT4gCLUDq27EWZZ4uGeIqIOY2m8tDF8CIFjlNfIJeg57osWkTwqskrbK3udpWbV4wro3yd/vDm6wXGdqcCI3VunaRPGh+Wq6atkHRczksMK1YJJGplbbxt5kEL4IJTPPzmhLT+FwJDHFrVCqt/OGd930DoZeAfqaKogo+BA6YK8HGSXQhy03k4F5oIcGzjakwgEHgH5fgpVMe2IBfzv7mxN6nx/EJpm+RI0iQzcXYtXrTF8eMBR5KgbAm7nk5dyVp72R1R1anKNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkB4V12eTA821GdTJvZQBmdDFYbVNvj1BDpgM9Oyh6o=;
 b=V659wnHnT9u9Am7eet/3RWw5fjHveWE9e5WJAZx68ZSyZ2Pc4AdsLRltQgrjYTUGG/zlanOjp1Qbx+0PiJZVEeB2fiaf7ltA1BEKw4kXl1aIsDToZNcocZE1aV3c8mFEIq4jBhGPyLEYSjR2ugrd1jXOVofJAVmXtpDVnFP6GWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB8078.namprd04.prod.outlook.com
 (2603:10b6:408:15d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:48:03 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 11:48:01 +0000
Date: Fri, 14 Aug 2026 20:47:56 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme/070: Test multipath and marginal ports
Message-ID: <an78AkXI1SUHXBwg@shinmob>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <20260812174503.3705830-3-jtaubepe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812174503.3705830-3-jtaubepe@redhat.com>
X-ClientProxiedBy: TY4P286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3faadfee-f20f-4fbe-3d5e-08def9f9e502
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|1800799024|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ABk4qwF76Wqt4V97jqIweObXqeaJ8BASQaryJxqnNp3B5GnrAik0cIYJ4E/9cqHOxWDfMcU3IJQrDmK/BnpX6Ja4fIXCm+gCn0niCGfxaJMKv+ldWSIUhgkw6WN/E/DaRMAdloSmdMB+NTcHSumKUdLMEPdWa5HqBOmz/h+eC5CRjf6hjFAQzhxHGya64Q6C2eE8re0cOuhZBebrECWllOqsw+QuNSwUwUzRyxQeO7EVmem39VmNLOXo/QnjOKjlHYCO52DTpoz3g2Taz3yXf+8KA6MzDM/CfuMFooyN5fRq6L2+1narl03ZAJb9Duee/q+r5ETHeaSGLJFjZWlyPF8kG1YArxIQ6CPLUrmAnEBrVi2WeM8DZcZGkFc2+sSuXE/MUYuoIDsQyvTVbI4A+t3L4QG4pqo1hHXegzO2h9J+cL6bFs9Z7VGKGg6M00O/z3IYgglkew1P7mSj180SAU39YWp9zovmMyTyk0L9GRHEqBlJON4OWbCKCgV2qkeyUBpDPTwBZtv53y99peWXOV26B6eUlmCwshdM8hx8kUSUD2hZJ72IVRu7T+LlVGRd1Q9LKSc7BZp+9HHFS1xM9BXoILKEaYYAcnB7mDswc8AHo9SlZ0M/QPymxRevT0r3HcGtmDoMqSXH7r/CrnqpL30RT6ozLuyBNmp1ZorqM6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWV8agF9GWizAiUn78Q2HjQ2bZPj6n7J+6W+VCw2jDMDNzZhkBgCmm8sBls/?=
 =?us-ascii?Q?3u5PbzhV6SPv5bDLyLx1qQj31LG8d/1A3s7GsTA8+n31Q6euGWq8+dSXXiy6?=
 =?us-ascii?Q?wFreTFQxB1C0WbWphcAR6h9WtkUp0XyEG8vF0kR0GmWr2uYJfI1IOAQHJm3k?=
 =?us-ascii?Q?ZEp0DG8NKho3tlWVUqrXl4gk3Ui5AOeyoM1nF0iXSGBi+1eWDxnmA7O9JDhP?=
 =?us-ascii?Q?wLjHccWERsVAtAji5NCanMCeZLzRQay/9YKNgIb8i17bgEIL8w4yow3mo1gh?=
 =?us-ascii?Q?ZrUW38wWl2t5cdub6J+XRxxXkIGli3iM0zupTdsbX8qcqPTdb0VrcemoXmR9?=
 =?us-ascii?Q?S/QizvvQz92w1w0nvq9MyAY8YZcPdSR/liI7mXwiXqREzOubxISH/RpfRy02?=
 =?us-ascii?Q?VI5hnj/Amm/BmqvKng2clI+rjXsGUqDflf3nZ4Ael+hgIQvENvTQPNmSqPKW?=
 =?us-ascii?Q?7p0uDnqzhyI+d5FnKoYokF1Y+i3R/ka+IETFdH+bYig8EnqZ4oz9sfqYdNdk?=
 =?us-ascii?Q?DTdfCQgtA8hW8M6duTj8tgWZi4a6Isa2RMpng/TTsK3RdfjJEYFtwf/sPKN8?=
 =?us-ascii?Q?BM+z8S6QcNn2i4nBlokCc2KZek3ghBLAlXSG9YYSWQV/I6ttHyBL3ONi+75L?=
 =?us-ascii?Q?gUNs6Gk/PgRfvy7Vs+8VDmDIrQXyIbQIWrM9+tdvu2XrUQY+rJQzfeln1+WK?=
 =?us-ascii?Q?Cemyt3nsVmBEgxDTos/joeF2bbdV7QBjujjBBNS2aQj952QgSAdykNXcKjEF?=
 =?us-ascii?Q?Oe8KIn1n70fNnDdpgjP0Xf+zoQAAGluUsRTGFXgQlB5ZzfIr7OKBwE4ILmXF?=
 =?us-ascii?Q?M0RYrioxHHM8VYLFlxAc7olaEYSCyBK9iCOCyIolyZq4ya+jPCQi/uh8tctA?=
 =?us-ascii?Q?LgTIEvvZsS/Yu6DwRmAVB/hWbZW76cuigFcaVeCXLR8PzEID80MjfA20/rcV?=
 =?us-ascii?Q?dW4n+ISjVBHXLaDUmzFjAzBQmWqkYQCQaJcU3Wv3rR+oZaioKkhHFY9ZMRYj?=
 =?us-ascii?Q?HMliIbEMhUgPsR13CFdAvxxqySNDrAcpptYEsjVePf5cMSlJkF02sS09tH6J?=
 =?us-ascii?Q?gtQvd8PMj2K7D13+UwUjOG9w4HHAQKsLaYuMoFhE6usMuSrycikCPINOZyo9?=
 =?us-ascii?Q?g0BBMX/2RPYlWinfWDoaH52tigRNH7YNoYd85PThlfP9BsQ2Zd88hm9bJP4j?=
 =?us-ascii?Q?MYKzM4h9YqsKsLA99g4rqUQmDc6AB9RSSXzt39+9i5EcHgNlCJrjce0hMIHk?=
 =?us-ascii?Q?6DkHV0DBg149Q0CmbC0g8pxFDXIE8h1UsuRD+WbPQMZgyGRK/MM6bUhRvcec?=
 =?us-ascii?Q?Q+GUHBxPCEXnEaG3qVT+k4HofilUeO/5m+btNZZ07YapgWno3TBCQt8w2Afb?=
 =?us-ascii?Q?3XhMiOfL1arPOvR9EJ0DMs/cL3Ja63qvT703hRMtOtjuLpXQJ7sugWvDcDle?=
 =?us-ascii?Q?914VKgyNZlIov5o9Z+AU5qLJ9BwZd22VG7ZYg9YA66188oEsOZpigj4CI/tl?=
 =?us-ascii?Q?VbDWHJ93Y1sayZCTWutZyH6JnQxK22iNkCJ2ASFtYI/35vYveci9CqsF112o?=
 =?us-ascii?Q?q2bu9Dmuv0VzQCQTyYqGcpeNGS2FeWmoM0D8ck4QpmTUmmteVwbmQsmBG3eg?=
 =?us-ascii?Q?0qp2oI6ZtFydb7mRIXXCsN4PCag0x8+zP8j/nWUcQYv1gsX3D+6eXDpPlEL5?=
 =?us-ascii?Q?ZsPmUZ+ZaYnnuHLYhlXhIaF0EFgedQa7r2/d5KffkFdHsZkCDdJQZJwDtyNK?=
 =?us-ascii?Q?Gp3sJaGigLVrHZArlAiVqJ5OfBBL6EU=3D?=
X-Exchange-RoutingPolicyChecked:
	I+mbrIFKZEZLmocMwlbmkk7q0+ZBWYM1Uwr3TMUyzgQKK1qTc9T1NrZCkMM9ZGcSjtKVHrjWubIK+k6HcroPzyTKWsJZEj4kuHx8oFcUzLpqrdc+QBNIPLtaj3gjpQa6zCB8Z0Cg6ZXiJSN/qwxL0LvPu3hEA1Az/DnHr0nohg2GdLR9QCmRltc4swJDKbBWR+9BN49YmeRR/DYxx8eclj4v6MtRBnvRfjHRPRJj4YDpUMfYJ3rXrQn+5Bb8Xyae0C4sNZmfHU8AelHRx5aPWQ7Bbx4S+D3827rbjP0m/TeiR6ZFNGW61RlPeJl94YfINbsL7tTw2XPQdRX6+Otj+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eEiJvQ13tcCnjbXXs1gU3bM1DElc9McsDGUWuMgW1nHOLEm5BgXYp7KXmr+Kti2512B/C+u+qQItkd0fAkdyqS5fBC1eKlY8nqz9Ob7yy2EZ2jmvDks5BRHocDSlsrAjPEVKceeE+5Z+g0V6wFxHBJCvMBUPhCr01apQCVd+lyW8xcA8o0/zgdDGXii9AO5E9DBE9xjszLx8XD4Ds3QkbUZnWMqCybHFi+eCZRZelq+FWtDsMAOJGag0IlKaDpNuF4bBjbYFbEjEsFu/L8BQQT+wd9N2My8fEPqDPRaeiUrVx1gExlNihMqGumWM738+Yqq9A4xLxzsol7Rcr+uLnUewtWEZ5SBbRgNEQJxWi8p5wF35idzD2ZamYWILGXR5YT+gKQoOa9wZbcHNFgRfLjTgaYtUhdpdQQqDaUBpdtGvL/Q7AhdnubwjOI7c4BTAwbFUlfcRH7+zXl/JFtTDJGfpuSH+a6Sp9r+ifgDDK9q2IwVRsqHaTO1V03dDuGCep1bKB3Vl07llvMEGvSFnH2QPl/Kr3siMqlEhqLYfUnNOqmRbZe0XS0F7nmMl9YDx0YWYBRi4ecg/37F6+B6p54Wpf+ziCJyDi2qhryJuNOZgCv4q+DuSwhb0qXLdawFE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faadfee-f20f-4fbe-3d5e-08def9f9e502
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:48:01.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOCG2EKZ5ddOu3mTZKYNJz/OtacCxuKC0EVJX2Xkf/L+H32deWiKxQUZajd/FwomhUzgT6JVTNHm+y6hV0CXkbDJrpHNXZ5U+la9eKB7yBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8078

On Aug 12, 2026 / 13:45, Jesse Taube wrote:
> Add tests/nvme/070 to test various multipath and marginal port
> scenarios, while confirming the port useage and state. This test is
> intended to emulate receiving an FPIN event in a multipath environment.

The test contents are comprehensive, which looks good to me.

> 
> Suggested-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>  tests/nvme/070     | 521 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/070.out |  43 ++++
>  2 files changed, 564 insertions(+)
>  create mode 100755 tests/nvme/070
>  create mode 100644 tests/nvme/070.out
> 
> diff --git a/tests/nvme/070 b/tests/nvme/070
> new file mode 100755
> index 0000000..a8002f8
> --- /dev/null
> +++ b/tests/nvme/070
> @@ -0,0 +1,521 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 John Meneghini <jmeneghi@redhat.com>

This patch's author is Jesse, which looks inconstent with the copyright above.
Also, please reconfirm the copyright year 2024. Should it be "2026" or
"2024-2026"?

> +#
> +# Test nvme-fc marginal path handling with fcloop
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test nvme-fc marginal path handling"
> +

...

> +# check if all link is in state and use state if optimized
> +_rport_check_opt() {
> +	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +	local STATE=$2 # "Online"
> +
> +	_rport_check_online "$RPORT" "$STATE"
> +	# Only optimized paths will be in use
> +	if _rport_optimized "$RPORT"; then
> +		_rport_check_use "$RPORT" "$STATE"
> +	else
> +		_rport_check_use "$RPORT" Marginal
> +	fi
> +	# Returns Success or Fail
> +}
> +
> +# check if all link is in state and use state
> +_rport_check() {
> +	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +	local STATE=$2 # "Online"
> +
> +	_rport_check_online "$RPORT" "$STATE"
> +	_rport_check_use "$RPORT" "$STATE"
> +	# Returns Success or Fail
> +}
> +
> +# Check if one of the marginal paths is in use
> +_rport_check_one_use_online() {
> +	local RPORTS_PATHS=("$@") #  /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9

Nit: "local -a RPORTS_PATHS" is a bit better than "local RPORTS_PATHS" to
     clarify that it is an array. There are some more local arrays in this patch
     that are declared without -a.

> +
> +	# Check if one of the online paths is in use
> +	for subsys_path in "${RPORTS_PATHS[@]}"; do
> +		# If path is Marginal, continue to the next path
> +		_rport_check_online "$subsys_path" Online || continue
> +		# One of the online paths should be in use
> +		# "!" inverts the return code, so returns false if path is in use,
> +		# running the return statement
> +		! _rport_in_use "$subsys_path" || return 0
> +	done
> +
> +	echo No FC ports are being used, expected atleast one in use when all are online in numa mode.
> +	# None of the online paths were in use
> +	return 1
> +
> +	# Returns Success or Fail
> +}
> +
> +test_set_all_online() {
> +	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
> +	shift
> +	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +
> +	for subsys_path in "${RPORTS_PATHS[@]}"; do
> +		_rport_set_online "$subsys_path" || return 1
> +		_rport_check_online "$subsys_path" Online || return 1
> +	done
> +
> +	if [ "$IOPOLICY" == "numa" ]; then
> +		_rport_check_one_use_online "${RPORTS_PATHS[@]}" || return 1
> +	else
> +		for subsys_path in "${RPORTS_PATHS[@]}"; do
> +			# Only optimized paths will be in use
> +			_rport_check_opt "$subsys_path" Online || return 1
> +		done
> +	fi
> +}

...

> +run_test() {
> +	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
> +	shift
> +	local ARGS=("$@")
> +	local RPORTS_CNT="$(( $# / 2 ))"
> +	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +	local -a RPORTS_HOSTS # host1 host2
> +	local PATHS_POS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +	local HOSTS_POS # host1 host2
> +
> +	# recrate the arrays
> +	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
> +		HOSTS_POS+="$(( RPORTS_CNT + PATHS_POS ))"
> +		RPORTS_PATHS+=("${ARGS[$PATHS_POS]}")
> +		RPORTS_HOSTS+=("${ARGS[$HOSTS_POS]}")
> +	done
> +
> +
> +	echo Changing FC links to online
> +	# Initial check to see if FC is operational and set ports to online

The lines below in this function have more than 80 characters and hard to read
in small terminals. I suggest to fold each of them into multiple lines.

> +	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Set all online: pass" || echo "Set all online: fail"
> +
> +	test_set_one_host_marginal "${RPORTS_HOSTS[0]}" "${RPORTS_PATHS[@]}" "${RPORTS_HOSTS[@]}" && echo "One host marginal: pass" || echo "One host marginal: fail"
> +	test_set_all_marginal "${RPORTS_PATHS[@]}" && echo "All marginal: pass" || echo "All marginal: fail"
> +
> +	test_set_one_non_optimized_online "${RPORTS_PATHS[@]}" && echo "One remote non-optimized online: pass" || echo "One remote non-optimized online: fail"
> +	test_set_all_non_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Two remote non-optimized online: pass" || echo "Two remote non-optimized online: fail"
> +
> +	test_set_all_non_one_optimized_online "${RPORTS_PATHS[@]}" && echo "Two remote non-optimized, One remote optimized: pass" || echo "Two remote non-optimized, One remote optimized: fail"
> +	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Set all online: pass" || echo "Set all online: fail"
> +
> +	test_set_all_marginal "${RPORTS_PATHS[@]}" && echo "All marginal: pass" || echo "All marginal: fail"
> +
> +	test_set_one_optimized_online "${RPORTS_PATHS[@]}" && echo "One remote optimized online: pass" || echo "One remote optimized online: fail"
> +	test_set_two_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Two remote optimized online: pass" || echo "Two remote optimized online: fail"
> +	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "All online: pass" || echo "All online: fail"
> +}
> +
> +_nvmet_get_rport() {
> +	local PORT="$1"
> +
> +	local dev
> +	for dev in /sys/class/nvme/nvme*; do
> +		grep -q "io" "$dev/cntrltype" || continue

Nit: I suggest long option --quiet instaed of short option -q.

> +		[ -e "$dev" ] || continue
> +		dev="$(basename "$dev")"
> +		grep -q traddr="$(_fc_traddr "$PORT")" "/sys/class/nvme/$dev/address" && echo "$dev" || true

Nit: same here, replacing -q with --quiet, and folding the long line
     to multiple lines.

> +	done
> +	# nvme9
> +}
> +
> +run_tests() {
> +	local SUBSYS_PATH="$1"
> +	shift
> +	local PORTS=("$@")
> +	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
> +	local -a RPORTS_HOSTS # host1 host2
> +	local rport
> +
> +	for port in "${PORTS[@]}"; do
> +		RPORTS_HOSTS+=("$(_get_fc_host_port "$port")")
> +		rport="$(_nvmet_get_rport "$port")"
> +		if [ -z "$rport" ]; then
> +			echo "Could not find rport for port $port"
> +			return 1
> +		fi
> +		if [[ "$( echo "$rport" | sed -n '$=' )" -gt 1 ]]; then
> +			# One traddr has multiple /sys/class/nvme/nvme devices
> +			echo "Port $port has multiple rports with address"
> +			grep  traddr="$(_fc_traddr "$port")" /sys/class/nvme/nvme*/address
> +			return 1
> +		fi
> +		RPORTS_PATHS+=( "${SUBSYS_PATH}/$rport")
> +	done
> +
> +	local IOPOLICYS="numa queue-depth round-robin"
> +	for IOPOLICY in $IOPOLICYS; do
> +		_rport_set_iopolicy "$SUBSYS_PATH" "$IOPOLICY"
> +		echo "Testing iopolicy: $IOPOLICY"
> +		run_test "$IOPOLICY" "${RPORTS_PATHS[@]}" "${RPORTS_HOSTS[@]}"
> +	done
> +}
> +
> +_find_nvme_subsys() {
> +	local subsys=$1
> +	local subsysnqn
> +	local subsys_path
> +	for subsys_path in /sys/class/nvme-subsystem/nvme-subsys*; do
> +		[ -e "$subsys_path" ] || continue
> +		subsysnqn="$(cat "${subsys_path}/subsysnqn" 2>/dev/null)"
> +		if [[ "$subsysnqn" == "$subsys" ]]; then
> +			echo "$subsys_path"
> +			return
> +		fi
> +	done
> +}
> +
> +test() {
> +	local -a ports
> +	local ns
> +	local fio_pid
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet 2

When I ran this test case on the kernel without the patch series
"nvme-fc: FPIN link integrity handling", this test case just failed.
I think it should be skipped if the kernel does not have set_marginal_rport
sysfs attribute. I suggest to add the check below:

       if [[ ! -w /sys/class/fcloop/ctl/set_marginal_rport ]]; then
               SKIP_REASONS+=("fcloop does not support set_marginal_rport")
               return 1
       fi

> +
> +	_nvmet_target_setup --ports 2
> +	_nvmet_target_add_ports --host_port 1 --ports 2
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +

...
