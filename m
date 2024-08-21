Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E11B2EF1
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240794; cv=none; b=HNLABcU60qH1WO+Wjft4x4XTlkt0fFY6a4sceDJNNLyc1BqVHwAgLpR7+RcI+8r9Y8tAfRdIYSvgrc4QxF8wgj1IMmGhjneDPtO4fLc13zzbjdfUoexOv6A7bC1Xs4WN6gDDrhDRpO6AkrWgLrBQzd0vjF1eXpvXb1fOCT3ig1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240794; c=relaxed/simple;
	bh=JMwCphN5pGrz+zpFb0NOZA1mmG3YJUULLXRPUgYZfsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjYxbX+GAFs+vCpy/GYUhLIsgmT6KfFil9tq5Ak4rk+s5sDWYlNeJfg+kijt8J7gmJhXEnxJtDvU2mzjeXgupQLh+h2IPsv0IOWcyYmN+zdMked8b0O4chNFQiSYEcej/duaoX/UNYry7RRNkwbPy6h5AaX0ZJ1rrpU4oIj8k+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPM6NHk7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPM6NHk7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so5027952a12.3
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724240791; x=1724845591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oErO252NQnC9h2Lk0YbFph/doRZfHKDAuMD366ZpOQE=;
        b=aPM6NHk7I2ZWm5xbHGARF6uBJO+jDPND5TZyG+R+OYcQRXBfUwbYv0Hzp6NUdG4uLg
         kizGG1hmw9p0Eb2RxbGNWyZ1a/owHuYqj62lHaRAQwkjwRmIZ2FslpjgMa/A98PylN3q
         Netzcj4oa6hix+LibwSZu4kOt9egLi7UlkmNtRv4ifgSio0C77jdqYxSSnF21mZERiS9
         QNYOf3mzzY/13W53fFqM0RS32zvm+AY25FJWCvf4tExD86qe2W6lAQMntjVsqdTgnfH1
         cV4twZGSDv2IcHSdKJlA5547aFmZO4dWnYnqP06ozXYrF+OqDyEgERSc7U62mt6gpILv
         teEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240791; x=1724845591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oErO252NQnC9h2Lk0YbFph/doRZfHKDAuMD366ZpOQE=;
        b=wC/PMRExAsekcRPohuOQSS4eNptv+bhEocORLkSk9+QQCtmaPR8we5vCNjN84celop
         tuFKl4GGkxVbAwaGxDtT5uljHIAieF3CHshOh19WzBKMwVvMF+Nn0jSgOTBoOIC/Z/Yu
         JhdBDK/N86/NYbYlgZ4oIP0XCi8/08sAFCRUWpgcjnLDTdTkeH25uXYRwUhVf6UeQl46
         akG7mJrHsTkW7kRqTXEz089tBg9I3hoEViVUCxECts3fPmhO3A09rolYRvJph5oRAnj6
         CjBEG3g+I4eWrprnPX7Vpi3sR5u+LCLDo/T81s4gMfemosx9qwWwEgJDEXwRP8Rh7zXL
         0SAQ==
X-Forwarded-Encrypted: i=1; AJvYcCULxEQfBWZNOtLpddd/vb2BMtBdBt/ZNqdefrcDsZjhPyOnCe8OI0J19G84wu8utqbVTHZVWU9eeGNDYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsp2FBix6xFMNiBXSRrsuMg22fmfepbXEt588w47NX5dk3UR0
	BwfRwH1Csy19Wnhfn2EyNfwk5lA1wrJtviDxfh8St+qjawlZdnElmfmBIDXVARA=
X-Google-Smtp-Source: AGHT+IF7jHunz9u+RQaSofBA9JaDACkz26TemKPcbEjMfuKwz7hzgJgDMZgPrPtmc6MMAlGh5AuCCQ==
X-Received: by 2002:a05:6402:34d1:b0:5bf:8e4:377a with SMTP id 4fb4d7f45d1cf-5bf1f0a3b0amr1255165a12.3.1724240790810;
        Wed, 21 Aug 2024 04:46:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe5a74sm7980181a12.16.2024.08.21.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:46:29 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:46:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed
 with error -12
Message-ID: <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>
References: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
 <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>

On Wed, Aug 14, 2024 at 03:56:56PM +0530, Naresh Kamboju wrote:
> On Wed, 14 Aug 2024 at 15:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The qemu-x86_64 boot failed with today's Linux next-20240814 tag due to
> > following crash.
> >
> > The catch here is the crash seen on both x86_64 device and qemu-x86_64
> > but x86_64 device is able to boot successfully.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Boot log:
> > ---
> > [    0.000000] Linux version 6.11.0-rc3-next-20240814
> > (tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 13.3.0-1) 13.3.0, GNU
> > ld (GNU Binutils for Debian) 2.42.50.20240625) #1 SMP PREEMPT_DYNAMIC
> > @1723614704
> > ...
> > <6>[    2.479915] scsi host0: ahci
> > <4>[    2.484371] sysfs: cannot create duplicate filename
> > '/devices/virtual/workqueue/scsi_tmf_-1073661392'
                                         ^^^^^^^^^^^
Negative number.  This comes from:

        shost->tmf_work_q = alloc_workqueue("scsi_tmf_%d",
                                        WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS,
                                           1, shost->host_no);

shost->host_no comes from ida_alloc() and we have checked to ensure it's not
negative.  The problem is the va_args changes in workqueue.c as Anders's bisect
shows.

kernel/workqueue.c
  5627  static struct workqueue_struct *__alloc_workqueue(const char *fmt,
  5628                                                    unsigned int flags,
  5629                                                    int max_active, ...)
                                                                          ^^^
This should be a "va_list args" now.

  5750  struct workqueue_struct *alloc_workqueue(const char *fmt,
  5751                                           unsigned int flags,
  5752                                           int max_active, ...)
  5753  {
  5754          struct workqueue_struct *wq;
  5755          va_list args;
  5756  
  5757          va_start(args, max_active);
  5758          wq = __alloc_workqueue(fmt, flags, max_active, args);
                                                               ^^^^
We're passing a va_list.

  5759          va_end(args);

Any workqueue that has a format string is going to be broken now.

regards,
dan carpenter

