Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC839282C
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699793; cv=fail; b=OTZWQOZNdHCUpTLDaxxGo2ySvy8CjGK3u5SJ7zZStXZPRL4uIlYM5TvInbzlit6+H7e+Fvl8u4cFMH7SNQbMGY76gXN9ivdINB5R9SYszPIWHrAygGNRRh5t1qcD7HGN7YUgwv5GnehynxeuGVzN9X0s8yF7VHN02Jt2UV7Tsb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699793; c=relaxed/simple;
	bh=6+HUjuxZOcK5rYrtBX3bc/ACdRsocPJYV8o2B7YBcOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/a5F7U+mA4Y9cLPrJ2cF0reXVx5D937eGihNa1s/qB/co0Td9fclT2/35eThFmot3QH6/ssPJwAn46dbACc4oJ1Mgc7942n+XybnaHXxD7Us6D7xdvn6KpC5/3pPh2T71A1LarTFUEHN4uXla3ydQmrsqagnetaAOlMAsWXA80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EiRvh2uH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FpMpVfJO; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EiRvh2uH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FpMpVfJO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789699790; x=1821235790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6+HUjuxZOcK5rYrtBX3bc/ACdRsocPJYV8o2B7YBcOI=;
  b=EiRvh2uHFWqX4VAAmIWDDv1nwn4COUIcrsURCyKGUL4MEhu4s3nDKyGx
   SP6oaLw09VnErbCOO0IJQ/9AJ6waOKsVJVoDjMY3T7W35GZnpRQSWHTEm
   2qgO3Jfrzor0mfRYCFCQ1W4/AnetHzU3kjCtXwRxdheMtHk/19ulbxDFt
   DAAq9MqC3ZceUkwnshtIc3Na7aHVdFki9FukRp2YaxoEN7l/waGw7bt3r
   EgPSwtFWJ/XVScgv4uLRs5lhpz+1QMaOVUvsWI09vEeKF3NYhqwyoTlOl
   zEDmR1Ji2Sj84Fpb8Ru9HtijiEHlTGwcy6kJ4iinQgt88xAxCA+0iPv8l
   A==;
X-CSE-ConnectionGUID: 7rHs3o9YR+WyrjiHzOQf3Q==
X-CSE-MsgGUID: qWUIKpm6TualMMKajlk/iA==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="156890848"
Received: from mail-westus3azon11010043.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.43])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 10:49:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddGwzfpfftaiR8v8kRIg7Pw9HwS9XWm3jEFqE3I3xcFoa5HofiC15rGsl6lSrXBkoqTJ7BPKkLb8zO4r5K2bYe5mx2yuB95sdL1LCMyM8dftnDYQbiWXKtRUU28b5qlCy8JEq0vgfdqj+R3ajFmLE9gRsrVwEHGkLYRgf+XRzm1q2GK1yIl1yfr/+yszoTQhUl3vJRg+42J11269glLNyhYZHh8jxcUtk0P38gmAxxKynnIyttfte3Go4c5KmIcgKcKBoS2Lg8f16BmLPALA1dwv++EfqytPda0JXDtwGj09oeXinAeWiG9HCIxSBA5cnxzGC1fgixHf9TT7iW712Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wrlDwmnIkhEqL8LiF42jg0crvnNZazIqyWO4ZR1r7s=;
 b=tSO1MzWL11rgdYKNhHLfZasoLaBm0bbgbF1OnJBy+YCYVGk+KNnIya2SaJeL6KjZpNhcGYy/is2/sJieLrlpD4s86et29U8dg4CFbZW/cKKhKxcsl8MjZy1yk55V1Hv6mKzS1oqTlz3DldSCFY4TBfu6pX2JhSCiyuBzyIPhCbwelZXbFzuyBxCDD6pWulGXVnAMU+JFLIq4fYPNaF7eOWfCvCpM0xQCFqR7N/kIqhWC11bfNBYR+WCf7hD+w1SqFEkMlxe8RzEDc0LBafFMaMxBWnpd7y4pIstSC4omKykUPGQ0eJx+rtMljBjs1PCGOcgLD0zKTtx/597OCk6DNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wrlDwmnIkhEqL8LiF42jg0crvnNZazIqyWO4ZR1r7s=;
 b=FpMpVfJOmSP9GzgFqJ0tVeFrwgRfhiObT1ywluwJ9uXnc2qTSrO3FOfghr8WF7HpAIcg9EF/6q11W3SNOMrZvj8AlArr9MY14Po++A7xDTQoQ7gNlLSMqgMcGmfMWuLyxnNIupZRxAgbgap7S8dtxehiuX8gJ5m5YLKnQKVFVDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV2PR04MB994422.namprd04.prod.outlook.com
 (2603:10b6:408:41a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:49:37 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 02:49:37 +0000
Date: Fri, 18 Sep 2026 11:49:31 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests 0/3] blktests: tests for the direct I/O
 fallback, splice, and bio trimming fixes
