Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8A3BFAEE;
	Fri, 18 Sep 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700165; cv=fail; b=QLkw7RlTsuFesTA3nObjUqr8udS6o4mHDqjZPAHpBCFikM22uegKiMb82Kdy8zvKpkGgHbqlGQKXz0fBZE18ubyPNBmzoA1a2/B099lMK3K5g8mCmUGdSgN0UhNu527o9SmKz5R1e2n7vUBKt/IMO3H8Qw/xgP1I5+SIsTrEGz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700165; c=relaxed/simple;
	bh=PZsrflgefGTzSEAKmCaPmbV+aRDGIhrq2TAfp4TuBaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ldZRZzTyjFMhiYC9n5ZuEcfEN/mtkNiEHAf9WqTzFBwMBqchmKrGoXoYCcjMtz+fsbEQyG4g0dFMSwWPnWTnzI0mzBBJcYIRhxSXDhW2asCK2/IcK8IUJobvBgzkfUAc3d31DVb1OpVAJQTutJUaXL3Pz8qgeQZHp6jybvq46js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qS847oFx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DM+alafH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qS847oFx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DM+alafH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789700167; x=1821236167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PZsrflgefGTzSEAKmCaPmbV+aRDGIhrq2TAfp4TuBaU=;
  b=qS847oFxMxlK93QzLW8+hsMMgbc7P+unF+i3WQ1OoBMe76FOYIhNqSBx
   dYMV60cdmuK71tSW4ohaVeZoR8fgwFs8vJPhzLKgWMeAjMLWLMVBlucJH
   hKfiFdi1p5sx4sU+wKelg1OtaD4yElLMyqI6qoMMX0jayLly/laE6ZkO5
   /oBOjCeEEdZ4+egV2IEos1fMPhljTRH20/JrHzz61UYmdegc2IXaomZGJ
   886T7ycpbRk0zSkA8hrGUA8qMA0lH3P/Xe32tTSjeqrceOUMcYKfD/jUC
   4rhYl5hXKURsorjrOyEeGsDlIzIUJ+B9RfPgntgnfWeUsRI8H5m64LvLw
   w==;
X-CSE-ConnectionGUID: Ww6IlgieTEq0wj/1xK9R8w==
X-CSE-MsgGUID: c9LVi0hdR7Sv4iXGz2xvvA==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="156891238"
Received: from mail-eastus2azon11010069.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 10:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjt6Zi1r/8nNsKiNNv37zDaTjKHb3y1lmd1XhIYgTZ9GwB1vNMThKWx+9K3OLBYM6dnw8l045o9jeDRaakL3HRif7vx5ZI/6icK9HkJ/I7+b6hOnk/5X3QjncxpQrY0YVVyFHFr8YQG7xSL/iL5Mb1OV37heTeeEcJffIxOpqleKl9DIlOtAMrfqBkG5IeEZ6lKFsf6v0AHJV5hmNnNEl2kXuzCo4IbRyWM8+ML5L+FSJzQJStDNBctSmzOblqjiQBDtNyHUt62Lc7ZqwKuzJznZqaZgZh0vrR+lF73zH6bnTvJuJHB+XI+0Va1NKeEpwdFAlVZKAzmlChuwRxHH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5z/630XPUZ/BFi+x4eMMc7UYkejYRaOORI9GXCCffU=;
 b=bGd3X7i9SCVia4MGbYsvNmJ6BNRwoofcgJmuHlxxk75XW2hV90VRJ/yk3AV9su2PcVW01XBi9aRPPYRmNFLIHpLFSPlnfQvIEq12eQ+iehX7NWCikMXkw+1jExRN8dWjZiB1l2//YwF1qlUKktGJqwK1sVUa6wrGxhbWCrDdQ3WrF8JQJRmymIucLJ4gSQO03AVX0rmZHiuHGnFIxweciXY2Kuuy1edDwJquUaAfr0ul7l6yKgYdkbKAx7jb6ymmfRpyz5Hb0nVJQN5Q2uufAbA60fVo98lJgVcj8JPnifNm7vdoPrLrPLeZ111vp9Yh7NKLbZ/XH9p9E0psU/wHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5z/630XPUZ/BFi+x4eMMc7UYkejYRaOORI9GXCCffU=;
 b=DM+alafH+VUZRHgOXE+Y+EYcMHpfQAvEg/a3LYIuzVHqywTWxMJfFk5LXwsDR6b7R+22+JZxuKUy5pe+vQlTnMoA1oSPPN2If98fTP39klp70bF10Y0F5G9PRSxVo4zdWuTWfTNesfHRpmxpVBFv4P/8iEVuxkVsEjEUx1nlyHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH8PR04MB994023.namprd04.prod.outlook.com
 (2603:10b6:610:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:55:58 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 02:55:58 +0000
Date: Fri, 18 Sep 2026 11:55:50 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Hannes Reinecke <hare@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	John Garry <john.g.garry@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 2/7] block: take i_rwsem for the direct I/O write
 fallback
