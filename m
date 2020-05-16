Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D15CC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1206320728
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO3Arfqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgEPJk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbgEPJk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 05:40:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676FC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 02:40:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w64so5043236wmg.4
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prOklu8nEf2Oj5oMbZw+o6ZVgBkTg9obmN8C8CyvLBI=;
        b=gO3ArfqhdkuKTu0bUuuh0OjKkDrVOufEhygdazOsHEcuicVM6apBjEFGD3gsrzRBx6
         pVcDTgUE1gBINyicExgDgtLfi6ZXSpCTjNF2Xdp8SLFLMl3SPkfNEb7fKt3sD1weR4vX
         cPCVuEgR9njJNV1wHMAcJPGP0ZYmWJuO39y662f38wURC5z5ZdTokICRxZDMk9p3x0Nr
         1zzzkHtAfNehR5H/l7yVt36YWZrArZ0HZTqcBH/YCMAjwIDGeje1Fu0jC3mnJ/l88P65
         zMy3f1QwKlIfI68yme3is284dOKoTKWdPW4ILLM/8ICTCp/5BRULyxOhHTKg0YMMAwc4
         fJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prOklu8nEf2Oj5oMbZw+o6ZVgBkTg9obmN8C8CyvLBI=;
        b=L7unmmsjrFTTEZIfjSOkXt7+Y1xiEF/pM/kZli3mdm2tuiaPvytyN73dl23/vEnpcy
         4ovNVTwdPREB943NpVMjHj5b1Q3k0svUHkWoYBLIYJynLCgXIGBASOwD2Jk4fpnkyiQL
         WW8QofYLUFNkS4MZEl5fJ6q+Vk2lnrDaTkpktFeDj2EU3/qH/NeMW1eyzC4JJweODGqT
         /xCOz0wAE+EaJ/gl7OqMqmhZVsjI5Np5QQnqBiWzoJqnU8oYWDTxgYd4q6JArB7IjhCs
         dTwWCUdwoGrqnesln+nttHgPntU0CxikpBSWRl8oArD6G+60hrL9yqS8njSb+8CZlnTY
         G3cw==
X-Gm-Message-State: AOAM531RRXnNfVe0XtpHio6fJp3jtLEbg03mOaBy7emTzRzw7NGdBgn9
        aC94bdQEDM5BYapXbLum/Xm+Jta80kLVJvSp729zdFIofOw=
X-Google-Smtp-Source: ABdhPJyKEI1cqsmHSqvJ87CMskshRudLT8y4PPa6lRlyz47/c8ZUqG0CcMyqJYCHSU+FWsiRiJ8UCYPO7RuVq6gfVxU=
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr8270994wmi.37.1589622022729;
 Sat, 16 May 2020 02:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-6-bvanassche@acm.org>
In-Reply-To: <20200516001914.17138-6-bvanassche@acm.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Sat, 16 May 2020 11:40:11 +0200
Message-ID: <CAG_fn=WAepYu5NwtHj_FVy426+VN1PD8FKt=siW0OAqq0YOq4g@mail.gmail.com>
Subject: Re: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 2:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> This patch suppresses an uninteresting KMSAN complaint without affecting
> performance of the null_blk driver if CONFIG_KMSAN is disabled.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Alexander Potapenko <glider@google.com>
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Alexander Potapenko <glider@google.com>

> ---
>  drivers/block/null_blk_main.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c
> index 06f5761fccb6..df1e144eeaa4 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1250,8 +1250,38 @@ static inline blk_status_t null_handle_memory_back=
ed(struct nullb_cmd *cmd,
>         return errno_to_blk_status(err);
>  }
>
> +static void nullb_zero_rq_data_buffer(const struct request *rq)
> +{
> +       struct req_iterator iter;
> +       struct bio_vec bvec;
> +
> +       rq_for_each_bvec(bvec, rq, iter)
> +               zero_fill_bvec(&bvec);
> +}
> +
> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
> +{
> +       struct nullb_device *dev =3D cmd->nq->dev;
> +
> +       if (dev->queue_mode =3D=3D NULL_Q_BIO && bio_op(cmd->bio) =3D=3D =
REQ_OP_READ)
> +               zero_fill_bio(cmd->bio);
> +       else if (req_op(cmd->rq) =3D=3D REQ_OP_READ)
> +               nullb_zero_rq_data_buffer(cmd->rq);
> +}
> +
> +/* Complete a request. Only called if dev->memory_backed =3D=3D 0. */
>  static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
>  {
> +       /*
> +        * Since root privileges are required to configure the null_blk
> +        * driver, it is fine that this driver does not initialize the
> +        * data buffers of read commands. Zero-initialize these buffers
> +        * anyway if KMSAN is enabled to prevent that KMSAN complains
> +        * about null_blk not initializing read data buffers.
> +        */
> +       if (IS_ENABLED(CONFIG_KMSAN))
> +               nullb_zero_read_cmd_buffer(cmd);
> +
>         /* Complete IO by inline, softirq or timer */
>         switch (cmd->nq->dev->irqmode) {
>         case NULL_IRQ_SOFTIRQ:



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
