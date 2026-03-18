Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1E3BED11
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839425; cv=none; b=K0J8aujpOh4B5FQuNLog4pfG/AM8WGid9g4nUO0jIjZN8WfPqWiALJAjkCphStdUHdEU7MntgvHkyxINZ1hJSOAfJ7A78EqSlZNItYyOk8OYg6rWibiHU2M1LKOxyoM2gprEF8mklo3PvPJCNrx62sbiicEgkySkBoPDnsJfSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839425; c=relaxed/simple;
	bh=8oxQdEISpfMHOhL/4ZF74UZJjYAXbm3WfrrkEQ63noc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MOAFBXCqlW/2NKReb0wfAYMIT0nGCBtPHxf3CJ+ZpfQckNRLpCQsoeaVS1f4HZziPS74AkKz++nmJQbjUwi25dt8jVGDM9uQpADfHNl2vhLfLO55IA37r/cwBgRcHieKlJQ7/i/AKFCz7K/Lt97oCJPvNUwsGrrwrT7BHAt+Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Inob2Fub; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPKOImA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Inob2Fub";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPKOImA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773839423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87mlS3zeTTCtWqzXl89MNXTW6Xcc0f3FIlJL2cvovbM=;
	b=Inob2Fubh6dwvEYCHC5hghQYzVL+UbGUCvy4LMYAfRdC52k9nxTXIxDnOuZbXxykg4/+XD
	iXCNtOCrdAN4WX0rUwcaHBf+OHRrVvNQyZUSAGMyjwm5zW0hiy1U7ZQ0NDOK92E6qsd/S0
	y/X0K0zTWhsLQ7qneBlzkpHLGfAHMm8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-06GABAx0PQ2zJYdPAEti5w-1; Wed, 18 Mar 2026 09:10:22 -0400
X-MC-Unique: 06GABAx0PQ2zJYdPAEti5w-1
X-Mimecast-MFC-AGG-ID: 06GABAx0PQ2zJYdPAEti5w_1773839421
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7de0e161so4574715685a.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773839421; x=1774444221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=87mlS3zeTTCtWqzXl89MNXTW6Xcc0f3FIlJL2cvovbM=;
        b=JPKOImA11vmamzBk31TNY4DFj2qPBuIGG8bs7W+XLP9gkkcaMaX7ewndrQ0qZU6up1
         p3GSqgsY68FrSghh54hgCc6RILCkBFSMxGUDEKr0G1jwaHd3v1o/bzs+lozNLuKf1j3H
         YXDzsV1LHJ7LN0NdQBCs2qVh1Ahm6k2hPJ3GC9QytpEwNERFxB5YMagGEUEas42wmRBV
         Isxg7fGlRglYJNT+7HDzL5ZPwqZLO6Cq5Q8EUATriF5AQKyifweP62s6bEhIlyXBLFYL
         ixDRlQMlb+uXyQh2aa1QFXSEMIRI+W0XdVCyEyryJhdRbQCEQHFR/hQMz2yQ9uQrYsFA
         kYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839421; x=1774444221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87mlS3zeTTCtWqzXl89MNXTW6Xcc0f3FIlJL2cvovbM=;
        b=kkWH3aM+AqRdY8j5hXbQFAscjpXk2VzEeOtapTgMIfqd0IZxj/PDUxSoEQDkdHMTmG
         WM2x2299uJ//KHA1U2n5zrgUT12D1bubsL6pOciZaJJsQW2HTwGMnwT2mNIIKCDCKW3h
         MSn1BCXPyFcau1TP3WLWy2FJwUf0FtvfaUxBaDWJhlS2rIPRNW+UpIdE0WUzhAjkiY1P
         PPH3BQBj4e6C9/enPjvHWkgtonQWJPt+eXfzj8BQqNgAaGJHDuL4lfeT1bNlYP1f7ZGp
         /UER0uE7bXlFP1FB6zaqc3Q5ZkVwYqJePaDhA2DdwcbINy94f1qUOlMXoXdUMQ9f380K
         qC/w==
