Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9481F2B88
	for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911949; cv=none; b=NnBvDU5oyICZUSn7jOfeIhJzgXP+AfnGA8gjFcSwWaGx8754HdJwK68UNmmOp9FHNYMgTjZkP7kYw98P7hAjORJOEKX/ddmOVmB+nVah3bDYzxHbdSN3FqF4gb+FuiCl5etduczBoILpYUYKkh/BhLseXdLB0A2rA75felpBApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911949; c=relaxed/simple;
	bh=ZDCD7TMmMBU4ptro5VqHZHIwf1F5zUtyaHM3OL4FbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfZZsPwkQWkU19lXq81OVAOetJhPwgVMKloVmGm+ppOGyf/YE4kgEy7TBARRn0l+NRQ3QnWHE4Px7UBqkIBR4oGQnDT4S9zpFFpMZgituDocmr5mS+9PBVDv+6xeP8u7aEItLG1k6P6bJoOTrXLsqPWmwHfRgY/c9S8tfw9MDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFCokfhI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFCokfhI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso423803066b.3
        for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775911947; x=1776516747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=pFCokfhIH/w+o6IWXQGA9Ktp74Gk0G8BjS9gd0qxZMOQ5IIuc8sE+TABUr8B8f8NYy
         k3umcXQDUaTtyvkD011r1ECSSIfLL23C+P2r0754onmIDTs3cmb7Lvxew8CKDfejnGdf
         uxAYSgMTuBmnu7RD3Cdr74gH+EyNLp278Zozme12NKgVC6o12HTEd4r8LXGoWv5UxAFa
         UPXRVC3jewbJtEiFsLxGgoc9n+C+5tAvnU2sdLTzQvg/ABotZRZ3wfk3w0H+cNm0x6Wt
         Liv9JoNO6GhAkyRPxv/pMWBL0m1IA9oJgrEPT1PQPG5rWP5FELJCWmwj5xgTn2Du6OuN
         VSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911947; x=1776516747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=RTwfVv9Dawhu1tFK5oRxr9mvqmEkBWhGx44whGatqi8svNShX1wVOeqWH4nE6O3+Wg
         +VQpHbE0u2FyMCNbhwU9VxNKIiKRpzrHKNGc4eb1TCc4VkUBvfesb4+hXn/hD8p1cSdN
         qz+ecVxbuaLcvs8PNl4ZOxI6UhF1kP1n/S5+qxwBhxbMLpTYy0sF0w9r+LatZ/qC/Or+
         0SVxU51mPIl9PgK4R7RSwXVPHjvjbwI+i+VSIta6MKkRu3qA/UOor6KP8RSBqJYmd1C5
         96ENqY1LLN5zjCbAb/0m8KjLLspYVK7v+5TKw8paT0Lz3RRDx6hmbXdaK8QsEEeo6pxp
         rOhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqeDs45eiRdmrlLZv3EsNXn6ubLof3ZhkJDCa0zPAUMHEKnsDEzHEaa64qJwVwERx7dMdKytuwly5aPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUg3M0wgrmrsqdfau+z86AEKB4wjC6L23uLoggquxL8L241+I
	UgPm56L6pPQ0nx4jvYnxrgDWQ7gGExZtjML7gZGTDt7MQrFFUsE5mzEf
X-Gm-Gg: AeBDievhRN1tt/aInsN1qlmzkEid9G4sJGKPZ3237Y2ixt/E9c570q3QzCxLwS08cG/
	i4LeMhE+W8OT9PJeYgalzBth5HZzbL/yGJw5EhGIQfeT3ghG595E8JjtxXdPN99qCv6Soyw26Cy
	nJYbL+Kw66ZjBgSeRBd4olCLngK/JD4yTnJWI9yI7teBZCcEcipTiGgL7ayeljZDgBL2LZD9XjR
	yCAs7odyFKZTY1V1LM2aPQUao7Errbz36bJbzdwYi/YDvfAk+/jrlqiXj1grBmUi/VPLtKXKvGP
	oNo7yvVLurmd7M/JG7Ds9NNF8E+d3SE7gXMMqBvsX+6kn4EDYvR6/V51dlpP+lUyf6Ot/dyMinj
	pKPC9J3NFQiWdmn01OvWgSByCGcsymBGaY9Y1DqyPom3QNzYRyhnHB3pdBYsLWbUKCVaC3h5TaP
	Fh+kI2Nooo5iakhCBn3lThUjk0K4dpQPuFULT9AMhJWi50kU+aDO3bgiMYkMl/M6VxB8veCwTuo
	5as7H7v
