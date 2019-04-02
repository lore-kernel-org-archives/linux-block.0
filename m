Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67520C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 00:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BE32084C
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 00:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDBAi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDBAi6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 20:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 488BD308339B;
        Tue,  2 Apr 2019 00:38:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 472C2607AA;
        Tue,  2 Apr 2019 00:38:47 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:38:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 2/3] block: don't drain in-progress dispatch in
 blk_cleanup_queue()
Message-ID: <20190402003842.GA21944@ming.t460p>
References: <20190401044247.29881-1-ming.lei@redhat.com>
 <20190401044247.29881-3-ming.lei@redhat.com>
 <1554131699.118779.119.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554131699.118779.119.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Apr 2019 00:38:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 08:14:59AM -0700, Bart Van Assche wrote:
> On Mon, 2019-04-01 at 12:42 +0800, Ming Lei wrote:
> > Now freeing hw queue resource is moved to hctx's release handler,
> > we don't need to worry about the race between blk_cleanup_queue and
> > run queue any more.
> > 
> > So don't drain in-progress dispatch in blk_cleanup_queue().
> > 
> > This is basically revert of c2856ae2f315 ("blk-mq: quiesce queue before
> > freeing queue").
> > 
> > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org,
> > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > Cc: jianchao wang <jianchao.w.wang@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index b3bbf8a5110d..491dc0295778 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -347,18 +347,6 @@ void blk_cleanup_queue(struct request_queue *q)
> >  
> >         blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
> >  
> > -       /*
> > -        * make sure all in-progress dispatch are completed because
> > -        * blk_freeze_queue() can only complete all requests, and
> > -        * dispatch may still be in-progress since we dispatch requests
> > -        * from more than one contexts.
> > -        *
> > -        * We rely on driver to deal with the race in case that queue
> > -        * initialization isn't done.
> > -        */
> > -       if (queue_is_mq(q) && blk_queue_init_done(q))
> > -               blk_mq_quiesce_queue(q);
> > -
> >         /* for synchronous bio-based driver finish in-flight integrity i/o */
> >         blk_flush_integrity();
> 
> Many block drivers clean up resources immediately after blk_cleanup_queue()
> returns. Not waiting for ongoing .queue_rq() calls to finish is wrong because
> it can cause block drivers to destroy resources that are in use by a concurrent
> .queue_rq() call.

blk_freeze_queue() has returned, so there can't be any in-flight IOs and .queue_rq(),
but there might be run queue activities, which do not call into driver.


Thanks,
Ming