Message-ID: <aqynM1cSQbjXCMjT@shinmob>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-2-1a5222c6e8ad@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-v3-2-1a5222c6e8ad@columbia.edu>
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH8PR04MB994023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0bf865-77cb-452d-7298-08df15305d64
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|19092799006|4143699003|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	r9VPfB3/55AZyzD7rXQTH9nROyTl9b2fooij8J7CQz+vQ/Op+igBQQd4EVlmWhz38Lga0Rxqc2m6l1NdWNvlhhLLupKUOW+kZxZwy8k/W7W+n5MG4oZFJ1uXOjkBDh2jXbMxxE/3wxdom2I16ZfpjcW7n2g8gpfrYnT8FRYF6OjzvRoXNwQCPoXI2zWQAa894vusHLYQ1aqrSnUwEjbaq+SiLeYheUHZCmqrSJK+OpKDCyIE7EElLmu68NzvnLUQY/q3O/d3BVuY/syo3PnOT18+muFL2TarLOJWWnVREkWJFdV568V7ih2MFC7NbEESkkEjGsyR3QykFOagyThanZsWuw8BMu44WjqKDGDLyTkTFGtWtDJNBS4Mb+J9Z4B8tsWawsK+OpLtz9ePv8VGUDHYqtgcebHnUtHbxIuLXFsMW6fBgPQ3sEqpUM65sQXL4uZ7/hcEhvK7QaO5S8WUoAOlDkcfz1R6+Cuo1mqfJs//URofl1iyTw3+/DdoEsaurwWiXR/O5vsMuiUmYr+Zi82VqCU8ALWL8KcsGXxl9EUpDuVBJUmch5562onJHO7t51ssVMYqwf9Dc/1/l2Yj7xP/HlqeojLcpp/1zJRSw/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(19092799006)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13YJf8MuSv2+kGmXHpXGFSS/EGWBFz8QkWoXGtFQxGw2+sQv3WVI/P45/4Ga?=
 =?us-ascii?Q?94urPzrXUADtljAxtgA2j/2sYVJhDajgJdm7sKl5wP2UO+5ANEPIyIk6LuoN?=
 =?us-ascii?Q?/Smqof43BdMsIYWSUGPnqNtZsLjzSWxp+7oNEV1SMHMm9GSCkavlqXyIyXcF?=
 =?us-ascii?Q?QKkpYQZAU4F1Coc9dTclJKsLi1OQ8q34UAwGdXsVpaj34OQ8IfIrdditBN21?=
 =?us-ascii?Q?qiYOHEqAVMU6kqBGPCGPxtx/84xV9KukSoAv9ChO4k2Drqr9dGU2YYEu3ZPr?=
 =?us-ascii?Q?7fmt4DyOrCoRl8yyLBtTozxgme7f1K+ukP/pL2e1xUWgiu8cvEYMjRhtkVpS?=
 =?us-ascii?Q?QmpMDPN423qotsBPyhtVq1HP5UfVSsqsuI6AL12CJ15s1VpVsgFO9Cr6ylKw?=
 =?us-ascii?Q?RwpwkSzfBP4BTRVaHb4KsIz5yINizHOweQOJKRTt6eXup/509PxJRWjW2sdl?=
 =?us-ascii?Q?ml2kQi9eiJAxwlPepd8ckFPi5fv8RKEwY5u8chiTU8CQQ+4WBbQTdDAf2vz8?=
 =?us-ascii?Q?FTVeMBxKbwoDZs2YkkTpYaDMYU+n5ToGqnlasZWEhdV+Q6205TuAP5a3UHZb?=
 =?us-ascii?Q?9SyM5IICj8zmmOHxlPItF7mpUuvJVIkrLKv50Hx8oxedCFIm7Q3EKmztOR7a?=
 =?us-ascii?Q?xOibqXuVuYx4Ng/a9CCPpriSCL+KsH3k16nV+2gafx0qWq0oAsRSF63OO6Rn?=
 =?us-ascii?Q?smmkiciUGl+dwIYNnif8WlCcnU52Z/5jgrz8G/1kBmpBlTkpRmbmX3n9vy0/?=
 =?us-ascii?Q?2k3rmbT/5Q2GDamJ3kUjN6u6ukMWMD1I1kIeP5pdfA2MlT/Ws22R/Zd0sZuc?=
 =?us-ascii?Q?mxd9ZNzAcM4CrU2igc3HakpvvZZ4FcaIHSo2xzVc4rkziJoDeAPDQ3/5RH8s?=
 =?us-ascii?Q?7QoBGT3Hl12OCEdO+WkCPLySK4xzYS1psXOy1pIegyk3tjL/aRkgdwCkpB6V?=
 =?us-ascii?Q?HYsmAOhfY50oPZMHtg/U+cJy7B1D0CHE/grB5K9QVb2AywLCID6V0iG0Hpnw?=
 =?us-ascii?Q?YOBVE6GsTCiypiJdYmGtbe56rEOxfAfjoQxvLGV1HhzBBGiXbGljAtthFvsE?=
 =?us-ascii?Q?TWO0ErvOea/umF0PJTD4VYCfHNtaBN/cCGIrgcTc5wNAYkACBZDm5ZAXPeNT?=
 =?us-ascii?Q?7gG+gOmVISSJKHptkjtHeyy6OUAguYLBeFt25naytcQ6SH2OiA0cRWVLXapd?=
 =?us-ascii?Q?2Kva6NPkckISNhyFe8j+ZSFvmOxreC83KM1x5kdTxFfTYsEWGaRELYkmeQJe?=
 =?us-ascii?Q?QiRzKxM+PKg5UYY2X6cDL1OLoLyi+2QXmToEgTdgZEUNLy9zHiletbxr3ZOy?=
 =?us-ascii?Q?hJCu8xB8ccgmWqbu6H3lZBOttBpnZyDmzXu0jWDom3fVz7fEBOyn8+dn4CmT?=
 =?us-ascii?Q?SRLW3L9BBr+R0U1hsO8Pzr/zxY4SdT9jSk5PKh5kN2tbmraXotfLWZk2Qhls?=
 =?us-ascii?Q?pK3pA/ciY7kx6SIxwI9mjGKwtPfoUp0vpp27yNvTMTJub7F5LpRoGSrLhjtj?=
 =?us-ascii?Q?RQVemIHOqvRWWrwVTKy6vooe+9iVTB6AR9c+9dpLL99BBhZv184FPObsDBLF?=
 =?us-ascii?Q?l9wxJSnMK//PcJ2NSgqU51q8QJb4n9rj0+z8TvMsQwamMkpBi695fwe4xndU?=
 =?us-ascii?Q?jglBysbEmjBOj0d3kCeKzgGi03U6CJuJeYl/oXFI1NXKNXx0Gu73MxYykmdE?=
 =?us-ascii?Q?XTifB0/4fIhc610Moru+CZ7z5IO44HM7tDiRKUMgC4PX1vfb4llgvzZSz9/s?=
 =?us-ascii?Q?+VjriEPcVZdveRVP8RCXhAUUd+ziZNk=3D?=
