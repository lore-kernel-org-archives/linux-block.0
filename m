Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA233D6488
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243508; cv=pass; b=eDxNNuPWow/Cyfs/dUvWtCIcq2Xi9AOdBa9Xg5gRF+UP9ZzvgeI/Jzt8m7t3OIjl0WfdLl1QcSlGggGW4zxrToJGsvHZNb19WEobGuFaAZCWLDKkcj6DorQQ0MmnIYGI9198wl7yR6wP7mDDLlSreF+TehjB7SlgsALKzczm/kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243508; c=relaxed/simple;
	bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGhuvD1tiFsW1q+mxPJCUnWRfSXFMYYMQNZVtKa7sss3RBkUuVh1nYWsZTMgoS4uMQoxeuZ8JDW8eYFOtkqrTlPiUZkYeVwsURg3X+pH1DQJdrZNUbhBX5VKfA0tazHowvyRLQHWTlSOPUvETaiijyZjO3MyvUchWNhRBbLCFZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiUPt9CS; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiUPt9CS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4670464029eso3684071b6e.2
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 01:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776243506; cv=none;
        d=google.com; s=arc-20240605;
        b=bZqDj6zqVVVKJZnbA8qxW4o0i15WqzRsHUICF2iAEc+MprcjJwVrRu3zammzVu8+0A
         ZgteJhimIawIon4/HHg7wNc+R+ZJwvCi2xXhho78h0v2uVcXM3sdnieFqZQLIeXadeVc
         J6gfH1xMuQMdwq+M+eLp9D8e2Y+As+D09HsJlKzQL+lmA/siPWLrlQuTmd/Kvh7iKYaN
         LcpeUCO9/xLvP5LntkIglz0bgZ0BB/LPvPZ2LVklRqZi1QYwSgLhW/opksR7y5s8VXOu
         03KFKQUNSdG7Q5XBZ/xVXWQHhjKclPVi+uiFoo/Gjoybxz+dG0fcixprLzZRsoCql/Me
         1bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        fh=UaSsELSt2My9OIXm2r+B5Dy0FMG5V4tGwPiW486750s=;
        b=Ubsw8xL8/TpdMvyAF8E9vBSH41LdWSqnq7O+3mRWuG3lxBoZKqaP9ObGz3mL8H2/hm
         +yJNDcxSpfbidYCTPSJigCGH3iklM9Vr3wkYSg08DQf6du+Thfp935Xyk2T3WNIYhjph
         TeFiszxkkNI9kvU/Xg79ADCUeu8FcZalVk/wQMjvVfacpAFf+7boXmTD6fC2d9xN8vsW
         hyu14J9aQ9ieK7xXYCIv91Xlx+AdFSty/wO7ZYJRqls383BET1YydpD0LkZ7OSFj55vE
         CMaxJanKfm6tpiKACKFOXo0QyFCz+S+xPE/LH733JrkwqTirXTlTnOyS3vs7BvkR2TWE
         La4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243506; x=1776848306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=UiUPt9CSQKWVfDF5vSnsZ26CXWIcvyyKj/UN3qAwB0mKS8FL6WyTdf4hW+59Hw2F5J
         XlAoQi3UNj6LXVdhkLurd1F78Ypy7SuiCHowYci5ZKo2/IfdZIE4V7ZqnSnaX8N7q6Ao
         rkSE56TTCPIc27+7QpbOx4vcP2cee8V+2K/OTbSBSnF19GgiN8npX1xtMNqvjpGyGBxE
         fdFHBui+H9NXExzW8IzAmTiIqp2GSXZA/Lti77acnN2z+2LPCuMzSzyYRS4fVgjuFzmH
         phDCuhML6PZSdfKEwSJl1q6Jl58u60ewAtealQJqEgbLX3uXPPFYla0DwsMZXNfMJigM
         x7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243506; x=1776848306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=D371lfgTBs7r2iMojKuCZeXLxA4uNvLl8skL//bA0/rxv/AA0+HpSB9gSGcJx1TGqX
         qq4Dc66jzkg4ivB+O0xQYvCTkaFNj1lT3QR7O0IK/VIr1K/qd8+saj9cruaDs1L3gAJE
         1gaEQ0wr2+b+p/kAbkTqJtaSUJgI4UrgRO7t7TzYFjvsUARIFCCmWU9LLPvmMJYYWkQZ
         XhSQ0xFxIQbG7HQYGhif2YHA/PXo67lQ42VErlNXQmrHA/SEZskrj0a75VgrFhEYWq+q
         uJeFnrk8NvSjQkzGW+1cxePGTczK80+Rp14sontczhPlnDviudEaJCIIh5D6gUfHQaaw
         iRrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YyfOfL4NvZWcSPr3H7u+Wrma1kLHsJXHAy931TDJYVfD+91fODISzf4rNnSYfoECke2khfov/S0FiFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAOryErh6d8WV8IsLaaMtULLmgT5aTfQyzUP0Lw2nhI+IFOPH
	+p2ufXOyIFDk7koqxkx0HS2QMGR9g9ob8efcw9u23vsSjPtH/ewDMLCsN/higEwbvXgrg7rpvAi
	I/WbqBURTfbLe+pKd+hRfvDmUpuGS7Vc=
