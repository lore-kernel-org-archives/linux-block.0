Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7629A326;
	Wed,  4 Feb 2026 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176281; cv=fail; b=UoN0prPC3n4qtPfr+7U03x1TqWLtuDhJGe4CqnqmgqHErbDWMNQuAmm6hC1845hYQNYoNHJttUR1cwAZfMamEJ15BDBVPniPl6Fr6XDtN6aBK61PiBABkljStz900BncWSK0lUSAA4gwYboil0etLb08PmL/MOcKA2g4Wvxgicg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176281; c=relaxed/simple;
	bh=eWLIgtIwD8pWKPIXBjXJvioe31fNNJkSGazrIZsD7qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMjldD8qpDZrVR33m38tpVrL01n//82wK12w3EDE1U9DTMcOUh4cKGDCYW1x0JDGijta1HMKtn8UF5UUyJW2mJJEnRkYxkFAL7X4+eKOn2GicJDL6W2UrnSfWeIH6VCREQC8aJgJUKWurtqp95cQ2uZ99q6AhMkUCrDVadYOryM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UgEFf+ch; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgEFf+ch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQy7emrUrkyN9VH8NqratTsyiJY2pBIaPfOn2WilnNoI/sZip4J2qIljcHPR9ucL49iiaXpgYrreCkfpmmewcOrMWIE8RJhIeaMORROBvruXfpsLZKKK/x4lR+RlikmyfATrbAF1qdNi9OGiliWod8dMM5/Gen8dW1+o0WHO2xb3+1YCNPNOZ+yPjB/a8zHYDK3+bWGe6SR9gkXqwgsUmxMCK7+qYUbsaSYfJy4v13j57qrxwX9XZJiD9A6d/KKwsVDy9UzPNtsvTugpLBIx10+lC8pqWPYH8HRtRfsrhPSz2L8s3cPH7i8jy5TilXON/2FsoTxiCyNPEmBlEXwp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if8lz52Ri9sqiQNyQVQ+M6p1gmjfiwJe6T1tptUzQNo=;
 b=yTk6Mgelvu7p/jE5fQIWr75NqMSkO5tWYZpRI3aTrfvVyq4da9xTZlv4OEkt1mxgyHK6wWcLEOIiVEOYBhX69ErpafpWuKBz6jKlHzNzdsSYkZjKLSRaXguHMHCYgAIbVfGIWeWEJse5drWE9143ZdiUy7q1DZ4jLTC/PdNnU7cG5d2GZHkik81Spv0hz4C3GV01NvKNVJpIo2sBUBajrw5ANkVwOPosmk2rW0cNCnT74QxVEvk3hw7+eEIkBB0QJKSCCuaZONVZHRj93NGDSttVDcxQa044kr26AnNojM+P8o3kCzHgTE+y2iDixAtQRqMbBM1A+SF8Zcl6fZJO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if8lz52Ri9sqiQNyQVQ+M6p1gmjfiwJe6T1tptUzQNo=;
 b=UgEFf+ch4Yw/V8W+4VAzQzAChPnxj48AgVQyWDYIfg349FWbcPClO/EELpRSaUZ+0lU51wuBHLpM+PJzKD7qG/wbO10YC6wWOOJ3WXeU6eVyZgRIhqai79hW/HH1IhwqYTK1lQ/1B0htbBcC3lCA+6rh8wc1EfyXlrkzGn0G74Brqni0/8R67UL9a3kxcnEhCpcKJmm72qZso06Elv0fAzLugPUNRfUTP0Fb9tUOp7s5Um1dri4gVx9EZ+c/dbsA6B2/TT4GtzJ4CfTfst75h9lj3Xi67UXi+NCQUcTwQG1oHHPQ3HZyWnUhO4tCfFeufJB+FLoPqzvR/r1PNkEpFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:37:57 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Wed, 4 Feb 2026
 03:37:57 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 1/2] block: decouple secure erase size limit from discard size limit
