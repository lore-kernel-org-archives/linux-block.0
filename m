Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD64C47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CCA21479
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJGPFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16475 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfJGPFx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 11:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B6703082132;
        Mon,  7 Oct 2019 15:05:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B815C1D4;
        Mon,  7 Oct 2019 15:05:39 +0000 (UTC)
Date:   Mon, 7 Oct 2019 23:05:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 RESEND 4/5] blk-mq: re-submit IO in case that hctx is
 dead
Message-ID: <20191007150534.GC1668@ming.t460p>
References: <20191006024516.19996-1-ming.lei@redhat.com>
 <20191006024516.19996-5-ming.lei@redhat.com>
 <b49232fb-83fb-b037-c259-9217e3c9f17b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49232fb-83fb-b037-c259-9217e3c9f17b@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 07 Oct 2019 15:05:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 07, 2019 at 08:27:38AM +0200, Hannes Reinecke wrote:
> On 10/6/19 4:45 AM, Ming Lei wrote:
> > When all CPUs in one hctx are offline, we shouldn't run this hw queue
> > for completing request any more.
> > 
> > So steal bios from the request, and resubmit them, and finally free
> > the request in blk_mq_hctx_notify_dead().
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 41 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d991c122abf2..0b35fdbd1f17 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2280,10 +2280,30 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> >  	return 0;
> >  }
> >  
> > +static void blk_mq_resubmit_io(struct request *rq)
> > +{
> > +	struct bio_list list;
> > +	struct bio *bio;
> > +
> > +	bio_list_init(&list);
> > +	blk_steal_bios(&list, rq);
> > +
> > +	while (true) {
> > +		bio = bio_list_pop(&list);
> > +		if (!bio)
> > +			break;
> > +
> > +		generic_make_request(bio);
> > +	}
> > +
> > +	blk_mq_cleanup_rq(rq);
> > +	blk_mq_end_request(rq, 0);
> > +}
> > +
> Hmm. Not sure if this is a good idea.
> Shouldn't we call 'blk_mq_end_request()' before calling
> generic_make_request()?
> otherwise the cloned request might be completed before original one,
> which looks a bit dodgy to me; and might lead to quite a recursion if we
> have several dead cpus to content with ...

Good catch, we should have freed the old empty request before calling
generic_make_request(), will fix it in V3.


Thanks,
Ming
