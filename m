Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010013.outbound.protection.outlook.com [52.101.128.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C8335D3;
	Tue, 16 Jul 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118444; cv=fail; b=dGhZZu/UczIhPx97Z3rSYzUxHBZVxHZsESXjngnL0jACAbmsbk/XJIT3pce7BfZzRfvhAkD6CP3Op7/3bvTHQbPVwAfD0zF3yAqSbHjo76V5ektKG91ujwmxSRARYsVZjOo66f5FLr4bN63VKOi5ec8rql9FUVq0s+EjbD24Z7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118444; c=relaxed/simple;
	bh=kFm/4fO6pJ6wd9qnhWDPqmZf8GIxpap5TMtHU+5ElsU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LJhTHTzRnMwbUnkjhdvq9M2Mq8IHnTX6IrRCO7NxIKA0h6koAxTvItCufNsF0sPYqsW97DTJYrTd35OXuXPAoKxtIzI+liSliVj+8wugZ8Sd4k6vEIbI0k0VRygenk7FAZYE+UtVGMhjSEng2vVJfINrInswfKBIs+ACiaKQ4xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZH5aDFZk; arc=fail smtp.client-ip=52.101.128.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZH5aDFZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDlhpK88cfdLxw6f6g5tpDRt4m9m1TF4PNxqWOPjoyj8mp6cTJLM3Pa5g77jJ23x5RJEvVaDJ6p3JC+SCDQGMq7n8/J4iynQssuE5vvreCzhKXr94JtJERahqODcJwazgMM3fN5mNFNw1B0Zso5FQWF1FlkwQvneSNzdfJuUbyI/NsYJHDKdgI9X3t0EVTojK1bTKGZNGfFEdvv1pfluLR/hh7wX+toYAIYpGC57sKFpDdikbgTRGzQ9Ztf0g6t03DpYBrYroNVZPsa+iDqvJnsqLriGpA2lV0DX/1Ju3FZEqp3+U958pbZJvmsipagybLfzzQm1ZcrlkZmY26WRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOPKAKQSH4dxwTS9czIJg2CZB+v8bh8ZNvQK1iWRQ3g=;
 b=jy7AT9+FFpb+o7l6j6HdMvSMSkWzqMI6rM5zZkdbxziT1Awx9JLdieQF8dus1yccUEPgMzJQC1ha/3tP/dPZleZL1FUkUjSAWtQY22bhY5+SVhIOsMfAALM/i/K3N40Q38078doX+0LBT1s3WBNO3haIc9NZs0g8+iPjuBcfcGZai2vrrS4+yBo6Ftb6hfTj2On4MZgxonInJuwwMQQfbP68y56CWOHVmv9CrkYHJNhz9Sy42sdKFn/imo76Kzcbq8OSyt1MMWeLv4jvIzxJ67YCfuQoBuJHMh3Nl+Y7GjJVtsqgbKLGnYOUREM3JhhEOJ8dP15fEaRb8GSgsbaI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOPKAKQSH4dxwTS9czIJg2CZB+v8bh8ZNvQK1iWRQ3g=;
 b=ZH5aDFZkLbosG+UOado9GXKuywPZEe78ckyWNr4hJELH6lwYYHy8odRLgEQ2jTRpT1BtfcDbSje6l/K663QU1R1dFY8pNZBV6pGXk9wxyy6rlvtjKYAhyvnWBQCF6BuAaOtYPoPl+RP8XDrkGx/7v8xYf+a+4lkdJVXU03BQ+lRqFDvF9s7S8CdVJULO1WUIxPkhEYyIt8K7LXK9/ST+Cg/ed802gycR7v7xlu66jc84bdPAxEYNpnXObSL4nmR4+wLfJ07bYilwC6n5YQFjm3wctkDm6B0RmhObQyuwMgtQW0IMmFk/OnONdzlC3HYS/Q2HpgQ6UxhfoJPCvuSkhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB6801.apcprd06.prod.outlook.com (2603:1096:405:12::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 08:27:17 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:27:16 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yang <yang.yang@vivo.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v8] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Tue, 16 Jul 2024 16:26:27 +0800
Message-Id: <20240716082644.659566-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::12) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 23216f78-f85f-4417-bb37-08dca57119ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9L3zqJmVIs7ws8w7CiPZVKL1EcNmpOphhhuLphwXV0zH1IAVV9rLL7pJrxS?=
 =?us-ascii?Q?NMOTiEITuGeb0tTVK7tnPwTDUQErEUQjGh55JxtOP/8yelwg976X9QLifjq4?=
 =?us-ascii?Q?Z6ceZZtNG18DZvJlNstboNuQJwRGb4dUlctC2wrMjL7KeTSuDP1qhZyiXCWa?=
 =?us-ascii?Q?OUxD18A/zi75/KVGS7l0Fed0KF3p+Nz8lr/BgT8wnFhx1e7XbkFEs76AnLbk?=
 =?us-ascii?Q?E41pmW64IXyHoZD2rXa7D3EceNWt3vj/XHwZtMBGzQs2bQMEqOXU531bhiHe?=
 =?us-ascii?Q?matAAV0HEXnmebmtlpuc7jRGYoeMZzIlb7QzgeTYgBvwacQtzidFqYbrxHZ6?=
 =?us-ascii?Q?GzR4W23XnnysnDbo/gCa2KPKC/f5RkWjlb4xr3h0noirxTo8j1hu+oeYqddz?=
 =?us-ascii?Q?aUeKFB3hFq0LjaMrncOaLpX50zbvDDLsaCVce6rMgDuo0KpcD4d89t7GHmUN?=
 =?us-ascii?Q?ruyhqK2c7lcGUwS6Nq3GJePjpL0sH3k6JmLEriY6uUEi83tf6MASpGTk/0z9?=
 =?us-ascii?Q?eEd1aY7fnXxrEd3vriv+tix71MqzHWT/L4nWJcK5Tc105zfk6LMbxvg3Ps3N?=
 =?us-ascii?Q?J8Bb2imIjYUSyj0g+zR0LPN7Zp4EhggdUg2XqllD+WUvZ4jReioNSueeHss/?=
 =?us-ascii?Q?feG24A0x7ld4ORmSi+9lcU0Rdfa32g3fGRAmkHKG1O9bIU9OxHxFgCUKvB2E?=
 =?us-ascii?Q?9RUETbPKECDrWC+ZvqTBRRPxUX/CpmN0ezmS1E5wNEiI60LvyaOPOhbOsAIH?=
 =?us-ascii?Q?z8FL59X2z14TASpQmmbmm7y03mewjySWUR3/8tij/Jwzo4Xc0J6LG/QCgvnT?=
 =?us-ascii?Q?vR/10ZLfPM9lJkonLkPyG4JOjQ6PwIAAwmPhyKiY/Sa69svpyYCK2HKAoztP?=
 =?us-ascii?Q?K9eNHA1aCzINcdjF9Os519SmSZNWE1KW88dSoX2riIPxr9/R4GUDonQk1q4G?=
 =?us-ascii?Q?MTWquzVNtlLYb49Z+2vkcARf3e7GEQWTK6KqDvCwNSTPYXpwwOOJJqwUtl7D?=
 =?us-ascii?Q?3O3pOsw9ffV6bvwQAayiNY/09wpCjwC/6Yaq7hc1UP4rTpKi8UT9CYd1sHbp?=
 =?us-ascii?Q?ZATp1cHDg9GixkUGQQz2uZMQeBUwxd4l7XYXHjhR7F8U2QWJIX9LXBY9+V5b?=
 =?us-ascii?Q?NHl0RaTg669f6R32QAh0KsLHcFPgI1PwrKKSmEcE1quO5b0yypN5InI334Pm?=
 =?us-ascii?Q?/LgtnAqDqg5PHZCAKQojpxsn+q/i4AJczfmoXg+3CufKgxHqqZj9za3tUxb+?=
 =?us-ascii?Q?KA8mkysrMI/0PQxpgEzrcTL7lM/E2ccWLrFnH/pFFvkWrS6xcPJv8YJl+Woz?=
 =?us-ascii?Q?Pz9iZrPddYyj3BDtNXNQeFNvEOPYYMm0s426IZKDlY5c6/XS6keiR0oOsQrZ?=
 =?us-ascii?Q?x5KYd/kOYiFiYeMuHczbP+6giKJKK++OB7lcQ1yzzhy1NunOlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMwIf8mxe9ThNg4isM4FssiqovJzaIdtF20n/fOi4XdxRPzSppqA2zQeAfQB?=
 =?us-ascii?Q?wj5ISxaXII0TVM2P8jhKLuqZ8ehJGZMVbdD11ALFkX+q7sqHU9oI+JElpWlp?=
 =?us-ascii?Q?OEupFtOO/BVIWi563ZQj/W42u+imomsuondnhmteng5yThYFWyV38x/gtYMZ?=
 =?us-ascii?Q?87yfc7Cpm0JXbJEwiDNQWaHh2YK+M5w1H0fe52j3tUEDI2PhTzoFNCVqnwGo?=
 =?us-ascii?Q?661TnL7uSUYEPRBnIQTiGq7JBQazG6gAoNl61ziQVMmoFumKxX/mdUli44OU?=
 =?us-ascii?Q?47kqwJjzu0KynFrm7FTXsRy4LfoLzk9IMb9lWSe2WDrDA6woVhokEaeKSeQY?=
 =?us-ascii?Q?6ylkRUhliP0KOwyh+fdZWl1Q1RFQ2wlg/xUXlH8aHoc4FgnoD46tHKEwT5vL?=
 =?us-ascii?Q?+uA2EogUQIIDtF1YaCvIUfo5OSIzljVloP4RjjamN+wggdY+0WOs+TbU8KKP?=
 =?us-ascii?Q?RxN8H6mNUdtl+2iLWohk5uZzOBrUpYue6GDP/BcQnJsN4MI9RGaXq1bqDzvv?=
 =?us-ascii?Q?oNIwXkQMyYmXGIulgVbB+iTKZDEzy5qUL3NCe27WDBk7qaDaNPN4MJ6/8mcV?=
 =?us-ascii?Q?y86afUhOzr2zFwDvcVnSS/y8O6ZbrHvC2ZH3NjQ7NTSH1gka5JL9Uam7Ahtz?=
 =?us-ascii?Q?GZnK8EYhRHtBw8vi6fT/9OcgdChqi+/uOf5GLUu+jwhibDvDMB160UNoJ695?=
 =?us-ascii?Q?x5wOr7qG5cpS1NjizLxPOzvI3/Ymokf9pKmeN+Ek6n4Jx3XLXL4JadrmUepa?=
 =?us-ascii?Q?zbLe7e5KUFb8/58ED60EMpD2WGSwYY+clWFsE7up13BNzhKoh7vU40Jif2M8?=
 =?us-ascii?Q?j5gawlyzqrY+4a5GSvWMqVakcoQJ21mOS7QZrts7zwXgCDCJ7Djp29PDc96Z?=
 =?us-ascii?Q?j+76KOmvejGz56/QyzugaSmyTP7o0W0Xk6pOzny8/9VQIhYJgdsbiVoi9bOs?=
 =?us-ascii?Q?FFDmuIZJe8uQ5T7A6n8vZ91/LWwLjIrhI2BCZgljaTaZQcRCFdtqx24e8zay?=
 =?us-ascii?Q?olnihBuLaPgMlLSmnV+fhOyzRGKu3eFeUmDS/TLB+JUnOvNt2Bvf/REsfQJK?=
 =?us-ascii?Q?xfwEJ42aOzBz8wYUE37aDZ4Xabx72S5wBFKR/MRuck05Y6njeZu18A0ughkQ?=
 =?us-ascii?Q?uZaw6k7PWKfsAA2R9PbXXts5yjzv2VPGJ9aIe4e7sHmH2PV4hdElZfBy8lMU?=
 =?us-ascii?Q?CHQZ1SHYlFOU7mTCvMk8OQK5Xzug6hKI7vPhbWbmsy2IQG4pNFro+5vCJpDF?=
 =?us-ascii?Q?PdvWhh42YRVFO081XV0WHoGkqrcQm+8hK851+XczOMEPB5HmfGpP5sIq8CPi?=
 =?us-ascii?Q?YOXiIiYOX7+XD/WIl+fmAtXSFwHkZCPa88RC9DQFn5AByvH2khNZrSmKBHz5?=
 =?us-ascii?Q?tviP9gtiOhjF2X5rTS3h6omdU+lD4+DfVIoMwm9m/ntQaB3KZJ+HCg4gsCAB?=
 =?us-ascii?Q?o+ib/YoAu0upYaUWm+yUBcdCthVCxffYKGeq9AP2FTJMLgjnK6Ajn7OYlEnB?=
 =?us-ascii?Q?ozZW20CwHc+/kFsyKIOpicIm18S8CmjWwpnJoM+tNs8poV4DqZbGV+zMjaM2?=
 =?us-ascii?Q?01en7DS8EfAIqy5id6gZJjM9MPRlEY0XPjM8n4V0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23216f78-f85f-4417-bb37-08dca57119ef
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:27:16.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL0P5B8xmmZze9g6XK2MZ11NSirsoeMPpncm42sLCAQr0HAi0qIfLv3TqaKvkMkcgiAv2VI2RpB4sapA2doUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6801

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
Changes from v7:
  - Eliminate the local variable 'ret' by suggestion
  - Simplify and optimize the if (READ_ONCE() ...) by suggestion
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
 lib/sbitmap.c           | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

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
index 1e453f825c05..5e2e93307f0d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -60,12 +60,30 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
+		unsigned int depth, unsigned int alloc_hint, bool wrap)
 {
-	unsigned long mask;
+	unsigned long mask, word_mask;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	guard(spinlock_irqsave)(&map->swap_lock);
+
+	if (!map->cleared) {
+		if (depth == 0)
+			return false;
+
+		word_mask = (~0UL) >> (BITS_PER_LONG - depth);
+		/*
+		 * The current behavior is to always retry after moving
+		 * ->cleared to word, and we change it to retry in case
+		 * of any free bits. To avoid an infinite loop, we need
+		 * to take wrap & alloc_hint into account, otherwise a
+		 * soft lockup may occur.
+		 */
+		if (!wrap && alloc_hint)
+			word_mask &= ~((1UL << alloc_hint) - 1);
+
+		return (READ_ONCE(map->word) & word_mask) != word_mask;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -85,6 +103,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +135,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +148,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(&sb->map[i], 0, 0, 0);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -179,7 +201,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 					alloc_hint, wrap);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(map))
+		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
 			break;
 	} while (1);
 
@@ -496,7 +518,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map);
+		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
 		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
-- 
2.34.1

