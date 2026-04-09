Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C3DA5D8
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746827; cv=pass; b=qe/oIMuK/iJ5T6d0vtTDGfq+7Z30HSMWswMVIV+owM0UMJIxnd0aDUCNmzXMnJUsBWhKXq80CRs4F98DIxucqPxpTjfcue6AiR8yEosl73xIqqq8oc2hiR3oevUNh+gLEoRNswgAwmbWeX6UbV3wByUNpbnIgZ6ZL/PEn9dNCCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746827; c=relaxed/simple;
	bh=A6WjcZkzB7y/uOYAw/eN9Tj+j1b6o0TUODV7Nvp2H68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYYYVPYkWTKyMhh9WSNZBJ/fSvLdkjJfI6kQu7JvRXklRPUPdz9qofIbV+UWxh0wolR7nUzXl3Jd8T0hk9KWciTs1d1RwhTyTYfbBkjgdSyyoNKOOv2mgG7hefjpLgNb3hjvz47KEyhkv/fTd0rrqr9iDIpxXlJG8jaaTt46j2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwedqR/p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+mbWEQo; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwedqR/p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+mbWEQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775746825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
	b=hwedqR/p0O6y1rp/HU8TxNQ9sgPH8BN/KEAnvhOVFj5L5Gmmni3nuLNiT8Dyi1XDhAThTX
	AvupUWhj4WPz5ZUmD1AjOTsj5ueqD854UxMDMM9fdtq+oQYrbsAR5lNvIEo3oL41zQAsrK
	cy66/CIeRnDjIOUmyaquAKSbLsTw+7s=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-4EsTn-7lOci6-TaFiOQxRA-1; Thu, 09 Apr 2026 11:00:24 -0400
X-MC-Unique: 4EsTn-7lOci6-TaFiOQxRA-1
X-Mimecast-MFC-AGG-ID: 4EsTn-7lOci6-TaFiOQxRA_1775746823
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-604eba0f2f8so350164137.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 08:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746823; cv=none;
        d=google.com; s=arc-20240605;
        b=I0JrWSPMiN8kBnJAL/K1kJX2GStna3lQgwtWz9a+U5urQKp7Qrs74rGfC1XM4iGoo8
         IJf0BUqByakwmyJiF6dTDGMjHt+wgALX3ryzS613Frp6ioMYtfqcpgVUrpdvmPPX7tIl
         D+rn3fw8K/hQSSsVR63XLrGAIu176FuCSUNZ55XZhNbnEqRAg+sFiUCzOnB76gLJTk60
         t3vw2DR4mfM2BFmDfDQSBHzy912TGXfO4XBLBKG8dJEdaj4paP9GJGHj1UgFQZbfI7qO
         9ClywCVcmX+bwG0p+RrDFD8Z0boDXVuQgYEiloPK9fKa9mvW/LDy6fBUbokTL9pMWmyo
         coZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
        fh=ywVxItwgCmflwdWA6AQpS/YZhX4x4yBjouwngZxPn6U=;
        b=WzVkokpKbHiMubMI7JSE/VWeKcCOvMN1+US8tDfklFGEI1+y12GyWmBG9pRM7qxooR
         sHFPEQxx2lGr4lZRZRkeqeyhZ5SiEPne9N9a023T7y6Ee+iIsvUahvI0dlW9oaHq/cQ3
         apqKzWOiKWSjMsEAEfS5/CMkpGOEcvD3hfQBDLdmImqIe0YhxZCNrEopwPIsVt8rrFFl
         x9RP849pwT9/IZmD9S5VFmIpn/bZP7CAP0iByrV4dm2UisJIkMZ1uDnrLgGmjqr/1DbY
         r+42T40QJLTjma07o/W5AKwaZx/HhizuCSbkLsYoetAGxDwhyXDCbML5HpWALzu35U/2
         N/BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775746823; x=1776351623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
        b=Q+mbWEQofehPMNn9Tn4fMyXnlZQo4SEJb6PdYCQxpwA2WQFX07aRMK17b9Cl7x8iBi
         5IDlZi7uCkzS+bhQW633HNjma4tmHfkB6829+x5X7A4gf7GhFLilIqTI47b1/vpnbjiC
         +e+o6gFSLo0DQhcF0+BSr1CihwErulFgs7odKi2tFKFO5aOnjMJ2T4a62iKtgjunArBT
         S15pKPOA3V6wKROCsPKQoGwyo6/g6oZoHHYpmZDz/rl4lBMqIhNTXr4vc4UIj5mqfriZ
         pmSV6edAtLmtucC8SLjZ0JgLfMpqTdsGxLFTjjIZ2BpM8rMCH6NvkCdryBRXsKfqdcZW
         yiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746823; x=1776351623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
        b=VZKzRUyTH9zg1R+PyRsMtuhTjCiNpp5KpVR68ZBigg3iV+69yGexjk1qYd1Gp2HY87
         mxJ4TRTFTpraru3U/MprCukRKQ0YMxKm0U1uGEhqRIsLxmmr46LqXRYHU1zqdkXh91Q4
         MkL9eQMsNEjhkb/ose1k33DiKtm9+FddJPCVP65YOAbJfJJFvsplhbxOQvNNoeG3j7A9
         +Jv1M/b6SrF+8HGqUsZFVjvKpuoPM+jFU172zCw/N9B0DDaNi/rSYzJw8SYlU9ICAuDl
         H+h3gAr7j4kf8OUm6EejdzgO9tmI74o7toHmz62PXVSDUZH6CBcoB0EFRh304dUDBo68
         mBJg==
