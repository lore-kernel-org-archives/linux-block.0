Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83B6C54FC8
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5834C2076B
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 20:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS07A22k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgI2UkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgI2Uj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 16:39:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF2C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 13:39:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so5832881qkj.7
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sMTUhRtCxJUsKQa8lWSMtjMRe19Fo8nho/L0Qwh7iyo=;
        b=oS07A22ksJFP/7LlOUycz/+jB2f6MlBvAOohuIw7HI7s397TX+tz1ajGHkiyRNVIGw
         GgNsiV+B+dHX1S9OlHBeNzU+idisjvlCNUjz6eztMp7+0UsIA5EOwZcYRBB72aqFU/Ji
         m2VFtOnF2yJzebbQSeWndYA8wJFs5uHLsYJP+kaMrk+g8VfpWm3tanNI8tTJIVuxdOqK
         VM5ZLrlUytrC9NgHje0zavwWrpKHFsDF5V9Ks86Aaz8vy2LzZDeOC4lbXOPfuuf+ywsS
         A66oCi7FwvZiScrmPzJ4r8Ba68eCayUPL29qAeaVHFLanVQjONgxaNByg/lnuxfPoP/s
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sMTUhRtCxJUsKQa8lWSMtjMRe19Fo8nho/L0Qwh7iyo=;
        b=nDSb/mcmsK/RnkrmEZ1vcwC/oAYD4Sd3x+3HolexF+3Ozmn4cbF5Hs9D0g17SGxNM9
         jTWgUVDgcmJk1Pe+101qS9WiIZc9hFv2sgiXbuS/zH3+DOmLAH/sRKSmKFLzcdcmesdB
         EZkOMusZNjd6JD1K7n4hTq25spjnT3jyDN1diJw04IMMvTjoWSjD72unMUWg6bEmCAM6
         D64RIOB+mxbyT9hiY6l7W+7EOH/QcMLVJoOwrAQDgG4i2+5vyRJ7qgrQ4PnY5BqD1drv
         lzHn8WcRBxz/5Ug+GyBlnVsAWl/+ROS4bLIPqI5gEg1el4gQ0AaR5BXruCPtDS0VWBy9
         viJw==
X-Gm-Message-State: AOAM531DZqytqVAxQYKOD/wxMnu9x4vpPfs4MLnDEi1RL0a+v8rsjdN8
        J51pPyWwtv9SOFR/eLxGUDk9Yr9+gvgq+Q==
X-Google-Smtp-Source: ABdhPJw6/0w3PjPmwfjKAedASq1Q1IPvzg5LFAs40kuAwjsyHSs8b1oYGcpeCJ4D+icBI79osgAznQ==
X-Received: by 2002:a37:e218:: with SMTP id g24mr6151311qki.496.1601411994170;
        Tue, 29 Sep 2020 13:39:54 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y29sm7015653qtj.20.2020.09.29.13.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:39:53 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Tue, 29 Sep 2020 16:39:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] dm: fix missing imposition of queue_limits from dm_wq_work()
 thread
Message-ID: <20200929203952.GA19218@lobo>
References: <20200927120435.44118-1-jefflexu@linux.alibaba.com>
 <20200928160322.GA23320@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928160322.GA23320@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28 2020 at 12:03P -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Sun, Sep 27 2020 at  8:04am -0400,
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
> > Hi Mike, would you mind further expalin why bio processed by dm_wq_work()
> > always gets a previous ->submit_bio. Considering the following call graph:
> > 
> > ->submit_bio, that is, dm_submit_bio
> >   DMF_BLOCK_IO_FOR_SUSPEND set, thus queue_io()
> > 
> > then worker thread dm_wq_work()
> >   dm_process_bio  // at this point. the input bio is the original bio
> >                      submitted to dm device
> > 
> > Please let me know if I missed something.
> > 
> > Thanks.
> > Jeffle
> 
> In general you have a valid point, that blk_queue_split() won't have
> been done for the suspended device case, but blk_queue_split() cannot be
> used if not in ->submit_bio -- IIUC you cannot just do it from a worker
> thread and hope to have proper submission order (depth first) as
> provided by __submit_bio_noacct().  Because this IO will be submitted
> from worker you could have multiple threads allocating from the
> q->bio_split mempool at the same time.
> 
> All said, I'm not quite sure how to address this report.  But I'll keep
> at it and see what I can come up with.

Here is what I've staged for 5.10:

From: Mike Snitzer <snitzer@redhat.com>
Date: Mon, 28 Sep 2020 13:41:36 -0400
Subject: [PATCH] dm: fix missing imposition of queue_limits from dm_wq_work() thread

