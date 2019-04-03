Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C578C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FC920882
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDCDby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54971 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfDCDbv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 23:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18E6185363;
        Wed,  3 Apr 2019 03:31:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 800AD1001E76;
        Wed,  3 Apr 2019 03:31:43 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:31:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] block: Fix a race between request queue freezing and
 running queues
Message-ID: <20190403033137.GC9968@ming.t460p>
References: <20190401212014.192753-1-bvanassche@acm.org>
 <20190401212014.192753-3-bvanassche@acm.org>
 <20190402005318.GC21944@ming.t460p>
 <1554219850.118779.137.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554219850.118779.137.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 03 Apr 2019 03:31:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 08:44:10AM -0700, Bart Van Assche wrote:
> On Tue, 2019-04-02 at 08:53 +0800, Ming Lei wrote:
> > On Mon, Apr 01, 2019 at 02:20:12PM -0700, Bart Van Assche wrote:
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 3ff3d7b49969..652d0c6d5945 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1499,12 +1499,20 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
> > >  	struct blk_mq_hw_ctx *hctx;
> > >  	int i;
> > >  
> > > +	/*
> > > +	 * Do not run any hardware queues if the queue is frozen or if a
> > > +	 * concurrent blk_cleanup_queue() call is removing any data
> > > +	 * structures used by this function.
> > > +	 */
> > > +	if (!percpu_ref_tryget(&q->q_usage_counter))
> > > +		return;
> > >  	queue_for_each_hw_ctx(q, hctx, i) {
> > >  		if (blk_mq_hctx_stopped(hctx))
> > >  			continue;
> > >  
> > >  		blk_mq_run_hw_queue(hctx, async);
> > >  	}
> > > +	percpu_ref_put(&q->q_usage_counter);
> > >  }
> > >  EXPORT_SYMBOL(blk_mq_run_hw_queues);
> > 
> > I don't see it is necessary to add percpu_ref_tryget()/percpu_ref_put()
> > in the fast path if we simply release all hctx resource in hctx's
> > release handler by the following patch:
> > 
> > https://lore.kernel.org/linux-block/20190401044247.29881-2-ming.lei@redhat.com/T/#u
> > 
> > Even we can kill the percpu_ref_tryget_live()/percpu_ref_put() in
> > scsi_end_request().
> 
> The above approach has the advantages of being easy to review and to maintain.
> 
> Patch "[PATCH V2 1/3] blk-mq: free hw queue's resource in hctx's release handler"
> makes the block layer more complicated because it introduces a new state for
> hardware queues: block driver cleanup has happened (set->ops->exit_hctx(...)) but

We are done with driver after blk_freeze_queue() and blk_sync_queue(),
then call .exit_hctx() to say good bye with driver, I don't see it
causes any issue.

> the hardware queues are still in use by the block layer core.

Block layer has the correct in-memory state to work well, and no
driver activity is involved too.

Thanks,
Ming
