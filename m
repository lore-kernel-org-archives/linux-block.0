Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C82C190
	for <linux-block@vger.kernel.org>; Sun,  1 Sep 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210805; cv=none; b=DtuYS4+tSf6vR1mrqHMY8F2gO2Ao5FmNvIKHmpk61mGkL23gWeL2ScQt56U5mq9BsJohjR73cPMJ3nq3Bzp2XxW7VDSJ1v3Thj4dMFezyLboAqF5S/zG/aIaw8gpWy3MLsqQ50yeUjHaCTIjvBDARZ69X0VgzrT9LLFXtKFdKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210805; c=relaxed/simple;
	bh=D2xP5sPbEfhk6ooGCuMPDFx0sK3E5gxzsS4ge7C4Y1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCs+P8a1V2ebtEPZtYalZgbxrqVA9jgI3uAgiIHQ/PNboGJ/+a0kJCpxFBLAW7+pWLuyEUOLkypo8OJcia/0TwYxGoMBj45iVbFAnLpcMt+4DMtw2DVkZuA59OhJo5KQonweaJcQGfX60rKtUl48E+jl3WZ+9PXAi8IvYemNNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=I3vatQ1M; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I3vatQ1M"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533488ffaebso4188835e87.0
        for <linux-block@vger.kernel.org>; Sun, 01 Sep 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725210801; x=1725815601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HKrxv3KIpmabIk5jknl0F48ntVRU+xbxnN9/Uz86xc=;
        b=I3vatQ1MBkAgO3n/bB11TgsCL6OXTRQ3QG1AEduadeLiY4PBdxjsJ5nxyYgL/CnH02
         4rgqONsuvshlW4aZvmZ54m+5m5pIguH6UpyXEHQFi1yfYcaeAXVu+mYRAy54zo6H88aP
         OSa7VHz5AhlylLePebqZfezfCGz+BCfSCQUcFqY5zsvsXYhfueUD4q8VRa/xjUVxkL4M
         RgF8Obr8oMtOw7u2f8tsjGFvl0peA1q700k1cgDUdSGL7EHY78PZJWQF7KBxVFUX6eVm
         +FLU77OxFf9gKzx87P9G2qJVTJ1KdJbgfs0DnJXpnBeDZiZ9OKK2PChhijxFXXl/Q8cN
         8h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725210801; x=1725815601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HKrxv3KIpmabIk5jknl0F48ntVRU+xbxnN9/Uz86xc=;
        b=hMO/FRWPppCec4F5gooatR20kSoVMGcfWKZdSFBY5n597CJ+UDQyn8cPIktbQJZrWs
         2msQctNlv/zyU87SZ2Bykx0e3aS1aUHKLEicYfYjlrI1oVCh3QwX/gcH2l8sgMWgIg62
         7DoWHJOpKl5BKIDSqMNUOOm69n6Q+v0GZSeeRwFIwIXHPNBwfqL9Unqsd75iYWEQ0rDd
         zNxeEP/ChVO6wvNdx7X/2IGzUNaP12K4mgIfRwdmz93gBmjCc60UnvhETTaGvwsHBRcT
         VlQOsL/MoT5dGkXYbz4Hk99mP5u6yXGqFXwCyTB7DC1XECvGI1lsTwhAb8Ax9N8rBdPl
         SMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuZqycU17CNaKi76+VKEOX7ChbWtB4gPhmcaJZXlf4jcd7qDpxEIiBOOkeab7mzEYGrtStfHj7KWsk6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfP4GqxW7elcak7C6Zxi3pey6/qazRliyCVfA4T+qaaKwEsjWT
	NrPd2YdgLMnLbZLHUXFYSMUC5V3LZ5hsgscggCHm3PC8HvxuR0k+8WwBhuB/tYo=
X-Google-Smtp-Source: AGHT+IG4kLq+xE3MfEJSf+bXeWg5GqIFJLHpQLKPtQtYKnVhTwLp/H2tCZIfJOOuT0o1ETcwiYoAqQ==
X-Received: by 2002:a05:6512:ea1:b0:52e:9c69:b25b with SMTP id 2adb3069b0e04-53546b2a85fmr4925343e87.28.1725210800841;
        Sun, 01 Sep 2024 10:13:20 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dbf2csm448622866b.186.2024.09.01.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:13:20 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:13:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: Sandeep Dhavale <dhavale@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	linux-block@vger.kernel.org, sudeep.holla@arm.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, bvanassche@google.com, quic_nitirawa@quicinc.com,
	quic_cang@quicinc.com, quic_rampraka@quicinc.com,
	quic_narepall@quicinc.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240901171317.bm5z3vplqgdwp4bc@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>

On 08/21/24 17:59, MANISH PANDEY wrote:
> Hi all,
> 
> We agree with the points like rq_affinity can vary from target to target.
> 
> But also please consider below use cases
> 
> 1. Storage devices with single hardware queue (like UFS 2.x/ 3.x)
> in a HMP system with shared LLC, not all the CPUs will be active and online.

Is this a mainline behavior? Hotplug is not considered a normal operation . And
a CPU not being active is not something I am aware of in mainline behavior
aside from hotplug.

I think you're referring to a platform specific out-of-tree feature that is not
part of mainline linux.

> Hence for large amount (say ~1GB) of random IO transactions , if requester
> CPU is from
> smaller cpu group, then due to capacity based grouping, Large cluster CPUs
> would be mostly unused /idle, as the completion would also happen on same
> capacity CPU. Again due to this, the smaller / mid capacity CPUs only would
> have to submit and complete the request. Actually we could have completed
> the requested on large capacity CPUs and could have better utilized the
> power of Large capacity CPUs.

