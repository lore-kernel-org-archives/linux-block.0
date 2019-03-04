Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD0C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0E20863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="fNjQvoAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfCDJfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:35:19 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36127 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDJfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:35:19 -0500
Received: by mail-ua1-f66.google.com with SMTP id e15so3816581uam.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EmlSrwdGIDFF1K3WJOeV85eO7B12tRefAchlfDhbVjE=;
        b=fNjQvoAmS9Kc2zDCHY2jFRLxu7M4RUjqUokz0TANoM4jiCo7F5nD8RC46HhBMThlQV
         pPfiobUvv682MAh14nse8poAMipr1QvZc9Z6Bl7928vAOT8+/bu9YzoWvwCWxEiLUBE2
         bghjvNSpBAPvf8FcurVVbVURfx5kqo5xsMMHNFMnJjGjFQrOG/oCuJzHsRW9fSRKzpCr
         Iqtk0e5KdahAthTE1aeFJsCRPGFagunhgF8N3NB5w6XHJSx8ITxxOiLIzRr0eYiiE1om
         hlNVBMdgZ6eHzIXvObFqB+/h4T8HBlOp7qcpc2Z8l93p+X6TT+muRKfDKbYLQ/n9X0OL
         Pzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EmlSrwdGIDFF1K3WJOeV85eO7B12tRefAchlfDhbVjE=;
        b=T6yDPUOIPdS+WCpgNsB38uMofeeFrIDwmEIxQjAAqDgkYQQROXcP7URxWb4qz6wxl7
         0bBv/oCaZRid0uRNb7CtmOQOEZyXLyYqbHpAoUbzFnmarMTc3gzLaom0aYQZOAYK5kV0
         +zcxdqSPKan3HrkCa6fQ84kFjW8EabhJQCaozf62Xi5n8DTdIEN8fBulZ9RJuBhRpYWG
         LhAwM/HWppf+e4D/VlL6vUdrnFUsMyXfLKZtXT234BiJ//a4z33xjaL1UryGZW+vG1yl
         PLZkFALj/CRGj0gnqIwu46KmAiS5SbN7MymCU6udP1e+K7HDYnJRMrknKy/djvSdjzLK
         WrHA==
X-Gm-Message-State: APjAAAUJsiF5KaxuxU7MbhlAK19d1ctN+CvzGIdoNWTAB4UhiD4heW30
        WfReAJhxjNkFDZWUxyMusWREqt2SUiES6PxWmWeFwksDB08=
X-Google-Smtp-Source: APXvYqxe3hYlk7njxdmZIPlXMtGC5SfybRe5YEnjPOSUjgVgdWByfX0VesQ+7by4v6DzhHk9pv6A1pTxQxLzE0xhOZU=
X-Received: by 2002:a67:f744:: with SMTP id w4mr9470909vso.16.1551692118080;
 Mon, 04 Mar 2019 01:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com> <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
In-Reply-To: <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 10:35:07 +0100
Message-ID: <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Currently in case of read errors, bi_status is not
> > set properly which leads to returning inproper data
> > to higher layer. This patch fix that by setting proper
> > status in case of read errors
> >
> > Patch also removes unnecessary warn_once(), which does
> > not make sense in that place, since user bio is not used
> > for interation with drive and thus bi_status will not be
> > set here.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-read.c | 11 +++++------
> > 1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.=
c
> > index 3789185144da..39c1d6ccaedb 100644
> > --- a/drivers/lightnvm/pblk-read.c
> > +++ b/drivers/lightnvm/pblk-read.c
> > @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pbl=
k, struct nvm_rq *rqd,
> >       WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random request\n"=
);
> > }
> >
> > -static void pblk_end_user_read(struct bio *bio)
> > +static void pblk_end_user_read(struct bio *bio, int error)
> > {
> > -#ifdef CONFIG_NVM_PBLK_DEBUG
> > -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
> > -#endif
> > +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
> > +             bio_io_error(bio);
> >       bio_endio(bio);
> > }
> >
> > @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
> >       struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >       struct bio *bio =3D (struct bio *)r_ctx->private;
> >
> > -     pblk_end_user_read(bio);
> > +     pblk_end_user_read(bio, rqd->error);
> >       __pblk_end_io_read(pblk, rqd, true);
> > }
> >
> > @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rq=
d)
> >       rqd->bio =3D NULL;
> >       rqd->nr_ppas =3D nr_secs;
> >
> > -     bio_endio(bio);
> > +     pblk_end_user_read(bio, rqd->error);
> >       __pblk_end_io_read(pblk, rqd, false);
> > }
> >
> > --
> > 2.17.1
>
> This is by design. We do not report the read errors as in any other
> block device - this is why we clone the read bio.

Could you elaborate on why not reporting read errors is a good thing in pbl=
k?

>
> If you want to remove the WARN_ONCE, it is fine by me - it helped in the
> past to debug the read path as when one read failed we go a storm of
> them. Now we have better controller tools to debug this, so if nobody
> else wants it there, let=E2=80=99s remove it.
>
> Javier