X-Gm-Gg: AeBDievfd//qomSVXKlJHTDGfOVT6hBxfttL6USck4t5mnKtAnjOm3LNXlDPJ6EJFsm
	0cSk/iLTP6hX1RiRQ2d7QDn7gzTX6vRcAyqih4mmIS3GePJDrJySpiy67xgwBs1RR83OBW8zw8z
	ajzxZj0PIG5s7QbEceMbz2sPaXAD7iJYtMT2OGfcFU6Fi5+5JbFhk1RjRvYlBjWRh+3Oc/2Y9dO
	ttszE7Cx+rJTNMFNJwOanc1Ys3Pgg3MfUBCwbJCG7M/GGP/xeH9S/B7TAKMtpsQMPU+fH9yi3Fm
	8zSJdWlW4o5cr00X60HM3kf+sfiCtzeFwPso2bguHw==
X-Received: by 2002:a05:6808:c162:b0:467:91:fb26 with SMTP id
 5614622812f47-4789f111a6dmr9948231b6e.37.1776243505664; Wed, 15 Apr 2026
 01:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora> <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora> <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora> <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora> <20260415083458.UD3cF5IQ@linutronix.de>
In-Reply-To: <20260415083458.UD3cF5IQ@linutronix.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 15 Apr 2026 16:58:14 +0800
X-Gm-Features: AQROBzBesZ1I4COKhVLm4yVWD97BVXXbWvhA1t-bSTLWqOPST2qVCo792OkUIh8
Message-ID: <CACVXFVMPO_JZMSbELnsKzUpXZ7M1sF7cHETUtdqEFT73gn9shA@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, mst@redhat.com, 
	aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 4:35=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-04-13 23:11:15 [+0800], Ming Lei wrote:
> > > > What matters is that IO won't interrupt isolated CPU.
> > >
> > > The isolcpus=3Dmanaged_irq acts as a "best effort" avoidance algorith=
m rather
> > > than a strict, unbreakable constraint. This is indicated in the propo=
sed
> > > changes to Documentation/core-api/irq/managed_irq.rst [1].
> >
> > Yes, it is "best effort", but isolated cpu is only take as effective CP=
U
> > for the hw queue's irq iff all others are offline. Which is just fine f=
or typical
> > use cases, in which IO isn't submitted from isolated CPU.
>
> Couldn't we tackle this by limiting the number of managed interrupts the
> device asks for and then limiting the CPUs it could be bound to?
>
> So if have house keeping CPUs 0/1 and isolated 2-63 then managed_irq=3D i=
s
> futile since it use 64 interrupts and map each to one CPU. Even if the
> device supports less it would map them evenly across available CPUs.
>
> If the user wishes to initiate I/O from all CPUs but not be bother by
> interrupts we could limit the device to ask for 2 interrupts instead of
> 64 (with the consequence of more queue sharing) and then limit those two
> interrupts to CPU 0 and 1 instead to CPU 0-31 and 32-63 like it would be
> now the case.
>
> Wouldn't that be what the io_queue flag tries to do?

Yes, that is why I call it one optimization, however it does introduce
cost of CPU offline failure, please see patch 11.

Thanks,
Ming Lei
