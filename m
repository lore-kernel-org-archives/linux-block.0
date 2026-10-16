Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598146EF93
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152602; cv=none; b=cck7WkLvEeJbmTAeCQi8uzxj3q2XJI8/f9Z4c+MF6kN2PTMCPVi8ivLFsNWcbaNwDn9ddtcDgTgLZqOak16V436Gd7Ze59gzMHeWFfLytr1pPwIg+ksOuMLYJWWk1P2ZeiTgzCN8Jy+oDmZMVMr+j/LsRdMbam7FHnKelI/oPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152602; c=relaxed/simple;
	bh=2uqaJOE1ZflgZEPQal5CUnZ1clIz7YKu+QjcrMjDn8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HerRCq42arX3HoXVswxfMxS76HcJJNoP6Q/pmNDYUMJXJAFG01E3LlomS1m+wywvQbdt9JInDtTv7zWcQAcDDtapFh1ZTgEFRe9xxTk4rm21I9qVH/rG66Z29VW/cpKQcX4fDMhiRNdTRGx/E67mVvg5TMDGQmVILkDAglipLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH5zc43P; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH5zc43P"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ccca948203aso2667482a12.3
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792152600; x=1792757400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLob/vRQa3c1x4TgqQCsxa5ZzEfJKY3TcYiiw4aZMIU=;
        b=hH5zc43PpPHNzsYnAhGwvO0vBjxGqbNBmBkpj4C01o+joFr7hE75VGkhA0g1h+3Dt6
         kHoFxlr/EPZaABae8Fm4th20jKWqQHbU880+KRJR2Lcv39cgcBYCa+y4SQeR/3QjQGTc
         S2v1/xzLkt48w8+Xy+BdqtPCSe1RLAm5C7dZ5hRIMfz7k7mZXmjmYXcOXDLQueq4IGcf
         N73fV0cBi1gP2dFlrbRt8bwS20qSpMDNQFNM5NCEh4mrEZ/XM2vg680r7rxXUaG6Y3cy
         MSYkxEC8gD/DG3IGJq8kx5EHwLRoengI3t6jKTvytVGXgbwgUyBr5uIB8sdFEQN0vet8
         X05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152600; x=1792757400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLob/vRQa3c1x4TgqQCsxa5ZzEfJKY3TcYiiw4aZMIU=;
        b=H9TEYaCLGIpD50Nl/2S8hf2Uv8AExY2CjcE2gyb8h8iaMjPJy+ilYjj7MWR7I+r0BD
         6OFzYfoW06c0i8C3c4t0T/zz25eC5K4Tpps8fpHX9lFwV1A3K2IqB3xZosfDB7gt1zzH
         Km74g9o/ywVgL0K60kr3w2yk+N6Gh7mBtkzPgWYKnRPt85QZolTgV7aLMyYYgztIXv2B
         mljuUluaNF0x/BnyEfduaNrfhM1jmwFHBb7ZOWiYgEpWRStgj6QKB8OW/dEmqXlhZ5nE
         K5WXnxuilfPnH3td/+5DwFRX7Qg3uKCjx8AG+EJLLrYVOlClkWNJvw2omqc9vEZ7ElZc
         kiSA==
X-Forwarded-Encrypted: i=1; AKwUvBzHqF0LRMGftpgOrgFkNTEztXtUP1pqyAts0IxOUNE0u2MHQ4lbRku03BUiHkg1o575xRMm1ENFugRXQg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfGFCqU2REe1ShKqx+5/e78sFhoLVTsDUUwvRHQJdQ2usmv2AH
	jYzdIc6oebrDGKQ0XDtZwdVo0EB5NI34JbvsYZ6Qn6M+YBxSOcpBLpi5pSso5aMfV2BtmKDQ