X-Exchange-RoutingPolicyChecked:
	V/L+2sB3Hlq6+rWnrqwnu6+t1d8Yk8vHVAHJ7ky7SwNOE+k+N5SXjg8MnxgTS5bZIUICvNjbKoUxsZPPYgKib4tVbrNlhVutTKeIQ+OYi3v+iNNYLCNSODrmVTvdAcUjkVLm7jwEe7HWDGap0VbZn96LNJjV1zHbgMGoNhC8SZvf9b7sB9XqiKBhYoeXy1g81AjU/tql+p5l1LTvo1EhiusVRAwqeg0Zo2bF/jPd9XgmN+MqLcG4J1Nrkb46NnlmnAOjZ9RwHDVPnDKC+mdNixGtFaNdgtoDtnpwIkyWQUuUPsG911oC6/Fxzu8pugPVkb2ek+TA7MuiZTE2U+Vdow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tK/wNHEyJS4hIIwL++kJ4LQrvHur7G0W9k8eoIfQaCCc0n28OZihoKq/mj2VeTWnL9xEgtDprc+YzIjxgf5rY/+av7MlRPZ+SvuPrFr+YHfIbjlz2kvTi03HOuAjCu1i86ByN3YUNm8kcrf9amL7+N5jeZN3/oz66dtnTnTlywaD+DcpvFpypfTRwCAj3DtR3LBkPdIzLSnpae4qBiJBuxbXxFBhFfl7LvQnKXJdtILkwe48yZJLQm9f9Y2t5ILgV6yDCkWrtRgIxuJapMfMVdH6zZ/zxhmeJj3pf1UX3HqZOe+C4bFXVqQkiUOiLxEKN3f9j/VMqXRjWp42KB34yWl8F45PD38lXFLlx8Ae0q+tB1OuT3XyHazP7ejnlfzIZ7btodJCP4+xER32ET29U411tPE22zwqBAAfCjOPQaVBR3OH71RRAMYMWBvWhFqKg+6NWonl7K6XxF7uadFb7kcGJsIwVn67VFjCAgr61aY1lvlNKT+GMEAmTqZ+sdQpXVUGuUMAsdvdHlorZk34GDZaDdij7NA84/Ejiedy76acD2OiXE7RXa/1tfrfMrt1bmkST993Pk1habkbOkrlhC36W5+HrVl+cuYRRXkYruf4126JcdB3cSE80ivAk5so
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0bf865-77cb-452d-7298-08df15305d64
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:55:58.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOylpkn/0dwLtsyzKshHUdA6lM5pQcqztDcwbhev3QDeQSSH7MJZsJ//rYP2WJ9l5pMTd0grtVnLp7qcPY99HUBIkq7NbkeQeH0SCTChcvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB994023