Message-ID: <aqyll5sZ6qrYzo3W@shinmob>
References: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV2PR04MB994422:EE_
X-MS-Office365-Filtering-Correlation-Id: 208fd15d-8305-4dbc-8d9b-08df152f7a84
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BdjCyba2dYKqWJ1Alp7BVtue7kdKGQLLr/MAmvktmSDs3t6bKfxKyijrTEZYpf8hgjEfGvcB4waGDwaMMCEiqBTwaprJhvKCJ8PykTLGVxFGyNervJIseEkK/rW3eLscdn0+YPVzc9Xwkz7lM0qXiiM1DrvOrC9TELdSx0O4CEfmq+iqdr1txv6Ng7j9+hc0bwND+fIqr96rf0K+Bsi3TI+Z/LZgNpJUDLIctWte5VUjOc8TMjpt5jcXBlMpTt0mZCC1WvF6vnah33oOFVfhlyLVAKAL0s7N5515Wwlz1SkRp1/MZ8dAoH+MtKgziifcAgPNxGFDIKAvcVDQY+B8Cbqi5goIiKQ4lEEhsY0NhNwkAXaKd8S/2VOLaCCkWZMJctiNXAkrLCXcNJzVClpEWH/Z4JjIbXcuQArjasc4B5Kn6J2htxdR009VYIpCiHRf0vHUlmKbAHkrtJBfGcprQezny7+cGLRUWAmjn45N4TuQcNtlMe3rB3YURIVayJpva5ambMdjWBfL8G3nh4p1OWvSoYnPi1BG1jQwHprQHiLKnlnXWf+0jCfWj/9C8qfbwyIUoSLyww0E7KLNS+XcRrWP8VnIu6l1/9hwcxNs28W8Cirw8Mbj3xW+/cdGGSubt/e7I0oY8fcQMjp5BHrSALOaEb8TMjii7QmyyYK+cbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lN9167LynbwzrOqD20N15/MvVA3OpxV0FiHijjdwt5kyINn2OSGEJYxjwXEM?=
 =?us-ascii?Q?h20zn4TLyt/I/QAaGwMSYKKp5kRDjKXE8gUxnUNxmFlYg+N7NWzWjJp3e9p1?=
 =?us-ascii?Q?ygWSZA0p51qU1gtZv46py69n+ySfIUpYn/kNA4xQABp9tvcMK2PhjI+fKjSR?=
 =?us-ascii?Q?zQzhtAHqmUJwhA4zeelUreZM5DVXDZU7YjITjAB76BEJNwd15ac3rILfa+tC?=
 =?us-ascii?Q?6w9UyMIb1FVBfzeGohVpKHdj00K3F1ryuPq/qP1V4yYjrDlR/amx0J9bPW8D?=
 =?us-ascii?Q?ASxC5WaGLcCk3a27Zu84TMJGwzAX/Gz5UyPzuwUWT5s8tSWiSugZtLAQgfOR?=
 =?us-ascii?Q?JD6NoHgwoDt5Ct+5jvOJG7mCPY//wph0rq/QFikGO4jX3d9s6CmedSizvwNP?=
 =?us-ascii?Q?Dyr2sIKbl6ta7Tq0ivUa20gUZqHX2FD+zQSC8GFvFKrGo5uJam6PydkbDqNj?=
 =?us-ascii?Q?tPLRuKWH+xD64id0eaaOw7njeJHRL5IvPmzPcmQqW/FnB9fp7fy0pk0MhFLw?=
 =?us-ascii?Q?z3q83opU474Jxc2cxHH/dGou9RH0zbgPsJiSkXAf3Fsik3glur9+oToJkUyJ?=
 =?us-ascii?Q?W1qeFBZgIMpsonFW+/To5VBc/Sg1gHm4ONor6NZIVmJX5Z+YpFKlY1VTdZM4?=
 =?us-ascii?Q?Yj4UR2fgOUwG/V5Bo8mJDwkgZ7YAKLlPGCcRpJ0y+0w17p6wwzFojl4cT6Mi?=
 =?us-ascii?Q?xtLSQ3preV/Gx/+ctvuCirYueL2/w8HTLgn6HrEyVkVFTCE+mXDCtPGo9oVr?=
 =?us-ascii?Q?Wu6Kf2nR5MbjogqYqY42O98e6NwidLrOAqte5TYszXlaDnICOxYqCSAJCgW2?=
 =?us-ascii?Q?1ZeJYog8f1vqDPkc61R+86Q4odTT88PeeXSccM7dfdRswIB05A6bF1ACtlmf?=
 =?us-ascii?Q?266gIhnO6uuUjNETZzf5J0upy30pxc9duq9mCG3YTKwGx3brP/00X8AfYTJf?=
 =?us-ascii?Q?o3zbaZAY53vocPMsJme/RfnbQR685z+w5wxxD0/hq0Nqj8+T3s9JBXDbcuor?=
 =?us-ascii?Q?ds4/3e4Xt53/24dUL+xoqaYSQv+T0UXg1iU1/NJyJVumTBhgHqpEV9ZkHl/y?=
 =?us-ascii?Q?l3k6gERhqwCgO6yZ84o7ZaFq7w+ilmYB++HAk6oT7sw63cL4vfWCf4a8KPtf?=
 =?us-ascii?Q?ozeCTnprn3fkOI5dK7uizz8f7IwqsHSO8Htgz8n6XrEEDiqAaRyc4H6LHJkY?=
 =?us-ascii?Q?N8cc2IwWQXXbcE2mVfHZyPdTewDx413BhlAoF2M9TmKOwi8V4JmTHi7oin91?=
 =?us-ascii?Q?JYKpXyF5wBX4ozHoxZAVFzKHUCcVfELATfeBuZrGLEROC3G2SqN0Fj6w3Sh/?=
 =?us-ascii?Q?3A+d3eetQsfPRIAsYv9wEGhVoc2tJnHPYjjTcyKum7AT/1P9LvMrOpkbWaE4?=
 =?us-ascii?Q?k8GOpdzWA9ulNEmWghj5vqSghOVMZ6NeO+30ciV/fMtgo4yN9+Av4D6pfZwu?=
 =?us-ascii?Q?uMQuEEgsxm5W4ABj3FqBkKphJzCG0OzaRgTGmoceTiB6/fgQxIfDTeSsggwP?=
 =?us-ascii?Q?/fv1pxncb+O9TFtXFDIi5PuzKRQHWvohRxFMq4fEniLZ5IidSvy4fnnFyCGg?=
 =?us-ascii?Q?Z+Ft1Z2H8PMdEknRlYIgcOQIvaKMleqDghIs/GrUaKJXU7VNVoLrYchX3O+N?=
 =?us-ascii?Q?fB4QrGrgA7+XJH6dWsVF0N0AuDOQ7xnYRkhxpiq+JXAKWJOEdVu2e/2HFYJe?=
 =?us-ascii?Q?zUKCk5nNHXuB0nrDz5EbrVnHSy8+/l9PBJimxy0rb9zYBpeiSmsfQYPh+z3X?=
 =?us-ascii?Q?3iAD0tlHdeYc3fpSawlJ39vn/QWJfhk=3D?=