X-Gm-Gg: AYBFou1wP9mR6VWzADbrP6safHlOZ4iZl/5+bLE2Il5jOWwUYfsLOBoTLT57rqkoO0r
	UHeo8ZdJUcag1NvTJDUlL1exI7rcbnQ86KdBXk0F6WPrKQxXSwRBpibVSTmRGdK0nQsLSAjSOJJ
	iBPlfbzois8JlU8KzQQ3O+yePBcO8kmYUH7xlAeVaXjjmVg3FBaZd+CZeKjjKv338pJa66Q9UHF
	zbexoxGPFtBGCBHJyTtiBBYgbNMPvmREkhOZsMLqK1erFW3mNcQt7hbtN5HsoqbZxltUGp4aDaS
	9ab3AvhPcsvXbyzFMYjDW9VcI6fLDhD7GB6GI+KWQ0xXM2zpkg3LAZMIcCKtMe4qyiMtS9xyiFC
	IhWvk8HA8PbBCQpu0TPgp6QA3J26Qo3AEYTRsJ3G1HG7aLeLjnWT/UXhxifrHI6LMJkf5JdTXI5
	tyLKH/9IZLlUtPNpGAQUy0QOreHlmZQTbZYaPo5Lwc7uPgZAH3mqKJfVmHJvTSsCsFd7fOmeDj
X-Received: by 2002:a17:90b:224e:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3ab3a9f42aamr16804358a91.23.1792152600469;
        Fri, 16 Oct 2026 05:10:00 -0700 (PDT)
