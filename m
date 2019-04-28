Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB5AC43219
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AE120843
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfD1MOn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:14:43 -0400
Received: from verein.lst.de ([213.95.11.211]:60143 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfD1MOn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 08:14:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5AF8468B05; Sun, 28 Apr 2019 14:14:26 +0200 (CEST)
Date:   Sun, 28 Apr 2019 14:14:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 5/7] blk-mq: always free hctx after request queue is
 freed
Message-ID: <20190428121426.GD4281@lst.de>
References: <20190428081408.27331-1-ming.lei@redhat.com> <20190428081408.27331-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428081408.27331-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 28, 2019 at 04:14:06PM +0800, Ming Lei wrote:
> In normal queue cleanup path, hctx is released after request queue
> is freed, see blk_mq_release().
> 
> However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
> of hw queues shrinking. This way is easy to cause use-after-free,
> because: one implicit rule is that it is safe to call almost all block
> layer APIs if the request queue is alive; and one hctx may be retrieved
> by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
> finally use-after-free is triggered.
> 
> Fixes this issue by always freeing hctx after releasing request queue.
> If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
> a per-queue list to hold them, then try to resuse these hctxs if numa
> node is matched.

This seems a little odd.  Wouldn't it be much simpler to just keep
the hctx where it is, that is leave the queue_hw_ctx[] pointer in tact,
but have a flag marking it dead?
