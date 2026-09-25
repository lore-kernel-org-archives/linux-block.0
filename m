Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F41A9FA8
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305709; cv=fail; b=MO8zRghyJf/sB8CFrgJD+5voNmq6yh1xPw2IJLUBQJkzTbLU/FZ7Un+p8Ds5NTz5rjjrXaAJlG0gkgByjywCmGReTaJqomfJq4NzbTOV5EOs1/meNI94jTI288Aii4YTD2zDSYTxfqLdeNu5wfJX2ziEvdBKQXSgZKWPWufUzXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305709; c=relaxed/simple;
	bh=heX+1I1hg5WiCkz7d+FywQh6IBWv83xiczpYhBnIB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JjCZTB+I1ATJjkFUKZ+T0ryL1D7fYf5xtAPZPVoFuQu3anRUK+Kfzzmhm8V/bjdWYyTbnhTEozm5YPtqF7vSnwSS0kXWkFO95Wb6VZ5nBUC7GIkkR3yNlBfUObT6MMjMSksz4Xrz2ScrAz7GpHpliWfIbd9jzx8s0wA2/AgoPRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bUTX/6xj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kczE6PRJ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bUTX/6xj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kczE6PRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790305709; x=1821841709;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=heX+1I1hg5WiCkz7d+FywQh6IBWv83xiczpYhBnIB9c=;
  b=bUTX/6xjAgWNmvfeV61XBJViOyqvl8zFTgI0xGeQZ8hd2RiZnfAfaLje
   dMA6bvL2yDJ43VKkED9oKW2iBP8r5nqiDiuMpW+uL3bY7HrIMHobTMpKN
   +cwWswMfafBHOadtzP/crEk7iMgBxdp/elPtlnxowcxtcPInInk3ck+46
   yqmKKA2AT1WriGTnw9DGbJQxKCNj8v950Qypu6jhBBrJkjGAoRttpTKGo
   l1PnqbKURjbx+hPPqq2p5qrzskjA/CsW36rXsY9aij5th9XhcZjzXAyT+
   YQrC/nTI80HUQF6P/p1sPYhvYqIXoAKnvmU8Fo5EkBgs2msq3q7cndQBl
   Q==;
X-CSE-ConnectionGUID: Va8Ozs6STJ63HyGfeFvsrg==
X-CSE-MsgGUID: sYPnCRYzQcmpgBN0i7ulww==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; 
   d="scan'208";a="156516727"
Received: from mail-westusazon11012013.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2026 11:08:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/5JLW15PkzKrOn/RjaSqsZKGGzesBL+WX1XdXmT2PvGH6KIfcIyZF+pkJATwxCENwkRwgTLhSxVlsGiFRHHP32cGiZXRO1hF+3hNVhtXCe3rXCqTmdfGY731B8dkz0ySYVdKyol0f5uL4+3iJSa2aAYb/12bfUN5K9vQN1ppLBWNgYWqK6/fD0VSUMHJ1SPYRrluZTnhxGKoh2LA42+VH6HjYKPWv7RBwPto/TMMBBHtp+T8tj0YVUQ2qKxRsG9hPpNh+zzsLyGo8mPQ/XUjwIGQO7IAQzaUio63AX+/qxmT8wPNKeKUgtC+YL9UQ1+gItKK800S1yt/MGEUU08sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8Sqan87DiF5kj7htp+4OV0axfL2GH2/uZAnEc2sz8=;
 b=lMbVIJPCShqu+l4xNQbMvj+FWVU5s4TYmuZe1HtCqL0PaWlIfaWka4j85U12L7BSMSEjVgYh1PWYxaj4OyaeGVGvX6bN9I+NY6bUilE9YmBYIi8qHU59Qb3yYESUqmTmb+HICGCeFQpKHqHrJQs1CV1tX3FFY2ScdrRtA1mtoTZ7w8zMA/5KnYipFIeIRNXdtz0MJYUnxZJHhk1+VDoiPCfxxMJphObqhcnI8w3UGKU8mQ6eudriYwwdBAV6qDVIiuPuE320fxb2ZkfNQU4XdFKBEQGO+miPSmQ9cqlgREa9U+LIPbI9FrUX+Cq6vcOcFcccksbbrvhN/ZKx2yBV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8Sqan87DiF5kj7htp+4OV0axfL2GH2/uZAnEc2sz8=;
 b=kczE6PRJ2Tow3d9w3xkLurNbsoVKLq+V9frMKdcrORQ/QN8wSmpglwtN3cANHUymATxDWWl21kFHNm9c2kSBu9h7IEs8n67/iFjVnmqNNw2WmGjoMtK/6WHDPLCiDd4i/n9ejXardo4UyuKlZAtsvMXjaY9nCYS8FqzkLYX8vuo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DSVPR04MB10128.namprd04.prod.outlook.com
 (2603:10b6:8:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 03:08:20 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 03:08:19 +0000
Date: Fri, 25 Sep 2026 12:08:12 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	Jesse Taube <jtaubepe@redhat.com>, Randy Jennings <randyj@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests] nvme/071: test CCR and CQT recovery on a
 multipath fabrics namespace
