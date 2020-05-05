Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E8C47256
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 04:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BC3206C0
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 04:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC40JjaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgEEEO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 00:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725272AbgEEEOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 00:14:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B50C061A0F
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 21:14:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so1043954qka.10
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLOtxAnNTSjg7iMrhCl/c5NcBOZ4WjRhE6A7lH1xLFA=;
        b=GC40JjaIthr+dpcR4uSRqFuSWyCoDmnfgqAJ7tp43mC9sAKCC4FcyNfHRlctNVkR+Y
         KqDJtB0eagdBG0ily1gvSuLgAyCFABTpKhRqEm05/OY4XLpwIec4nvtLRW68fNSuBWTq
         bfBZKfIpKydDArBRXOhcLHDPGoBNRtrBQuD5L/ExoHt4fstblockO7/ra7yDo9J6Ld14
         oQJbTFoKJjeGH/k3NfmIW6Vjebwt1cJwvFGmUDNjEsoea8FJ3cHwuTnXstX5mVRLYrjd
         uOMKqz3AYkIRCtBU4MWQ8tGl7hO3KXwkdeVGCB7hrqxrs1YBrg3Xwpo3iZqtfLsKAONR
         dG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLOtxAnNTSjg7iMrhCl/c5NcBOZ4WjRhE6A7lH1xLFA=;
        b=EoPwLj3TyM6ESyvciAMlL6S6tR0V0lKn7W8hV+3eQA+kQ5QqpYP+YzZyVqvm0QIdwp
         V3ZdL1zlo/VcYovo3ddDomzC7HY9h0A3dvS91QQvqq8d92dam2YqQXG5NEAQyoZilQln
         +kkaFPJqmTrWK77Q6sO5tA9SPJflr//q/6feI06l3x708wUeM4GXrEEj9olGcBZrXVmL
         R+g+BCgArS7gxm9mms4bm68caOOhUDlTjjkF8dIBY/77l4FEEx2V/Oby6HYpIvH0lp+9
         1GP+GvmGwwJo3gPYxVwkaY/BuGdJJG9nsIO6Be09HLaQYEp+urdQGeXVtryHrwJymwnA
         rl0g==
X-Gm-Message-State: AGi0PuayxoWccIeHj/3ibH2/0vd+uucrv+E4C/fqoLJ8KHXdi0k+mar2
        Y8Pn//Yb06p0GaOupkWnKjEA0wvtHyriSq4SNzU=
X-Google-Smtp-Source: APiQypLSuIL1eV8H8E4q1sy4pcgYYKzvWfgG0mTP535jQJVDqP2+EtWr4Fo+AqwNc1aaJPBFz+Ox01m9gVknMsyxnbc=
X-Received: by 2002:a37:7b01:: with SMTP id w1mr1726267qkc.167.1588652064634;
 Mon, 04 May 2020 21:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
 <fbf27d4283954c9bd3e65422cc962a4e60a0ae5c.1588080449.git.zhangweiping@didiglobal.com>
 <20200503032112.GA1128091@T590>
In-Reply-To: <20200503032112.GA1128091@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 5 May 2020 12:14:11 +0800
Message-ID: <CAA70yB4vB=Hbie-gSbvPpBeKDKfAnGazofjqZgWnx=jHMENNOA@mail.gmail.com>
Subject: Re: [RESEND v4 4/6] block: alloc map and request for new hardware queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, tom.leiming@gmail.com,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 3, 2020 at 11:22 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Apr 28, 2020 at 09:29:59PM +0800, Weiping Zhang wrote:
> > Alloc new map and request for new hardware queue when increse
> > hardware queue count. Before this patch, it will show a
> > warning for each new hardware queue, but it's not enough, these
> > hctx have no maps and reqeust, when a bio was mapped to these
> > hardware queue, it will trigger kernel panic when get request
> > from these hctx.
> >
> > Test environment:
> >  * A NVMe disk supports 128 io queues
> >  * 96 cpus in system
> >
> > A corner case can always trigger this panic, there are 96
> > io queues allocated for HCTX_TYPE_DEFAULT type, the corresponding kernel
> > log: nvme nvme0: 96/0/0 default/read/poll queues. Now we set nvme write
> > queues to 96, then nvme will alloc others(32) queues for read, but
> > blk_mq_update_nr_hw_queues does not alloc map and request for these new
> > added io queues. So when process read nvme disk, it will trigger kernel
> > panic when get request from these hardware context.
> >
>
> map and request is supposed to be allocated via __blk_mq_alloc_rq_map() called
> from blk_mq_map_swqueue(), so why is such issue triggered?
>
> The reason could be that only queue type of HCTX_TYPE_DEFAULT is handled
> in __blk_mq_alloc_rq_map(), and looks all queue types should have been covered
> here.
>
> Could you test the following patch and see if the issue can be fixed?
> Then we can save one intermediate variable if it helps.
>
Hello Ming,

It works well, so the patch-3 can be dropped.
For patch-3, there is no memory leak when decrease hardware queue count,
blk_mq_realloc_hw_ctxs will release the unused rq_map and request by
blk_mq_free_map_and_requests.


>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 12dee4ecd5cc..7e77e27b613e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2742,19 +2742,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>          * If the cpu isn't present, the cpu is mapped to first hctx.
>          */
>         for_each_possible_cpu(i) {
> -               hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
> -               /* unmapped hw queue can be remapped after CPU topo changed */
> -               if (!set->tags[hctx_idx] &&
> -                   !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> -                       /*
> -                        * If tags initialization fail for some hctx,
> -                        * that hctx won't be brought online.  In this
> -                        * case, remap the current ctx to hctx[0] which
> -                        * is guaranteed to always have tags allocated
> -                        */
> -                       set->map[HCTX_TYPE_DEFAULT].mq_map[i] = 0;
> -               }
> -
>                 ctx = per_cpu_ptr(q->queue_ctx, i);
>                 for (j = 0; j < set->nr_maps; j++) {
>                         if (!set->map[j].nr_queues) {
> @@ -2763,6 +2750,19 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>                                 continue;
>                         }
>
> +                       /* unmapped hw queue can be remapped after CPU topo changed */
> +                       hctx_idx = set->map[j].mq_map[i];
> +                       if (!set->tags[hctx_idx] &&
> +                           !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> +                               /*
> +                                * If tags initialization fail for some hctx,
> +                                * that hctx won't be brought online.  In this
> +                                * case, remap the current ctx to hctx[0] which
> +                                * is guaranteed to always have tags allocated
> +                                */
> +                               set->map[j].mq_map[i] = 0;
> +                       }
> +
>                         hctx = blk_mq_map_queue_type(q, j, i);
>                         ctx->hctxs[j] = hctx;
>                         /*
>
>
> Thanks,
> Ming
>
