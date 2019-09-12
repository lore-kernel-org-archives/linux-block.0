Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826EC4CEC7
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129E820830
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfILUP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfILUP7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 16:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B79A10CC1E2;
        Thu, 12 Sep 2019 20:15:59 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 946045D9E2;
        Thu, 12 Sep 2019 20:15:58 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        Lewis Baker <lbaker@fb.com>
Subject: Re: [PATCH] io_uring: make sqpoll wakeup possible with getevents
References: <c9084c96-1771-6b7e-affb-2ac2e09e827d@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 12 Sep 2019 16:15:57 -0400
In-Reply-To: <c9084c96-1771-6b7e-affb-2ac2e09e827d@kernel.dk> (Jens Axboe's
        message of "Thu, 12 Sep 2019 10:08:55 -0600")
Message-ID: <x49k1adtgn6.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 12 Sep 2019 20:15:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> The way the logic is setup in io_uring_enter() means that you can't wake
> up the SQ poller thread while at the same time waiting (or polling) for
> completions afterwards. There's no reason for that to be the case.
>
> Reported-by: Lewis Baker <lbaker@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

>
> --
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4bc3ee4ea81f..3c8859d417eb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3356,15 +3356,12 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>  	 * Just return the requested submit count, and wake the thread if
>  	 * we were asked to.
>  	 */
> +	ret = 0;
>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
>  		if (flags & IORING_ENTER_SQ_WAKEUP)
>  			wake_up(&ctx->sqo_wait);
>  		submitted = to_submit;
> -		goto out_ctx;
> -	}
> -
> -	ret = 0;
> -	if (to_submit) {
> +	} else if (to_submit) {
>  		bool block_for_last = false;
>  
>  		to_submit = min(to_submit, ctx->sq_entries);
> @@ -3394,7 +3391,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>  		}
>  	}
>  
> -out_ctx:
>  	io_ring_drop_ctx_refs(ctx, 1);
>  out_fput:
>  	fdput(f);
