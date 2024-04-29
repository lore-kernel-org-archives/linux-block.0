Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23388200D5
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389502; cv=none; b=JgVcaumlH9m2pG9jXY8CdhK5WNXRsOrnwMf8FjtMqi7daQYeVkJuuxNqAWZGM1utsvCnO8YBlJge+SmFNcKpECJXuluHavDcSvBdlT7Q/eEkpO/PcxUbYFYvT8zRPbgfCnOTWVfyvAMvH9SYZdo/8Ei9uMR7JsO1W1GhKEHp6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389502; c=relaxed/simple;
	bh=8xa84trj/OuvBERyOQRKPGpd53bzPZEwz+4yWpMegVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lERqAetVsb86uOGZNWRrtgoRQj6iRpXRvnoAY1qA/OLNd2EqwvofXBh6+000aTt2T5aBqcWg4n9a7IXsh2+lU5M3/32Q6Pn5ILM8Q6FpmwjPBFKBr2QQPag2IsjvUzNE0cPXfgWYF2DlmML9shmooYxAy9yoMaXbG3gsqHel9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KWFbG9dj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KWFbG9dj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d1e6ddb4bso470470f8f.3
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1714389499; x=1714994299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwDsJlGHU7QiLVD+kND22vviKRi7S24br0n3yPE4cXE=;
        b=KWFbG9dj7UkjtPcsI5lavdxL+hL9i54r/5Pp6Vmw7k18AMRXLJq2ZsMHJrtk+MuUv4
         BjBSIq1i1lyJzBUscvc1y1CT+Z8N3OEMRw2zJPtMx1fZU6CLdvV9nw+DJ8CDHvbYtDfI
         7rq9cvES3hksKYfN+AxrlShoKJij7vhF7Vi0XsEjC83W7czF0fIqB1H4fTpeK0xFt7UO
         YZjgWez7/lFtQtvceCTlPEJaQgwemhgXEKGzB9ZYcRZJtJL2syv6GawAyo08rVn5MfLx
         rw0U+fXLyUi71RrRgZ0Dc1U8SymSVTZxAk/uaSoBAmFv320Weaq9aVwLIStarwcDV6tc
         oFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389499; x=1714994299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwDsJlGHU7QiLVD+kND22vviKRi7S24br0n3yPE4cXE=;
        b=HJbliPegIZN6lRovcWVx24Gv7vHd5yadeQlYIyh/orZkTpgy14I4GWUYBS+pTkyLvm
         92KoYmD/u2blx8bwqICySoNi5cKWPl4Ropyu4j3O+jTNcix5ZIGPvVkt2+EDHwKmVBtq
         QEus8NPeRV5JK1Gjw4nrkdb7d0eNSdo9dg6W/+mGrNmJMz1OG6SeXGWJEgwf45WPg0Ao
         aDPJNPRuuFx7xSiHTehcFaSumP/kKVgX7cIMP+q4CnnEo5P1ax+habv9CTzntUrZVDRo
         4hLY6jyVMIWhEmhdFEqndTdqGzCnfTBcL29DaBbUaRlxyepCwrgLLaSX1w1MqxPy2oXH
         aGnA==
X-Forwarded-Encrypted: i=1; AJvYcCVTAoz1mYCjVLg+O0xQQq+N3uk0OxLFEWL6eSzBJ8t1iX5ZPcMFjkD7PU/odG7rP5dZbeSxnIsUTtGo6Kv1eHNfaQK786CeKs2LmEQ=
X-Gm-Message-State: AOJu0Yw9eE2WCB2ZBQzSriQTdrE+XQtIT0XuY58aMpbudE+dGXwWMgvb
	CeQYtiDN5tU2tpXOAW5kNpw2AIaP+IdAjWFNNQvjxD7Xe2sVIjyFYlOVs1ijPIY=
X-Google-Smtp-Source: AGHT+IESIaZKXHhTxatqFCL9Fa90Gl/4hES0owFvuG9oTUJHLtxjWYX9ULzmGc4TJhqz9pbve+0cMg==
X-Received: by 2002:a5d:4b44:0:b0:34c:9a24:7a40 with SMTP id w4-20020a5d4b44000000b0034c9a247a40mr4607842wrs.56.1714389499309;
        Mon, 29 Apr 2024 04:18:19 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0034cf39c64bdsm3229404wrt.101.2024.04.29.04.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:18:18 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:18:16 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
	dietmar.eggemann@arm.com, vschneid@redhat.com,
	vincent.guittot@linaro.org, Johannes.Thumshirn@wdc.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org, andres@anarazel.de,
	asml.silence@gmail.com, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] cpufreq/schedutil: Remove iowait boost
Message-ID: <20240429111816.mqok5biihvy46eba@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <20240304201625.100619-3-christian.loehle@arm.com>
 <CAJZ5v0gMni0QJTBJXoVOav=kOtQ9W--NyXAgq+dXA+m-bciG8w@mail.gmail.com>
 <5060c335-e90a-430f-bca5-c0ee46a49249@arm.com>
 <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>
 <20240325023726.itkhlg66uo5kbljx@airbuntu>
 <d99fd27a-dac5-4c71-b644-1213f51f2ba0@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99fd27a-dac5-4c71-b644-1213f51f2ba0@arm.com>

On 04/19/24 14:42, Christian Loehle wrote:

> > I think the major thing we need to be careful about is the behavior when the
> > task is sleeping. I think the boosting will be removed when the task is
> > dequeued and I can bet there will be systems out there where the BLOCK softirq
> > being boosted when the task is sleeping will matter.
> 
> Currently I see this mainly protected by the sugov rate_limit_us.
> With the enqueue's being the dominating cpufreq updates it's not really an
> issue, the boost is expected to survive the sleep duration, during which it
> wouldn't be active.
> I did experiment with some sort of 'stickiness' of the boost to the rq, but
> it is somewhat of a pain to deal with if we want to remove it once enqueued
> on a different rq. A sugov 1ms timer is much simpler of course.
> Currently it's not necessary IMO, but for the sake of being future-proof in
> terms of more frequent freq updates I might include it in v2.

Making sure things work with purpose would be really great. This implicit
dependency is not great IMHO and make both testing and reasoning about why
things are good or bad harder when analysing real workloads. Especially by non
kernel developers.

> 
> > 
> > FWIW I do have an implementation for per-task iowait boost where I went a step
> > further and converted intel_pstate too and like Christian didn't notice
> > a regression. But I am not sure (rather don't think) I triggered this use case.
> > I can't tell when the systems truly have per-cpu cpufreq control or just appear
> > so and they are actually shared but not visible at linux level.
> 
> Please do share your intel_pstate proposal!

This is what I had. I haven't been working on this for the past few months, but
I remember tried several tests on different machines then without a problem.
I tried to re-order patches at some point though and I hope I didn't break
something accidentally and forgot the state.

https://github.com/torvalds/linux/compare/master...qais-yousef:linux:uclamp-max-aggregation