X-Forwarded-Encrypted: i=1; AJvYcCWabJJx85RSIqRJXJchCD/pswgwOunLTNalepPjaIGnDCHojSuzZECEP2lpYNFktLZfuujFUCPS5CBvjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrNWy00tyBjGWA7K5naRRsEYOy1kEFR0Fyluqhf892LwFm9Hk
	ZTyw9wjUYWU6kL3BPZxwOmpPxYfjBZIFNC4Hk3n6+Ubg+T18aYMvI52EUpIxLsY17kKZ+9eZizq
	CMppSksHRAwAUH87HY3//VRHx+3vzQ4gTDqhRB5+0BzCl9U5YPAdJo4XFmxOwAVaDuZNkzjpX
X-Gm-Gg: ATEYQzzRaEVjymrPGBPT+71V5PXinP2ilQuMuJub/OxXa5Cnwbb23kew8ldGC5r4uR7
	Osj9LfcD6tNCvsxaFDvDFMG3XRlv9N8DMN1auss73XB3R0CMbJ2mmWiUFfm/Kx186CsYqyhHMQC
	ZDerekxRyOZarzFsi5TtzHSvPimLVEtJ0XKtwVGww72ZQfqIebYRI+FSTQNVR4nlUSb6z+LQerP
	SqXQ1A/yidoXyoS1QNuH5knJ9NuEzhvQbjSifCLWI+2byBEjoG3H+h+nOd9uJRrqGyLsR9Df0uU
	dbP24bkXmyahrOwSyyjaw0rmx6Ja3g2SGzTCVWWH41AnNmAlR8T/DTWRYN3wB/dNrAbC7/tDxAv
	LlZz3nbhCuqaosqWUGYx9jpshebkCCvw/qA3Z5NPBV6hbcyX3HRqUqAUgY2U=
X-Received: by 2002:a05:620a:254f:b0:8cd:b3dc:9d4e with SMTP id af79cd13be357-8cfad259557mr439906185a.32.1773839420811;
        Wed, 18 Mar 2026 06:10:20 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:8cd:b3dc:9d4e with SMTP id af79cd13be357-8cfad259557mr439899885a.32.1773839420260;
        Wed, 18 Mar 2026 06:10:20 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacdeb9edsm210216285a.17.2026.03.18.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:10:19 -0700 (PDT)
Message-ID: <01a554a9aca3ce03cfe6b60200d80dab975bb644.camel@redhat.com>
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
From: Laurence Oberman <loberman@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 	axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 18 Mar 2026 09:10:17 -0400
In-Reply-To: <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
References: <20260317182835.258183-1-atomlin@atomlin.com>
	 <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 08:38 +0900, Damien Le Moal wrote:
