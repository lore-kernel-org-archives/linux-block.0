Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C71A267
	for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781931118; cv=fail; b=IkS8IrO3mesRA+NLm8hFQg7A4+s2WL4OS6AQYNMMhLF/ukAwNXe/QdOf2ctyUdVRRFxkY4Dy6C/J0nNc6wi6kAZTSk4hUAIFbBNW/1xMsIrEHSxiOS/OB92s5k2lGw1rL3drS7o/ANPhpxRIm9q0thXvkPObStto+Dzb+os7gh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781931118; c=relaxed/simple;
	bh=l7ol2wCwRrqMWlN9ok7T07jFVn9lutyU07kznkjqb24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0saAmkqh88fKhntieXQ5P/6KTjtRnk//y40lDPHll1brBBP0OiozTh2AAvuV3OOwZRzyL4+2SsB1O9WzNp1qNhzNY7DCYx+iXgYQ6mS8+sgJwidXF5wES56E8AF0X7jJWIQm+f7jhrBPTNT5tGvwvYj3PxGtdxcR81uBLSNbvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=goVP4w6w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JcmsOcyZ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="goVP4w6w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JcmsOcyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781931118; x=1813467118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l7ol2wCwRrqMWlN9ok7T07jFVn9lutyU07kznkjqb24=;
  b=goVP4w6wfOVPSvRe6NjqRObhwLtw4Mt5o6UCVtjT7sE+qk+hZ9FT/Bqg
   rVcDycB806z0wEr2b2Stbnp2PQd5azrXlWFxxqvucRaJMxNe6O1y8Ge8l
   HKSTtSSi/fc+quDgwv/AuwleoD98LNSATOCgw1xCERfrlf4yGdy2/jZf2
   fWL5jKZ1pzORMTXgtdTuJMJszruQ7YXVQX3nP6+3LNowEMwh+dQ1RhSQo
   YsXuPMWJzuO8xTbqWRVBEu7J7/Pvbvkcrh+ECRBqN5UXHPgFQyPLVubYY
   MuQ7+PV5k0ib38h2Fr9z9Lgf5tGRROzKPRS1Y0BIVTd2fM/QnD1JvCAXI
   w==;
X-CSE-ConnectionGUID: eM//YWp2S6ikM5Oqywmu1A==
X-CSE-MsgGUID: VGFn8cUfRG+wI6z8183MRA==
X-IronPort-AV: E=Sophos;i="6.24,214,1774281600"; 
   d="scan'208";a="145366554"
