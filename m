Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BBC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 10:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhLFK0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 05:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233542AbhLFK0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Dec 2021 05:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638786194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJulRQjGBrycGKqixvp2UHpYGup5UoOJ3zjkkvvBYr4=;
        b=AVmZccriQz95dR4W7nv6Su93nncCNfgaeIiDH/lBjyp8O7Kkl0znRNI3e+a7v3i9U3kbqd
        P2UFmNaXeckrXCYaRs3Y8TEKIu6/OViGbxeoy7c4ymOz2wG9HbbmuuVzq6zULzjDlwxiTA
        PNBTu1zjNXb1rS77Vz2lWHMFDsGa3x4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-TYoTigw9Pe6E1FW3Ns54JA-1; Mon, 06 Dec 2021 05:23:13 -0500
X-MC-Unique: TYoTigw9Pe6E1FW3Ns54JA-1
Received: by mail-yb1-f197.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so18859490ybj.13
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 02:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJulRQjGBrycGKqixvp2UHpYGup5UoOJ3zjkkvvBYr4=;
        b=7YWz8nE1+u1iE2Oh2lXEISKL2V/h2shMKyhxWSiWgEg5R9h4+PmI61NUhGX74kS/05
         HlYaFe9xPGxkwdh+G8pZOJAveGmeTBnHlJ+AVUBp/yMNsDVKxZ/cQaJzyK3yt3WAULqZ
         ndG9ct+CtmC8OIwhKCn329Z5SGZj4lUznN6QOMNNpSaE3ACimsoglnyacg3xlpqOhu3t
         9/gasPz/OyVIjVFVThGEj+venRI6Id35q+Ybu7napkLbp9WeuztodDLq9Swj/Ohm1rNl
         lG0DxuqzViaTrX/7IPC+V1ZHQQqP6UvXv8Vll81CUMzbcv8x+5UGFd/19BQsRp6gjsbm
         CtKg==
X-Gm-Message-State: AOAM530Rfx0vU1+6ZjVC+qfOEnpzy1qVwHL6i3gWomO2xEjc4jBEvsk0
        PnKPQZY0n7dqeDOp/4SQtn5ClsGkmjFVtrAgsgggDjwKBx+x9QeseGJQHed7+YDDphCWhtOAzGX
        m0zwEq+8h+jkwszjAJZ1EwTNFdrk7E7dwadqKpnI=
X-Received: by 2002:a25:9a84:: with SMTP id s4mr40367153ybo.405.1638786192354;
        Mon, 06 Dec 2021 02:23:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSiUpfhuhZAljLgaZ8M9b9F3TrkbNfxVOpZXaRZTP1LY7FIT317NaIF7cZZmHYqySxRFeIgc8g5vII3Fi27Iw=
X-Received: by 2002:a25:9a84:: with SMTP id s4mr40367124ybo.405.1638786192089;
 Mon, 06 Dec 2021 02:23:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs-w_ypfFdiR=YDYZptcBUDh4=Qrc3-+ATpuDOng4PFbQA@mail.gmail.com>
 <CAHj4cs85h_Cs-yf0U=5eckaBifvciX1FNPEterBnGRc8rbKmuA@mail.gmail.com> <Ya2Fn4oNKDgjhO3T@T590>
In-Reply-To: <Ya2Fn4oNKDgjhO3T@T590>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 6 Dec 2021 18:23:00 +0800
Message-ID: <CAHj4cs9T4xU8kG9RdCVvqkj2cnN6Fq_GMLWQ+QUZxLyzAu4LeA@mail.gmail.com>
Subject: Re: [bug report] BUG kernel BULL pointer at blk_mq_flush_plug_list+0x2c4/0x320
 observed with blktests on latest linux-block/for-next
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 6, 2021 at 11:38 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Yi,
>
> Thanks for the report!
>
> On Mon, Dec 06, 2021 at 09:38:35AM +0800, Yi Zhang wrote:
> > This is the first commit that observed this issue.
> >        Kernel repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: c7d61010b991 - Merge branch 'for-5.17/block' into for-next
>
> The issue should be fixed by the following patch:

Yeah, the issue was fixed by this patch:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> From 8d30d9a46d4ede16c61ad48c2a1ceaf2ec29d044 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 6 Dec 2021 11:33:50 +0800
> Subject: [PATCH] blk-mq: don't use plug->mq_list->q directly in
>  blk_mq_run_dispatch_ops()
>
> blk_mq_run_dispatch_ops() is defined as one macro, and plug->mq_list
> will be changed when running 'dispatch_ops', so add one local variable
> for holding request queue.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: 4cafe86c9267 ("blk-mq: run dispatch lock once in case of issuing from list")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 22ec21aa0c22..537295f6e0e9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2521,7 +2521,9 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>         plug->rq_count = 0;
>
>         if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
> -               blk_mq_run_dispatch_ops(plug->mq_list->q,
> +               struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
> +
> +               blk_mq_run_dispatch_ops(q,
>                                 blk_mq_plug_issue_direct(plug, false));
>                 if (rq_list_empty(plug->mq_list))
>                         return;
> --
> 2.31.1
>
>
> Thanks,
> Ming
>


-- 
Best Regards,
  Yi Zhang