X-Forwarded-Encrypted: i=1; AJvYcCUbw2NwA9Vaqs3IP+mf0bTCgQYbCdjWGmCnHHydTEi4g6O9FYJ710nLAtJTwResKD3TNiVjfqIOV0s1og==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQqamCnO7PcXmBqWLXeKF3EB2c6kzp3+UnrImqEEfoCivFVTj
	gBZd3qsVmgrO1T8o+LwP5ai59+c3vSwAp1SKHh9g2aQG0dEuDvDIF26w1BMlucBuXtlh16VOKL6
	7TGtQ+Uvl7MOoMersyHmysoWEuQdpW5rp8o8D+kMYf7cuxGQUAMoNkgm7/cNot8gSPwnH36Rj2X
	UIqfcjSuZZPDvpbPnkWIeDvfsrJpgCaiVWkau4U3M=
X-Gm-Gg: AeBDieuoMNtoP8nn2zUcc96ejDHpXC6+Kznunhun1ogWYEDXcP9W97qjj9eTeR216d0
	LmKMXGtzuG0OmYv95uL5+2mb1Q6d+qAgQLW9MwIYcJ7Piwiqfb6TEGQFbcIxW8rIF6zZ9zSz9BR
	mmjQnkO6nxxjiTQ4aSks4bCL1kze92+ETL9fDUQa/uJVYbN94Ph9XV03pmf3GUgCIdURD0qXOsW
	ehg04xXvTMxduGa68VHXgZVb7Orc3s2f8lLJUM=
X-Received: by 2002:a67:e713:0:b0:608:1b6e:f4dc with SMTP id ada2fe7eead31-6081b6ef921mr2784475137.11.1775746823183;
        Thu, 09 Apr 2026 08:00:23 -0700 (PDT)
X-Received: by 2002:a67:e713:0:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-6081b6ef921mr2784399137.11.1775746822118; Thu, 09 Apr 2026
 08:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401222312.772334-1-atomlin@atomlin.com> <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora> <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora> <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
In-Reply-To: <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 9 Apr 2026 23:00:09 +0800
X-Gm-Features: AQROBzBGMQxEgwdm4UZJAa6NOKwn3RLk5aSwu5C0sv3kx4PGZQZHIp5V15VSUxk
Message-ID: <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, 
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com, hare@suse.de, 
	kch@nvidia.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, 
	neelx@suse.com, mproche@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, "Lei, Ming" <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 11:58=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Mon, Apr 06, 2026 at 11:29:38AM +0800, Ming Lei wrote:
