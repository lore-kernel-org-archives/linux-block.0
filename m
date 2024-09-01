Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3228387
	for <linux-block@vger.kernel.org>; Sun,  1 Sep 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211956; cv=none; b=Pqjs9gFznKCo+mg9PL8Pi66/q9DKRkk7hZUmAdg5FNYjvLyvlOaQh0O+ZNZLjEcmOegI6i1TsbXC+3PdvnMSOzb4pRSODrAJ/ZVizX7cbaFoULdNt46BWazoKLPLOecZHBg/jYNcYBKBSNNkFdT2BPwnSORXEvz+tfTzvj8s1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211956; c=relaxed/simple;
	bh=EkWT1jF7poYKL1Z6hU8sc4dRjedKR4GLFHZcsyyeOLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mipG0qW0S5uHqVgPalrIPOVkRjuV8o0xnqC78E0mYs58mcnV7NHRyL7yFsOePPZ/Xnrexlc55BlHspul7/NSMQj8iPpph59RHlbATtNr0xta+CZFnKzKllCeGonKyjNlWzWVUCndCV6/xLd4IQkGgwlyzcLhAGLuBY5zjd5iU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dySyYQ8y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dySyYQ8y"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ba78f192so1279226f8f.3
        for <linux-block@vger.kernel.org>; Sun, 01 Sep 2024 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725211953; x=1725816753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4D4sJrLrrIZ7iVSCd2I4lMCj60uPYottSCrMVDrHb0=;
        b=dySyYQ8yRHA+K+OnhGUK+zN8GIKkdjjhWturWHFp1fay5dObVHqzSnvjZIpb3ujSJ4
         aj07Gw4krOtJnQYposqjnq+SberWJ6LCrfnHGjuCWGuhUHErBiJPYtQJ+rgvuKB7BK5y
         dWnTVGLdBO7diKCyM7qHbAtG3wGhVlJA914Id5ASex9a7LakRCR0P8DwRThlB/th5C1I
         rZbWdFdn84Iqco996aew21t8WMFqi+DzSS1dmzhlD+49LmqK5TbRzBzcGvIlZnnfNYSI
         J3xf7YVOpuMlcesXYL6dZUgcdV86S8lWk7391EkV4WWpitq7mua3bBx+HhjHThNJxVMU
         5eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725211953; x=1725816753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4D4sJrLrrIZ7iVSCd2I4lMCj60uPYottSCrMVDrHb0=;
        b=GtL19fbO9VNsuPTX6GP+iU15MDh+reItX8lwoRRZkPRjveYiQcAVnB/fMt4nFNi98c
         l/L/CHRnET5weQJVtPtT5ZgiGyQEXwitKJmwcQiSA9tqxKo912C/kZXkws6Bbw0+iThb
         0MVN3BOSDAUlelJGVQ2f8LdFLSzqJltIIun1n8IgDGpdKP796/R5YuLv/plRX827HZZT
         OIde6GpcKdhnLETeZy9lfG+g3Wet3E0xu1eWnVHuXuEE8dVRDx5M40yJCrdsewbbkpQV
         SEQCzX6n/7uyDNKqRUwx6wHWrEl/o/DQCHJy2P+JE+3WXCc2yPROfU1FJzwEOMaCDSa/
         OyEA==
X-Forwarded-Encrypted: i=1; AJvYcCVRjd8Gy5m852YtqA9Nz+ohzAXz7sNxZguK7E+IqvRgGzQ0JyVzrRzvAbIM7MgXEyR6MqCvZvnAXi97ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8f11+O0H5cDPkWD0yKRrNVbijLjckWhlzwBlMyajXw/Thefn
	t0xwxSGRM4+SbLFrgAJxBHhDSE/HWz8V9JQpNF+puDzvN8sxFFNIS+Tf6+Mzl4g=
X-Google-Smtp-Source: AGHT+IF90MOG01YVgBOrF3b0ODo3ETDvTIlN2Kg7QhpNwD6cuuJL5fr1+FoCN4ZU3ILfdx3HxUhC5A==
X-Received: by 2002:a5d:51cd:0:b0:374:c515:4441 with SMTP id ffacd0b85a97d-374c5154570mr1799939f8f.56.1725211953126;
        Sun, 01 Sep 2024 10:32:33 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm836309a12.79.2024.09.01.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:32:32 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:32:30 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Manish Pandey <quic_mapa@quicinc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
	quic_narepall@quicinc.com, quic_rampraka@quicinc.com,
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH] blk-mq: Allow complete locally if capacities are
 different
Message-ID: <20240901173230.lgyvfkx5eq5sr7ss@airbuntu>
References: <20240828114958.29422-1-quic_mapa@quicinc.com>
 <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>

Thanks for the CC Bart.

Manish, if you're going to send a patch to address an issue from another merged
patch, the etiquet is to keep the CC list of the original patch the same and
include the author of that patch in the loop.

On 08/28/24 08:13, Bart Van Assche wrote:
> On 8/28/24 7:49 AM, Manish Pandey wrote:
> > 'Commit af550e4c9682 ("block/blk-mq: Don't complete locally if
> > capacities are different")' enforces to complete the request locally
> > only if the submission and completion CPUs have same capacity.
> > 
> > To have optimal IO load balancing or to avoid contention b/w submission
> > path and completion path, user may need to complete IO request of large
> > capacity CPU(s) on Small Capacity CPU(s) or vice versa.
> > 
> > Hence introduce a QUEUE_FLAG_ALLOW_DIFF_CAPACITY blk queue flag to let
> > user decide if it wants to complete the request locally or need an IPI

I answered you here

	https://lore.kernel.org/lkml/20240901171317.bm5z3vplqgdwp4bc@airbuntu/

This approach is not acceptable. I think you need to better explain why
rq_affinity=0 is not usable instead of confusing rq_affinity=1 needs to be
hacked in this manner.

The right extension would be to teach the system how to detect cases where it
is better not to keep them on the same LLC/capacity because of scenario XYZ
that is known (genericaly and scalably) to break and requires an exception.

rq_affinity=0 would give you what you want AFAICT and don't see a reason for
this hack.

> > even if the capacity of the requesting and completion queue is different.
> > This gives flexibility to user to choose best CPU for their completion
> > to give best performance for their system.
> 
> I think that the following is missing from the above description:
> - Mentioning that this is for an unusual interrupt routing technology
>   (SoC sends the interrupt to another CPU core than what has been
>    specified in the smp_affinity mask).
> - An explanation why the desired effect cannot be achieved by changing
>   rq_affinity into 0.

It fails to mention a lot of things from the discussion from the previous
thread sadly... Including the fact that there's a strange argument about
regression on a platform that is easily fixed by using rq_affinity=0, but the
argument of not using this is because some other platforms don't need to use
rq_affinity=0.

I'm not sure if rq_affinity=1 is supposed to work for all cases especially with
the specific and custom setup Manish has.

Anyway. The submission has a broken CC list that omits a lot of folks from the
discussion.

> 
> >   block/blk-mq-debugfs.c |  1 +
> >   block/blk-mq.c         |  3 ++-
> >   block/blk-sysfs.c      | 12 ++++++++++--
> >   include/linux/blkdev.h |  1 +
> >   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> Since the semantics of a sysfs attribute are modified,
> Documentation/ABI/stable/sysfs-block should be updated.
> 
> Thanks,
> 
> Bart.
