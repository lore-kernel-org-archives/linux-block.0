Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794479789;
	b=u8Jc0DJoXfxVIX3/HpP5248IhQHzTmvMF52/6cns/boT5HBHznP3aomJ6pDL99bo0nKw
	 QBe4OSTEOaAGwOXsExAXZYpCJ2T8AksQbAPpTAzMnzKBgeqN/6taSHJak3K6exJ/qDLwp
	 O39GEQCXR1mzpAKVEMoz0DTMECIgLtfR+5Cxvzmxgs6loaYEV5DFDTo6moY1LTjNtR18a
	 eIOcEwYp9BN24e8u9UMUiQe48k+RiMfL0Z4wrHqoIoqoT6Ue4z7NnqTG/aqy4Y5N9YfIv
	 GFv71Id+TltuCThdmp4NBqOsN3ZF9NBIMOevVbyZFdu2xMfBIE5J6mw/7+k6LLBuayw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479789;
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
	bh=2OoIxW3tAloW/U8JPEhJlb5IdGErFS0xoeRYtcy5Uj8=;
	b=2HBcrFhC+Owk73ZZNggRM9UQ6g1vnMQaD11d6yuY/wM8B3jG5/w8mxxkEbsu32X42Gbu
	 NRc4sK/+mXHXQjm3rve0j7u/QG4zKyqhEeiACvUlZQdqhUVYqyJRS2CBgNmx3m1VdKSRP
	 DlaXX8ifNgDPDB+QL2ErhzF1BhD2lJM2XG8lps7a4YBF61sBrjG189rNPAAC3fILvSLmU
	 4pQod449XGEHoU9yiptIl29tez/Yrw7jJ2jGULNrN/zENrmqOHO7xDFHSjbGRKpf9A1wU
	 U743lFU0mPodfxdVFcIyhH55e04LOWe8xYfwAtSrSvgaTb30ASfYf98CmXHWyuzA4hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Vu1xwk7s;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="Ee58I/uw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84249606A335
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 10:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84249606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Vu1xwk7s;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Ee58I/uw
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794479795; x=1826015795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l7gBY88kqC3oGvc+IFUZrmeJaTrLHQ9RLA60EUGIvGM=;
  b=Vu1xwk7sy1GiaqnFFTShLiHa/VXPi6Q8FfQQn/7N6YclETBf6jJaYsSF
   yS6BOKzZHb2n1/f/g2uTbwdFCJSrl/YLptxM7h6uPnaQmSaJgWZe8JBqn
   cCXb8yIoSXCtyYa6A5mz+nsDenb0DPMN9i3BLkaPnKu+hkaX8TgGnSkeR
   +Yvp2Aog7G660XIQ0L6KZewPipi0V5HxbPV4tVYnHReSsXXLDD/vcdyoM
   H69m15m/n6GtkzA9GevNliyr97WdsmMyw2PGLyvAUGitT6itmA3SindDW
   cH0+jH+bM+n7NrCljwliotjDZIJDjC6QCB0edIIt/scvGW15rQCCwglV8
   A==;
X-CSE-ConnectionGUID: AaflnTLeQA603SYJWJ/S0g==
X-CSE-MsgGUID: ZYBuRx9NTm+N5WzVM3oXgQ==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; 
   d="scan'208";a="160653525"
