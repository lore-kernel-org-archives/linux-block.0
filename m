Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E4101F2
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426949; cv=none; b=iSllC7c/Y6huXPM03kfb9CBBoQ1r53bix6Fy2vmvOasvfE3jRmbmzqGZOprIb475iJUF+DqO7X8p6lflidSe67a2iuSTa3w/jWOt/zq1GYJXUHmSkXHUj8qEdM2GRypr+TmFfS095XGeoTxMr9oGaPOHPibXKna7gPfJ2Oxz//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426949; c=relaxed/simple;
	bh=2suqgK1W8gUlcxLA9hRQS6qALHmf1sBJaIvT970O3F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xje2UpvMVD3M05MMAJ8k/J893Bav3kaBPb6QKLRoTX8ktTyB8PlhpGI7iFHYYl2981Wg8mMbGZkynqLlh7kFbFGfXHtelVi64k5Kh88qx2l9GhSXcks54yAmJjjWKVv69PKnW09Gfvv2xLJtuOK4nDUqJm07zmTZJam/2c8mxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L4VTi+N4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L4VTi+N4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403c99457so47375ad.3
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745426947; x=1746031747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZwfhp+zzHnBfk7upRaL6t1a1xHLv6WOztymQ4FMfqk=;
        b=L4VTi+N4XiagMQLYc5CrmrvcY86dAwLxkSiZKGE8BVjWtdP9vMNlq+sBdOCVaNOHVq
         +31whOxbAIhYgFdtxzZe4KFr/vrTcd2OqSOunNaP5ZqCbhU0rsYgBIO1ye906Dxmfxq0
         N5d7poQADkq89TzaCxtbR8vTVdNyjI4ibLAbniTMiENeEO0D+PPEbP0taWfSWQGMDxau
         RWJcfAj2mQYhM738yK4GEXIZmHFRBZ/opEV0PVoK/G0K1tU0HNXXEr9K82GM3CuxsL89
         XkYtxzscEA9BA5blOOOyD5ekp1n+UXIxKcRGy8+JaXkCFNJhRUJV/BUuwoIvJ7sQp1GJ
         A1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426947; x=1746031747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZwfhp+zzHnBfk7upRaL6t1a1xHLv6WOztymQ4FMfqk=;
        b=Ltxrk8OkMNRZussZa4K5EEgW2iAdKAs4DvaFGlGaUYc7xA0QxJZ+h9FskauPNkKuA8
         uBiH3G9nMZOZCvBz59fkfDOj8r3eodmnl7IxdNMkEM3VGd6AQWSWoGP+0HPXSN/TWJ4w
         1M3bIrW/EamHhm4wIdrMgKjD23dwKyi7SK7C8XrvdyUgkZqg9MM279jOub0nSB4GeK74
         FrQM3rkJZ1kmwj7kQtQOV6NtCL9xZiNDxQNP9EIS0gnQI6d2Pb44bCI9NYwycf8OnZmC
         SgrjVYpdw80LUl1VO+Z0GpsH9jxGclT4ryNOHQe7Ecvw1tMrOGJCaa5Z8gvbRKMkKaZ8
         HNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH3ongYm82VUVukDBgZ+CXyFi8pmwwsKyK8bNoMTR8RhEIPiYDtK4jigRFDGKjDDQCze0ELLaes00MSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBbfVvldv/S97Hlw4VmUj6+MuuPDRr/6z5p8NjuzqbA51Hwf2
	7cwfGGiYQ61P9dps7oihsrlGnGjPlpEsKv01EdjKDN3SE48/hLlDWd5Xa5ti8OFp3WF6Z6xhel+
	mga2wsi365BMdN8FkZAQhrfp/47tYN1v0yGcZlw==
X-Gm-Gg: ASbGnctqP146QlWSkQSq9oRb+L38oKO3GOCaOOwwN8aBButmHCpXuCOuVkuwe8BVtJM
	NdWgsGjije/J85tpHGdcUqPB0hopTu3n8N2RDZHP2D6Dd07lDXhjr6J1WJVUf7zaP4+xrR2akWT
	98i4RMKFAaCLZmCwXi+4yd
X-Google-Smtp-Source: AGHT+IE6LVf630G40TZwABQyx9CTrbseW0dZU0GyudrzEPKIFOwfB1mOTTQZyeZqSyvMuPfCGYN20A5B0try4LOmoRU=
X-Received: by 2002:a17:903:8cd:b0:215:b75f:a1d8 with SMTP id
 d9443c01a7336-22da2fe436cmr22376085ad.2.1745426946947; Wed, 23 Apr 2025
 09:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423092405.919195-1-ming.lei@redhat.com> <20250423092405.919195-3-ming.lei@redhat.com>
 <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com> <aAkJrELebhlgX7OZ@fedora>
In-Reply-To: <aAkJrELebhlgX7OZ@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 23 Apr 2025 09:48:55 -0700
X-Gm-Features: ATxdqUFUHyFpqyAtfGHf768R6UvNZSSOjZjGpOu1gWo5vcKoT0OOuVPAgdskTBk
Message-ID: <CADUfDZoUohFbisLOrav35kCbLB0pxi1nFWGaki_fFxxVqU6pew@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
	Ofer Oshri <ofer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Apr 23, 2025 at 08:08:17AM -0700, Caleb Sander Mateos wrote:
> > On Wed, Apr 23, 2025 at 2:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, bu=
t
> > > we may have scheduled task work via io_uring_cmd_complete_in_task() f=
or
> > > dispatching request, then kernel crash can be triggered.
> > >
> > > Fix it by not trying to canceling the command if ublk block request i=
s
> > > coming to this slot.
> > >
> > > Reported-by: Jared Holzman <jholzman@nvidia.com>
> > > Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-2=
3242981ef19@nvidia.com/
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++------
> > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index c4d4be4f6fbd..fbfb5b815c8d 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct blk_m=
q_hw_ctx *hctx,
> > >         if (res !=3D BLK_STS_OK)
> > >                 return res;
> > >
> > > +       /*
> > > +        * Order writing to rq->state in blk_mq_start_request() and
> > > +        * reading ubq->canceling, see comment in ublk_cancel_command=
()
> > > +        * wrt. the pair barrier.
> > > +        */
> > > +       smp_mb();
> >
> > Adding an mfence to every ublk I/O would be really unfortunate. Memory
> > barriers are very expensive in a system with a lot of CPUs. Why can't
>
> I believe perf effect from the little smp_mb() may not be observed, actua=
lly
> there are several main contributions for ublk perf per my last profiling:

I have seen a single mfence instruction in the I/O path account for
multiple percent of the CPU profile in the past. The cost of a fence
scales superlinearly with the number of CPUs, so it can be a real
parallelism bottleneck. I'm not opposed to the memory barrier if it's
truly necessary for correctness, but I would love to consider any
alternatives.

I have been looking at ublk zero-copy CPU profiles recently, and there
the most expensive instructions there are the atomic
reference-counting in ublk_get_req_ref()/ublk_put_req_ref(). I have
some ideas to reduce that overhead.

Best,
Caleb
