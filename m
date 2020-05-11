Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90CC47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 04:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B592075E
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 04:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Syeli+mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgEKEI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 00:08:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46324 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725817AbgEKEI6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 00:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589170137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zP/+6OjA9hJznhvtBYrqxhj1ahM1z8FANvwBXq5YO+o=;
        b=Syeli+mHQER6dNyzeDYM9N5zYPEZZhVr5m+71J0S2NnHz6ruhSBZe1U1JG5cuEzcevHzdR
        arKskGRX971iNnEXtsjrAKAi7kX4dAhjSE9aJ00/34y4+RhcKAptGxWSKsVlDs6krnKeUn
        FpBB3lgcz1RI1Mks6Lx0e+nlof5dEu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-wCG7DOBSNc-3bi6dn3WVUg-1; Mon, 11 May 2020 00:08:54 -0400
X-MC-Unique: wCG7DOBSNc-3bi6dn3WVUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BE5461;
        Mon, 11 May 2020 04:08:53 +0000 (UTC)
Received: from T590 (ovpn-13-75.pek2.redhat.com [10.72.13.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1072A5D9DA;
        Mon, 11 May 2020 04:08:45 +0000 (UTC)
Date:   Mon, 11 May 2020 12:08:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V10 11/11] block: deactivate hctx when the hctx is
 actually inactive
Message-ID: <20200511040841.GE1418834@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
 <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
 <20200511021133.GC1418834@T590>
 <73702cd9-6dcc-a757-be3b-c250e050692c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73702cd9-6dcc-a757-be3b-c250e050692c@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 10, 2020 at 08:30:29PM -0700, Bart Van Assche wrote:
> On 2020-05-10 19:11, Ming Lei wrote:
> > One simple solution is to pass BLK_MQ_REQ_PREEMPT to blk_get_request()
> > called in blk_mq_resubmit_rq() because at that time freezing wait won't
> > return and it is safe to allocate a new request for completing old
> > requests originated from inactive hctx.
> 
> I don't think that will help. Freezing a request queue starts with a
> call of this function:
> 
> void blk_freeze_queue_start(struct request_queue *q)
> {
> 	mutex_lock(&q->mq_freeze_lock);
> 	if (++q->mq_freeze_depth == 1) {
> 		percpu_ref_kill(&q->q_usage_counter);
> 		mutex_unlock(&q->mq_freeze_lock);
> 		if (queue_is_mq(q))
> 			blk_mq_run_hw_queues(q, false);
> 	} else {
> 		mutex_unlock(&q->mq_freeze_lock);
> 	}
> }
> 
> From blk_queue_enter():
> 
> 	const bool pm = flags & BLK_MQ_REQ_PREEMPT;
> 	[ ... ]
> 	if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> 		/*
> 		 * The code that increments the pm_only counter is
> 		 * responsible for ensuring that that counter is
> 		 * globally visible before the queue is unfrozen.
> 		 */
> 		if (pm || !blk_queue_pm_only(q)) {
> 			success = true;
> 		} else {
> 			percpu_ref_put(&q->q_usage_counter);
> 		}
> 	}
> 
> In other words, setting the BLK_MQ_REQ_PREEMPT flag only makes a
> difference if blk_queue_pm_only(q) == true. Freezing a request queue
> involves calling percpu_ref_kill(&q->q_usage_counter). That causes all
> future percpu_ref_tryget_live() calls to return false until the queue
> has been unfrozen.

OK, just forgot the whole story, but the issue can be fixed quite easily
by adding a new request allocation flag in slow path, see the following
patch:

diff --git a/block/blk-core.c b/block/blk-core.c
index ec50d7e6be21..d743be1b45a2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -418,6 +418,11 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (success)
 			return 0;
 
+		if (flags & BLK_MQ_REQ_FORCE) {
+			percpu_ref_get(ref);
+			return 0;
+		}
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c2ea0a6e5b56..2816886d0bea 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -448,6 +448,13 @@ enum {
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
 	/* set RQF_PREEMPT */
 	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
+
+	/*
+	 * force to allocate request and caller has to make sure queue
+	 * won't be forzen completely during allocation, and this flag
+	 * is only applied after queue freeze is started
+	 */
+	BLK_MQ_REQ_FORCE	= (__force blk_mq_req_flags_t)(1 << 4),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,



thanks, 
Ming

