Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207512B94
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542549; cv=none; b=nKwEJY8fdIaH7vXBNoTtJ3oU/7iyoXkr0n7gDjvF3xiu5roNpCOfs6yJY4U0IE/CnGKBxJUB4IVkVnfE9Mpm7/6E9+1Seq1lNRU+ak57HdeUrsPVnEAmRsyMdnMPKPvytZ33Hcb9VFnVylE/17kWSwzpsPl4amyBU0rmy08eUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542549; c=relaxed/simple;
	bh=BPy7/DhowiDuwxE1zr7owRbALGE5rPJkrK2k1Syk3TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/2Rx1LlBU1IFpBkq5Fn6rkF5J3tMZZRU7yIawAAoQRH1WtVMXIWI1We0oxQTLrVVYYExG4QYpULkg5mUJfW2r2e/H2luojlrBaY1EdBF3k/uSi1XGBfZ5Z9NG+oas2C4GLfdDwKA6QhoW+uSm7SwnK0JtFq+fW7SyoYXc1TPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EQW3fw9K; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EQW3fw9K"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso264454a91.1
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745542545; x=1746147345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTlGsC+KMEY9x6NDKFZRtjegHm9ZoTLa6cXUhF3OHiI=;
        b=EQW3fw9KPemPxT2vFrVE4CxNo75/YLljy923sKyfvGlwEuiUMKCMktktDc4i9u7Dzy
         lPpHtaq/pzPPEn7FL/mQThnQflRwJKMeWWv/Hlsb36A9ikvUIStn/Q4QMEEyrFxcTz3D
         wSRJh7nCUUSMOUdcb3IcOROKN1qtYjQwxgbJOh80+zxej5GSqA77ucja6AFEVWrVFy/m
         3gM1vRUA3FyRJY8n7g96sB934b/6L1JHw8ZGpGjGm3sPSKHO61SGyeWit9Z4R5f+p8Ei
         J+4VKDyrIV+dUPWylVTnfWTAxr2InDKgk7fborBatzxwKfe9dGnZhvJMtRLrz0X3SysE
         FiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745542545; x=1746147345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTlGsC+KMEY9x6NDKFZRtjegHm9ZoTLa6cXUhF3OHiI=;
        b=UZNthVQTjhtYvM/EeRKIucdEGCOMo+RlMZ38pJzortYeqZu4kWy9uvx+l03DminQ3f
         rTC4J4Nr4p04F4LAX5guMiCpo4ouHREGuqT0/3WT3JWUKSS+wNWEXnLPCfztHpMOnNMe
         eIp6VN6F0eGTJCPvrhpEiwGzob/fPnw2oQdU3Y1gZ4Al+u8Z9q8msLq7cVeApMOIegSa
         vMwU7+5F7Dx8cymuK2AbSSGDAzQaeykCsLssXptnMvU4rG2yFjmmxSEMTJcylzti+M+D
         w897BIDWsIhwN2pHOvfN5N+8pvPGfPFD/vRlLVYl/CO9ZFt5DQ094qikLfdIoxl8ocep
         UI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF22gyHMcf+L1+1nGJPNngsmxENemjBGJEWyLvKNhfJFWI67gah2Um1ifdWhDP2eRLvs1v6ZXZ4h0Z+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwxPfJay9l3YhuyjxQCkYOY7+/daIZ3UYtFGfCXSgk3/F0R+X
	1YxxSSrY7rJmKi1Lomk6YRDirS6qyl4BOz8iaqIm8NCz3GQOiurJy0y0kW5mVPLAXhMvTbRPbm5
	/xfL1qMiPSpvt7oME6E3b8JxHT5TwtWfGTE7YMA==
X-Gm-Gg: ASbGnctCAyNSmOUuOWmSkRtvqmHGaXjcCEVNvY2h77/EHJGihhNoHeHagRCU4PM7PY5
	aDmDTVQwKxqmzRIDALrhesmu664SHAiCwe9sgdSMLxeg7BDfu2qCAgfjXJCEy1qbppBlkAuzho9
	5UboRiEsovl8IFbQodcALM