Date: Wed,  4 Feb 2026 11:40:02 +0800
Message-Id: <20260204034003.2961402-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a121f3a-1f35-46eb-7e2c-08de639ec990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LECOq4MsBLTxKsqYql1A97CbzHReDV39hr8e+o0n7ef7kxCOXYZ9FCmAH+ld?=
 =?us-ascii?Q?55wOOXmlMFIrq2Fg14S42dxDXA7WFjGkcWlT17hOYm1+tl6MX5yJcF9yHhDO?=
 =?us-ascii?Q?q3qOYQPH6a5Fyz6m9+zJZ60hx0Rw5l1fy5naHN4LGVoDDqwlom9lenCSL9m9?=
 =?us-ascii?Q?hX+3SwVRrxkaCJexppUPgmKu8IvdwK/4/WCGcqCe3XJgPmw2xZdPzfHYxWgN?=
 =?us-ascii?Q?tXRpkNR0Ay5EegNSirxPSwAPcLzMMRw5vinA5nmtEYZy14goP2XqbpEoOnL2?=
 =?us-ascii?Q?mkecWbyo2y5crsoj+0MPHx1YVFcwyVTEy01ZXPChY+l59Wq8IpFxqguwQ6s1?=
 =?us-ascii?Q?M4vVE+mFRW61vtQKh9F5abwVET8mWUh3MQXCJ5eDqMvbDPGCqo37h3GNxFAw?=
 =?us-ascii?Q?lPhq6cCQW+MUCK/YJWNkTRgQJSzx6cJgVk3C9OWexA0d4ngXbkUs4dUw+pgg?=
 =?us-ascii?Q?hb273mnuUFEohb3zIN1MnL6B08j5sfNbpNqt0zxHlljxQgmGrbMw8sCKTH0H?=
 =?us-ascii?Q?KBiW4KE3pdngr8tBKrWnIRIGoSf4wUCm8/EwevdsC6f5bfqJOH2vxcELFJWq?=
 =?us-ascii?Q?FvGm3Uk8jxzY67c/mGvOyg1aBFUS6h2dFnhQXjPQ731EwW2ODrgDZqcaFgjR?=
 =?us-ascii?Q?61zXcJb4ldq7jG20m8FYoFnlJvXttX5ndhtxHRhBXYnLMJvK5+WeEw7dcaE8?=
 =?us-ascii?Q?XnGdvKpsCyLhIMn3ZsQ0J5k7l6sTM13RaswLGr+8s38O0Sga1H/PdqZ95Exb?=
 =?us-ascii?Q?MC+aZu/sJQHvPw5nIjbbJXazMm+Qu/KvRqVGd/IQ+r1HhTSlgKxrqJVhvz81?=
 =?us-ascii?Q?Y/j8C4LioBMP/4aj4/pfs1gBezIShQmTC9923XKwxNXrRqtZBXOycQO7RJQs?=
 =?us-ascii?Q?45Xw6X0tVpNskt1JgRXb1/J3RMFUxfalO+ZIl5MzBXMzn4QHpDBlcZC/jKWw?=
 =?us-ascii?Q?BLAMHKCANbSL2EaCuniu9AwHjRxsu+OvofYIpe03ZYXXOuklxC4Z75ejB03X?=
 =?us-ascii?Q?SCq0dxKw/ChU1jHHYPYhq9AxPzliUbKm3vfqrJUhgTFxvVSrDL+duKqJpLeQ?=
 =?us-ascii?Q?3tHo6dHJh/mECtzTCsFoA3wDUSJq7NZ2pO7/RfQajbvEmASjp8l1QZ1xFO7K?=
 =?us-ascii?Q?kTRhJd7sELUiP5oMFuzTd6wJ+Mc4DpSBeGwzF46yTlYhlgWbiu5xQ7WqMGzG?=
 =?us-ascii?Q?7tknFdoqksBJimgGmJq6wqHG5+ZCSFcrOhL2F6VVLBi48eQrf6UF+uyTFJtY?=
 =?us-ascii?Q?ryfg2kjIsoyYbdYl7yK9AGgdsSH3nzTMcuiY8Q9gVK08kHvw+xJ024vspZ7T?=
 =?us-ascii?Q?sayw6ja919pUomWzzUvQQ5QgoKGJUqMkvDzUjnrKSckGwcgge4X87n9UTm4L?=
 =?us-ascii?Q?QLBDcToUZ3qa8hRoWeBESE3GUWjOEYHiH8t1pi0ryN1P8SMYAE09J/cUBHKT?=
 =?us-ascii?Q?gaiw05U0efqFg5dB+GCkAjP6ztHl0t8OTB2Y1EfKoWCswU7OErE2TpVd9NrD?=
 =?us-ascii?Q?DXRrqbz2xPO7JS6ONE5Cm2LKAogh+7ayucY6gXvICHX6AQSfJlNh1OlNJAbh?=
 =?us-ascii?Q?vm/aKR9QkVImDM3UHlejMxM2hs+u6Id/i5dU6rFF5Ws9yycmsC8mOrPQODih?=
 =?us-ascii?Q?cN6tNSntQyAbtHSpycwcQ78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khIv+mpYKRwOeQb55im91hcpeV2heMEMylDrDAdA4iqgclSJPUKiLaR0HoGe?=
 =?us-ascii?Q?jpF0aX4bqdIRHWbKJStt5ZvrF33/++JiGfqQUa1Lgw6dD6c4ijOUUCNudgjG?=
 =?us-ascii?Q?yCq2J75KqQQTKOi9qqEpokYaQt0QlUb/3j6fr9CWO4wt28VOmfXvwyYyo+Ha?=
 =?us-ascii?Q?ktQsu0RqpLndS7JYiYIV5JQlHmRWIN+n59M7tlm6IuwT4mko5smi0c8MzaR/?=
 =?us-ascii?Q?hghJbAtrl8OkO7iAUfh04f3LsWaXZhGpdJNvvC4VyeXNuUuhRZ1Krn8bOV69?=
 =?us-ascii?Q?O4fq5B5WVl2l02UbMWYHwdNmZT9eV04/yeNHzMAUa7ed4hu+TG5Uu6Z4h64z?=
 =?us-ascii?Q?s8aii88j7NDRlp8ZOUXSmqfWQbq9MWFgrAaBJlzBAEAGEJX9ZHEddoHIh/+0?=
 =?us-ascii?Q?Hcxjupxx2f+DxzWr7Qhz/5P0JcETi4OMgM1JeLCoWUlCYyXX1rv+51WK/5Uy?=
 =?us-ascii?Q?lcQ6VFPSGvLssZ+R0oZfKtUdSSNR/oSI80ppES16AWwf4dFMy0+KuBo7AQbF?=
 =?us-ascii?Q?pjKT4K2ZgtDbWDlYq1LfFNAz8IeDQN8F71HU6dqkqVpNnXY4Vq4P1ICcPO/+?=
 =?us-ascii?Q?tPZt+wDTCXS9MOoU4cZTRTSr29FH4DPywIplmO85MVqpt4JP3X83MUX8H0c0?=
 =?us-ascii?Q?t/dzNU3HkTJI7tvMObqhD/n5+Y05kQleFO12IY+BImZxgsFOruYghPsSy9k1?=
 =?us-ascii?Q?nkYvVYq7ioajT4+z4Da/1OH5lMTbhMTJHyAVPEKIMMp4cGKEySEhn/FHPUih?=
 =?us-ascii?Q?r+FHXqg4iXt1HXCwJCdN33Vm3zj0ueKXHcBxE5bm/4E0VtTP2vOzVvS3Zgll?=
 =?us-ascii?Q?0/EgGduUES5IqgjI0ujlx/Wj2FZC0HFOfz9zX3+1O47IYXIDsrRRO3LxDUVN?=
 =?us-ascii?Q?bqHXO8nclystZWFCFyh3mGX/Y08qD9VAgDVlzPBDf3r8YgACnTuSe+kGqt0x?=
 =?us-ascii?Q?UT9jtiDKvd0z5uuhhtOPy1edepBhj4bjQXXbJN2O+XP6Uocl2LfiZUfIVaLh?=
 =?us-ascii?Q?i4n9N4OWKAaOUx/nhe4yFBDIkV3mSEQAw/36N/smLbcQiKx5sUO/l7Azvy43?=
 =?us-ascii?Q?u/1KPVKGQJBopMQFh5QchRKL0FAPTiVCaHJrEVsJWG7KRHQg7DlVJs8jru2E?=
 =?us-ascii?Q?ctKPxIhGJE9FLDVmEvo0FugS5bAFWgb3fWBZoGjrxKz3piuYbVVv9aSIRVeg?=
 =?us-ascii?Q?H6KQhXNP8uBSZE9tDkHSjLjqNuTpOoMaP9Tt9ACZqaLykuZMNlmyOrOL5bMY?=
 =?us-ascii?Q?buxNHV0Jn3xJKuSn50161G3GJwoBeihLAqlVITrzHhzc6IEqcuUtNe4WKIBI?=
 =?us-ascii?Q?dPYx3rDzJKsRZG1M5N1sRt8Qc/+Td58IVW+mjGti4XOIRxCyGBNFtl9bPtsw?=
 =?us-ascii?Q?6HjbREtDNlwm6hNc5Svll3VyE44f3sP1Kn6b+pxzXPLB/eSVVD+k/dfl7LHA?=
 =?us-ascii?Q?rdag0vrIdVwOxas6uzpcwnmqJf1sO6h9HGcwnOGIl3y6DUWg/fYP2iqilsO3?=
 =?us-ascii?Q?VybTzv/J0a6RbSVi+Ikz1niNX64CktD5Kw/roswmbFMRZj3ZGhOIRN5W/5ud?=
 =?us-ascii?Q?Y+7CswXphKBATqJhTp55Qe4Xccaq3WVsfKCnqdW76HunxpoArfzwizWmg/cf?=
 =?us-ascii?Q?cNFbgGmq6l5WTN6xzy3wbvzjYd2QAWEDBshrkkF3591kjwuJbAJznSPTA4Qe?=
 =?us-ascii?Q?YXB7Xu7RRbr5OcBHu51UiOaTkHya3NpZbMV/a3kW49z+gKrrjZI5119XOw3n?=
 =?us-ascii?Q?s6/jtFaLPw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a121f3a-1f35-46eb-7e2c-08de639ec990
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:37:57.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBqERj8yWNbeBtC6/A4d9Rl3UahN+YkHvwBiuDsgqtMmB9+nLHRVXUMCXuct+3JNl1YsifgyED9CL1iEAe0Mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

