Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794139177;
	b=H/vmxE4DCFTUuv/ZHxOPJSvtUJw7CEzpIhD9Fcojvs3H0BVg8sWjUE9ur402NTZYh4DO
	 /d/TE2wNh7j4VsEhQHz61xYPXfM8v88IEX+Zu+s7kDjGqLjmbxWxXLbjZyu2T+yAonN32
	 5oF/m5nA7lfsjxwcnTBREFS3zK21mQ4z1Eo927c3S58NZl2ISZ0yTLhUbLN3k0S+DaGy0
	 skb7iNDjSOXSG1c4beOZuORNVaqRggqUcTyfutylQjnThyEyJwN/PwUr+itzZujD5GeAx
	 k6WaMWLHbAM609L2B+iJ2oSACZSHe7anGpvoYwWtZtf4pWffLYtYKZIXtNJS7EPf0LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139177;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
	b=ePiUwloll9QBVuBaMHtbj5cqaj2MoN2WR7YLXQ6x8+UM2+07vdqJmDSMo379IWGmiTKn
	 R8N+2D8JsOCIouO7BFQaiBsM5Ms02QpIDW4CFMgeVehpwDD87kY5zwZaU0aVHqO4+HPA6
	 wgHW4aW8Ws7k/SVsogFVBag8C7n6iYVj860TDUvCMGMEycXp59Scy5eyN+1dTKzpPdWR/
	 GbpZ9i4rbtS33pOWLTYGpI0ElwePqJzF3X0N2S8UROLLBnL9PVYCfV/4tVowrvqUuuBl2
	 Ny+rV5MdPWd64id7uBPiwi+LYjHU2QrrM43+BN8GvcpWf7mLB4QXFB1uBghDA3pLJfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Opq8rKTJ;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RxMh1O0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B81606A31C
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 11:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Opq8rKTJ;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RxMh1O0S
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794139176; x=1825675176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
  b=Opq8rKTJumHSUSFqjd9wHhuMB9an8bhBeELF543XnbGeo3VTcN/Ij8ST
   am+F1fltImQYIXhN5MDjHaRWmTf0c3mURxRpxUonGFmkJAXXu8fxJBjJS
   aGKCkwL0l+PPED182c0/xX+84ToDv9G6b5ZLZE77INAWWWLzgymAJrIfB
   Fd6feqR8QrfXI+WojGrp7KGX8EsPAXrOs4h3EjsmljRxjTXgcpR7UGcA7
   DxdsPCXRTKPmjjxKqany06Re/V+Evwlen0qr34lvF+USWFObIJUShGHcj
   vHZGB3Fp0z9kyaRFKgaplLqs1/ltnJoS6o4ktLAT33pfy4Udg/lpHqHhO
   g==;
X-CSE-ConnectionGUID: OuzB8R4YTbex5kvjEzhEyA==
X-CSE-MsgGUID: EkAZKK7eSCSbPOCfzbwILg==
X-IronPort-AV: E=Sophos;i="6.27,202,1786982400"; 
   d="scan'208";a="160150230"
