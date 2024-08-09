Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9814431
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163006; cv=none; b=E028wA8iS41mBvBGja7MFoMN8l83Uj6byqPIRae4Y4n+vfWp9vvIsSnQHfbStM5Gy1t3Bzm3x8roph8zFsQ2cNd16N3fHmGoUnxQBzJhaP3299R7Hr3qhmdGDVgB1ZDuZo1dEfNxTd/TM/JpcJ3w6CtVF0ndpY4O9irj+PJzsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163006; c=relaxed/simple;
	bh=0P3FLHEXhmSjg6tnD5HmluFLz1yQVYbEMJkASKuVmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUexjhqzmU3GFtZmaoskUHxdUmLvo7l32Y0iIUmq/jYiEQOvXmSjNpyS3yVwbU1ZCiEKnBLG70oCF9zZCZgxopMuNFQe08F5i0kSyrsJyLCgYqZ+Sc7HZTYsa94Ykv8VNdCLrtDts8bauARc1egi+hM2nIfbggpZnOpyflFwbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=S+Tm3mG2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="S+Tm3mG2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so8709715e9.1
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723163003; x=1723767803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AztV0lLOwdqI9QgaMB1DKaQg1Otgpzmj+Q3BL6hIbiw=;
        b=S+Tm3mG2vnDB1XUDOirXdpmYBPzW3fNOCpS6/cMxIC8OSKTZWnRhHPwBnMWL7MHT0l
         9wmH4SSYDA3PiJXhzocbnBVt58TNFbZOARweX3POkw/1RtqGj6O6QVOP/ku2CqSckmy4
         o2nQ198BQsceiavndzoJ2Ob8kJweZnTBG4ysLs0mFoRQaGQKYfkuhyZUNb+8DLCOEo2E
         BfkT0dAl6rNyYFkT2CsfGlvcrYLWv6AShtEyB4eW2T3ptV819yuLAb/NInXlSXkyO2DG
         yvGRMT6AykfT0fVvBvW6N2HSaLFBOaDxP7Quec1KGfJPi1jZb87Wip3ir+liARZv8QzD
         3olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163003; x=1723767803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AztV0lLOwdqI9QgaMB1DKaQg1Otgpzmj+Q3BL6hIbiw=;
        b=kuKspjWB4BOLZtXg1mCVlXxmZkLwvNuAHaYe+7mdCI14BpiV8lE31/xobWoRBt5ark
         WezPX9nq/UqWvqDKB3rm2rfkcqu0zPhpljbJa3M2iF1c9sZOxkthbx/t5CCITkamRHXZ
         wlxVZWuS2sG8DUlvIt66ScZtvQjBrxpYR/zfX6XCmrIkbobmjZIygLQVNbrefZeaYWI4
         8+wsT3p85aB4Fh4eIXgv8c6mLYJrTGyurwb1KxJke1AEWujZVxqOszak1KU30aA1J6w5
         W765g9+GzfKOvoK63hmu4fYiW0yNCQi5w8e6YjjIzKXfNCw0iAHNyOdz93s2YUZGUN3b
         /ICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaidO5t6wP5TMr25KEKjCyl58l2bC4Nv9CAeOgxu2FMxUTGURXCNBKxxS8/JrvdcPQtIBxk1njYfVefBBr5prGhrGqokcXqL34P4w=
X-Gm-Message-State: AOJu0Yx7cPExGBcAOcBxkwB2tjUG76RDVrurKX/pmwushUYJ5OPELA8O
	JZUdv8Y7nveY+m3KNRHcST7Qt0MLH3ord4gNTc2giknxj14SNbiozTjOL5rTYgA=
X-Google-Smtp-Source: AGHT+IFhtIaMHgpaLbc/67n498umxhIehCq9XMMin3UEfUmJ9TNAhBCQfHnOGbQfT6vxAKG5iDaSOw==
X-Received: by 2002:a05:600c:548d:b0:424:7871:2e9e with SMTP id 5b1f17b1804b1-4290b8480femr29464695e9.6.1723163003296;
        Thu, 08 Aug 2024 17:23:23 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d4c9sm49708995e9.8.2024.08.08.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:23:22 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:23:21 +0100
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
Message-ID: <20240809002321.3k5g2isqmiuflrmd@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>

On 08/05/24 11:18, Christian Loehle wrote:

> > My understanding of rq_affinity=1 is to match the perf of requester. Given that
> > the characteristic of HMP system is that power has an equal importance to perf
> > (I think this now has become true for all systems by the way), saying that the
> > match in one direction is better than the other is sort of forcing a policy of
> > perf first which I don't think is a good thing to enforce. We don't have enough
> > info to decide at this level. And our users care about both.
> 
> I would argue rq_affinity=1 matches the perf, so that flag should already bias
> perf in favor of power slightly?

Not on this type of systems. If perf was the only thing important, just use
equally big cpus. Balancing perf and power is important on those systems, and
I don't think we have enough info to decide which decision is best when
capacities are not the same. Matching the perf level the requesting on makes
sense when irq_affinity=1.

> Although the actual effect on power probably isn't that significant, given
> that the (e.g. big) CPU has submitted the IO, is woken up soon, so you could
> almost ignore a potential idle wakeup and the actual CPU time spent in the block
> completion is pretty short of course.
> 
> > If no matching is required, it makes sense to set rq_affinity to 0. When
> > matching is enabled, we need to rely on per-task iowait boost to help the
> > requester to run at a bigger CPU, and naturally the completion will follow when
> > rq_affinity=1. If the requester doesn't need the big perf, but the irq
> > triggered on a bigger core, I struggle to understand why it is good for
> > completion to run on bigger core without the requester also being on a similar
> > bigger core to truly maximize perf.
> 
> So first of all, per-task iowait boosting has nothing to do with it IMO.

It has. If the perf is not good because the requester is running on little
core, the requester need to move up to ensure the overall IO perf is better.

> Plenty of IO workloads build up utilization perfectly fine.

These ones have no problems, no? They should migrate to big core and the
completion will follow them when they move.

> I wouldn't consider the setup: requester little perf, irq+completion big perf
> invalid necessarily, it does decrease IO latency for the application.

I didn't say invalid. But it is not something we can guess automatically when
irq_affinity=1. We don't have enough info to judge. The only info we have the
requester that originated the request is running at different perf level
(whther higher or lower), so we follow it.

> Consider the IO being page faults (maybe even of various applications running
> on little).
> 
> > 
> > By the way, if we assume LLC wasn't the same, then assuming HMP system too, and
> > reverting my patch, then the behavior was to move the completion from bigger
> > core to little core.
> > 
> > So two things to observe:
> > 
> > 1. The patch keeps the behavior when LLC truly is not shared on such systems,
> >    which was in the past.
> > 2. LLC in this case is most likely L2, and the usual trend is that the bigger
> >    the core the bigger L2. So the LLC characteristic is different and could
> >    have impacted performance. No one seem to have cared in the past. I think
> >    capacity gives this notion now implicitly.
> 
