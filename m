Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF624
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163781; cv=none; b=X1kxuvAs6IzZ/g6RZ7je9P7dhNUottvx66yda9SwfrM/sTRdznjB2ewY9ELIILmE+MS+McOPr6nUJGxZtdS6VWxd9WBkzP2rj7uEyN1mbClxWgHoCCf7b33iWsdluR7OySUs518ZG9LOX83vhyi9vifSA0EmI1l+veOi9PotcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163781; c=relaxed/simple;
	bh=khdDlRX1dG+CG1oneQpdEXKE/91sOensqqc9izeduAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8IKcTtdfNBxqrvxtYUSNoie2HsMFqd5pp62yD945nVriLXwTlDHL3nveuDTgG8s5p8+KFAnAXoUrKnl7PlBP3c1D+dFMOL7JCVS37gxRjsF8A9sK+1ifHaiEMn0NDMlZxMHxVxCxH2d9xyM0A4Z8mEm0Xzls0Mn6uRNwHram/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=liyZ+MmM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="liyZ+MmM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428141be2ddso11010625e9.2
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 17:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723163778; x=1723768578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQhqcyZH+yNzmtWCSXazQBOSfvT3/aQNFQtDCXjmi/4=;
        b=liyZ+MmMU+R4D2eEReFwP8b62SPHIEBLr0RMGbMnU1sRYwukW/fFIrS2uShltDncTG
         FXdqSg+VJRGM0uaeej2PxowmF/ECtkLY/NW9qsePH76yn3XO8hZO0I9vlVJHPbjOTAId
         8OMZuYtuNQn2hm7FnMgur10YSuM231RcqWLs/SSj62FCXi3vfZKk1Jxc53/Z/Oqk7NlA
         EWRfySReErUxrAPbdoG+qPR/q7pLznjH/7DRWlgSTJ+1BBWrBr/Z/hW3RnWIqgamLCpy
         +70QjvhApH0gcnnRMvLtPP7krnE9JIOiqbRdRUYGiDlxcRnK7FLz+EoDx1cRUYU9rFIh
         EMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163778; x=1723768578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQhqcyZH+yNzmtWCSXazQBOSfvT3/aQNFQtDCXjmi/4=;
        b=M/VgyQXT9Ex/VmSBNDbD1mVQM0ZsLoc8DSG3e/vyhUSBZ1o6uMfB/owHXOrlNhWJN1
         nSz0PFgUJaFmCECE+uKxAfK2mZIpJLUC6kak6EDBjjIXk3G4BKAk9lOW1WhZl9tQX/ww
         YH2jw/YMEnqeprkn2BBtiPxgruyq5w5gG0W6ikKTVguOWKy0JTqIC2Nac8N7Utt0bXnY
         xqXHAQEKnEH2NdNe/BED+WnCnjQYPLP0yd3FL2OhiSCoyvVpwQQr0EMzeC/tgdVpkFJh
         m7wVqIh9gxk9XfYCqPVg5frHNOQdkH5U2Sd6sKhCq0OrOw05IAk8fciuUAYAFtovm60w
         jdBw==
X-Forwarded-Encrypted: i=1; AJvYcCXlVIkzOrSSLanJxiSVy4SFgVa+P0GIVx9Qatddeqj9R+hogVAWfo3BhXPas1XgPTRbNhzy8MjXqv9f4WlEtl0yR7d8q4k06qJt3R4=
X-Gm-Message-State: AOJu0YyhSOU5Cir/GlX44U/EY6rNDC+dgXZMhnUxeWeV0cC0Z/4bGBSN
	6o8MmaFo6BgpivGOEVpFv5heZ3muloxvMJcwE7lVRmB9LZo3dcXklWQK60PlFq6kVNKRpdADg1r
	t
X-Google-Smtp-Source: AGHT+IHKiYhfqlKpCaTu3Q9UVY9eahW7ThLgHvgxwiy3oOFNoMql6MjYrhvg5lFB10mvqfvNV0tjRw==
X-Received: by 2002:a05:600c:4f0d:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-4290af3b106mr24280945e9.27.1723163777796;
        Thu, 08 Aug 2024 17:36:17 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm101107545e9.23.2024.08.08.17.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:36:17 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:36:16 +0100
From: Qais Yousef <qyousef@layalina.io>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240809003616.nhnhxy23hgjrx3jt@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>

On 08/08/24 11:35, MANISH PANDEY wrote:
> 
> 
> On 8/5/2024 11:22 PM, Bart Van Assche wrote:
> > On 8/5/24 10:35 AM, MANISH PANDEY wrote:
> > > In our SoC's we manage Power and Perf balancing by dynamically
> > > changing the IRQs based on the load. Say if we have more load, we
> > > assign UFS IRQs on Large cluster CPUs and if we have less load, we
> > > affine the IRQs on Small cluster CPUs.
> > 
> > I don't think that this is compatible with the command completion code
> > in the block layer core. The blk-mq code is based on the assumption that
> > the association of a completion interrupt with a CPU core does not
> > change. See also the blk_mq_map_queues() function and its callers.
> > 
> IRQ <-> CPU bonded before the start of the operation and it makes sure that
> completion interrupt CPU doesn't change.
> 
> > Is this mechanism even useful? If completion interrupts are always sent
> > to the CPU core that submitted the I/O, no interrupts will be sent to
> > the large cluster if no code that submits I/O is running on that
> > cluster. Sending e.g. all completion interrupts to the large cluster can
> > be achieved by migrating all processes and threads to the large cluster.
> > 
> >> migrating all completion interrupts to the large cluster can
> >> be achieved by migrating all processes and threads to the large
> >> cluster.
> 
> Agree, this can be achieved, but then for this all the process and threads
> have to be migrated to large cluster and this will have power impacts. Hence
> to balance power and perf, it is not preferred way for vendors.

I don't get why irq_affinity=1 is compatible with this case? Isn't this custom
setup is a fully managed system by you and means you want rq_affinity=0? What
do you lose if you move to rq_affinity=0?

> 
> > > This issue is more affecting UFS MCQ devices, which usages ESI/MSI
> > > IRQs and have distributed ESI IRQs for CQs.
> > > Mostly we use Large cluster CPUs for binding IRQ and CQ and hence
> > > completing more completions on Large cluster which won't be from
> > > same capacity CPU as request may be from S/M clusters.
> > 
> > Please use an approach that is supported by the block layer. I don't
> > think that dynamically changing the IRQ affinity is compatible with the
> > block layer.
> 
> For UFS with MCQ, ESI IRQs are bounded at the time of initialization.
> so basically i would like to use High Performance cluster CPUs to migrate
> few completions from Mid clusters and take the advantage of high capacity
> CPUs. The new change takes away this opportunity from driver.

It doesn't. You want to fully customize where your completion runs without any
interference from block layer from what I read. Disable rq_affinity and do what
you want? Your description says you don't want the block layer to interfere
with your affinity setup.

> So basically we should be able to use High Performance CPUs like below
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..a4a2500c4ef6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct
> request *rq)
>         if (cpu == rq->mq_ctx->cpu ||
>             (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>              cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> +            arch_scale_cpu_capacity(cpu) >= 	
> arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>                 return false;
> 
> This way driver can use best possible CPUs for it's use case.
> > 
> > Thanks,
> > 
> > Bart.
> > 
