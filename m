Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB8437478
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448525; cv=fail; b=gvy09CPA0M7OOYOira4Se2uiJXmwWH4/aCJFqzI1UgqNE2Y4CxE1+xu4NYU6vexo353FUotskWIvfTj2wpk0m/7F0mlEvCe+kdwTIIA5K2l0RfZy/LLwBeBknc6K3kkdiIh+kO/2d//rWRjd5x1m/3ISsc2TAev3s1iTUogDeus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448525; c=relaxed/simple;
	bh=GkXJCt8IqXEV8a4ASYENhjHA/VW7nQFaY5spX9NMQtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9T9IcecD5fxk5yZYPDeM90MCjK/pNInu0EJahc+eM5amKXAZWdok2P89YimHLHg6q3B+8yEAFDySrP22gykQgybIrN2QKwTgtUM+l5/Ir589+gj+A7bKSj+r2xt2HTJqOOiM064fIYNsMs+2XvZ7syjthdinYtm2CMBeTG2CZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pHhoEEJC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=to/ZbRV3; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pHhoEEJC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="to/ZbRV3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786448523; x=1817984523;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GkXJCt8IqXEV8a4ASYENhjHA/VW7nQFaY5spX9NMQtU=;
  b=pHhoEEJCNpafolKs0LY27GgJ/pYixW91tqWV1B8C47sAA9PMM4v16gyL
   kCGvn1VXbkdR/kDgbE9mlNlOQihgR1XhaB5TghGelJ/PFpwBCMzt5oDVe
   TKx3z2Vr5T1MIADCppBHf7nVSyLN3/KIA1HgsMx6Fysx6/ML5h+7xCsCy
   u43J5QpNQTLkC++qIAdvohaj7nQGlCJ//EqhHzauJlbjuMrbP+h+XW0ZK
   5t6pQRPxcpdE1DU/zHlPHKfvAHcn7dRAtznOq1Jxk9tBkRhvKt7g+BC/h
   Mdhxpxe86GDtFouUrtsUQ8EjiJ48gKAb4FDdkJiB7nLwUWOtIqT1wOSZ2
   g==;
X-CSE-ConnectionGUID: ApQWqd/gQKOZN42VAdjikQ==
X-CSE-MsgGUID: HjBcVYYUQomTDOiZnyxPEg==
X-IronPort-AV: E=Sophos;i="6.25,217,1779120000"; 
   d="scan'208";a="152670347"
