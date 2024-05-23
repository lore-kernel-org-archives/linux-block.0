Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5B10A14
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477788; cv=none; b=BURcGLFktB+cLXDO91annrhJAxWCmqyOpKO+NiFxxww2WiLr6w0YULi1cq4NKwtf7DcII0fsr5hpOJDUe5zMrBDp9Rj67BTTNoihVfQSb9mXz9BP7jlnBBf/dvU5ZwmClZHg3BHRKLLm/0tO1MlitzXdkMOTiJr/RxS5KJWtil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477788; c=relaxed/simple;
	bh=tPUeEnU5cjG3i0yzJnK9h4CPPvHzW2y3ucRopOeOZR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGMCgF9GHRR2Izx+rv0pxLkx8pWiSwbR6ugeK741jsFyfivZBF7hNeyMBsBOPLIMqYnJ9idc4tvFkaZBm5gZDvqptsqxMDT5U2D8GpMWn8JN2uQlkjvV2m/pynL1qcCGeLoXfUhf0FE66JByK6BkHW8NNiwDOukYczxPrSLs9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BREKqrQ6; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BREKqrQ6"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8030f814a15so664067241.1
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716477786; x=1717082586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8tCGD+B/90fiwr0wHpk4PrsZCbhBjOEiTIub+soBMc=;
        b=BREKqrQ6T2lDxxClbOURvV3ZeKJ5J5EBtA10ZfBBqk9+JudJGvrBJJN8bafMDmyynN
         PTQ46tp+ZE0SuAB6N0YCEY8QdE6tLrqenQsMvrk8kLs5JkYA1b99tOZLiz/CLasohc27
         0XGhYxqpDToQFqVwt5j9MQhjAcebVFWVC0gZlch5qirtCLajgfZ1TwxqrGjJPM5Vz+C7
         9ns9PB2CsT7ycLaufZbwDTNfWHPxxsx0kBhNRzSk6fW4VCOxqpKvChjrnYSX/k7OLj7S
         4oZbLuonAA63bhKNDv3Ert7swbj/jHms0th7fAGXg+QCmLhQz6reDVYbGfEDA++NiG8D
         4ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477786; x=1717082586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8tCGD+B/90fiwr0wHpk4PrsZCbhBjOEiTIub+soBMc=;
        b=XVGY2rG8XGQNGUJ5SbxvtO2c0KanYMu7lsUiTLLRFMVDCCT7fDhyAFuZdkZmcrRw0W
         4nRpmSVmFNe7+6gf5C8aB98O0qFMG2Ilp05gLevoTqBydvTxsdYD6RBuZC7gCi7gXqWd
         gLt78XO2rk/4KNu8S+g1o48+9KIokQyMu4nRioA+t9mCnf7NBUrOuuXxy97muDRS4/9J
         Szr8tHPP+szPKEGUvu0VAsiKqan0iwNfDdHj5C76EbJd85U9qu+eHeKAuKTs2Xc05T+3
         aTFSXVN+/tLukicloYveGyzIoYe0FmtGXRqONm5J3TExNKlCuFBmQ2n/BZlgyeyHDu18
         DsJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXf1HT+Ak8UwEzNohfdSOiCUxVsar68WW88DEAe4Lc+GVO3oWVP/q7+/A8Fa/hRpge+ghingJ//kuP5OluzbOaMUDsddhAzUSdgto=
X-Gm-Message-State: AOJu0YxwvB7gelMAK2m8Bq3JkTRMG4/bUZzjStRkxeR2FirYe2o+5sL/
	YOsFNe36hki0qTfLJ+28GbYWoDPfSV8oDqJrLKyVxAuuoHEQ63QH9ElIbrc11NL0qM+slP3jI4u
	qxYr441LRgdhZjzUyqQ4ItWdNKg==
X-Google-Smtp-Source: AGHT+IHf+AmqHylb4UCzV6cCGGq50XriQJFqc3S13bgCKMdOxy9ZuTsPeUtcuE77AHyQWp9HPWeABRGMmoFgFZvcQWY=
X-Received: by 2002:a05:6122:208a:b0:4bd:32c9:acb with SMTP id
 71dfb90a1353d-4e218524df6mr5691819e0c.7.1716477786039; Thu, 23 May 2024
 08:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com> <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
In-Reply-To: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 23 May 2024 20:52:28 +0530
Message-ID: <CACzX3As928NhtJdNGii16Jeuix3RfzRZbgr4ZSv9p+Pi6FiNvA@mail.gmail.com>
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:41=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
>
>
> On Thu, 23 May 2024, Jens Axboe wrote:
>
> > On 5/23/24 8:58 AM, Mikulas Patocka wrote:
>
> > > Here I'm resending the patch with the function rq_integrity_vec remov=
ed if
> > > CONFIG_BLK_DEV_INTEGRITY is not defined.
> >
> > That looks better - but can you please just post a full new series,
> > that's a lot easier to deal with and look at than adding a v2 of one
> > patch in the thread.
>
> OK, I'll post both patches.
>
> > > @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> > >                     goto out_free_cmd;
> > >     }
> > >
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > >     if (blk_integrity_rq(req)) {
> > >             ret =3D nvme_map_metadata(dev, req, &iod->cmd);
> > >             if (ret)
> > >                     goto out_unmap_data;
> > >     }
> > > +#endif
> >
> >       if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)=
) {
> >
> > ?
>
> That wouldn't work, because the calls to rq_integrity_vec need to be
> eliminated by the preprocessor.
>
> Should I change rq_integrity_vec to this? Then, we could get rid of the
> ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> static inline struct bio_vec rq_integrity_vec(struct request *rq)
> {
>         struct bio_vec bv =3D { };
>         return bv;
> }

This can be reduced to
return (struct bio_vec){ };

>
> > > @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
> > >     struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
> > >     struct nvme_dev *dev =3D nvmeq->dev;
> > >
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > >     if (blk_integrity_rq(req)) {
> > >             struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> >
> > Ditto
> >
> > > Index: linux-2.6/include/linux/blk-integrity.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.orig/include/linux/blk-integrity.h
> > > +++ linux-2.6/include/linux/blk-integrity.h
> > > @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
> > >   * Return the first bvec that contains integrity data.  Only drivers=
 that are
> > >   * limited to a single integrity segment should use this helper.
> > >   */
> > > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> > >  {
> > > -   if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > > -           return NULL;
> > > -   return rq->bio->bi_integrity->bip_vec;
> > > +   WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> > > +   return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > > +                            rq->bio->bi_integrity->bip_iter);
> > >  }
> >
> > Not clear why the return on integrity segments > 1 is removed?
>
> Because we can't return NULL. But I can leave it there, print a warning
> and return the first vector.
>
> Mikulas
>
> > --
> > Jens Axboe
> >
>
>

--
Anuj Gupta
