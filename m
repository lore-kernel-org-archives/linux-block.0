Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA2EC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F7C20721
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWqg1F/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgE2Doz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 23:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388037AbgE2Doz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 23:44:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F636C08C5C6
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 20:44:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so1635568wmh.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u6mMZSLimZl0GywaUQnKdRzfuv7lLKSy19l3gA5aXU=;
        b=kWqg1F/Ov75DwlTBnYhlLLQr9+8g20a/Z1UtG8VIPv7wOcmYunemTHdc7kqgsHcBD1
         8gvngbETYilY/8Fv/N6L6e9gOuDdNbxyxkPkWdFNmRSF3igjf9Ce/zF7QBsJouJluTVx
         hC/XQ1VVC9/482y2P3tYKEFzs7qq7V95O7C8tnb7vDxDzzKi+s/FeXoRd0uksXywhIoQ
         cQs9Q3UOfCwuZZ5AlY/V5VsvQaUEBlpLn7r+sr4857qmD7BrthkMwRlBLSvYBcsQsNRK
         w6++VW3aW9WTy0LDlbzkPXao0gyNILIAKCKiT/piN8pKnFc8tZIgxNxSw59dJbP4RdLI
         6ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u6mMZSLimZl0GywaUQnKdRzfuv7lLKSy19l3gA5aXU=;
        b=ND3M/W9xJmEYSs50KfwBXREFEN43EkSZ77jSqKtoNG+vgFu727Nbognet/2qebkAal
         42y44DfYS4Q15ewrEvX9KXc4ZzjGGCR9A5T7TKxyBZMw7DWPm7k4Usn4oI197tI/0mLf
         UlAWWS+L9Yd2Z5rxnzdjlO2ZkEdP1MxwxJWKY5Zs1I1WQHxYRmrV0PTBatB1ZvrTrPN4
         U/uuGuQbwR6E9FmPZtLcoFJpC7A/tq7UBemCl4HdEiYaaDHgzUszEsknMHVfP51vPSro
         b8UeptgUihZl3kr8ShEwHtrzxA9sPuIdOIUby53WY3Sv+IrCXe1I4zeb4nNy/z84WfV5
         KepQ==
X-Gm-Message-State: AOAM533ATS+iwNK/uRfnurSGswd/Ent83fPypfIcRiJ52530YDXfMKCn
        FnfkQAevzjzG05gP8KaJCie+g0XcjsyWJZZky7Lj/1fIm5I=
X-Google-Smtp-Source: ABdhPJyxD6HpdHMYbOLK5MKbh2lMWfZML7uJP7IfC8iuNxn/mxHI9L6PlL1AnUz9n6/ABz1O05hb7dlUXQrUghmMCEg=
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr6070547wmg.115.1590723893290;
 Thu, 28 May 2020 20:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151931.3501506-1-kbusch@kernel.org>
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 29 May 2020 11:44:42 +0800
Message-ID: <CACVXFVMosTsw5vD=y848umB4UkK3pgnNPjvULBHtp9C40XgYJA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 11:19 PM Keith Busch <kbusch@kernel.org> wrote:
>
> For when drivers have a need to bypass error injection.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq.c         | 3 ++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cac11945f602..3c61faf63e15 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
>         q->mq_ops->complete(rq);
>  }
>
> -static void __blk_mq_complete_request(struct request *rq)
> +void __blk_mq_complete_request(struct request *rq)
>  {
>         struct blk_mq_ctx *ctx = rq->mq_ctx;
>         struct request_queue *q = rq->q;
> @@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
>         }
>         put_cpu();
>  }
> +EXPORT_SYMBOL(__blk_mq_complete_request);
>
>  static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
>         __releases(hctx->srcu)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d7307795439a..cfe7eac3764e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
>  void blk_mq_kick_requeue_list(struct request_queue *q);
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
>  bool blk_mq_complete_request(struct request *rq);
> +void __blk_mq_complete_request(struct request *rq);
>  bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
>                            struct bio *bio, unsigned int nr_segs);
>  bool blk_mq_queue_stopped(struct request_queue *q);
> --

Looks fine:
Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
