Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B1224AFC
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920913; cv=none; b=Q/q/ljUg+BRv6RwdlWSxeNBzUHcM82XUb2nlCdyYikyMgQ8vfIvxuXhxWWIEEm21pH4onKkIXdMliHaRXAzYGa7zefalrYS4afYr5CyX8awlZB7r3ioebCf3GzlO1ZoSrrGXf2qUbVpGoQ1ApQ5jTTYhwbEUg2HO2rBUO8MwOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920913; c=relaxed/simple;
	bh=y0zIX+KBoOVyLl1lGcBqZ+e5rFzymnFo9tPUEW6YMeQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MaQvQNhvzIaCai4CbFIwPepRKULzg7lSMS7oDOUQuz7Rxjhk15A0Kf295uoHW/tkY3HqLk/CYEoFPgQQFKLKoyAHf4GVSeGbWqYo4t9hiqiKXSQSF2NtJz77+sJ9aILU9gWhD3V1VI6v0j3enn2wEX1ZTl9nJvXeDyAhPh3vBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C5MRKQUH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C5MRKQUH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso4820632a91.3
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920911; x=1755525711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=C5MRKQUH5CUxmw5MLOVMpeiTBJPEPIhFcIpaem7uEwXa7Wrwog/fvCrnVSXCAoAGVN
         e88shQkNVUWpZQ6Nr/EVi/NKIS1XlFS95nSSAbSFxdxI6Ep5NeV2h3RTqFJc9eq13VTE
         +AHnNb+9MMQD27zoLCtDMzZz/+GWt19Zv7W8oMaukVV4Hu0Hgme5IXwWFHt/ObBQUC1d
         TSGp6rRF9MN9GiLuHVIjFTwtdo91jmGGVLNhVuNCrVTDDqyXj3oJHfDjGpnw2WFdz2Z5
         kHmiD8MGor82oDnZhEue9Zu7hZeoPfwWt4rlms52qOERpl7eab+Q53NUGxs1Qu6rXxdr
         pVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920911; x=1755525711;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=Y0VRkPEuz6SJu90C+Y/dihOoT0SWs5YPYcVssQQt6NcuFTaR7SK7YuAMBi6iu5IM8s
         7tfHm7SH3RiJQih3PYLnk932gfOEh3evy3R6Ls/6it9qWvHkwoj9zqHbTdEk7FWqqxgN
         MOTxsbGUKmlpowimyzCgBpvvBCxYV9r0R/9T+RuKWzOErEYctncWmXDW7/L+SZmvt2xl
         ja+Zg1n6iC5T4EIdsd1vkJpUicOTToYLZPi6z15UJu42y7nPp2ZZYaRUS+NreGZ88+3P
         gf3pXmmrcDGEaQerHrgKvZA++7/2VWNTwbsdj1SQyGzkaY8/b1O4DYXI1ydTDdXydyUh
         OziQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlEjczFL6cq1HHDAx8qI1YLEwkrN6u4POMpcgRkF9rShXaCYPzimKVsJGRnFGcCVZj8WZnC0NnkRJSnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywau4C8qt+FyEGK1D3u/NGLBVrtkk9KsOCehXIbM1kcK2irDIJ3
	vSEI2yCoORy0F7hXgkiIsG90etcxIW9QK9ZlYnlJtxL5I75xlgBnGXttQVkz0cgw/f4vCH5kCCY
	QwFOw
X-Gm-Gg: ASbGncuIDUEb9INtBr3JX1BQwdnzgbMCtyplLwmAgKB/V0PQ9kS5uaBjIbYh1ZQqVnp
	6CfxMycqcnZYHgYNV9/JysXrBKkhgK23riADj1PBpxvqgvXF76748CYZn+9Rr4LosllxxxSxnTK
	1VRKI/oeSFeUnCNbenleGGAadA43VdRax/sZL4Tb5GL9KKoMmOJPdmGWgnXvs0ovVJAhTqRMPJC
	rhiFB9IQYf7R3axT4Z5vC7JWabY2gH/lp6lWWR6vnF39e3/EfVG5+ASQLvJOCE5tXe2lZ8sYh1C
	7UBA81ziSUQPeTRppqOsw309b75BD58NafwoddrWNtJgDJZ+1Nmtbq7fP9yIalhnDpfLgz3nh+S
	/Ry43e26JjapLxhgEqK5WOgaH5g==
X-Google-Smtp-Source: AGHT+IHdapQQqIEBFEuAI4fgLuc7zanwo1g6eAIPxfo3wR6CEjTbZw+JPfriC+9e8kRAaZJLbRghjA==
X-Received: by 2002:a17:90b:48d1:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-321839fde25mr20913876a91.15.1754920910599;
        Mon, 11 Aug 2025 07:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250809141358.168781-1-rongqianfeng@vivo.com>
References: <20250809141358.168781-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] blk-cgroup: remove redundant __GFP_NOWARN
Message-Id: <175492090902.697940.7586040071360422708.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 09 Aug 2025 22:13:58 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: remove redundant __GFP_NOWARN
      commit: 196447c712dd486f4315356c572a1d13dd743f08

Best regards,
-- 
Jens Axboe



