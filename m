Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2382C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A5E206E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfD1NQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfD1NQI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 09:16:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C64C307D910;
        Sun, 28 Apr 2019 13:16:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6616045A8;
        Sun, 28 Apr 2019 13:15:59 +0000 (UTC)
Date:   Sun, 28 Apr 2019 21:15:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 5/7] blk-mq: always free hctx after request queue is
 freed
Message-ID: <20190428131553.GA30723@ming.t460p>
References: <20190428081408.27331-1-ming.lei@redhat.com>
 <20190428081408.27331-6-ming.lei@redhat.com>
 <20190428121426.GD4281@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428121426.GD4281@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 28 Apr 2019 13:16:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 28, 2019 at 02:14:26PM +0200, Christoph Hellwig wrote:
> On Sun, Apr 28, 2019 at 04:14:06PM +0800, Ming Lei wrote:
> > In normal queue cleanup path, hctx is released after request queue
> > is freed, see blk_mq_release().
> > 
> > However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
> > of hw queues shrinking. This way is easy to cause use-after-free,
> > because: one implicit rule is that it is safe to call almost all block
> > layer APIs if the request queue is alive; and one hctx may be retrieved
> > by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
> > finally use-after-free is triggered.
> > 
> > Fixes this issue by always freeing hctx after releasing request queue.
> > If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
> > a per-queue list to hold them, then try to resuse these hctxs if numa
> > node is matched.
> 
> This seems a little odd.  Wouldn't it be much simpler to just keep
> the hctx where it is, that is leave the queue_hw_ctx[] pointer in tact,
> but have a flag marking it dead?

There are several issues with that solution:

1) q->nr_hw_queues becomes not same with number of the real active hw queues

2) if one hctx is only marked as dead and not freed, after several times of
updating nr_hw_queues, more and more hctx instances will be wasted.

3) q->queue_hw_ctx[] has to be re-allocated when nr_hw_queues is increased.

So I think this patch should be simpler, either in concept or implementation.


Thanks,
Ming
