Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45064BE43D
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967686; cv=fail; b=tIXmqEVjqe2V3N6PxKGRWpcAJA6s2fB+jQwu86qk0pDuIe9PN8gmiatGvEX5sBOLXxZVTzIdymZiVT1BD0RKZt8t3IxMpsG7WFQcL/29kpD/SEHZtH+Z9jkYyh4nyIDvzUy81Zwa/UGcyUBucCJqDzqi3s/DwXpoyDqvhV+drc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967686; c=relaxed/simple;
	bh=q64Ts9oexJz4YQmfQxhhks6JGfEAcLBQrvQLM53LrGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJvMNhPi+9UyNQqt0jJ4TuQYKa8TdvVxiD2yXc93Cve3+Q9Y6/POEPVLQfU4O8nIvswfOwvZCQP2ti6/ut+GdOeWnVihW3qcW1vkivChvvHYswqW3Dtdv42pnUwFssoLWQaDQRE14HVLbuK8z5+Wp/8Cz1iwVXLz7eGMTAWTRSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CH8PI4cM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AmRV/Mt3; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CH8PI4cM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AmRV/Mt3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791967682; x=1823503682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q64Ts9oexJz4YQmfQxhhks6JGfEAcLBQrvQLM53LrGE=;
  b=CH8PI4cMXhEcBoMO4htjQYiS6OxICFM+2jnajzRy+eUOdULBuS+VzCK9
   Tp5P0M4VZx/iBGuxAf2RejOIB8PfHog9VoiFtvBzSThGHMxgOMRpJ9M5e
   6NFglJjdI6ZxWQ6MUANqDC4yzvsSU27RKVczlDhzrx/TAjiPudp7QrTsr
   suxCXaXMCE7/BvwrniEdpcMs3w5cn/a2kFMkfINp6JXKEFt/psJR9EOgP
   8cB1cQBrtentuD+8+VuZevPLYj+E6zp09Tiqi1pWc/Q8WzUqeHJIiS6uP
   5JxpMWL1zlYxiu7orzWSl2dIsnfWFQT4E4/HstMS6IJx4DF4VmfenSNlU
   Q==;
X-CSE-ConnectionGUID: bz4uoblFRfCNL4CVwxRLgg==
X-CSE-MsgGUID: 3EVzwfuARgu9nYo7z2SXmA==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; 
   d="scan'208";a="153838638"
