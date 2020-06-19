Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F61C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BAE224B2
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 23:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Glf/S8tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgFSXES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:04:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730206AbgFSXES (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 19:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592607856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Vy+5yEl0Y9eK901rvk0wKpSyr7znRV+7rJBYJaGx2k=;
        b=Glf/S8ttdpM1NsC3jOVEKYMsuuOqneaeF/qHqTt4OKWnPosaZHusS1y6BSKSBXYExcwNQY
        cisOWhSzPhlwr2lZ8LPJNrhGxXGnC+3IirS9O0em/BbqQlCsuo2RxubDgdHeoFvub+FdkR
        Awbmnj2NuWODxHotrwoyKxZYSsN4Y6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-KhvzwmMvPAuatQfpgekl_Q-1; Fri, 19 Jun 2020 19:04:12 -0400
X-MC-Unique: KhvzwmMvPAuatQfpgekl_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A928B800053;
        Fri, 19 Jun 2020 23:04:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFA7F19C4F;
        Fri, 19 Jun 2020 23:04:05 +0000 (UTC)
Date:   Fri, 19 Jun 2020 19:04:05 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, axboe@kernel.dk,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619230404.GA26305@redhat.com>
References: <20200619084214.337449-1-ming.lei@redhat.com>
 <20200619094250.GA18410@redhat.com>
 <20200619101142.GA339442@T590>
 <20200619160657.GA24520@redhat.com>
 <20200619174040.GA24968@redhat.com>
 <20200619223744.GB353853@T590>
 <20200619225241.GC353853@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619225241.GC353853@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19 2020 at  6:52pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Sat, Jun 20, 2020 at 06:37:44AM +0800, Ming Lei wrote:
> > On Fri, Jun 19, 2020 at 01:40:41PM -0400, Mike Snitzer wrote:
> > > On Fri, Jun 19 2020 at 12:06pm -0400,
> > > Mike Snitzer <snitzer@redhat.com> wrote:
> > > 
> > > > On Fri, Jun 19 2020 at  6:11am -0400,
> > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > 
> > > > > Hi Mike,
> > > > > 
> > > > > On Fri, Jun 19, 2020 at 05:42:50AM -0400, Mike Snitzer wrote:
> > > > > > Hi Ming,
> > > > > > 
> > > > > > Thanks for the patch!  But I'm having a hard time understanding what
> > > > > > you've written in the patch header,
> > > > > > 
> > > > > > On Fri, Jun 19 2020 at  4:42am -0400,
> > > > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > 
> > > > > > > dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> > > > > > > remove the check.
> > > > > > 
> > > > > > It'd be helpful if you could unpack this with more detail before going on
> > > > > > to explain why using blk_queue_quiesced, despite dm-rq using
> > > > > > blk_mq_queue_stopped, would also be ineffective.
> > > > > > 
> > > > > > SO:
> > > > > > 
> > > > > > > dm-rq won't stop queue
> > > > > > 
> > > > > > 1) why won't dm-rq stop the queue?  Do you mean it won't reliably
> > > > > >    _always_ stop the queue because of the blk_mq_queue_stopped() check?
> > > > > 
> > > > > device mapper doesn't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues.
> > > > > 
> > > > > > 
> > > > > > > meantime blk-mq won't stop one queue too, so remove the check.
> > > > > > 
> > > > > > 2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
> > > > > > queue is stopped, given blk-mq must stop all hw queues a positive return
> > > > > > from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
> > > > > > all hw queues are stopped.
> > > > > 
> > > > > blk-mq won't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues for
> > > > > dm-rq's queue too, so dm-rq's hw queue won't be stopped.
> > > > > 
> > > > > BTW blk_mq_stop_hw_queue or blk_mq_stop_hw_queues are supposed to be
> > > > > used for throttling queue.
> > > > 
> > > > I'm going to look at actually stopping the queue (using one of these
> > > > interfaces).  I didn't realize I wasn't actually stopping the queue.
> > > > The intent was to do so.
> > > > 
> > > > In speaking with Jens yesterday about freeze vs stop: it is clear that
> > > > dm-rq needs to still be able to allocate new requests, but _not_ call
> > > > the queue_rq to issue the requests, while "stopped" (due to dm-mpath
> > > > potentially deferring retries of failed requests because of path failure
> > > > while quiescing the queue during DM device suspend).  But that freezing
> > > > the queue goes too far because it won't allow such request allocation.
> > > 
> > > Seems I'm damned if I do (stop) or damned if I don't (new reports of
> > > requests completing after DM device suspend's
> > > blk_mq_quiesce_queue()+dm_wait_for_completion()).
> > 
> > request(but not new) completing is possible after blk_mq_quiesce_queue()+
> > dm_wait_for_completion, because blk_mq_rq_inflight() only checks INFLIGHT
> > request. If all requests are marked as MQ_RQ_COMPLETE, blk_mq_rq_inflight()
> > still may return false. However, MQ_RQ_COMPLETE is one transient state.
> > 
> > So what does dm-rq expect from dm_wait_for_completion()?
> > 
> > If it is just no new request entering dm_queue_rq(), there shouldn't be
> > issue.
> > 
> > If dm-rq hopes there aren't any real inflight request(MQ_RQ_COMPLETE &
> > MQ_RQ_INFLIGHT), we can change blk_mq_rq_inflight to support that.
> 
> Hi Mike,
> 
> Please test the following patch and see if the issue can be fixed:
> 
> From faf0f9f15627446e8c35db518e37a4a2e4323eb2 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Sat, 20 Jun 2020 06:45:49 +0800
> Subject: [PATCH] blk-mq: cover request of MQ_RQ_COMPLETE as inflight in
>  blk_mq_rq_inflight
> 
> When request is marked as MQ_RQ_COMPLETE, ->complete isn't called & done
> yet, and driver may expect that there isn't any driver related activity since
> blk_mq_queue_inflight() returns.
> 
> Fixes it by covering request of MQ_RQ_COMPLETE as inflight in blk_mq_rq_inflight().
> 
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4f57d27bfa73..7bc084b5bc37 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -831,7 +831,7 @@ static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	 * If we find a request that is inflight and the queue matches,
>  	 * we know the queue is busy. Return false to stop the iteration.
>  	 */
> -	if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
> +	if (rq->state != MQ_RQ_IDLE && rq->q == hctx->queue) {
>  		bool *busy = priv;
>  
>  		*busy = true;
> -- 
> 2.25.2
> 

I was going to ask if being more explit would be better:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f57d27bfa73..96816ce57eb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -828,10 +828,11 @@ static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
                                void *priv, bool reserved)
 {
         /*
-         * If we find a request that is inflight and the queue matches,
+         * If we find a request that is inflight or complete and the queue matches,
          * we know the queue is busy. Return false to stop the iteration.
          */
-        if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
+        if ((rq->state == MQ_RQ_IN_FLIGHT || rq->state == MQ_RQ_COMPLETE) &&
+            rq->q == hctx->queue) {
                 bool *busy = priv;

                 *busy = true;

But is your patch more forgiving of any future blk-mq states that might
also consistitute outstanding work?  Seems likely.

Thanks,
Mike

