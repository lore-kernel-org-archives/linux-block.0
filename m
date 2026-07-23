Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775A43744D
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801123; cv=fail; b=l8PbBvMaGEA8jXjlF1tnznNkrkQ03jtGH6x28DC6vKUF7oIZnl0eBQyTOgtiPon5aYIfNuF6u+LaWT89f+AogAAu9C4UsZNHIGm+kvUHRr814rWvraC9cu/0Go4hligQM3h08zgwY3mRv31aMUSqJeC79hy8ZBHzAt4sEiFeJU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801123; c=relaxed/simple;
	bh=tzs5p+HT8xlJrZYOQeoeGA0J8VzTK9jxU6sBfDkOM0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KO9NnTvNphE7t9cKC7Khuz63L74Y9CoLqc886eMeS+YhC8qgVCByETmgaH5g/dZb5lHxodkbmnyF/Ukc7Dc0Z/XU8gnX6Q85Yx1GnLZ5zQ+FqahQL6ImDKaOhp4djyK7Y64YipMHPGZV1ZP2vzEWLj19TL5ZHTYrmpFvCtGpYTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X+Wl7UQx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oLnQQWm7; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X+Wl7UQx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oLnQQWm7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784801122; x=1816337122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tzs5p+HT8xlJrZYOQeoeGA0J8VzTK9jxU6sBfDkOM0w=;
  b=X+Wl7UQxycQknB/aKJsSY7IyL1OXpTGfn22fiD79mLFeo1jZ8uGVlwr5
   /FTDC6RdpwDZ1Ixq20lSLH/RiFcwW30aeUlFcgyTyFEqN6pV4Ro6fCm6G
   SpgarJGmacgUn+YZ7b3pw8ZH0dAenn/ensVFRs8x4Cnguorcnp0olUfnm
   tyPxjsWuKpspxd480qZl5/SUIGsLi98ZOti7CmYke6LW1DVN0Psx0KlxP
   pb1KQY2c1KPMOOdbAx1swcRr3tiJ7N0HhWXiiaXc+0vuEOo/hnoRhXSg9
   rd5pgei9kAzR0o5R3m43mWzmhlFlTOl9/+xuPwgSd6zSOhS2Z4IITJ/0z
   Q==;
X-CSE-ConnectionGUID: PXu4uOTvRliagZKyS0O58Q==
X-CSE-MsgGUID: rEagQiz+TPy+GGYzG9Y+Qg==
X-IronPort-AV: E=Sophos;i="6.25,180,1779120000"; 
   d="scan'208";a="152540972"
Received: from mail-northcentralusazon11010038.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.38])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2026 18:05:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlGZrZ/XxMHqksxdOnKTGiJ1xy48XSRIC0I+FSFLO0IsAJnTCFjcW66/QZLlWPZB7cDkADfjrkyUn5sSwvFXBtP4drTwLRnP1r0a+O7udisAvpftsdc1vCRIgktQqyCc8FTVoYelHU05N2en0lo5PpTN/6U/UxQ1/vS21EOsqZsc/sXXbdCDnnOzatqN8SEOSbFJdJLD0yoW2Jy0XVSs+YckHI3Lfbd2sBdyvJ0wCQrq1ke2IxjPAvjkatxruDzLuvH/LMJIJe77GiGdsyXQRMzqfFWIp5epyOaCqsu8rDXA9WLfGZDOhPlhU/Q/m44rSw39sizybiax99OJXWJ5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBKXyk9dgngvm8sxS4jpKsXZ289xJAvJqoXJmfL2cG4=;
 b=rjZCxsfuLll9i0v9SbI67QvytfnYd2IveJuJ0IxtIvwdRnDSub354ueKUCCJpCq0tsQ/Xbmb63DHcIlvTHtbJjtNfE2xbv/M0nLCh/Ekl5U2b0a5Cq7oyFYTuWZ4cGvTbMaARrpy4kS5oUsVcWzeF4BeqFn4FXLC7jGl/TO/xsIS3GpYVqg5dB3Z75Ou1pQyDGsms3C0MoPLbHtAF13wTyVOqgmM0oyr7a65++ow67CfYfsldIggMh61az9/3oTDa+jyb2zj8f5u8E1NBLrWbDv+E4DOoI451lE1DUNuzE9AqnmCRmbhCwwdEdlOvAtzi1Uhsp0CsbKRPMUJBRpDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBKXyk9dgngvm8sxS4jpKsXZ289xJAvJqoXJmfL2cG4=;
 b=oLnQQWm7qGWxug66AfCLPw/ll2nxC4v0LogbZe/X9tB5dEmuRw66UNowD8tz0/kEWvdKLrxHy6gf9MF/lNss+Bj2VOjK3ZmtlM0N8xu4oc1nn6fzhdvpS1YTZgxTaEZAhasM1ZizYoRyHL96ja8hwuSfnCZ3UMMd16qBcrTBqQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CYYPR04MB8792.namprd04.prod.outlook.com
 (2603:10b6:930:cb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:05:17 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:05:16 +0000
Date: Thu, 23 Jul 2026 19:05:11 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, nilay@linux.ibm.com, 
	linux-nvme@lists.infradead.org, dwagner@suse.de, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v5] nvme/069: add a test for multipath cdev lifetime
