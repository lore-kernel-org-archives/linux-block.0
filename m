Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94D298991
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789077; cv=none; b=APXOF0/FaQRwJLKiaokwMobc9kZdeHoWjLuEW4bWo6TjwwtserTcgY4TCsjE0HpTOOIE9eRq6tI4OL/688a+eteHxHyqofpQxuIv3kAQdNp5vT71LMOlRH+h0RCzuJmPeYmnQIXlYz3ryN9qzGen7RtJKciVakYQWHepOH6sF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789077; c=relaxed/simple;
	bh=TPe+unbB39v2p3g34Bl3H0+CW+J9BRBNX3aGbJ25L2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnwYeAsW+JWBz9Uf6abYPHeyIxgilQfzaGubnMbxM3F/hbcs8RqSClDNiUWvrfWgjurh/arhez6MBR0ik7SB/ep59yKF2IEItJAqSFREgtlc0uPUtzHta9XbxxW7HaOUjL1IaKK3tdcDHlC17zeKWWFHHY+uWymILWD3d3HYhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0XP0+bz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0XP0+bz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d965648a2so1431050a91.0
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775789076; x=1776393876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=g0XP0+bzuy61RG2po8R5vKlOVHv0clDoj+/ZwgrwwhS5pTdXq7pp4VzEgx3zXuVbe7
         U8PvcoAAZen6o/8ywrK92mvNm9ZXBxsYkJxLrDnPeU6rZ4ChWa3PiZcFdatcBIsibaY1
         E33AdtHTG7ymxjzMmM0VscfhAsYirikwyqWue0nkjnYzPmILu6M9EOUuLqbE82pVPqOB
         aCuLOv2ya6ht1QllIPYGLwLiby/g6mOvgj2+/hCnKLh+P0hy0gdgKRWJ+FDnidAPWNBO
         yP+cHdKsRRX558uHciNLl/hMrkZXGA345cRxxOOx+H89FixUOwmXgQqeK8x6bsm2v8Oh
         l/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775789076; x=1776393876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=q5BdGHRlVijoulNZf+hMNK5C9Wc9YO9k9snwL9Qu5nR72kmbi8nD84tPXfg1Fa4WCA
         6pvmMIAMxMy08LpARV9ZT7HmQu9znsRYGOkrZ/vfJg9F85VFkDFJ0+T1HAWFOZ9LLEgf
         nMjw0QZwYR3s3VObd7nJiYs+Wpc/opWBbSQ/8nLBOoHPsQ5KFSqkZchMfQ1XBrpQX8/5
         K1k/GKlbm+LjO1p1X5/+HjD/0aqsGo22vqaA0fLf0Wbpsbx2HAJ5RHsCkblKbS3tplQe
         UvWRuqjMheCCSIM8HLqQqG3aXLf+9y4/jWpHf6OOD/wck1SruieS2RKkKCf0YemFnfPi
         6pkg==
X-Forwarded-Encrypted: i=1; AJvYcCWM1x/MlqZihWiPADVOPWI/0kLzriA4jhxGFiN0y3Ywf2VTUluRjVw7YTDxZmtO1LtYmiUUZI9g1Fgebg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweNqSxAWjlgEakrfxY1YxREb/T4+xwhyro4XkV6w+WAUl+BfRb
	RlWxU4XFDhw8a9o6z0q14iWl4lmEuzCMoWjNXPNzvcezo5LgpBII/7Uq
X-Gm-Gg: AeBDiev1sklF/JfFR1dYhokN2wUDmJF3rYOa8d66R9T6f9Cpsky6ZU1BRShbplvkrwa
	ikySSMewGfY0Gc/cQS24fmBilOAipD7TSQspzfrvm6D+Z4L1p2EDx1HAXxf66oQV+gLoqIMZJx8
	kbeAc9Na/s3rSyjvieHOvkSEa3L9DZj9w6Gf4Ir8OhgboLYE0IvnJGyF5ayt/KnQ2GC8ERsPhnf
	TGajTUKeLNpfs7QQFRqJFoV3626ezKo+WvBavCSq4fNjm2p6I4D68W1RNqmTstJiHUe/b3MkqmO
	LK2ygKNQQmDDNO3GDCZ6hMT+5ecbbQjzDTLGUs7ppc5Jktyj0jhweAoJupiv0AILAzFFdXBRxYI
	ynQZUgVvVTQ00j2MHLrCO2wk/d5UyLPxdHvjU4V+p9mB8kJEnn3nCxuzyvaE/om3RQGlg6hU3bx
	zhD/ZUnDNhc+AUwtR9kFG/ENoF4BeBfCruBPPtavgD7E+OIn4+REQQ
