Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBB143882
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664062; cv=none; b=cQa32GX3QTo1xqyJKtd7ToMIYlvgZdc3K5h9ojhTZGl10L8Vyb2gum4JWb6QuBHTu6O9DYN+8Yvli34BxpjrL+JfIQMd3obwaZ3jrc8EUwdAaXq3qEBTxpF2BQTOfIP0edKXMLSmNJNsI7ikFuSm781KwMAA9sF9i8kaOdfrxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664062; c=relaxed/simple;
	bh=7/jvPfPjLNWe682qDWZCvhO4ske8Ezk1Ybv6oqrtboM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6LtJbU/nCQRGx0rUNiz05Fuh+Aijoevv8i8l0GiE/M4PGKgLStTBU4r2TYNRq3bATDkuxM2CtAcBxMrxwz+Yvuxd8zWMNAZskn0wPtu1+sAxJzSMfwVZjSOUxFriLfo7oru5p0QGW1hXL7vWhQ2BS2u0QPQhQooopdVhtvOSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6JPIYeo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6JPIYeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724664059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/Rz9OL2Ql7AeANS5jndVyW8EU9zBxk9meDOMyH+oFI=;
	b=O6JPIYeoC/aoTzPaTjx7Nson3cIvf/eb/IAw2btZ86aEo9Fl387/183vRSXbMYJ3URs6ZL
	1X/ek9PK4MArEOdRxmZ9lMJrXYd+jbCnzsLb6ChgNxVj8E8QrPUTa0DJP/VMLzpTWZcZnZ
	yRtL3ecsX2hA+qowNJTT5ESKC/vUKtc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-KZ5NH_XSNcO0E27HjFksIw-1; Mon,
 26 Aug 2024 05:20:55 -0400
X-MC-Unique: KZ5NH_XSNcO0E27HjFksIw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E63A31955D53;
	Mon, 26 Aug 2024 09:20:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C3A219560A3;
	Mon, 26 Aug 2024 09:20:48 +0000 (UTC)
Date: Mon, 26 Aug 2024 17:20:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
Message-ID: <ZsxI6uCbGpQh1XrF@fedora>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com>
 <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
 <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Aug 26, 2024 at 03:33:18PM +0800, Muchun Song wrote:
> 
> 
> > On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> wrote:
> > 
> > On Fri, Aug 23, 2024 at 7:28 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> 
> >> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
> >>> Supposing the following scenario.
> >>> 
> >>> CPU0                                                                CPU1
> >>> 
> >>> blk_mq_request_issue_directly()                                     blk_mq_unquiesce_queue()
> >>>    if (blk_queue_quiesced())                                           blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
> >>>        blk_mq_insert_request()                                         blk_mq_run_hw_queues()
> >>>            /*                                                              blk_mq_run_hw_queue()
> >>>             * Add request to dispatch list or set bitmap of                    if (!blk_mq_hctx_has_pending())     4) load
> >>>             * software queue.                  1) store                            return
> >>>             */
> >>>        blk_mq_run_hw_queue()
> >>>            if (blk_queue_quiesced())           2) load
> >>>                return
> >>>            blk_mq_sched_dispatch_requests()
> >>> 
> >>> The full memory barrier should be inserted between 1) and 2), as well as
> >>> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
> >>> cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
> >>> Otherwise, either CPU will not re-run the hardware queue causing starvation.
> >> 
> >> Memory barrier shouldn't serve as bug fix for two slow code paths.
> >> 
> >> One simple fix is to add helper of blk_queue_quiesced_lock(), and
> >> call the following check on CPU0:
> >> 
> >>        if (blk_queue_quiesced_lock())
> >>         blk_mq_run_hw_queue();
> > 
> > This only fixes blk_mq_request_issue_directly(), I think anywhere that
> > matching this
> > pattern (inserting a request to dispatch list and then running the
> > hardware queue)
> > should be fixed. And I think there are many places which match this
> > pattern (E.g.
> > blk_mq_submit_bio()). The above graph should be adjusted to the following.
> > 
> > CPU0                                        CPU1
> > 
> > blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> > blk_mq_run_hw_queue()
> > blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
> >    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >        return                                      blk_mq_run_hw_queue()
> >    blk_mq_sched_dispatch_requests()                    if
> > (!blk_mq_hctx_has_pending())     4) load
> >                                                            return
> 
> Sorry. There is something wrong with my email client. Resend the graph.
> 
> CPU0                                        CPU1
> 
> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>     if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>         return                                      blk_mq_run_hw_queue()
>     blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_has_pending())     4) load
>                                                             return

OK.

The issue shouldn't exist if blk_queue_quiesced() return false in
blk_mq_run_hw_queue(), so it is still one race in two slow paths?

I guess the barrier-less approach should work too, such as:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..632261982a77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2202,6 +2202,12 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
+{
+	return !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx);
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2231,11 +2237,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * quiesced.
 	 */
 	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+		need_run = blk_mq_hw_queue_need_run(hctx));
 
-	if (!need_run)
-		return;
+	if (!need_run) {
+		unsigned long flags;
+
+		/* sync with unquiesce */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+
+		if (!need_run)
+			return;
+	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);


thanks,
Ming

