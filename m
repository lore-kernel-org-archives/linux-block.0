Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82826F47C
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773801; cv=none; b=rBvVrfqP0gdPPm/YL/9KWpOEIHqk+hiX4rhkFJTWw819+ARZ8ArEyJ6e48FdSkkF2mVi3FOwXg0M3+ZTe4VhDMz5ttY6i6apPP1/yKohIlmXvBjcJkkSCvJoIMKOG6xNQc0ZFCIQe9IkWeMpJarukfpnz3gyocFaYzUnBn3fBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773801; c=relaxed/simple;
	bh=OsPM8v+E4y3NWGneKFZu5xp/xot0j3nv947RmXQaSIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGP6NH01qQSZV5ovLTq40nfm4VIVPBSc7uBNbBNCvW1PO82C1teH8pyEbVtdjI2MApjW9GBCBzhJiq+xwQmNJIVdu1b7SzybzZI6u9fAcrFcO5/dGzababCToI/lSeR4D6cZJTMOkYZX5Dh3bVapSOLMnHuv3+JwMI5lxH+uGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkOBbh3Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkOBbh3Z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82748257f5fso2735872b3a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773793; x=1777378593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTX90kBWYPlf5c0l3p/5jjfTkLXTd7XpDQpkztEEKcw=;
        b=ZkOBbh3Zgyj9PyGoJ2+EPb60zk2pkpLxo9AHPaSlQhgc6Ph+tufrPJZqoPkWAUxsqk
         EW9iIlXkqWcVTg3s18dpcW6zhwd9NwxXVcbznUaFOkEGQ01OXYlglXzI5EJd7TYYDnVG
         RZBYdUzYYzxE+dStizA+es67qCF+CNuXuAmmd2YKdkAFLybjLOG38TAxu5irZYNMchjQ
         X4UM1V5Bz8K6spNXLQ/ooEdu6aTuO1HA2S5AQ63Zce+clYLAM3Yd7ypA157W8jzK2Ydh
         8R8pPcdlrdDJyTLvbRafjLHVoo4oazZS7eaa6kgiPV1HzI3EsoLY9qTuwIaJ/hnfSP75
         HnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773793; x=1777378593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTX90kBWYPlf5c0l3p/5jjfTkLXTd7XpDQpkztEEKcw=;
        b=ft7yrlkiKcot5ysQ7uMaFQK+FheNPKuWEoYKCrKYjf/EA0lXDTmV0fXIBJtY7Ognvx
         yo5ylJF9WAwq5hVHr11wFy3kzzNVc9WHPdI9BdyVZipn1fna4n0zgixy4V3LC4//B+UH
         lCQAZWfGLr/4UlHNHQFlyVkos92SreUtAcss8QDt4REFLNoA5njZT1p7V69uu33Q8sCP
         Ual9IGmiuDZFU+vs5J8nmKHtemOIkhFHqvms05hwefQxqUcSrNynjeW4q3pZdU/VayLW
         p9wMbvBp1EGyGsCdxvx1xc0KFKm45oEHb8pCvJv6rcUyskaRk55vRPvSSq5uok2xxS1G
         Uwbg==
X-Forwarded-Encrypted: i=1; AFNElJ/wCcwH16N44uZkux/lFKYZ4ClXY+7kuIHqgjrtY1IoAo5CELvI+3s1ahxTSb0FwTSj3kLVTQbXEqHSbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlLg5KwXONLqMV3wCgxUN7PLHKXjJVPoqC9Md3JaNY8W1R2u2
	UE/dggoK4UhOQAf7sfxLLlUpDv1qLup2Difm5HdcwPZHu+JNh1FSzZtj
