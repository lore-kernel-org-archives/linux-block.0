Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A512C04AB6
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 03:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2702027B24
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 03:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCD40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfFCD40 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Jun 2019 23:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FF0930842CE;
        Mon,  3 Jun 2019 03:56:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5252110027CA;
        Mon,  3 Jun 2019 03:56:11 +0000 (UTC)
Date:   Mon, 3 Jun 2019 11:56:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 8/9] scsi: megaraid: convert private reply queue to
 blk-mq hw queue
Message-ID: <20190603035605.GB13684@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-9-ming.lei@redhat.com>
 <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com>
 <20190602064202.GA2731@ming.t460p>
 <20190602074757.GA31572@ming.t460p>
 <020a7707a31803d65dd94cc0928a425a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020a7707a31803d65dd94cc0928a425a@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 03 Jun 2019 03:56:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Kashyap,

Thanks for collecting the log.

On Sun, Jun 02, 2019 at 10:04:01PM +0530, Kashyap Desai wrote:
> > Meantime please try the following patch and see if difference can be
> made.
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c index
> > 49d73d979cb3..d2abec3b0f60 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -589,7 +589,7 @@ static void __blk_mq_complete_request(struct
> > request *rq)
> >  	 * So complete IO reqeust in softirq context in case of single
> queue
> >  	 * for not degrading IO performance by irqsoff latency.
> >  	 */
> > -	if (q->nr_hw_queues == 1) {
> > +	if (q->nr_hw_queues == 1 || (rq->mq_hctx->flags &
> > BLK_MQ_F_HOST_TAGS))
> > +{
> >  		__blk_complete_request(rq);
> >  		return;
> >  	}
> > @@ -1977,7 +1977,8 @@ static blk_qc_t blk_mq_make_request(struct
> > request_queue *q, struct bio *bio)
> >  		/* bypass scheduler for flush rq */
> >  		blk_insert_flush(rq);
> >  		blk_mq_run_hw_queue(data.hctx, true);
> > -	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops-
> > >commit_rqs)) {
> > +	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs
> > ||
> > +				(data.hctx->flags & BLK_MQ_F_HOST_TAGS)))
> > {
> >  		/*
> >  		 * Use plugging if we have a ->commit_rqs() hook as well,
> as
> >  		 * we know the driver uses bd->last in a smart fashion.
> 
> Ming -
> 
> I tried above patch and no improvement in performance.
> 
> Below is perf record data - lock contention is while getting the tag
> (blk_mq_get_tag )
> 
> 6.67%     6.67%  fio              [kernel.vmlinux]  [k]
> native_queued_spin_lock_slowpath
>    - 6.66% io_submit
>       - 6.66% entry_SYSCALL_64
>          - do_syscall_64
>             - 6.66% __x64_sys_io_submit
>                - 6.66% io_submit_one
>                   - 6.66% aio_read
>                      - 6.66% generic_file_read_iter
>                         - 6.66% blkdev_direct_IO
>                            - 6.65% submit_bio
>                               - generic_make_request
>                                  - 6.65% blk_mq_make_request
>                                     - 6.65% blk_mq_get_request
>                                        - 6.65% blk_mq_get_tag
>                                           - 6.58%
> prepare_to_wait_exclusive
>                                              - 6.57%
> _raw_spin_lock_irqsave
> 
> queued_spin_lock_slowpath

Please drop the patch in my last email, and apply the following patch
and see if we can make a difference:

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3d6780504dcb..69d6bffcc8ff 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -627,6 +627,9 @@ static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+
 	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
 	return 0;
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 309ec5079f3f..58ef83a34fda 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -30,6 +30,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
 	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		atomic_inc(&hctx->tags->active_queues);
@@ -55,6 +58,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+
 	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return;
 
@@ -74,6 +80,10 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 
 	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
 		return true;
+
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return true;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..84e9b46ffc78 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -36,11 +36,22 @@ extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
 
+static inline struct blk_mq_hw_ctx *blk_mq_master_hctx(
+		struct blk_mq_hw_ctx *hctx)
+{
+	return hctx->queue->queue_hw_ctx[0];
+}
+
+
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
 {
 	if (!hctx)
 		return &bt->ws[0];
+
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+
 	return sbq_wait_ptr(bt, &hctx->wait_index);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 49d73d979cb3..4196ed3b0085 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -303,7 +303,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	} else {
 		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
+			blk_mq_inc_nr_active(data->hctx);
 		}
 		rq->tag = tag;
 		rq->internal_tag = -1;
@@ -517,7 +517,7 @@ void blk_mq_free_request(struct request *rq)
 
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		atomic_dec(&hctx->nr_active);
+		blk_mq_dec_nr_active(hctx);
 
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->backing_dev_info);
@@ -1064,7 +1064,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	if (rq->tag >= 0) {
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
+			blk_mq_inc_nr_active(data.hctx);
 		}
 		data.hctx->tags->rqs[rq->tag] = rq;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 633a5a77ee8b..f1279b8c2289 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -193,6 +193,20 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2]);
 
+static inline void blk_mq_inc_nr_active(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+	atomic_inc(&hctx->nr_active);
+}
+
+static inline void blk_mq_dec_nr_active(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+		hctx = blk_mq_master_hctx(hctx);
+	atomic_dec(&hctx->nr_active);
+}
+
 static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
@@ -218,7 +232,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
+		blk_mq_dec_nr_active(hctx);
 	}
 }
 
Thanks,
Ming
