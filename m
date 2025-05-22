Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894DA50
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875077; cv=none; b=aNQmJZzBwHido7rtYCLcFGoPLZ7L7FD8p777cvs3nIddvfPZR1any4+SZrsaJXWVePCdV5WrnWZNlXawcTEtRUOqvU6HvybmOQA1dvX/0bFAS1FSP1JqGqjiNTcfr5nDXY0RUjSdaLU0TZqiO1F9euii+4GCAlCxDHMErLfkFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875077; c=relaxed/simple;
	bh=UerXj1CO3lDYlt8t8YmsP5ALp6SHO6hU0jb8Cbd48qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhsadH/OgAUfnjXu50wbQCxpy1j7n9QIPLPwYR3D/LMtw0dqUqMGN4e0nMA1UO6bwDgF8fgRq9TcXxM6r1dlJWUqncG/1YluwqRXw4EvxWzYL/dREq8IK/UinYdjzwL2mbrRq4QT6boJIqvx8uGtXnUeewfEMfiYycPR5SCrPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ey25tM/N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ey25tM/N"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-308218fed40so567082a91.0
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747875075; x=1748479875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG+6aGCdgjc3eMqVLziW0Hb1LJdrswmRlFxe97FuFQE=;
        b=ey25tM/NvFXfqv9RqTGOW0+L8Krt6wlZEoXRRt+TVdZ/XiCa4gBw7KiR3INpNWpF7W
         TPIR9P9iloiqOp8HqYxQQQByRGlxi+hD0AUwhKP/8ZdsfIcrJDT42Kq2Ofw47b2KfVWd
         81x70iNo6UpvtVGd+OMAp65dqOsT1FtlLIZhEM6yfmfKRzvwrSgSQy+n35/tfNPCRhUa
         h5lJFpZpUiVxaShRjXuFG7bWSuylEcUFf8NsrXVT8dznTT18HQfM6IMtYmeQBvMMvbLK
         m8S9TqhFNyuEvxCdSqmAaOE3+tgyCWOw5QkrzFYMEzQ7wlVp9MQFlC4/swzvnM18GoBD
         m8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747875075; x=1748479875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG+6aGCdgjc3eMqVLziW0Hb1LJdrswmRlFxe97FuFQE=;
        b=Geq/W0kawVPWRgeC9p6xgKc+SCvT8RuKbHUQjjWLSxeFk4Ons8p7+uA7Aa7X0XfukT
         Dwdu+zcajgIdyfyt4z0/m72hbzcAv35UOPaBl0ArB/PH4PbeAIgfm/s42V7HHwOdKLjk
         LEGgeNhBm6/IvjOvLQuE7cVLVp+pNQS2wW1qo+6VyMZBpNZDbiWjPXhfqy+EM8b3L+vy
         MWlvjzNCKywIHoc0GCR3kZfudOSKdwx5O+vY3peECbMGxtgLjsxG16FgwVPJlfb17Jk+
         h7C3nmwizilwQzCCqowRM1SDoZV/8nmX5lafGgcuxtA3aGLhmzrQBhmCStPZTejNdJYU
         z2MQ==
X-Gm-Message-State: AOJu0YxsJWJhYWtB4uasYdq9x7AFMAxxM/Ww4WB5jaMG/XH30xZuu70Y
	jzxSPFkJiwPhk5kwxpQ8TUcyPtvgg9Ih4ftmLr9wHMTZ5ffmq/EjXa4F0WCOc8K2N+EC5NvRZeI
	CJNykUWrjn0smlHfa+V61SIO462RykI3/xnqhRAIP7yl5gBxtNVpaW0A=
X-Gm-Gg: ASbGncv41IFQ7WwMgmpCvFhZxGFsg69oGVt4gAJTU9uQ5JGDcsT9ZbwNPpLLGIvPwiH
	iBD8QipnQ9pDw6RRnVE3H3CeIyrue2H/+GOzsLfpez9Q4U55mRVTekrIdZaEXKBHTtOQ6T8DRhP
	ageM4/isBoCu4DiE3QA0VT61CxRKCtYgE=
