Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492562;
	b=bDaqkZY2Kdxw+15XsufK5vYxox10Spx58mdhrxKWJ91iOrkjluph2FfWQ45hP2zdH0mJ
	 umrRkVC4zsQfTZwi2QoKMnqiuL+TxYjvmQeuRcaBnWRPibQ6tm7tiDkXP86/Q26wOlCwi
	 1eDgc4J8TdOS86tJnp9K5PnHQkwUZlMq2IDIOY6UaBV+oauOeFQiDQIq6tj4CsDhKpkL9
	 C3zpxNYC3mmcg9RqW8akuzRC67/jCV+xAsLE3VZsiQFgSKqaBTCSZ1N1O5lzQxVKcf212
	 13SPcvP5ucOYxjCl70ElXQrT0ef6CFr52+dszg28RNY8gLXbHYbrxU7HHUBkQpjxqnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492562;
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
	bh=z/Z218I27m19t9T9AwwJwd3nFOF72ibiHeUFPcgilMc=;
	b=awkbrdrMnCPtVFsK2gQAyIZqqN+JJ+UW10ZXowT17mx4fxi+a+Oa/cYAEKwkahG1JrT3
	 Z24x6OfOGwOx4eKBzx4yVjxIh0Q7USGLrwRnib0vjy4O87YtA9rLH6K9bySq43bN9PlcO
	 SH67l9jKc7EVQkKUG5rKkH/RZzELWpG9GS6TWFIObTG6xTfljFe9evHIslh4YTRnUqLiv
	 9GNu6HoaNx+045RW54ry24n/tBE68j8xp8suatRDOwtBIzbOhjjQDEbfw/QX0JERLm4Xy
	 J5iPJ/jFhc60N5JsbdaRh6YudZN1cclKYJN0zwsEEif9c4V5ETrxJh0PhMC44j19j3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bG57M7Jw;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Z4fQHkcK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06960606A31D
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 10:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06960606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bG57M7Jw;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Z4fQHkcK
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792492561; x=1824028561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ezx3QE1izDKhRL06yq/DXQSjbO3CPBiKejjOWHx3unY=;
  b=bG57M7JwMK6zPtHtRZfzs5qwIQezlNkwGB/xr2zEvsqCamdIGm0Ifbgw
   vWvPJifmDFJLAzRw2zHksFKgusEJWHbdIxLl7sEjQiHDuCGH7U7anEXTl
   54Tce1GeNJMRyPMm+hHwomktB5FczKx2yupIAvKg1/duUTgxkR/T8xKYg
   ZCzE62N46B4ViG2FRpXA0pLDbvThJA0KwwdRo7AUmBkQSFHAy9uphidwp
   20gh3MVoZwWCRInOa4yII86n5uA2jX0rc9Mke6baS6YK4wd+UhBS/So8a
   N1EJUOJTdSQDscKVyjiyo/rHCrgRMr3FFx9NE1DPlfOT06V1xwkZXD+X2
   Q==;
X-CSE-ConnectionGUID: xnYtQ11sSKac11FIuDNRFA==
X-CSE-MsgGUID: kYfaW1AZQN6zIAvyZiNy8w==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="157580457"
Received: from mail-westus2azon11012038.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.38])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 18:36:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ3wHVlAH9BLhtibI902c1qAmTzUxrMRuRQJa8Zz8EUA7LZ+zX4mf6HFKv6w8hGQg+w4Kf633Rf1MI2K17UsjfPOHSfGtqIC8o53BRhkJ5+GawheaO66SNkMbW4ElAhF19iXH9HnpvysmxIy8Lby4pk6GKRarL7g8RKLenWQ9gc+rU/IHTsODi107UZIHwG1iq7Ga0AQZRW9svUOGmmA5nfvGPHHtIqn03arnzr51BCL7ry5ynxk/GZocgnVBH9TuaiPckB3nJCwj9bdu38qPMCzLWYZblMbP7SZJtTUomt0jQltlANG9icdN5y7aDhrQ7E7/+F983LoQLw65YXLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Z218I27m19t9T9AwwJwd3nFOF72ibiHeUFPcgilMc=;
 b=mdz/VG7ph0+x0NMdLBlefuU4ADHnFY0yi1vbBFHYbPwAjyK9OatOjT+G5HdQgrR5I0xEEvKTFgB4WKNRW1HIXUiMMrn/WUdI/NTVfLVNjTeWjOZRO8tsLSMIMpc/BdIbrwbCcffNDw9VoMANnOF1B+8Z74RoMy4sxoF7sscFuHSOvJGW5bFpJqOnsUXtKe/M6mvwXDgs4DkDkIzWGRvlrGI6rIyFZlckxuk4xcl71NGKTFrrjAzcjfKF2ZGdoKL5kSI9xizw/rzNjO7va2kvTULNekLhKO6X4KakAW6mxAUFiRwAvCz6qiNQkz90Xd5uVwZkcDsjKSdoNX67U7aZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Z218I27m19t9T9AwwJwd3nFOF72ibiHeUFPcgilMc=;
 b=Z4fQHkcKTxNonM+ZUWwYqMyI1umfiir7OhEgBSvY1jGHFQm/nHgtcTcYKti4n1758tS9pt/8TAriN9fKH0GYIUnJklLXFfMXI1EkoQUhSKchbuHfAKfRGhpBOpTsMtDqLrcagjXJsz4AJRTR7T713/zWt2GiE9uK2xR8boq/Edg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7513.namprd04.prod.outlook.com
 (2603:10b6:806:147::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:35:59 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:35:59 +0000
Date: Tue, 20 Oct 2026 19:35:53 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 2/4] nvme/071: test that nvmet sends no data for
 a failed read
