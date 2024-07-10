Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2045.outbound.protection.outlook.com [40.107.117.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F967D3F5;
	Wed, 10 Jul 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594653; cv=fail; b=fpMDmwi7x1cRmR+cKvC4o3RZCT5HMb60Yl62FDNSZuevnLiEgd+NjWFjV9fU3zthmYFIDf8PKEph4DeUet8qoX0O34F5XBspo1++wZNut6HnSyDzTfAffsZqwEheWEV5TggGWRyXYucvBVhWVhqGEDozx1mgfUpb24I+lfHHTlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594653; c=relaxed/simple;
	bh=dUGlxpWcAgRNSelXKMEP3onPoJsTLVoZaKAN+GA23mI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z9wF3AqWOBIHXRS5ASq6MZbtaRaV552GD9tr7LUQZV1wukf4TiAenGW+n5sgbTR6vF40KJIqGLW6EGpWMQpNCqV4jJep86vDUNhpUb6xyiiOPbf6NzRElPJ4BuDugSoCTIbZBJFugtI3Y8GxC36Yp57M/A1xQOCSbA2ZSoFw7BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VKgrolFL; arc=fail smtp.client-ip=40.107.117.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VKgrolFL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2wtUxpZpeJUcQF6b5wPdlXbWtn5pCe+eDn59h3Gvrn8v2/8Y0MG9+FpojhxSPtifdsJs3u0GL5Nz2dbdBvubTtM0WkRZzwfkgTGVucmbybJDK49UsN2jHNhXGEYCMWlxwlBIoZQFZPPehAgdr2fzYm4Wfrrmmuc8GuSsALfqZLeAHjjV9v5ks87mxJyufuk5HmkNe1h1bQrhwptiEnKZLwAzOckdB+dzSZ8QkQPdiZsKT86ZYB7RGpIkYxZulehwViFxot8K1/q1eP2A44eLpxAW81wTzs4hEzJFbeOr8+MIcPwVTZk+0zsqesLZKb/DKAcjYSPx8XUTHQhPDwTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJPBuqkQkRx/C54hwrtz+grzmhDgsVH5G6UUBq9T2rQ=;
 b=oA9Mecc3MoeLPqlRcZqg+Akp5i877E6AZClw34PZWCPDvm8XLcUxbxTeAEsH1L+VuITcPznm/fQfQu7GjzStbocYi8z6yCu4DKhDR33YIP/Y9M5ZN8c6n8Vh0LauoHCQLqurTuK8ODRCQVwVpJhZuEfuCGavWIYR7iqML8erF9SVjSDP4zfMqfe0MGRZpkh7FszJXF6ezsGXsOiDqVf2wBdIn5fkZBIkh5uZCUKe1mfoxtjeJEPdjg/Xm3Uq/2zR7dDZ4OWDQWkAWlPzt+z9Dqf9bB2FhmXUzsmaRQPzx3VNrYvc99d9U3aPgvw1RdGhvuNnYazjIbaSIYECbmS6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJPBuqkQkRx/C54hwrtz+grzmhDgsVH5G6UUBq9T2rQ=;
 b=VKgrolFLdzGkFIspMx9EvRPvsJ4ofm/WWcWiej1t/Tp32Q47VEJU/wLp30v1MUFje1BXjDpOiS82/Ol0qyC6+5ydiIKf5MnVVBlrJfQGJv+maiGDcXmJwwubIaq2WuSeHzmv0SyLqXp8ipOGzGcpHdpsQ/vXSrq8Jdfcgf+B2MsYNJIdBzkw4vw6UE4cPX1uNf8248mHtfUKnOS3PRChsmNSrd/EnnLdxJwoO5UtoTWQREA/txdcMMn9HgGGJAtxN4JihrfHAUAKMnn3cK6BNNAeMaDaDO+nTye9xiEKag/GtzG11p7hbiUeKANRdnN6qThiFtb91PtknsQ0Dx+gLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 06:57:26 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 06:57:26 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Yang Yang <yang.yang@vivo.com>,
	Omar Sandoval <osandov@fb.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v6] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Wed, 10 Jul 2024 14:56:14 +0800