Received: from mail-southcentralusazon11013025.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 16:47:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBvGlVk6gb46/g99Ji5uaYlnYg5kLNpMgEYwNTaUE9XvRZzI5pDBOpjEk1OBOY8v0i8jb0l9mTami7/0ixT/NznN50OSrTVM83lLm9BqpPp4Pj60tKH8JpbfV3KXWuxn0oKhlkd652X4sAjspjHXK6+pAmC3xOLeRZJUqx9tAYz1q/ui7nnR8SR7INVF4OEii5NxDr0EXnpGzf386zntfLWysrFNqxHX34p2VgFiA61ptpcZswIen5/RLCbQ9U0cMNJC+p2XJYlOoPhUhMIgQ1qBheuRsGNaxjfvv4ane3lDHY+0LKmxUZqS0HTfy89KfgMccNoHCWRqJzqGpc2clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBqTuCo69TJolZzCU4ZOb/CbIptmkILs2scESGj2DdA=;
 b=o6jWoCjUtRuYWK0jkbl4nKwZZ74XtYB22FDGBt+7chjTRpWJeRggyug1I0TtDcC9+B3vVXtm1BEcx1rltrtvBBl9u5L0C+i+Bm1l2tw34+vzW4KoUmhsUz5lhERpPrzoPesf6c2dQfL4PO+etAITwabtvh2MQVtdWgIDmZC5uF5kMeRTsXqEP+OTzVkzx69msCK2rk+dqCEef9RIru4rCz2zhvskfKkiwsf6oy1Xh4XRqxLlMm7Emxi0HWoAezkLj7ryAMyb9co4AbuYvIxrXguedyhgrSe9qNYVhnbG88ZlgnjkxpuOt7JY9eHlWk4idY4R+EUNC59I70t0EvpX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBqTuCo69TJolZzCU4ZOb/CbIptmkILs2scESGj2DdA=;
 b=AmRV/Mt3FSX82+IBJWvyRlbJ10/8Y1H+L2UMRcCLxF7m2NC95RZH1E9JITfEDGFdBiYr+SoxOxxrS2i8VcyF1OIcgdJuXsQZfka/XBTIE8GGrhRIgi5hUdjp0XUmhQjm0u+mDHCs/cPV13VnXx2g/lteIsBbYTUVfe5GZkHoYNA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA0PR04MB7178.namprd04.prod.outlook.com
 (2603:10b6:806:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 08:47:54 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 08:47:54 +0000
Date: Wed, 14 Oct 2026 17:47:48 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] loop: remove support for swapping loop fds
Message-ID: <as8-8rDJmUb1FxbP@shinmob>
References: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
 <49a2d2f1d44a018dbe2a3da155b5fedea30cf98ea484bdc19da2f9cf97c4e0da@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a2d2f1d44a018dbe2a3da155b5fedea30cf98ea484bdc19da2f9cf97c4e0da@mailrelay.wdc.com>
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA0PR04MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e722932-599f-4cfc-252d-08df29cfd6b0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|22082099003|10067099003|18002099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UlkrC6Kz6Rs3PMdXLyR3HhB3gAayW7wa/XpIIMrDS1ee5cVy57rloylshvIpqbPbao+JEt18TXhvvYxDH5lavM4fNabu+XjfD1exDb/qgQvhiBVrPaVYt9bAb0zXGR3qSa7ne5ypA28AZkWOvNivDvUr1qxKxv0A/MFllQ4ppBsGLTs8q08lwZy5/VUWpmsdfbmfE4KqEtTMBut+625lL4sMCqoJZpEMAdrOwPGucSMoxwCHmzANEX6Ep2POz2AT4VJ2ta61735dvebhW+RKN4MMWQ1lZ3pzFKWQVxr5ZJj1SBv65OrFGMQ55JfpftMUfJOPhXhEG72MOce2m7Bovt6DpdLc0oLHaFQJ2YjNmwt6S6/GAx70qhQIYc6bezYUQke9VXfVtuQ69yrh7MiVj+0qGVWuwMTkMI89tj8khcuHBAl735NXTTlVzjT/S+AOTODNJwufjdrMJ1leWFv3kyUeitqH5IalfhSPd2qaWfLbyj4+PjGR4q7ETtVDJu4e/5DB4kjum55BTdFoGxQpmxZUWkTE/uv2oQp5mNni2m6QmcM8pHEUebtMT+MvE+Q3f773/G04UW6ceNgk5tK9dlNFDfX6erWEXAQqDnTC5bFmhqJ4dIPIdDW2uYf4XJ1g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uOqwORMb9e992puEKmjGpK5VbM1G1w3haMvayXTn++c3QyB3B4P2QBvYHH6?=
 =?us-ascii?Q?BdjbdlkdroTz1Ypj/4XIG0HNauqiFB/r7l5OdxUUm0ZNVWZvkz8eWGyv9o7o?=
 =?us-ascii?Q?DHST85cc1J0Mg1oHp9mL2CfzxXEe9S7S4ZjDVTkHU2MAUHd1zjMWV3fP6GRv?=
 =?us-ascii?Q?q4fi8qb+f+E1PkZY0PPSoGgSZHHb1mjne9snjL976ULbl2eGhjQagJt81sVA?=
 =?us-ascii?Q?Dn3upGljla7phG1LvpDLb4QdJoiLzfnKGt6onOlQqQ7XaoUmFdDFFtcYTi3Z?=
 =?us-ascii?Q?1+/Yz+/YQSx7zEUephn69QLkVd9xoqPu04YJuYG4r4UxtJRaHQ6137Tt3JKJ?=
 =?us-ascii?Q?W2qNCS2dpylTVV2c3npd181kq85DoME09zs9TXlcM4Nt3oC63FOAb/4GQ8Bw?=
 =?us-ascii?Q?ycPnYy+Rr5WQiiUD0IDhdARpg9qklb8IpMdlVOuwZbTCkDq9V+JLdH6D1gBA?=
 =?us-ascii?Q?grpeXx+gPDvZpma/5H6nWx2pvQl1GfFxhiPZvKF/OfOVvu5Tb8F6ua7Ict0d?=
 =?us-ascii?Q?mHi7zDhamBDppZ/iPDXTe+Q7zrUpd0q0QB0gaF2rc0PCFJ1enLSrM14lgZCv?=
 =?us-ascii?Q?1Lu5ybtzHq9OvS27ru4YaXGevKkji6i3t94E+FgHFjHR29HPt2RdyjtPG7fr?=
 =?us-ascii?Q?Z6vjNMAk8kYPcd5lVeYIsaGtWC2EadzF1HmezOP2+7xG2kOLIESG+hF3UdYa?=
 =?us-ascii?Q?4oQozLjRZMQL+SR2qOYkgM5WmUGCYVznYuWy5ixVcIApbB5WDl6Gs8m5nr52?=
 =?us-ascii?Q?syPSzXhd96c5ZHbZxyEoO2YMv2JMOZMdZIqGgQaAgXCnVJxvOyYR1zi4LecQ?=
 =?us-ascii?Q?4HPiN6mZGBqzLoiE6Mz6JFXWI2ZlNDnJPwj7pUD6xUgYgrKYPbtal4qsGVbC?=
 =?us-ascii?Q?0u3EuzYTUj0WOytuWp3TKyBs9MGnom4VBeJ89OdjVIoPhiu7m71YMVkB497K?=
 =?us-ascii?Q?vY2V+aTn/xMHEPyjovpwKsh1UxmTO2XDBpH2yZ3fSKItbuXzT3WE2rIa6IU6?=
 =?us-ascii?Q?FGRNEbWxmMVJ2QfTItmV/ZvsyX7Ggv0/QXVYiRxvkDk98S/55NrH7qarL54F?=
 =?us-ascii?Q?0e/7vdewV7Q4znrBad4d0D45Lu1BFXFPzOhzj7gtQj3nUNi6OvMD+ZHYckU1?=
 =?us-ascii?Q?i39yOG+chq3SLpG9fon8+VEbY0BlAVHVxAUUPvL3u4bYo8EnVsUjrAGNnCOl?=
 =?us-ascii?Q?54gk2xKewFrqq9T7Te9gKgE0RQukNRnj+QdtcerpV3jDK/bSAkZSKcCcZuvM?=
 =?us-ascii?Q?RJRND6aw1zzHSdE2Snd0INwPonZuJaNfdDHJDSWWqo025mmg6ewvGrcaViU4?=
 =?us-ascii?Q?new9Jw7VBBhaZyH6u68Z2kdtH+9205b5+7htmFou9EieLoISjDesxvCnJEKB?=
 =?us-ascii?Q?R+ptVlTI8SQkc3jG0bYH5QFBy4KG+4+HWhG3bmi4sM04PdR8iHu0riFiKT+3?=
 =?us-ascii?Q?YVh4wJtBc4laXKV6zRB7FKPNwhZ7nk0r5cCMg5JSFyjME61AiwWQSxCE46yi?=
 =?us-ascii?Q?bpITF30zgIcfyllC3JuHettI22Q+LXNUoNZahPSv7CtHqxgoqVXu4XoDBjvv?=
 =?us-ascii?Q?L7cqQ1JTPXkjYcuXJE7tkVeA1hCFAg/fO5N2qx1qcca+3/90UXE3qV3PQfhO?=
 =?us-ascii?Q?08y2lrnshFeOg5/pThV1uPdWk/lm8fEDoph72tgUY5mV6y74IC0Z6It61AAR?=
 =?us-ascii?Q?K/i6xwYs8YkbermJF+I+l3SmFNL0kvLcWz4lgB76eNTmsxl7kH/sTPEPth83?=
 =?us-ascii?Q?MeG6yDHJTChaqKMRoMx5hwyebrc0d7g=3D?=