Message-ID: <amHnLkkhLqIPiMHh@shinhome>
References: <20260720150217.1355223-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720150217.1355223-1-john.g.garry@oracle.com>
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CYYPR04MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 77051473-08bf-411f-21fe-08dee8a1e4e6
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RaHdH5tpenE7BJSZg1Ymm0nAJ6nkDSoh3FXWXCj019bLgvDFWIGISkD13P7fb6cnzPkIUbqEUKtxmF4HUXBmpZ1CMy8R392dPudc/cZGRkTN1Z62nc0CdO0e+daRTUSpv+itDc2hIrgaaVl85xYfT2FgrEz/m6xrJWzgXk/Wg+VyyH/tNfma78/TuHpSYt/huW5ULFnvhp2HUmWpYsmsQpdYy91Q32yFNjrD4V8CECyj145cZR0pQRcmMRTsPqbbxvg5BphApZM9Btobx8GXda9tLSm6nSn/j3dtkoO+mEjJnScV2mxmieIYw1juiOKhLry+nSJtRJ8OB5Oj1wcUciSygHzRI1aiywH4T8SYUd7Lamwjnf56uEj3dtOBokRjbZHgryg5Xt2iyK2vH48EzB6VTFOvf6/apvJZoGcYJOS7VKHT4XqIG03lpDSjUB/5RE/fD7OQYD9cTsan26RYIgs9cvQ78SifKvid8qHa5/vAPPVUxNfu/cULMvZmmouW1ssYQCB3G0Ey2ud0cvlbpGhlzsK7QE5PB7PUj5Wabb5qdEOguoOMQal5rnrSLskk6jYQFu8d343heIjuhySSuKeGfUZX3fLwOIKbisqaGx45bAguJqB+7q+Wm/bT0AvertxVSx5gBlej5aNOUH9tpLtVetS5ZxbZnqNcovZJJEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIBhAYZmmPKpymOQATQkrc+aqf2C7qJIOk4fitofkjK+IE2SoGK2Crv/Wyga?=
 =?us-ascii?Q?5XWjYRgzGM8IAJ+XXp6Bv9b1NSTF/7kRh7CCgk5TWBxEglwDjp075AelR3pe?=
 =?us-ascii?Q?YZ1bGMLeSLLOw9SrN3EevRPSRQI/aBioBasf8x6qxKFlDZUPaV6TJfsJVYR6?=
 =?us-ascii?Q?giWvZP6UrT+7OOLkkiYiDi7Gxd2d+lWW2uUeajaaoTfaxieUNRnvhTnnRA8Y?=
 =?us-ascii?Q?AmqYGfPOSKns0aHXMkv/YgQtru9PBNekqNokFulBsdXTyU4kqPwxTwSQuLJ/?=
 =?us-ascii?Q?nS8TalWYqTUfuZiibl6DlxkdvR93lkcJ95EqFowVVrmrTiINxCPftzxT2Y3m?=
 =?us-ascii?Q?Px4URXPW05WppvWab38gMyMmdvvkWqQLRWl/Dw47lSrCrgNn87WQnNw/K04m?=
 =?us-ascii?Q?Ietv6+OXjl3lB3zuMHUYqGoWX47h8Ld0d5JhFZxvt35orFewjzBbYDjxxrRt?=
 =?us-ascii?Q?L6yON2jhpXWEyCCuIw1lcTqhTSr5/5zQB9pDSFe71c6jewKjUaEP5QxzXsM3?=
 =?us-ascii?Q?YJlD45Ce9LvoD4pD+Uly1gcFWK3MVPwPIxc0PMueDlX5gU2fjLFuaaBFgand?=
 =?us-ascii?Q?N3F8lJvdb8JJiwr2YvC7aQjh2PQWW17jYt4jot/yLNJyGw2ks1TmyzZMLbo0?=
 =?us-ascii?Q?2FStJzcDCjqlfyXjHXn4yEnWC95f0sh79DaSvxIAGH+Opb2AAVLk/9gnmHO3?=
 =?us-ascii?Q?GI++Mm2TR+9FGCCLNl16+G6dFH27v8+EVirTkeDb2jPjriWoBwVW/LmdDaU3?=
 =?us-ascii?Q?eEV1yA4cswK8fo2BIzTtzWDTthxaR+5xQmVb6qUFI0tEZgRW8XFdMlLd8de/?=
 =?us-ascii?Q?bkmxzJhC/ifH6vvKBltdAMmEF7EtWFi2JitQaBP5kLmetuIiW3f9XITPAzz6?=
 =?us-ascii?Q?MU8/gGYSX/9BOOq7fERdXrw6xEvPwdhOuKl5ZMJ05eXbjzUA9vNPl31Wfkum?=
 =?us-ascii?Q?c3pqQsmx9Eg9bDvVPFNmUZINLf4FEacRo2N7eB3b0ogHYA08TmQlFCpLfHzk?=
 =?us-ascii?Q?Vz15aDc/DK1xJI82xjqd9ehAfEFq30iqzlmZQejYp2woZcU+dNqMDR6JFn7K?=
 =?us-ascii?Q?loZX54zy611YQuUbDzap6cR5s5689aNg/HyyfmsqPZTUcQB07IAT86GL9VPq?=
 =?us-ascii?Q?yffvMmGghRTcsNW2K08n/1lxh+AWerDk5mISChOwml8vt0L52bVFeOh/j+3v?=
 =?us-ascii?Q?lAb8lF3QMUYLCNK9zR/HSM4JdF8D3BPa0N6P4cL/u+ql7xDap00Gxobp5Ovq?=
 =?us-ascii?Q?1PFIQPW55tE4bg1tRQ/LwvGz7tneDf+nZvWn4jWcUAJdYOco5DqZqGMQz5Ps?=
 =?us-ascii?Q?8p8W+nhmP7eHUfUUrd6IFTnuiztE/kljboFRXll0rwVY+vv/BJICiOPiCn6l?=
 =?us-ascii?Q?19/miyzLYtlW//vf+osTzVnIJ/30OBVUA1MXnbz52HYjCUNMcUrMHNDddI3+?=
 =?us-ascii?Q?y+EONqznHHKCXmUwyJ1uMHoCHLe9XfHC3lHpKaNqwNQq8IonbAWRMSbD3w2R?=
 =?us-ascii?Q?hSnjg3yyl3JPdOiyqzvuyo0OGBXVg+d3w6ZWxtJc8joi8L/Kr5exrqI6lfMu?=
 =?us-ascii?Q?IOKu0Y7Pmj90uMmwRFEBnZzb6uCb4dVFdJw0b+JgdyParwHxWxCkZo/S2mbI?=
 =?us-ascii?Q?evEok4/n/ep003mjY6hT0A4JljiFGrQlMid20vtljD9dFFRV0rCa+AXSwxRz?=
 =?us-ascii?Q?m27Dju+4E3tso8N8ZAZPsuDiKhN5LtvpoZiw0oK3xE7pYJn8ALiryfQ7Lmmm?=
 =?us-ascii?Q?TTsagPIJX5lZICPvo9LPpFrfpgLV6uE=3D?=