Message-Id: <20240710065616.1060803-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6c6886-2765-422e-9415-08dca0ad8ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ycsOPatoVp9J5qd4J6q/VsV/zRqvGoIqh3Il1Jdx8g+EJGx/SvuQEvD7aTRS?=
 =?us-ascii?Q?NuJ/taSeay7NXl5HWrwBNZM5ZPBCG8pFRo2GEatPSQs1Nv2eohuJ6ZKnDW8A?=
 =?us-ascii?Q?NF/mAygk+nagz8vgBY0pGFXHqXv1jGqTVi5AnhqekmUhkcmu6JeK55/UIJY7?=
 =?us-ascii?Q?CABmWwsbzF/rNsOeavQvvAIJLxTatV38jaGhpa7Ptj4C7r4plGwFNJqczzUC?=
 =?us-ascii?Q?OXSyLUYmQrShe0v1vlfWi95AD20usWF1eB/ciWY5tWSoq9LqkAkThBI43rJy?=
 =?us-ascii?Q?E5zcQP574cXS4/80Os2bx4MEqn97WSutrA2ea8jqcwRKkJ7uYVXD3xzBKNqO?=
 =?us-ascii?Q?0e0QCxcDZjZaJcG/mF6wUPUeeYVSjrEu/C8htEkwQ5YvOGHQ1nHDMiBhJAsI?=
 =?us-ascii?Q?XMrcWfD/adAsaIAdYAbaSdzDE95vglN4mlPlW3L/x0TFq3jIuOku4CUJQeB8?=
 =?us-ascii?Q?u4sKozDkOezUV7Qp3/Xdt8+EM3r0Ny35gay/QezPZdvTDxEpoRf2i2lXQSsY?=
 =?us-ascii?Q?A9SnS1tSMpHxYE3xVJ6paVsSz4/Zo0ZkLjeULquSs+VCF1ZK8Z6R/hCnskym?=
 =?us-ascii?Q?rW7VY4OKTDQ41gMEnzKdE94jVViBoGuvXyFprU0SOOZzXBn8jeSVgcVysl/l?=
 =?us-ascii?Q?MNNUN4Kl7ATCr+BfVhJuxSsUW7Ps/zYx6F9M6dEgQH8sH9uh1DWI6nw3NqV8?=
 =?us-ascii?Q?K1bDGoQWr/aMeUT5+C0xRdWw6lls0vKyLZp+aFfoCo8XK+0Z8Y5TYHDdlM1P?=
 =?us-ascii?Q?TdsAbc/M+y1XbGAJYl/7XjOFanPHXheUccLxioPScTegS9/NyLNTIJbW9YNb?=
 =?us-ascii?Q?gFaB9QGFlE+xL10ulJfm8HwOMWCQ4EST1ULaWCK2AFpw9/rZsS9U8YbFMYvr?=
 =?us-ascii?Q?odk7+2kDedw0I20UNFN1RKQxowwZHO7cAX7Tuy4KyXIINreFxYTh5fdQmjOS?=
 =?us-ascii?Q?DGehBW2N8xxK0x3k+qNHguF+I83HNo8bnvBZPRtI0KjJ+MfM65/8YuUQFQCr?=
 =?us-ascii?Q?5mcYVomkIQ+IGGGQActZk/LtTNV5aV2zCSoqtJ1mLohSsSreXqXeDEPTtcni?=
 =?us-ascii?Q?63cpgofDeWjlJrQBcyLINkynvJm428HDXammlSX+Tiu4tE7lHzSe255z8/2a?=
 =?us-ascii?Q?LSxdM892pyniRo/BFNEfmN8oLaMtGluv2dZ1qS0v/ExFNGiUFhFgjIpwGdRf?=
 =?us-ascii?Q?hAJGjHL7qYvrhCa8VywDOE+Oj+cqJxVvz2C7FXJfDxvVkOLjjisckwOXEbAu?=
 =?us-ascii?Q?/mW9SlE8168jhi3Ytzv2mISCBTg+kOtf7Bp9kNbPiZ9cDUEmrb8S4rC2wmZr?=
 =?us-ascii?Q?afdwZIP0/Yt2uOq1dOYyk8OkwHjWQB5BvqQHJuZJq1pOMQpkY50qkeubnRiG?=
 =?us-ascii?Q?3zKR8bgyur7vv+LpDzxPDTftCKkdZ5XPMWz8eoNnkWukNtKfnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxUg9XNnX/jClyXNXPNGxWPqbCprzb3jRhPN8Aw6bZ4ZKpAH58zPiMpWLXyI?=
 =?us-ascii?Q?TFB3OIkLonwnt/bBpRuG6cCgvqZ4KsQxoEO2wy5QkrC7tdxkTifiqpu/+ZB8?=
 =?us-ascii?Q?OP2dt989fAjAISyB9xpb3UraAFen0yeEeCLlYuTa3VgDLpSQBrainAIIFfnv?=
 =?us-ascii?Q?BXJ5nYeuEpJGi2DcwC9xCnmO/CEGj6WwP0Y09e9xyMU7UT8LL7Qq0RI+1rzQ?=
 =?us-ascii?Q?bxg5HaUxLXP49u0URp6+1WildQTrNbPHkCI3R20u4Zp3udLoRj+BpkiFIglN?=
 =?us-ascii?Q?tno03C/IEp3vTQO+zczV4b4b3rvT4XPu8j6LPgMi1Ncg7oeByVMqZ496z0hg?=
 =?us-ascii?Q?vChusDFpSxsXCK3Rhx6qNZ/GwfcSONUmflcmzXmKXrDyTDIvfG+8LSKSr9GY?=
 =?us-ascii?Q?alDOd59dSuhgbxLXgnlaEhMbYqnQUIOHoJrjqtuhhmltYgBIsixp8SC7wtPX?=
 =?us-ascii?Q?OARqFMIokrXHkPuUi/uVYXOKay+e15yLjc4ufxDdG2GsUCAa/gSEFXrbDdtZ?=
 =?us-ascii?Q?36AEsD2uMZuVudCJl++DXP5rxAlg6vE0qFVdBQk+3UFiXzhiwomA53dwkgP6?=
 =?us-ascii?Q?z4299FA5YD1y4YPAdxh4X/pUzNhWX1OTiptO4jyAsUWy4LHgQPVAkRddXEfM?=
 =?us-ascii?Q?jECWQkVxdGfMxQRK0Z5EimUFmc8CbVSDWL3yF//b9rLEfiQ4IVjDbUjTGzfb?=
 =?us-ascii?Q?NKZXjgYZccA0fo64s4xhuJBtnot8t5zs+pAb4zDjg6oPzK5o0kqf+mTMaSFd?=
 =?us-ascii?Q?hYdEDM9TjhNObNsuhU+bTpcqPM1wfOU7k4u8oWYyf7YbI0pFSruRhqX3k5Xn?=
 =?us-ascii?Q?kg2E9q1GGJxKq1l1ZgOv2gELpTfR/okj59glzVgvst1c9m1Yex7E/cyxs6Lk?=
 =?us-ascii?Q?AVjV1Y+jhKXZ87XDM7dje7X1Hb1iJB4uqnnBpnnTs4pmOiWK/iGdFM+gbasU?=
 =?us-ascii?Q?zChbfiKfx5E3CMYV57MQ2+/c/fvc5h4Z5UZOLn92Tz6CAIwRFjCAYw5XICKq?=
 =?us-ascii?Q?oyR7foFWNG29oZtkdzgGfC4k+TEVWSohQcpc4ADsV0w/JATNAmJ3R5DtoV49?=
 =?us-ascii?Q?R2UbQYHrlgXpunCy2I6ami+yTbeVUiJXw34D0e3skFgTebnY69ExBbK3aHLJ?=
 =?us-ascii?Q?78V9bew74mjeHQXLv9iqT/tu8K3EHv3MHCYjPeI89GlWUCISHhfy4vVvo2dd?=
 =?us-ascii?Q?9ytBt+bATzhSbmhR7nxzWX8ad3F9byjXZiTReBhWiW9Rrz5p4+ezGSen0Qnm?=
 =?us-ascii?Q?CIpuIuJJUY50ssvt+/gcRmBHGR6AMcchEZ3FcjgIeNJsXrsjVJlfU8q/ohpF?=
 =?us-ascii?Q?2Z6OPI1iOmZVuwixRmluuvfCyQgU9hROGXAk6tDQEdHNeYMlLQ68M1QV/3et?=
 =?us-ascii?Q?HguYcvsw6UvepdLMtogcVZ191+HzT1q8EwKBq9ZOdO8t7ooWNnj88kmds0Uq?=
 =?us-ascii?Q?zNL4abb7xkMMutK+F44rcs4GvO/AIkmCuTMoJLXG7wcH4ckcKUS4f0bjpUke?=
 =?us-ascii?Q?c9sZ6Npcxnd4sLmDAUXtbN6drcvt6mPn7zGFntzv1FwZkrLjPFd2P6fDlYDP?=
 =?us-ascii?Q?xk/5gRIMWb9+mzvpo6hZifBw5IpJQKM60Nr44RyH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6c6886-2765-422e-9415-08dca0ad8ec9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 06:57:26.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi084c/9smvQofdtLDObJgtD9RZalgustE2LC8BF6me3ep9ygUrVNhWHfLAJKrYFCZNfq0yq5WQhhDoGE/vE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4984

