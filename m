Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2845C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEWJbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjEWJbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:31:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7DF94
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:31:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fdc081cb3so351824566b.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834261; x=1687426261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqephx2VJND73mFAxCRE2QU7Sh/HUprdV2dKCS1tbP0=;
        b=NjTxQCtFOnvVf5hPEO9XDgsNlkoBRV8CbT/3yjliaIJbRKzpNgxYxnIViwHZpadQI6
         smODJgDYri2v/nllMLzqCihELk7qEHbGBOntcFqbaDYKjNuXvM107feAiHJDcyTTV6Hf
         EO4Z+9EpZmRMZWnKpBCH9ZLg+1TV/G+75utsh4ott9Vrd5Q6sN9LkhIIYhUjiMlwfeZU
         BSIl/xXuBucbMpUrle6CgGByZYbCibseBWfw/ncWBOsbPQVB2MaC0kiU7Jr5wUsa2EYA
         f5yTXHcQd7t3InyLS21YsuaxghDsB037/yrPuM0vJfOqCu0yS7itunj/Ocd7TXCvcPFE
         ewoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834261; x=1687426261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqephx2VJND73mFAxCRE2QU7Sh/HUprdV2dKCS1tbP0=;
        b=ExlxoSoSVh4GeqamNRoGKn608GtgF3Ucqf5fn6UJkOhQ9ttSMMstm6ARa9vGWru/Gn
         xRLP3Kl9gyao5fEQVnnTZ8pczetTYVFWSpKv3OlXELrmVhg/A3EgMqNFUwueA7Qq/Rkr
         L9EGRM3QVICwOdMGLsi9XEzqOv+xD2BvO8QBdB0ypTbtAHg/9ggGoAkq/7ugNam29s/D
         ThGvw5yN/eRKkSP1OTynaRo6ki01jV1TO25DgJbCnV28aPhf03C/YnqTYj4STfbAVeqw
         5RNlWpPfwmgVymnd5e28PFEHTdBCYoQUCiDVY8vFzDe6VXz0/NxG2z64R9P8lZ6eWs2A
         353A==
X-Gm-Message-State: AC+VfDx25iKYftFrgqt4oGfiVUGDLEYwUKZIIRsSBjgLeHPY4BCfkd8u
        VmXuhl+e169ytXmrk7Uh//7Pweenq8gjtF8bC+Cy0F63Y6k6JTW9
X-Google-Smtp-Source: ACHHUZ7CB7FbvHRcOMBNalEmU+2uoKwkhXlxnq/lfcSnmwpLyjmruaMTrpxmoJrvb4E2jJ6erlmO/3cPATMrAfv/VFM=
X-Received: by 2002:a17:907:d0a:b0:96f:bd84:b8a0 with SMTP id
 gn10-20020a1709070d0a00b0096fbd84b8a0mr8014797ejc.5.1684834261555; Tue, 23
 May 2023 02:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-8-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-8-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:30:50 +0200
Message-ID: <CAMGffEkqJgE-g5Z9_6JZE37=arJpkE4nEs+bERaauVck3399uw@mail.gmail.com>
Subject: Re: [PATCH 07/10] block/rnbd-srv: init ret with 0 instead of -EPERM
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
> Let's always set errno after pr_err which is consistent with
> default case.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index e51eb4b7f6e6..102831c302fc 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -463,34 +463,33 @@ static int rnbd_srv_check_update_open_perm(struct r=
nbd_srv_dev *srv_dev,
>                                             struct rnbd_srv_session *srv_=
sess,
>                                             enum rnbd_access_mode access_=
mode)
>  {
> -       int ret =3D -EPERM;
> +       int ret =3D 0;
>
>         mutex_lock(&srv_dev->lock);
>
>         switch (access_mode) {
>         case RNBD_ACCESS_RO:
> -               ret =3D 0;
>                 break;
>         case RNBD_ACCESS_RW:
>                 if (srv_dev->open_write_cnt =3D=3D 0)  {
>                         srv_dev->open_write_cnt++;
> -                       ret =3D 0;
>                 } else {
>                         pr_err("Mapping device '%s' for session %s with R=
W permissions failed. Device already opened as 'RW' by %d client(s), access=
 mode %s.\n",
>                                srv_dev->name, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
>                                rnbd_access_modes[access_mode].str);
> +                       ret =3D -EPERM;
>                 }
>                 break;
>         case RNBD_ACCESS_MIGRATION:
>                 if (srv_dev->open_write_cnt < 2) {
>                         srv_dev->open_write_cnt++;
> -                       ret =3D 0;
>                 } else {
>                         pr_err("Mapping device '%s' for session %s with m=
igration permissions failed. Device already opened as 'RW' by %d client(s),=
 access mode %s.\n",
>                                srv_dev->name, srv_sess->sessname,
>                                srv_dev->open_write_cnt,
>                                rnbd_access_modes[access_mode].str);
> +                       ret =3D -EPERM;
>                 }
>                 break;
>         default:
> --
> 2.35.3
>