X-Google-Smtp-Source: AGHT+IE8KQ0pBaWIeM5RZZMuIPd3ZaANbtrHqYHKbNjtw97yc6uUPYF3UaMGKq2Xbzamen9e/r9yZwYNyIz8jOSGgaY=
X-Received: by 2002:a17:903:3316:b0:231:e331:b7d0 with SMTP id
 d9443c01a7336-231e331bb9cmr90635705ad.10.1747875074726; Wed, 21 May 2025
 17:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
In-Reply-To: <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 17:51:03 -0700
X-Gm-Features: AX0GCFudnwvn_Udgiur8069Jmsj9xowix4SDZDAHPqTd0gHgQT3ZpP6zXJP2fH8
Message-ID: <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:47=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, May 21, 2025 at 3:31=E2=80=AFPM Keith Busch <kbusch@meta.com> wro=
te:
> >
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Register the nvme namespace copy capablities with the request_queue
>
> nit: "capabilities"
>
> > limits and implement support for the REQ_OP_COPY operation.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f69a232a000ac..3134fe85b1abc 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme=
_ns *ns, struct request *req,
> >         return BLK_STS_OK;
> >  }
> >
> > +static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
> > +               struct request *req, struct nvme_command *cmnd)
> > +{
> > +       struct nvme_copy_range *range;
> > +       struct req_iterator iter;
> > +       struct bio_vec bvec;
> > +       u16 control =3D 0;
> > +       int i =3D 0;
>
> Make this unsigned to avoid sign extension when used as an index?
>
> > +
> > +       static const size_t alloc_size =3D sizeof(*range) * NVME_COPY_M=
AX_RANGES;
> > +
> > +       if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >=3D NVME_COPY_MA=
X_RANGES))
>
> Should be > instead of >=3D?
>
> > +               return BLK_STS_IOERR;
> > +
> > +       range =3D kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
> > +       if (!range)
> > +               return BLK_STS_RESOURCE;
> > +
> > +       if (req->cmd_flags & REQ_FUA)
> > +               control |=3D NVME_RW_FUA;
> > +       if (req->cmd_flags & REQ_FAILFAST_DEV)
> > +               control |=3D NVME_RW_LR;
> > +
> > +       rq_for_each_copy_bvec(bvec, req, iter) {
> > +               u64 slba =3D nvme_sect_to_lba(ns->head, bvec.bv_sector)=
;
> > +               u64 nlb =3D nvme_sect_to_lba(ns->head, bvec.bv_sectors)=
 - 1;
> > +
> > +               range[i].slba =3D cpu_to_le64(slba);
> > +               range[i].nlb =3D cpu_to_le16(nlb);
> > +               i++;
> > +       }
> > +
> > +       memset(cmnd, 0, sizeof(*cmnd));
> > +       cmnd->copy.opcode =3D nvme_cmd_copy;
> > +       cmnd->copy.nsid =3D cpu_to_le32(ns->head->ns_id);
> > +       cmnd->copy.nr_range =3D i - 1;
> > +       cmnd->copy.sdlba =3D cpu_to_le64(nvme_sect_to_lba(ns->head,
> > +                                               blk_rq_pos(req)));
> > +       cmnd->copy.control =3D cpu_to_le16(control);
> > +
> > +       bvec_set_virt(&req->special_vec, range, alloc_size);
>
> alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> amount of data used by the Copy command, which not all controllers
> support (see bit LLDTS of SGLS in the Identify Controller data
> structure). We have seen the same behavior with Dataset Management
> (always specifying 4 KB of data), which also passes the maximum size
> of the allocation to bvec_set_virt().

I see that was added in commit 530436c45ef2e ("nvme: Discard
workaround for non-conformant devices"). I would rather wait for
evidence of non-conformant devices supporting Copy before implementing
the same spec-noncompliant workaround. It could be a quirk if
necessary.

Best,
Caleb
