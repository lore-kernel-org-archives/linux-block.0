Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241326AE8
	for <linux-block@vger.kernel.org>; Sun,  1 Sep 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211536; cv=none; b=mFVO3ATEDaWyclX7DLTYLlL+GSmx0i4Y7AxLFPOMyQwMa2beFp/f9hdp4aTLCfTvZEIuIEImv+/HvtREh99oQFTLMGgn9sGLztwbrh04Gy2mxp+2PLC7oSHYRYQ3c9bapIdgOngjLhPIglCPMUPE1pfcd1ivSyRAGB/5EJK4Yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211536; c=relaxed/simple;
	bh=0PGB+WH5uh80lPMAZnLiMQ/5N8+gF2anJLQq8QDJIxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZpC1CDFFm3zleQM+yAFsgXHlitXpvbuJ2yy6ONBlnOB48JggqJVW5oKhNYIjDveAl9hYhpELn8OJBWe1GYGWFWdhO3xyQIqSUhF6rXAwkWUWlmGRUPqRVdRA6TkZ3EJ97rpVnekEvvb01qyAGeWkSvnWToRL8D3qLIV/96a08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=u0/cUNPg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="u0/cUNPg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86b46c4831so374101566b.1
        for <linux-block@vger.kernel.org>; Sun, 01 Sep 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725211533; x=1725816333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6swxwBAIVtqp8OLyRprRpd+2EVyaZpcS0JvCJqnS+X8=;
        b=u0/cUNPg1rwWUMoXW2MrQc/7z6O8rAf7kNnXR0sWJWR7Z8L9r4ujkv5zdPC5gWBYfY
         rxhSI0Gp3T8Me0s3j/rev7ElGJygLvUMHtES7dYD2yxH2oAy5+H639pdsftNGW/aMQvx
         f6AklbIWVtJBHIB+Yxj9I1cKvn7S7UMN1OT11L+VhigLvfhps7eWlNdV3AQ4VI+6nNta
         xgQzxdYIjrmxc8n9lSpfxrrKewso0W3AWgrNsaFhJhxmIx5jrpLNHi9P7ztDHyZrTMsG
         Pc2Pc4RT40LR1p/0RqDb8SFkDfb5NmbLLjHh+hFJhCe/8oreRLN2Q+wE7rhlES9vsM3U
         Eosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725211533; x=1725816333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6swxwBAIVtqp8OLyRprRpd+2EVyaZpcS0JvCJqnS+X8=;
        b=cJAxiYtrXBO2gPG9u7ugUPAvpdJB69lXQJVXI9Ji7c39sItmBE9erZZrDbvPg6sV5o
         ABy6L5fkO17EeYQkd+QTH80hCeuFcnkBbCOVQxDYe0ovYf/KitMg/asbOzDqvvpXTOTb
         LeZGaCmNbJ8eZfy32slcE4scb7hMwKbTEocDfzO6SOPg2fv/6EMDMrcYkTrrKw4aAr/o
         qkxssRj8LmhXBbPGAXOU0pdkn32SeYQjnSiHs3mfYUN/ny20dS0IYAM/OXEo+4uE40wJ
         WPcwn8eg43B/0BMoN9iPupqB5umN1CaTfhVq3aA4fzQffZfEOLX+XOIFe/xXLR5t+uqa
         Zq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWochukKvhDILYf8cV0OueMOHKuZ/3Me48xJw2Rqnu5HBQDWWwHGKIDHoV8ZDZ56Uf6R6i8/3BecuEyoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysSI5zbBpKC6DLwQAs9+VmBWKThKttLRiccN4GUpvC5balJcvj
	GI5KBA7ZFU3NR/2gnoup2lfmJYSGwmAwuFuVssLv7HUMKfNkBiW2Dnwrwj1omdA=
X-Google-Smtp-Source: AGHT+IErkXEZytp4CJ4TWeGE3ba+YJc9CoZRTU+x//ajwTFgINBp0o96c9++n/vuCL/hX0RjaYywHA==
X-Received: by 2002:a17:907:1c20:b0:a86:8059:58a8 with SMTP id a640c23a62f3a-a89d879c672mr244627966b.38.1725211532478;
        Sun, 01 Sep 2024 10:25:32 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dc6a1sm463223866b.175.2024.09.01.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:25:32 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:25:28 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: MANISH PANDEY <quic_mapa@quicinc.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240901172528.2ab6yatjmfvlrfjt@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
 <20240809002321.3k5g2isqmiuflrmd@airbuntu>
 <a225f9e0-5335-4c58-8e94-960c2557f9c0@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a225f9e0-5335-4c58-8e94-960c2557f9c0@arm.com>

