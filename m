Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063103502A9
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220519; cv=none; b=jK7HG8dtVYlX6hVKhSvS1E4U6CYIqaaL9Tb4w/Eyo3H2LZaEV33N+fdUFalWZbfp+AFfGnDl+hLDcxROD5ImNOPPxdRKuE9r/fojos67IB+3nsgOBY8wpChhxAngEGcl3tmioafTWIFXccKORtIUbYmw7Yj4glcHEZ2xzlx7Flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220519; c=relaxed/simple;
	bh=F44cshLe0rQV26karhspwn59+OgT6EOxogJitR4bH2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=muiNVUSe4zJChB4MNfw7nORUp1iBsMxyTPvTYN3fgw1K2mmalRjvYx0D0GD68au+1CLpQE6mxlI01WArjvJ2qtbmGGldQphZWXZnklVoS5TS3cqbjS7XfvzbsNQBPNRl4QO1oBOzwBIAdoaPSYS1HN95OD9nJbGuWwpfqlpXrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSvaqiFF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSvaqiFF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so796595a91.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220512; x=1778825312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NO9fgxc/4uI9ijrHR/+VJ2Jv5ttegtV3BGSa2bNu9og=;
        b=fSvaqiFFKrdCN56DZDOtgtiUouDZZcJqbCa93UJYYSSo/S5QoZaPwyKgbKayPZnMoI
         022KfCCxy0E4gS1nkAJIZN6VRdFIPjC2CwKUoLgtW9ubQcZdeBSsFc2RJRgSKt+8yAFQ
         1M5dW5a/cmS3iH/jRCBg7uFe6xJY9+eGS59ghlSMSkK7OnSLqePpCJ0l3NMl3pF8a/4P
         BHrC6rYxsO+vBaYp4DmOP9GukfgcOd/tCw2ERy2Cevfj/lNvxxzfMtyeXz1a809Y0XXg
         dnprq3YnzPE8Enq3g3dxmWmcVtGIXaoniI4HUB7TCp5EXn4weUHtO2IZkxRqyN6pCCQQ
         8vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220512; x=1778825312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO9fgxc/4uI9ijrHR/+VJ2Jv5ttegtV3BGSa2bNu9og=;
        b=OrRnbSpOsW09wsPtSRjB+XghkioT2FVtPdX95eXiUB9sCRoiUrgZjiXoD4D5S+WKN3
         Un3KNKTYh+B1PQTgGV2G0g+AULl6BEfOTqoHBYjPjOKRNbboxK7IsgTimG8bfOYvbLOU
         MZyqmMx8eXxjAwxuY6mHDJnmZLm2zSkJGtCktgwTSdYDxvyMqlpCrYgLylWAgMXWB9i1
         YsFxUunZ77TTWSNnWlIAuEtc/fpcprh8efFvyLzIrVM30skWec8Mh6DOTkzeMhU/3tgL
         Z5Q5RfKgL/ZX/tt+QNfIADzJyPbtEQ79S3fQp+nHYpC0jnksint4Qub2Jli6F0zkJ11o
         HWxg==
X-Forwarded-Encrypted: i=1; AFNElJ8LQvs+wMgvCvxC037X05MsfTMxbBwa+RcUCHvMtB/s3F0G/uBg/c2+nJWlgSylVhrD/Gwvqa+vZMVy7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzMJSHyeaymNpGduuQSo6rwqSUPqtMQwe9c0Dnwkhezzvs18y
	w5U+/U7GKY3qJObseEULx6QLfwT58IqwufL6bRV2tLdd38PcbeNQ6LLy
X-Gm-Gg: Acq92OFt40VRJyICkf8zUwlB5NrdsUFEdddlqO9MbHWfNNJpqD4WEIOEjIxZLYV5obN
	i/+EvZE4WDhEzx2L+v06/T1VRt0NWvba7b4YTpCMk6i2ULQ9xDVWiOa+FHl3rDvGve4L8mQ9/dv
	YLYJeYVUePUn6q3OCcwVs/XnFCNB7LcDJlXV4dWuXSmnoKUIm+JUd+OvUb1Foi8lc5g6lxqcPvf
	CpNHFcNWV6S2nRhxFqvZOL5ysZjbEkfnEDln4+doecG26PHQqvb4tMXMQOKIKhfNytFTLXKGuK8
	r7BtmDJsyc+aZJmCi7TibdiWXozGCVmsKdsnsgTG9Yw9xtr0+5oWuWO0WIH+x+o9woQl2YQvOiF
	j6NBkba1ZKcBFLVWEOlPEDHOlv4ZvMeHCIbcYwKvz5WI9e7tIfTUAE5zB3t8gu+Gl1i7p74WOhk
	PcT4+TT85cwHloFQxVRYmQLdF5Ss1OZlcxyPgqyPL2vUO5ZwvV