Message-ID: <atdDDxISK3i_5uQX@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
 <20261014170046.2516-3-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014170046.2516-3-parri.andrea@gmail.com>
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffbae90-4052-42a7-97f4-08df2e95ee17
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|3023799007|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bFS3fW0/JicDTz9zaYJKp2JZyPcv/00LlZpA7Y7stSvWexpwedbUuatLdfMK/twckTCMCgo42qPCMynutzIzMSeRH3ntBBZGONVSH9gCE8vEU6m+XKzO8qENNASh4i5Phu+6w1qv0Eey8tN9o+Cy+MFFFYBzRbqHqpH1r0ZZcerRY2xSEJukwH7CG+DGkAswNSqgkyIL2tNjZVgrhNK4lWpt15Je8Os83isz5ZCDv6RUd8uqbd3suVpdkyzapuUN+8il6L2tXDpmqzM2JEVxLhpO0qrA2nJiaq1N/ltFBtYkXZP9elAerXa5KTZrID7D8+MeF02JYGjZ/PCswrH1uC+jPa38UubLe1rfwoAGcSXYH7QbBFejG9NdXxAUb984qFvZThLJ596h3zjaDATfKY3X2iccJD0vL7mybyYXqyF9iFE7S9+gHepPXJAFWAf8wK6sA/NZFBUJ3pX++nIMHbK2pmZyxbAdcyaCi7HrPWucvialpzUwK2LbbAJeuYSiWMAKxvhRn3AWLqeEs1PhONeBCPfwc2ss9L1+F4CvAhwEuNA5pZSYVAQUYoh8NHX8GW15pdT2PWlW3jFJTHoTIm141BumEt0KP+JSt3ss/GvyWqrBHzFsap9p1hS6sSqq3gp1jqbYalLn8G0SFeyubXPkd6eJ9KIzq5nqk9AsFIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(3023799007)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXvd+Uv7fY+FwiFH0enApKsS6y+jDpMFCynGde5qLhBHW+1G5w2luamwXHLz?=
 =?us-ascii?Q?rW1n6nld3ak+zfp2rfWrafY4PZawNH1H487T5xKOePq57qhU97lhOkDI1cHG?=
 =?us-ascii?Q?mKAZazydgip6K5DtaqNNu5gT/AdCsmPR0Tv/Spsyt0l6tqqMUEj7hd+KjSeu?=
 =?us-ascii?Q?q1Y2S/8QzMWgfVYfX/+bWetdCoimOZszHl1GEsNeOJI6SRxkx0t+Gm0dnwAM?=
 =?us-ascii?Q?pINa0p+S2LgS4+kl2ByMA77q+fsIdG7jkFYbrnzBOv6yWSAIG74/VROs2ij6?=
 =?us-ascii?Q?ypSnaVWpfGI3UuCt9n6WziSZGjfsmNWjq8NKT4KgROSyCB9D3Qq9+/FabTLd?=
 =?us-ascii?Q?2M7NMs8/pTIDxuviInE9z7c9XMfJ2bPcyBOhUkvpA5oO186QHtr1PeFjxngQ?=
 =?us-ascii?Q?ibFw42Ll7WQc1/4F8j0pnv20iKta1XmDO7UC0riX6uq87w2rRaHusTRunyIT?=
 =?us-ascii?Q?xlZdqV744724Z6ybLHhGDE4r7JkbJBTs3Kcggs/i8qMP4Eced8cP72N26I+X?=
 =?us-ascii?Q?yOhYl/8pbzoTMTyKeZqFfiZYTl5CGGZJ3UGfw41OFrvu0LxavhD61MIgH+6F?=
 =?us-ascii?Q?4+jGu6WoQj7kAcM1HRWeYT2CM+wQcjK15L1hcg/N/QznscBJHYQqAEz5LWZy?=
 =?us-ascii?Q?SZPcIrtPcvtylk8KQFaIzeoD61kRHCCaIS0CVJIXNc61z9cFWX3uMIfnQUVb?=
 =?us-ascii?Q?DXyufuzd1Dg5+HIohRPdex5oKSkcnvKfGhaLD0jkM5nbZM8bDlYzVbDCYuRv?=
 =?us-ascii?Q?/ucVnwb0NrrD27hQ0o3d37/FO4rc3gLgo4uHMxwYUpsQoSUEI1qfqmydgb/J?=
 =?us-ascii?Q?Fm1/rlcnolhJnz0T1SbapablwEqD0R9qHXL91y9jqzceYs61n1RjDWyYG86K?=
 =?us-ascii?Q?nIL2To/62G45QscpZjVg79GU1lxGmTCnefjgKrHtDgpla002XwU9h3G33m6X?=
 =?us-ascii?Q?1aZJvfKcoUCqwlEsQRawISCdLtytWhIsClldFkjnxs3evYxcavWSZKNHiKtu?=
 =?us-ascii?Q?NhdvAAnvO/3DqExAy60RlChvU8ifqWb/ylSD/8eGP1n/eRqmC1V2NnFwsk8K?=
 =?us-ascii?Q?L6Ei5gdT3GzfnnuK+W2+fXfjBN9olPvwju35UvbGk0PchA9XeHXh6cRD+1fQ?=
 =?us-ascii?Q?votupkzCY1X110SeT3ZE4SGjeG2cyJmlXuSHjR13DK1LXRdZXRUBHy3YyFJw?=
 =?us-ascii?Q?PL+PIjaNw3RBxUwyBkyN0xKUuVHB+nfbCeLevRaxB7TqY2TCLucSGMgbhEvi?=
 =?us-ascii?Q?f8VEgd67GeWNYMVFmecmmi2dkO6q4ciG66upEp5byc81Yelbbbv32eBy54tw?=
 =?us-ascii?Q?odKUqJWS0Qk7GkQinbN/3zRkkn+ElGmowchym39hzabv9fRULmHmhhaJqSHy?=
 =?us-ascii?Q?yfdAQQKF5865oHI39C6kj7GH+2AP/+OiYkktxUkWdllXVbQkAks1ySgC1BRm?=
 =?us-ascii?Q?x/H4b0rDJ/vH0tyxhKtbjsp1Ik2voXZECRvcMCLjFKzAKVXwyhf09IbL1NTe?=
 =?us-ascii?Q?2T72wnwCPuq/D2niLmhTuVP5nILI4orzObEcsGxBoViqdpPp5o0dP7IVVwuQ?=
 =?us-ascii?Q?aau+jA/SNEkgtEHoCxKXNt2Yo9dL6g2X3m/xSkverxNmjo2g9q4My0+J3e56?=
 =?us-ascii?Q?crGQfYME9qbmT7o/x8JN1LbQKsBkf7xY209u59GlobscPEzsA+Y+p340vpTN?=
 =?us-ascii?Q?6OQ+i/cN4bklBVDH7V2VntgKv+s8klyo1sDbfc93FIFJwgRHpNXnUvMH4KlF?=
 =?us-ascii?Q?UDAMRbLc/1Fs2MibPeCxVzfZfarYjNs=3D?=
