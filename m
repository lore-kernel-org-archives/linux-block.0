Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E162874E6
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369395; cv=fail; b=On29cJ6r30zgDov/DKUTN44jESheEgKKSx3u2yB4f2pXUHB1ENZtwWZZjBhMiypqZil7PH+C56SzmYbYJIVD/g8MF72vX6qF+2KwcSiNTMl4hImVufTEIVqaR+kwxrCfuDcf4V9NZpS6s7lizurBXT8cWor2GIL9UePTpwx7gU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369395; c=relaxed/simple;
	bh=NCIooz/Xg8ObJAcl19kIIBOoz8nhTqnd0AAZnrOzcuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OyFhnMemxeI1p895gaxvxZFpSVdxYh+kPDU3qlUSQLBYMDyjjUj1jNtx+sgYvD1MexG3NE1zVlLZMAZkXi1ND75Az+uE+BaTQ99INaTRFfG3oe5pU4JMHi6sty8ZLcvgmyBsS/62W5PrCHJTIWJ5Tg1N2xmhPDGC6DKMIWhoC8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BkDJTTpc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AhUzwye3; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BkDJTTpc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AhUzwye3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782369393; x=1813905393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NCIooz/Xg8ObJAcl19kIIBOoz8nhTqnd0AAZnrOzcuA=;
  b=BkDJTTpcyCFOBl0OrbEW7W5Lj+7uUfuO6bgeQBeu39OL+l7OrCV8Lxuk
   4mMZepCrzV4tzIgpfV11gnuBYTi+VNgn1DUoNKhcCrcJ/fiBjimfu5ehf
   ajQLkjVelFoWLcFsiV5nZ1r2pS0hUlaCkP5wHXjo90W1slDKtFm3q6pos
   xIEWE+8a8hQW2DETJ1jBxguJsIJUtyFsLl9YGNZfd7UtIaRVBKw7k1N/G
   cJqfaMXrYIMlD3nK6nEzPW1Yu7KUz1FYlZ5Nx42mVjH6a5NeHwXQIPL2Z
   1Vx+fiMATorq7+C1Qf8xV0BhV9pmN0A6gnjOh5Mug5a7vP2S5TN1Jber0
   g==;
X-CSE-ConnectionGUID: I81Xeq43Rv63XBQr7taZDA==
X-CSE-MsgGUID: mP5y5yOxTKarLse+Q00G2Q==
X-IronPort-AV: E=Sophos;i="6.24,223,1774281600"; 
   d="scan'208";a="149470189"
