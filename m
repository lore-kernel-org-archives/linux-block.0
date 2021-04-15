Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF2FC43461
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD811611F1
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 13:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhDONJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 09:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233213AbhDONJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 09:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618492151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4BSGNPrb+Ur/0ielLLQl6KwM595K6/ayB7X/f5fp3gA=;
        b=WRNj997N7v0M/RkwCtu5HeV8O2vdhlv6xOMMNyBPQDGD6IB12vMf56lNBRHJUNdJ/BFdCR
        hXl9boqWo7E/VMmRT9BqDm53Vu2K2gw+tDEYGq58DE1tm7NndVMlEbbMFlUzli+k++9Y85
        qgO2qy8QpzA24M+CMSkT+eAoXcUhAws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Hqy-LLzXP9WNsB_Z4XFd3A-1; Thu, 15 Apr 2021 09:09:10 -0400
X-MC-Unique: Hqy-LLzXP9WNsB_Z4XFd3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E415A801814;
        Thu, 15 Apr 2021 13:09:08 +0000 (UTC)
Received: from T590 (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A68F16D36;
        Thu, 15 Apr 2021 13:08:56 +0000 (UTC)
Date:   Thu, 15 Apr 2021 21:08:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 11/12] block: add poll_capable method to support
 bio-based IO polling
Message-ID: <YHg65CMSt6KEHvQp@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-12-ming.lei@redhat.com>
 <20210412093856.GA978201@infradead.org>
 <a6d46979-810e-bc53-bc19-8acd449e3718@linux.alibaba.com>
 <YHbQ/rZUPoTFUMDs@T590>
 <5f30059d-6650-8268-b681-d8567ac1c509@linux.alibaba.com>
 <YHfumsTKHuvPGp47@T590>
 <0ceb3060-bce4-c39d-26cf-8c715ebbfd51@linux.alibaba.com>
 <YHgQNL4byNCEmh3/@T590>
 <5f2542e4-1c36-71e8-5c72-a85b23c98b72@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2542e4-1c36-71e8-5c72-a85b23c98b72@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 15, 2021 at 07:21:52PM +0800, JeffleXu wrote:
