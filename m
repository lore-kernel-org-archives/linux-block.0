Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EB7F9
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939057; cv=fail; b=VYmBSgTynQu3Ox0aCkZBFox2YhL2tSZhB+TVjs6IPRxCQemAFnJiSgjczOf+H2lCyHWoFZgmubuHBp0Gsd4zSx/Xe8rR9MdgT+8NOwE8nC1As7DFHZ36s/mVtIObKqkGjlMCpkqIOayznmGVDcRjZi9FyxjY06gT6rDS0RVaUa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939057; c=relaxed/simple;
	bh=DVdfLXIt8C3gyii5mXkkmsePYs0VROpUgkCYE1+2M10=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CzWY5k6lHlyVLvNrq5tN1GG4SlNH2IaZWmrubXJuQE0pe96YRNZ9mKnPXaCQDayEb3kX7g4avQPIDKDidkwEPxyj7JgTfCx/Bd52Br0fCQY3gHr916Fx4p3KRYm94TUQYximIAEFqJS99O0ZoZwBKD7mT3TLpEgwLMZRRVs0QbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=cDUFlw3O; arc=fail smtp.client-ip=40.107.117.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="cDUFlw3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VI0F6yQ88AjF41t/oPX2Oh5Y2D5n4gHlE0coZvfTsi/XCFoLUtpxc26JoLlYQEO/Xbw7zO1QlAxczW0BdodZKjGlZYHOcCV2rVKovKuvDClmObLcu3AUFfwkZ+xRCM7XT8w8vIKCk5Out4A6k6hJfSPtZ3lLC4fiGSDqVuiksVt9ofyV39oVOBw8uZaCa9hDp8iWf0xWVbgtjdGu13zqIKJsWTT6ZSmi5Mn+v7fsdn0UC7pLj71kHtqL/OTtB9pg5ZycfCOzc9hwD6IDVGqdf7O52gnqOAtlQZ1sLnNYddvhAXxSW/V59pfwLa0QLthpkUnhFvwPvkofxgoA5xLkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT8NHOrbSkLR49lZbRS/1mmcO9oNLUw1+IXO0TWJ+UU=;
 b=k9Nvr3vd2bZdWFG0AZiCDyeIGVCDyxgJcFXGxvrVwizLw9e0NNUZeivznUeXaqf15urs23mzlBlKFAKPl1ENXByKwyOIB1MG4oewLfJfg6yAj7jN1eXfOjYAvJmHwDQF9HqE8Sx2W9aIEZKk65emPVCglcLXzYMyBhSkRbBbkogEFXfnbs2W5qdxQ8YRViBmzXew5Ia532kn1MiDGtBAyuO9FOHPoyVUHgxqptUneHOP2tHJYJpXoMjTJ7qXaS1tZmuUrwOGZlc8lYYEpB0IzXXOkC+/1M8mJBAKduFbFRRkh9731Soe/RlhSryASt+HHY+4mLyDhjaDMx57NdDvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT8NHOrbSkLR49lZbRS/1mmcO9oNLUw1+IXO0TWJ+UU=;
 b=cDUFlw3O/3h+bPfVdO2gVQ82VJfVfk5QmMLba5L+IbWZDnU21UcVzgnTNHxShyHdlEzoFpqjFXZJfbYxInl08lEU9ogDageVtjXxSNXKp7VtqjXPvklOh+e5eyJa3fHsCkecxk8gJHRpUFVqv6PmLHHEfTd9UgniI1LOpafbOmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com (2603:1096:101:22a::14)
 by TY0PR02MB6857.apcprd02.prod.outlook.com (2603:1096:405:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 00:24:12 +0000
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b]) by SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b%6]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 00:24:12 +0000
From: LongPing Wei <weilongping@oppo.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	bvanassche@google.com,
	dlemoal@kernel.org,
	LongPing Wei <weilongping@oppo.com>
