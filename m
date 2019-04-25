Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B899FC10F11
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D31208E4
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 00:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfDYAxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 20:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfDYAxt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 20:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1845D314E275;
        Thu, 25 Apr 2019 00:53:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3463A165D3;
        Thu, 25 Apr 2019 00:53:38 +0000 (UTC)
Date:   Thu, 25 Apr 2019 08:53:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190425005332.GB22636@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com>
 <20190424161834.GA23854@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424161834.GA23854@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 25 Apr 2019 00:53:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 06:18:34PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 07:02:13PM +0800, Ming Lei wrote:
> >  		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
> >  			if (this_hctx) {
> >  				trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +				percpu_ref_get(&this_q->q_usage_counter);
> >  				blk_mq_sched_insert_requests(this_hctx, this_ctx,
> >  								&rq_list,
> >  								from_schedule);
> > +				percpu_ref_put(&this_q->q_usage_counter);
> >  			}
> >  
> >  			this_q = rq->q;
> > @@ -1757,8 +1760,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >  	 */
> >  	if (this_hctx) {
> >  		trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +		percpu_ref_get(&this_q->q_usage_counter);
> >  		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
> >  						from_schedule);
> > +		percpu_ref_put(&this_q->q_usage_counter);
> 
> Why don't we push this into blk_mq_sched_insert_requests?  Yes, it
> would need a request_queue argument, but that still seems saner
> than duplicating it in both callers.

It isn't in other callers of blk_mq_sched_insert_requests(), it is just
needed in some corner case like flush plug context.

For other callers of blk_mq_sched_insert_requests(), it is guaranteed
that request queue's ref is held.

Thanks,
Ming
