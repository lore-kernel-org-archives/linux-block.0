Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35332C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjEWJ1p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjEWJ1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:27:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB6C120
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:27:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510b7b6ef59so1209767a12.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834056; x=1687426056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L53/9VLO33f3ddIL/bSVSBLmCZsvLRdmANtBY1Bnz6Q=;
        b=GdEBqPluU31XmO4giKXLucZTehyTrGdQUnthFEYNFFiHmZZTQIsvjMCt8L3DdQ/mPR
         AKQ6YmdZCTw4/Mg7Uy9x6ZkeTowW5qjKf4ui/IIS3LcPYQad22FVYV6ygoN6tgXhJ2rc
         qrATn+ols9GoQB+jkRjrgfPu+BnCVdb73kUpzEvmPC2Lf+1FsY/ntd1QJFRq67Wm1o0C
         3Zj35K84J/1z6Jax5A60QLhG2BGzdHM/WrEAblp+D5SylIO6KBG3qLXK8hLKoTteNhlR
         PfaQQts9DSDhM4shG2aqaJugoHNo6siwPsCuTP9xUXRbHhXnDS80d7cibpsdjuhm1oCw
         UzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834056; x=1687426056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L53/9VLO33f3ddIL/bSVSBLmCZsvLRdmANtBY1Bnz6Q=;
        b=Z7f/cte0DfL/3eVi793gdh8TUVx3/phReosRyaXVgSxcJg1jBImGT5aycI9UdpmHwa
         k/l2NJYwjjD/RUg0fdBk1CH8fM1MYdm71/ZAk5kW8MmODon8FogV1QEVLJoKDwNfsNEr
         oSPnGjc9AfDHFA6EvisgNcCn7zgaqWuGJroKxuovGTr/ydvQNbsj5rYpHQDwdIZJbW+6
         YRniXYSe0Is5MZQFoDeRuqHVJ5kltaIbjVKWPa9zn/lkqr0eJPAY5lALuYnu4Y8HreW5
         urVFUFM2pmnryNVFVhxkH0LQdUQKwGd0lzIQkMo7I5k6IWfoQxzCd/tO+MCuDObZEbr1
         eypw==
X-Gm-Message-State: AC+VfDxdUrmJpj77fYrvw/O8Z7P1LKzr50XDysXN6p0Lf5cKbZt2YPXe
        VU5ayL/jmdr74RWg2dNiGZM1DLK2/n/TzKFT6nGiDnjdSTMhcRLO
X-Google-Smtp-Source: ACHHUZ5EV7wrG7czARhRbzOusiSZ5XN+B5/kpBM2gNCakuzZdBrrItIMOrkSnwprgQO4oqLVhp0a1KtftTplS4hEDwI=
X-Received: by 2002:a17:907:c14:b0:969:e304:7a22 with SMTP id
 ga20-20020a1709070c1400b00969e3047a22mr16015534ejc.18.1684834056107; Tue, 23
 May 2023 02:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-5-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-5-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:27:25 +0200
Message-ID: <CAMGffEkw=A=WSSgW4ReCMV9h0TCOSWYLEqSUZPf3bfNgTXTp3g@mail.gmail.com>
Subject: Re: [PATCH 04/10] block/rnbd-srv: no need to check sess_dev
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
> Check ret is enough since if sess_dev is NULL which also
> implies ret should be 0.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index e9ef6bd4b50c..c4122e65b36a 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -96,7 +96,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *=
srv_sess)
>                 ret =3D kref_get_unless_zero(&sess_dev->kref);
>         rcu_read_unlock();
>
> -       if (!sess_dev || !ret)
> +       if (!ret)
>                 return ERR_PTR(-ENXIO);
>
>         return sess_dev;
> --
> 2.35.3

This looks wrong, if you drop the check for !sess_dev, you have to
check it later with IS_ERR_OR_NULL when call rnbd_get_sess_dev
