Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD03C6A56
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813433; cv=none; b=E7IpzyTK9zbpNdIeGNzOLYFhj5ZC9/ZRrrjfGyu2bCQfWkt8PM8IvwCVGHFeaLwyJcdoGI4B16OFMBGRokDj6ZABJahCV/fzZhR1EiWeHJoTbq2W99iQovQzc0DURl4JNuZz49CFi5vK2tfQYZKfWEljSUDyTewKgHPVFPMjp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813433; c=relaxed/simple;
	bh=k7m3TShuDxcI1i40xO14T3m0hb0f1G2Z9ivDSnAllCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QbWbl8zl/kZcC5pq3JG6dPiNm8JSijBXxRaEbJZ9pjfmvBvKNmz46x9nKJGHIaznjih0FULwS2S909y9s2nVTDVaMq2bcSNGB3+mXdADrww2uIpJCfdV6cX/eBMKhdBYypVv9G4Dk9VRWWBFxbRhWB7k1wBhIAWl1R5TiZ78s18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vU7TohBN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vU7TohBN"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43b78b54dbdso2622051fac.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813430; x=1780418230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjWmpAZyQXAr6Dn33RGAFX5IxZ9Y2+mFnV5iI0sKiIg=;
        b=vU7TohBN9O6hqZeKb6RBvP8/+iNdQXbm6QfeeslBvIFp/lJYsZjJ+03mfv8ZVKUzxM
         wrzMfg26dXCjGJgpKUEuqyapjLUu3xZSBoMCGgOOebMgVSiLecC688XPU3YDRHU6q6EF
         Uq2+oCBpuIRPlFBxWcpC+XEE/dhHm3jdvR6G+1j0CIGUlIWDXFoVCfNhliNxSNgH+lCI
         kVuxcpN6BoO4l0xj/F0LIu01kd3UnjOuACjw23piNUBg11+oCU4Sn8c15KKfkw7+qseV
         YixxVyx/qZ3MYg9DuaxUbmAhed3bI5QIbc50jCk/gLWu9LopVypm6kgLG5HvYXQEygWE
         hCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813430; x=1780418230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjWmpAZyQXAr6Dn33RGAFX5IxZ9Y2+mFnV5iI0sKiIg=;
        b=ea5Fl9HihoYbM9xAJnyTR679KeA5oYy1EgAQl8kTfVLL2Sm55j+0Sh1+ENrY2SwCD+
         l3yXeml/ZLqux565O8ANsWHmI+dCrht/oyV5s6dIzafT9zYKLpd1k8YxtsEaYl9B4Ep8
         6yh/3VjU6ZcBqzyHw8ZV2IsWdmzXjCGOx9oEeK98kkG46Jj+KRXg2zOHq7RS9yOi3Lu0
         A0gnLNQp9rjNxbf2jQtsWJsTbnBdLUFjOONFXRl1wcby7oz1vNXfMlSBgS3e5UVpGlWV
         6LCIbqxfDm41H+WR60IJevSuN/Z00UTL1zGJ4gFzgShKaVMPve6IK6KfH//cSyvKXwKM
         WDTg==
X-Forwarded-Encrypted: i=1; AFNElJ9UzhBmoiNwdrMPE9y8vza/g+QLoyiF/8XHMpBJRqWD7KTe+SDbwfh8kh4hcIybFCclXH7LHI4UxkaEWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhm5DilybEKESB2sJF07hPEq3OVkA1jL8sUyKGRYN4oOmwK03
	nl+pCJNeLFmb8Fl5FMGLoufWPdTaSKzoQhDxtbQUeGLAEaFMQdXGl2e64iZ3idY2Tsw=
X-Gm-Gg: Acq92OEZR5S6IZ1e6pLuR3WGVyxPecNtM61MU8PibG4SM7ElJcwN21sHaqbw/lInzQX
	V/ssM7dJeJLpcvoTDfMGr/iVPxU+T0V2tjlumVKyO9lb/6fqqfDCvwVzACxulWS1YLI8ZlVrogh
	uxZgogS3MNsT/KPtLxJoKHUhXYjXHZ+LLmqnMHII+xbw7Ijag2gkoLfNce64B0w36esGWH/t/Ha
	M7lzuVwSbG6/+m/vYlPPYLIKqL3SjGt8teTpBSQlGEcXz08MhtDWONBrEQFWxAu88izFSp3b1Wx
	K1cnf3p4gjelGVXPIzUDny+wZpubjO7qOcJuSadmnBmw5gVwQuJDxQjV6AO4ZdTzKLLF8lXx+k3
	yTTZKTSKMonNtekjZ3TIaCBx1av4Ose5a4auhwIImGWcAGm8tWp8rTOcXB6ocLVs1doDp44/hkE
	mmoCmr+BFPntOCYmcg62T4rog2YuWoiivSCN7gGuPpk+5LDmBW/bEX5/cqmJHF+Gs0rZ7cIp2fL
	nUKyJ20rrH2aA==
X-Received: by 2002:a05:6870:4595:b0:42c:f89:7555 with SMTP id 586e51a60fabf-43b5aa4a3bemr12861346fac.11.1779813430300;
        Tue, 26 May 2026 09:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, Aaron Tomlin <atomlin@atomlin.com>
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
 dlemoal@kernel.org, ritesh.list@gmail.com, john.g.garry@oracle.com, 
 loberman@redhat.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
 chjohnst@gmail.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260525005123.722277-1-atomlin@atomlin.com>
References: <20260525005123.722277-1-atomlin@atomlin.com>
Subject: Re: [PATCH v9] blk-mq: add tracepoint block_rq_tag_wait
Message-Id: <177981342289.464267.13862280829247173081.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 24 May 2026 20:51:23 -0400, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising
> RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
> latency spikes can occur when fast devices (SSDs) are starved of hardware
> tags when sharing the same blk_mq_tag_set.
> 
> Currently, diagnosing this specific hardware queue contention is
> difficult. When a CPU thread exhausts the tag pool, blk_mq_get_tag()
> forces the current thread to block uninterruptible via io_schedule().
> While this can be inferred via sched:sched_switch or dynamically
> traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
> dedicated, out-of-the-box observability for this event.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add tracepoint block_rq_tag_wait
      commit: 9ece10778f8931630f86e802f94dc71115de0c8c

Best regards,
-- 
Jens Axboe