Configuration for sbq:
  depth=64, wake_batch=6, shift=6, map_nr=1

1. There are 64 requests in progress:
  map->word = 0xFFFFFFFFFFFFFFFF
2. After all the 64 requests complete, and no more requests come:
  map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
3. Now two tasks try to allocate requests:
  T1:                                       T2:
  __blk_mq_get_tag                          .
  __sbitmap_queue_get                       .
  sbitmap_get                               .
  sbitmap_find_bit                          .
  sbitmap_find_bit_in_word                  .
  __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
  sbitmap_deferred_clear                    __sbitmap_queue_get
  /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
    if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
      return false;                         __sbitmap_get_word -> nr=-1
    mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
    atomic_long_andnot()                    /* map->cleared=0 */
                                              if (!(map->cleared))
                                                return false;
                                     /*
                                      * map->cleared is cleared by T1
                                      * T2 fail to acquire the tag
                                      */

4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
up due to the wake_batch being set at 6. If no more requests come, T1
will wait here indefinitely.

This patch achieves two purposes:
1. Check on ->cleared and update on both ->cleared and ->word need to
be done atomically, and using spinlock could be the simplest solution.
2. Add extra check in sbitmap_deferred_clear(), to identify whether
->word has free bits.

Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
Signed-off-by: Yang Yang <yang.yang@vivo.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