From: Luke Wang <ziniu.wang_1@nxp.com>

Secure erase should use max_secure_erase_sectors instead of being limited
by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
REQ_OP_DISCARD to allow each operation to use its own size limit.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 block/blk-merge.c | 21 +++++++++++++++++----
 block/blk.h       |  6 +++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0eb0aef97197..fcf09325b22e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,8 +158,9 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 	return bio;
 }
 
-struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
-		unsigned *nsegs)
+static struct bio *__bio_split_discard(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs,
+		unsigned int max_sectors)
 {
 	unsigned int max_discard_sectors, granularity;
 	sector_t tmp;
@@ -169,8 +170,7 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 
 	granularity = max(lim->discard_granularity >> 9, 1U);
 
-	max_discard_sectors =
-		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
+	max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors))
 		return bio;
@@ -194,6 +194,19 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 	return bio_submit_split(bio, split_sectors);
 }
 
+struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nsegs)
+{
+	unsigned int max_sectors;
+
+	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
+		max_sectors = lim->max_secure_erase_sectors;
+	else
+		max_sectors = lim->max_discard_sectors;
+
+	return __bio_split_discard(bio, lim, nsegs, max_sectors);
+}
+
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
 						bool is_atomic)
 {
diff --git a/block/blk.h b/block/blk.h
index 886238cae5f1..a6b1de509733 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -208,10 +208,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	struct request_queue *q = rq->q;
 	enum req_op op = req_op(rq);
 
-	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
+	if (unlikely(op == REQ_OP_DISCARD))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_SECURE_ERASE))
+		return min(q->limits.max_secure_erase_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
-- 
2.34.1

