Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E922D799
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573679; cv=none; b=DJcVWr170d2IasAOm+jR93XU4IgqKpsg5k/9GhyAUDRk94FHaI7exoY3unl9uP9/Zdz0Sq2OcR/pP1kSSdwKVPeW0DSdH43qljxphU/1zvCrM1vykzVqqTSNOU8IWFt7p+hNxA69JUSkYV854DYhSqF78q6l/V1Vv0mFEERJ+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573679; c=relaxed/simple;
	bh=qXpYjnL6QzDKFF/vEA2avZLphl/BA8jmPIwzNSXeK7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv6jrNfEaA/B7q0v9TXyL0tzTNavzb+zGskNwQB0xW3EtjDrlS352ranU6UBwHl56m4Odg0B1Q+5RmoA9q2EzmbE6fX3dKaK3O+elPUAG61bW6sxIjir25WVUxcG8Dp70C8Demr5k6jHa59r1+Ba7p2JjC3QGLj69TfZZzq1BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv3+y9CY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv3+y9CY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47681dba807so242911cf.1
        for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573677; x=1743178477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr1NpamvodEP6MFP3VgS0Dk87IubpsnKUE/+euMf6QU=;
        b=Fv3+y9CY8f2z8Zy2KI6pqFnQyV7BVUDrSAJNKGpTVdyOpcyNU4/FQUL4zz3+faPkaT
         oTn39Aqr1rBjdcYFvzwokw8ucOYuOiR6qNpR0xhBxlofxuKBD2A17SWui721887+jErb
         lueqHOTTfjYujWnpOrnpa5DUarH7F+TBIooG65jTgRsSgylaC3X874jRNb/uAZ/0UtEa
         RHQJyMwwwLLgnmTfRdf4Mez+HL4viGgBfv77sFS0axbQKPdYfgZ1LoK8v6DYvcKsDWnT
         5CIGlf3AVywZZKfZkUs3PSXud/k6UbXei63f8v/a3XWoKST+acnFS6g7cKySgNE6PqQF
         4QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573677; x=1743178477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr1NpamvodEP6MFP3VgS0Dk87IubpsnKUE/+euMf6QU=;
        b=AvaTtA/twz1ykI/uCF3piwH1MCiGTRtMWJyMrkeF6mnq7FJzKem7cBUCDtxpsd/eCB
         frFT8loqAKIZRC3j42crroXKMdP1KgIGFhm6Aia/aqONGTsy9IrMGHZ2q7OH/1GRJldo
         lH8vgEBgkeFXFemV1wshpgbdu7wv3jrkMDB+hT/Vc9mNTeo+I0OYVSHDTUdas4TeBnTf
         TrZOkQmli4stxJ3mmvvwbK5kQNBvXallKG2C1jlwZ/RjqFRtVJxjtISbDGOlkbJFH6gp
         jYfD+I3exjHjwoClg518XfDA9T6TBjgcwzRzeYX3MccPW77opeh9/FturHzEwS5uufTl
         S1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWHmYy6I556Lr0UrpKrM70HgNoq8crb8wHjlszZjLtjZsww4++N1KCRVKImpn72Q6ROBnsoqP+mR9yitA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT++ItFPwcBr/WByLJqd6/XGMWgJ5cu4+Rn8ZE1kM2hE4GJui8
	kxNZFJKPD/zyXJaLFcmwFFvR7b5YoKfsmOV88xUEbYYRnlTOBPueSy/w+So18YvkJy+YUIbJfxF
	wBvoOLhhavg4JZQlCj1RqWvNSP4pXnv5KDFUM
X-Gm-Gg: ASbGncsYvgzQUP+zLfhZ/YgPjFZ8Wo2X2GNDPyOFUmvbSWBTurWBmkGPDV/198XdbmQ
	L3tzkI+biMkUMbJ2wqjqnbD6dSyD507Iv3rs6zZqPsVrxwA4uFf24kwXZrSaz/yUkARTc+6l9X6
	25NNicni4fhWliXqvj43voafKR/w==