On Sep 09, 2026 / 17:59, Tal Zussman wrote:
> Commit c0e473a0d226 ("block: fix race between set_blocksize and read
> paths") closed a race between set_blocksize() and block device I/O: with
> large sector size support, set_blocksize() can change i_blkbits and the
> mapping's minimum folio order while a concurrent reader still holds a
> folio of the old, smaller order, leading to crashes. In particular, it
> made blkdev_write_iter() wrap buffered writes in inode_lock_shared().
> 
> However, the direct I/O fallback path was missed in that conversion.
> blkdev_write_iter() passes blkdev_buffered_write() as an argument to
> direct_write_fallback() with no lock held. A direct write that completes
> only partially then finishes as a buffered write with no protection.

[...]

> Fix this by calling blkdev_buffered_write() in the fallback path under
> inode_lock_shared(), matching the plain buffered-write branch. With the
> fix the same workload runs clean.
> 
> A short IOCB_NOWAIT direct write reaches the same fallback. Taking
> i_rwsem there can now block behind set_blocksize(), and the fallback
> already blocks on writeback of the data it copied in
> direct_write_fallback(). blkdev_write_iter() already rejects a purely
> buffered IOCB_NOWAIT write with -EOPNOTSUPP, so do not enter the
> fallback for IOCB_NOWAIT at all: return the bytes the direct path
> already wrote, or -EAGAIN if none, and let the caller retry.
> 
> The reproducer used was written by an LLM, and is available at [1].
> 
> [1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74
> 
> Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
> Assisted-by: Claude:claude-fable-5
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

I confirmed that this patch avoids the hang triggered by the corresponding, new
blktests test case [*].

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-tests-v1-1-1f8af8665d16@columbia.edu/