Received: from mail-westus2azon11012050.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2026 12:51:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYg3tTTO3Pb56fbEXuaFQ/9SA6CWNoSE+gBlrFw4eQDC2z/AKpWPA+lvNIjRdOn53Pxo0mN4qYlHNeJfySPzCH6IP6kajnx47qR6ZiFNhzGZ7cV5P6x2Z1+RqvPv1zqz3k95gLtvTUjsypt0josAY0zsgGRYdSeiXkyYrkM/QBv3Byaw3Ym6aAEs3qcBDVVB5J6fiQc/aV+DfJK6PmiF77S0W2fKVMxsUbdDllPITWfdS01oIZQV48I31GLoY9PpS1q/uYAuLuY3xTLkRGFuNoYY4torIMlt+xk7WUtNR3R+9GjQ2pJemXPtr6XMmDdcdXZU/USUQL/RaOC8+zR/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU5o59jFtejo1Blh+gshOoVLDlvH/Msr3q4dIVSCNgA=;
 b=Dz/1Pz5moF5Jv8SQRrfTa930uYMwCc+h2kfU/0xLb33fsMuR5DPN2cZNlfo8S54qNw8jBeBbbGBD1vxIoQwrR5bBtIitSGUGJF+qBPLR+JUBg2EiVqVT+PKtr+uEnoh5CuBRiO9JJ+X5yRp1rCTaqNzFTNUakfT7tRfJp1SXPQjmlmLz0WagcPih63Dkc8yXF5kE2DVpL8TWfP92pcEzHekWYM0HJ9zb2u3/9SSosY30gALQdbyx6sHfkV6QdH5yWPdo920x/0ckw/WpqWn+1KoRwL7U8LsozB5q9mbWhmkAoKogdxcuac+GZzsTcxSPWcQkxnUn3LrbT28/8qcDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU5o59jFtejo1Blh+gshOoVLDlvH/Msr3q4dIVSCNgA=;
 b=JcmsOcyZ7J4VSvHMdJHw6a3KMai+p/S3MEQdzIEXce5ItuU8xv/Tg+Q1Z5HoB67Y0/k26k5UlCrdoHTzImEPCwljk9eqCvYEXUTnysuaDLXmZh7D0dNjio/arkcFwKMuWr8B57097IyGIFijYFIXU16AZKYxm9YxtKDPHlZCU1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by MN2PR04MB6461.namprd04.prod.outlook.com
 (2603:10b6:208:1a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Sat, 20 Jun
 2026 04:51:47 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 04:51:47 +0000
Date: Sat, 20 Jun 2026 13:51:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org, 
	osandov@osandov.com, kch@nvidia.com
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <ajYabLMbEo6zyOWh@shinmob>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob>
 <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|MN2PR04MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b1ac06-0409-49ed-8194-08dece87a276
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	WtWnllG1MrtgdVx7dH9uJxil6ejrn3zAdNZyQfy+VeL0RYlUPnG8VlLazBowXwK2i97WR3v+OB7W5BW3Gn1KGoQIYtIHhZubCdyyB8SA6RJxTaZ70wUiQCGeXVKSdoE/hGbwMC4UB9KyHuOT/uwFUzHcjx0ZxZyNRAY5MDUjUJfWZx4XOPtdE2MfjVPM9DKUB1U4+OtkzwsSlReHh30z1PnXi4dEbekzADjk+jkQEwwxc62UJ2DBolma+rq/fxEpjwRzlbdxCsfL3V4HCG+6hBB9OVQEb9Myk6JK5FCikVvWrTpKlwbXh4/AKiQh6SsqZyL1pCSiYjAnryUTRbfIrQFpI5GKC8C4Yr8yVBY0mjEA1WrAwP1PNEBWyQhuBYlxSWfPrOAufHEW2SZ+MSOinkcs1DdWJJmdjQ7zcfXIK/aGQsWygGGXkVdk5bhaaQHeR7esBTap3tRNnR5lH78eOUTZ2BOnG0v8EugT05pKvIFtqEg5YyRfI9bqiR0TaijlZdHcYkxNcc7Cqfux5H4tiyMaMR9h4Rk+o5VOG93bgWwrN7XW6O6e6tMZHZ6fMGUjxZ2vDi9Chm7Xhq57vg+WXFuf23gtLhNIwUr7Urye/NmciL1b5xLnMr3unasGHRw3kP7lj453jD5QGoTcC2iSNz+bnwKeZi9YsslY64zGPj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tm8eP0F9gvADKYYKk8db+ZAMj0xd087MIfD7LbnwLnh7i+sK95VTTewGaxqD?=
 =?us-ascii?Q?HIlJNDLGCUrbcxhddMWUpTcFPbPJwXwo5c2M6dguUT+1tWDm7fee7vpM+dwV?=
 =?us-ascii?Q?aw+EiHvarEcGWdTMVOXXWwShwX0SYVBVdbClY/83DCXok+D7zx2txzmQVgLw?=
 =?us-ascii?Q?CG/hls/6t2eIOA5lKllHU81D0ji3Qwo5zKRZQqJrMOwvUgHMR427qrndfxdm?=
 =?us-ascii?Q?QBIYwKV9vD6BGw4EtKOu5WNpob4bf4Cv3i1iQFZgM7uU0esdeTNHK6BqIKyj?=
 =?us-ascii?Q?Ac9WtPxL47u7+0QjT2LwnIGGjZX1Re/d22RDYGoJW1pr+I8hW1RUOpirnXQx?=
 =?us-ascii?Q?M2PPcR+PbVMWL/vWhqQMf60IW8eWq8q++emUR8iBVApuk295Ej4M+bABww8S?=
 =?us-ascii?Q?ffPW6fWzeCNslt4890jiK6pAxFx7vFkdTsCXj6FP8xDfODdjcqEa7y81TyTD?=
 =?us-ascii?Q?u8WabYa1A6xFTnTCdgnk1CgeS4Mbspe3XVIK/0TDaoOJ5Van9fzoBMXHwzC4?=
 =?us-ascii?Q?PuTrVlV5RkKsId8W6uEHRxnT7EVrk1s4/qv5Zcb+1hodjc1Y3AMO7susrgVj?=
 =?us-ascii?Q?fHBqervEEiRCWVp8a0lKWyP+H/WNxLGumk5NLA3WyHdPGhgTUJi+VpmkSBAW?=
 =?us-ascii?Q?9av2l4jPfG7nWhEj6iKCd5+hF4V9ILo2N65tb7xd0j+uXIOhlCfMCM1lhFIe?=
 =?us-ascii?Q?lO4OhntpVN8VK2fM3qCYZ0/NTvSfhtn5TtjY+6cyMQbA3fgmyt8NYKdoFCnL?=
 =?us-ascii?Q?y/CiGsyKrbioHc2C1lofpzZvrqo/d1lchRL7N3iJith9wUaB1kJYZPLjQ1C5?=
 =?us-ascii?Q?K+sRNBCTyFrpyKU0qOtam7lMvvnyGQTZ80gj79ON7bP1Oq/3IB4xyPFRV12d?=
 =?us-ascii?Q?rSX1maLRVqYg938biCs02PKcj46QksnYQEU2k4oG5bVOqoSnkjqbMnywRml8?=
 =?us-ascii?Q?7tScb4d2MH4c3LczCoLQu7TFms80wE3w4IKKnbuh+70GDqgHoeevl4f8OWw1?=
 =?us-ascii?Q?aQ8uqsICYviwlXSc9oSAgr+7jm8eor2rBwmeZb14dX+OoHExcUwrtg/CepF9?=
 =?us-ascii?Q?/4WBPgz9ySTD0+vKUMgG4J2OTyAEBWwWP/VLJjVy3VJuCBbyvoQbTMQM2hnM?=
 =?us-ascii?Q?d3Y5NdTwlRJ+KJo+uMw88iAc0svLmXo/6CzJ2sqwDLOSnGZPg+g5hMtIkO7j?=
 =?us-ascii?Q?KgNRs/C9phbdkPUqCmCs0X2o8Z+s+fa13M96aAgWe5V9A0t0JyGbtD5a2eXJ?=
 =?us-ascii?Q?tjMKVDHz884dgEZiUYO+gFthdG+u3rCAchA8SRvO4E81d8y0zaJ2+wiKrLEI?=
 =?us-ascii?Q?xxkoREEOPRv4sy5vbFb6BPCByJLczcJCZbsh/kyxsztfrWJ8cIn2s3h5Qzss?=
 =?us-ascii?Q?iwIZq5fwNT6bWCHiZdt0Sedqp3cT32Jm950QGyEECgtCQZSJsz3vQt42lCHH?=
 =?us-ascii?Q?6gng2Z9oUAVNC6KW1W8dw0t+ADre+d8zLEPtRFnnn7CjllyoIfWjjQiwykNP?=
 =?us-ascii?Q?JS0K/B9DWQZhWUmojGU3XRgOgBOctdNJzTTVnO2QTBEoxW9fGhbedrEWYO/7?=
 =?us-ascii?Q?fErLkJPQn7a3UK1tP+5UF3G2wboKvt3uAicr7jFw6gTIQ5lRh+w2Dme7N9nD?=
 =?us-ascii?Q?HDUpW5MfaGSCVX2ryjiPNiN5EJ0ko/AdtTFdYTuFUIp06tJBVoyiynZRqS4U?=
 =?us-ascii?Q?WdieebGiyphF2qcMFPgYP23XCMvnYL3s4xjqAEuvxRGWjHHxWnaZrBALMsBc?=
 =?us-ascii?Q?3NG7zppf6/HBLO31ekMUjQys3ygmgEY=3D?=
X-Exchange-RoutingPolicyChecked:
	J5/pln7keNazVjE4qRTiiulA2DcaBQQfjJ7P2ZShKUnlyh0mIP7CXNBupv/F6BBPyxNt5VI6tazrHwYQN8VXfu/qcv0QYu5BlTB+NIak6RrzYv/8Fna7Jwm//m518iwA7dGkUdXaSBQSMbPusQ48emJW+KzB8eTVHhYQntx9iqMLcX9jwK3TwLHblpW1OLJvXvS6AmTgOhAwIfhz6WIhGn7jgFswij2yzaws12twd2XsjRsr5Ep9Uqbg22HClxLEEz3wt5084qdFV/QmhdX/5G9GaV4KDUZpptx3Ieb2XB1RbJmOooqm2AJNPkDoCeJtp9csZFRS5KhVb3Xb3RlAkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KFWSBFl0OOnXn7pLOwGJ55J2NgPamwrD9rl/Q5/VQtXF3r7H+EbeuscKX52i8tTD312b0xzX0NhuFWzFnHURTts/ZOoM9Tqge4dCFbaN/A1KyFUQY7EGVpRTLrWxUFxGR8wBLEA1mobTitUQIRh70Xw/jtqxsfi7W+GE/cYFKcgOZqnff+v/44wAdB2wJbj9v6y0ZG0QrRvgaqjw2kFlXeckVFQswzNkNfR07gV5R6lAozBpMCJC2Z5WAGLSQZRedLw9sQ4qJaCaxDkv1puwlRlWfq6hqhksDhMACasAJiG56Cr19SDrTgnEaIc7NoI7Y/ZIACJaaAs8z03ZTlQVZ5oQ6imq84thDvm0/SKTFko95KnM/oZ71gXwiNQTTo3KMntfMwdKzMQCe/ZAhX+nIdCfZNzNWUVeQiH1CQOPMltI6EFRPSXvrl02uLtKNo77c/1k8WjnL+HuMuQkFxY2qPGqkH6VLDNbMgo8g9q2O04ecAUXRc92S6Kq/Rn1P9yn+WHbDvq9lBB7M4b+pBvJeS9W1skCr1I7/ae6uFqLWTVO6kols09b0NuipCgpHUsUPFmHMk15dPtvXhypkRH7WkzOGdekg83NRIbVkaNTb5fg4MGt0xqOwFZls7dDE2+c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b1ac06-0409-49ed-8194-08dece87a276
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 04:51:47.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1dCfQwlbGOPVJeiEgixRbDaJsLcXcBashsO09wpzZf7i8vzu129Llb2DfYytxHQnGgvzN54iftNPQn1FtcXPgbZyaih6hPxg0vo89NJXVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6461

On Jun 20, 2026 / 05:55, Bart Van Assche wrote:
> On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
> > This is a rather fundamental change, so I would like to ask opinions from
> > other blktests users, especially Omar and Chaitanya. What do you think about
> > the idea to add getconf to the requirement list?
> 
> CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
> (commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
> definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
> CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
> kernel page size from the kernel configuration file for all upstream and
> distro kernels, isn't it?

I checked the commit is in the tag v6.9. My Debian bookworm system has kernel
v6.1, then the config file at /boot does not have CONFIG_PAGE_SHIFT as expected.
But it does not have CONFIG_PAGE_SIZE_* either... I'm still afraid that kernel
config file approach is not reliable.

$ uname -a
Linux testnode3 6.1.0-49-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.174-1 (2026-05-26) x86_64 GNU/Linux
$ grep PAGE_S /boot/config-6.1.0-49-amd64
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