Received: from mail-centralusazon11011049.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 19:41:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB1VI83y9rEjgdPzlF2+o1vJXkbEjl0EAcE2iG8mQZasBMcCudrbs9OFAC1ehTYQe1cdZ6RKc5Y9zHZ1D4eWEB2rJ5sNIgHSye+y36DkbCQOv48J2ElxWBkJL7LjgstMQ9KcaAFfXUdlGMHrYYedI8wieReNJYhoOv1+RgAx5N0WaVNIlIiumVCMcIdJGjbfjv6OLyaXh+QiERy+0EHhBJ2wtEDqY23HGEKX5ji7Br4O2/UFXLZcIQUwaFGIzMAxsw7N0/UMNxgL8LY5Hj0PeKUEwL963c8tFnYUhi0nNpIbXRtqh3vV6/K9PSb8oK/p//5y+ocuI4e/pRPKHU7ZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRvnhW47aHUwUxCHV6wD7jx82Y5pjnrhVvCHLr4j1pI=;
 b=kFR7HQjS24eIVy7iasQm2ZtNmnSlPHIMKiW4vKKA4vmBgyglsa1pJFJzzbboffB0C3z12ZljcqH5yvvpI2YPMlOHOurIXb7aCXgZ/Xbzn+lqO0miEW62Mih0dw8p6lYWZdvQZ2D2vbRJnKz2Ih3CSe6HAQffNGiuJcvedxR7hpF35Gs0LctLw6a4j711aV9oZRW6s/m7ArpR2i1+9AKvu3yvMRlDzhu1emvghZPVBe1v/vc8xD6BT70Owzhqt33mPOONkq1D78FydqMQMyPCJ4OI/g66af+whce+PFVNRSHUrec0UkyLFaovGC5DAs12n7/nLXhswKeRGnwYoyx0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRvnhW47aHUwUxCHV6wD7jx82Y5pjnrhVvCHLr4j1pI=;
 b=to/ZbRV3LDbrQRn0Zk2nXTzGj0hfRgfesN0TDokXnY/UID+oWfg7y70AfuAZoRHWazW59nXgqYn4K8LO5c1gnUlm35wV/sSjZcbIk1Rpyt3xphTVDfNpCP9aFoqGbTTA5gkM9nNYmceV22GCTr/RATnjAnXeE5wTVDzjF81gOGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by LV8PR04MB9265.namprd04.prod.outlook.com (2603:10b6:408:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:41:54 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:41:54 +0000
Date: Tue, 11 Aug 2026 13:41:44 +0200
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 01/13] block: remove disk_free_zone_resources()
Message-ID: <ansHsOhXTxPcUr-R@mayhem.fritz.box>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811105852.1245357-2-dlemoal@kernel.org>
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|LV8PR04MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ada2e53-3ab4-4b68-40b2-08def79d8a9b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|10070799003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	5AwF1Tv4VECNOoJdpRhRVaFndOQKYw0KROWEcJxN2SDk2g2WiYrXlGQ/1FF5nTf+M6uXQx+oF1gb/Z+ozNlGONklILhofUf/MQhGTGw5sos+1W9+aSs4zXHFYtI8oIsIXkqSrzS+opXMauw3AgN7GqURJ6G+5cRiOIK8z2rCW3u4sDXrpIrR+0mvgJTm+qwJ3QlOyHw2sPB6GgvaAcUNT8zOx7xoRq7ZvE+VA/cnBE5RzYndzXzxkAPOmVkvsU0hYPfwYKxwivKVEZ5DuORcRuFThej8PDk44ihfunVpg3AZorSzPeWv7trFLfvBAfJY2cLKA76cIjex3lLk2pVBsjiJwxDg2kDF/yAx8RXvvjrqE3wqC7nlRIHa1XFgZ9uab2Uae/44U/6OpzI44BUwAENJeONF1YtxVD5pfY7dl+NESOwy4h61cMyVw6pJOWF7SQe/LFW3jT9sKfkp7rVE3B6w33LeZ5CedOh79FxDJMHq9G3iH4j3w/1WYStsFLtS9Kmb6xpERJ3mzPfDn8GrEhbsKqC+9sj5Y3HI8E7ae7tFcheW5fOQVZ3V5av6lT74tud1KUh4kESeOdSBfMwWQ/mUy7it97299ZH8VnZT7x7kGfMah/Kr6AXeFt6PUwUrrhfJq0lZI3C5e0lFFhGo0Cau1tydG4crabgCK7gyoBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFyP1a4wCWFQkTFEZI70VNr0Y3fZ4GZZUGM6uIEG339pDuMsk/0W6ZQ85rfA?=
 =?us-ascii?Q?dQfBe2tsL6UPKc/i2aG07gPa20R1SGdXWc3uFGv0zNLO9U3GidR922+wDWCV?=
 =?us-ascii?Q?vM7sgnmxkq4Gn+QueAmTdIeie1t1wELTwPCr+VgETCK8K3iQgitGCXH+Q1hk?=
 =?us-ascii?Q?Z1q5zd54ySLTBiPknjTwkHBFLPjEs4ClPyxsiIiLRFW6t84Kbi5Kg3L3PImC?=
 =?us-ascii?Q?1p29t4OBsIY22VHW6y9gB+BwSN2WA0usBoEy2shUpuBo3SvEO/qvO+UiVAhz?=
 =?us-ascii?Q?s66jTSNwuwragpPRzpOt2Sj3jtPsW8qLrQUCFDSciKA8/8mwRpjmrDr9T2h6?=
 =?us-ascii?Q?qB47Xm+rbrb4PnJ1hv/jepdOl1AOmZne2KFco0Z9b+Tnb8fp0SwoLyKYv8wR?=
 =?us-ascii?Q?9BSu91C1uQUhjR3aBA8BkRkKoLeKPx1GooDtyiqieex8JRpliTfpvb8QwDLv?=
 =?us-ascii?Q?OhieeYrrTWkjnL6Qif/VzTdKIfV+xk0q1BYSjUxQN8lEBEaAZknjprBWH5xr?=
 =?us-ascii?Q?TLZipWlPgUP3lpcZGELcWeESt7qVdVNiLUewZKToq50ZwyQNrJji8aOXqeC9?=
 =?us-ascii?Q?fZvwkPqkDv8PIgQ+gqsKUSNzt27P/ID3tHCFtBipSrNeZypcyUwPi5mCn2Dl?=
 =?us-ascii?Q?lPhuhzGCYoU5E4eBFSP267K46lyXJhIgN/7n301SGXyeGnrVoE/4uZkRiMnP?=
 =?us-ascii?Q?IezwsYm6l9pYCwifhlO5/ogImIUN1QCm4T44Hf5SPKxkmK0Cy2jx2spDc6Ce?=
 =?us-ascii?Q?aZBFvv5WoL60rBGl+fbfO8aTrE/KuK9r6sW2+WgaLrWg9sumasvUv69+VmMX?=
 =?us-ascii?Q?zRGQM7yYQ6uinwiCqgpedcYl2HYM+2822UM/AlhpMvt4CFZ7c+aD3wxmF0BO?=
 =?us-ascii?Q?VZBxNxT10CRY0/FhYWIuNXKVgrDXnx7JBMU3+u1LT8KZwGO4y+3HlQH1ayky?=
 =?us-ascii?Q?F90t1IHx3JTJMGOghaUNSftE6c512JHZNVyGhe7r7OkhS7hRYgFWCh9hhqoq?=
 =?us-ascii?Q?yYrYALAyPzfOr9wa6NKSPELxAszciAljTX48P+zkz3Kx++l5InyknxsQCrg3?=
 =?us-ascii?Q?qLVRsivcr5V/a/Sb4z1uNA9agSTZFz7/cGC9ZK3d6CDaOMz7qWmzWo81TEeM?=
 =?us-ascii?Q?xWG1PTXJB2aoVePuU9IoNVar3/n14ohxWgDuHYLfDjNWQ75+s5ne7bUHzwO8?=
 =?us-ascii?Q?X9YPwsUoutYMFOvmwPXgqLMUQ8cyoupfNI7QuEqmmNISp1BzDtw8GJ5riJek?=
 =?us-ascii?Q?8mykzXkko+429Dtt31Rj6HS/+FdXZPRH0Bto5Sbr21cC3VhzvxEwm6UAMP5n?=
 =?us-ascii?Q?ktiTAJZG0+LB54MPn585fGvTupA0p+TGIyu/QxIPK6lCgMVJ0qsyxaWiEhca?=
 =?us-ascii?Q?0hfLz3ngnv+H/odp+XY5JODFqail1fVM54zsQzSeoiKvEC5mkK6IVEugcVLC?=
 =?us-ascii?Q?OrhFGUufrrmreM7VUcIhQ2IA57cWzBTtI3bIvkvhxSDOP0VlCZ6t6tOMxHRw?=
 =?us-ascii?Q?gk+HGvTr0RQ/xzE6WdFFXIETvZTP6BhXNy+fcAQt/Svnl7ZRbCkga5/wl2CM?=
 =?us-ascii?Q?G00QSWq84EiuMRGI7CNiXJsccuMYyla+skEg5x/ze4QxfURiITZlRq2gEl2x?=
 =?us-ascii?Q?+z77s2HkrsYAWjlZk9mj/z5RxMJ9gp6RC7rs2XigFFbtQ6GXxsI9xjSIlTrF?=
 =?us-ascii?Q?H0EvhvIw4ixLpax/IbWxKi8vOggd3NML8GjsPWG8zDNMVKNtispTb98F8arw?=
 =?us-ascii?Q?oIyX0Gn64UnRK9qa9RBMk9xwLNr3l57Ctvytw1CEtXxrcSuEYtv+h6/R3cNm?=
