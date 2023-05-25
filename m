Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18663C7EE2E
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 08:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjEYIZ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjEYIZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 04:25:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339EE198
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 01:25:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0C1468B05; Thu, 25 May 2023 10:25:47 +0200 (CEST)
Date:   Thu, 25 May 2023 10:25:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O
 scheduler
Message-ID: <20230525082547.GA23344@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-3-bvanassche@acm.org> <20230523071835.GB8758@lst.de> <639fa0ac-e7b9-2ba7-3d68-3fe1a501e779@acm.org> <20230524061300.GD19611@lst.de> <3e4dc15a-1117-1122-1d9d-746aef55ef95@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e4dc15a-1117-1122-1d9d-746aef55ef95@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 11:22:00AM -0700, Bart Van Assche wrote:
>>>   static inline void blk_mq_sched_requeue_request(struct request *rq)
>>>   {
>>> -	if (rq->rq_flags & RQF_USE_SCHED) {
>>> -		struct request_queue *q = rq->q;
>>> -		struct elevator_queue *e = q->elevator;
>>> -
>>> -		if (e->type->ops.requeue_request)
>>> -			e->type->ops.requeue_request(rq);
>>> -	}
>>> +	if (rq->rq_flags & RQF_USE_SCHED)
>>> +		rq->rq_flags |= RQF_REQUEUED;
>>>   }
>>
>> I'd drop this helper function if we go down this way.  But maybe
>> we might just want to keep the method.
>
> My understanding is that every .requeue_request() call is followed by a 
> .insert_requests() call and hence that we don't need the .requeue_request() 
> method anymore if the RQF_REQUEUED flag would be introduced?

Yes, but at the same time RQF_REQUEUED no creates global state instead
of just in a callchain.  That's why originally suggest a flag to
->insert_requests instead of leaving state on every request.

>
> Thanks,
>
> Bart.
---end quoted text---