If a DM device was suspended when bios were issued to it, those bios
would be deferred using queue_io(). Once the DM device was resumed
dm_process_bio() could be called by dm_wq_work() for original bio that
still needs splitting. dm_process_bio()'s check for current->bio_list
(meaning call chain is within ->submit_bio) as a prerequisite for
calling blk_queue_split() for "abnormal IO" would result in
dm_process_bio() never imposing corresponding queue_limits
(e.g. discard_granularity, discard_max_bytes, etc).

Fix this by folding dm_process_bio() into dm_submit_bio() and
always have dm_wq_work() resubmit deferred bios using
submit_bio_noacct().

Side-effect is blk_queue_split() is always called for "abnormal IO" from
->submit_bio, be it from application thread or dm_wq_work() workqueue,
so proper bio splitting and depth-first bio submission is performed.

While at it, cleanup dm_submit_bio()'s DMF_BLOCK_IO_FOR_SUSPEND related
branching and expand scope of dm_get_live_table() rcu reference on map
via common 'out' label to dm_put_live_table(). Also, rename bio variable
in dm_wq_work() from 'c' to 'bio'.

Fixes: cf9c37865557 ("dm: fix comment in dm_process_bio()")
Reported-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 67 +++++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 43 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a1adcf0ab821..1813201d772a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1665,34 +1665,6 @@ static blk_qc_t __process_bio(struct mapped_device *md, struct dm_table *map,
 	return ret;
 }
 
-static blk_qc_t dm_process_bio(struct mapped_device *md,
-			       struct dm_table *map, struct bio *bio)
-{
-	blk_qc_t ret = BLK_QC_T_NONE;
-
-	if (unlikely(!map)) {
-		bio_io_error(bio);
-		return ret;
-	}
-
-	/*
-	 * If in ->submit_bio we need to use blk_queue_split(), otherwise
-	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
-	 * won't be imposed.
-	 * If called from dm_wq_work() for deferred bio processing, bio
-	 * was already handled by following code with previous ->submit_bio.
-	 */
-	if (current->bio_list) {
-		if (is_abnormal_io(bio))
-			blk_queue_split(&bio);
-		/* regular IO is split by __split_and_process_bio */
-	}
-
-	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
-		return __process_bio(md, map, bio);
-	return __split_and_process_bio(md, map, bio);
-}
-
 static blk_qc_t dm_submit_bio(struct bio *bio)
 {
 	struct mapped_device *md = bio->bi_disk->private_data;
@@ -1713,22 +1685,34 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	}
 
 	map = dm_get_live_table(md, &srcu_idx);
+	if (unlikely(!map)) {
+		bio_io_error(bio);
+		goto out;
+	}
 
-	/* if we're suspended, we have to queue this io for later */
+	/* If suspended, queue this IO for later */
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
-		dm_put_live_table(md, srcu_idx);
-
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-		else if (!(bio->bi_opf & REQ_RAHEAD))
-			queue_io(md, bio);
-		else
+		else if (bio->bi_opf & REQ_RAHEAD)
 			bio_io_error(bio);
-		return ret;
+		else
+			queue_io(md, bio);
+		goto out;
 	}
 
-	ret = dm_process_bio(md, map, bio);
+	/*
+	 * Use blk_queue_split() for abnormal IO (e.g. discard, writesame, etc)
+	 * otherwise associated queue_limits won't be imposed.
+	 */
+	if (is_abnormal_io(bio))
+		blk_queue_split(&bio);
 
+	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
+		ret = __process_bio(md, map, bio);
+	else
+		ret = __split_and_process_bio(md, map, bio);
+out:
 	dm_put_live_table(md, srcu_idx);
 	return ret;
 }
@@ -2385,7 +2369,7 @@ static void dm_wq_work(struct work_struct *work)
 {
 	struct mapped_device *md = container_of(work, struct mapped_device,
 						work);
-	struct bio *c;
+	struct bio *bio;
 	int srcu_idx;
 	struct dm_table *map;
 
@@ -2393,16 +2377,13 @@ static void dm_wq_work(struct work_struct *work)
 
 	while (!test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) {
 		spin_lock_irq(&md->deferred_lock);
-		c = bio_list_pop(&md->deferred);
+		bio = bio_list_pop(&md->deferred);
 		spin_unlock_irq(&md->deferred_lock);
 
-		if (!c)
+		if (!bio)
 			break;
 
-		if (dm_request_based(md))
-			(void) submit_bio_noacct(c);
-		else
-			(void) dm_process_bio(md, map, c);
+		submit_bio_noacct(bio);
 	}
 
 	dm_put_live_table(md, srcu_idx);
-- 
2.15.0