X-Google-Smtp-Source: AGHT+IFtRdtnxmYqCiNGozdyiDRgbS5XVd2/jJNIMYaa9ildizNYGE8X3N7zH+w9Lm6oeOkoQXAJJ6yRGhxNC/i547Y=
X-Received: by 2002:a05:622a:1c10:b0:476:77be:9102 with SMTP id
 d75a77b69052e-4771f510a8amr3527931cf.7.1742573676464; Fri, 21 Mar 2025
 09:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-4-surenb@google.com>
 <20250321-unhelpful-doze-791895ca5b01@spud>
In-Reply-To: <20250321-unhelpful-doze-791895ca5b01@spud>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:14:24 -0700
X-Gm-Features: AQ5f1Jp8UfxX8WOnw9385d8J0NeQgt0g6OSnoez6cTxiRd2n5Bydr6rryoZB6As
Message-ID: <CAJuCfpEujbaSrk5+mR=+vWqwSu-t52fVmbPf5msnpduSB6AT2Q@mail.gmail.com>
Subject: Re: [RFC 3/3] mm: integrate GCMA with CMA using dt-bindings
To: Conor Dooley <conor@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, hch@infradead.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 7:06=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Mar 20, 2025 at 10:39:31AM -0700, Suren Baghdasaryan wrote:
> > This patch introduces a new "guarantee" property for shared-dma-pool.
> > With this property, admin can create specific memory pool as
> > GCMA-based CMA if they care about allocation success rate and latency.
> > The downside of GCMA is that it can host only clean file-backed pages
> > since it's using cleancache as its secondary user.
> >
> > Signed-off-by: Minchan Kim <minchan@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/powerpc/kernel/fadump.c |  2 +-
> >  include/linux/cma.h          |  2 +-
> >  kernel/dma/contiguous.c      | 11 ++++++++++-
> >  mm/cma.c                     | 33 ++++++++++++++++++++++++++-------
> >  mm/cma.h                     |  1 +
> >  mm/cma_sysfs.c               | 10 ++++++++++
> >  6 files changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.=
c
> > index 4b371c738213..4eb7be0cdcdb 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -111,7 +111,7 @@ void __init fadump_cma_init(void)
> >               return;
> >       }
> >
> > -     rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump=
_cma);
> > +     rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump=
_cma, false);
> >       if (rc) {
> >               pr_err("Failed to init cma area for firmware-assisted dum=
p,%d\n", rc);
> >               /*
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 62d9c1cf6326..3207db979e94 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -46,7 +46,7 @@ extern int __init cma_declare_contiguous_multi(phys_a=
ddr_t size,
> >  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >                                       unsigned int order_per_bit,
> >                                       const char *name,
> > -                                     struct cma **res_cma);
> > +                                     struct cma **res_cma, bool gcma);
> >  extern struct page *cma_alloc(struct cma *cma, unsigned long count, un=
signed int align,
> >                             bool no_warn);
> >  extern bool cma_pages_valid(struct cma *cma, const struct page *pages,=
 unsigned long count);
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 055da410ac71..a68b3123438c 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -459,6 +459,7 @@ static int __init rmem_cma_setup(struct reserved_me=
m *rmem)
> >       unsigned long node =3D rmem->fdt_node;
> >       bool default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default=
", NULL);
> >       struct cma *cma;
> > +     bool gcma;
> >       int err;
> >
> >       if (size_cmdline !=3D -1 && default_cma) {
> > @@ -476,7 +477,15 @@ static int __init rmem_cma_setup(struct reserved_m=
em *rmem)
> >               return -EINVAL;
> >       }
> >
> > -     err =3D cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->na=
me, &cma);
> > +     gcma =3D !!of_get_flat_dt_prop(node, "guarantee", NULL);
>
> When this (or if I guess) this goes !RFC, you will need to document this
> new property that you're adding.

Definitely. I'll document the cleancache and GCMA as well.
Thanks!