X-Exchange-RoutingPolicyChecked:
	H6pb1bSlCg7dI4i/th0HHMPiQGxS4HubLRcjDcJRcoNRKXBel2bVN+Rk7UZGE19c8oj2N9J9UDEK6nWwYsZgSsiFgNxWwZ2f/9Obuj3ZMAeB9znqcKmbl/u1Izx6rKS2nzTSZV1xVBRgBlaPg/vLHcKogEZeEusmt4gtYhhmxpf4pVpvB8v878iIDF34m0FymAQSeRxF1c+mTznc8i5gQ84nqR3BjmfMBtUxUngYrJoky7Q6m/MAFXBSNQUmoFMmm8bCn3dT21OrgyHGzGAZZo43+fYFleQGo7jyJQIcnh1x+YCVf2yvVw0mZNElWUerG+uZ9WkZjMgoMOHpYaFonw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zLPmlne5AmjsfRe/tw0JHnckqb0Z7Mf9L8Vlt0EfFjTuSkalqbWyowZ/oTM2a1GiVRskrfwA2/yPPaQrzt30dYbTfQA7kuZnHnTWrxVIaLy6EYot2G8EqQ/j/seu9+U0Nr2WtKI0Bh1lLrCd0hEWHBBOQj+Nhc6tobjSt4/bo5eKwBgkGDvsHQdoSk8G/661yBkT3VlTE14/LoVdMVzV3rUrOzmgD04A9LvpmyK+BuJfPR05TSeae52GNsgYafLQXBSjehAhbUPQ2EXvNKpZeP8Es6S5IFFELxYYlnyYZA7hMAtBCUzxlikQD8eWruhwKRGOXQ0LRlbdNJwBZJZk4iRnHdU4WDZCNm0jyp+2hT4ZpTp5AKnub+00F1mqubQfgx8E54gZE3lGnqGhwrulfbqrF2tbrj9YYt94hUpetOj/WnDHACMua4JRsvJlk8ZuyY4Ris8OWNCNVrEiDafCA2+w7xmSp2VGFjI8CSU8ZUTj+3qbirj1pn9hvOih8WT2prYKsGkAyMbHZdEppj7sMDKG6P6A9aapV0BqUc5OFDIqToS/hqv5otCtmuDhMmtf/c0dukcE+aBIwfdBe6r26NtGl7ci2N6kNkSh10BzxdqMG5LmyKBRs3nEZDtYegRB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffbae90-4052-42a7-97f4-08df2e95ee17
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:35:59.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUNdVRrBtweTcde+H9TPgkL2nRwOuwMdujcbnhfKXfXwHIuQwnHEEw0gogcrTTJ/drQL6bqEItTBm/xceYlEISBt5W27+93iYvJnNI44MmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7513

