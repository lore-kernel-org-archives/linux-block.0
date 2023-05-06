Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051CC7EE24
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 06:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEFGcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjEFGce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 02:32:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AE5A25C
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 23:32:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a34a14a54so515019166b.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683354733; x=1685946733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh+rLv64T/XKdExtopYbn1p2e3mwdhjXoRnI90UeXPc=;
        b=NP44+tFWeUv4sXWs5pM2c9nMpHOr8y6ykXcVI1EnTgV9TBncHoNqcw5rSQlV4SrEAF
         HCH0CBLfw7RfU+1XjqBaz67psEMoZNnWKuBN7ybXk57c8pDvqqiVWaIRoHe39cth2roF
         XwcHPtKNOinbh1L/3h1QjK5eDn2soCGW2YF2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354733; x=1685946733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh+rLv64T/XKdExtopYbn1p2e3mwdhjXoRnI90UeXPc=;
        b=Wt95xQ5TwkfisZqakk3PBP6kJTKcNAli+aR6zqfginHTv0ItZjXFfZ8lAIZG3cRhgP
         LPWsTuI2Mm/alz8a5SJtjj0XyCihYFFfT7mHA8GDfASQKv5PR6cvY3x+ERHgdYBsYevh
         cqJ9UZ2/Do6Fny0bhGJYll5ycIpCO0RVHZatgyHFmrG3pzjhTYv6XuW+8OQFP36No6BI
         7tum9L0W7Oyzr+UPSeyKAMOTVQGodC+ukVM5z1JP2H4eIdAw1D5SmNeRq0JNPLLRZFrU
         Wt487zXlzZgWB7iFrdj0St9Zwn62PZCU2SxTVR/yLCBnscvQ6TXjPr/fQ0GAvxlmLAhl
         9EPQ==
X-Gm-Message-State: AC+VfDy/+RCM/fgqWTTMQ3bu0bGGLaLqXpOGqiIRJjFcIL6kCpwWjz2h
        RzWIvPhWB51uUjd9aIds0HjVd+cFhd6jHNtr/AZJIw==
X-Google-Smtp-Source: ACHHUZ49lLaiO0buFBePac28VZVZZ5J4y63mNd4+sXRBHhN0wwrJ6PD3jFK0pFSF8IgYJk2lmVOifSuBIwb8CLlZkRk=
X-Received: by 2002:a17:907:9605:b0:93e:fa12:aa1a with SMTP id
 gb5-20020a170907960500b0093efa12aa1amr3601469ejc.1.1683354733732; Fri, 05 May
 2023 23:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org> <20230420004850.297045-5-sarthakkukreti@chromium.org>
 <ZFAP5yQ0mwE4F6Vg@redhat.com>
In-Reply-To: <ZFAP5yQ0mwE4F6Vg@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 5 May 2023 23:32:02 -0700
Message-ID: <CAG9=OMNh8w9hmkU6ZHBm8bN0NGCL4NaKv7XAEQrFvTKKNcXLLg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dm-thin: Add REQ_OP_PROVISION support
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, ejt@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 1, 2023 at 12:15=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Wed, Apr 19 2023 at  8:48P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > is not set, dm-thin will opt to zero out the entire range as a part
> > of provisioning.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-thin.c | 73 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 68 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 2b13c949bd72..58d633f5c928 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -1891,7 +1893,8 @@ static void process_shared_bio(struct thin_c *tc,=
 struct bio *bio,
> >
> >       if (bio_data_dir(bio) =3D=3D WRITE && bio->bi_iter.bi_size) {
> >               break_sharing(tc, bio, block, &key, lookup_result, data_c=
ell);
> > -             cell_defer_no_holder(tc, virt_cell);
> > +             if (bio_op(bio) !=3D REQ_OP_PROVISION)
> > +                     cell_defer_no_holder(tc, virt_cell);
>
> Can you please explain why cell_defer_no_holder() is skipped for REQ_OP_P=
ROVISION here?
>
I recalled seeing a BUG in dm-prison-v1 if I allowed
cell_defer_no_holder() for REQ_OP_PROVISION, but from additional
testing, it looks like it was left behind from a cleanup in v4.
Dropped in v6.

Thanks
Sarthak

> Thanks,
> Mike
