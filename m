Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C01DC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEWJcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWJcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:32:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977F102
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:32:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f6e83e12fso669845166b.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834307; x=1687426307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRHTMTxKgqhqtxlEyX96ixb2A6QEbaJZP1nHp8ykdQg=;
        b=Ro62uBAb/x6ARNJLey8VOA+DKvzUtcMpSltlZscm3bBgNBkfkn6N8XbxSLiRlrBkDf
         ZgoxechuUTPSoAadqdU8YTfk94azsHV8mz2Dj0/OdpYtCWdnjGWNukhCZ1F99z0GXvFS
         yox4m5i53BMJje9ALR5LWbx2P/xdAPgHlLqNQRdrFtYgl4X/qsAMGIKo59BWWUXDQgfj
         u4zcW2nDm6A3XipXIt2tK4/Oue6ZMPg2BE1SvrKP+6QmXqnHXERooa1dBtySjkAH1FfI
         uvjg+4ak+0g8BxCIh4cyUsnNJN4XZKlwM1c4ZeuapZMiKLeUjpqtetZD5yhlT/19B8Dy
         RJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834307; x=1687426307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRHTMTxKgqhqtxlEyX96ixb2A6QEbaJZP1nHp8ykdQg=;
        b=AHF509d5RS7to2pEE7bV8Z0H4p8JiEebm+CsIAKHDJO9kZKPr4WiFZTtgrS9KtRVef
         WmdF4wQc10L2BekUGhbL8mI61z2uS7ppvsjZh5QBmpqmL6hHkwAEStR6cDTqy2StfQwN
         2J39Fev15gT/v7LGL3rj//2xYKj3BeDbA0gdFuofyGi+4T2MTcoKKJkissupjcP5JOSg
         BxyaIVUPNUP93M00baQnYLbnFVatMsSNAXebbeoQHcO1992i55gRICqRdNZxecffBlbI
         o2oyRmAfWbak2HiP3X4w0WwiKiUQDa5LXtPk63f1l/DgMGhPPmHmypCwUBGSTg9zAyuX
         z/xw==
X-Gm-Message-State: AC+VfDy5PUQ+7z4qKjx27wqy96oFwj6Nqd8/03uYwRXJV+byJkx6YkPD
        w/sjegmPV8i1kzl1dO6Rd8nbaBSauVY9RiRzNAzIsg==
X-Google-Smtp-Source: ACHHUZ7NKmP9GzonoV5jeMTkx1TGy9cFegEcKq2VKeSPejSBlsw1W4hEnAnGGjHW4WEAv94VihGo1msVifH/tX15gSM=
X-Received: by 2002:a17:907:9449:b0:969:cbf4:98fa with SMTP id
 dl9-20020a170907944900b00969cbf498famr12432997ejc.65.1684834307654; Tue, 23
 May 2023 02:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-9-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-9-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:31:37 +0200
Message-ID: <CAMGffEmMNMjK_t0gOsKphKYwVJXKKabiLqWL-DZrcqrfKd++CQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] block/rnbd-srv: init err earlier in rnbd_srv_init_module
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
> With this, we can remove several lines of code.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 102831c302fc..1fdf3366135a 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -803,7 +803,7 @@ static struct rtrs_srv_ctx *rtrs_ctx;
>  static struct rtrs_srv_ops rtrs_ops;
>  static int __init rnbd_srv_init_module(void)
>  {
> -       int err;
> +       int err =3D 0;
>
>         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) !=3D 4);
>         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) !=3D 36);
> @@ -817,19 +817,17 @@ static int __init rnbd_srv_init_module(void)
>         };
>         rtrs_ctx =3D rtrs_srv_open(&rtrs_ops, port_nr);
>         if (IS_ERR(rtrs_ctx)) {
> -               err =3D PTR_ERR(rtrs_ctx);
>                 pr_err("rtrs_srv_open(), err: %d\n", err);
> -               return err;
> +               return PTR_ERR(rtrs_ctx);
>         }
>
>         err =3D rnbd_srv_create_sysfs_files();
>         if (err) {
>                 pr_err("rnbd_srv_create_sysfs_files(), err: %d\n", err);
>                 rtrs_srv_close(rtrs_ctx);
> -               return err;
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static void __exit rnbd_srv_cleanup_module(void)
> --
> 2.35.3
>
