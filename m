Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBB34DB59
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975744; cv=none; b=OEKfaZzRir8RyrrEOV7VDfgqefmnj622xb9x+i8L6TwtAA8LEtIeHAUpFNXnnpxI46lA1JtD6ALhKfIOUmt+wonpXi+h5A2eYz3dJgtCBMVKMLm62bILJ5NYsSc7AKfgPfMNXTwiNDOWIltASsaVQK4Kmm7S7xCb0LK3aVcWFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975744; c=relaxed/simple;
	bh=iPx/p1PDS2qSP5J+nCZnQvpqGZRAvVSgR3VaXJVUIuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNFnIIlL1ZfV0rGDGRreaZIqEFJbh9v7//7/WYpVOcqZX9uC52vuWJx91o9cpuBZeyJdE+h3T+iyKul1zoUbDhqlrGQfWtFXShu0huRMG620kru1Z6iQHysNBdAomwJZPyeKPAIROB4KGNNyuyW4UaSNl1kmwaeERBaUb5+soMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjigQqe; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjigQqe"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-824adc96ad2so792525b3a.3
        for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770975743; x=1771580543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9jdm9e4LpehRQOnSCiausys9F0ow8LvB9lV5cy/oWQ=;
        b=iAjigQqeQCWezymj3tk4db3Qdz+UawGyG9f5LegvL/mpkErfrC2DXVUqhcySBdEIMs
         zIIXndROL6VtD60wG5w68zd3aCXqk6nfAyttSKwh5piw+4Xam5c4kiz6OrMHXwPL50uk
         wNDPtmwxnu7iHJfi5JwP1GZduZRf9zuntRzn/rUJtA2NYt+4fm5cDhDHBZdFkpjAncJ7
         B3yExDo8kSb0MSEszQ4P5NU/6/gGjkhz4mXdopTdlas6jIXSgPaJcJIvMwBVVNovxgXg
         HPlBDtlUoSpt/cYNqcC/XzxFZ9UdqFM+CYMA8qF2HQVzRTz3hZSNZFhRqnrVBLMB6h0+
         goqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770975743; x=1771580543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9jdm9e4LpehRQOnSCiausys9F0ow8LvB9lV5cy/oWQ=;
        b=LdPIgSV0F1GkrUEiTwgJw4vp0+P0nHDfmHIVU54o1oYqVf+4ODZkAkK5qigeL3FEBD
         r/WScHJwPuxZ87j5mpPK/krm4eAbwjGqyQ1Vl3E3kRi3sC/ME9CuK54C+T9WS03RvaRj
         V8p9Bk1JxWEag3VL1O5X5SQ/0WjnZ8iOeLKtlr7jflr0B9wqCJLjaMvBPh6JCzeWQwh0
         +vt4de3MVg6Z2q+5u2MRQmUnbCUTKEcsZxGmFxLM9A/fMeN5zFSQFbl+S58z1dgdidhk
         /rK+dSDF5tkkx5nu+Y3g4Nh4MP0oJs4Mb2fzz4FceWuKEtl5a5eB3hWFduyibszM+Wzo
         J+ow==
X-Forwarded-Encrypted: i=1; AJvYcCVe1YaxgGNy1DDwdsCEOIEnIlMKIsU9iQReC9vbRdSPFz19ZQQzJCkJHijlOO7rCrh27ETLfu8uJh1a9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNBd3Y7MGFZD00VzP7FTHDg+ZvCG1jjvvdIjRvlZ6P9E9V4q8
	7ozs6apfvHMLd5B3zJBWDKRE+Xg8PXv6Kr8rnep3RmUZs3W6OcjOFVXW
X-Gm-Gg: AZuq6aJGU3//UX3MjBg9MxU8Hh6BVBUSh5a40OOnIWWpW7qgAdftpR62/+QflyqGV0D
	WC7mcrUGFY8+Vb+CC0Qabwm3I/RQqLYdpNmaOm6dEIeNX8mcv+xBxSud8f32lX15R2cjlAOCVnY
	LSV5brX2FHS2rh26wn+OJHcE/jv65uxobxqM/fUNFHgEITj56A/ld9wnntlgsPDtJMlWysek7UB
	H41mjRS3YFCIh5pvnC0pTbABQdT0SAphENVEUGY03h3+rrNwvM6ezMxKllS2u4Zsgwh7IeiU3PV
	Ua6YTjnibfAw62JLeuijt5WoZz+s/IBSucNrDidDnrLhvGoGZp/JEf+Jc41M30T/LFtBw1X3ncy
	YvPA4uA7MXjBykqGpaPeY93wZaLBSXm0jNkOEiIAvn/h/YxheMGN+ZftckOocPnkCqouDjomTBN
	qlfoRA9x6PewELDjbXKPlr1DUQmh3RSdCB8A==
X-Received: by 2002:a05:6a20:2595:b0:38d:fe2a:4b13 with SMTP id adf61e73a8af0-3946746db87mr1876262637.77.1770975743002;
        Fri, 13 Feb 2026 01:42:23 -0800 (PST)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e196accf9sm6996720a12.13.2026.02.13.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:42:22 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	lianux.mm@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Fri, 13 Feb 2026 17:42:18 +0800
Message-ID: <20260213094218.253536-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213073829.182168-1-wjl.linux@gmail.com>
References: <20260213073829.182168-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This formula correctly models the dual-bucket behavior of cloud disks.
> It ensures that for any block size, the calculated cost aligns with the
> actual bottleneck (IOPS or BPS). This allows the system to reach close
> to the provisioned BPS/IOPS limits without premature throttling, while
> still maintaining the latency protection benefits of iocost.

This model still has some limitations. Under workloads with mixed IO sizes and
vrate max at 100%, it fail to fully saturate the hardware performance.
However, it still demonstrates a clear improvement over the linear model.

The following fio benchmarks were conducted with two cgroups assigned equal weights:

Cgroup A: fio --bs=32k ...
Cgroup B: fio --bs=1M  ...

Results:

Model       | Cgroup A (32k)         | Cgroup B (1M)        | Total
------------+------------------------+----------------------|----------------------
linear      | 1137 IOPS (35.5 MiB/s) | 79 IOPS (79.5 MiB/s) | 1216 IOPS 115.0 MiB/s
linear-max  | 1781 IOPS (55.7 MiB/s) | 83 IOPS (83.9 MiB/s) | 1864 IOPS 139.6 MiB/s
