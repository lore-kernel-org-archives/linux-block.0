Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF52C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 11:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiGKLV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiGKLUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 07:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E51112871E
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657536291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cc4YCGlT5mNKlbQEPPOYGJvAwmuI9Lc6pbXcTrCWK8Y=;
        b=HhKCo5Km7Z25zXeKiDUB9GjpsJjvlXmvA/ULTNwzJGCqDdp6eUP4Zyqr0M5bNUFEQUA6T1
        t2Y5whKRAW7jEIAl+MK2Y4g70rRX0Yyoj7/qBahf7zsxi3oNO2IpsyhC0YeSDYHKthx9ej
        aTTcgDF75pWryz4Rz424je7MS5izvEc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-iZAzedaxOPyZxjDPXXJBpQ-1; Mon, 11 Jul 2022 06:44:37 -0400
X-MC-Unique: iZAzedaxOPyZxjDPXXJBpQ-1
Received: by mail-pj1-f72.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so241687pjm.2
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 03:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cc4YCGlT5mNKlbQEPPOYGJvAwmuI9Lc6pbXcTrCWK8Y=;
        b=g/SBXh2l/3M0qyWU4bDuAorxHBjF3fFmk+g6XDXoCsj3S+rgm1VV8EWDkDdkjzVSFA
         yM3MEeDdIO7zU+gf9BcssfbhIWLEqh+6Knzdy1xVMvNlVWgGlVYCWT6m2emcw7vfBrCK
         8gZwA7QXQVhD+N0EGuCdQbUCnDe/Q428LJ0SzppNBdIZPXWMhjBzU+xo/sbejak9wz6V
         FQrqzJtkqQeYDwi9+HGwF/Pl2HeNm85ag2VZq2wFnA9pC85ir7HSLVbX07NBQa3Bj7LX
         b5cRruc1pOUNcDK0flRAPy5QLK8TZTDaAplZGbC1gH1flPty6AZyARJqRDAbSINpR6R8
         RN3Q==
X-Gm-Message-State: AJIora9646ydWHjFGWXellW58uaNY0JRrebRl1aeexaVZ41jhMW0fphU
        4jE7inBvwy/eAosRcG5hCQseGXsTYKvmeBrqBFjhlcxKLm4Yd1R6BQCdzMUyp8rqPF8FapTvfOP
        SB35PRemyBKbtb+rHZALMT1ZdIcleje1pzwK4z68=
X-Received: by 2002:a05:6a00:23c9:b0:52a:cedd:3992 with SMTP id g9-20020a056a0023c900b0052acedd3992mr5137995pfc.43.1657536276205;
        Mon, 11 Jul 2022 03:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYnrOw+uRMOO/c8vIUctc1rvWmK0ZrqojXQg4WeaNm2BClRjrUewK/w7HbyvrDFnWyFbiVoVncLj9L6foJtg0=
X-Received: by 2002:a05:6a00:23c9:b0:52a:cedd:3992 with SMTP id
 g9-20020a056a0023c900b0052acedd3992mr5137972pfc.43.1657536275864; Mon, 11 Jul
 2022 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220711090808.259682-1-ming.lei@redhat.com>
In-Reply-To: <20220711090808.259682-1-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 11 Jul 2022 18:44:24 +0800
Message-ID: <CAHj4cs85rWQHUY4+9axMNitJo67kD22=UjDHpK25e3i1uuYZTg@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Verified on linux-block/for-next,
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Mon, Jul 11, 2022 at 5:08 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> blk_mq_debugfs_register_hctx() can be called by blk_mq_update_nr_hw_queues
> when gendisk isn't added yet, such as nvme tcp.
>
> Fixes the warning of 'debugfs: Directory 'hctx0' with parent '/' already present!'
> which can be observed reliably when running blktests nvme/005.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b80fae7ab1d9..28adb01f6441 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -728,6 +728,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
>         char name[20];
>         int i;
>
> +       if (!q->debugfs_dir)
> +               return;
> +
>         snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
>         hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
>
> --
> 2.31.1
>


-- 
Best Regards,
  Yi Zhang

