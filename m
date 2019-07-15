Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7147C73C66
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 01:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866D920868
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 01:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFsY4oNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfGOB0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 21:26:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37707 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGOB0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 21:26:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so13475785wme.2;
        Sun, 14 Jul 2019 18:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXtprjYX3LMZPcPvIkCQpHQOi7CXiEJzMLuO2MOHDFY=;
        b=JFsY4oNs0InJ0zKTLAT5/DNZA3GeQ5vUGlzj4vJoyukxjE9wh31D0X5E2dFcXBkuu9
         5baYD+BB44bzldFblCMubnJYeJQHfm+bo8qvYWrq7FCoCCyNcEos9rL8vCxW80743jj4
         djzYr+jT48v68VGOmXfKBu3szUoeqTYbIoQcYpMzOKVoMpyiZN+psoOl5RnCea+QznzW
         u/GrX5TTepNy2ZGNckHIRJWkEtOBfIPZsFJnVrI6VK85cFq90YQ0oV33WqMnvuGZRV4N
         5HhfV9vrDA1aLeatn8qE221SvZsxUuJzvEFhzSgrEuapTnXcocerUWiLIDXfdgvxUkZJ
         VDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXtprjYX3LMZPcPvIkCQpHQOi7CXiEJzMLuO2MOHDFY=;
        b=DNX1pTWBCiEWhroEWUAJRCDdNUOhXN1W+yKcYjiHdjqLr/ofhVIdnvYbbp6KB45nvK
         Fa/X+elZB5M5OcbpBWwRbdlSgJ6OadZX1Oq1+WT0+XIj6c/rSttW0yQaiBrz0wS3djrc
         agFYBZ7pzzLJ+DjxDfcYFKlQaiadbfxWzSoBR4uD2fgULti7SVue420lfPko1OiRKk2Y
         7RuA/YrX7Oj72t/bGA1BtpbAx2yT4ogT6NwbMNlYoE1wubw6Pv1dhoo6MPv7ckFNbWak
         Z0cL7Xsfs87UZAog0j1UPBsMatbPts5c4eGTMywtTmv2TbxA8o9TDmBYjabCaoAGhHJ6
         Qe5g==
X-Gm-Message-State: APjAAAVenMoK/7whlCGPlyuAdFu40PH/BaUq/Lcv9YT/LPc85RO2oSps
        b1TZtTykqh3bDgsf1q478JHBQ1vEx2irAPyzfeg=
X-Google-Smtp-Source: APXvYqySfMIGh9QaP384gEwM9t69jEpaX7PiQK1qs9kxdiu7h7Kj/FqkvR6LDKFq42u1aaGMZWWhp3rmBxjL7I8ruZg=
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr20916333wmg.121.1563153957506;
 Sun, 14 Jul 2019 18:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <1563087801-7373-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1563087801-7373-1-git-send-email-wang6495@umn.edu>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 15 Jul 2019 09:25:46 +0800
Message-ID: <CACVXFVOXZCtYtt3UuYBa7OYHEwsMkYFznfpL=1q9HkJV8xcx0Q@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 14, 2019 at 3:04 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> From: Wenwen Wang <wenwen@cs.uga.edu>
>
> In blk_mq_init_allocated_queue(), a kernel buffer is allocated through
> kcalloc_node() to hold hardware dispatch queues in the request queue 'q',
> i.e., 'q->queue_hw_ctx'.  Later on, if the blk-mq device has no scheduler
> set, a scheduler will be initialized through elevator_init_mq(). If this
> initialization fails, blk_mq_init_allocated_queue() needs to be terminated
> with an error code returned to indicate this failure. However, the
> allocated buffer is not freed on this execution path, leading to a memory
> leak bug. Moreover, the required cleanup work is also missed on this path.
>
> To fix the above issues, free the allocated buffer and invoke the cleanup
> functions.
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  block/blk-mq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e5ef40c..04fe077 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2845,6 +2845,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
>  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>                                                   struct request_queue *q)
>  {
> +       int ret = -ENOMEM;
> +

The above isn't necessary because the function always returns
ERR_PTR(-ENOMEM) in case of failure.

>         /* mark the queue as mq asap */
>         q->mq_ops = set->ops;
>
> @@ -2906,11 +2908,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>         blk_mq_map_swqueue(q);
>
>         if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
> -               int ret;
> -
>                 ret = elevator_init_mq(q);
>                 if (ret)
> -                       return ERR_PTR(ret);
> +                       goto err_hctxs;

The above change itself is fine.

However, elevator_init_mq() shouldn't return failure since none should
work any time.
That said 'none' should be fallback to in case that default
mq-deadline can't be initialized.

thanks,
Ming Lei