X-Exchange-RoutingPolicyChecked:
	mhOrBrvbJHYYp330Anhk00Zv5pAn0zqz5l+XvCGqSF6+cyZ/+lHCCKmnntMaskzfZ+bODMMzzWrKh0VaEINTIAU/85nhCgQBdq2QJfFRvykLjdEPZmQ3YAsfIcrcBUOO+reSnHSugupyaBcf068CuE3d3QoYVpvRX5pvTp52ZgooKvvWdkeRuNbOHGwA0EQneo57Grd3rmC0e9NBOB+FTLjxl522ThGU/vNYDC2AP8VsYjiA6UG5UD7cqJojtTAPjL+PzdNtzWZVKJ/NS/QH/p5rPbTYVk0JExrtRDaUmVt09hfoEZ7b22nU/ScX4fuUCbC78KJpYSeQ53FWyVvQag==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	faEJM3W6P48ddBfvOxkBo8lzYxymvAR8qrG0xbtqV8NQ/HYldIJHX4Fv+64WZwpl4Ev0F2HvYdpsTbhGrv+Dbrc8ls5ZU8sbdN/Vv2qKr+p904LYiEKKbMVidP0rS7HGB/rwSInRbUej/al/+TAVLE7NB2toMyMzIrH5TRwG3+K2CEEI3jtLGDQq6bJ/kvcCtPwWXVQZ/L0yed9tM5e65BZKESgCkvkQJZ/8FfeKRaMiO5AAtD8cf1nU/8+m1PXkM34syYz2CGmwaPxKffXCNux+c61mMMu1omxuTgUDP4Y4P6slXzix28KZrzVZ3rpVXWQ7zt+Tkie9VwZl5tK5WVZsKGFxN6fgN2+OP2MnbyjclaZOjimocFxGE1S4+KMav3IQMGMWnll0LtCa1bQZ8Fnkn85lAriyLb0Xo+H3pcmGWUaeSDPdLdtq8UJLqAn5kr6GjQzcbfFTck9czBWillX/Y3slJOQD9356nGYLh2SxS7BFZLsiiY6f70yfSjBNRWUEXs3FJWWrpe4nCuZKvm36R0PcuRYbN1OXF2327sdZ3NP2o+OwQGsFzxo3q6HyB9UCAAiokmATAEloAo9ZvhzFEgrd+dWgG3ISqmiOJFWdANB/8SLif3E5pHpOjgTe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77051473-08bf-411f-21fe-08dee8a1e4e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:05:16.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUVV5oFsF0iE0/L2jsFqAG5s3oav4oHA4TOFDWkn5LZD413fBKNenibxoV/trIN0JvC0SWnVd+bcQsx0ykDQl6b4qWBClavl8HauRmVSYGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8792

On Jul 20, 2026 / 15:02, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> In [0], a fix was proposed for the NS and NS head (multipath) cdev
> lifetime.
> 
> The issue was that fds for the nvme-generic cdev may exist after we tear
> down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
> use-after-free.
> 
> This test recreates the method described in [0] to expose this issue
> for NS head cdev.
> 
> First a fd is created by opening the nvme-generic cdev. Next we tear down
> the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
> the kernel fix in [0], this should trigger a KASAN warn.
> 
> [0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I applied the patch. Thanks!