X-Gm-Gg: AeBDietp4QLWYE3RSbDV8jEPJEIQEkeq2uixmvFae8z8Tyq9thp94XaKFLXRB/htKiD
	vYWLR8w2G3sI7qY9kup7oq3e/AOf0KX5uguzMsWFFC3+MllziXEGMGFq+OaGgB9z3nsQDfGUvr4
	RkRnIheVrom0fVAkzwXftxC//ILfgcylWCc50nZeow9IWGEnLzMLD2jIC6HUrKQTWxAPf+YjwzK
	qWFCBi/f0zocKCoABNHelFKHDdCjx8g69wJsI7P00MUKpZc2DMHOwdeUjvDwb21a543oCI7jn9U
	Uz84p80FmCwRMoxhclJ2IPKfZSAFspumu5AfGXHW5H8O4zmwK2Zw8xuANFP7YGPIUzWO27c8hZw
	ffvk6wtYHIhZBwmT7v9To+1sVYeSH2U/XbvrT0F79/dcuK1P/H8ubXQ0lFxfut4hnXn/V6aIarV
	sU15a25QSMiND6PhEGyUyl7NM76YrMDz3cR3ukvkcMLM3cVWQ=
X-Received: by 2002:a05:6a00:9291:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-82f8b370621mr15308948b3a.6.1776773792646;
        Tue, 21 Apr 2026 05:16:32 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm16371071b3a.54.2026.04.21.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:32 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Barry Song <baohua@kernel.org>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap release path
Date: Tue, 21 Apr 2026 20:16:12 +0800
Message-Id: <20260421121616.3298845-1-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap freeing can be expensive when unmapping a VMA containing
many swap entries. This has been reported to significantly
delay memory reclamation during Android's low-memory killing,
especially when multiple processes are terminated to free
memory, with slot_free() accounting for more than 80% of
the total cost of freeing swap entries.

Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
to asynchronously collect and free swap entries [1][2], but the
design itself is fairly complex.

When anon folios and swap entries are mixed within a
process, reclaiming anon folios from killed processes
helps return memory to the system as quickly as possible,
so that newly launched applications can satisfy their
memory demands. It is not ideal for swap freeing to block
anon folio freeing. On the other hand, swap freeing can
still return memory to the system, although at a slower
rate due to memory compression.

Therefore, we introduce a GC worker to allow anon
folio freeing and slot_free to run in parallel, since
slot_free is performed asynchronously, maximizing the rate at
which memory is returned to the system.

This series takes two complementary approaches to reduce zs_free()
latency:

- Shrink zs_free() class->lock critical section by moving zspage
  freeing outside the lock.
- Defer zs_free() to a workqueue via zs_free_deferred(), benefiting
  both zram and zswap.

The deferred free approach builds on Barry Song's earlier RFC [1] with
changes based on community feedback: optimization moved to zsmalloc
layer instead of zram; fixed array storing handles (not indices) with
O(1) enqueue to avoid memory allocation on the exit path and data
consistency issues on slot reuse; size-based capacity scaling with
PAGE_SIZE.

Xueyuan's test on RK3588 with Barry's RFC v1 [3] shows that unmapping
a 256MB swap-filled VMA becomes 3.4x faster when pinning tasks to CPU2,
reducing the execution time from 63,102,982 ns to 18,570,726 ns.

A positive side effect is that async GC also slightly improves
do_swap_page() performance, as it no longer has to wait for
slot_free() to complete.

Xueyuan's test with Barry's RFC v1 [3] shows that swapping in 256MB of
data (each page filled with repeating patterns such as "1024 one",
"1024 two", "1024 three", and "1024 four") reduces execution time from
1,358,133,886 ns to 1,104,315,986 ns, achieving a 1.22x speedup.

[1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@vivo.com/
[3] https://lore.kernel.org/linux-mm/20260412060450.15813-1-baohua@kernel.org/

Xueyuan Chen (1):
  mm:zsmalloc: drop class lock before freeing zspage

Barry Song (Xiaomi) (1):
  zram: defer zs_free() in swap slot free notification path

Wenchao Hao (2):
  mm/zsmalloc: introduce zs_free_deferred() for async handle freeing
  mm/zswap: defer zs_free() in zswap_invalidate() path

 drivers/block/zram/zram_drv.c |  37 ++++++---
 include/linux/zsmalloc.h      |   2 +
 mm/zsmalloc.c                 | 141 ++++++++++++++++++++++++++++++++--
 mm/zswap.c                    |  16 ++++-
 4 files changed, 177 insertions(+), 19 deletions(-)

--
2.34.1