Received: from mail-centralusazon11011021.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 19:59:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZalTkh5J9MGEp6NpkY9Ce7f6Pj7qIWRYJKXC6CZcXsxTWr6ZEKrnyKefo72sT3Taju9I0hUkY1WwuH/isIqpQGXhaoN3DouBy8zbSDxPS0svg9iIke2XNs9jnJH9WO4RdVFYUcRIJfYFn7j/aE1vzmYnnayadcqwHrAaXfsPtN5i8f5d+q6op/uQqUmylulAKdkangTGhKwE5qtPYcEIfeFSm/KFtksWs06tHTKh2ZdKCJkrwM6wScfpWLfCJzm7z5Xlvf+3OZwoZkTjJPH+aplK8NANviqPg5/HDVPqdHAVFsVku8EVu2l7BXMXUoc9ur0GPcmpgjSYQyA16Rf1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
 b=KacTQ5tesVc7RVKOC7VPHXRl7lNuZS4WkIRT4HDd2b22os9BLVTW2XC+HH0iWcRI892fPrOTF0JYwqKHDxl1BHsm3RlPVJJooC0CEAMG01T7bKcz39u00mnNFhp6w24uMdKBTdWCmW28ryXtBw26kUB14BT0+zsTC/9XgHq8ho4aRO0VNa49qrQP3UNRwF0Qr2iq3L95xOVs9VAPbX5GkjpTNTJGAo27dF9loslx0cPOrUHUxIYDT2MYLot7rAH8jwWJM4oO6aPWVMbtuHvlbpG9OM8ODyNVD2oPeqUd19LEjh4G92lbtY8OV49MmvuqaW72smBywGA79UgDN/rt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
 b=RxMh1O0SzzSMZJT3+DpRCjfIgBdO+5JxsSCaFh/rLJH6fSJg9rBnHIeB2HkXGPGR1LZtIWsEb2b0/AJeTyMov+NYpzpVOoXZqLhvH19xJGWX/ode/HCRFsEUnBt3ndce2vXKQeDqnCYX2aSXJsCftHD3QGTILIiAhG1TNPRvi28=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH8PR04MB994117.namprd04.prod.outlook.com
 (2603:10b6:610:35b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 11:59:10 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 11:59:09 +0000
Date: Sun, 8 Nov 2026 20:59:04 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
Message-ID: <avBj_fY_cZazcdXU@shinmob>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
 <e8553327f2610f51d7800c1bbb1544201cead9fe05828d82975a7f4e9245d30e@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8553327f2610f51d7800c1bbb1544201cead9fe05828d82975a7f4e9245d30e@mailrelay.wdc.com>
X-ClientProxiedBy: TY6P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH8PR04MB994117:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b84e53-9262-454c-9260-08df3d8fb2ac
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261022075727099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eZ1ZjFfhJWyM6nA+Ak1nIhgQM3wQp6dvFzSdi+wtMkAbhkkrla4G++4jTs3A5n6TxccbVz1uZseB9voKRiq2xVLGglx56Ske2b5Eb4MQl0ASd3oWwoblU6DPQ1KJ4HMIxGpbTzp9gy7qNOpCG2j9QOK8/v3nee1hOgatLx8BVg5RW4wADydPC01VlD/+TBP/wnI+G/8DgqUWpIPPJ2eDsIMhfOzrOv0AaNEy67BOD44YYswZlCS7038NNS7C3oqb8zWwu65lP16gccJKARfEOfBkD98IJi/e0gKlK6FRu1Xp5iEFOaOL4KaPMIbGmF8Lhh4qNzVYUWrDvGFX7VISsHKiSsFl/yZ6osEVDbo/3O4AqApjKykntxsY3VApeCd4uLr2vjlqH8TnDWIJYo0r0GQnVWcIiMOgkrovs93cmzvI/vqY15ExnTB62dtZ9/MY5fb6nsaeYb5pv1AZ/IeJaEswNJ2fuCrE2dl2vG7+vVwmtODZt23E+eUYjNrbUW/GkUAWZFDPTmb2XAstqf/Ie+ieol2M6pDyb2WlYmq2okSaZF3Qs3X6QldPa1LUCX9BKnd4BpR4GUiNgtC9EjjPBnu75O6RfCLyaYCbrRvrodYn+zyR5TaLZFFgr5IyHZBxRQrOVd+q4rYnOuWR+puxaxeu28DMR04aqBFFayrtOPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJ/bCo4mWfsUYSav3hetuFnh+udQI+NpBOJKwA2S4ROqv985arDDxY9VJ8JD?=
 =?us-ascii?Q?NxC+JnDey1VZrFBKt/ACBhj0hKX3c1WJ33qWLc76ChhXSfLsFEO317kHJY5I?=
 =?us-ascii?Q?2miZdwneln4WuucgxbPWBN68eu+yqgLxraZmFoCE4bHwiVeq883+k82LtkDA?=
 =?us-ascii?Q?SExDUlrB3/1zQdx/e16wpjx4MC9Hd7NZJrkkec0ulS/e5J6Jpsz+VaT6EUoZ?=
 =?us-ascii?Q?vpLyoN0uEoCoKhYu+6qWPszjt/xyoL99O7Vn2Z4N99P1iU3lGgcRX0XwaWiT?=
 =?us-ascii?Q?TmUQxenhilGx29s+9jYhk7zmtO0+HJ/iliOJCjY58wvQMPefPGvYOa5tZvzH?=
 =?us-ascii?Q?Ulkeck2oHeUk2+L6GpxJgyBXys0aRtoSEPtsVqXmnAEllnc8hHoNBcd0/6oC?=
 =?us-ascii?Q?J6gF8iMpozaw/e4yZVyvbCL0g73Sb0g4fBUswFASFN7MP23A6wFisjUHs/cg?=
 =?us-ascii?Q?IUkCFRV4PmKHLLXQP/OaAmGk54NKC6KYhhQ+mylGG0oYlEImC3L/QA5jCFPl?=
 =?us-ascii?Q?is9hXgdJfD4ka54I2DMjcUHKEnvO7F33W25d5WYjzH2K86jGDW4TsUNNhtuf?=
 =?us-ascii?Q?yMMOFq9F2reZLBSO3jGKnaAmm7KCXASmVtGYVQIyTstYKLSTebm6JdD1Hr0p?=
 =?us-ascii?Q?2vEc+xMJn3xVZDD94F0K10nyC3iE4+4YCi9lB6m6N8BNB7tysD1ne7qsSrq9?=
 =?us-ascii?Q?Qi6iwa6Bd/yuH945EMl4EUCdlv4tHqq994Z59aNYa0AI4k8guIdd/VOpic6I?=
 =?us-ascii?Q?0/XFAZf+rRlB+pOY6xUt6J9UstCVac8D3T+ua+V7niclP4oekoIRNdYOCapx?=
 =?us-ascii?Q?rGHSGOgFYFRDj3x1gkI3+rS3WHErPaCJ1o0aj2MLNNm6hNGNBIjHn4obrjgp?=
 =?us-ascii?Q?3PZGtU2hHYK7MBMSzPlh2DiDUgDk/M3r3ueE7R0Oqh+oPXkXGmEsx7uMThte?=
 =?us-ascii?Q?iZc37zp5HinV/rCnmb7OKMiOonG8jmsZ7Kk7S40y6VZylPcKIKsbiCNnX/wE?=
 =?us-ascii?Q?Qo1B6iQngP1gYBFykx/fifjgwK9emrgS5zMztAxD5OUNrEJVpslufgZ3yxAU?=
 =?us-ascii?Q?pW2k3DxR2xc39+Sr/k3LJCe1pU+7VIhnmjNAny4duOfrD3bbjrRpF+zwkv5W?=
 =?us-ascii?Q?83IzVGkgSVRky+SQsY7ojAxCkxRt+NPoz/EdsfGWLn/mpv3c+J67WCC5NPC4?=
 =?us-ascii?Q?lo6g64KBdB7BuDUwC8WQkHFmyegHKX7/jRpe9ordR0cPPwGeNVEmLWuQLFS7?=
 =?us-ascii?Q?IkwVEr0rv4e5Nby5I5L2kz2rojUDqZcdeAUJB/U613sIj9qmeeIrZla333+g?=
 =?us-ascii?Q?jd/U7QSnFJajyREv+hTawVM+dlIrzLV9FZ4oBXmaqbJXCDxTutWGV0OQWq+C?=
 =?us-ascii?Q?DvUsjgHph3LoHLGhusJ7MCfQP3BAl3TVCL55yDU1LhD2JjjsTD+5J4ng2SSa?=
 =?us-ascii?Q?fK+VcKGSrdc9nOEBjVtGFexYok/tGyrphzS10hDEEliWmM8GoCSYwO0P69gg?=
 =?us-ascii?Q?ypU3pfn9rQ7886ZNoMzw6RGywHuLOvyC8MDsBktcLoNp3yPZ4nKaZO8WScu9?=
 =?us-ascii?Q?DFdyJ72yUK85XLTY/XJzYJaRMLOwGgUvBy6MvoEiC0yRZK0y1YyaBcrFRhti?=
 =?us-ascii?Q?J39Nde8KSxvPdaGM79TCFwdDeV3Czm513itdC/FgEfSvL+xKPb2xnJpomdyY?=
 =?us-ascii?Q?l38pBWnwou59soCxHHt6AgdDnwsXZ/IYrwFog+W3QGKKtFBtpkS89e38Cjuv?=
 =?us-ascii?Q?YLgWd021p/aIQDaJLPcxOz3tZ585bjI=3D?=
X-Exchange-RoutingPolicyChecked:
	G6u9/PnI1WCNVW2Us3i69xAzcpuj8TFADTsicHMHcXzfuc741UGHOVLJmemNBmLE4YQtWU+VYEGkdpXChzp0QB9duyFX37SIM7Y0uBmPnmXjjSPJvQUFDEk2d9hfnDg72UgkexmzUs4/jdr6bY5R8yfACnmb2HWjwH8PUxTNx/uGARB0vFiIVEHOSlV7U4ZpISlisEjR3J1BDnTVY8RMcNzIpJe/f1RqQ7uzOBfgwj6NZQFg8kHx4om8rUucyx2TsBJCaQ3KiERM7f0fctAQuZPWybHG/CgpH/VNYvdQdbZZzuXBiIse3Boo1fU6Vmy6Br06MVW7GPtyQgvMBMq5zg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZM2ZVIc9nK1gV0jIKO2pctSUEBypppnrrUcLmtmE3NNeGHW3+5SDsaasO/LnvNk5dluHXjrEJL+MK5hsdxzpIjPCW/d5WrfZfcQBI/Tfwka1T0Ku2pzMJs0MYlkMyZiaJLy/NZt4998GbirfhgCuNM6ccj6XcqqR79Gat/95Kjl25W1u189AkUqtcJqH/RUI9gjhtZNFw1X5vJmLY1n4F3RmDPgXwxzb4x4yOarkA3RsaZx0wby6XP7EK97aCvh6639K5dEsShrbclalcqs0O0G/8xKKG5KnTBHDvDtiBdpc1ywb++qUeOj4qtYRaPeBVHH6fYPUs7NIzyZ9OeZtwAeY8GyfeZYiJiHqioYe0467bXL78GDRM+NQn55T2gTG/9Z8XbbtCABmSJY8daoy/vBAqu5A7c5E+ZV/kHncheGAGIkw2vobuY7rEJToERKVvvu3+f7/j6mIBXbuC8epeXVjeW/EqO9V4Qltmw9hcfjf6g/N2c6sxS9dutD2gVmzT16h3CwZmjyN7h9u052n50xttIYh+v3omxnBHbzMZZBaWtUXhK0ta4Ll3GPsfaPPwmGNpbntx2eAyWAc/RwkAzrnGxY70TPnTWhMQSg8u/3fMZ/DdLFafDMhUdwbKe+a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b84e53-9262-454c-9260-08df3d8fb2ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 11:59:09.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcLkEbDf5QfTr9oTRYBhMReRNmtFwwdk1X3u37e0dEpexEI40ojfg2clyTmct3kfT8oTBRJkqPoLQlS7iDS6+8Mf6ApFG02wVdOe7r2xzBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB994117

Please ignore this report. It was sent unexpectedly by blktestes-ci
misconfiguration. Sorry for the noise.
