Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF7C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGUFDh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:03:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594577A7F
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:03:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5EB0B68AFE; Thu, 21 Jul 2022 07:03:32 +0200 (CEST)
Date:   Thu, 21 Jul 2022 07:03:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
Message-ID: <20220721050332.GA19443@lst.de>
References: <20220720130541.1323531-1-hch@lst.de> <YtiV148hTcpsjTZ+@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtiV148hTcpsjTZ+@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:55:03AM +0800, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d716b7f3763f3..70177ee74295b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
> >  
> >  	disk = __alloc_disk_node(q, set->numa_node, lkclass);
> >  	if (!disk) {
> > -		blk_put_queue(q);
> > +		blk_mq_destroy_queue(q);
> >  		return ERR_PTR(-ENOMEM);
>  
> The same change is needed in case of blk_mq_init_allocated_queue() failure too.

I don't think so.  blk_mq_init_allocated_queue only calls
blk_mq_add_queue_tag_set at the very end, after any failure point,
and the last failure point is blk_mq_realloc_hw_ctxs not mapping
any queues.  So what would we clean up when
blk_mq_init_allocated_queue fails?