Received: from mail-eastusazon11011029.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2026 18:36:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4YWBRKbbwua/xA0DitM3sGI5/XFe/Uk8aTedDIV+DiM6v5dquNg6LPf2wrtwvftTHYWs1mV5cqutl5QekP+ZmX6BI2BkPqWf4/23PnBqZ+Id/YoaHym6Wurm2n2x/HKZ1dg6mPc6dIuxUqoMV3OSSlvg5+XojUcLOVn4AIjTYcn17riIqQPBIEUQwDqT7NfuDTCa9FE3JeN6uGRoBXpBiKuMgKWcBHyhKWf9Lgi/HetssBJ+/PuLC4EPjBzan95QP3mcJ8I7aExUI6L5f6CABXwc/MQLo6lSI0FQG0hsnH5ncnIbw7NvjHyKmHg43TOuApBzOokumBFkNHQj6U+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OoIxW3tAloW/U8JPEhJlb5IdGErFS0xoeRYtcy5Uj8=;
 b=BbNcxoTqC/GTvmPxnuyzDOKYoUXpoKiJd8rmJhbTJra6eXTNKBoG5i/4IBacESrU9fME81musH+ynbrTzTtnFrrEJlpAJwSG1iIxH5L1g2wTWx49jmHQ/NTVbFXIK+PRx3pQ1614Y30MnzQD0etR+zP73MtIL15SYIOEY/xcXi+ptSLtX7QANjNng9DTpgh5AV0VGWVpyNRCFwhC+GfGadzyZPmuFIYQYnNIe7Q3PVaJyZrYax4Vf39VR+25DIigaC0ihWApePx9VOxJikQDcmhcltjlRM3ZdNs1rAxIyhsK5fj8mS1X744ndu+0FVBiX83M82hlkPOFH3CqaZbdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OoIxW3tAloW/U8JPEhJlb5IdGErFS0xoeRYtcy5Uj8=;
 b=Ee58I/uwqw7pYTTetVnbTzKZTpA0G2iSRvb3VovhmmJ3HBxxqdsV36sgV4Mr6X7TuyRnDAMGye5aYWf4nPAlKa2cITF0VYbYWQl8AUbeNVY3UK4oOJ5WoPuV3fTBsH+/mB4EsGtt+3I2vly8WItTyFc6XT0ug8ACWpw6cwV7j6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7165.namprd04.prod.outlook.com
 (2603:10b6:a03:2a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 10:36:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 10:36:16 +0000
Date: Thu, 12 Nov 2026 19:36:09 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>, kbusch@kernel.org, 
	kch@nvidia.com, hch@lst.de, sagi@grimberg.me, 
	"Ewan D . Milne" <emilne@redhat.com>, "Claude Opus 4.6" <noreply@anthropic.com>
Subject: Re: [blktests] nvme/077: Add ANA log page information leak test
Message-ID: <avWUy2nQQChS7dsu@shinmob>
References: <20261104173842.2937092-1-jtaubepe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104173842.2937092-1-jtaubepe@redhat.com>
X-ClientProxiedBy: TYWP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::14) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: eb53bb7b-1cc2-40a7-80b6-08df40a8c7fe
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|366016|1800799024|18002099003|22082099003|10067099003|261028144727099003|11063799006|261021121427099003|56012099006|261022105027099003|261009223027099003|261026140227099003|261026121527099003|6123799006|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	kMp5lZ5TVeFWJwgomiAYr/KyT0zRJ+l4Py0Ouo9iS6t6bFPgqd7aDh6sO1IVNHLDpDzEpKpIcDjJGPwLwIBDeuskmbj3o8B8MXFADe4YSJS8Q8dAAF+KV0je+xzpoNFYMZ7YLPEEK1wPUS2Dg7oViq0l89LLFwPQeu3r8l3t1Cuob2drbNJjdL8RsiRAMUBp5we7c93Egnl0lJU6pRf6kGcMVR6Iwmt3SPbFpCXRXvP04vmIgNKkq2VMdaWWOQt1gn9qFWFlzSo5nKOh4kZFGzTB7xviTSqKiG/+dnYaWurNIvGAYzVpJx8kFKKySzDp9u19o2qmjfAd3zE2Asj7dV8Wm1mSyzxPwjgRQPmO9NYmIOHFxxX8KbQRYVu+tzr1F/H+YEUqvPSGM3tgTTclDqCGcwJB22dC0zcDxfYpzBp6pIA4UFZqN+Eh1yquBqAW5kaVhJ4+xZJAxg/5NMlp2oREqXdl3F9LXfWhV65QqA1XyU4+UO4u8mP/1XUZ7aiStviTsDLOkR60lEeUyMNpl9PuXhS4dkInTQk0lw61fSSAbaKFlaz1MyrwjfZMtjyo5l+JHohBI6D9H1z761m67Z1+RB2NlUbx0vx6m6DZSXMHtI/6pl6Awfm+qRugH7kp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(261028144727099003)(11063799006)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(6123799006)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2liE9E4f+Y6+7EOhSl0ce6V/o0T9n0vQQf6W8kWEpKMWPe//Uqfi9fl2kUKL?=
 =?us-ascii?Q?YPHGrC/MxhPibqyGKJhzi8nbsHXkl3K9HvQ1rSWGXD3KZCmhyTfMacC4B7Io?=
 =?us-ascii?Q?kUka60i+tm34dC1xHhws99yf7TRXioUzIsAGSoVzuc3N/hCSdwSLDwev4Vdn?=
 =?us-ascii?Q?5Fdcv7k21ubR4ZLFliPNMmapy2gKGvUpej5jV0xN577O8VH374fQR8vltM4Z?=
 =?us-ascii?Q?+zkkDP+XdgiBtvEDWctXzy/Qa0Zy95OJqLVFvo368fBQnEGxNFljEntLmWJl?=
 =?us-ascii?Q?/YQkQjK7nNx1/yiVnQcEEaTHtar/50e2vGNyobJQa7hfJM3chP48vtCFX4gR?=
 =?us-ascii?Q?Egek7/v1fccPC6BPKiS3d8jckz2WCo0M7dCVxq/foYQkfGz42mUU1B/1gL6V?=
 =?us-ascii?Q?tqtu6ws7CVdbPWNw1ii1+BUngsQx3Stg2liof0pt6vQhoKdApw1nT1QSCMIZ?=
 =?us-ascii?Q?yFMzDRrQSo7q9B+D9nCgTtLxrkVZZxC0ov1uiPBDmIyo6Srpsd75jD7h+BdT?=
 =?us-ascii?Q?DthFlcMv676u/y9f5JXzPcyL6j+bWkVZD5bvpR/wnt8fDoupAuTY5EIuLfKW?=
 =?us-ascii?Q?RehDH8iuatz+76MGSJJYzLdvVHgKSk6ziLDA25yXjv+o8bV4ZU53YEsWh7jJ?=
 =?us-ascii?Q?9QMCCs5+3J2TiiA0hrhfIB+m48MX/hm6Z4/kf78XLYuujUmOyQuGlyzOQeI6?=
 =?us-ascii?Q?XQRD1uOtQ2nIathD11hQtgZQ8SFZH70un9DkD06YBbNSw+x8HNBOYtQIfoHJ?=
 =?us-ascii?Q?HNQYahKHJloKOYgdhW8kzjwAqV600qDvwRFqUF68bSG9hiBZ2jl5tvrPGV5K?=
 =?us-ascii?Q?7el5grKdAt5zZO6pi7abeL9QZgww27mjrahh1WZnDS+AyS27klQBc7/GF+Jn?=
 =?us-ascii?Q?iAh36XsST01Auf38GfrSIVvJhk2XT8jN+Sf1mYG6R7WwcC7gPMuXCULYsvXO?=
 =?us-ascii?Q?CobR+0/jz25LytgsPnUHAMXRtnbD+ef/j2MSlXhliShgoxd7IEj+rK0i+xlQ?=
 =?us-ascii?Q?rF6ftPW4p2HaHcOokiT/dBgFTlVik0DB/fUtK9ixxXzHFWU5CbNCfw/JYSqv?=
 =?us-ascii?Q?KVvNRSRljDRwH+2Wkb2knnYShvIyLKBDTkBWndUFmBwag7O9pefaiYqnSoX3?=
 =?us-ascii?Q?7GzR1q4VGXSts6LgkCT706cr0/u7fkYsQ5k93Ctv21hRVPAOgem5D0ohOoMY?=
 =?us-ascii?Q?DLhXPc5EaDHGR1oOmiVhsSDsZEjWiNvdR5z206f7BIOY8HWPtVY8kAECELvC?=
 =?us-ascii?Q?1DJSTZej/LnY9u/DUhwthbTu1txiKResc2/sBmIorvGDAbxy+tJbXkvQZrLI?=
 =?us-ascii?Q?6LrOJTqEWn9aRsyC9zrjUty+zmDrCXUmERLqIJkJkklnlINM+QBTSPXiUoQL?=
 =?us-ascii?Q?Lmticg+KaC7+9e9W1v0v52WiqnvMd7+1eNNnv1WMVI3AC6BgJh6k18JoCf7V?=
 =?us-ascii?Q?KmkCAzvAuTaFZurM+A8QD5BBHhpcYY77Z0V0Ta10gIKJllrpNQ8kC06pRuxY?=
 =?us-ascii?Q?LIiyWggxxPBUBHb31GQ0AXbiaNXxF9rnFgEm3D3od/tQzs2z5d6qqJ40PphK?=
 =?us-ascii?Q?TWW5m9hyKgOHI1Kw1nTYnOQUmeDwvS6kIxUMN43zcqcZbmPpCXcPqHia2v6s?=
 =?us-ascii?Q?lXwi0bgKp1T7UhjDxT/VjVCA4HDtnjEftAP3+XEwaC2Bd2Psy+UwhhcOEcq6?=
 =?us-ascii?Q?2UBvVN9n6x+CiRa2FfnUUcsOJRVmKF6Jt8KKlLmBSz5wPLCi3wuzJQvO5kma?=
 =?us-ascii?Q?dL3OwXV+DnijdPfoigzEwDFA3au8krk=3D?=