Received: from mail-centralusazon11011055.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2026 14:36:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqrsqp+OLn9DAk28lHMmV50ZJIdaGmdnBt/WKb1B9jZQf8S9J3rSivE/OoXzktUVwdkJk8ApUBYkpgOSOcqX8kB6upVWtUH9NXYMGMDYvd2HsBUghbu113uTk10rlQlVvEzHZ1oVnp8ksQr+uojc+8zbeGI5silq2ndLbBESGsMKJ76y3FqW1BisF7PMO/gA8mgvjQ0YPuNq94xABhod/SdNqh3VLvRsUBQC0ohP8kMuNy4r22xxQUwp6rQygYWlEkmisNjVwIsj8NGdKLWt2y18b/bjGmPeBulM7Vlue7u+0+6aAAnvulnuNoFA/zxl2pNittvNdKwPcRM7dxJ+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcHlTlerPoJFui2opYECPF9jbNCirfFbh+Z/oJqbkoQ=;
 b=BN7wRp4LHEOxr+0OjzmRn1FOVDAiNc5UD8gZpN58p40oWOXB43Sv1/N8jFwh8MuZQdzgTyfD9sjpa0n06dSTgtOMbvT+FFGaXM/3HX0RnRQKpcXaikbwBfvg6rSjmuBUDrLPg4Fx4b5uHRKSHOWl7BatJSqLVxY165pvwNVVBEhWsOiR6stVN/ELFzO2MxnF7wl+sncS1Ai2+X/gQtZ/gGSdC9er2Cl3DxL2lyh70CYFSGXs/7QoFhxQoiHWxRQUzyQZhu8u3CY+HAIr85/D9JNAVzgoZRlwKX8J0uUpHiZD80iy6rU+Mx7ejLwBDDKKlt5G2CLXn6jV7zBtRxIx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcHlTlerPoJFui2opYECPF9jbNCirfFbh+Z/oJqbkoQ=;
 b=AhUzwye3rKvJulfBmo8QSgq3TVTnWrTuseKdeKLrXT+BC6I1QNTn19muSkReI0tI3DfBUhqZoqyaZAcFL8trzcOXCVkmf0n6R1D6lMtsm+4U8y3m6YewrjsxwIrlfR3wtWS9M+ygiScZ49eOpqeXrgZhyo1kECpkeAW3EJgJyvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS4PR04MB9721.namprd04.prod.outlook.com
 (2603:10b6:8:280::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 06:36:24 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 06:36:24 +0000
Date: Thu, 25 Jun 2026 15:36:19 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <ajzJiWqsQc2EgR3I@shinmob>
References: <20260622160808.1552568-1-hch@lst.de>
Content-Type: multipart/mixed; boundary="qdbvjyqkpmpae2ps"
Content-Disposition: inline
In-Reply-To: <20260622160808.1552568-1-hch@lst.de>
X-ClientProxiedBy: TY6PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS4PR04MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 1712a010-d0a8-4e36-330b-08ded28413a5
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|6049299003|19092799006|366016|1800799024|376014|23010399003|11063799006|56012099006|22082099003|18002099003|4013099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	No2F8989qxsqq8zJnDdO/kDDYNYstbQLw/O14xO+wCtmMA/CUBVHTitNcQpiRXznX+w9rZnar4THQ88lva7xk+PiOf+v0YIsj6CMRhEo2iPfsntUVPMoWT2zh/CduFhzmDW1coJz0qLEDt+AlJmfwLrPlhvTbObxk/OcBxwfudg0GdcJD8wU3sZjP6AwHZxF/aDSYZjR9oHOOtP+Ar1P1gw8E8hRIBK7H+bOEQW+etfT0Jfrolj3T6xYYQFzAXfzJd302E0Chfz8rQ785Pyb20jvwxdpmbrbJRE4kYC+Nr6a4cWtjdGoB0WUAnXJjH9M9a7tthaLVccIKsR9bEn/x+Bskbpa7eOUjiazjHizvgJd/axRjQPwTqQMxgoek9U3H9CicBMgPY6EJjgEga/EmuNCfNJH2eakRXhENVmwrY923v3XjA8DEviReei1WkEvtPsS8MsswGnQ+rBbBoea3gdo6esMd/fUiLmreg9YDvqKXHGPWiuMp7Lcffio9IaFwKFVAExH2FNnDBJSXQa96V9ad0aXNd1sejQpifgsRJXBhxB05VHRqClRq3mRY8MU+gdjNmZtP74y6EIvQTXwsOIilqeIRnRUAsifFvCwu7e5i7z66iN20LZ34tFpV/omKwu7dLVWm34O9YHPd5bQ1qw4RfEkrZLaEhR+tTFccuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(19092799006)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(4013099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qZ9ZkQXx+UWtg/Q6RFB1GaLfCdjyit2C8OCfPTxZrcuwZUwrnhVq4QND+/c?=
 =?us-ascii?Q?IPGneCWJn9CCuQ4PF6nYI0Sc/aGAE/nitDJlajuIbf7fSBW61VwkvyfAAIGZ?=
 =?us-ascii?Q?qGYccMwCXLlM50InpK4jW1yXKb1JMqRP2nKt2eBf/C4Ddc9gAd6HDokIwwNz?=
 =?us-ascii?Q?OYS1LQ0IIRlcJtJ/15yCQ2WIl9p8ED/gBRQcFMW9jbPb2DkY3m4qf9EJ45gd?=
 =?us-ascii?Q?PUa/b5AlpsQEjk3pAOvbdY/W4wUOHfS3Qi56RDI93DjT4R+zBH1u/xvfqmwS?=
 =?us-ascii?Q?wDdps9l72BfBSJQ/kC+AQ/bfJTQkH8MA6kdqMYQNThRndji9skFgA7GXAA1u?=
 =?us-ascii?Q?nqV0pxgKUSlubUQ0ZV56FVHhBJkXyTQDwzzLlMv4zznnEaF/KnYHuMtpEmt1?=
 =?us-ascii?Q?EdNQXrYoC6qHs8PcZG/rE0Lln2g0pWvV1w/3erg6wXmtZylwktBYTj6FS3zK?=
 =?us-ascii?Q?EfOFdFxvh1sq4XmQTecBImpFBiW7CcxBV9e6Ls8LOZ0il+Lx5JXDkY8ozcma?=
 =?us-ascii?Q?t9wrFcD1XcJX8iCND8qfKhArH3fJUI6xWUhGFZKgOli8uaxaNFCQfp/MLcFJ?=
 =?us-ascii?Q?V2sR1ymApuZFW+nSgekmxhdw0hOdciJiXMutzjOwwOVE2ADQKgfVDPt6BslZ?=
 =?us-ascii?Q?hiOBUmTKmakprEOipf+hpeikGH6G27UdeO7XI8TB8jRo3IvmkKVG8L5nt0jR?=
 =?us-ascii?Q?aduGT2FUZqYe2uWJ6w1ipRMvMd+K//NemQf/45jXThUP9l6sJWgnbqyPB234?=
 =?us-ascii?Q?09Tb/CAbX0b55kHXvtFZd93x+eMOTt63TA8r8U1p8mI10HfFgzh7jeXcYmDA?=
 =?us-ascii?Q?BkzxxDin8JvgPkj2Yo/xVqmPhZQt/Z4HupK0psfA9Ep0a+Bp/gk0DWh1sWhZ?=
 =?us-ascii?Q?UA+NNbwPeWU4jiqfCno/G4rpNgKlKnBvqTccLO3oA5K3G+rfO98akXrM+CtS?=
 =?us-ascii?Q?yum/Q6xZCEyN7+bebmBh6qjdsCNwsXr+PgrK80h3lZSbD6km7xFrIXlnlbEr?=
 =?us-ascii?Q?CYYF+jG8luT5EhOdrYcArtm9ZifUDlA8R6MMl3VkdbztkX5JhruRFDlf5iQT?=
 =?us-ascii?Q?yoiUc/JX+qq3/CQMXexLk9If1jz2jdvWdmAPjZcjkU02/60Mx3Gxn6H9RA3u?=
 =?us-ascii?Q?smy+hQGZb2KoVNhP4Is3XFZbkR88lx9bItNzGQciDgqAZyRuLyNR/6qEI+Q6?=
 =?us-ascii?Q?eN6NRR6DUzuGUl2gzVoj0+lfLOmsCTd7Br3iYERgebL7E6w1iHfUb2sK5amK?=
 =?us-ascii?Q?qGRMIPessytdIeQJNXHjChZz98TeyQhjzbh8e7Zet5zZ92SRSL+9HwvjBwZQ?=
 =?us-ascii?Q?FOHYym8HAMkGGQVXy5VAguXqNS3sYtiXm/vl2FQkeRSRbLrhBZlMYHJxQ1ym?=
 =?us-ascii?Q?zQO+7mntSE6nW+QNPMPl6jAKX6kAqmiOZJ/XQ+cUFU39Ml+mu7YjaJPuAZep?=
 =?us-ascii?Q?zgFHYrdOS/kWrSi6Fi5LbMloGnhtwFPi/DSTMPmkKfuxr4+wcSqoyixhBi0T?=
 =?us-ascii?Q?wyErbUauA77uAobZo+acbarwA7LxBjtOddRrxpZg3Gy1vtXZE1E/6agGeXMX?=
 =?us-ascii?Q?jgTk8kU85TvPIknwWmCGIMDdOqFR/Hg7hT+b7/gezZPMJieUpR96z93Boa8+?=
 =?us-ascii?Q?ABko25t5CdhgC4O3HBL+hj8sijEIJ7DlwrTELukRwIq/zXCIQ1yQEz4zYTNf?=
 =?us-ascii?Q?vfFsB1sAedisRzWUgL2ZYenLCz6ru2kWzjTgPcZe+EV0QNrMLscIhPZa6Mc5?=
 =?us-ascii?Q?aPT9DyO/xeNOfD3bh0JIng5IiXK/9Iw=3D?=
X-Exchange-RoutingPolicyChecked:
	nkO2A059igrwp18tLwXJO0eHrNHCoPHlMWtift8qeQUmX3M6u6asajVHy04+AprEkYuEXlI0kf4brjRxLg73UtU2MLhrhYRzjqB2p2atdcFQQDYRr4ByzXng81GJiaq13+Oickn8OK5IRLpgKO0JKAuBEFSUVxH233sVwbMKWvogH5aJljDkHKJjfWKFL0MQtlgAPoNrjzlwKTN1dyiCXatSZ+juKeUBpOBwqPu4KLmKlnh6XAz4BFXa9qG569XyFW9hwpPGKvD1dzVEHeKLesx7/nZIIiq0se1a7pvxN+Rh/ps3Irx9ygRRbq1zxNn7pRWOG9wKu3HdlY6MnUxZ4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ES4ssQmdUZq4oKKxRuRoKcQvQFESU/HjjmIgYsCt/1skVUPhBuqu50W4KYx4KblkLTu87ty7D42utiPp7Rguzw4ivJJ/4jFNnbKrXGPNgRO6/cGK9EaJxbLmtMkTB34GBR6Smitcn3GbG0nOpZ+M5m3JE/CIvk/S0rC5QBU3AgkicfM0zy0xSkrkiP5ZjJBtKWTpJ0WGHXTzgMhhgASXSVCMEeSoo0qBoK9tMCwzWNEy7pgwfI3gJiiIixf+c/wKZmarecuPQcuRmfBeHCiDjvQ9mC+oGblKS32LQMlmaXPZ+jeYiTd1qO9+Us+X5/HUqUhzGNIMoqZldbrXt5Fnim28qDVPAQFBXW4sHQ308TgJ0NQbwM7r8UYVvW301j9TgffomXxh8CPfeC03tDPszeDC1CEzR8q3pm4JvBXaDfs/P9I9tb87kj7KMsvwRl2pZv3f8wtV9KId+BedSA4SxJ1NRkHfzXTeQSC9FRv8r1LpEDl5ZHuVZNIFr8Y83oC7/CFO2g2szbIINUF8DdYLMbkxaq4tThs3Zq7puyKPxxPzqhQbBWqeiYLLg7ha6rEjyenWOSYoig0P9vAUEmmsPwnTjVh5m/5EmDZ76BnILzbK+6rQ53cLCn+XVzVwtthk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712a010-d0a8-4e36-330b-08ded28413a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 06:36:24.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98znKxdHMA+DWRA8XR3e9eICGaGJXQAd/Nz6X+NICIuqRoIY6p+RCHd6c2dwFgHVTXn+1roesM/GTlvHNui/Oa1w8PSwbEp5U5BukdcETj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR04MB9721

--qdbvjyqkpmpae2ps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christoph, thanks for the patch. I ran the test case with block/for-next
kernel branch tip and confirmed that it is working as expected.

Please find my comments in line. FYI, I atttach the patch which reflects my
comments. If you are fine with the changes, please let me know so that I can
fold in the change and apply this patch.

On Jun 22, 2026 / 18:08, Christoph Hellwig wrote:
> Test the basic block layer error injection functionality.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/block/044     | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/044.out |  9 ++++++
>  2 files changed, 80 insertions(+)
>  create mode 100755 tests/block/044
>  create mode 100644 tests/block/044.out
> 
> diff --git a/tests/block/044 b/tests/block/044
> new file mode 100755
> index 000000000000..8baf9fa59c68
> --- /dev/null
> +++ b/tests/block/044
> @@ -0,0 +1,71 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
I suggest GPL-3.0+.

> +# Copyright (c) 2026 Christoph Hellwig.
> +#
> +# Basic block error injection test.
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="basic block error injection test"
> +QUICK=1
> +
> +requires()
> +{	

Nit: a stray tab in the line above.

I suggest to add the line below.

       _have_kernel_option BLK_ERROR_INJECTION

This way, we can confirm the kernel has the required changes and
the dependent feature is enabled.

> +	_have_loadable_scsi_debug
> +	_have_program xfs_io
> +}
> +
> +# load and remove scsi_debug once to test the static_key bug in the
> +# initial commit
> +_test_load_unload()
> +{
> +	if ! _init_scsi_debug dev_size_mb=500; then
> +		return 1
> +	fi
> +
> +	local dev=${SCSI_DEBUG_DEVICES[0]}
> +	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
> +	if [[ ! -f "${debugfs_file}" ]]; then
> +		SKIP_REASONS+=("error injection not supported")
> +		_exit_scsi_debug
> +		return 1
> +	fi

With BLK_ERROR_INJECTION check in requires(), 7 lines above will not be
required. This will simplify this bash function.

> +	echo "Testing unload without rules"
> +	_exit_scsi_debug
> +}
> +
> +_test_rules()
> +{
> +	if ! _init_scsi_debug dev_size_mb=500; then
> +		return 1
> +	fi
> +
> +	local dev=${SCSI_DEBUG_DEVICES[0]}
> +	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
> +
> +	echo "Testing valid rules"
> +	echo "add,op=WRITE,status=RESOURCE,start=0,nr_sectors=8" > $debugfs_file
> +	echo "add,op=READ,status=IOERR,start=16,nr_sectors=8" > $debugfs_file
> +	xfs_io -d -c 'pwrite -q 0 4096' /dev/$dev
> +	xfs_io -d -c 'pread -q 0 4096' /dev/$dev
> +	xfs_io -d -c 'pwrite -q 4096 4096' /dev/$dev
> +	xfs_io -d -c 'pread -q 8192 8192' /dev/$dev
> +
> +	echo "Testing invalid rules"
> +	echo "op=READ,status=IOERR" > $debugfs_file
> +	echo "add,op=READ,status=EIO,start=32" > $debugfs_file

$debugfs_file and $dev in this function require double quotation. Otherwise,
shellcheck will warn about them.

$ make check-parallel
Running shellcheck with 4 parallel jobs...
tests/block/044:48:61: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:49:58: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:50:39: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:51:38: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:52:42: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:53:41: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:56:32: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/block/044:57:43: note: Double quote to prevent globbing and word splitting. [SC2086]

> +	_exit_scsi_debug
> +}
> +
> +test()
> +{
> +	echo "Running ${TEST_NAME}"
> +
> +	local ret
> +

The local variable declaration is not required.



--qdbvjyqkpmpae2ps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/tests/block/044 b/tests/block/044
index 8baf9fa..d31aa4c 100755
--- a/tests/block/044
+++ b/tests/block/044
@@ -11,7 +11,8 @@ DESCRIPTION="basic block error injection test"
 QUICK=1
 
 requires()
-{	
+{
+	_have_kernel_option BLK_ERROR_INJECTION
 	_have_loadable_scsi_debug
 	_have_program xfs_io
 }
@@ -23,14 +24,6 @@ _test_load_unload()
 	if ! _init_scsi_debug dev_size_mb=500; then
 		return 1
 	fi
-
-	local dev=${SCSI_DEBUG_DEVICES[0]}
-	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
-	if [[ ! -f "${debugfs_file}" ]]; then
-		SKIP_REASONS+=("error injection not supported")
-		_exit_scsi_debug
-		return 1
-	fi
 	echo "Testing unload without rules"
 	_exit_scsi_debug
 }
@@ -45,16 +38,16 @@ _test_rules()
 	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
 
 	echo "Testing valid rules"
-	echo "add,op=WRITE,status=RESOURCE,start=0,nr_sectors=8" > $debugfs_file
-	echo "add,op=READ,status=IOERR,start=16,nr_sectors=8" > $debugfs_file
-	xfs_io -d -c 'pwrite -q 0 4096' /dev/$dev
-	xfs_io -d -c 'pread -q 0 4096' /dev/$dev
-	xfs_io -d -c 'pwrite -q 4096 4096' /dev/$dev
-	xfs_io -d -c 'pread -q 8192 8192' /dev/$dev
+	echo "add,op=WRITE,status=RESOURCE,start=0,nr_sectors=8" > "$debugfs_file"
+	echo "add,op=READ,status=IOERR,start=16,nr_sectors=8" > "$debugfs_file"
+	xfs_io -d -c 'pwrite -q 0 4096' /dev/"$dev"
+	xfs_io -d -c 'pread -q 0 4096' /dev/"$dev"
+	xfs_io -d -c 'pwrite -q 4096 4096' /dev/"$dev"
+	xfs_io -d -c 'pread -q 8192 8192' /dev/"$dev"
 
 	echo "Testing invalid rules"
-	echo "op=READ,status=IOERR" > $debugfs_file
-	echo "add,op=READ,status=EIO,start=32" > $debugfs_file
+	echo "op=READ,status=IOERR" > "$debugfs_file"
+	echo "add,op=READ,status=EIO,start=32" > "$debugfs_file"
 	_exit_scsi_debug
 }
 
@@ -62,8 +55,6 @@ test()
 {
 	echo "Running ${TEST_NAME}"
 
-	local ret
-
 	_test_load_unload
 	_test_rules
 

--qdbvjyqkpmpae2ps--
