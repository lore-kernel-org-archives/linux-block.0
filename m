Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C6C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19F214DE
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB19F214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLFT10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:27:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFT10 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:27:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEF213164665;
        Thu,  6 Dec 2018 19:27:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 133EC10841F4;
        Thu,  6 Dec 2018 19:27:24 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
References: <20181204233729.26776-1-axboe@kernel.dk>
        <20181204233729.26776-9-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Dec 2018 14:27:24 -0500
In-Reply-To: <20181204233729.26776-9-axboe@kernel.dk> (Jens Axboe's message of
        "Tue, 4 Dec 2018 16:37:11 -0700")
Message-ID: <x49y392fobn.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 06 Dec 2018 19:27:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> It's 192 bytes, fairly substantial. Most items don't need to be cleared,
> especially not upfront. Clear the ones we do need to clear, and leave
> the other ones for setup when the iocb is prepared and submitted.

What performance gains do you see from this?

-Jeff

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/aio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index eaceb40e6cf5..522c04864d82 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1009,14 +1009,15 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
>  {
>  	struct aio_kiocb *req;
>  
> -	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
> +	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>  	if (unlikely(!req))
>  		return NULL;
>  
>  	percpu_ref_get(&ctx->reqs);
> +	req->ki_ctx = ctx;
>  	INIT_LIST_HEAD(&req->ki_list);
>  	refcount_set(&req->ki_refcnt, 0);
> -	req->ki_ctx = ctx;
> +	req->ki_eventfd = NULL;
>  	return req;
>  }
>  
> @@ -1730,6 +1731,10 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
>  	if (unlikely(!req->file))
>  		return -EBADF;
>  
> +	req->head = NULL;
> +	req->woken = false;
> +	req->cancelled = false;
> +
>  	apt.pt._qproc = aio_poll_queue_proc;
>  	apt.pt._key = req->events;
>  	apt.iocb = aiocb;