Received: from hongfeng.mioffice.cn ([43.224.245.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm3908912a91.12.2026.10.16.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:10:00 -0700 (PDT)
From: Hongfeng Chen <chenhongfeng0212@gmail.com>
X-Google-Original-From: Hongfeng Chen <hongfengchen@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>,
	Wenchao Hao <haowenchao22@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hongfeng Chen <hongfengchen@xiaomi.com>
Subject: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu batches
Date: Fri, 16 Oct 2026 20:09:25 +0800
Message-ID: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Freeing swap entries is expensive when unmapping a VMA that holds many of
them. `zap_pte_range()` eventually calls `zram_slot_free_notify()`, which
frees one compressed object per page. As a result, the unmapping task
has to pay for every `zs_free()` itself. On Android, this slows down the
exit of a task killed to reclaim memory, precisely when that memory is
needed.

Two earlier attempts by Lei and Zhiguo introduced a new thread in the MM
core to asynchronously collect and free swap entries [1][2], which
seems overcomplicated. Wenchao's RFC v3 [3] moved the deferral into
zsmalloc, but introduced push/drain callbacks that zram and zswap had
to implement, potentially violating software layer boundaries. This v4
RFC defers freeing inside `zs_free()` itself, leaving callers unchanged.

Patch 1 makes `zs_free()` append the handle to a per-CPU batch of 64
handles instead of freeing it immediately. Once the batch is full, it
is handed to an unbound drain worker through a lockless list, and the
worker frees the objects. Releasing empty zspages is also deferred to
the worker. If the per-CPU state cannot be allocated, `zs_free()` falls
back to its original path.

With the zsmalloc work moved off the unmapping path by patch 1,
contention on atomic operations in zram statistics becomes significant.
Patch 2 moves the contended counters to per-CPU storage.


Using the following microbenchmark:

// SPDX-License-Identifier: GPL-2.0
/* Times munmap() on a region pushed out to zram: MB. */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <time.h>
#include <unistd.h>

#ifndef MADV_PAGEOUT
#define MADV_PAGEOUT 21
#endif

static void die(const char *what)
{
	perror(what);
	exit(1);
}

static double now_ms(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec * 1e3 + ts.tv_nsec / 1e6;
}

/* About 2.8:1 under lzo-rle, objects in 16 size classes. */
static void fill_data(char *p, size_t bytes)
{
	size_t i, k, n;

	memset(p, 0, bytes);
	for (i = 0; i < bytes; i += 4096) {
		long *q = (long *)(p + i);

		n = 106 + i / 4096 % 16 * 8;
		for (k = 0; k < n; k++)
			q[k] = k * 8 * 2654435761UL;
	}
}

static char *prepare(size_t bytes)
{
	char *p = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	if (p == MAP_FAILED)
		die("mmap");
	fill_data(p, bytes);
	if (madvise(p, bytes, MADV_PAGEOUT))
		die("madvise");
	return p;
}

int main(int argc, char **argv)
{
	size_t bytes = (argc > 1 ? strtoul(argv[1], NULL, 10) : 256) << 20;
	char *p = prepare(bytes);
	double t0, t1;

	raise(SIGSTOP);	/* ready */
	t0 = now_ms();
	munmap(p, bytes);
	t1 = now_ms();
	printf("%.6f %.6f\n", t0, t1);
	return 0;
}

Performance results:

ROCK 5B+ (RK3588: 4x Cortex-A55 at 1.8GHz, 4x Cortex-A76 at 2.4GHz,
performance governor), single process munmap on A55:

  times in ms, speedups over base
              Base       Patch1       Patch1+2
  size        time    time speedup   time speedup
  64MB       13.81    3.62   3.81x   3.28   4.21x
  128MB      28.50    7.18   3.97x   6.49   4.39x
  192MB      42.19   10.71   3.94x   9.69   4.36x
  256MB      56.06   14.26   3.93x   12.89  4.35x
  512MB     109.50   28.43   3.85x   25.66  4.27x
  1024MB    217.10   56.70   3.83x   51.15  4.24x

Same machine, single process munmap on A76:

  times in ms, speedups over base
              Base       Patch1        Patch1+2
  size        time    time speedup    time speedup
  64MB        5.59    1.58   3.54x    1.49   3.76x
  128MB      11.86    3.16   3.75x    2.95   4.02x
  192MB      17.18    4.72   3.64x    4.45   3.86x
  256MB      22.89    6.29   3.64x    5.87   3.90x
  512MB      45.15   12.52   3.61x   11.64   3.88x
  1024MB     89.16   24.75   3.60x   23.12   3.86x

x86 (Intel Core i7-14700HX, P-cores locked at 2.1GHz with turbo off),
single process munmap:

  times in ms, speedups over base
              Base       Patch1         Patch1+2
  size        time    time speedup    time speedup
  64MB        2.87    1.50   1.92x    1.14   2.53x
  128MB       6.00    2.93   2.05x    2.21   2.71x
  192MB       9.33    4.35   2.15x    3.33   2.80x
  256MB      12.51    5.78   2.17x    4.38   2.85x
  512MB      24.96   11.39   2.19x    8.62   2.90x
  1024MB     50.19   22.78   2.20x   17.05   2.94x

1-4 process munmap of 256MB each:

  times in ms, speedups over base
              Base       Patch1        Patch1+2
  mode        time    time speedup   time speedup
  1p         13.18    5.78   2.28x   4.35   3.03x
  2p         25.83   14.41   1.79x   4.57   5.65x
  3p         35.70   22.14   1.61x   4.68   7.63x
  4p         44.25   28.71   1.54x   4.75   9.31x

[1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@vivo.com/
[3] https://lore.kernel.org/linux-mm/20260508060724.3810904-1-haowenchao@xiaomi.com/

Changes since v3:
- Defer inside zs_free() only and drop the push/drain callbacks, so zram
  and zswap do not change. Yosry and Nhat objected to the layering in v3;
  Nhat also pointed out that v3 leaves torn-down entries on the zswap LRU.
- Buffer handles in per-cpu batches of 64 allocated on demand, instead of
  per-cpu pages rotated through a preallocated pool.
- New patch 2: keep the hot zram statistics per cpu.
- Link to v3: https://lore.kernel.org/linux-mm/20260508060724.3810904-1-haowenchao@xiaomi.com/

Changes since v2:
- Use per-cpu single-page buffers instead of a global list; the hot path
  only writes into the local CPU's buffer with preemption disabled
- Add a page pool for buffer rotation: when the current buffer is full,
  swap it with a free page from the pool and queue the full page for drain
- Introduce push/drain callback ops so that zram and zswap can each define
  their own element size and drain logic (zram stores u32 slot indices,
  zswap stores unsigned long handles)
- Drop the lock optimization patches it will be submitted separately as
  part of a dedicated zsmalloc lock contention series
- Link to v2: https://lore.kernel.org/all/20260421121616.3298845-1-haowenchao@xiaomi.com/

Hongfeng Chen (2):
  mm/zsmalloc: defer object free to per-cpu batches and a drain worker
  zram: keep the hot statistics per cpu

 drivers/block/zram/zram_drv.c | 171 +++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  16 ++-
 mm/zsmalloc.c                 | 182 ++++++++++++++++++++++++++++------
 3 files changed, 309 insertions(+), 60 deletions(-)


base-commit: f4e9810097537d862c128935c36216bcf0c31cb2
-- 
2.54.0

