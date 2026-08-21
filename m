Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F54D2ECC;
	Fri, 21 Aug 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325409; cv=none; b=qaWx8nIEs/JEY9NHU9Q8IRvPINOtzW8wJoLJCjBi/DDS3CgwPhxc9KXJSk6Esr1GeY5Kd051FwsCM6Sxie2RtPefyb8W8qwLBLh5GxAKNm8IlVYJz4UlNAfSwGc0TgJKTz1NwvL0GKYn7Ea3ZcDuahZTq1p157WJ//VnZ2pPBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325409; c=relaxed/simple;
	bh=sMp6FiF1W+sUxO8OiI+7C9VN+ABlP+oiwY2+pobWOJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czy1SQxBSRxnn5+jsVe9bpWCe8MWEVkDvaP2mqe942B5VlwW7PL2TZSg7YJY8hT5vgxtxLMZTTdn5/ZlExy4KMjwmuUnAWUocXDleiQa75zLZ1vx4THYkPSj1oL9JRjrhuCdtcp4D07Q4d7AibniL70UWY0sZ8mz+Pi2aAvKWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KqQpXC9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TFneFEX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KqQpXC9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TFneFEX"
Date: Fri, 21 Aug 2026 17:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787325405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkCRof0felrJIVURinMFSatdFMGiwSakP90wn8OvTzs=;
	b=KqQpXC9uv7+UY1ehXdhp9n5nAl44KVjmGAqyswHdwRDsN0doUw+nXSTRkczq16MbEZJjKr
	2ztzFRwP7cfsmqlmSjyIKxPJFoQJ3JOhWvrkUKbkODG0ugdKYf5NNKJzSEjjU7BZXpLR6u
	ajQtwjo3WRizuQbGcSXV6OAGFs053egd3P1fL82mn61O5A1+ARjlxnqvvBrUknkxenL6i2
	8kH6muP/V2eX38OgErII7h8cDbSXHI0N+O3EGv0tXwofo1yf7zs4ajV71CGSmUkjlgyZKn
	nVh/A9Sl80J7Pjjbg8jhWVjEotPMdTRwb/m+QpeNTlRMnCyeza3jpnEBhp6aYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787325405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkCRof0felrJIVURinMFSatdFMGiwSakP90wn8OvTzs=;
	b=2TFneFEX5opsn/PMpJ9zQuYJVCwFEzUEtXEa2ZyB+1IPiLkb7FoHbjFOVDN9QMSLP5fcY5
	Uo2A2/sw+ejGHwCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>, frederic@kernel.org, hch@lst.de,
	wagi@kernel.org
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, ming.lei@redhat.com,
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	nick.lange@gmail.com, marco.crivellari@suse.com,
	rishil1999@outlook.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 8/8] docs: add io_queue flag to isolcpus
Message-ID: <20260821151643.4pYBoVaY@linutronix.de>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-9-atomlin@atomlin.com>
 <20260715102535.STkb5tE8@linutronix.de>
 <xjcwes5caiwh3eumqfuvankokb7wzzokleqfkfmkh5sgl333sg@nwlgqvj4vdet>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xjcwes5caiwh3eumqfuvankokb7wzzokleqfkfmkh5sgl333sg@nwlgqvj4vdet>

On 2026-08-05 12:22:59 [-0400], Aaron Tomlin wrote:
> Hi Sebastian,
Hi Aaron,

> Yes. Though the underlying mechanisms differ in a fundamental way between
> the two flags:
>=20
> isolcpus=3Dmanaged_irq (post-allocation, best-effort):
>=20
>     managed_irq operates downstream at the IRQ affinity level (i.e.,
>     kernel/irq/manage.c and kernel/irq/cpuhotplug.c). It attempts to steer
>     the effective affinity of already-allocated IRQ vectors away from
>     isolated CPUs. However, when a multiqueue storage or networking driver
>     allocates one hardware queue per CPU, the affinity mask for an isolat=
ed
>     CPU's queue contains only that specific CPU. Because the intersection
>     between the queue's mask and the housekeeping CPUs is empty,
>     managed_irq falls back to assigning the interrupt to the isolated CPU.
>     It is therefore inherently "best effort" and cannot guarantee isolati=
on
>     for 1-queue-per-CPU devices.
>
>
> isolcpus=3Dio_queue (pre-allocation, strict constraint):
>=20
>     io_queue operates upstream during device probe, MSI-X vector
>     calculation, and block-multiqueue topology setup
>     (irq_calc_affinity_vectors(), irq_create_affinity_masks(), and blk-mq=
).
>     Rather than attempting to steer vectors after allocation, it caps the
>     total number of hardware queues and MSI-X vectors to match the weight
>     of the online housekeeping CPUs. Isolated CPUs are strictly excluded
>     during initial vector mask generation (group_mask_cpus_evenly()). I/O
>     requests submitted from isolated CPUs are routed through shared
>     submission queues mapped onto housekeeping cores, ensuring completion
>     interrupts land exclusively on housekeeping CPUs.
>=20
> In summary, while managed_irq influences where already-created interrupts
> land, io_queue restricts how many queues are created and how the hardware
> topology is constructed.
>=20
> I hope this helps.