On Oct 14, 2026 / 19:00, Andrea Parri wrote:
> Issue a failing Identify into a buffer filled with a sentinel and verify
> that the target transfers no data, with a successful Identify and a
> namespace read as controls. The test runs on every configured transport;
> only nvmet-fc failed it before the fix. Add a small helper because
> nvme-cli cannot prefill the data buffer.
> 
> The test fails over fc on the unpatched kernel and passes with the fix
> applied.

[...]

> diff --git a/tests/nvme/071 b/tests/nvme/071
> new file mode 100755
> index 0000000000000..5333bfac8db53
> --- /dev/null
> +++ b/tests/nvme/071
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Andrea Parri
> +#
> +# Check that the NVMe target transfers no read data for a failed command.
> +# The host buffer is filled with a sentinel, so any data the target sends
> +# shows up as changed bytes.
> +#
> +# Regression test for patch "nvmet-fc: only send read data for successful
> +# commands".
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="verify nvmet does not transfer data for failed reads"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_kernel_nvme_target
> +	_have_src_program nvme-sentinel-read
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +# Issue an Identify with CNS $2 to controller $1 and print the NVMe status
> +# and the number of changed bytes in the 4096-byte data buffer.
> +_identify() {

In most cases, the function names that start with underscore are used for
helper functions in common scripts. This function is used only in this script
file, I suggest a function name that does not start with underscore. How about
issue_identify() ?

> +	src/nvme-sentinel-read "$1" 0x06 "$2" 4096 2>>"$FULL"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local changed ctrl ns status
> +
> +	_setup_nvmet
> +	# File backing: the namespace read below fails over loop with the
> +	# default loop device backing, for reasons unrelated to this test.
> +	_nvmet_target_setup --blkdev file
> +	_nvme_connect_subsys
> +
> +	ctrl=$(_find_nvme_dev "$def_subsysnqn")
> +	ns="/dev/${ctrl}n1"
> +
> +	# Identify Controller succeeds and must overwrite the sentinel.
> +	if ! read -r status changed < <(_identify "/dev/$ctrl" 0x01); then
> +		echo "successful Identify could not be issued"
> +	else
> +		echo "cns=0x01 status=$status changed=$changed" >>"$FULL"
> +		if ((status != 0 || changed == 0)); then
> +			echo "successful Identify returned status $status with $changed bytes"
> +		fi
> +	fi
> +
> +	# An unsupported CNS fails and must leave the sentinel intact.
> +	if ! read -r status changed < <(_identify "/dev/$ctrl" 0xff); then
> +		echo "failed Identify could not be issued"
> +	else
> +		echo "cns=0xff status=$status changed=$changed" >>"$FULL"
> +		if (((status & 0x7ff) != 2)); then
> +			echo "failed Identify returned status $status, expected 0x2"
> +		fi
> +		if ((changed != 0)); then
> +			echo "failed Identify transferred data: $changed bytes changed"
> +		fi
> +	fi


Do we really need this dd part below? As far as I understand, the core part of
this test case is Identify command part above.

> +
> +	if ! dd if="$ns" of=/dev/null bs=4096 count=256 iflag=direct \
> +	     status=none >>"$FULL" 2>&1; then
> +		echo "namespace read failed"
> +	fi
> +
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +
> +	echo "Test complete"
> +}