Subject: [PATCH v3] block: get wp_offset by bdev_offset_from_zone_start
Date: Thu,  7 Nov 2024 08:23:13 +0800
Message-Id: <20241107002312.1643655-1-weilongping@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To SEZPR02MB7967.apcprd02.prod.outlook.com
 (2603:1096:101:22a::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB7967:EE_|TY0PR02MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: c265dfbd-83a0-4030-fd24-08dcfec280f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZiSCeBSr+PuEOfBFfAMMyf4iWVu9rctet335hXwmbb4jaBJrWV4pBLLLR/Hm?=
 =?us-ascii?Q?mqaWdgQSxNm6rK5114N7UfWWEZcuyqTNoy/0HXMZW/h899NrZb9b+MD4OTov?=
 =?us-ascii?Q?y/ykRJcyNmWFmA1chpeYYG5oyCZQOaS8w2E4e82mRBAf3VxNGGWUGbLxdFMQ?=
 =?us-ascii?Q?+q8r/KmgALHO5VQmEY6qlntdc0/BNy3gWXVaumUElsQphLL3j+3W4dIlj+Ou?=
 =?us-ascii?Q?bBxOKEfVCcj1iAh/GBq3Tt3eE+ILhJMNWrHS78+aK8Qmj5gVIcd0pskjqbtX?=
 =?us-ascii?Q?nrjNFuOhFnNM2V0sfmE/83ESbggjVsKEjgs+KVsJbPkWQLs/uUhMhe9BCmZq?=
 =?us-ascii?Q?Q0tDrvKk30ebqKAmdc0RI9JVFKZYsdkiKnTCbr9obzp+RCZrsKYV2brB1Afa?=
 =?us-ascii?Q?CkZ6uBwJbIHPI9MpRnWhAvbOxVmTomUI/f0mRX8oaFwlUuG9rhds4IVdn7JH?=
 =?us-ascii?Q?E+31g7MIcORUdLCIogHH8oDrOmXK96N9/G6NLn4t0FpSY60yz1G3Fux0LUQP?=
 =?us-ascii?Q?4y57sAEuReeIBLflSPIZ/mZgERlLjs45t/iPe2m9iSLGpnG71ue7ihtu6NK3?=
 =?us-ascii?Q?QwPAcjMOPkjMeNVWiiGqaLaPdzHi03kys7Us//zwl4kT/1sbXejvdFUyz6Tr?=
 =?us-ascii?Q?FhE2e9niXGJ0/4pzUcwLQyq/spwjHV+0ziRI7DLJjuVQ4wztQJt4BJRk18in?=
 =?us-ascii?Q?cn7aXcWl93vmSDtc1H/orWu3Y6XU7ErLB4sF6P9ZStE6Oz60E8+0Hgl3LgDv?=
 =?us-ascii?Q?MNSFQzgNDXLWcAu99hNU5j1eWV8OmcImubF0kkItQhvAQNw3GfcrDYeRFhdq?=
 =?us-ascii?Q?6Og0bjG/mP+1zdOCFHz8j3SarsRpaxhbJbPbgzT0pUeyEiZd2+4gv5ERzqY/?=
 =?us-ascii?Q?83670XJoVQK9JblMj4R8cUUb/P5EOOlPA9ZT/KN7tlsM4LsrdjCcuQWq36Jz?=
 =?us-ascii?Q?weaC1pdWsT3rupr3njEfC4Co4D3AAbzvF4JTkrjTwybYLUeu2VYiqI8SHelu?=
 =?us-ascii?Q?F30K1hV5RxQoGVNFKTu3mdBVNvdOeN7sq9WF7ohR+Xy1SZHDofVUylmo6p5g?=
 =?us-ascii?Q?f3cVO/04tUfZ1UN8pnokHmHxxoRdAqE1OSKmxDnHhrFy3A6mqwPCd2Cbqbi2?=
 =?us-ascii?Q?cTf1fbKaAaXyzgXLnkmKM8zqTRny6p/htF0d5Or0UvIHHqg60RIWFd7tOhi2?=
 =?us-ascii?Q?RsJBxiz8B/YiKw561HhZWKsQxvNkrEQoF6cO9wD9u/TKHYn2COS9OBnLawfl?=
 =?us-ascii?Q?+ak2Oe0VYKtjBI1xwE6VIXCcMR5WNIg+FaNt9eSOLs24qV5YoTww6qVAmzRm?=
 =?us-ascii?Q?22TItng6WXWjFMJ/npgzqbAeSq0+qcMTQEHnUESh+69ctJ8HW5FkIk/xcrqJ?=
 =?us-ascii?Q?Uw8fnVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7967.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DBuGRLUVLPpXr+XJBOpPK18O5vcKZa29lrlvDLdxf6544QwaP3M48zjj40wi?=
 =?us-ascii?Q?639t1CC2N7V86hC3yLvChPPz1o0b+jIzeggcU2mVcsRjYzBciIb04hY5GPaH?=
 =?us-ascii?Q?pa0/wj5UYqtHYyHoRvOJVlDPN89GYlgJBknyrHBOFxbnxadMhyahGvX8TxDE?=
 =?us-ascii?Q?3r4V7DIbBJkOtWHN/93U5rP7EUpBz0FgGKMyvOKomn1iilRMMOFjWo6tvpl1?=
 =?us-ascii?Q?D2ucdgiAo/GJUtUntiLjDlgeqsUfZgMZ5Vy5HCv1wxKdnzAwOO//YwyWLA1S?=
 =?us-ascii?Q?YxZ84YUtVWJnEplciwUChDkqf6FVu/0WigA/gYHPh/RJyQnZqWvG9PuaRZdX?=
 =?us-ascii?Q?/zOmGZIRHgFahWxP9LhJxgoc+CWMm3A1poeLoEHAGQND2El1Wv1pMTSsm3kZ?=
 =?us-ascii?Q?LJGvj4kNUL3ab2mhmJwQaKZ2nxI4vcUln/lLB9GUEWmh1hhWD5lOag0txIKE?=
 =?us-ascii?Q?0M1IfCvDzkWmqJy/vccICtrbRl933X1rJ1lL7K9PorFor4MTb5opPGOL25iN?=
 =?us-ascii?Q?9YfEpJhjurgrFiD3zrXi2s+kHWSUgEhcuL4lV49iNeU4wqhUj2f5v2DnTr3N?=
 =?us-ascii?Q?wwHt1Z5VHH6dYoLJGhe+x7Kv1IJEfLSbwO4iF0988Fn9YDP3T0asaKDKtp6S?=
 =?us-ascii?Q?5LpD2k+biviuKfRK+nVhfHmgXZN4MGTnqkwuhp2lbsV/Q05LF38Z5rOG3jKu?=
 =?us-ascii?Q?wZply+Z1CkB3C5WRsYsbSNwpPOI0XN3989xfrFpxI/9nfx417IOhqasdg/5U?=
 =?us-ascii?Q?ZemVHD3I6I/Ha7BbRRb/IZDvlpHzR7iYzrKGUcWxVRabz2LXeKPJqVo9so2D?=
 =?us-ascii?Q?Czo292Kja15VcmoRVLzrrlmg3mn61/276WY2J5U9ZRFguSxLpFwgTlPHar4R?=
 =?us-ascii?Q?80EpAxGrHdeuu33LMazlACn5VBoaJKqb5oe2BLLF5RAuMQ4zpH4j7FYStqtm?=
 =?us-ascii?Q?8Xfg8StekC/6q6VdZjwcoTUg1ffjYHWD+Gy1IhnTLjdlFTIfJHz17jPRWfpa?=
 =?us-ascii?Q?Ooe8RRmfz8VfPduwRAu4Ri5lcIPgp2Gg2dYi//G8sMF+WZKZHVs9LiP3hlDu?=
 =?us-ascii?Q?Vdj8cBivWHDWHYfABOH0tKxfpCKCtwfvW6h4ETwrIga6zftvUobPqNMa/Pr9?=
 =?us-ascii?Q?J9OA9tjWq4eLNmpBk0MiXCIZqMZNxd3sGQdJs5vmZB9sadwoL6yi9dnuCYPx?=
 =?us-ascii?Q?rNd3EkxR4LL1DTDhHPb271zxAKCEqU0DBIoLlStsn0qc1TM6U7zQcN8dCBGz?=
 =?us-ascii?Q?IJfEKYcHhhjkPrmP155LAZfLiVDpR16xKTx3Gl+CF+9j+vN/Y5fdDq5Pib4r?=
 =?us-ascii?Q?+UBs0KtMleYZg04wXx58G0NCm1woUhncyVFkAFsogzDSlByTk0vfoQ1elnIb?=
 =?us-ascii?Q?t5sN30oP5NLqiXg4IbrqgP7W5GAEPzeDMfxGH7XXooHlzgK4wIO5T2QCDtV+?=
 =?us-ascii?Q?MT8vOGmbuoY5Yea9F+WMf/zp7MGpuT09rCHzHj8Dq6WyOzhA9+3gBbUes1B9?=
 =?us-ascii?Q?qAtOa5ddqvKOSU+mHIyiaPOm2B9ok3v1b8DBDjPg5xxWgtxQUoTuvPKwt4G7?=
 =?us-ascii?Q?VAkP5ig5j1GEPXYgWyEMqYreycuy+B3uQQGV21Dskti0qH2zrGkJ455kGSWe?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c265dfbd-83a0-4030-fd24-08dcfec280f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7967.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 00:24:12.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSMWc87h+7bFtGK3y2K+fD4mfAVNP2Caw/R/WX70UY3nSRCzrTXDxuSAsOzQ+Z2g0ikulag8gwFAwV+Q32aERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6857

It should be better to call bdev_offset_from_zone_start()
 instead of open-coding it.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: LongPing Wei <weilongping@oppo.com>
---
v3: update commit message
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index af19296fa50d..77a448952bbd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
 	zwplug->zone_no = zno;
-	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
+	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk = disk;
-- 
2.34.1