---
Changes from v5:
  - Modify commit message
  - Change the fixes tag
Changes from v4:
  - Add some comments according to suggestion
Changes from v3:
  - Add more arguments to sbitmap_deferred_clear(), for those who
    don't care about the return value, just pass 0
  - Consider the situation when using sbitmap_get_shallow()
  - Consider the situation when ->round_robin is true
  - Modify commit message
Changes from v2:
  - Modify commit message by suggestion
  - Add extra check in sbitmap_deferred_clear() by suggestion
Changes from v1:
  - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 46 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..ec0b0e73c906 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_lock: Held while swapping word <-> cleared
+	 */
+	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..22d6e86ba87f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -60,12 +60,35 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
+		unsigned int depth, unsigned int alloc_hint, bool wrap)
 {
-	unsigned long mask;
+	unsigned long mask, flags, word_mask;
+	bool ret = false;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	spin_lock_irqsave(&map->swap_lock, flags);
+
+	if (!map->cleared) {
+		if (depth > 0) {
+			word_mask = (~0UL) >> (BITS_PER_LONG - depth);
+			/*
+			 * The current behavior is to always retry after moving
+			 * ->cleared to word, and we change it to retry in case
+			 * of any free bits. To avoid dead loop, we need to take
+			 * wrap & alloc_hint into account. Without this, a soft
+			 * lockup was detected in our test environment.
+			 */
+			if (!wrap && alloc_hint)
+				word_mask &= ~((1UL << alloc_hint) - 1);
+
+			if ((READ_ONCE(map->word) & word_mask) == word_mask)
+				ret = false;
+			else
+				ret = true;
+		}
+
+		goto out_unlock;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,7 +100,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 	 */
 	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
 	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
-	return true;
+	ret = true;
+out_unlock:
+	spin_unlock_irqrestore(&map->swap_lock, flags);
+	return ret;
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -85,6 +111,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +143,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +156,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(&sb->map[i], 0, 0, 0);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -179,7 +209,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 					alloc_hint, wrap);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(map))
+		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
 			break;
 	} while (1);
 
@@ -496,7 +526,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map);
+		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
 		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
-- 
2.34.1

