Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F7961250
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhJRCcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236699AbhJRCcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634524221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ii6iHCtvT88rvAvpzwty6fvd5PmXJkiXwXacRAw1Ink=;
        b=IMeuhHKovBWnOkZQ40Zsn07txiUn09hAoooV2hfW1kx66SK0KV/TOQ1XUad515sHQ4/uVQ
        saZgzCcv9MDWXMG3zXz984Y9Q1gOynGhEkVMk/I0h70AEILbfyehcXsZ9RJ49Vbsg2NcyF
        MMd5Sgnkr2fwbGxut2j5XBKKMLX59zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-9R3NNu_pMGqTmiNqP4fBmg-1; Sun, 17 Oct 2021 22:30:18 -0400
X-MC-Unique: 9R3NNu_pMGqTmiNqP4fBmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92956802575;
        Mon, 18 Oct 2021 02:30:17 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A273A7093A;
        Mon, 18 Oct 2021 02:30:11 +0000 (UTC)
Date:   Mon, 18 Oct 2021 10:30:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't dereference request after flush insertion
Message-ID: <YWzcLuH8VWPOf0ZU@T590>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzSqzsuDF8Fl9jB@T590>
 <17362528-4be4-1407-5a05-cfb0a7524910@kernel.dk>
 <YWzVuDdyTVvED1QA@T590>
 <YWzXzd/LQubjXnrY@T590>
 <65db3ed2-9cc5-b136-0a54-d477acec9a58@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65db3ed2-9cc5-b136-0a54-d477acec9a58@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 17, 2021 at 08:16:25PM -0600, Jens Axboe wrote:
> On 10/17/21 8:11 PM, Ming Lei wrote:
> > On Mon, Oct 18, 2021 at 10:02:32AM +0800, Ming Lei wrote:
> >> On Sun, Oct 17, 2021 at 07:50:24PM -0600, Jens Axboe wrote:
> >>> On 10/17/21 7:49 PM, Ming Lei wrote:
> >>>> On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
> >>>>> We could have a race here, where the request gets freed before we call
> >>>>> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
> >>>>> of the request.
> >>>>>
> >>>>> Grab the hardware context before inserting the flush.
> >>>>>
> >>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>>
> >>>>> ---
> >>>>>
> >>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>>>> index 2197cfbf081f..22b30a89bf3a 100644
> >>>>> --- a/block/blk-mq.c
> >>>>> +++ b/block/blk-mq.c
> >>>>> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
> >>>>>  	}
> >>>>>  
> >>>>>  	if (unlikely(is_flush_fua)) {
> >>>>> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> >>>>>  		/* Bypass scheduler for flush requests */
> >>>>>  		blk_insert_flush(rq);
> >>>>> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
> >>>>> +		blk_mq_run_hw_queue(hctx, true);
> >>>>
> >>>> If the request is freed before running queue, the request queue could
> >>>> be released and the hctx may be freed.
> >>>
> >>> No, we still hold a queue enter ref.
> >>
> >> But that one is released when rq is freed since ac7c5675fa45 ("blk-mq: allow
> >> blk_mq_make_request to consume the q_usage_counter reference"), isn't
> >> it?
> > 
> > With commit ac7c5675fa45, any reference to hctx after queuing request could
> > lead to UAF in the code path of blk_mq_submit_bio(). Maybe we need to grab
> > two ref in queue enter, and release one after the bio is submitted.
> 
> I'd rather audit and see if there are any, because extra get+put isn't
> exactly free.

Only direct issue needn't that, looks others do need grab one extra
ref if the request has to be queued somewhere before dispatch.


Thanks,
Ming