Message-ID: <arXkH22uhHHdnaq3@shinmob>
References: <20260921205951.3023714-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921205951.3023714-1-mkhalfella@purestorage.com>
X-ClientProxiedBy: TY6PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DSVPR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: d30ae6b2-5245-4387-d649-08df1ab2407b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Qf18Gbl6sagrPUfZ4BZ4HRK7ujqDvGvM+gdcj8H6W/tiweEJCo1uC90Vp/Obv766QIiE67vLWpdpOHChXttSOfUIg3DTHM7DxsU0n8+68ZU8bFpOMvxXkkt1iiTjxJho/iwTsG8+Ty+RSKxKg3aGxQk769JO8/B63/Go96YpsYXhPMsok4hjaV4USu33NhN9YEs3bBDPogHCfxg3Edn+YWLi8BzU59XYx/Ti3qucfj5aOrIXfwurubXP0bsDBAU3RGjb2UiEQW1yMvQ/SxWsChQ+kH7bzqjKaSngZs1TwqXD9pdbak3bmW0XoqUyU4anKGhdvKsMjtl0siYknB2C/KQIEx7M1aDoZ+V6+XKVd/G2Yx/NN3OTJQOZB3c9zB/5bAu8wadJ/g4Mmt0loJ7p2zKPNIdmZGaLnovgb7ajGyCt1JB8cLbYzL9kyAmVCltOqmy8aqXRYknqpWmH4ugk8avKOm3Eo//Uus5C1bg0gxhm0VZzs72wn85wxGsEeQDf7lWo19mXz9VeINuYYu8Mk3bkO0sD8byD17CaSdJRJjkVgAJtTGPouNRzYL/PCoKAMEvNG6o94h6Sl6iFPKACnqvCwafUgmCjun5PZ6lmZ5sJFCamKLolYCosU8C4v677czqvWt1Fy9TOAJlU4M7zRDnLM+06bpTISCKNaWtIY/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QILolGSljUCo6KruELgJVI5tFlzPCwzvSqQ5RDr0DJMOPwG5Ro3WEc0VRGmD?=
 =?us-ascii?Q?0ApnNyM7QJ5XEL1WavifWQZw4ZdSn5sKrG5RVYEYdlop9gjVhMMz58OoSJYz?=
 =?us-ascii?Q?1Tu4WS3qqgmrgN9DcN0UkpTXFKibHlMziaf8LlejFrdS0odS/F4nISyh3B+W?=
 =?us-ascii?Q?1lFq6VrQ4XNVfz8dHqjPNLIkEJ439iecbUzY+fBmLUaWIIzrqw79p5KUk1Pd?=
 =?us-ascii?Q?jgJXXQjJ+aRwNgf3iwMyXaK7qCFLlMgHz/UoM/Hr+BdKoxXcVl9Q65nVpOwj?=
 =?us-ascii?Q?DXTn7FNc1P/i9EeiXlHmGPL9uNtHINgKAkYJGhmCo78zoYnc+qogk4lhXr5r?=
 =?us-ascii?Q?zfMRCpBwChL3Eoew3OLbGcd9fo4SY6tZotgH6xJVnIgwUz8sYbNkY9k9dzWO?=
 =?us-ascii?Q?kxck2Bg4IZFSSH0yuJNIWxagC2bNMeEHRBkAtCiZHuhnESkDXRHlMDB9d3zv?=
 =?us-ascii?Q?oNv5+FGvqdaYYf4GuhhcEZTmmWz8HIuXcRlRkyrLsDFQ3F+bWfoRDltATJS/?=
 =?us-ascii?Q?GmsfbI1xp/RF9LMClBFzYX2XlcuYQC2fJphrU1/NaXkLyQwwU0pS043hyxsH?=
 =?us-ascii?Q?mTvztRGqUbOEHsXtOL6oETDUR6e/gJgrikpSqpOwFxu8ifzr5H+Hep31GWxT?=
 =?us-ascii?Q?GTLfe3fpnKPkqrqZqPQk5mkfn4wYWb7Gb/fnED0mD61NY+2cTECCTtdAsLoS?=
 =?us-ascii?Q?VJosDAq0k/AtIS2gRxF7NvU7KOEFp6Kd61+UHvZnlPzJKHPjdOsCA4lWPzbv?=
 =?us-ascii?Q?XOZlO9NhrX/j4y7Tw7Wim55h3L6ADZB+hHElJHpxpgEK/uekatas03UqgORh?=
 =?us-ascii?Q?zer61CXF4497OaRkwb6VLVvlO+mLOElUM5VGmabgpHFnHiJukP79C3U6l4hN?=
 =?us-ascii?Q?93aS0tA86T/yFuppYPvMi0wMQWcgKPGMwPdRNG9qfktNOMyvoXrRjnZ/DBs7?=
 =?us-ascii?Q?imbbLjf1EZDB7r3gaPpyvVJpYsGNcudx238SFyu6+48gTQGdM+1fmP7q+Pc4?=
 =?us-ascii?Q?ic7kXb/qWULGJUY5V7VhkskyqurAEwJVQRyvGjXzMHxCNkzamjWJirk0wK2Y?=
 =?us-ascii?Q?WOaCz6WvF0Z9Oc3FZEZI/5NawadRWoVxPNdr7Sk3Z61+ry4cl9q8pfXbMNde?=
 =?us-ascii?Q?dN19ujLRMPnDMd4XO+i6Ybc47neWltbxZmW2FNW5iLcmfeFobF6aDCC1uXNR?=
 =?us-ascii?Q?gp1lG543bXb4IZmOyn7L/Npo7ai13zVoRrosve+cwqiEzqRnclhbMA7OHSVN?=
 =?us-ascii?Q?mB9/ZlaPrMSKyh1z0yE/S0I8MZaM7Y6eWWFtL1HqRQX99SXY011LFlpRUZNY?=
 =?us-ascii?Q?/tmZKn2UJPAdL4TEYIhnH6HCXj4hMqhJcpsDzUzjLPYh0fuz6z1K0evWu3/Q?=
 =?us-ascii?Q?8CHMhMs6UlXLZTZA158OUokumz9pxU2cp+P2C2qP1cO1qQGdpqfHavwbGCHU?=
 =?us-ascii?Q?/pzXnEIxdoWlObjo6fh6wwFPwN2K84ejRoDCdJpz7ld06MAQnfRU2bbNEfrv?=
 =?us-ascii?Q?h4qmlW3iQiwE3EnbGs6Nk2hgRcEPpe8tPg2dBs6vTgazjHFAQBFcnpGwQt1F?=
 =?us-ascii?Q?JORP79/I0OERc8Pi+mJG7Rc6BAIDJB4sFrMf8qjPW29IptSN5scd4QbpxUFb?=
 =?us-ascii?Q?g1Mcgi1Cj64r7s2CtauLZk5EYYtFtZpomebb53xSKyPLWKlLYljYWED0M3UA?=
 =?us-ascii?Q?7SCQoFjSZ8Vc7NdLMmIwTy1WHmfcJIOCcNfj4TqC0jLBiq5zp/ujqPpgCciC?=
 =?us-ascii?Q?6KcI3KR2acIJTp8nxUVGOmNyGRiGsLo=3D?=
