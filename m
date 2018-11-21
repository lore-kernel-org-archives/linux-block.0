Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D687C43610
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 01:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0863B21479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 01:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0863B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeKUL4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUL4u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 06:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A2B658E2C;
        Wed, 21 Nov 2018 01:24:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1835885A;
        Wed, 21 Nov 2018 01:24:38 +0000 (UTC)
Date:   Wed, 21 Nov 2018 09:24:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Message-ID: <20181121012433.GD31748@ming.t460p>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 21 Nov 2018 01:24:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 11:58:09PM +0000, Damien Le Moal wrote:
> On 2018/11/21 2:31, Jens Axboe wrote:
> > I think the below should fix it, we haven't necessarily setup an
> > ioc if we're just doing as passthrough request.
> > 
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 13b8dc332541..f096d8989773 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
> >  void blk_mq_sched_assign_ioc(struct request *rq)
> >  {
> >  	struct request_queue *q = rq->q;
> > -	struct io_context *ioc = current->io_context;
> > +	struct io_context *ioc;
> >  	struct io_cq *icq;
> >  
> > +	/*
> > +	 * May not have an IO context if it's a passthrough request
> > +	 */
> > +	ioc = current->io_context;
> > +	if (!ioc)
> > +		return;
> > +
> >  	spin_lock_irq(&q->queue_lock);
> >  	icq = ioc_lookup_icq(ioc, q);
> >  	spin_unlock_irq(&q->queue_lock);
> 
> This seems reasonable to me, but I wonder why this problem was not triggering
> before. The previous code getting the ioc with the rq_ioc(bio) call was
> essentially the same and there was no "if (!ioc) return;" in
> blk_mq_sched_assign_ioc() before the patch.
> Any idea why this is popping up now ?
> 
> Ming,
> 
> Is this a new test your are running ? If this same problem triggers on stable
> kernels, Jens patch needs to go to stable too.

No, I run daily block related tests on block for-next, and this issue is
just triggered when your patches landed.

You may find the test script:

https://people.redhat.com/minlei/tests/tools/elv-switch

Thanks,
Ming
