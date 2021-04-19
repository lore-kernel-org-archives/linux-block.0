Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC9C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 02:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C017C60FF3
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 02:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhDSCWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhDSCWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 22:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618798907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkWRu5hLnZo5fr3qFvYuVX/r+7arjgAsCKIuVdtVwyc=;
        b=iAu/ZhgHe0cOh8eg5dE/GYvEt+eSGjwyBXaFnZBfXoHx97hD+eYHlOCgZaXQ9xkKzbsvFW
        +SwYJhLCdDQhmTkVFTw/v7UWZ6do9HRSsEQwRyK1yAUc7FYtlQ9dhJBPWO0Sgx8hISKTjP
        RpiIvMI1a2Qkq91C/yYsNBRGOezNofk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ikhi7jRLM1yCIaJYQuslQA-1; Sun, 18 Apr 2021 22:21:45 -0400
X-MC-Unique: ikhi7jRLM1yCIaJYQuslQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D37D107ACC7;
        Mon, 19 Apr 2021 02:21:44 +0000 (UTC)
Received: from T590 (ovpn-12-222.pek2.redhat.com [10.72.12.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72E50138FB;
        Mon, 19 Apr 2021 02:21:28 +0000 (UTC)
Date:   Mon, 19 Apr 2021 10:21:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     snitzer@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] block: introduce QUEUE_FLAG_POLL_CAP flag
Message-ID: <YHzpJsOYJL/AGC7k@T590>
References: <20210401021927.343727-12-ming.lei@redhat.com>
 <20210416080037.26335-1-jefflexu@linux.alibaba.com>
 <YHlTtVtTEBpxa8Gh@T590>
 <1fb6e15e-fb4d-a2bf-9f65-2ae2aa15a8a2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb6e15e-fb4d-a2bf-9f65-2ae2aa15a8a2@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 17, 2021 at 10:06:53PM +0800, JeffleXu wrote:
> 
> 
> On 4/16/21 5:07 PM, Ming Lei wrote:
> > On Fri, Apr 16, 2021 at 04:00:37PM +0800, Jeffle Xu wrote:
> >> Hi,
> >> How about this patch to remove the extra poll_capable() method?
> >>
> >> And the following 'dm: support IO polling for bio-based dm device' needs
> >> following change.
> >>
> >> ```
> >> +       /*
> >> +        * Check for request-based device is remained to
> >> +        * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
> >> +        * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
> >> +        * devices supporting polling.
> >> +        */
> >> +       if (__table_type_bio_based(t->type)) {
> >> +               if (dm_table_supports_poll(t)) {
> >> +                       blk_queue_flag_set(QUEUE_FLAG_POLL_CAP, q);
> >> +                       blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> >> +               }
> >> +               else {
> >> +                       blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> >> +                       blk_queue_flag_clear(QUEUE_FLAG_POLL_CAP, q);
> >> +               }
> >> +       }
> >> ```
> > 
> > Frankly speaking, I don't see any value of using QUEUE_FLAG_POLL_CAP for
> > DM, and the result is basically subset of treating DM as always being capable
> > of polling.
> > 
> > Also underlying queue change(either limits or flag) won't be propagated
> > to DM/MD automatically. Strictly speaking it doesn't matter if all underlying
> > queues are capable of supporting polling at the exact time of 'write sysfs/poll',
> > cause any of them may change in future.
> > 
> > So why not start with the simplest approach(always capable of polling)
> > which does meet normal bio based polling requirement?
> > 
> 
> I find one scenario where this issue may matter. Consider the scenario
> where HIPRI bios are submitted to DM device though **all** underlying
> devices has been disabled for polling. In this case, a **valid** cookie
> (pid of current submitting process) is still returned. Then if @spin of
> the following blk_poll() is true, blk_poll() will get stuck in dead loop
> because blk_mq_poll() always returns 0, since previously submitted bios
> are all enqueued into IRQ hw queue.
> 
> Maybe you need to re-remove the bio from the poll context if the
> returned cookie is BLK_QC_T_NONE?

It won't be one issue, see blk_bio_poll_preprocess() which is called
from submit_bio_checks(), so any bio's HIPRI will be cleared if the
queue doesn't support POLL, that code does cover underlying bios.

> 
> 
> Something like:
> 
> -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> +static blk_qc_t __submit_bio_noacct_ctx(struct bio *bio, struct
> io_context *ioc)
>  {
>  	struct bio_list bio_list_on_stack[2];
>  	blk_qc_t ret = BLK_QC_T_NONE;
> @@ -1047,7 +1163,15 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  		bio_list_on_stack[1] = bio_list_on_stack[0];
>  		bio_list_init(&bio_list_on_stack[0]);
> 
> 		if (ioc && queue_is_mq(q) && (bio->bi_opf & REQ_HIPRI)) {

REQ_HIPRI won't be set for underlying bios which queue doesn't support
poll, so this branch won't be reached. And the submission queue will
be empty, and blk_poll() for DM/MD(bio based queue) checks nothing, but
the polling won't be stopped until the iocb is completed. And this
handling is actually same with current polling on IRQ based queue.

> 			bool queued = blk_bio_poll_prep_submit(ioc, bio);
> 
> 			ret = __submit_bio(bio);
> +			if (queued && !blk_qc_t_valid(ret))
> 				/* TODO:remove bio from poll_context */
> 				
> 				bio_set_private_data(bio, ret);
> 		} else {
> 			ret = __submit_bio(bio);
> 		}
> 
> 
> Then if you'd like fix this in this way, the returned value of
> .submit_bio() of DM/MD also needs to return BLK_QC_T_NONE now. Currently
> .submit_bio() of DM actually returns the cookie of the last split bio
> (to underlying mq deivice).

I am a bit confused, this patch requires .submit_bio() of DM/MD(bio
based queue) to return either 0 or pid of the submission task.


Thanks,
Ming

