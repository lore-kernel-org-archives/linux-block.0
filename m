Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25CC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653820879
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfA1PCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:02:42 -0500
Received: from verein.lst.de ([213.95.11.211]:40113 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1PCm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:02:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7789C68DCF; Mon, 28 Jan 2019 16:02:40 +0100 (CET)
Date:   Mon, 28 Jan 2019 16:02:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
Message-ID: <20190128150240.GA10110@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123153536.7081-9-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	struct {
>  		spinlock_t		completion_lock;
> +		unsigned		poll_multi_file;

This seems to be used as a bool.

>  
> -static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
> -				  long res, unsigned ev_flags)
> +static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
> +				 long res, unsigned ev_flags)
>  {
>  	struct io_uring_cqe *cqe;
>  
> @@ -206,9 +213,15 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>  		cqe->user_data = ki_user_data;
>  		cqe->res = res;
>  		cqe->flags = ev_flags;
> -		io_commit_cqring(ctx);
>  	} else
>  		ctx->cq_ring->overflow++;
> +}

Maybe we should have created this low-level helper already in the
patch introducing the code?
