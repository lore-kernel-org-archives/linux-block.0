Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DDC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEWJaA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjEWJ36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:29:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A096E6
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:29:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f6e83e12fso669549566b.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834188; x=1687426188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QBf3iwC40d0yyQhdwV1z7B130zAmQClMdoR3E3jD/Q=;
        b=PEf8/Np/utknSfD6lQhKF8CqDouZRmLnKaBeoqYjbKZSYgDNDotSEqfHxs4kD4mJoU
         lWR5LIBhQ/IYKHZzBH21tR7utAvEX5qotc6i4/fASIQak3uRJBAHRVGM3Hir/IHPxs+Q
         G7csyVLSkNcre5Ruy5Qs44vYzuooziPt1AD4iZZ/6WOCxitG0kGfGQcksFyBVAGpZTMH
         aNFibCm3pVXb2cxEFwGPZwpgCweCQ3fVUMbCxHKQ/bWZfe3QHxeYgpkCapGG76F6wb9E
         RDV3mAScAwrrqL8pi4Lh12kiXWwfI4LiHf7imEdK1zKCF8/GsuQIf+AIsuQPEtoyo48M
         j+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834188; x=1687426188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QBf3iwC40d0yyQhdwV1z7B130zAmQClMdoR3E3jD/Q=;
        b=MlNxs39KhlSKdQ3pzqw8/2YEwvMmmkQ1TfF37KPvjq67JveaEo0JzpOI3BlWLwA24W
         sosd2WhF/dw5B595Bgyjymu1ZQKlO6SNjaeySWpE9Y35AS9znHuiLRmX852zkviNJExI
         gAFzNoqzaylNOBmF8/JnT/nCR0q+0y3CppK8lMTG1NMoXwaMuNyxyH6XSYCYvKpTevzH
         o0PCPeR7CQ+4R3ja/GVlGbRFvgrzMCGCtK2hSOLDpk2rcdcjftJoGgOnjuHsgpyej5b0
         PhLr0yB8U2NjysR5XwGVMfEdPFbUKUUvlLa9wIFO2cNufZJxdFsw2sz/7YxfkiKXWj7u
         kZWw==
X-Gm-Message-State: AC+VfDw2we1fATQGbFu9KIBa4BIz40SXOVMXdA4xbWexZWWMiYcawjXY
        +3nXAMUNzCWFIKph9vFj0rXs2eQ+ZB/JEdgNVhw2Yw==
X-Google-Smtp-Source: ACHHUZ5o2neS4WQqhy4GxF267FvfxwjA1+QvoMofHUIbmTcWkbEJg+9XIjsz0MN6lCTqF8YlRefixq6zeUCqVNpRhH4=
X-Received: by 2002:a17:907:5c2:b0:96f:5027:5907 with SMTP id
 wg2-20020a17090705c200b0096f50275907mr11173777ejb.35.1684834187976; Tue, 23
 May 2023 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-6-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-6-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:29:37 +0200
Message-ID: <CAMGffEkhcOZtiQOeoHTyStU8ba7n2QbC9eb_MVAixUBkCx8R5A@mail.gmail.com>
Subject: Re: [PATCH 05/10] block/rnbd-srv: defer the allocation of rnbd_io_private
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 9:53=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
> Only allocate priv after session is available.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index c4122e65b36a..b4c880759a52 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -128,20 +128,17 @@ static int process_rdma(struct rnbd_srv_session *sr=
v_sess,
>
>         trace_process_rdma(srv_sess, msg, id, datalen, usrlen);
>
> -       priv =3D kmalloc(sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> -               return -ENOMEM;
> -
>         dev_id =3D le32_to_cpu(msg->device_id);
> -
>         sess_dev =3D rnbd_get_sess_dev(dev_id, srv_sess);
>         if (IS_ERR(sess_dev)) {
>                 pr_err_ratelimited("Got I/O request on session %s for unk=
nown device id %d\n",
>                                    srv_sess->sessname, dev_id);
> -               err =3D -ENOTCONN;
> -               goto err;
> +               return -ENOTCONN;
>         }
>
> +       priv =3D kmalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
before return you have to rnbd_put_sess_dev!
it seems not much benefit with the change.
>         priv->sess_dev =3D sess_dev;
>         priv->id =3D id;
>
> @@ -169,7 +166,6 @@ static int process_rdma(struct rnbd_srv_session *srv_=
sess,
>  bio_put:
>         bio_put(bio);
>         rnbd_put_sess_dev(sess_dev);
> -err:
>         kfree(priv);
>         return err;
>  }
> --
> 2.35.3
>