X-Exchange-RoutingPolicyChecked:
	eVt0j58LbvDeHJVJQF92JpMYkpI6ldc8+4vzg6xlQR6wk9DFYyXgHHSfnm8jas/USP9m8I80ANrOco8OHpVX8K7lVsWlmAa9+v5NtKfknAY/8pnm64ARJLTiUbWq7YTCKyqp4gC1zLlFT0x2uuAbWZO2oS+eTmVFWawUNQHKCkFcBFlSPK81d1rQ10ClTNvql3MBchSHVAKM7AJX2pueGkcjUm+VNFgrjTWjx6gNH8Y83Qexz2XdI3nf48zMOWKdafiiuSiGYTkh0OUlfAEyQKvhx8/aJMo7RIwjoLVjf6F98UPM3+ybuENiY+zxwgFgJf88440FbPymlOM8zsGzPA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IVdBIz7DcLKSXPaEL6flrNMy7xJEiw6DMjESyGls6xdE1PHuo4iwZ8DtCAU8KxRC0nZhIbYpdqsBDgLc27v5XomaaWC/4PG65+BxJkZAdq4OjM5g6TCzUYKc7lUKWQHlvbWSoZiWWyCt7N6pETiFWUY0Ca/FtGQOdBXYSuMI5IL8K+F5cU147RH3XlNSPPp8QO1A/xsvuk8te7FoURuFqjha4elQ05VWmDMYTTP3fPHwCPg1S9CxefE0HoTGeQL7akDigp0ywmxXJYA6zewJm/u0V4chRAJb/HS6usnRFNFePwm5VqmYb8Lm0UUZEsdSRzV3vY9FlzTSfE6pfakDH3UU77wIICQ1+cJVrM3xqlOKHv6AEfw1/qmZmSbHGGhWYZrRqo0oLuCwmYuvF4XSdeQzGmFLYL0l7wddUGuYuANct9TxexPMAq06aqR27MGkc2+2ReYNQhdcyY4Amu1iKUPMpEFoqSAeSRSOd1mXZuPg0RDbLuVeuSzBni7gFF8a2VOcnWTB0hsoHckCk/p+YReoQpGdtucZyv/fK/1Pg7TVl1wvwcLKed+2+jO3oOwP9DycQ8LVMPY48FWbnfWVRoli+nvNkzKlF1tVyCOM779xNd3IMg35csoMyfntGbMc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb53bb7b-1cc2-40a7-80b6-08df40a8c7fe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:36:16.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HiNsCYez3oAP/injT9x+1Sew8IxWFxQ77DSogP+ZgKF0xovgUUokcaP9sytX7vzL6XB2sqUp6FOAD34TFOa6PDw+A8leK38+F9ykFCfBa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7165

