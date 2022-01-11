Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10447C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiAKL5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239324AbiAKL5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWwvbOG2GKIjre8pObQ51fShfG1r4i+IjOSlKDUp1zI=;
        b=aHNRvb54yBYnItQ5+OmfTzf5W3zzFx7AX3BtMneMNe6kF1cSA5Htn7pOkzK4nH8Un/cjPf
        /MqDkrd2a1HhNQGm+9rpfG95wvHhn4JY4M7fWz6YECH5rEj1nk3cbzr7dvp18qx6Gzr+TS
        Uf3FwP8PS40EgHH7SuRIS7ed4nEgya0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-j_kxovOaPZeAlmZQEEymwQ-1; Tue, 11 Jan 2022 06:57:00 -0500
X-MC-Unique: j_kxovOaPZeAlmZQEEymwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03845839A42;
        Tue, 11 Jan 2022 11:56:59 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3020E7AB70;
        Tue, 11 Jan 2022 11:56:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 7/7] block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
Date:   Tue, 11 Jan 2022 19:55:32 +0800
Message-Id: <20220111115532.497117-8-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large
IO scenarios") since we have another easier way to address this issue and
get better iops throttling result.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 28 ----------------------------
 block/blk-throttle.h |  5 -----
 2 files changed, 33 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 36c17fcb67ef..cf7e20804f1b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -641,8 +641,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 
-	atomic_set(&tg->io_split_cnt[rw], 0);
-
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
 	 * bio dispatch. That means since start of last slice, we never used
@@ -666,8 +664,6 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 
-	atomic_set(&tg->io_split_cnt[rw], 0);
-
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -901,9 +897,6 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
-	if (iops_limit != UINT_MAX)
-		tg->io_disp[rw] += atomic_xchg(&tg->io_split_cnt[rw], 0);
-
 	if (tg_with_in_bps_limit(tg, bio, bps_limit, &bps_wait) &&
 	    tg_with_in_iops_limit(tg, bio, iops_limit, &iops_wait)) {
 		if (wait)
@@ -1928,14 +1921,12 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	}
 
 	if (tg->iops[READ][LIMIT_LOW]) {
-		tg->last_io_disp[READ] += atomic_xchg(&tg->last_io_split_cnt[READ], 0);
 		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
 		if (iops >= tg->iops[READ][LIMIT_LOW])
 			tg->last_low_overflow_time[READ] = now;
 	}
 
 	if (tg->iops[WRITE][LIMIT_LOW]) {
-		tg->last_io_disp[WRITE] += atomic_xchg(&tg->last_io_split_cnt[WRITE], 0);
 		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
 		if (iops >= tg->iops[WRITE][LIMIT_LOW])
 			tg->last_low_overflow_time[WRITE] = now;
@@ -2054,25 +2045,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-void blk_throtl_charge_bio_split(struct bio *bio)
-{
-	struct blkcg_gq *blkg = bio->bi_blkg;
-	struct throtl_grp *parent = blkg_to_tg(blkg);
-	struct throtl_service_queue *parent_sq;
-	bool rw = bio_data_dir(bio);
-
-	do {
-		if (!parent->has_rules[rw])
-			break;
-
-		atomic_inc(&parent->io_split_cnt[rw]);
-		atomic_inc(&parent->last_io_split_cnt[rw]);
-
-		parent_sq = parent->service_queue.parent_sq;
-		parent = sq_to_tg(parent_sq);
-	} while (parent);
-}
-
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c996a15f290e..b23a9f3abb82 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -138,9 +138,6 @@ struct throtl_grp {
 	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
 	unsigned long bio_cnt_reset_time;
 
-	atomic_t io_split_cnt[2];
-	atomic_t last_io_split_cnt[2];
-
 	struct blkg_rwstat stat_bytes;
 	struct blkg_rwstat stat_ios;
 };
@@ -164,13 +161,11 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
-static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
-void blk_throtl_charge_bio_split(struct bio *bio);
 bool __blk_throtl_bio(struct bio *bio);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
-- 
2.31.1

