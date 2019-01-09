Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26433C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064620883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfAIMMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:12:52 -0500
Received: from verein.lst.de ([213.95.11.211]:41159 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfAIMMw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 07:12:52 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4C45E67358; Wed,  9 Jan 2019 13:12:50 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:12:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 10/16] io_uring: split kiocb init from allocation
Message-ID: <20190109121250.GC13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-11-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-11-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 09:56:39AM -0700, Jens Axboe wrote:
> In preparation from having pre-allocated requests, that we then just
> need to initialize before use.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/io_uring.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index afbaebb63012..11d045f0f799 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
>  	return &ring->events[tail & ctx->cq_ring.ring_mask];
>  }
>  
> +static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
> +{
> +	percpu_ref_get(&ctx->refs);
> +	req->ki_ctx = ctx;
> +	INIT_LIST_HEAD(&req->ki_list);
> +	req->ki_flags = 0;

We still only have a single caller of this in the final tree, and
I don't think this function helps.  So I'd just drop the patch.
