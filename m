Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9EC433E3
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22ACC20855
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHMPly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:41:54 -0400
Received: from verein.lst.de ([213.95.11.211]:46782 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgHMPlx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 11:41:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1CC268AFE; Thu, 13 Aug 2020 17:41:51 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:41:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 1/3] block: respect queue limit of max discard
 segment
Message-ID: <20200813154151.GA14200@lst.de>
References: <20200811234420.2297137-1-ming.lei@redhat.com> <20200811234420.2297137-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811234420.2297137-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 07:44:18AM +0800, Ming Lei wrote:
> When queue_max_discard_segments(q) is 1, blk_discard_mergable() will
> return false for discard request, then normal request merge is applied.
> However, only queue_max_segments() is checked, so max discard segment
> limit isn't respected.
> 
> Check max discard segment limit in the request merge code for fixing
> the issue.
> 
> Discard request failure of virtio_blk is fixed.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Fixes: 69840466086d ("block: fix the DISCARD request merge")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/blk-merge.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 5196dc145270..d18fb88ca8bd 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -533,10 +533,16 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(__blk_rq_map_sg);
>  
> +static inline unsigned int blk_rq_get_max_segments(struct request *rq)
> +{
> +	return req_op(rq) == REQ_OP_DISCARD ?
> +		queue_max_discard_segments(rq->q) : queue_max_segments(rq->q);

I'd go for a good old if statement here..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