> On 2026/03/18 3:28, Aaron Tomlin wrote:
> > In high-performance storage environments, particularly when
> > utilising
> > RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED),
> > severe
> > latency spikes can occur when fast devices (SSDs) are starved of
> > hardware
> > tags when sharing the same blk_mq_tag_set.
> >=20
> > Currently, diagnosing this specific hardware queue contention is
> > difficult. When a CPU thread exhausts the tag pool,
> > blk_mq_get_tag()
> > forces the current thread to block uninterruptible via
> > io_schedule().
> > While this can be inferred via sched:sched_switch or dynamically
> > traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
> > dedicated, out-of-the-box observability for this event.
> >=20
> > This patch introduces the block_rq_tag_wait static tracepoint in
> > the tag allocation slow-path. It triggers immediately before the
> > thread yields the CPU, exposing the exact hardware context (hctx)
> > that is starved, the total pool size, and the current active
> > request
> > count.
> >=20
> > This provides storage engineers and performance monitoring agents
> > with a zero-configuration, low-overhead mechanism to definitively
> > identify shared-tag bottlenecks and tune I/O schedulers or cgroup
> > throttling accordingly.
> >=20
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
>=20
> Looks OK to me, but I have some suggestions below.
>=20
> > ---
> > =C2=A0block/blk-mq-tag.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0include/trace/events/block.h | 36
> > ++++++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 39 insertions(+)
> >=20
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 33946cdb5716..f50993e86ca5 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <linux/kmemleak.h>
> > =C2=A0
> > =C2=A0#include <linux/delay.h>
> > +#include <trace/events/block.h>
> > =C2=A0#include "blk.h"
> > =C2=A0#include "blk-mq.h"
> > =C2=A0#include "blk-mq-sched.h"
> > @@ -187,6 +188,8 @@ unsigned int blk_mq_get_tag(struct
> > blk_mq_alloc_data *data)
> > =C2=A0		if (tag !=3D BLK_MQ_NO_TAG)
> > =C2=A0			break;
> > =C2=A0
> > +		trace_block_rq_tag_wait(data->q, data->hctx);
> > +
> > =C2=A0		bt_prev =3D bt;
> > =C2=A0		io_schedule();
> > =C2=A0
> > diff --git a/include/trace/events/block.h
> > b/include/trace/events/block.h
> > index 6aa79e2d799c..48e2ba433c87 100644
> > --- a/include/trace/events/block.h
> > +++ b/include/trace/events/block.h
> > @@ -226,6 +226,42 @@ DECLARE_EVENT_CLASS(block_rq,
> > =C2=A0		=C2=A0 IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry-
> > >comm)
> > =C2=A0);
> > =C2=A0
> > +/**
> > + * block_rq_tag_wait - triggered when an I/O request is starved of
> > a tag
>=20
> when an I/O request -> when a request
>=20
> > + * @q: queue containing the request
>=20
> request queue of the target device
>=20
> ("containing" is odd here)
>=20
> > + * @hctx: hardware context (queue) experiencing starvation
>=20
> hardware context of the request
>=20
> > + *
> > + * Called immediately before the submitting thread is forced to
> > block due
>=20
> the submitting thread -> the submitting context
>=20
> > + * to the exhaustion of available hardware tags. This tracepoint
> > indicates
>=20
> s/tracepoint/trace point
>=20
> > + * that the thread will be placed into an uninterruptible state
> > via
>=20
> s/thread/context
>=20
> > + * io_schedule() until an active block I/O operation completes and
> > + * relinquishes its assigned tag.
>=20
> until an active request completes
>=20
> (BIOs do not have tags).
>=20
> > + */
> > +TRACE_EVENT(block_rq_tag_wait,
> > +
> > +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx
> > *hctx),
> > +
> > +	TP_ARGS(q, hctx),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(
> > dev_t,		dev			)
> > +		__field(
> > u32,		hctx_id			)
> > +		__field(
> > u32,		nr_tags			)
> > +		__field(
> > u32,		active_requests		)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=C2=A0 =3D q->disk ? disk_devt(q-
> > >disk) : 0;
>=20
> I do not think that q->disk can ever be NULL when there is a request
> being
> submitted.
>=20
> > +		__entry->hctx_id	=C2=A0 =3D hctx ? hctx->queue_num
> > : 0;
> > +		__entry->nr_tags	=C2=A0 =3D hctx && hctx->tags ?
> > hctx->tags->nr_tags : 0;
> > +		__entry->active_requests=C2=A0 =3D hctx ?
> > atomic_read(&hctx->nr_active) : 0;
> > +	),
> > +
> > +	TP_printk("%d,%d hctx=3D%u starved (active=3D%u/%u)",
> > +		=C2=A0 MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		=C2=A0 __entry->hctx_id, __entry->active_requests,
> > __entry->nr_tags)
> > +);
> > +
> > =C2=A0/**
> > =C2=A0 * block_rq_insert - insert block operation request into queue
> > =C2=A0 * @rq: block IO operation request
>=20

This visibility will be very useful. I plan to test it fully.
Updates to follow
Thanks
Laurence Oberman