X-Exchange-RoutingPolicyChecked:
	mE8044BdqESoXGWK7YWU8qzaa0IlYoLvFRp/S76zyPv4Ge9Wg2rqFGxCno6ltDEWuIf/14DAcdDXmAhNx+M+OJ0/3+LVrcFSdPMU3F8RDOeI1TpsWCZko17r0wrzK824VX0kIbpzn8lCA3RWpFySOm1tNe7DP2djzlPNNAAIAFEzCR6VfrHtSaX+n0GKeQh7V/VJxLFovgiRQC7D3xRKr3S5mRZGIUt/dF72hfzGOXBYhE/PPDtsFJyajf+0Qm+l0iC4AQcUl5Fi7BxmNK5yqeNsio8iqscydzBkkDunHLA62B/7q/5QFj/RA7nktOe6ozARcOL3myWyNcpHv8oA6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lfPg6R8AxzwFrP/vbRChnK+jBI4hoL06cpS0uIb6/9ckY7wiePuTDOAlvL9LO/eL7/tYeJ16Zwa42TCKFatCLUKd/bwwOd/pEAzE6LLKt0RY6fr/3dnMGPKsLUZGDYNq5NjXTjjzRS1GSzV/GXxt855Lug8TdDg1FghrJEEqycjt2jpvzIXytEVrQQ5nPmfGJX3Is00mmkQIT67VXCq9BxKfr/KIyzRqZKhdpLgq1ozqbswVvpE6PU1fJdtXEDQRDI8JyEvc0BLAfSPybmZoAp1/ZN3vRTWvz/7hsazLfmfaM3X/xSrBIzMpKG5xQW+gI/ST+YG+/x8tz45tMUkZNmaAZ4QzBuoYH3JDCdDElN12ZbYCQd1o+H0HJPReaTAUluSPekz54ebpVa1fHdk/xWhs2pmg9UvooRbFqYrhD7hrgHDuYkQe+s4svgOgAXVz1SMeblRP/l2FKJC274SSZDpByx8WggzUv6w4YXnUQa3GQVAB0OB0Las9heQlZmP33e0xKtnQ0cmZtqoa+MhEpTfSzN7dthOrqOKrp3kniiy2c9FWoi7vMfvFQHXFA2UmfOxkxTiX7Wc3Yjcu9krulX3EXEFWql5H/TeyT4kl4yARaeuIL/P+orjftJ8bjkJ5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e722932-599f-4cfc-252d-08df29cfd6b0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:47:54.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un/1TFPAN6x3BrvhA5nbO9JdlntCfdcPo6P64fcM18oHvCKuqzIn7rIvJ0W2I6jUn/8U9Qll6jhfREDrQWslMfYvEcSTTMZefc2ZGbG68rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178

On Oct 13, 2026 / 16:03, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       loop: remove support for swapping loop fds

This kernel patch removed the support of ioctl LOOP_CHANGE_FD.

> Patchwork:  https://patchwork.kernel.org/series/1183887/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/38278109458
> 
> 
> Failed test cases: loop/006

And this test case confirms that the ioctl LOOP_CHANGE_FD works well. After
removing the ioctl, the test case failure is expected. Blktests CI caught it,
and reported it with this e-mail.

The test case loop/006 is no longer valid, and its failure should be handled.
I can think of two action candidates:

  1) just remove the test case loop/006
  2) skip the test case for kernel versions larger than v7.4, and keep it for
     older kernel versions

The ioctl has been broken for certain period, so I think action 1) is more
appropriate. If anyone has different opinion, please share. Otherwise, I will
post a patch to remove loop/006.