X-MS-Exchange-AntiSpam-MessageData-1: JF8toyJULvNX/+4GxkFJFl19mhealPJ7MAc=
X-Exchange-RoutingPolicyChecked:
	fBq7Jrjolvqgm9voPL7tXaAcsZ4rFy+t0FEKp27GL7YLC1xxuevOrJaXbb1qCBIhTlyumVPrws9HTPNQBW7LPNYc1kUpsGUh2kXrFBvwnZcfmqc0DlhNKmh9fmS8ksVyRNfU0U5SskbOAdI6Y7v0DtP2kRr7iUq4BZ7LjQyQ6Yt5+OL3savkJOxlKgD48dY4/crZWUsrJtR2lqpeWOxmrxNJc0+tg9qgizt0WxEL2JEF8HFolDTylFN9z7aT28RCzs+pxwWOEtKkmpqiugVlka8ZqbTz9miHk/jRavw28wE2kMVExnZql+70WNc++g0jINCaQOyaY/xozhPIHjN94w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PmXs/9E1gV278oJrqR75Y2cRNnmIZHzAI+H4v8BX7EggchB8wAHAvDnJngzsSVhglsB/pvs84/NMvKiH1PhVkL1XbNKaPGi+kKOrjsBG8E9n+iBcveBS/zUDYro2FZYvZAJhufBmkEtXgT2+El7+HrVrEpJbQuweM9j+WlpoYJ3n5EmGY9p+dERl0GOYDqrrBI1n5o5NzJd0RIVm/el9a+IMw2ASTrDZBRXkXQJAC0fE2t4FrKsaRoOvaX+bcqHT2RhdHIGerRL0v6FUd/sxnjeqU86WIZ5+aUoDw2QMEpHs5cj3jYGTrUL0eeQut/c32gGfCfmh3LA+vylTBGwOC0KXjnEXgVSy2p5iYX9IzUvPNjuqemdVIp4aFvNHS5aTLFHrE+GBsEwp78+sVvYj2vpdTRNTlMhbydB0fRxwuffiXR2D4zT6tf1lyAe8BexiUABFayhmcK34OAnklIzcSi09k6/eHq9eV/+JlskupNOpnjqP4tDOQ3FGNUxK0qyp2R8yIsocUuTYFnY3fEYEy4AdoUwuD3ECSAlfQwAM55WAmwzFq4rUpB48UlMMC3F6PnQa7sxZ5mO1Hd6HnDIIx4k6976s9U5qnOs+vQ1nZ3n9emcxHTDacsVCHYsId9sI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ada2e53-3ab4-4b68-40b2-08def79d8a9b
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:41:54.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xUMfwPWeOa1Vp+w0ZPh+qwbWRcFp95MRCcAZjXBxGjtxBmQOwIr5MFFJOcX2AFgbA/Ua/uLNO+7X1mbu53slt+Po3d6s+169zXJlNfc304=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9265

On Tue, Aug 11, 2026 at 07:58:40PM +0900, Damien Le Moal wrote:
> In the rare event when revalidating the zones of a zoned block device
> fails, the device capacity will be dropped to 0. In such case, the zoned
> block device will either be rescanned and restored or dropped entirely and
> its gendisk destroyed. So calling disk_free_zone_resources() from

is destroyed

> blk_revalidate_disk_zones() in case of error does not make much sense. We

an error

> can keep the zone resources in case the device is rescanned and restored
> or simply free all resources in disk_release_zone_resources() when the
> gendick is destroyed.

gendisk

> 
> Remove the call to disk_free_zone_resources() from
> blk_revalidate_disk_zones() and squash disk_free_zone_resources() inside
> disk_release_zone_resources(). With this change, the conditional creation
> of the zone write plugs work queue is not necessary anymore as the
> workqueue will keep existing together with all other resources until the
> disk is released. This simplifies disk_alloc_zone_resources().

Other than that:
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