X-Exchange-RoutingPolicyChecked:
	TA090czk6+68wZQu5FBkYn+ZbWHQVoa7aiep1jTAmgTdppKahlk6Pk3aH/K1bzMLGkt1/Nf4b8/ztS9ucMiAxsjvCQ1fElz96FU5LI7MLmlVlHMcPfBK+TuRm6WlXyAhczVV3hm8t13oyiQZssbn73sGx2sI9ZYeiVV7Eko9lez/4GsqKu37R6yHCNAxDW7sChtOJEAnFe11A6clgaK+cGEG0YOoZBjbyk/o8vNxvBMN3gDA6sIK4jcu+GxgcYJYwfbrUx8KS8n86+Y1PTbV1ROLdeMU8yFLMIciIV/WblQuD0iLA1RuZ41QIsG+QekCG9Jn8MenkLwfm0NaZ28GTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	geNsn7NQZACNWE9dBsGkZkyQ97dOyJ2Uca2lFviCuTG4q01EaSkADL4vgtMV3ZHqjRts/dIulvtrEby0vuzihzDikJQ7St+VoXATs3DdE9nNXHEL/2Ur12eL881r5IUxa4vwDtpUt+pqUPSodVQoPLWGRAlayyZkyXOL9ZcNvi9fZU4+HwR1xsNUSBJVcnxtt8tiVtIPbjveXminptl39G7VZLUrRKuD2xx1rxIGRzh9sk2N+eb0E+NVNvqPGqIJk6Sm2wY1870nD48oNQfjfUKZ+oe/Jl629r+GkspFL/Y32SR0rh1rQrMsbQWHDznWIfMClXwSj7Ftwzuuu1U9nZMiK2EhTAhdS2Z8PWo4k/JpM0s7gwMz4ubObgRDVsHFQAygCe+a0bFfkmdSUbx/eXL43JtPhZ7KE5Wx9Y+ZhNbMhg7kdKsFJdwU429tHbK0ZMXD8fyazgIgCg7yeY8k+Z1U5Zk0Ms/Nv0aak39kpYiM0d2xJnH764A18ZLOQCt5YKalx2WwbbmwILrvc5Bz4l8g4Bzvi662c2pfFanFqJOjyJ+ddOTE2WJfdgonzItnnkVqNucxkfagIfwzXR/VeTY44EoEohH+Z+4rAbtJ65aZ6aUZBvBxfBydYXaIJXlG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208fd15d-8305-4dbc-8d9b-08df152f7a84
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:49:37.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQwM/4xgkT0zhc3ftnWO0CIaMr11wNLYotw1xJCeQicsJ7JdfOEeWgZLAKetNr27LPkdcb+9uMjzVKe/GKZ2Bes21lpZdtedsReT3/oR2gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB994422

On Sep 09, 2026 / 15:39, Tal Zussman wrote:
> Three regression tests for block device fixes under review [1],
> following block/048 for the first patch of that series.
> 
> block/049 races partial O_DIRECT writes, which finish through the
> direct I/O write fallback, against BLKBSZSET. block/050 does the same
> with splice(). Both need CONFIG_DEBUG_VM to report the folio order
> mismatch, and skip on kernels without a 64K block size or with 64K
> pages.
> 
> block/051 issues trimmed O_DIRECT writes from a hugetlb mapping to a
> device with a 64K logical block size and checks that no huge pages
> leak, covering both the dropped and the shrunk bvec.
> 
> [1] https://lore.kernel.org/linux-block/20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu/

Thanks for the series. The patches all look good to me.

I ran the new tests cases with and without the kernel side v3 patches [2] and
confirmed that the test cases trigger the expected failures and the kernel fix
patches avoid the failrues. Good.

[2] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu/

I will wait for the kernel side patches get settled to Linus master branch
before I apply the blktests patches.
