Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF0C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 07:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453FD20857
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 07:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiFYIF90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfDBH7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:59:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBH7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 03:59:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so15332749wro.5
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2019 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2ru/BFVHEWSadfx1cM6+uKtJ+kqJjiJuEIrRwhtwAI=;
        b=XiFYIF90eYovH6lL+5WfQpAlG7W2DKylG2dC5Z0GxJkeRl2ma0na7dALXekW0p4Jb4
         ru3D4rgy60UrNT4kxsjxPkyQ9WGJ9/dqKjPB0r68BtjiBtP13XKHcXrRje2UyZ8Akqyv
         qAeviQDGLKFFpCDZm2A1B4m9bMGMIwFaZWkQMLRGB1siDA/k5eBTVCa6IQSIhgD4NVNN
         1uzw8xDJNckRb6VQOV7AxUFWgPHDn08t6PU7nHqxpSqlwh5ngUgUXyzJnnPE2V6wiNXc
         yhHRoPTjmMdVIH3AzihZjjzfHaUIWjeBjeyGZfRkPNWfcWuLqZqko/SYT5+petxb2H7M
         pTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2ru/BFVHEWSadfx1cM6+uKtJ+kqJjiJuEIrRwhtwAI=;
        b=MjdCKcj0HAHKF/W6SdS1EACgVDEs91A9b+jdytqLO605MwMuIzB/4Mo0XNr6VHeUwH
         2yPqc08VPsyuVM1cEytu70dpQgA0h+179A7sKOtVf/Me8IX1tXA3lco17RJ/qMmhLTq1
         pqdmS6Bnu2365MwJL3sJ2GbqUXzQRye02D1RLY1ny1RgJMOF0lVZztXVMLM11Nyn4i5I
         rKm+W77qI2jrd97C3NtzVN2aIDakgfLJOrLqmD1avwx2+as0sB1SVjwjKcdVAqIctqO8
         FLCPynbjSpV99bZXGjY2OHfaZ4ukmcCZL4/gAh6A3qe8XzFngqDgsq0jAPr99z4hojlj
         U9TA==
X-Gm-Message-State: APjAAAUo1CdfXS45Y1EsXHWgYaBZeEI/WiiIAeKA0rys4H01HXXV2Z/V
        pZeHL4LLM/jEff1aWOQg7P3KEw7b+A1w72NZ1a0=
X-Google-Smtp-Source: APXvYqyJwW4atSQzvdRbmVnh2Mo8Z3U0VrUOb05vjy+JKISPFK9+gQHBD3aiuKxWxIlV0eXoxefsgL/wD7Ysgk2aK7I=
X-Received: by 2002:adf:ed90:: with SMTP id c16mr42467336wro.74.1554191988262;
 Tue, 02 Apr 2019 00:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134036.8377-1-shhuiw@foxmail.com>
In-Reply-To: <20190401134036.8377-1-shhuiw@foxmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 2 Apr 2019 15:59:36 +0800
Message-ID: <CACVXFVNsgA1Xu24smAJ1i7OnSUY1d1wa8aAYgHxqpZ2iQgXhkQ@mail.gmail.com>
Subject: Re: [PATCH] block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hctx
To:     Shenghui Wang <shhuiw@foxmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 1, 2019 at 9:41 PM Shenghui Wang <shhuiw@foxmail.com> wrote:
>
> kfree() can leak the hctx->fq->flush_rq field.
>
> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b49969..f3b0d33bdf88 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2332,7 +2332,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>         return 0;
>
>   free_fq:
> -       kfree(hctx->fq);
> +       blk_free_flush_queue(hctx->fq);
>   exit_hctx:
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
