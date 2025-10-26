Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E06F06A
	for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440724; cv=none; b=MbFcDpXpS6GEKrHuA7dr+QBqkxm2dyzuwdxlLNkPmU8hnpKKHbce/qbViHM1RyhorT0Wgwt2iq1fRscIMwKcaHFCRJcUP8dlkmAx6Bediu+wg3J0dFW/SH6AhmqASxYSsv9GPfMVK2Krv72FJ4WIFxjTot4U92BqzA7QS/MEAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440724; c=relaxed/simple;
	bh=KLqV75PcvEyUm05RQodatiEG/ugFMUNCSjZ4Fbo2bkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGW1N2Za1Wq108oEOdGmejfbb8pcH0J7lrtIzUkG0+9r5Zh37WsympXSdS38YRAc4h9LRe9iXy6Ex/rR1KWr+ryVYQLe5V3x+yLZ3XooC4iQ3aZcpRsJaZ+0iqhwgcyeqvw1t0hiBJVMn2EkMSqR2CfVm6beBSREYmeEEOII+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWe5OMOe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWe5OMOe"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a2852819a8so1909781b3a.3
        for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440722; x=1762045522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=MWe5OMOe824Tdw6FcQvWhgeBq0xyEAepk3Q4yOtpcfeHIoNGUzCF1uEh0/FD2ZPudz
         u6luLV2YhOzvd7Sks8zL2aHXJLykn8klOFH5TnXf724gSlLB+QGkJyyTHGLNRpTyBGCX
         L0Qscld6K5t3wYu22El5xRsirPCb0fTf6myS8yr4uqJIyefWFddKxeI2D6BjKamAC0t5
         bOe2yyUqRlX80THK0F6r7+TzO2k/PoKx9rHMkJ7WKPM9oBTVPBb4sgL/Vk3zsE2gdeb5
         CnWqvXnpDN9nWif+3aiBSUy3sZsQBLclDn9w9z+Eweq6mVo3D3iVkUA/++dcreZKwJVV
         VT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440722; x=1762045522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=Wzs0r6CNFI0I6J4AXB/XFO6P23m3nhGs1KZ28l4U383InHfLwHndmKms8SKI9SOekW
         43CzUUhfVNNvvp5gRaOcKmkD/TPvteuhBf4Hx7VBudrEUto9mhzIVlUdMYlXbvlhoKHT
         5uxpMYBoiaCtOipmdMiWpJwI9lZwSG5Mr6UPwMOL/PXphT1xCVHGNSi8/df4VymWakOi
         oDVzPCjSQ033Fa2MtuyFjgy/ELq3Docp/eiJRmmPvZHp/c0msLIXwKc3vb+tpNcwp1x/
         RmnONoSDIMUeLrzAanLT7nJHmyttGHOOEi1JGcA4eb4HPYiaM4RqlZ1nlVTE7v9N+8Zw
         YMaA==
X-Forwarded-Encrypted: i=1; AJvYcCXcS7ylR8TzyEKADIhGPSrk7Vg/oquoP3NIMiCNLOqSapPk9yRz2sNtrbx0E8YILXiWt/QWy4YO9riodQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RdC8H9FiVJ4C2Fcjalb1ZUSmv6Bx76y2V5xPA1gQnPI2l+9H
	BT6kaNjJC/F4QdZp5f17IgQFKYxedfhFLfTwo0RW+fLIJTKiM4SXKyEU
X-Gm-Gg: ASbGncurcKhP+JaiR3q7aJHrfqNl/fwmavzs5ihOmR9j1MudT3irfemEcpFnc805Ouz
	/a7pXi0t3DsCsitOaJDCLiIyRwcL9/l8KFZduToLji+KWC2l2HUPmMiOAAFIEhkgvUp5jmeh5v5
	vpQQQmWab0t5qr01O2PaKfba457kJ9YbJM8QRBUc8vH1DRyej9/E7FaRNOfrqNvOdV2s5oKz6p5
	DF7HRcgJRX29WBkYFuWUDiQSXTR84epwvy5IPl9fiJN68LYf2B0+B4iMSuZt4Soz7/Hc1gs7V+o
	qPxUu2WARL69c+qyev4dqS4v87tU9YpUJeHZHLwea1CpR2dmRQI65J5blblEI0clQVUKAYENiGq
	r0lHNcb0jIsYlrb4NT3s7We0eV3qyESLsqvYEjXnhB51FgS2ylCcuXTSm8H7PAKGwpg7aaFrzvg
	PxuKMQHF0G6qeupA==
X-Google-Smtp-Source: AGHT+IGqJ3fK980blF3S2OhDDl1kPCFC3PDx3uiV6lRR9MlLGgQ+c3xMg89feF4XpI76Z2y7cP/wYQ==
X-Received: by 2002:a05:6a00:23c2:b0:780:f758:4133 with SMTP id d2e1a72fcca58-7a274ba91d9mr12147230b3a.10.1761440722260;
        Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:21 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:07 +0000
Message-ID: <cover.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

On Android, different applications have varying tolerance for
decompression latency. Applications with higher tolerance for
decompression latency are better suited for algorithms like ZSTD,
which provides high compression ratio but slower decompression
speed. Conversely, applications with lower tolerance for
decompression latency can use algorithms like LZ4 or LZO that
offer faster decompression but lower compression ratios. For example,
lightweight applications (with few anonymous pages) or applications
without foreground UI typically have higher tolerance for decompression
latency.

Similarly, in memory allocation slow paths or under high CPU
pressure, using algorithms with faster compression speeds might
be more appropriate.

This patch introduces a per-cgroup compression priority mechanism,
where different compression priorities map to different algorithms.
This allows administrators to select appropriate compression
algorithms on a per-cgroup basis.

Currently, this patch is experimental and we would greatly
appreciate community feedback. I'm uncertain whether obtaining
compression priority via get_cgroup_comp_priority in zram is the
best approach. While this implementation is convenient, it seems
somewhat unusual. Perhaps the next step should be to pass
compression priority through page->private.

jinji zhong (3):
  mm/memcontrol: Introduce per-cgroup compression priority
  zram: Zram supports per-cgroup compression priority
  Doc: Update documentation for per-cgroup compression priority

 Documentation/admin-guide/blockdev/zram.rst | 18 +++--
 Documentation/admin-guide/cgroup-v2.rst     |  7 ++
 drivers/block/zram/zram_drv.c               | 74 ++++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  2 +
 include/linux/memcontrol.h                  | 19 ++++++
 mm/memcontrol.c                             | 31 +++++++++
 6 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.48.1