X-Google-Smtp-Source: AGHT+IEfRCv9NL5KHwfviIpwrU6fz1vbYMSTJk3ERp1Nph6JTI7BkYRpNTNVQC8lldLmUXXtzBiB31LBy8iGLXVfMTM=
X-Received: by 2002:a17:90b:3ec6:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-309f7e58627mr346300a91.4.1745542545305; Thu, 24 Apr 2025
 17:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423092405.919195-1-ming.lei@redhat.com> <20250423092405.919195-3-ming.lei@redhat.com>
 <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com>
 <aAkJrELebhlgX7OZ@fedora> <CADUfDZoUohFbisLOrav35kCbLB0pxi1nFWGaki_fFxxVqU6pew@mail.gmail.com>
 <aAmYJxaV1-yWEMRo@fedora>
In-Reply-To: <aAmYJxaV1-yWEMRo@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 17:55:34 -0700
X-Gm-Features: ATxdqUFso9igyz7RvMDNu-cj1XfgPXZtwqa-6HuV4XeCVamw2gDR1JCFlDHzrNU
Message-ID: <CADUfDZrAUdmkKLTGYV+jGrbWFYF3Fid1__vWZhE2YzPrURQ6hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
	Ofer Oshri <ofer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 6:47=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Apr 23, 2025 at 09:48:55AM -0700, Caleb Sander Mateos wrote:
> > On Wed, Apr 23, 2025 at 8:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Wed, Apr 23, 2025 at 08:08:17AM -0700, Caleb Sander Mateos wrote:
> > > > On Wed, Apr 23, 2025 at 2:24=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd=
, but
> > > > > we may have scheduled task work via io_uring_cmd_complete_in_task=
() for
> > > > > dispatching request, then kernel crash can be triggered.
> > > > >
> > > > > Fix it by not trying to canceling the command if ublk block reque=
st is
> > > > > coming to this slot.
> > > > >
> > > > > Reported-by: Jared Holzman <jholzman@nvidia.com>
> > > > > Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b6=
64-23242981ef19@nvidia.com/
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++---=
---
> > > > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index c4d4be4f6fbd..fbfb5b815c8d 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct b=
lk_mq_hw_ctx *hctx,
> > > > >         if (res !=3D BLK_STS_OK)
> > > > >                 return res;
> > > > >
> > > > > +       /*
> > > > > +        * Order writing to rq->state in blk_mq_start_request() a=
nd
> > > > > +        * reading ubq->canceling, see comment in ublk_cancel_com=
mand()
> > > > > +        * wrt. the pair barrier.
> > > > > +        */
> > > > > +       smp_mb();
> > > >
> > > > Adding an mfence to every ublk I/O would be really unfortunate. Mem=
ory
> > > > barriers are very expensive in a system with a lot of CPUs. Why can=
't
> > >
> > > I believe perf effect from the little smp_mb() may not be observed, a=
ctually
> > > there are several main contributions for ublk perf per my last profil=
ing:
> >
> > I have seen a single mfence instruction in the I/O path account for
> > multiple percent of the CPU profile in the past. The cost of a fence
> > scales superlinearly with the number of CPUs, so it can be a real
> > parallelism bottleneck. I'm not opposed to the memory barrier if it's
> > truly necessary for correctness, but I would love to consider any
> > alternatives.
>
> Thinking of further, the added barrier is actually useless, because:
>
> - for any new coming request since ublk_start_cancel(), ubq->canceling is
>   always observed
>
> - this patch is only for addressing requests TW is scheduled before or
>   during quiesce, but not get chance to run yet
>
> The added single check of `req && blk_mq_request_started(req)` should be
> enough because:
>
> - either the started request is aborted via __ublk_abort_rq(), so the
> uring_cmd is canceled next time
>
> or
>
> - the uring cmd is done in TW function ublk_dispatch_req() because io_uri=
ng
> guarantees that it is called

Your logic seems reasonable to me. I'm all for eliminating the barrier!

>
> >
> > I have been looking at ublk zero-copy CPU profiles recently, and there
> > the most expensive instructions there are the atomic
> > reference-counting in ublk_get_req_ref()/ublk_put_req_ref(). I have
> > some ideas to reduce that overhead.
>
> The two can be observed by perf, but IMO it is still small part compared =
with
> the other ones, not sure you can get obvious IOPS boost in this area,
> especially it is hard to avoid the atomic reference.
>
> I am preparing patch to relax the context limit for register_io/un_regist=
er_io
> command which should have been run from non ublk queue contexts, just nee=
d
> one offload ublk server implementation.

Good guess! I was hoping to depend on the fact that buffers can only
be registered by the ubq_daemon task, so that reference count
increment doesn't need to be atomic. But if you plan to add support
for registering ublk request buffers from other tasks, then that won't
work.

Thanks,
Caleb
