Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A555CC433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8282A60C4B
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhKBPLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232707AbhKBPLT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 11:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635865724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb1SYN90Ez79ucs+87GKFCsteOt8iwcSXkSkUiXXffc=;
        b=KUwQK9Mry0o4fG0nPp84nrdDGWjGASoOoZWjWhCAd0SD/wr4Edv6/JWJ2AXdMo5IY5rR+B
        NRMXnE/i11TM4fFPhaVZdPT05X+46gGHazl5LS9zL8KJ+hrixMTHswC3DWnkp5qtZmE1JP
        rCGLYnjJ0fIWfQvPa3mM9aymKzdCEQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-2uvb6S_yOjeVl5IkgWf0Zg-1; Tue, 02 Nov 2021 11:08:40 -0400
X-MC-Unique: 2uvb6S_yOjeVl5IkgWf0Zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75747BD522;
        Tue,  2 Nov 2021 15:08:39 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E08B794A6;
        Tue,  2 Nov 2021 15:08:30 +0000 (UTC)
Date:   Tue, 2 Nov 2021 23:08:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
Message-ID: <YYFUaaLNOExwJ5P1@T590>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
 <20211102133502.3619184-4-ming.lei@redhat.com>
 <922449db-73a7-efaf-52ef-d386edf77953@kernel.dk>
 <YYFDz1AQqDoglgyu@T590>
 <dda27cef-a3fc-03e7-0c28-c4b24600438e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda27cef-a3fc-03e7-0c28-c4b24600438e@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 02, 2021 at 08:57:41AM -0600, Jens Axboe wrote:
> On 11/2/21 7:57 AM, Ming Lei wrote:
> > On Tue, Nov 02, 2021 at 07:47:44AM -0600, Jens Axboe wrote:
> >> On 11/2/21 7:35 AM, Ming Lei wrote:
> >>> In case of shared tags and none io sched, batched completion still may
> >>> be run into, and hctx->nr_active is accounted when getting driver tag,
> >>> so it has to be updated in blk_mq_end_request_batch().
> >>>
> >>> Otherwise, hctx->nr_active may become same with queue depth, then
> >>> hctx_may_queue() always return false, then io hang is caused.
> >>>
> >>> Fixes the issue by updating the counter in batched way.
> >>>
> >>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/blk-mq.c | 15 +++++++++++++--
> >>>  block/blk-mq.h | 12 +++++++++---
> >>>  2 files changed, 22 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index 07eb1412760b..0dbe75034f61 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
> >>>  	struct blk_mq_hw_ctx *cur_hctx = NULL;
> >>>  	struct request *rq;
> >>>  	u64 now = 0;
> >>> +	int active = 0;
> >>>  
> >>>  	if (iob->need_ts)
> >>>  		now = ktime_get_ns();
> >>> @@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
> >>>  		rq_qos_done(rq->q, rq);
> >>>  
> >>>  		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
> >>> -			if (cur_hctx)
> >>> +			if (cur_hctx) {
> >>> +				if (active)
> >>> +					__blk_mq_sub_active_requests(cur_hctx,
> >>> +							active);
> >>>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
> >>> +			}
> >>>  			nr_tags = 0;
> >>> +			active = 0;
> >>>  			cur_hctx = rq->mq_hctx;
> >>>  		}
> >>>  		tags[nr_tags++] = rq->tag;
> >>> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
> >>> +			active++;
> >>
> >> Are there any cases where either none or all of requests have the
> >> flag set, and hence active == nr_tags?
> > 
> > none and BLK_MQ_F_TAG_QUEUE_SHARED, and Shinichiro only observed the
> > issue on two NSs.
> 
> Maybe I wasn't clear enough. What I'm saying is that either all of the
> requests will have RQF_MQ_INFLIGHT set, or none of them. Hence active
> should be either 0, or == nr_tags.

Yeah, that is right since BLK_MQ_F_TAG_QUEUE_SHARED is updated after
queue is frozen. Meantime blk_mq_end_request_batch() is only called
for ending successfully completed requests.

Will do that in V2.

Thanks,
Ming

