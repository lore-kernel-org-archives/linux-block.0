Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05795C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEWJc0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWJcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:32:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B894
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:32:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f6a9131fdso661946966b.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684834343; x=1687426343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZKswzNin6FNsPpmNpdHDc07G0zPvch7la0roTk3qvE=;
        b=hUc2dOORwmR5qVK93QbSAQDN42tRweNKWg3HQ4U0k33Dc8foahSbcbqgQn46im51HE
         J6skEhiO05c7/L/a6NLdD504XUTmEjkKm8+17lzknstT0Bcc4jNUeG/z91fuX6wvP8B8
         nEnuXa8k+6r5LiJ/YCyohiY2FzfId73wH7RMQv68Fzwqngwlry9sKa/wQ1Yu1wVFKmG4
         jI5WYYwlasJ7s6JUFZigO5HRcfWbm7UOHA0ORoXTyI5RioNP/xORKzsXVGTgNOBZoTQQ
         TPmYQPrWoLjsbFsfdyEbWx20vvx/mr6RId7iWGpLfcNRZJb/RIj5pM2tvFSl2MrG4aNK
         fgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834343; x=1687426343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZKswzNin6FNsPpmNpdHDc07G0zPvch7la0roTk3qvE=;
        b=GnEXpuKyU7LR0G3YdA5ME3q6w2zLULARadKo1PiNObuVqdduFHvqE0iFTpxZBBQ+AB
         WnKM02J97RkDveciK66mU3SXHqWpCGBM1jbrBk9iIZD1vwEefqojuflShHebsfWMlQMS
         JXuk4MfkzAIKnetME26VXTPz4R6z0Reog2I0gjq1W2h20Y4JhWxe1l2o1XzA5KDcJcKR
         tOGg/yG7rw4a0HSikxlzIAulbpqV00f02L+Oi329sXof9t3meA5d66H1JOnayxBcUFZk
         6gFHcMNn6bQSwrw67YXKLGGXIvoBhvbUEFuzBHuIjGk0cnzt5B6Y7ArqBWs3tF4R4M9P
         05Bg==
X-Gm-Message-State: AC+VfDxkd8K6AfzjssCZpdQujyr65hkRloIxGVlXzTJ1sWmiQMWx6cn7
        TtrF+T04jzesBsnWhLD8BTjrEqzJ3KY3aMAt6ldxHgAO353+dlmh
X-Google-Smtp-Source: ACHHUZ7gda4qeDfrtCCGI+C3RXZOVwp3HyLVFm3+7LWWh3b8jFGH80Pk84mz8S4GlGhSxJAo65sI+j4oH2KANFFHT/Y=
X-Received: by 2002:a17:906:fe08:b0:94b:cd7c:59f4 with SMTP id
 wy8-20020a170906fe0800b0094bcd7c59f4mr11692183ejb.16.1684834343011; Tue, 23
 May 2023 02:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-10-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-10-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:32:12 +0200
Message-ID: <CAMGffEnCKj+oztV-Jie51ycy-hKpNSvmvWOBmyeCRRL9skxzEA@mail.gmail.com>
Subject: Re: [PATCH 09/10] block/rnbd-srv: make process_msg_sess_info returns void
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
> Change the return type to void given it always returns 0.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 1fdf3366135a..d678ffa50c5c 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -352,7 +352,7 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>                             const void *msg, size_t len,
>                             void *data, size_t datalen);
>
> -static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
> +static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
>                                  const void *msg, size_t len,
>                                  void *data, size_t datalen);
>
> @@ -380,8 +380,7 @@ static int rnbd_srv_rdma_ev(void *priv, struct rtrs_s=
rv_op *id,
>                 ret =3D process_msg_open(srv_sess, usr, usrlen, data, dat=
alen);
>                 break;
>         case RNBD_MSG_SESS_INFO:
> -               ret =3D process_msg_sess_info(srv_sess, usr, usrlen, data=
,
> -                                           datalen);
> +               process_msg_sess_info(srv_sess, usr, usrlen, data, datale=
n);
>                 break;
>         default:
>                 pr_warn("Received unexpected message type %d from session=
 %s\n",
> @@ -626,7 +625,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_s=
ession *srv_sess,
>         return full_path;
>  }
>
> -static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
> +static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
>                                  const void *msg, size_t len,
>                                  void *data, size_t datalen)
>  {
> @@ -639,8 +638,6 @@ static int process_msg_sess_info(struct rnbd_srv_sess=
ion *srv_sess,
>
>         rsp->hdr.type =3D cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
>         rsp->ver =3D srv_sess->ver;
> -
> -       return 0;
>  }
>
>  /**
> --
> 2.35.3
>
