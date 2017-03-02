Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36190 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdCBUyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2017 15:54:21 -0500
Received: by mail-pg0-f49.google.com with SMTP id s67so35912127pgb.3
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2017 12:54:06 -0800 (PST)
Date: Thu, 2 Mar 2017 12:53:22 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
Message-ID: <20170302205322.GB7792@vader>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
 <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
 <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com>
 <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
 <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com>
 <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
 <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
 <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 02, 2017 at 09:13:30AM -0700, Jens Axboe wrote:
> I was worried about that. How about the below? We need to grab the lock
> at some point for legacy scheduling, but the ordering should be correct.

Makes sense, now the locking is consistent with the other place we call
ioc_exit_icq(). One nit below, and you can add

Reviewed-by: Omar Sandoval <osandov@fb.com>

> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index b12f9c87b4c3..6fd633b5d567 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -54,7 +54,7 @@ static void ioc_exit_icq(struct io_cq *icq)
>  	icq->flags |= ICQ_EXITED;
>  }
>  
> -/* Release an icq.  Called with both ioc and q locked. */
> +/* Release an icq.  Called with ioc locked. */

For ioc_exit_icq(), we have the more explicit comment

/*
 * Exit an icq. Called with both ioc and q locked for sq, only ioc locked for
 * mq.
 */

Could you document that here, too?

>  static void ioc_destroy_icq(struct io_cq *icq)
>  {
>  	struct io_context *ioc = icq->ioc;
> @@ -62,7 +62,6 @@ static void ioc_destroy_icq(struct io_cq *icq)
>  	struct elevator_type *et = q->elevator->type;
>  
>  	lockdep_assert_held(&ioc->lock);
> -	lockdep_assert_held(q->queue_lock);
>  
>  	radix_tree_delete(&ioc->icq_tree, icq->q->id);
>  	hlist_del_init(&icq->ioc_node);
> @@ -222,24 +221,40 @@ void exit_io_context(struct task_struct *task)
>  	put_io_context_active(ioc);
>  }
