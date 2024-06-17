Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF2367;
	Mon, 17 Jun 2024 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592394; cv=fail; b=Rfbli2DxwCq8MoxfgVOnFn2/m/ApEGFRaoa2u+8K/JBPD4Czl1w37spdO6T+pRfw/D/Lx6EZywZ/27xsNLAsboCALS5NUkT2paEU6ZD1R0J8SGqmO9K0FDiwIbOba5Hzvt+IVO5URmWFd7YQ8qiWBHOJJWOWjbc0A9jVih2/0D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592394; c=relaxed/simple;
	bh=qPWaSaA/Buue14xsnzYRcG3UPo8aMrmEFGcGRbMeHHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T7/lJX+H8jfd+379A1AtUZztw8A+lSgVBLXlp1dcU1eMu6YmfqFzeaP//a8SX6XqoC8XaR4Jh+smTEl0W9lOeu34oSv8SfbBfsLjl6Y6srwhivgcXflU7/AhyzGKhjhZlGqwukKZyLFKOXxcDVW4j6htkP9vCKx9X+orz1SXApo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B8pqCqRB; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B8pqCqRB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP2xFAXXLE7TfNPC535H2Z8tuShMQIpM8qX0w6dYg1Ono6Mbz7/p5qInx9xdIkJQBeTcz9WUVEQwo9Tpj4Luqph0T7ji0qdjTq/KSR65QJRnbCBr/sONhyVIOnkuGygdsgi+DS/4uiCVTwwi0l331wadJauhFH/YxZBTgkKvXAuoX1VtrYZ6tI277R0D4AClS8zlypjvLnyZwMGB0uQkuOpqAWyURAVfW8cm22TwNVjQgsWBRWlfoPfZB/XgP3sxMMc2/ooSxJ63C0Tz7yj/0M8TDOjD2s/bK7OTKKgjD7qXHRBafQG3qtuiULRRqsGcP4JhmHIVwCCGolU4UrzX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isJCAaVzwZBLpEsCZrbwBzFm2oFRdQAFBXRlILy4+i8=;
 b=l959D20S3qkohIdw4f5T8x8EQ0q3nIvYdBJrhyalPzF+1pD11aNag2SAQrkNVz0rsd8S3oOEei2NQPkag1QSduMmytjCFj4rq/8y4z4pThXDzulT+I/727R8KlFrVl1jHyfnwOqUW2PmU+PKweRm99dI09u0tliJhbYVha090U276ZIGkNlezVdxNvujUb4a6qrB7uYQE4gp1F/SOoQ9GRXbCH8v4QaOvC4eK9YKiUMkaNR374GBroy+jz1642zdRw5AYCVxMJkf5whTZLv/sso2GG8KZ/0a+BlpSttO/inpMJHn0AsFbMiiTm+mVjm2dKkszT4OVYl8Jm1/rUt+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isJCAaVzwZBLpEsCZrbwBzFm2oFRdQAFBXRlILy4+i8=;
 b=B8pqCqRBHtvSdk/7CwsYiX+kKK6reNuhnrJX1KtI3YgOFL6XFUuvArUnKHDJ4n6IY+HWr8VD6mJHRJDC39f3oorce4FiSmmjF42ExmQmyfEpk6Tjikm8s3jCCrQC4TUFZC5oOyYrAjhBFu3OUPih6LeOS3c5Iom87zYugWiG3xv+McVJBN7V6dVY885PemV7YT5sqy0t57kSNnGI9oifrYJhrDduKC28Ekv4D0l5uHjXlgBfzyQV45wEbWHy/JWPkVbR9IVj02QVe7XNx5scO/ho8yLNUvEDgzsRLpWgT4IKyU5FNpBotNyivOaRSg4/NTgsiWHNh6Xlk81kbohCBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB6277.apcprd06.prod.outlook.com (2603:1096:101:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:46:26 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:46:26 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yang Yang <yang.yang@vivo.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Mon, 17 Jun 2024 10:45:51 +0800
Message-Id: <20240617024556.211451-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b6f766-5ba5-4d78-23dd-08dc8e77aed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYXAQy+jCjEPXrciC6e5RhZWZa+zqGxrOfGtB3KebCdpqHelbsFXaQzr2ppZ?=
 =?us-ascii?Q?3/gnAfHW4wohksOzVQrV0CrzHILd3jFRFVFy9sDWoPFp5LroHPvnQTH5dmau?=
 =?us-ascii?Q?IHYxQ9877pTXE/V7U3k40iEzI72YM2X3PXL4rUyA/myW3HidEuDv6EjC+GBd?=
 =?us-ascii?Q?M2ub3bET2/cuaIWzlxFumwaB+A1rZbRRJNcV6lh3Rbg2KZlakxMFmAJhK//f?=
 =?us-ascii?Q?4dgSXguFXDihoj86SdX7OIp/L1HubrUzCAC9AjPvVyBwiKvlNiC++pUuYvYd?=
 =?us-ascii?Q?hLalb+vx2eRqjVOa5wj94FXUilE6/m750UEzYnEo1wEoBKaLhNoryKtxpUP6?=
 =?us-ascii?Q?ojo2oVTNDHco9PPLxIeUT02X9P2vg4EGUXR6c6ovtZlCapKvl6EnNUokGs5T?=
 =?us-ascii?Q?p674FiBx/op558jHplVVqssKy0LJEGk2IIzy6Oq8rfkRlxkF+p5GuJ8RmP1T?=
 =?us-ascii?Q?BcdBSWYc7a/CtYUUjNGhU7dL11TeI+6iQQOkcgI6KxGbBWn9HDGDtlLIStHf?=
 =?us-ascii?Q?3Px/znVcRo7RRqxJfYoWqaGouefAFQgwCVC7hJut9K/Nspj/1SIIdtYmqSXT?=
 =?us-ascii?Q?poE0PBDkuFPDEXHnm9sh0jWJzFrdkzIxjuBqkUOa4C0/Vjd9GBH1BYT6TteK?=
 =?us-ascii?Q?Z6n8N2VyurGQHIZWI0t3LpMBZqSzDH5HbglX0PT6JDs7PyqZICNk9QO8lRT2?=
 =?us-ascii?Q?a8ZfrBgr0QyiiqoPeoHpLUOAibCn4xVonG/FbbzlyqNCw5x94ucVOuqlATiv?=
 =?us-ascii?Q?2Jb56u0Gg/PkcZZGsIQq+vW68ISiQVbcgBRLMvjEyGxSDGxr495NR3xotiWr?=
 =?us-ascii?Q?xj3vFUXRIT08TrFQqGrl5w+piKQfon5bRoNncq1H4YziL54zHyxfxTeoMZpu?=
 =?us-ascii?Q?lHaM6kCP2dcazN4HV0v20bUedclFUu0dIjit+ImA7MfUxPlmpJSzxaoBiEan?=
 =?us-ascii?Q?+Iq0a6f9DH8dlfr0McwBFPLfRbooJGom9e1dVdF1zmc3LQf2Huut/06UP0+r?=
 =?us-ascii?Q?YR+678SsUpFAEl+/D9e2fkIWkPvJjUcmcwf+bS5F9DNA+cqtASEpWjyT2jpt?=
 =?us-ascii?Q?Lt0wYlMZwS1J9TpEB94cHEmoRjvnKNoJHcx9gLQvxdHKTiqCuLkwo+CfULor?=
 =?us-ascii?Q?+PTy8mKyfQ9VE0E0he85pCZOvLC0NpDlwjHKYQJkvp60i3wiIuNVsvdr1vVx?=
 =?us-ascii?Q?2ek5SVNdYqgYP3rJ38VgkumdOu/4AtfzVdEs3rWYgAXRU3lYYjV3JFF7UcF2?=
 =?us-ascii?Q?ke/sx0a+tBfU7Xj6ai5ov/OrmojFlDJMxf++4RkyuIUGFT/vbC2+7PtWf6IW?=
 =?us-ascii?Q?NrYMFxP5U/KIpBfUfL6r0HMfy59EGujPa8PbwRQRTIwJ/hLTRR1XEyyjFygM?=
 =?us-ascii?Q?yC5Dndw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AbpvMLBw284MIPd55EujPMtYRXe492uTQTL3CwX5vIlEzjs9iD5XF2t9cEY/?=
 =?us-ascii?Q?nPbj+ghJWBKUPR//U5eKP89L5NU2XjRONDCDRTedDC+gge7ofhmIaNpo7Bon?=
 =?us-ascii?Q?RIBE/pYUNGCzzDOCGW+hNuLq1kOayowLC4wCWVfwDXQnxRGRu2C8ijlXrVS/?=
 =?us-ascii?Q?lVi2VgX2t38Qd6OyfCRxQnjKYqna2zRr9sPhosCSfiJmBJPn6a+04qj+siai?=
 =?us-ascii?Q?R8e/GUOWXAw5IJQImDTY1QvtDVww4ciDBz1zfPruzA5gWjrDa7AlQ9JqZfMu?=
 =?us-ascii?Q?fIkm1APy7RVI66JYOkeD61oY7H7bzcReYbcvE1aDj6zGfZ4s5COkIm9utJ4S?=
 =?us-ascii?Q?xrN1PEBoAE4JhrXqFkOW3zh3cmF3XsnYIL9TJTkpqzQI6IgwVhZBL9DALxog?=
 =?us-ascii?Q?1K6Fvts199Z+2seXjQAm52Su4WIdS+bXgKCCzioa6njQZyqaeJFE3vvaH0GA?=
 =?us-ascii?Q?PQ0kPMmralagzCppRuKdv/oSuTrNudzDS/Yl7EZ3VmG6yhLg961nvxRBIhRf?=
 =?us-ascii?Q?wdPGYqoczR/knBQstR25REVWybNcQX6xIqDO8OSxjEz2xzb97lrSlpiRH9Cd?=
 =?us-ascii?Q?5cI01TT1AAloYfWanDUBpz5R4Pqx4o4MWnDNhGvJVMy/ne5WF919jyQd42v+?=
 =?us-ascii?Q?G3wgoSiXVjowhju0sl+m0KyqESxMygXBlKeGGD1FhL5KwVTfV0Jj4ge2gPL1?=
 =?us-ascii?Q?hYNpM7EoAbENQ5mmeG5uBBmWLTUYSQ1jr/UrNqhX8TDzwLeovQXF4sDTKtPN?=
 =?us-ascii?Q?v0YO66yLGF6mcrAiZdsiyR8D+aacQ+Bv8jXeGpEpLKJM/c7yGfLHpKfhreHg?=
 =?us-ascii?Q?zczdJpx80VqA71eG0LenQ/R6MpTN8+cjR5hg4V5O85g1SezlzTjDUcdbKdmd?=
 =?us-ascii?Q?uPrgiiwtWo4unIpiV3Y/FZP4mlLwm9J0C7l/t5Uo/LC6XhRyYok2PEYP+CLs?=
 =?us-ascii?Q?6+kESsWf3w8lW59UXDaKax51IgQkVOb+NWJkevwy5sB99ckWlC8hrSJEaejo?=
 =?us-ascii?Q?gdacIX+mIpMrmiDs+61XyrMegkImdUKq6wQPYtlopBWTr6RwpVpdK54Tr+eI?=
 =?us-ascii?Q?QXlFIZjJX5IWOknt5o+YL89Y3ltsAk3eJaDQHwnLLSN+eFRtJam/LEIGOwjx?=
 =?us-ascii?Q?nzroFNIb0+CA6wutaIPEG03fxi8S9657WJ9SkYOHlJORBLRoV4VrocZrPzTf?=
 =?us-ascii?Q?xsZQojr8SojduArRwT+PPfbgGHh/4Jby2xybEUNkC+0vdo6HSAwRekpBx9D3?=
 =?us-ascii?Q?8KUEvlHqqBTEwAUmWC+NDemzzOI9bW/H2q8jPmnjnXLwb+e+rqF0iGVHh4Ou?=
 =?us-ascii?Q?jrnB8VsE/ZlX2bux3qIMbDNLePQbyOOJUdtiHBA1EpUKJZSzOHrlrzPSdljf?=
 =?us-ascii?Q?0ACj7lV1bMos7zEmgTPL47Ylet3pOn8VVJKB12PNludBWryeLHoqlyKOvLKe?=
 =?us-ascii?Q?FMMB1jza6gkCtJtKCbJ/7Glt5k/gndifXzwClMb1PAeiq7Au6ODkarH3mHl2?=
 =?us-ascii?Q?568UGSR3u1WabFO0M22lmZB1Ov+EGhloHCPN+lPDtbFEah6IKtLUCARfOeJi?=
 =?us-ascii?Q?AqsOdx9b9R2nw4/H84E8+TYrZWr8i3Da/BJpaWVJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b6f766-5ba5-4d78-23dd-08dc8e77aed3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:46:26.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph+7+ahjVDuF9slom/qtwrSDMU4lSbp4+VvEI+WrrOYZcVtlJPRmiNPz49i7aXWn9B81sruCMjMEqjEYdc7xag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6277

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
So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
may cause potential race.

2. Add extra check in sbitmap_deferred_clear(), to identify whether
->word has free bits.

Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
Signed-off-by: Yang Yang <yang.yang@vivo.com>

---
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
 lib/sbitmap.c           | 45 ++++++++++++++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 9 deletions(-)

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
index 1e453f825c05..9bd85a9b74b9 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -60,12 +60,32 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
-{
-	unsigned long mask;
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
+		unsigned int depth, unsigned int alloc_hint, bool wrap)
+{
+	unsigned long mask, flags, word_mask;
+	bool ret = false;
+
+	spin_lock_irqsave(&map->swap_lock, flags);
+
+	if (!map->cleared) {
+		if (depth > 0) {
+#if BITS_PER_LONG == 64
+			word_mask = U64_MAX >> (BITS_PER_LONG - depth);
+#else
+			word_mask = U32_MAX >> (BITS_PER_LONG - depth);
+#endif
+			if (!wrap && alloc_hint)
+				word_mask &= ~((1UL << alloc_hint) - 1);
+
+			if ((READ_ONCE(map->word) & word_mask) == word_mask)
+				ret = false;
+			else
+				ret = true;
+		}
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+		goto out_unlock;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,7 +97,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
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
@@ -85,6 +108,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +140,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +153,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(&sb->map[i], 0, 0, 0);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -179,7 +206,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 					alloc_hint, wrap);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(map))
+		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
 			break;
 	} while (1);
 
@@ -496,7 +523,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map);
+		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
 		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
-- 
2.34.1