X-Exchange-RoutingPolicyChecked:
	2klOlt9NIdDeAlCkZbzJBKokydH5RrgIys3tzjB5qaH3roumbdlxJWmC2rabA2hMcvDhwPF3zYHs6rIrZ9GxpX7piLvUHFhHY+uZFeNAZYnfUsapW1b2KDfjLGPrBCQShzqdm2ivVwt8Fre+wlYUX+0Kit8Z5EUwThdUvqZtP8bAqE5fhF+mN5BKo/SaBgOlaSjiYgrqc5idgXGtR+Kl4EjeDeCIig4kB3uu27WqiRqSULoXM04KGej7s0UNiyPKyd+MBjbOwGeYtyRVU/XYEb8ShE/2A+xEuRZmgPEACx10EjkKEDzX8Z6/LDjfRKv+bXpORbmvRB0JvR7CO7R2DQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c1LF6SMqq30/5dKKTcZbRzgJ8167yqEivqfTNOS/Bjgmz+V59yPnfl7LjZiWZalUMeFTU/aBBqjeyd0Lyu6H19CdYQ5uyjir3UykLITKFEEK4pBwF0Y9TGkKPOxkthol7XwCF+J1RwKfKNcNbmlYAW0CElUMhjwktAF8FqM4z8AywgxIJcHmj1A+QOymndVwmuhg0falT6HaXS1JtU+MnGgF8Nrr4bf8ehfTZ8ixu8E4T3Jbx+vL7grAu54+BOgb4OhuO9Gj4RmEsjWZjEU3eo/EZYygs0YF14t4hpi+7dy73UninmwxK5XA3VcdGAInlEwlIxKufbmez0AsHFM6GHl8YGwBqRwgOVHgiO26/XpMwruwYU4XdkIJ+lObylIScuX56j0/GjKihn7FisxUZ2oq+Yi9P38leC2GNnhN2LD44selZlX9UV+z75tV0+cybXyRrRoQxbUlTqaeDKQPdDx1eW+LQXREpsjg14zlLeEnGFWO4rXZd5cqnK6SHIVuXt7LXm9CXhdb33VkLTQDQ1hPK626mM9yrgPQBOzUZ5VBYkS0Pe+3Cd2jfXY9jtbTwlKNLB+PKyL1qr/VqMSmPdpcFpt/ags+stg3RUB+t8KlUUz97SzkQyWGNnS+AMTk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30ae6b2-5245-4387-d649-08df1ab2407b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 03:08:19.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfYR4tc+bC16BfSVrr8qrVFBOm6hjbTZUybRVt3YBIq7rKB0Ics58OOJketFvVt4Pdzc84R2ja9eGiuZSEwjAEMgTrO9Rux8GSmlDspoBUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR04MB10128

