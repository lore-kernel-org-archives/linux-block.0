Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7C180A70;
	Mon, 15 Jul 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034821; cv=fail; b=hmJax+6+2JSwBHDlximBfOm8lCV4YChn3WnhyU/rVjNqdRNcwz+2W7NR8UxLIa84Hkkai6BT0EtysDULaIVr4PF9gj0h+uQ8Jhp7CwcHWqvvkvWiaWQ7+wfnmS1/B7i2zLj6ma18Rqd9FThGNRS9hUqcQMbrf7676S9iX2n3sQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034821; c=relaxed/simple;
	bh=X20Iim3DoWrP3cDqIGLf+Ui6u5PDAaSvFXMSarVCefs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GzKq4JDDdWnyKCU7Ik0Q7tskfYrYvww5N1VPMzgFC7xGBgSwSi5wRCkaQm+wNkm7BptuJECp5/6CQENwBV5OD+qlctI2kLr6qM9TsC4bePcvGX+t8tiL0RY26arP87EZfHsKJoBR4CPCg3PjH4X1XvFQ4LeHniVFk0PI+A5jcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ot4OfItv; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ot4OfItv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENGK+SrAZ9VpwJCgV87g7GSfXKNfDiywatOvdrvhNVLtU6Hq8ZOTcf9KOFwPyq5HGiTy3m7ZPWlsthDqsCt3SRdqwhlTtxrBvsY8jsrlBwpplwyurpaSt1T6G60G81oduGglh3S+7+ew+UakGDGSt2NwYE61ysADX6BP5k0RsgeTNRRUfrINMP0i5wAlobMpg13IjR2qxhOCoHmI+4gCzGV/XMXcfF3k2uS8aqq6KsVS4hvVjHleZl25x9aCH5Xu2zlfUp+X4GlJgZAdk9Ozy2GBHc357JKOxmOfvcpEsHFqlFC8mN5hPhYIM59/6Lm+mJlHFu+1Jw+KISA6T++9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSeIq2pmnetWwrdHI/CBi/D6A1mMbSt1RKn4/PG6a6w=;
 b=g986W4E+7XosSOQops4n/cp+0IAtYpX4Pitp6KdYAuhYH24iO35r/JIZtW4syNcNoL9ZIGvertOSoKX0tEwo0uMnaJBtCEplbdd9b28PsC2ayOgMuyzR+pCBSG+FrhJKnnVd4yhdaI2W3IAEtdyuf4sEnGNW7tY6P1UZ4/hhJvFNFC59/2qO6k4JWb1TF7c0l7ASXMSfcdDoAQDvUPxupw876hFUB3rTFJWiGpg/WwnQPc9htUbira15VuBW8FpU6oqlVr4MzW0WDx7u6MxNoryIEfcX3eHKBXUi73B9KnicRO1xQsW/bd1Il8h5MCUmLELHi9PlvO8ecXYlh4R5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSeIq2pmnetWwrdHI/CBi/D6A1mMbSt1RKn4/PG6a6w=;
 b=ot4OfItvmPl07/A44Eo2I+7+KIPCFM5bzo+/mDjIH+039nV/A3IRqojUgbfcoewrgTXwliBsVNq5IAQyZKs/YpzU0SCFyCceR6vzxDvwdr1ANAZLWn9PQCQ1W3DAd0uNTNP0ptOuqjyqb6WYhjzmX4JYg8zi8XurYSM4aqo1dIIob12Sn3XIIgoTEEOJMAgzBrnNJQQK6z6LzMI1ltesQ4QAx7oR4fyKqxhHAzOUsxu+Nq0difCyCN8daJF+gkbMaRCKnlZaSbM+STK7ux05Sxh0miHHqZk7pKV/avaDUUr4Y917ZHafJyjKKt3MGYFkexhVQWwBARHiBzhiT+lNIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 09:13:36 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 09:13:33 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Yang Yang <yang.yang@vivo.com>,
	Omar Sandoval <osandov@fb.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v7] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Mon, 15 Jul 2024 17:11:20 +0800
