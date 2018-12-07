Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51512C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD3220989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD3220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGB6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:58:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGB6c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 20:58:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9407AC04AC54;
        Fri,  7 Dec 2018 01:58:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F145C634;
        Fri,  7 Dec 2018 01:58:31 +0000 (UTC)
Date:   Thu, 6 Dec 2018 20:58:30 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: block: fix direct dispatch issue failure for clones
Message-ID: <20181207015830.GC17427@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
 <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
 <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Dec 2018 01:58:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06 2018 at  8:34pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/6/18 6:22 PM, jianchao.wang wrote:
> > 
> > 
> > On 12/7/18 9:13 AM, Jens Axboe wrote:
> >> On 12/6/18 6:04 PM, jianchao.wang wrote:
> >>>
> >>>
> >>> On 12/7/18 6:20 AM, Jens Axboe wrote:
> >>>> After the direct dispatch corruption fix, we permanently disallow direct
> >>>> dispatch of non read/write requests. This works fine off the normal IO
> >>>> path, as they will be retried like any other failed direct dispatch
> >>>> request. But for the blk_insert_cloned_request() that only DM uses to
> >>>> bypass the bottom level scheduler, we always first attempt direct
> >>>> dispatch. For some types of requests, that's now a permanent failure,
> >>>> and no amount of retrying will make that succeed.
> >>>>
> >>>> Don't use direct dispatch off the cloned insert path, always just use
> >>>> bypass inserts. This still bypasses the bottom level scheduler, which is
> >>>> what DM wants.
> >>>>
> >>>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>
> >>>> ---
> >>>>
> >>>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>>> index deb56932f8c4..4c44e6fa0d08 100644
> >>>> --- a/block/blk-core.c
> >>>> +++ b/block/blk-core.c
> >>>> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
> >>>>  		 * bypass a potential scheduler on the bottom device for
> >>>>  		 * insert.
> >>>>  		 */
> >>>> -		return blk_mq_request_issue_directly(rq);
> >>>> +		blk_mq_request_bypass_insert(rq, true);
> >>>> +		return BLK_STS_OK;
> >>>>  	}
> >>>>  
> >>>>  	spin_lock_irqsave(q->queue_lock, flags);
> >>>>
> >>> Not sure about this because it will break the merging promotion for request based DM
> >>> from Ming.
> >>> 396eaf21ee17c476e8f66249fb1f4a39003d0ab4
> >>> (blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)
> >>>
> >>> We could use some other way to fix this.
> >>
> >> That really shouldn't matter as this is the cloned insert, merging should
> >> have been done on the original request.
> >>
> >>
> > Just quote some comments from the patch.
> > 
> > "
> >                        But dm-rq currently can't get the underlying queue's
> >     dispatch feedback at all.  Without knowing whether a request was issued
> >     or not (e.g. due to underlying queue being busy) the dm-rq elevator will
> >     not be able to provide effective IO merging (as a side-effect of dm-rq
> >     currently blindly destaging a request from its elevator only to requeue
> >     it after a delay, which kills any opportunity for merging).  This
> >     obviously causes very bad sequential IO performance.
> >     ...
> >     With this, request-based DM's blk-mq sequential IO performance is vastly
> >     improved (as much as 3X in mpath/virtio-scsi testing)
> > "
> > 
> > Using blk_mq_request_bypass_insert to replace the blk_mq_request_issue_directly
> > could be a fast method to fix the current issue. Maybe we could get the merging
> > promotion back after some time.
> 
> This really sucks, mostly because DM wants to have it both ways - not use
> the bottom level IO scheduler, but still actually use it if it makes sense.

Well no, that isn't what DM is doing.  DM does have an upper layer
scheduler that would like to be afforded the same capabilities that any
request-based driver is given.  Yes that comes with plumbing in safe
passage for upper layer requests dispatched from a stacked blk-mq IO
scheduler.
 
> There is another way to fix this - still do the direct dispatch, but have
> dm track if it failed and do bypass insert in that case. I didn't want do
> to that since it's more involved, but it's doable.
> 
> Let me cook that up and test it... Don't like it, though.

Not following how DM can track if issuing the request worked if it is
always told it worked with BLK_STS_OK.  We care about feedback when the
request is actually issued because of the elaborate way blk-mq elevators
work.  DM is forced to worry about all these details, as covered some in
the header for commit 396eaf21ee17c476e8f66249fb1f4a39003d0ab4, it is
trying to have its cake and eat it too.  It just wants IO scheduling to
work for request-based DM devices.  That's it.

Mike