On Sep 21, 2026 / 14:59, Mohamed Khalfella wrote:
> nvme/070 demonstrated the ABA ghost write window. The kernel closes it
> by fencing a controller before retrying timed-out writes on another
> path, but nvme/070 does not functionally exercise CCR or CQT
> themselves.
> 
> Add a functional test that drives both cross-controller reset (CCR)
> and command quiesce time (CQT) recovery. The setup is the same as
> nvme/070: a ublk loop device backs an nvmet namespace that is exported
> through two ports, the host connects to both paths, and io_timeout on
> the subsystem drops to 2 seconds. In addition, the target subsystem's
> CQT is set to 30 seconds, since it is disabled by default.
> 
> The first scenario holds one write in the backstore for 4 seconds. The
> host times the write out, starts fencing, and the CCR issued on the
> other path completes within its budget. The second scenario holds a
> write for 10 seconds, longer than CCR can wait, so the host gives up
> on CCR and switches to time-based recovery, waiting out the remaining
> CQT window before releasing the retry.
> 
> Each scenario runs nvme-ghost-write-detector while recovery is in flight
> to check that no stale data surfaces, and confirms the recovery took the
> expected route by watching dmesg after a marker written to /dev/kmsg.
> 
> The test requires nvme_core.multipath=Y and is limited to tcp, rdma
> and fc, the transports that implement controller fencing.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Thanks. Overall, this patch looks valuable, and I did not see problems.

As I commented on the dependent series [*], this patch also depends on the
miniublk change. This approach looks useful for this kind of precise test
condition control, but the two points I noted will need consideration.

dmesg_mark() and dmesg_since_mark() can be useful for other future test
cases, and may worth adding to common/rc. Also, it can be refactored with
_dmesg_since_test_start(). Said that, I think current patch is fine and
we can do that refactoring work later.

[*] https://lore.kernel.org/linux-block/arOFG9-sM_GrrbQf@shinmob/