X-Received: by 2002:a17:90a:e7ca:b0:359:974a:3d65 with SMTP id 98e67ed59e1d1-35e4285280dmr1485690a91.16.1775789075530;
        Thu, 09 Apr 2026 19:44:35 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm4526177a91.14.2026.04.09.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 19:44:34 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:44:15 +0800
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
Message-ID: <adhj_w11cpMfeEgN@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>

On Thu, Apr 09, 2026 at 09:45:04PM -0400, Aaron Tomlin wrote:
> On Thu, Apr 09, 2026 at 11:00:09PM +0800, Ming Lei wrote:
> > How can the isolated core be scheduled for running polling task?
> > 
> > Who triggered it?
> > 
> > > loop waiting for the hardware completion. This would completely monopolise
> > > the core and destroy any real time isolation guarantees without the user
> > > space application ever having requested it.
> > 
> > No.
> > 
> > IOPOLL queue doesn't have interrupt, and the ->poll() is only run from
> > the submission context.  So if you don't submitted polled IO on isolated
> > CPU cores, everything is just fine.  This is simpler than irq IO actually.
> 
> Yes, you are entirely correct. The ->iopoll() is indeed executed strictly
> within the submission context. In the example below, the file operations
> iopoll callback is iocb_bio_iopoll():
> 
>       // file->f_op->iopoll(&rw->kiocb, iob, poll_flags)
>       iocb_bio_iopoll(&rw->kiocb, iob, poll_flags)
>       {
>         struct bio *bio
> 
>         bio = READ_ONCE(kiocb->private)
>         if (bio)
>           bio_poll(bio, iob, flags)
>             if (queue_is_mq(q))
>               blk_mq_poll(q, cookie, iob, flags)
>               {
>                 if (!blk_mq_can_poll(q))
>                   return 0
> 
>                 blk_hctx_poll(q, q->queue_hw_ctx[cookie], iob, flags)
>                 {
>                     int ret
> 
>                     do {
>                         ret = q->mq_ops->poll(hctx, iob)
>                         if (ret > 0)
>                             return ret
>                         if (task_sigpending(current))
>                             return 1
>                         if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>                             break
>                         cpu_relax()
>                     } while (!need_resched())
> 
>                     return 0
>                 }
>               }
> 
> If an application on an isolated CPU does not explicitly submit a polled
> I/O request, it will not poll. Thank you for correcting me on this.

Great, you finally get the point.

> 
> > Can you share one example in which managed irq can't address?
> 
> Without io_queue, the block layer maps isolated CPUs to these queues, and
> the device will fire unmanaged interrupts that can freely land on isolated

For unmanaged interrupts, user can set irq affinity on housekeeping cpus
from /proc or kernel command line.

Why is unmanaged interrupts involved with this patchset?

> CPUs, thereby breaking isolation. By applying the constraint via io_queue
> at the block layer, we restrict the hardware queue count and map the
> isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> regardless of whether the driver uses managed interrupts.
> 
> Does the above help?

As I mentioned, managed irq already covers it:

- typically application submits IO from housekeeping CPUs, which is mapped
  to one hardware, which effective interrupt affinity excludes isolated
  CPUs if possible.

I'd suggest to share some real problems you found instead of something
imaginary.

> 
> > > >
> > > > IMO, only two differences from this viewpoint:
> > > >
> > > > 1) `io_queue` may reduce nr_hw_queues
> > > >
> > > > 2) when application submits IO from isolated CPUs, `io_queue` can complete
> > > > IO from housekeeping CPUs.
> > >
> > > Acknowledged.
> > 
> > Are there other major differences besides the two mentioned above?
> 
> I believe the above is sufficient. Please let me know your thoughts.

Both two are small improvement, not bug fixes. However the user has to pay
the cost of potential failing of offlining CPU. Not mention the little 
complicated change: `19 files changed, 378 insertions(+), 48 deletions(-)`

But I won't object if you can update the commit log/kernel command line
doc and fix the issue found in review.

Thanks,
Ming
