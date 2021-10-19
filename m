Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCCCC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0A660FDA
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhJSNhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:37:11 -0400
Received: from verein.lst.de ([213.95.11.211]:38323 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhJSNhL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:37:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A73C568BEB; Tue, 19 Oct 2021 15:34:56 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:34:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 1/2] block: change plugging to use a singly linked list
Message-ID: <20211019133456.GA19216@lst.de>
References: <20211019120834.595160-1-axboe@kernel.dk> <20211019120834.595160-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019120834.595160-2-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 06:08:33AM -0600, Jens Axboe wrote:
> +						!from_schedule);
> +			blk_mq_sched_insert_requests(this_hctx, this_ctx,
> +						&list, from_schedule);
> +			depth = 0;
> +			this_hctx = rq->mq_hctx;
> +			this_ctx = rq->mq_ctx;
> +
>  		}
>  
> +		list_add(&rq->queuelist, &list);

I think this needs to be a list_add_tail to keep the request ordered.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
