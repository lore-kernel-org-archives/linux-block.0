Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97635C65BAF
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791220989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLGBlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:41:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeLGBlM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 20:41:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CDB14E936;
        Fri,  7 Dec 2018 01:41:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 494E551F06;
        Fri,  7 Dec 2018 01:41:12 +0000 (UTC)
Date:   Thu, 6 Dec 2018 20:41:11 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: block: fix direct dispatch issue failure for clones
Message-ID: <20181207014111.GB17427@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 07 Dec 2018 01:41:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06 2018 at  8:13pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/6/18 6:04 PM, jianchao.wang wrote:
> > 
> > 
> > On 12/7/18 6:20 AM, Jens Axboe wrote:
> >> After the direct dispatch corruption fix, we permanently disallow direct
> >> dispatch of non read/write requests. This works fine off the normal IO
> >> path, as they will be retried like any other failed direct dispatch
> >> request. But for the blk_insert_cloned_request() that only DM uses to
> >> bypass the bottom level scheduler, we always first attempt direct
> >> dispatch. For some types of requests, that's now a permanent failure,
> >> and no amount of retrying will make that succeed.
> >>
> >> Don't use direct dispatch off the cloned insert path, always just use
> >> bypass inserts. This still bypasses the bottom level scheduler, which is
> >> what DM wants.
> >>
> >> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>
> >> ---
> >>
> >> diff --git a/block/blk-core.c b/block/blk-core.c
> >> index deb56932f8c4..4c44e6fa0d08 100644
> >> --- a/block/blk-core.c
> >> +++ b/block/blk-core.c
> >> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
> >>  		 * bypass a potential scheduler on the bottom device for
> >>  		 * insert.
> >>  		 */
> >> -		return blk_mq_request_issue_directly(rq);
> >> +		blk_mq_request_bypass_insert(rq, true);
> >> +		return BLK_STS_OK;
> >>  	}
> >>  
> >>  	spin_lock_irqsave(q->queue_lock, flags);
> >>
> > Not sure about this because it will break the merging promotion for request based DM
> > from Ming.
> > 396eaf21ee17c476e8f66249fb1f4a39003d0ab4
> > (blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)
> > 
> > We could use some other way to fix this.
> 
> That really shouldn't matter as this is the cloned insert, merging should
> have been done on the original request.

Reading the header of 396eaf21ee17c476e8f66249fb1f4a39003d0ab4 brings me
back to relatively recent hell.

Thing is, dm-rq was the original justification and consumer of
blk_mq_request_issue_directly -- but Ming's later use of directly issuing
requests has forced fixes that didn't consider the original valid/safe
use of the interface that is now too rigid.  dm-rq needs the
functionality the blk_mq_request_issue_directly interface provides.

Sorry to say we cannot lose the sequential IO performance improvements
that the IO merging feedback loop gives us.
