Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393323BB
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163295; cv=none; b=VEGPRiRnAWL34lSQDd6odvfxuH0kSWMPXF0VgbDfX2MuB9dn3F7/xBST67ShmOt138vRuCDV38rweiDxyyPO3ycEv2NkoqCYewFEmnNyTtuWZiWdtYM9D72GXR1jxzGQi5eGHxNjQdBV94GPofRlvoq1uRY1nimB0AlcxMxWKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163295; c=relaxed/simple;
	bh=01rLBHPepfNn4nMOe1RF2EsHZFX3tpjMG3hFdzuwxUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+wq9WtvhYVJfivbGUnN6jq+gGqjDTQCUNaPBpBNXLWtZFNCaE4TI3qm4Rg4gADclJhusBeRQqMFOtvp9/6RNHuKkp1SBCwIvM/IlMMmivbbWIsEeu3fvbfE+/zTtA3v3Nqt54ZyotXXsb2zMfGMvrWDXOkvRla4412R7VtzckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=pWHz5SW/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pWHz5SW/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso11147605e9.0
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723163292; x=1723768092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xM8a7T2xqqc8VcrzcsbnwlGmVeLYc19FUhA9Zh8M04=;
        b=pWHz5SW/xFtJw46PzGl2PjNlZEAPeCuUU2V42I3pxwSknrgXj4ElRGLUnNNN0x9n7H
         WnlDzCPTVI9EjraPaWcn+aaih0+Abx21k0ZPfKLYSrTUWWnBesN96HC/iwqhJXTeZAqW
         nINLc5WNQODufBVMEnBV7I9DJaT++dgKgzu9IjdkBJaWYSuaX7GNtB5Cg/14s5bw/0xd
         +/D40hBL19u+GKW7zQ81jsIOIgaRRY17+Vq5J9FiZrLJReXWRMqaW17SbLkOkFvGGgqK
         Vc5mloWMewh+ne8zHr5iUaL5gPT8SCAqffzNtNeMSbqAHSCI3CgkwCM4x208lYixzQba
         S3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163292; x=1723768092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xM8a7T2xqqc8VcrzcsbnwlGmVeLYc19FUhA9Zh8M04=;
        b=OVWroEHVj389DUl7+eHMXJ7gdT0f9aVWRg8KuEEL8tuTZqR4lHTaqRu6a6px2Ud9vN
         7+MWbLdDBj05TRcOGLEYIo7MWgqn3OSX/ii3ez3D125xom9hjxbBXoXiNfYJtg1KaQFF
         oJsPD65iNG4stpMmOeU+YZqjq81AxVWxhrtBvAigWww1i7+JSqmDAVsAD5L4D/HIgEt8
         DgLzi/jNEfR6KsiaEt1yjp4jDfJiuLj+y/rE4c72nkEyWLFVaG801UXneKFgolcIqPTk
         eVEixDa/YZYtS3KwCuF4wBKqoiwr4IpNxOGjGdzn07DiKlJw8pQMsI2Rbtj554KfUfzc
         RSZw==
X-Forwarded-Encrypted: i=1; AJvYcCWgguNkvL3c7QVavXvbdW7MVoZKeouaTfhr1fMoefokQsUel6pUzwxrcnCnt4/VKdyg9OYCQfP2S6oCmaHUJGsI3HAjyyXBeQVLEMY=
X-Gm-Message-State: AOJu0YxjNecwmqAyEE7aVqowHrEv3z5wreuAzGgMeqCfZpVCRUsbdyGX
	2nGFTs5W+HLED9aAhcsHaXQMMzEImPyRaB4VEXDXnIRjaxdMkxQ51ZA9HfTD3mQ=
X-Google-Smtp-Source: AGHT+IHyES8ojagsoNYc460q2UZxBZ0epazI9xpwQ2Xs9FkRwpdCkOxdu//TzLm8rzuHLG28jwTJdw==
X-Received: by 2002:a05:600c:4ece:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-4290af459c3mr25866805e9.34.1723163292159;
        Thu, 08 Aug 2024 17:28:12 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059623besm96742435e9.2.2024.08.08.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:28:11 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:28:10 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	MANISH PANDEY <quic_mapa@quicinc.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240809002810.ewlrrh2v3vaaboer@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>

On 08/05/24 10:17, Bart Van Assche wrote:
> On 8/4/24 7:07 PM, Qais Yousef wrote:
> > irqbalancers usually move the interrupts, and I'm not sure we can
> > make an assumption about the reason an interrupt is triggering on
> > different capacity CPU.
> User space software can't modify the affinity of managed interrupts.
> From include/linux/irq.h:

True. But this is special case and was introduced for isolated CPUs. I don't
think drivers can request this themselves.

> 
>  * IRQD_AFFINITY_MANAGED - Affinity is auto-managed by the kernel
> 
> That flag is tested by the procfs code that implements the smp_affinity
> procfs attribute:
> 
> static ssize_t write_irq_affinity(int type, struct file *file,
> 		const char __user *buffer, size_t count, loff_t *pos)
> {
> 	[ ... ]
> 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
> 		return -EIO;
> 	[ ... ]
> }
> 
> I'm not sure whether or not the interrupts on Manish test setup are
> managed. Manish, can you please provide the output of the following
> commands?
> 
> adb shell 'grep -i ufshcd /proc/interrupts'
> adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do ls -ld
> /proc/irq/${a%:}/smp_affinity; done'
> adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do grep -aH .
> /proc/irq/${a%:}/smp_affinity; done'
> 
> Thanks,
> 
> Bart.