Is there a difference if this happens before or after allocation? I
*think* if it is made post-allocation then the driver expects a certain
amount of interrupts which need to be there. But otherwise=E2=80=A6

There is no way to limit the amount of queues as far as I am aware which
makes the isolcpus=3Dmanaged_irq useless as long as there are more queues
than CPUs in the system.

Is there a benefit of having 4 queues which are handled by 2 CPUs or
would it make more sense to use only 2 queues and not "overcommit"?

The problem I am having is to figure out where the managed_irq makes
sense since you need less queues than CPUs and this is hardware
dependent. Say you replace your NVME after the old one broke and boom,
now are all CPUs utilised.

So if managed_irqs would also act pre-allocation then the only
difference would be "best effort" vs "mandatory".
There might be the details around what happens if the CPU goes offline
and can the CPU go offline. I think the block layers drains the I/O
queues and the actual driver does nothing. In the CPUs > queues case the
queues (or a few) are mapped to more than one CPU so if one of the CPUs
goes offline, that IRQ is simply moved to another CPU within its mask
(which could go to the initially isolated CPU if my memory serves me
well).

I am not aware that networking is using this. Judging by
pci_alloc_irq_vectors_affinity() this is mostly scsi and there is one
networking driver (which makes a bit curious how CPU hotplug is
handled).  Anyway, there is some effort on the networking side to
consolidate this:
	https://lore.kernel.org/20260819-flo-net-7-2-make-stmmac-default-affinity-=
aware-v1-0-3f79a99cadaf@siemens.com
=20
> > If so, can this be integrated?
>=20
> I do not want managed_irq unconditionally enforced vector capping. Instead
> of creating a standalone HK_TYPE_IO_QUEUE housekeeping flag, the strict
> vector capping and mask restriction could be integrated under an opt-in
> flag?

I'm asking for breaking the current option because it makes no sense and
so far nobody responded by saying yes, or no that is stupid.

> How about an opt-in flag:
>=20
>   - isolcpus=3Dmanaged_irq
>         Keeps best-effort post-allocation IRQ steering without capping
>         hardware queues
>=20
>   - isolcpus=3Dmanaged_irq_strict (or managed_irq:strict)
>         Enables strict pre-allocation queue capping (i.e.,
>         irq_calc_affinity_vectors() and blk_mq queue limits)
>=20
> If the preference is to avoid adding a new top-level isolcpus=3D flag, I =
am
> more than happy to refactor io_queue into a strict sub-parameter under
> managed_irq (e.g., isolcpus=3Dmanaged_irq:strict). This probably makes mo=
re
> sense.

Not sure what Frederick's thinks here but I would aim for
managed_irq_strict if we can't change the current behaviour.
It should be also documented if both can be used (or are invalid) and
what to expect if they are mixed.

=E2=80=A6
> > This is named io_queue but it does affect I/O in general unless the
> > driver uses managed_irqs. This may or may not be clear to the user.
> > So the io_queue might not be the perfect name given that affects alles
> > devices in the system. We do have just I/O devices using it right now.
> >=20
> > I think this still deserves an explanation in
> > Documentation/core-api/irq/managed_irq.rst like how to use it, what is
> > the expected outcome and how does it interact with the managed_irq
> > argument. Does it make sense to use both, is it exclusive or, what would
> > be the use case for both arguments.
>=20
> Regarding the name io_queue, you are correct that it specifically affects
> devices employing managed IRQs (i.e., NVMe, SCSI, and blk-mq devices).
> The name was chosen because its primary operational objective is to shield
> real-time and latency-sensitive isolated cores from multiqueue storage and
> block I/O completion interrupts. Non-managed IRQ devices continue to be
> governed by standard irqaffinity settings and irqbalance.
>=20
> I would be happy to provide clear usage guidelines based on the above, if
> we can agree on the new proposal, irq_managed:strict?

I *think* ':' will be an invalid character and ignored so maybe the '_'
instead.

> Kind regards,

Sebastian
