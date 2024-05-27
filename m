Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2041.outbound.protection.outlook.com [40.107.117.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DEC121;
	Mon, 27 May 2024 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784117; cv=fail; b=dQjymtAg+CFLougzOVnFezg5XOEts+OhuTbTmhSgzenzXQ8SgJIEKtwebhhtR6wlobbDdpsMJRYKGkf0yFOXvNZFA9Hu975f5KS8/C7TfIQ5I5165+WZ6lJaT1fQsjaYPXMMbmT4UtbKIqAw7d4qXNIyBrLlSsIBnJCKiZv8mSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784117; c=relaxed/simple;
	bh=5FP5RDoQhJq2Haj00n9Se++ZKC+WxuYgsDqO329IxSw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=abTXpY/snxE/LmD/DtTX78b02w97f7Yr4D4bFfx1+F3ykxPSW3sAT52hlJ5j91NFrMmgOsJrJydMw0VcBJ/afX8O1i3ZXYSr5tR9QarM5Y6aSqFy+h6OOSx4MOKB5b7JT0phHgyY/0lOFCRkkg8kA+mvEHDkDQKYsZfi11lXzYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m1UlnANq; arc=fail smtp.client-ip=40.107.117.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m1UlnANq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esvrrs2Qimu+GmtSkgM6drIf5i6pByxMICdn0SIXUbhvc34/fgPFWCvcIFq7Qjj/q6LBuOffgd07EJyBFMfXMXYuhHdoraB6PrO+qOK4pKD0kSotWDVMQK4H9SGvlUOyIGz/pSdBZbwnnTuZSeLXUp46nw+WQE5Agenwqp3lZP4TykYUzUMGEflsk66sNe5om77jIw40ElHzdip3A1Wbc5fjLgSjs+3slhgutvdfcHNXrL41Cc/j2QzC536jj1UsFXH7luvjHMtfN7waJeUrxO+XRNB9XwWdbQ1xLQL83CAvVQJ8V6g+xkfHdgeikjLTJdS5KQBzJ9hSz2AjEMPtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEIiGxgT2VsLXHlbaIrmTjEr3/QjJo5Qh5YNhcNb/s4=;
 b=Fau+qYLvgj6915o1ssStcgAEu/TI8NaC6Sfk4sHpFOWno7eAnPSQpUU4ul6d8cfJcIHPU+eiEur804qQ+GAGEHGiGV/3TEeM/WwCZQXeOkvUFQLLHsU+cHscDy418/KMeaR5SdTbUbCLjtu6VRIZ15XI5J1dfMbXq5007cuX95cEeIf26S5pe8XwMQA69i00CILpZskMpCkqAE23rr71WzS3qpuKWL+1n7KDZXjuP1T9UH2VxDFgnxxEk4j2xKp715yswuJvVzJ1CorqoPs4Tsv801nh5Z1hGY3s6p8PKlvc5KpoV9fh33l+ZVzSkjR2WftqL9kQE7sZExIKjodC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEIiGxgT2VsLXHlbaIrmTjEr3/QjJo5Qh5YNhcNb/s4=;
 b=m1UlnANqC3JAcKl6vr/yEdnbIqXayQMgLu4KHshSruC76ttwzpe145MuMAfVOl5ykGNRluA56hLtF6jbG7o+iedS7HMDkIPy86721JTasNcFqM6EyTDhHXanPJv2Nf5Vg+icrOXdfTCIVt1tOjvgGZFVykeYDFGq+bid63Wetmb6RplJjDmtkblegqDwr1+VqxmDWvJRG4/Bo/8ZvakV23z1RPBnBSMGomCHsFf3GU0GnvGn/aPew+rv3omMUnrPE24FJQ4wu1M4/11W+NTV7Cyww4sclthu7yeBVbvup59TLpDGvM5LfLn9o1b3VLb8C+kZMpL2VFv/D7Pge/BNjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 04:28:32 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 04:28:32 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yang <yang.yang@vivo.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [RFC PATCH] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Mon, 27 May 2024 12:26:50 +0800
Message-Id: <20240527042654.2404-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bae6fa-45e8-466e-cf83-08dc7e05773c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AT5aFtfpClkhr3HQWeBp30O1ZjHyYSsPZvsPYLGIXbN+yk/kmv+xE+uG/sq?=
 =?us-ascii?Q?6Cujomc+JZKEYBwxIcBdNDnZBU0rYwldDR44pMf7mR5wukg7iFmtaOmhJbM2?=
 =?us-ascii?Q?5zwY+CqubYYy9vrkBL4QI9Pmj+c5SNQUysDv9u5XZrRAhkalnobIjOQm0V5a?=
 =?us-ascii?Q?i3bfZTPT5N8yq/Y8PTedCIWPatXby0bpzI5C2ID6+Up+fcWihArUSZnB89Gy?=
 =?us-ascii?Q?RDA4Hx8HFfwDynLn+roCGZQT7N2TC7yAMefMbltmkDxB/fAUQqD2PgzV+Jhu?=
 =?us-ascii?Q?WYGaMVGMYCdfiRsJDFSSzOItY04sFCGtCvv1o/EwrjkhYKlIrHx6qcvUzmHp?=
 =?us-ascii?Q?SJYG1pqklMx5wGtg9u05YEkUPf7CVTHNnNuKL7EFATXsYpjxx9RbsVY6YT37?=
 =?us-ascii?Q?8v2TTElw4AugN3GbQBBA4j10/tAg6brUC4OU16kMYZrwQCQ7NAUJibU3hRUB?=
 =?us-ascii?Q?qQz8OgLZcYIVx4kNyRTF82S3PqxshVqUHOAvwX/+C8VM8JZorKLU7VxQFijR?=
 =?us-ascii?Q?p8my5wYWir8yBRWjUSixDMXyAwDfXhCPF4sLKUres7GL+ZkAE/la1Zv+WUXu?=
 =?us-ascii?Q?CAh+oVIYsMl6kAdWnnee/+iRnKKzoJNXmGQA/F1RKPOqNdmYahJRzqD9m6dh?=
 =?us-ascii?Q?/ElWRUF0pWBWKmJelJaVUO8Y5PeuScS/UyCR54WWjBPnZCZdWqFuZjA4/X1u?=
 =?us-ascii?Q?YD8UGLf9w8xrWiluBe+fomK1i8f1RV2K0+cO9GdjTC4lAC6LUCNG3tX4fFKO?=
 =?us-ascii?Q?oZVUMB1y0Lj9MeizQ9137jI2oHllwva3xMork2ge8bI89NChUmeYtM3h8XMg?=
 =?us-ascii?Q?4CSaXOqRiExQXNUARQ6VLTo4WJcwbu+yqXU8iUOBw1cMq7o/m6DQSENcwaUm?=
 =?us-ascii?Q?uWOpUeZENuQBZrUf+BynGrLDbwfzIDE7RBFVdSaq4XdBk2D0+QlVlbVKdXmd?=
 =?us-ascii?Q?u6lJzsCkz6+DdcMEhbKKUdxmP0ZeVOLdBCaObg6jR+NnZOLz5WazzJREpPkC?=
 =?us-ascii?Q?CJ3qYVT2YZvWRP6sFedNdN7ZdtoYsO9Jf7O0+dQI5zsINT03KjPR8boas+l2?=
 =?us-ascii?Q?B6iqYaTxRGv8QbNxEHSwP9vbgQ9YPpiB+KgghGS3gaFwq8+lby+XroGxhkYJ?=
 =?us-ascii?Q?C73p8UExHWnUk+uuhurS62hrmcC1WtM6YqfazFVeoVmM8LfBKcCkh0UX/MN+?=
 =?us-ascii?Q?w3gE7REoKQrfviZLs/q5JWlw9C+pHq/McDU2It/1YqIgtnlhH5U2qhWq4FJe?=
 =?us-ascii?Q?oDc9hwSBVYQPXvmLlibeBODWe57DiyJXYQ8BQn9LIkcfbkEDikqUlB7xNWa/?=
 =?us-ascii?Q?1jKc8WMhn99AmvNpMoEtpHeYS3kt65EWDPrrm4bkU+4THA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chODXHFHATKDubhwM272/6ETJ12MDn7uj46RTKW0k+iQ2XhdMr4wbM0iaUZZ?=
 =?us-ascii?Q?jML+rN8xPiK5rG1IBxqQ3T32tSkT61VVoNxcmyQuZDJjGHvolLidG1efCGYP?=
 =?us-ascii?Q?CUhSB6eLKN9g/wOd5oq68ZVs3/McvtGRK+K62QB+MXiUqlTo6egza7Wub85G?=
 =?us-ascii?Q?GCScfRPpZWkdzZE+6Bwaeg/ZOI7xdTyBsa718pQFsxc7X51KL2VTAU2AgoX4?=
 =?us-ascii?Q?paKs4pYqshrNp4moaZqLyq//mQhQiJnFaDLnnK6ZlVfje5qPat3C80F1UhRp?=
 =?us-ascii?Q?pqWPXyJ4e+Bk8uEFEhtBqmkMWgarESmpZmXXoUQsRk4MFKKAwbNGbk+dTZI9?=
 =?us-ascii?Q?JQaV/JHXp4lKwWzurIBJUykcXHi0jEDM1WgZBry2gKKzEnK/Bt+Ex6NwXprE?=
 =?us-ascii?Q?w6zMR3T9+56aasU27XoA8I9Cafkr31q6c3xUiNA0czSi4xjvhJz+Fo4BRE6A?=
 =?us-ascii?Q?T7Xgp5ouXNUsbA5LN8t3OhvClll4Y9mHbnZG4DLtjkCXV+rUBgurKyy0oCQV?=
 =?us-ascii?Q?n3eUsKz01YP9Xa+CEX2fpxwKlySm2Ln9+sG6fIxSNUAhgN9NzKTUSQMiKAnY?=
 =?us-ascii?Q?V5qtOBZ7KmcDI4Kvg2F8z9r0ap/wiamfGPpou/Hf7jZtqP086wc4iFNSMzNy?=
 =?us-ascii?Q?+PMqYERs6YKsrIMz+RjsXOwDZh4xv7jg9xdcCHMg6EY68pOmNdEBBIcdI6hZ?=
 =?us-ascii?Q?Id16v5kFbH8KXMEQhpKaADzEhuZoqntuabBFOHsbuavJIybtvEpWlLcBdHa1?=
 =?us-ascii?Q?t2nAgOLISIOGhEaySl/3UKP2GD22bf9X06ihTf+oTxDqapRlAeNoB85EzcQM?=
 =?us-ascii?Q?HRSacX8aLNaQD8Y49Nb0qOtaoCBifmGhnZ5NdFAPMgED52k3QLX1CiMSR17C?=
 =?us-ascii?Q?Z3CWVMuJ3AJcWlCzP32vzXZpDFgohybOM1d5KqLF/3hq9euDspLfJoXH8q/L?=
 =?us-ascii?Q?OTmvmAdTy9stRPA7dZgyNoKjgAyKTP3qYLDl4vi0nj2i0jNOmrnWnZFtdy0k?=
 =?us-ascii?Q?WUvB9YOaZLfKqtbzQ4kzmiSTOT6W66l7dshfvUh3e47g4Z8z6N6jxEGhOO+I?=
 =?us-ascii?Q?0NBJ7aRSs0gxeGfBJLIATAsjFcLh4Jqw0Xs60CVtF+L2uRN4tAnL6sEDtcFS?=
 =?us-ascii?Q?YTihvX+zao5Ae/FlnuHgS+VNm0xQMzeSK9uzgL3aKgUf0cZcsTtRI0rt9HGa?=
 =?us-ascii?Q?p4M3izaKaizvzQ5OJFpy3Xi2vM2/n4UCJrA7OSgaNH+JPQnZVJUT05MK8Bff?=
 =?us-ascii?Q?ZxQvm0MRQmMVRcg3svOl0HKqQCWSWzL6banG2TY9i95C3Rb+aObw+5tjd+0k?=
 =?us-ascii?Q?X8Tf8nPKJU0zL6ijnsOKRdj+33m9ssbXuutSKYWYNiPBezIiJDOYRHlrBAAh?=
 =?us-ascii?Q?ajRiJv0S6MM9a5M0e9OSDcJnVsAJBuyzAm5w3lEENHPtCGXw6eBDze8HTD/1?=
 =?us-ascii?Q?u3J8cFXvbC2WPLW6vbRkvvZjblUDR3lSq10oSbd9o8413JXXw+zNzYTXMEoR?=
 =?us-ascii?Q?iRgwj8mwprOggR8XyY0p5zP4T6Ms9W75ljnjOpiWLcF6Mieq6hfLt6pCzoEs?=
 =?us-ascii?Q?lTMdJgy9aw17KnoZFo4WilPiUXKnLBI55+AYiXmV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bae6fa-45e8-466e-cf83-08dc7e05773c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 04:28:32.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LShssbvktRTB7JthA8oXi8f6czC/8QfKv9Yx4cPliuupmhA2FGIPsYUuAwhmNzeGwDz1WpgtUtZXJZjUfS2zoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504

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

Fix this issue by adding a new flag swap_inprogress to indicate whether
the swap is ongoing.

Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 22 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..b88a9e4997ab 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_inprogress: set to 1 when swapping word <-> cleared
+	 */
+	atomic_t swap_inprogress;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..d4bb258fe8b0 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
  */
 static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
-	unsigned long mask;
+	unsigned long mask, flags;
+	int zero = 0;
 
-	if (!READ_ONCE(map->cleared))
+	if (!READ_ONCE(map->cleared)) {
+		if (atomic_read(&map->swap_inprogress))
+			goto out_wait;
 		return false;
+	}
+
+	if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
+		goto out_wait;
+
+	local_irq_save(flags);
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 	 */
 	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
 	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
+
+	atomic_set(&map->swap_inprogress, 0);
+	smp_mb__after_atomic();
+	local_irq_restore(flags);
+	return true;
+
+out_wait:
+	while (atomic_read(&map->swap_inprogress))
+		;
 	return true;
 }
 
-- 
2.34.1

