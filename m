Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B45C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD92206DF
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfC1AvJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1AvJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 20:51:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1E5CC4EAC;
        Thu, 28 Mar 2019 00:51:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E4791001E6E;
        Thu, 28 Mar 2019 00:51:02 +0000 (UTC)
Date:   Thu, 28 Mar 2019 08:50:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190328005056.GA19708@ming.t460p>
References: <20190327085114.12111-1-ming.lei@redhat.com>
 <20190327085114.12111-2-ming.lei@redhat.com>
 <20190327133244.GA8448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327133244.GA8448@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 28 Mar 2019 00:51:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 07:32:45AM -0600, Keith Busch wrote:
> On Wed, Mar 27, 2019 at 04:51:13PM +0800, Ming Lei wrote:
> > @@ -594,8 +594,11 @@ static void __blk_mq_complete_request(struct request *rq)
> >  	/*
> >  	 * For a polled request, always complete locallly, it's pointless
> >  	 * to redirect the completion.
> > +	 *
> > +	 * If driver requires to complete the request synchronously,
> > +	 * complete it locally, and it is usually done in error handler.
> >  	 */
> > -	if ((rq->cmd_flags & REQ_HIPRI) ||
> > +	if ((rq->cmd_flags & REQ_HIPRI) || sync ||
> >  	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
> >  		q->mq_ops->complete(rq);
> >  		return;
> 
> I think this is fine and agree this is fixing a problem, but just
> considering an alternative: would it be okay to just temporarily clear
> QUEUE_FLAG_SAME_COMP in the necessary error handling that wants a sync
> completion so that we're not introducing an additional parameter?

But the flag can be changed by sysfs too.

Thanks,
Ming
