Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5946C10F00
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840162184C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692815;
	bh=wB5yMbd+xds0A6HLBwF/hSyrSp8RgZ6jaWVwZVO0FRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sV+t4FofD8q6ihcWdyTWYBu8jXQgLiNppEO4Nl/x/mYEoxQyuhutIK9ecalUk/xJi
	 q5p9GecUczpNqZ9P0reDYHP6RFZTVDAaud7fhUVmNRhFdQlw5v9QP/gxW4GyFHfQcs
	 faluxS14cprydKSN92KzNAl4rSZ1c4pwIdA4aqtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfC0NUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:20:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:56121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfC0NUM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 09:20:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="156248817"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2019 06:20:09 -0700
Date:   Wed, 27 Mar 2019 07:21:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Message-ID: <20190327132116.GA8419@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
 <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
 <20190327083142.GQ20525@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327083142.GQ20525@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 01:31:42AM -0700, Christoph Hellwig wrote:
> > Okay, I may even be able to drop the new block exports if we do request
> > termination in generic block layer. That's probably the right thing
> > anyway since that layer is in a better position to check the necessary
> > conditions that make tag iteration safe. Bart did point out that is
> > generally not safe for drives to do, so it'd be good to safegaurd against
> > incorrect usage.
> 
> Did you get a chance to look into this?

I haven't had a chance to put it through the proper tests (I no longer
have a hotplug machine), but this is what I'd written if you can give it
a quick look:

From 5afd8e3765eabf859100fda84e646a96683d7751 Mon Sep 17 00:00:00 2001
From: Keith Busch <keith.busch@intel.com>
Date: Tue, 12 Mar 2019 13:58:12 -0600
Subject: [PATCH] blk-mq: Provide request termination API

A driver that determined hardware contexts backing its request queue
is unable to service new commands, it would have to end those commands
in its IO path. This requires unlikely checks per-IO.

Create a new API that terminates all requests directly rather than
requiring those requests get flushed through the low level driver. This
is safe only if the current request allocation state is unchanging, so
driver must have quiesced and initiated a freeze on its queue, and after
it has reclaimed any in flight requests so that the tag iterator is not
racing with in flux requests. The new API enforces these conditions in
order to successfully terminate requests.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..ad98c27e2b34 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -952,6 +952,42 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_queue_exit(q);
 }
 
+static bool blk_mq_terminate_request(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	int *hctx_idx = priv;
+
+	if (WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE))
+		return false;
+	if (hctx->queue_num >= *hctx_idx)
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	return true;
+}
+
+/**
+ * blk_mq_terminate_queued_requests() - end requests with an error queued on
+ *					hardware contexts at and above the
+ *					provided index.
+ * @q: request queue
+ * @hctx_idx: starting hardware context, 0 for all hctx's
+ *
+ * A low level driver should invoke this routine when its hardware contexts are
+ * not capable of handling future requests. The caller must ensure their
+ * request_queue is quiesced, freeze initiated, and all dispatched requests
+ * have been reclaimed so the tag iteration has a static request allocation to
+ * consider.
+ */
+void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx)
+{
+	if (WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth)))
+		return;
+	if (WARN_ON_ONCE(!blk_queue_quiesced(q)))
+		return;
+	blk_sync_queue(q);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_request, &hctx_idx);
+}
+EXPORT_SYMBOL(blk_mq_terminate_queued_requests);
+
 struct flush_busy_ctx_data {
 	struct blk_mq_hw_ctx *hctx;
 	struct list_head *list;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a64b3fdce0b0..d47cd4575abb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -334,6 +334,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.14.4