X-Received: by 2002:a17:907:8b98:b0:b87:d09c:1825 with SMTP id a640c23a62f3a-b9d72792c0cmr382274666b.13.1775911946574;
        Sat, 11 Apr 2026 05:52:26 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1e87sm159883666b.61.2026.04.11.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:52:25 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:52:00 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <adpD8M8cNu3IZzEL@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>

On Fri, Apr 10, 2026 at 03:31:22PM -0400, Aaron Tomlin wrote:
> On Fri, Apr 10, 2026 at 10:44:15AM +0800, Ming Lei wrote:
> > For unmanaged interrupts, user can set irq affinity on housekeeping cpus
> > from /proc or kernel command line.
> > 
> > Why is unmanaged interrupts involved with this patchset?
> 
> Thank you for your continued engagement and for ultimately supporting the
> progression of this series.
> 
> To clarify the handling of unmanaged interrupts, while it is entirely true
> that an administrator could attempt to manually configure "irqaffinity=" or
> via procfs after the fact, this series actively address unmanaged interrupts.
> 
> > > CPUs, thereby breaking isolation. By applying the constraint via io_queue
> > > at the block layer, we restrict the hardware queue count and map the
> > > isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> > > regardless of whether the driver uses managed interrupts.
> > > 
> > > Does the above help?
> > 
> > As I mentioned, managed irq already covers it:
> > 
> > - typically application submits IO from housekeeping CPUs, which is mapped
> >   to one hardware, which effective interrupt affinity excludes isolated
> >   CPUs if possible.
> > 
> > I'd suggest to share some real problems you found instead of something
> > imaginary.
> 
> If we trace how mpi3mr sets up its ISRs, it relies heavily on the core
> grouping logic:
> 
> mpi3mr_setup_isr
> {
>   unsigned int irq_flags = PCI_IRQ_MSIX
> 
>   struct irq_affinity desc = { .pre_vectors =  1, .post_vectors = 1, }
> 
>   pci_alloc_irq_vectors_affinity(mrioc->pdev, min_vec,
>                                  max_vectors, irq_flags, &desc)
>   {
>     if (flags & PCI_IRQ_MSIX) {
>       // affd != NULL
>       __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs, affd, flags)
>       {
> 
>         for (;;) {
> 
>           msix_capability_init(dev, entries, nvec, affd)
>           {
>             msix_setup_interrupts(dev, entries, nvec, affd)
>             {
>               // affd
>               irq_create_affinity_masks(nvec, affd)
>               {
>                 for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>                   unsigned int nr_masks, this_vecs = affd->set_size[i]
>                   struct cpumask *result = group_cpus_evenly(this_vecs,
>                                                              &nr_masks)
>                   if (!result) {
>                     kfree(masks)
>                     return NULL
>                   }
> 
>                   for (int j = 0; j < nr_masks; j++)
>                     cpumask_copy(&masks[curvec + j].mask, &result[j])
>                   kfree(result);
> 
>                   curvec += nr_masks
>                   usedvecs += nr_masks
>                 }
>               }
>             }
>           }
>         }
>       }
>     }
>   }
> }
> 
> The critical issue lies at the invocation of group_cpus_evenly(). Without
> this patchset, the core logic lacks the necessary constraints to respect
> CPU isolation. It is entirely possible, and indeed happens in practice, for
> an isolated CPU to be assigned to a CPU mask group.

It is one bug report? No, because it doesn't show any trouble from user
viewpoint.

Sebastian explains/shows how "isolcpus=managed_irq" works perfectly in the
following link:

https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/

You have reviewed it...

What matters is that IO won't interrupt isolated CPU.

> 
> The newer implementation of irq_create_affinity_masks() introduced by this
> series resolves this. It considers the new CPU mask added to the IRQ
> affinity descriptor. When group_mask_cpus_evenly() is called, this mask is
> evaluated [1], guaranteeing that isolated CPUs are entirely excluded from
> the mask groups.
> 
> [1]: https://lore.kernel.org/lkml/20260401222312.772334-8-atomlin@atomlin.com/

Not at all.

isolated CPU is still included in each group's cpu mask, please see patch
9:

https://lore.kernel.org/linux-block/20260401222312.772334-1-atomlin@atomlin.com/T/#m59df0689ef144f5361535ce59c9ed5923d6e21d5



Thanks, 
Ming
