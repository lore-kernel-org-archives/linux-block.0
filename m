Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C1C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4396214DE
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4396214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFT3q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:29:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFT3q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:29:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EA0F394D58;
        Thu,  6 Dec 2018 19:29:45 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0981179D44;
        Thu,  6 Dec 2018 19:29:44 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 09/26] aio: only use blk plugs for > 2 depth submissions
References: <20181204233729.26776-1-axboe@kernel.dk>
        <20181204233729.26776-10-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Dec 2018 14:29:44 -0500
In-Reply-To: <20181204233729.26776-10-axboe@kernel.dk> (Jens Axboe's message
        of "Tue, 4 Dec 2018 16:37:12 -0700")
Message-ID: <x49tvjqfo7r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Dec 2018 19:29:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Plugging is meant to optimize submission of a string of IOs, if we don't
> have more than 2 being submitted, don't bother setting up a plug.

Is there really that much overhead in blk_{start|finish}_plug?
-Jeff

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/aio.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 522c04864d82..ed6c3914477a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -69,6 +69,12 @@ struct aio_ring {
>  	struct io_event		io_events[0];
>  }; /* 128 bytes + ring size */
>  
> +/*
> + * Plugging is meant to work with larger batches of IOs. If we don't
> + * have more than the below, then don't bother setting up a plug.
> + */
> +#define AIO_PLUG_THRESHOLD	2
> +
>  #define AIO_RING_PAGES	8
>  
>  struct kioctx_table {
> @@ -1919,7 +1925,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
>  	if (nr > ctx->nr_events)
>  		nr = ctx->nr_events;
>  
> -	blk_start_plug(&plug);
> +	if (nr > AIO_PLUG_THRESHOLD)
> +		blk_start_plug(&plug);
>  	for (i = 0; i < nr; i++) {
>  		struct iocb __user *user_iocb;
>  
> @@ -1932,7 +1939,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
>  		if (ret)
>  			break;
>  	}
> -	blk_finish_plug(&plug);
> +	if (nr > AIO_PLUG_THRESHOLD)
> +		blk_finish_plug(&plug);
>  
>  	percpu_ref_put(&ctx->users);
>  	return i ? i : ret;
> @@ -1959,7 +1967,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
>  	if (nr > ctx->nr_events)
>  		nr = ctx->nr_events;
>  
> -	blk_start_plug(&plug);
> +	if (nr > AIO_PLUG_THRESHOLD)
> +		blk_start_plug(&plug);
>  	for (i = 0; i < nr; i++) {
>  		compat_uptr_t user_iocb;
>  
> @@ -1972,7 +1981,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
>  		if (ret)
>  			break;
>  	}
> -	blk_finish_plug(&plug);
> +	if (nr > AIO_PLUG_THRESHOLD)
> +		blk_finish_plug(&plug);
>  
>  	percpu_ref_put(&ctx->users);
>  	return i ? i : ret;