Message-Id: <20240715091125.36381-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd11558-12f7-4fec-c323-08dca4ae6680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4q8R4hadluVqPBr169uwjXaazuto5fSv0CWsdzLuVaqW93dTHiwTOtqmZQ1?=
 =?us-ascii?Q?9ODCKXd35vINOPzlIwJJTg3c5zRiY+0XCfr3dbLI/uma0aJJx+tKNb54AVKx?=
 =?us-ascii?Q?zKGdTWdf7SqyaNrGXwq54qsoN3YLfuhQSrm8PldXAO5GaRxQ0EwwVxlsHxRp?=
 =?us-ascii?Q?1Aef4kv3qsIHNEJj19TlqEeuWa4oTisUWMnZcxNDI3z7q3F41P2LOQZZLExY?=
 =?us-ascii?Q?p67Uwa1S1kzIGkJXmjUlqxM19rdfoGD6r5kY6nzt2uG7DX0giBGcPF70CB/8?=
 =?us-ascii?Q?VpqdIzRKlekpxsKlCMTuBMbfSSTnEzbMUh9SjPQQo+kQnPKeKkioDApHW/Yr?=
 =?us-ascii?Q?Ar4UBHrTioV6u6hkIGfc6YO0MNiVyUj/dK76vEYPT6LeZDExy8DtwAsDbBA3?=
 =?us-ascii?Q?SqCO6V1dTNcSJ8R5Wf4zvfD7mmxvO4jaLt+e0Z0R9/F6NnxJ2t7MtuMb3erB?=
 =?us-ascii?Q?edlW/wGaGlCEbE2BPXlxS4sW3IdvT7NksDTfxt0xdbHUp0oPq3Dw73Z4okfY?=
 =?us-ascii?Q?QKQ9AA29pFivcPLbs8Htwr8dvzZVAuvWrfz/vfehtgsZ293qTLSwrnVoxyc7?=
 =?us-ascii?Q?YlCOrh2UI1OlG0HiHzq2ofzDCZfSP+rC7JnQ6rKHeWXDw1OFhb7j2RkQHV9r?=
 =?us-ascii?Q?d/nHSsQmaPHEnqXfVvfyFDyInwtPqrvIe1m7UcFG7i3LHKQAFLuYfMvZ75NT?=
 =?us-ascii?Q?WrRGeStqls1P1SwnWGlkLq0E3fH35CY1J7lnF2UJRMY354i8x9wSZ3c//JHy?=
 =?us-ascii?Q?6zxVmz3YBPksTKwDo8rA+ALeQekeZFtRDh9mBZB8SH2XVmGXuX+LiSkKKZK9?=
 =?us-ascii?Q?iIkaABanoH9IBdacSUWYfAzEtwx7Loidn0i2fOvPJeOF1PP4f+K7PYmrskhn?=
 =?us-ascii?Q?8SxNRKx7fHATDtYlEGQK/jk/ockL1PAKe8Ot39xdBPTWM8kUNFi0IPN1cMWS?=
 =?us-ascii?Q?fete7ww3BVa8HE2tn1Knk+L7isFUNEPeMepBa7LLj4sMCFVEUpfrm/oI6Qcv?=
 =?us-ascii?Q?qf2DhRMhXn6bfsRf7dID0zABpkmYxzZN6fXUQqN8sSzN7r/pz2RzCStStQpF?=
 =?us-ascii?Q?vZ2HgxESZRmO23IxKxColtPyDynHGZ24MohGrZ//8l9kLMIiyGNoCxnTvZ4h?=
 =?us-ascii?Q?1Qo6DXcy/kTcQqtY1xmekKiN4Db15cW3dlXBdr6xMOoJVbgOt2NDdd/G3Vor?=
 =?us-ascii?Q?ZC8GTL068pAq6OnA73XtyVRg4ziogHq/cIzykfXOTYSYTZB+02bIxpebc8FA?=
 =?us-ascii?Q?cG6UMidB9oaqmv1WtmdDbnsIYdijzSNjd9rGoGFuxEPxAw9zBMeBMqKme1zX?=
 =?us-ascii?Q?uCS9a3ULrG6Q/Ua1Ehuo6NdVe8PZm4ARGgjkUtSRvgKd4ITG8ZGOjsXao48X?=
 =?us-ascii?Q?E+C7UFAPv+COE431LDr0VXxgBNqTz0plGnekFezh1onnX3mo4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckLN2fKjiJAMooDbW8wXlZp6tvdOn+irDl20zzeZzmTlGZOyi7AkjgyZ6j2Z?=
 =?us-ascii?Q?gA7dmMXAKz7YKKunscO79HsmGqnHZ4V4GeLzw+sL6jGaGiWHgEo3DH0t9v24?=
 =?us-ascii?Q?oaO3OVkN9Rxy3+n12wuOuya1tOcHMQGSjkad2Aq7xq1RykpuLFS90UTMQ3My?=
 =?us-ascii?Q?84wylsHCZYV3qtZa0t2jHtpluLrMnLBRPuqRIk7JYZJoSPU3ZR/7iRIGZljK?=
 =?us-ascii?Q?cWzCaZ7oieFR3DFoW9TsgHrJODHEtLeI/kLHQTgJhiZbqTYBnsMMdftQWrrQ?=
 =?us-ascii?Q?btYuKpiD8V5n5LI3KP3o//dh17bEs0nkqD2oCc69L/VL0ynhOHIWU9wQDCXX?=
 =?us-ascii?Q?W+poSC44PxJBJ2pd39hhfAOSxgjLG0RI4iL0cT5Iyz2+b0ZINoTjJmRolV/G?=
 =?us-ascii?Q?0STLK6Bu7T13/ocOZMjKcwhngmDqjuwwCUdlUaqMFN96PugJb7ouzb3Z2laR?=
 =?us-ascii?Q?UOFhFlLfMsElgG1n7DX87uo+U4YkRHyst/dxoRoB+7/sQ7OB0tzNkfcizNpI?=
 =?us-ascii?Q?3V4OHtOZgPkn8dDMNrkgmkiGbv4B9z7nvgNCOjMPf9LYjwfgODBZZt8TQUud?=
 =?us-ascii?Q?09Ekd9xjtqxJr2IPdWDDN0bUri9r9fffL0T4i+y2R6peKK/kSL196pAH+C7e?=
 =?us-ascii?Q?wPFP7i8MKCr27WryYfiV5ta9yiBnhIn7Yut7ovTmFWxD5mQQrcVT0Gb5SebY?=
 =?us-ascii?Q?q71OY//97HwHoOGTk2IJ7cLSRbyj1KiMY5IUoANezf22SAzo6zaXrzTzMZyw?=
 =?us-ascii?Q?EuYoVdRgMBvikdbs1v5TaQT7k1NzAb7m22hDFgKq9uwqiAXEeClfadp/c4G3?=
 =?us-ascii?Q?q8kjlHy06TchpCH10fzWihwJU0xkX05CHPlGwK7L0av8Iyz/VL2mzZYIn1YH?=
 =?us-ascii?Q?ULJAwYSZ84S482SYXWKUhaYOv6ekTylr2bQyntfSH30DD2P0fVhvmg13IJkG?=
 =?us-ascii?Q?JHt7YJJacTW95geS2kluzH92AB3OFtbMbT9jshWyGSuHtg0nGmwSvPkmWbIZ?=
 =?us-ascii?Q?kwUBZHOmrt5LXY66gaci696SwTuGXLk5NMFKsLB4JvaIC29qTlZP6ZWZYSe3?=
 =?us-ascii?Q?rsw7GT33ujw5CnRUtJYlSCKLbfx/rprAyWOTWeRZjhuNifQ/IRVibaWfEd9N?=
 =?us-ascii?Q?1oTgjAIO9PjD+fg9vqUgAtu9tkzfaZ3HgGPSk6FXxmIllpwMiN5seIEGYvaz?=
 =?us-ascii?Q?2zRlcUBjh9vyItIk/EEyas7ikLIWVm9AQKjhpMg1VQCJ8ewlAGjqCAAq2R1L?=
 =?us-ascii?Q?lBgviVQ+Tn1UeqlRjHkJSpNcjpM/vSdcoyGLbNPc7C2JSR4RFz61THdBoF5Q?=
 =?us-ascii?Q?bNY/02pUCmKtaD8aRx5a8onCZi3jO89e6NFtfzD+CW964fiGAg2a4ZufpffD?=
 =?us-ascii?Q?EKR9Q9frIBeLPyyVk22B3qpzzKAAI/niQ5tyJBhtJbRkSLsai0mG3xNRsUsD?=
 =?us-ascii?Q?21rxxmlYYJIRVMHLFMYLwr8AVDXqFknPLJXu9+YyYfiVqorK9CycBDSxPC8b?=
 =?us-ascii?Q?vYIEx+UrWvgKYcP5njVTpm/PQ8FqXlYuXht0Dymc730cuLnyVX9prTlhzi0S?=
 =?us-ascii?Q?MBbLpWigFiwx9x/5VJf7WXUrwpo+Za5CrTjzOc5/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd11558-12f7-4fec-c323-08dca4ae6680
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 09:13:33.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQKCYBzizaPSkdEfU+oW95BVuy2S3vbdH+DwQyrocudaO8bGqWxXaWpeCO+Dop6zS633GqFSP0jz9Tiy1pcNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111

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
Changes from v6:
  - Use guard() for locking by suggestion
  - Modify comments by suggestion
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
 lib/sbitmap.c           | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..c09cdcc99471 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_lock: serializes simultaneous updates of ->word and ->cleared
+	 */
+	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..3c00fe4b74fc 100644
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
+	unsigned long mask, word_mask;
+	bool ret = false;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	guard(spinlock_irqsave)(&map->swap_lock);
+
+	if (!map->cleared) {
+		if (depth > 0) {
+			word_mask = (~0UL) >> (BITS_PER_LONG - depth);
+			/*
+			 * The current behavior is to always retry after moving
+			 * ->cleared to word, and we change it to retry in case
+			 * of any free bits. To avoid an infinite loop, we need
+			 * to take wrap & alloc_hint into account, otherwise a
+			 * soft lockup may occur.
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
+		return ret;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
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

