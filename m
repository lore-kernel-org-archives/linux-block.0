Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46575EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGTOcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGTOct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:32:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FC10FC
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:32:48 -0700 (PDT)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4508E3F120
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689863567;
        bh=skqDL74K4vHKIXiEo76fPHTYmTGldqD2uPn8X6eRWMc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q/GFiRV64wQa74OQ110uhJnkFiwZhCqxHFHXm/L56fPePag9TZRzVw1EDVi+hTyYj
         XSDFhC+1uuZD7vfcvx1LgGG48y/6tt+8YejFFf8onwZIybG97xDZ6vn+MiWaXT7b6C
         QD3UHPIvkhKEcfjehGNMdSYPajuJtmT+mH8a86Q3p0M1Ui1uVoKVu4A5/JYl91JBSy
         +2DOOuhfCeZmhIQMveU+2SOARZL/4DYCgKgUYCK+Gt6qeDJM/1YJc6t7DdGuxIXv1r
         1eoO9F2s5HyzXEONgMLI8InPoZuY51C4qXybnX9mYjusyYJjIlZXRuk9yMuKUP0VjI
         dDsS4jqVf3EjA==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb7ea6652bso831738e87.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863566; x=1690468366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skqDL74K4vHKIXiEo76fPHTYmTGldqD2uPn8X6eRWMc=;
        b=Bpj53s7e5ljWqimiSumTxrBHl6Dl/Fm+dIgAk6q5MQJUrxK2HklD6CC2wKcmLW+pUk
         prQss10S0LZJUOMaGcieN1X0k5YHfikkk3JY4cP4oNWClz02HQhIpQ1g9tfFNNMdOvKq
         X8/5FMxLJv/ejedCjH+3EHUA+vV3q3audDK1eiIRKXHguJPjvEzzGsOnXM36ByOwOFcv
         pacNMT/JXKWzw/Va5pfPMsuoXZ9pdaPXXZK0YpJroQNX7CNbZyCNvQfsLatO5s9/+pUA
         Cb0xxbUN4fumQztVm6xq+0DPfBFGfg4Ja8//R4KyDjav2TfwSFHnj/ODdeAnyYLLgJ3d
         z7kg==
X-Gm-Message-State: ABy/qLZifIW/fNHDDpgc9/ctM1MLZ4w6zuhicXL6jp3ToOctoXdz+YbE
        YPkNL+M8z+7L4UApMnGtJ1fvHT88daugDjhlzATRh5YXxN4sR+7emK0xc6L/DVRVuNbGWkF4q9d
        5r4BqYpiDkW5hhCpbORcP7e0PgMMIsQe/Zmgto9HpvvMVexHRWFptffSWZhbV4gyF
X-Received: by 2002:a05:6512:484e:b0:4f9:5ca5:f1a6 with SMTP id ep14-20020a056512484e00b004f95ca5f1a6mr2477570lfb.17.1689863566394;
        Thu, 20 Jul 2023 07:32:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1U8mE1ALyYC/GlgZJ60EOdV466/t3aflM3q+qLEE1T8ut0DjipkVa3Vyfy/WWNHFKesczuUNnANB1F1D1cqk=
X-Received: by 2002:a05:6512:484e:b0:4f9:5ca5:f1a6 with SMTP id
 ep14-20020a056512484e00b004f95ca5f1a6mr2477557lfb.17.1689863566038; Thu, 20
 Jul 2023 07:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230717191628.582363-1-mfo@canonical.com> <20230717191628.582363-2-mfo@canonical.com>
 <ZLjwrNntqIEb7QQe@infradead.org>
In-Reply-To: <ZLjwrNntqIEb7QQe@infradead.org>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 20 Jul 2023 11:32:34 -0300
Message-ID: <CAO9xwp2jevS8bgZQ7Usf+E8D94ezTpTjkCV55cBZCbhhjJmT7Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] loop: deprecate autoloading callback loop_probe()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 20, 2023 at 5:30=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Jul 17, 2023 at 04:16:27PM -0300, Mauricio Faria de Oliveira wrot=
e:
> > The 'probe' callback in __register_blkdev() is only used
> > under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard.
> >
> > The loop_probe() function is only used for that callback,
> > so guard it too, accordingly.
> >
> > See commit fbdee71bb5d8 ("block: deprecate autoloading based on dev_t")=
.
> >
> > Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> > ---
> >  drivers/block/loop.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 37511d2b2caf..7268ff71c92c 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2093,6 +2093,7 @@ static void loop_remove(struct loop_device *lo)
> >       put_disk(lo->lo_disk);
> >  }
> >
> > +#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
> >  static void loop_probe(dev_t dev)
> >  {
> >       int idx =3D MINOR(dev) >> part_shift;
> > @@ -2101,6 +2102,7 @@ static void loop_probe(dev_t dev)
> >               return;
> >       loop_add(idx);
> >  }
> > +#endif
>
> Turn this into..
>
> #else
> #define loop_probe      NULL
> #endif /* !CONFIG_BLOCK_LEGACY_AUTOLOAD */
>
> and you can skip the pretty ugly second hunk.
>

Thanks for reviewing and the suggestion; just sent v2.


--
Mauricio Faria de Oliveira