> > I don't think there is such breaking isolation thing. For iopoll, if
> > applications won't submit polled IO on isolated CPUs, everything is jus=
t
> > fine. If they do it, IO may be reaped from isolated CPUs, that is just =
their
> > choice, anything is wrong?
>
> Hi Ming,
>
> Thank you for your follow up. You make a fair point regarding polling
> queues and application choice; if an application explicitly binds to an
> isolated CPU and submits polled operations, it is indeed actively electin=
g
> to utilise that core and accept the resulting behaviour.
>
> However, the architectural challenge arises from how the kernel handles
> these queues structurally when the application does not explicitly make
> that choice. Because poll queues never utilise interrupts, they are
> completely invisible to the managed interrupt subsystem.
>
> If we were to rely exclusively on the managed irq flag, the block layer
> would blindly map these non interrupt driven polling queues to isolated
> CPUs. If a general background storage operation were then routed to
> that queue, the isolated core would be forced to spin actively in a tight

How can the isolated core be scheduled for running polling task?

Who triggered it?

> loop waiting for the hardware completion. This would completely monopolis=
e
> the core and destroy any real time isolation guarantees without the user
> space application ever having requested it.

No.

IOPOLL queue doesn't have interrupt, and the ->poll() is only run from
the submission context.  So if you don't submitted polled IO on isolated
CPU cores, everything is just fine.  This is simpler than irq IO actually.

>
> This illustrates precisely why the io queue flag is a mechanical necessit=
y.
> Its primary objective is to act as a comprehensive block layer isolation
> boundary. It structurally restricts both hardware queue placement and
> managed interrupt affinity strictly to housekeeping CPUs, ensuring that n=
o
> storage queue operations of any kind are mapped to an isolated CPU.
>
> To achieve this reliably, this series expands the struct irq affinity
> structure to incorporate a new CPU mask [1]. This mask is explicitly set =
to
> the result of blk mq online queue affinity. By passing this housekeeping
> mask directly through the interrupt affinity parameters, we ensure that t=
he
> native affinity calculation is strictly bounded to non isolated CPUs from
> the moment the device probes.
>
> This structural enhancement allows device drivers to seamlessly inherit t=
he
> isolation constraints without requiring bespoke, driver specific logic. A
> clear example of this application can be seen in the modifications to the
> Broadcom MPI3 Storage Controller [2]. By leveraging the expanded struct i=
rq
> affinity, the driver guarantees that its queues and corresponding managed
> interrupts are perfectly aligned with the system housekeeping
> configuration, completely avoiding the isolated CPUs during allocation.
>
> [1]: https://lore.kernel.org/lkml/20260401222312.772334-5-atomlin@atomlin=
.com/
> [2]: https://lore.kernel.org/lkml/20260401222312.772334-8-atomlin@atomlin=
.com/
>
> I hope this better illustrates the mechanical necessity of the io_queue
> flag and the corresponding changes to the interrupt affinity structures.

Can you share one example in which managed irq can't address?

>
> > > Every logical CPU, including the isolated ones, must logically map to=
 a
> > > hardware context in order to submit input and output requests, saying=
 they
> > > are completely restricted is indeed stale and technically inaccurate.=
 The
> > > isolation mechanism actually ensures that the hardware contexts thems=
elves
> > > are serviced by the housekeeping CPUs, while the isolated CPUs are si=
mply
> > > mapped onto these housekeeping queues for submission purposes. I will
> > > rewrite this paragraph to accurately reflect this topology, ensuring =
it
> > > aligns perfectly with the behaviour introduced in patch 10.
> >
> > I am not sure if the above words is helpful from administrator viewpoin=
t about
> > the two kernel parameters.
> >
> > IMO, only two differences from this viewpoint:
> >
> > 1) `io_queue` may reduce nr_hw_queues
> >
> > 2) when application submits IO from isolated CPUs, `io_queue` can compl=
ete
> > IO from housekeeping CPUs.
>
> Acknowledged.

Are there other major differences besides the two mentioned above?

Thanks,
Ming

