Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5EC19F2D
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 10:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiHMK0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMK0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 06:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A01EA18390
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660386391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HG4FsEUEwyxpL4/g3+92gOonanu0P6Bi3bc/HppZv88=;
        b=W6PwYhYWT3UQTe86WecsvGYe1+vdcZaShLLN+jeIqHsMiUNYLGX8XU7LdoLQcM/OgAb/ab
        8FUUrKLBg/lgLBh8C1I/xm9gmp5QIAYodku9jXFIXfwjFUw+IZldn+17704GsyhGu0Luo1
        iuLRatLhDxomuDv7tpUOyXk0Yf/4KZg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-cm6vNqEsPNC9S6ADy3aATA-1; Sat, 13 Aug 2022 06:26:27 -0400
X-MC-Unique: cm6vNqEsPNC9S6ADy3aATA-1
Received: by mail-yb1-f200.google.com with SMTP id 126-20020a250f84000000b006842c2dbbd4so2406446ybp.1
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HG4FsEUEwyxpL4/g3+92gOonanu0P6Bi3bc/HppZv88=;
        b=q925Xx+Zh87fk6cUxwC4NzLqYQeQH01BmT6SB4Hot/6e/yrtGPhSzWt3DyBTVp3YYZ
         2C80UDo0TY7iWw7kLSxilneDUj0N4ff6gXQzIdc53LxIrMFsS34DsWxWgxjMwrUXOnS+
         0x2sJADjBEuwxXhMdgM+0mgSrlqOYWEYr8UEJonHEfwyv//GkUwbnNjF8bJ+8uL2tOfp
         BXe/E83NxZWcv/Rs7sF76VnOF++DS69aDuPMR5lVoDTrMUDdUUJRXUuoY09yOLrWdWIR
         9h0esHcV76fAJevffoRzxCWevn484CMM8PWQrrBsb+bIeg+1kvrT0nXWQ8Kh724MiyGb
         XlDw==
X-Gm-Message-State: ACgBeo1cm+DX6S8FwhzKHtkp4OrqX7AP/ZnEUDhWDYSLSWJlzTKrdN8q
        p7K5p3FumPmMc8YujLQ1oij0HrxvAOVwr7xRQqh5QqnKq8MH8zlgwNJvG10QTHmv3te4mZqq315
        LeF387oVVRRX6F0G/yfZeR2bUhSCfumTjs08FYws=
X-Received: by 2002:a81:bf4b:0:b0:322:aec5:b17e with SMTP id s11-20020a81bf4b000000b00322aec5b17emr6915574ywk.271.1660386387154;
        Sat, 13 Aug 2022 03:26:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GIKGLokh2KZCuuH6fnRMEf5kXklq6/NepH4/ZR4EEJRENErOX1tSqTxZmGGri4u7IaS81IaLDTCHXET0yf1Y=
X-Received: by 2002:a81:bf4b:0:b0:322:aec5:b17e with SMTP id
 s11-20020a81bf4b000000b00322aec5b17emr6915569ywk.271.1660386386933; Sat, 13
 Aug 2022 03:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com> <20220809091629.104682-4-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220809091629.104682-4-ZiyangZhang@linux.alibaba.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sat, 13 Aug 2022 18:26:16 +0800
Message-ID: <CAFj5m9JaEK=7EYHMf4WcPT6Oa1uZnS33C5W82ZdJqMLfZ8WFhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ublk_drv: do not add a re-issued request aborted
 previously to ioucmd's task_work
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 9, 2022 at 5:17 PM ZiyangZhang
<ZiyangZhang@linux.alibaba.com> wrote:
>
> In ublk_queue_rq(), Assume current request is a re-issued request aborted
> previously in monitor_work because the ubq_daemon(ioucmd's task) is
> PF_EXITING. For this request, we cannot call
> io_uring_cmd_complete_in_task() anymore because at that moment io_uring
> context may be freed in case that no inflight ioucmd exists. Otherwise,
> we may cause null-deref in ctx->fallback_work.
>
> Add a check on UBLK_IO_FLAG_ABORTED to prevent the above situation. This
> check is safe and makes sense.
>
> Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request
> (releasing the tag). Then the request is restarted(allocating the tag)
> and we are here. Since releasing/allocating a tag implies smp_mb(),
> finding UBLK_IO_FLAG_ABORTED guarantees that here is a re-issued request
> aborted previously.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index bedef46f6abf..0b9bd9e02b53 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -725,6 +725,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  {
>         struct ublk_queue *ubq = hctx->driver_data;
>         struct request *rq = bd->rq;
> +       struct ublk_io *io = &ubq->ios[rq->tag];

The above line should be moved into branch of not using task work,
otherwise this patch
looks fine.

Thanks,