Sorry if I missed your reply elsewhere. But if you don't want the
rq_affinity=1 and do your custom routing, why rq_affinity=0 isn't the right
solution for custom routing behavior?

> 
> But to move IO requests from S/M cluster CPUs to L cluster, scheduler would
> need to wait until a threshold IO hits, and by that time Performance
> application would spent some runtime and would report low performance as
> overall results.

This is not an IO specific problem. Tasks that need more performance will have
to wait for utilization to grow quickly. I don't see this is a problem related
to rq_affinity=1 behavior but a generic scheduler behavior issues that is
outside of block layer.

> 
> 
> On 08/02/24 10:03, Christian Loehle wrote:
> > So I'm assuming you're seeing something like the following:
> > Some CPU(s) (call them S) are submitting IO, hardirq triggers on
> > S.
> > Before the patch the completion softirq could run on a !S CPU,
> > now it runs on S. Am I then correct in assuming your workload
> > is CPU-bound on S? Would you share some details about the
> > workload, too?
> >
> > What's the capacity of CPU(s) S then?
> 
> 
> Yes.. for few SoCs we follow the same.
> Say an SoC with 3 clusters ( S/M/L), if M CPU(s) are submitting IO requests
> ( which is a large data transfer), then in this case since LLC is shared, we
> can allow L CPU(s) to complete the request via softirq / hardirq. This will
> make sure to avoid contention in submission and completion path.

So in this case you want rq_affinity=0?

> 
> 
> Again consider an SoC with 2 clusters ( 4 cpus of small capacity  / 2 CPUs
> of Mid capacity).
> In such case, if M CPUs are used for IO submersion and completions, then
> these CPU would face heavy work load and hence Performance will be impacted.
> Now if the new patch was not there, we could have moved few IO completions
> to S cluster CPUs.

And on this different system you want rq_affinity=1?

I still don't see why you must use rq_affinity=1 for your custom routing which
AFAICT is outside of the supported realm. We have no clue this is contention or
not. It seems you have other larger logic that does custom software in many
layers and I don't think what you're doing is part of what's supported.

Could you help contributing patches to help detect contention problems and how
we can differentiate between the two scenarios instead of hacking rq_affinity=1
?

> 
> > If no matching is required, it makes sense to set rq_affinity to 0.
> 
> > I don't get why irq_affinity=1 is compatible with this case? Isn't
> > this custom
> >setup is a fully managed system by you and means you want >rq_affinity=0?
> What
> >do you lose if you move to rq_affinity=0?
> 
> actually rq_affinity=0 would help for few SoC's having MCQ like UFS 4.x, but
> even this won't be generic solution for us. As this won't considers an SoC
> which doesn't shares LLC, and thus would have significant performance issue.
> Also since the change is picked up in all the kernel branches, so it would
> be very difficult to experiment on older Socs and get the best solution for
> each target.

This is a userspace knob. I don't think the expectation to ship one
configuration for all SoCs...

> 
> This won't work for many SoCs like above example of 2 clusters, as
> rq_affinity to 0 would then complete the request on hardIRQ context, which
> may not be suited for all the SoCs.
> Also not all SoCs are arm based and shares LLC.

Why you can't modify the value based on the SoC? The only thing I am gathering
from your arguments is that you can't modify rq_affinity to suit the setup the
SoC requires, but I don't get why.

> 
> 
> 
> 2. Storage devices with MCQ (Like UFS 4.x / NVME), usages ESI/MSI
> interrupts, hence we would have opportunity to bind ESI IRQ associated with
> an CQ.
> 
> 
> On 08/05/24 10:17, Bart Van Assche wrote:
> > On 8/4/24 7:07 PM, Qais Yousef wrote:
> > > irqbalancers usually move the interrupts, and I'm not sure we can
> > > make an assumption about the reason an interrupt is triggering on
> > > different capacity CPU.
> > User space software can't modify the affinity of managed interrupts.
> > From include/linux/irq.h:
> 
> > > >True. But this is special case and was introduced for isolated
> > > > CPUs. I don't think drivers can request this themselves
> 
> There are drivers, which can manage the cpu affinty for IRQs
> using irq_set_affinity_hint() based on the use case.

Are these in tree drivers? I'd love to learn how the use case is detected
generically if this is in tree.

> Since in the SoC's the LLC is shared ( M and L clusters). So if IO is
> submitted from M capacity CPU(s), and request is completed on L capacity
> cpu(s). Though the capacity of M and L is different, but since the LLC is
> shared, so completion can be done on L cluster without the need of IPI. With
> the new change, we may not get advantage of shared LLC.

How come? The LLC is shared on mid and little. It wouldn't make a difference
which CPU handles it to take advantage of LLC. What did I miss?

> 
> Proposed solution:
> We can have a solution which is backward compatible and a new control flag
> (QUEUE_FLAG_SAME_CAPACITY_FORCE) could be provided for this new change to
> maintain backward compatibly.
> 
> How about introducing a new rq_affinity ( may be rq_affinity = 3) for using
> cpus_equal_capacity() using new flag QUEUE_FLAG_SAME_CAPACITY.
> 
> 
> if (cpu == rq->mq_ctx->cpu ||
> 	(!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
> 	  cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> +	  (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq->q->queue_flags))
> 	   && cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> 		return false;
> 
> 
> 
> Could you please consider raising similar change, if this seems fine for
> all.

This is a hack to workaround the fact that you seem to not want or for some
reason I am unable to get yet can't change rq_affinity setup to suit the need
of the platform.

AFAICT we don't have any knowledge about contentions to automatically decide
the best way to route handling completion. It'd be a welcome addition if you
have a solution that can teach the system to handle this automatically. But in
your case it seems you have a lot of custom setup that is not part of usual
upstream handling and would like just to keep backward compatibility for
reasons I am unable to make sense of yet :(
