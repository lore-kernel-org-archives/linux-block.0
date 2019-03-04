Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE2C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24682075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Xi4WdAb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfCDMOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:14:33 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46772 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDMOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:14:33 -0500
Received: by mail-vk1-f196.google.com with SMTP id j68so1061070vke.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kw6yGZWQ0PXaXM2pZJPXRtLvHINAWZMyK0zlAL7pjNM=;
        b=Xi4WdAb99oqB8NNHumaj3EzZXZtxFR1sHzI8RZv8+cEGpHvqujFgUmD5bVYWAXRjYK
         rI/VQhOHOnfSpMwXziZjEkwuNzh4vH+NB7hkqdGHUDsDvqQuLKsFBGUbpNZhdtxWf3xj
         s89OKHI0Tjw5lxHpJ/OvgwxwAZrw087WeY3vfV7wqt8D6/e/imvbAolHR/LrVt0VLZ0s
         Sw5xR/XwnTUpOOAW4ky8R71Vj6pGjGD2Q8iSD0MbzwQ450ArrBnWVxrIxnZaxXYDytDy
         jotx30TTxfN+UOiUjQfODc4K80k5P2+qVFfzujoC5nZ8J76NvKyK1y2oJ2b+yO0WjqRE
         Hx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kw6yGZWQ0PXaXM2pZJPXRtLvHINAWZMyK0zlAL7pjNM=;
        b=mtKRxqYfMQHqjj9buUXvIfW6+RvK4Phw61bFelB8NJ14y+E3gqR7ZPvzlMRsymZvmx
         48Uc6iKkj9Efwmbr3XVzk0Cx/NleKbyuVE6VMCg8qqflqEbVqSTt5AcyJeFfHG9IDV+7
         EmRrefhfRb4SVa2p0U15w6gvI97SB1CZYl18p01xV9IW3UvLxTIGMZrA9OfsnKC4qbhu
         SSKSb9GRZtCZMQQ3CWq0s379t144SU8a5esGPiFDJh5HtfY2HWeiHc/sOovNjBucyDin
         dBOmem1PA12AHMlyvGEOPdyV7om/qJ6jI3eWKRWgiBjK2hjN5VChtZGQQK46fAeUchOJ
         eiFA==
X-Gm-Message-State: APjAAAUSd7vE6JWQfMGAT+RXS9+o0zVh79yjAe7Erfh3/+WGpzYiQuSv
        Z5HHq7k06DkHA08tv5hD1n+Kz01G7Jduhtbvwt62Vw==
X-Google-Smtp-Source: APXvYqyvIPcsf8SxFHaUAJgigw/T9+XtRZ1ghvyVXyucHLCXI+5tJRJlMgm7BkUIEb+m2yrtWICCByzFW9CxwJrESIE=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr9558022vkf.51.1551701671812;
 Mon, 04 Mar 2019 04:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com> <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com> <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
In-Reply-To: <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 13:14:21 +0100
Message-ID: <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
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

On Mon, Mar 4, 2019 at 10:48 AM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
>
>
> > On 4 Mar 2019, at 10.35, Hans Holmberg <hans.ml.holmberg@owltronix.com>=
 wrote:
> >
> > On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
> >>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> >>>
> >>> Currently in case of read errors, bi_status is not
> >>> set properly which leads to returning inproper data
> >>> to higher layer. This patch fix that by setting proper
> >>> status in case of read errors
> >>>
> >>> Patch also removes unnecessary warn_once(), which does
> >>> not make sense in that place, since user bio is not used
> >>> for interation with drive and thus bi_status will not be
> >>> set here.
> >>>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-read.c | 11 +++++------
> >>> 1 file changed, 5 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-rea=
d.c
> >>> index 3789185144da..39c1d6ccaedb 100644
> >>> --- a/drivers/lightnvm/pblk-read.c
> >>> +++ b/drivers/lightnvm/pblk-read.c
> >>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *p=
blk, struct nvm_rq *rqd,
> >>>      WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random request\n=
");
> >>> }
> >>>
> >>> -static void pblk_end_user_read(struct bio *bio)
> >>> +static void pblk_end_user_read(struct bio *bio, int error)
> >>> {
> >>> -#ifdef CONFIG_NVM_PBLK_DEBUG
> >>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
> >>> -#endif
> >>> +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
> >>> +             bio_io_error(bio);
> >>>      bio_endio(bio);
> >>> }
> >>>
> >>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
> >>>      struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >>>      struct bio *bio =3D (struct bio *)r_ctx->private;
> >>>
> >>> -     pblk_end_user_read(bio);
> >>> +     pblk_end_user_read(bio, rqd->error);
> >>>      __pblk_end_io_read(pblk, rqd, true);
> >>> }
> >>>
> >>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *=
rqd)
> >>>      rqd->bio =3D NULL;
> >>>      rqd->nr_ppas =3D nr_secs;
> >>>
> >>> -     bio_endio(bio);
> >>> +     pblk_end_user_read(bio, rqd->error);
> >>>      __pblk_end_io_read(pblk, rqd, false);
> >>> }
> >>>
> >>> --
> >>> 2.17.1
> >>
> >> This is by design. We do not report the read errors as in any other
> >> block device - this is why we clone the read bio.
> >
> > Could you elaborate on why not reporting read errors is a good thing in=
 pblk?
> >
>
> Normal block devices do not report read errors on the completion path
> unless it is a fatal error. This is actually not well understood by the
> upper layers, which tend to assume that the device is completely broken.

So returning bogus data without even a warning is a preferred
solution? You want to force "the upper layers" to do checksumming?

It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
warning that OCSSD 2.0 adds. The data should still be good.
All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates that
the command did not complete (As far as I can tell)


>
> This is a challenge for OCSSD / Denali / Zone devices as there are cases
> where reads can fail. Unfortunately at this point, we need to mask these
> errors and deal with them in the different layers.
>
> For OCSSD currently, we do this in pblk, which I think fits well the
> model as we exposed a normal block device.
>
> Javier