On Nov 04, 2026 / 12:38, Jesse Taube wrote:
> Regression test for reading memory contents beyond valid data when
> reading ANA log page. The NVMe target must zero-fill the ANA log page
> response buffer beyond the valid data so that stale kernel memory is
> not leaked to the host.
> 
> The helper program (nvme-ana-log), requests the ANA log page,
> parses the response header to find where valid data ends, and checks
> that every trailing byte is zero. The check is repeated 64 times because
> leaked data may incidentally be zeroed.
> 
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
> This test is meant to test:
> Lore Link: https://lore.kernel.org/linux-nvme/20261104172833.161567-1-emilne@redhat.com/

Thank you for the patch. I ran the new test case on the v7.4-rc2 kernel and
confirmed it passes. When I reverted the kernel commit 29b8758b470 (" nvmet:
don't return memory contents beyond valid data when reading ANA log page"),
the test case failed. Looks working well.

Overall, this blktests patch looks good. I have three minor comments below:

 1) src/.gitignore should have "/nvme-ana-log".
 2) it's the better to note about the kernel commit in the commit log and
    the test case comment
 3) I think "--port 0" option of _nvme_connect_subsys call in test() is not
    required

Jesee, if you are fine, I will make ammendments based on the comments above
and apply this patch. Or you can respin the patch. Please let me know your
preference.