> 
> 
> On 4/15/21 6:06 PM, Ming Lei wrote:
> > On Thu, Apr 15, 2021 at 05:21:56PM +0800, JeffleXu wrote:
> >>
> >>
> >> On 4/15/21 3:43 PM, Ming Lei wrote:
> >>> On Thu, Apr 15, 2021 at 09:34:36AM +0800, JeffleXu wrote:
> >>>>
> >>>>
> >>>> On 4/14/21 7:24 PM, Ming Lei wrote:
> >>>>> On Wed, Apr 14, 2021 at 04:38:25PM +0800, JeffleXu wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 4/12/21 5:38 PM, Christoph Hellwig wrote:
> >>>>>>> On Thu, Apr 01, 2021 at 10:19:26AM +0800, Ming Lei wrote:
> >>>>>>>> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>>>>>>>
> >>>>>>>> This method can be used to check if bio-based device supports IO polling
> >>>>>>>> or not. For mq devices, checking for hw queue in polling mode is
> >>>>>>>> adequate, while the sanity check shall be implementation specific for
> >>>>>>>> bio-based devices. For example, dm device needs to check if all
> >>>>>>>> underlying devices are capable of IO polling.
> >>>>>>>>
> >>>>>>>> Though bio-based device may have done the sanity check during the
> >>>>>>>> device initialization phase, cacheing the result of this sanity check
> >>>>>>>> (such as by cacheing in the queue_flags) may not work. Because for dm
> >>>>>>>> devices, users could change the state of the underlying devices through
> >>>>>>>> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
> >>>>>>>> the cached result of the very beginning sanity check could be
> >>>>>>>> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
> >>>>>>>> is to be modified.
> >>>>>>>
> >>>>>>> I really don't think thi should be a method, and I really do dislike
> >>>>>>> how we have all this "if (is_mq)" junk.  Why can't we have a flag on
> >>>>>>> the gendisk that signals if the device can support polling that
> >>>>>>> is autoamtically set for blk-mq and as-needed by bio based drivers?
> >>>>>>
> >>>>>> That would consume one more bit of queue->queue_flags.
> >>>>>>
> >>>>>> Besides, DM/MD is somehow special here that when one of the underlying
> >>>>>> devices is disabled polling through '/sys/block/<dev>/io_poll',
> >>>>>> currently there's no mechanism notifying the above MD/DM to clear the
> >>>>>> previously set queue_flags. Thus the outdated queue_flags still
> >>>>>> indicates this DM/MD is capable of polling, while in fact one of the
> >>>>>> underlying device has been disabled for polling.
> >>>>>
> >>>>> Right, just like there isn't queue limit progagation.
> >>>>>
> >>>>> Another blocker could be that bio based queue doesn't support queue
> >>>>> freezing.
> >>>>
> >>>> Do you mean the queue freezing is called in the following code snippet?
> >>>>
> >>>> ```
> >>>> static ssize_t queue_poll_store(struct request_queue *q, const char
> >>>> *page, size_t count)
> >>>> {
> >>>> 	...
> >>>> 	if (poll_on) {
> >>>> 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> >>>> 	} else {
> >>>> 		blk_mq_freeze_queue(q);
> >>>> 		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> >>>> 		blk_mq_unfreeze_queue(q);
> >>>> 	}
> >>>> ```
> >>>
> >>> Yes, if it is a bio based queue. Or bio queued queue(DM, MD or others) may
> >>> use freeze_queue to do similar thing.
> >>>
> >>>>
> >>>> And I can't understand how bio-based queue doesn't support queue freezing.
> >>>>
> >>>> ```
> >>>> submit_bio_noacct
> >>>> 	__submit_bio_noacct
> >>>> 		bio_queue_enter
> >>>> ```
> >>>>
> >>>> Every time submitting a bio, bio_queue_enter() will be called, and once
> >>>> the queue has been frozen, bio_queue_enter() will wait there until the
> >>>> queue is unfrozen.
> >>>
> >>> Not like blk-mq, the refcount is just grabbed during submission for bio based
> >>> queue. 
> >>
> >> Could you please explain it more detailed ....
> > 
> > Please see __submit_bio(), in which the queue ref is dropped.
> > 
> >>
> >>
> >> I will research a bit and see if we can extend freeze queue for
> >>> covering bio based queue. One trouble is that bio is ended before
> >>> freeing request.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Mike had ever suggested that we can trust the queue_flag, and clear the
> >>>>>> outdated queue_flags when later the IO submission or polling routine
> >>>>>> finally finds that the device is not capable of polling. Currently
> >>>>>> submit_bio_checks() will silently clear the REQ_HIPRI flag and still
> >>>>>> submit the bio when the device is actually not capable of polling. To
> >>>>>> fix the issue, could we break the submission and return an error code in
> >>>>>> submit_bio_checks() if the device is not capable of polling when
> >>>>>> submitting HIPRI bio?
> >>>>>
> >>>>> I think we may just leave it alone, if underlying queue becomes not pollable,
> >>>>> the bio still can be submitted & completed via IRQ, just not efficient enough.
> >>>>
> >>>> Yes it still works. I agree if there's no better solution...
> >>>>
> >>>> And what about the issue Christoph originally concerned? Do we use one
> >>>> more flag bit indicating if the queue capable of polling, or the
> >>>> poll_capable() method way?
> >>>
> >>> Just wondering why we can't use QUEUE_FLAG_POLL simply? If user wants to
> >>> enable it, let's do it for them. And bio driver can start with default poll
> >>> state by checking underlying queues.
> >>>
> >>
> >> Consider the following scenario: QUEUE_FLAG_POLL is set after
> >> initialization, indicating the device capable of polling; then polling
> >> is turned off by '/sys/block/<dev>/io_poll', thus QUEUE_FLAG_POLL is
> >> cleared.
> > 
> > If the flag is cleared, the bio will be submitted to irq queue, what is
> > the problem?
> > 
> 
> The IO path has no problem. It is the control path. If you want to turn

Can you explain a bit what the control path is?

> on polling then, you have to check if the device capable of polling,
> while QUEUE_FLAG_POLL has been cleared in this case. IOW you can't rely
> on QUEUE_FLAG_POLL to see if the device has the **ability** of polling.
> QUEUE_FLAG_POLL flag only indicates if polling is turned on or off
> currently.

For bio based driver, I'd suggest to start with do polling simply if
QUEUE_FLAG_POLL is set in bio request queue flag. The flag can be
enabled/disabled during initialization, or via sysfs. That said we
can start with always thinking the bio queue is capable of io polling.


Thanks,
Ming

