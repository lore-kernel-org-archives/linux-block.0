Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123FEC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A2F204FD
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Gm8Wbu1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHRGmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHRGmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 02:42:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58FC061389
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 23:42:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so20758541ejb.0
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=775qzk5G3HfBeCtXoCDJAjllre8IaZ3OdmJ8ASXAorY=;
        b=Gm8Wbu1x1AJcq/l7haOdWUzinyv1kkATVYdGzJWyJQcZjzKNYg1Ceoc7QamWOiRX91
         j/0Sna8XVp4tdn3iu0VN64uLGFwDrkD3QyXv9eZ+cvhtwJGdHLnG5sP27MCf6vnanRrq
         5gnGGadcbWftINqgeB95FzjqX5kuYAs7PEACIhPN/F/J2f4kgkikmv5cyozGJsszhohH
         9O1W9tcIdbx9BGbUE2adtJU/UP1+pYh5KX3jEF0vfHx9kmvKlFX3DvRXlbKtEJmKdNj5
         x2iWTQveL9Vd8HlmozC5wtt3jHEijtH03aRcL2YumKTKbtJMjHfCk1hUFhrsB1zer9ns
         QmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=775qzk5G3HfBeCtXoCDJAjllre8IaZ3OdmJ8ASXAorY=;
        b=i0o+n3B5SdvC1/zuPYZZEgLnECQXq4BPRXt6aWlixEoBhEYbUSI6OTBuXrRaH+ymKA
         OHY1Jh5IYwokE/6BZrFdudTwCMuDpbAAa6dnAMpSoA04ahmS68NOEopkoZXtzlyVwhy8
         XYEGX8WhSLxo5HXWFpoIpqkhhvxqbFVVCx1wM7LKfWQRn0Vm7AiL7P6DxDFZWyO5adl7
         DYbWXLPPypAgz0rBpOiRcYl4+FrRkKXMrSwt+Nm9NpbqjymMFDhpH2UXfNtV9s8wrXVn
         d0OixQbJOpRlkotlKk6S+/oXUHYfbl2s4Sd6yE982Q6xCAHr63jvynOW5+4b9bsKMdRU
         YBqA==
X-Gm-Message-State: AOAM531YBJgcZss11YbAO3hvlzMgBOv7VguZDoPPivrHU7vKAg+bA89v
        ebCQpPZwcM96M03DOv57Kt6Y/HvBUWdpIk5GSzz1gw==
X-Google-Smtp-Source: ABdhPJy29eOQ86CGzmJWusJHfF6RcNYVtw9fGWL/sowtYAH8GGuqHcmp6fLJD+g3kpf9WgaFKI/wGXU5xQBuJFjMlew=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr18532375ejx.212.1597732938235;
 Mon, 17 Aug 2020 23:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818040317.5926-1-brookebasile@gmail.com> <20200818052957.GA2253299@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200818052957.GA2253299@ubuntu-n2-xlarge-x86>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 18 Aug 2020 08:42:06 +0200
Message-ID: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
Subject: Re: [PATCH] block: rnbd: rnbd-srv: silence uninitialized variable warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Brooke Basile <brookebasile@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 7:30 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 12:03:18AM -0400, Brooke Basile wrote:
> > Clang warns:
> >       drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
> >       uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >               if (IS_ERR(bio)) {
> >               ^~~~~~~~~~~
> >       drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
> >               return err;
> >               ^~~
> >       drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
> >       to silence this warning
> >               int err;
> >                       ^
> >                       = 0
> >
> > Silence this by replacing `err` with `ret`, returning ret = 0 upon
> > success.
> >
> > Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> > ---
> >  drivers/block/rnbd/rnbd-srv.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > index 0fb94843a495..f515d1a048a9 100644
> > --- a/drivers/block/rnbd/rnbd-srv.c
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -123,10 +123,10 @@ static int process_rdma(struct rtrs_srv *sess,
> >       struct rnbd_io_private *priv;
> >       struct rnbd_srv_sess_dev *sess_dev;
> >       u32 dev_id;
> > -     int err;
> >       struct rnbd_dev_blk_io *io;
> >       struct bio *bio;
> >       short prio;
> > +     int ret = 0;
> >
> >       priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> > @@ -138,7 +138,7 @@ static int process_rdma(struct rtrs_srv *sess,
> >       if (IS_ERR(sess_dev)) {
> >               pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
> >                                  srv_sess->sessname, dev_id);
> > -             err = -ENOTCONN;
> > +             ret = -ENOTCONN;
> >               goto err;
> >       }
> >
> > @@ -168,13 +168,13 @@ static int process_rdma(struct rtrs_srv *sess,
> >
> >       submit_bio(bio);
> >
> > -     return 0;
> > +     return ret;
> >
> >  sess_dev_put:
> >       rnbd_put_sess_dev(sess_dev);
> >  err:
> >       kfree(priv);
> > -     return err;
> > +     return ret;
> >  }
> >
> >  static void destroy_device(struct rnbd_srv_dev *dev)
> > --
> > 2.28.0
> >
>
> I don't think this is a proper fix since the root cause of the warning
> appears to be that we are ignoring the return value of
> rnbd_bio_map_kern. Should we not set err to that value like this
> (completely untested)?
>
> Cheers,
> Nathan
Thanks Nathan, thanks Brooke,

I agree with Nathan, the problem is we forgot to set the err before
"goto sess_dev_put".
Nathan's patch is simpler, less code of change.
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 0fb94843a495..1b71cb2a885d 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -148,7 +148,8 @@ static int process_rdma(struct rtrs_srv *sess,
>         /* Generate bio with pages pointing to the rdma buffer */
>         bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
>         if (IS_ERR(bio)) {
> -               rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
> +               err = PTR_ERR(bio);
> +               rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", err);
>                 goto sess_dev_put;
>         }
>
Nathan, could you send a formal patch?

Thanks