X-Received: by 2002:a17:90b:4d90:b0:365:b93a:1ebc with SMTP id 98e67ed59e1d1-365b93a1fe0mr9875584a91.3.1778220511629;
        Thu, 07 May 2026 23:08:31 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm673651a91.1.2026.05.07.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:08:31 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to accelerate swap entry release
Date: Fri,  8 May 2026 14:07:20 +0800
Message-Id: <20260508060724.3810904-1-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Swap freeing can be expensive when unmapping a VMA containing many swap
entries. This has been reported to significantly delay memory reclamation
during Android's low-memory killing, especially when multiple processes
are terminated to free memory, with slot_free() accounting for more than
80% of the total cost of freeing swap entries.

Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
to asynchronously collect and free swap entries [1][2], but the design
itself is fairly complex.

When anon folios and swap entries are mixed within a process, reclaiming
anon folios from killed processes helps return memory to the system as
quickly as possible, so that newly launched applications can satisfy
their memory demands. It is not ideal for swap freeing to block anon
folio freeing. On the other hand, swap freeing can still return memory
to the system, although at a slower rate due to memory compression.

This series introduces a callback-based deferred free framework in
zsmalloc. Callers (zram, zswap) register push/drain callbacks to
define what gets buffered and how it gets drained. The entire free
path including caller-side bookkeeping (slot_free, zswap_entry_free)
is deferred to a background worker.

Implementation:
  - Each CPU owns a single-page buffer. The hot path writes a value
    via the push callback with preemption disabled (no locks).
  - When the buffer fills, it is swapped with a fresh page from a
    pre-allocated page pool. The full page is queued to a WQ_UNBOUND
    worker for drain.
  - The drain callback performs the actual expensive work (zs_free,
    slot_free, zswap_entry_free, etc.) in batch, off the hot path.
  - If no free page is available, the caller falls back to synchronous
    processing.

The speedup comes from moving expensive swap slot freeing off the
munmap hot path into a background worker, so that intact anonymous
folios are released back to the system without blocking. The worker
drains at a slower rate since compressed objects are small and freeing
a single handle may not release an entire page until the zspage is
fully empty.

Performance results (Raspberry Pi 4B, ARM64, 8GB RAM):

Test 1: munmap latency for 256MB swap-filled VMA (zram backend)

  mode        Base       Patched     Speedup
  single      61.82ms    8.62ms      7.17x
  multi 2p    94.75ms    54.11ms     1.75x
  multi 3p    154.64ms   104.83ms    1.48x

Test 2: munmap latency for different sizes (zram, single process)

  Size       Base         Patched     Speedup
  64MB       14.11ms      2.18ms      6.47x
  128MB      29.45ms      4.48ms      6.57x
  192MB      43.85ms      6.62ms      6.62x
  256MB      57.01ms      9.08ms      6.28x
  512MB      115.13ms     55.58ms     2.07x
  1024MB     229.66ms     153.28ms    1.50x

Test 3: munmap latency for 256MB swap-filled VMA (zswap backend)

  mode        Base       Patched     Speedup
  single      152.14ms   51.26ms     2.97x
  multi 2p    186.56ms   105.42ms    1.77x
  multi 3p    205.83ms   153.32ms    1.34x

Test 4: munmap latency for different sizes (zswap, single process)

  Size       Base         Patched     Speedup
  64MB       37.83ms      13.26ms     2.85x
  128MB      75.11ms      26.73ms     2.81x
  256MB      150.78ms     52.97ms     2.85x
  512MB      303.04ms     130.38ms    2.32x
  1024MB     599.95ms     287.10ms    2.09x

[1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@vivo.com/
[3] https://lore.kernel.org/linux-mm/20260412060450.15813-1-baohua@kernel.org/

Changes since v2:
- Use per-cpu single-page buffers instead of a global list; the hot
  path only writes into the local CPU's buffer with preemption disabled
- Add a page pool for buffer rotation: when the current buffer is full,
  swap it with a free page from the pool and queue the full page for
  drain
- Introduce push/drain callback ops so that zram and zswap can each
  define their own element size and drain logic (zram stores u32 slot
  indices, zswap stores unsigned long handles)
- Drop the lock optimization patches it will be submitted separately
  as part of a dedicated zsmalloc lock contention series
- Link to v2: https://lore.kernel.org/all/20260421121616.3298845-1-haowenchao@xiaomi.com/

Barry Song (1):
  zram: use zsmalloc deferred free callback for async slot free

Wenchao Hao (3):
  mm/zsmalloc: introduce deferred free framework with callback ops
  mm/zswap: use zsmalloc deferred free callback for async invalidate
  zram: batch clear flags in slot_free with single write

 drivers/block/zram/zram_drv.c |  44 ++++++-
 drivers/block/zram/zram_drv.h |   6 +
 include/linux/zsmalloc.h      |  16 +++
 mm/zsmalloc.c                 | 208 +++++++++++++++++++++++++++++++++-
 mm/zswap.c                    |  38 ++++++-
 5 files changed, 306 insertions(+), 6 deletions(-)

--
2.34.1