On 08/13/24 17:20, Christian Loehle wrote:
> On 8/9/24 01:23, Qais Yousef wrote:
> > On 08/05/24 11:18, Christian Loehle wrote:
> > 
> >>> My understanding of rq_affinity=1 is to match the perf of requester. Given that
> >>> the characteristic of HMP system is that power has an equal importance to perf
> >>> (I think this now has become true for all systems by the way), saying that the
> >>> match in one direction is better than the other is sort of forcing a policy of
> >>> perf first which I don't think is a good thing to enforce. We don't have enough
> >>> info to decide at this level. And our users care about both.
> >>
> >> I would argue rq_affinity=1 matches the perf, so that flag should already bias
> >> perf in favor of power slightly?
> > 
> > Not on this type of systems. If perf was the only thing important, just use
> > equally big cpus. Balancing perf and power is important on those systems, and
> > I don't think we have enough info to decide which decision is best when
> > capacities are not the same. Matching the perf level the requesting on makes
> > sense when irq_affinity=1.
> 
> Well you could still want a
> "IO performance always beats power considerations" and still go HMP because
> sometimes for non-IO you prefer power, but I agree that we don't have enough
> information about what the user wants from the system/kernel.

The flag was to keep requester and completion on the same LLC. Note the keyword
same. Assume L3 don't exist and L2 is LLC which means capacity level and LLC
mapping to cluster is the same.

Then note that the capability of the LLC is different since the big clusters
tend to have larger L2. I think modern SoCs for servers can end up with complex
LLC not all of which have the same performance.

Keeping requester/completion on the same capacity keeps the old behavior. To
teach it to do more then we need sensible extensions based on sensible use
cases. And not hack rq_affinity=1 to do complex things.

> 
> > 
> >> Although the actual effect on power probably isn't that significant, given
> >> that the (e.g. big) CPU has submitted the IO, is woken up soon, so you could
> >> almost ignore a potential idle wakeup and the actual CPU time spent in the block
> >> completion is pretty short of course.
> >>
> >>> If no matching is required, it makes sense to set rq_affinity to 0. When
> >>> matching is enabled, we need to rely on per-task iowait boost to help the
> >>> requester to run at a bigger CPU, and naturally the completion will follow when
> >>> rq_affinity=1. If the requester doesn't need the big perf, but the irq
> >>> triggered on a bigger core, I struggle to understand why it is good for
> >>> completion to run on bigger core without the requester also being on a similar
> >>> bigger core to truly maximize perf.
> >>
> >> So first of all, per-task iowait boosting has nothing to do with it IMO.
> > 
> > It has. If the perf is not good because the requester is running on little
> > core, the requester need to move up to ensure the overall IO perf is better.
> 
> See below but also
> "the requester need to move up to ensure the overall IO perf is better" is
> just not true, with asynchronous IO submission done right, the submission

I think it is true for rq_affinity=1, which is the context of the discussion
and the patch.

> runtime isn't critical to the IO throughput, therefore it should run the
> most power-efficient way.
> This can be observed e.g. with any io_uring fio workload with significant
> iodepth (and possibly multi-threading).
> Completion may be a different story, depending on the device stack, if we're
> dealing with !MCQ then the completion path (irq + block layer completion)
> is absolutely critical.
> For any mmc / ufs<4.0 system the performance difference between
> fio --name=little --filename=/dev/sda --runtime=10 --rw=randread --bs=4k --ioengine=io_uring --numjobs=4 --iodepth=32 --group_reporting --cpus_allowed=$LITTLE_CPUS
> and
> fio --name=big --filename=/dev/sda --runtime=10 --rw=randread --bs=4k --ioengine=io_uring --numjobs=4 --iodepth=32 --group_reporting --cpus_allowed=$BIG_CPUS
> is (usually) only because of the completion path and setting irq affinity of
> /dev/sda to $BIG_CPUS will make the difference disappear (rq_affinity=0 and
> implying LLC is the same).
> Running the submission on little CPUs will usually be the most power-efficient
> way then.

From rq_affinity=1 context, how it is supposed to discern all of that? If
there's a good answer to this, then this is the direction that should be taken
to handle it transparently. AFAICT we don't have this info.

> 
> > 
> >> Plenty of IO workloads build up utilization perfectly fine.
> > 
> > These ones have no problems, no? They should migrate to big core and the
> > completion will follow them when they move.
> 
> So if I understood Manish correctly the only reason they want the completion
> to run on a bigger CPU than the submission is because the submission is already
> saturating the CPU, therefore utilization of submission is no issue whatsoever.
> They don't want to run (submission) on big though because of power
> considerations.

Is this what rq_affinity=1 means? This use case is rq_affinity=0. IOW, custom
affinity management.

> 
> > 
> >> I wouldn't consider the setup: requester little perf, irq+completion big perf
> >> invalid necessarily, it does decrease IO latency for the application.
> > 
> > I didn't say invalid. But it is not something we can guess automatically when
> > irq_affinity=1. We don't have enough info to judge. The only info we have the
> > requester that originated the request is running at different perf level
> > (whther higher or lower), so we follow it.
> >
> Anyway, Manish's problem should be solved by rq_affinity=0 in that case (with
> irq affinities set to big CPU then the completion will be run on the irq CPU)
> and "rq_affinity=1 <=> equal capacity CPU" is the correct interpretation, is that
> more or less agreed upon now?
> 

I think this is the sensible route. The sensible extensions I foresee is
teaching how to discern different cases rather than add a hacky flag to confuse
what rq_affinity=1 means.
