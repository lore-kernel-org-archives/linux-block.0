Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710817;
	b=N+a2wRyWWpwjoZ2Wahz4cezwuy1ykOOlYmrqYPw6Dhvq7kRW2R1CO0xRVbY6Wqja9SaS
	 +3NPJJiRW0sS1XY3GNNqxK8E6wQwCqA2ONGa+8xAwqO14OD7sqMMmc3hPWY6j7I9mwkPA
	 VvipucKPOTJDZHRth2QFcW+P4PBgXZDRZxBQtXGaOoHNjiUsq5wXGQEJ5vtYXKEMQfPmA
	 JePcCG9tg756J7KDoKSLdN1ozT6HVl2wjNRTlkck3ukkTrHdrKQKXOt5KYHoQFvWab0Ml
	 bFV3J2sQBs4h0MRAb7d3M7rUdoNLFKUZfFPeyYR5XN7sSxWkiLm/NirPiWEgqUyWw4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710817;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=xOzrbckJJcWh/pB8wxs7WLkmsYb8n7B8H0ZwNaayh7s=;
	b=kEdJyzLq7TAYmMRlS5SaP5HF1TulBdanGYczKo7yY/XKg9T+AIyaFmvExc8zaFxIRmD6
	 M+YENi9cwzxaBXZhmYs1aZsBCwe/VjwnhUJ14lEdCpex9CQfw1dNvNkk1aqCkFsIN/3hV
	 uJ3KBCtG5InkXrQH/etNZayRHR8Bxx0IVjUOw/sHPEXt7MtZu62NEB4N5mf1OpCi1RsLD
	 MzrPlFHsRcrmRuGpiuLeGa4zMnFWwZ4pPVXl6Nga+zYdfVqrcy0jhlXQnKEBIS3WdUmjy
	 z9uA0oXxcgTLclZ/i9sAxW0AcjcKZ6/JNRN8ekaepHw3T1bu+BsIgzSSjiVt/DrWAJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=LsYG0WcT;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803C606A33A;
	Sun, 15 Nov 2026 02:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2803C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=LsYG0WcT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xO
	zrbckJJcWh/pB8wxs7WLkmsYb8n7B8H0ZwNaayh7s=; b=LsYG0WcTGpFFEaj51w
	hx5+0yDbIhj1b9nLpCnXMGUFydIl67wncWDCWhaAWnYq4lkb5ZUKoQ6NEND2Khvt
	9frOsPnsa3M+Lk/1a5DTXZ0N2jwuhaZdLYeH9QUDnlp6qpAh5TSHCiOtQq20YpUK
	EmWzwXJcFREKNJeGC7/qp1BoU=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3H_OtHPlq+ob+DQ--.31738S2;
	Sun, 15 Nov 2026 10:45:03 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <ying.huang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Wajdi K Feghali <wajdi.k.feghali@intel.com>,
	Bala Seshasayee <bala.seshasayee@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Barry Song <baohua@kernel.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: [RFC PATCH v4 0/4] mTHP-friendly compression in zsmalloc and zram based on multi-pages
Date: Sun, 15 Nov 2026 10:44:47 +0800
Message-ID: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3H_OtHPlq+ob+DQ--.31738S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1xGrW8Zr13GF15ur17ZFb_yoW3trW3pa
	yag3sxCF18ZFW7Arn7Cws2kryfG3yxXrW5Ga4Sgr10kFy5JF1IvF4DKF98XayUurs3WF47
	Zr45Gr1ruF1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIZXOUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQ9LG2r5HK8qAAAA3k

When large folios are compressed at a larger granularity, we observe
a notable reduction in CPU usage and a significant improvement in
compression ratios.

mTHP's ability to be swapped out without splitting and swapped back in
as a whole allows compression and decompression at larger granularities.

This patchset enhances zsmalloc and zram by adding support for dividing
large folios into multi-page blocks, typically configured with a
2-order granularity. Without this patchset, a large folio is always
divided into nr_pages 4KiB blocks.

The granularity can be set using the ZSMALLOC_MULTI_PAGES_ORDER
setting, where the default of 2 allows all anonymous THP to benefit.

Examples include:
* A 16KiB large folio will be compressed and stored as a single 16KiB
  block.
* A 64KiB large folio will be compressed and stored as four 16KiB
  blocks.

We captured anonymous pages from four Android applications on a Pixel 6.
To evaluate throughput, we allocate a buffer via mmap(MAP_PRIVATE |
MAP_ANONYMOUS), populate it with the captured pages, and invoke
madvise(MADV_PAGEOUT) to swap the buffer out to zram, measuring the
pageout duration. We then sequentially touch every 4 KiB page to fault
them back in from zram, measuring the swapin duration.

For example, testing the 143 MiB WeChat corpus (times in seconds;
w/o: without the patch, w/: with the patch):

Algorithm  pageout w/o (s)  pageout w/            swapin w/o (s)  swapin w/
lz4        0.247            0.210 (-14.8%)        0.137           0.113 (-17.6%)
lzo-rle    0.240            0.207 (-13.7%)        0.149           0.123 (-17.5%)
zstd       0.567            0.452 (-20.4%)        0.258           0.192 (-25.6%)

v3 left two issues to discuss:

The first issue is internal fragmentation. A compressed 16 KiB block
is rounded up to the next size-class boundary. If it lands in a class
with a large gap, the gap becomes per-object padding.

On all four applications, unused pages in partially filled zspages
increase by ~1.8 to 2.4 MiB, and the per-object class gap is wider.
However, because the number of allocated objects drops by ~74% (from
four 4 KiB objects to one 16 KiB object), total rounding waste
actually falls by 13% to 31%. Combined with 5% to 15% better
compression ratios from multi-page compression, total zsmalloc memory
occupancy (mem_used_total) is reduced across all applications.

For example, below is the memory breakdown under lz4 for our four apps
(lzo-rle and zstd show the same trend, saving 3.8% to 9.3% total memory):

App          objects (w/o -> w/)        rounding waste (MiB)    unused pages (MiB)      mem_used_total (MiB)
WPS          27,530 ->  7,285 (-73.5%)  0.80 -> 0.56 (-29.8%)   1.07 -> 3.35 (+214.0%)   36.4 ->  34.9 (-4.0%)
WeChat       32,460 ->  8,450 (-74.0%)  0.89 -> 0.62 (-30.6%)   1.35 -> 3.32 (+145.8%)   42.8 ->  40.0 (-6.7%)
Douyin lite  62,668 -> 16,218 (-74.1%)  2.07 -> 1.61 (-22.3%)   1.37 -> 3.78 (+176.0%)  100.8 ->  93.6 (-7.1%)
JK chess     71,950 -> 18,584 (-74.2%)  1.75 -> 1.52 (-13.0%)   1.43 -> 3.28 (+129.7%)  117.0 -> 112.7 (-3.6%)

Here, objects is obj_allocated, rounding waste is total class padding
across all objects, unused pages is memory left in partially filled
zspages, and mem_used_total is the total memory allocated by zsmalloc
(including fragmentation and metadata).

We also built a 256 MiB lz4 synthetic extreme case: 16 KiB blocks with
the first K bytes random and the rest zero, with K tuned so the object
lands one byte above the previous class. Below is the code to generate
this pattern:

#define BLOCK 16384

static void make_block(unsigned char *buf, size_t k)
{
	size_t i;

	for (i = 0; i < k; i++)
		buf[i] = rand();
	memset(buf + k, 0, BLOCK - k);
}

static void write_corpus(int fd, size_t k, size_t nblocks)
{
	unsigned char *buf = malloc(BLOCK);
	size_t i;

	make_block(buf, k);
	for (i = 0; i < nblocks; i++)
		write(fd, buf, BLOCK);
}

With the default CONFIG_ZSMALLOC_CHAIN_SIZE=8, the largest non-huge
class gap is 576 bytes. Setting K to 10,781 bytes lands the object in
class 11,456 with a 575 B/object padding, increasing total memory by
5.0% over the baseline without the patch (179.3 MiB vs 170.7 MiB).

With CONFIG_ZSMALLOC_CHAIN_SIZE=10, the classes are denser and the
largest gap drops to 448 bytes. At K=10,781 bytes, the memory overhead
falls to 3.9% (177.3 MiB vs 170.7 MiB).

A potential future optimization is during size-class merging: we can
avoid merging classes if the resulting gap exceeds a threshold (e.g.
ZS_MAX_MERGE_GAP = 256 bytes), for example:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ can_merge() @@
+#define ZS_MAX_MERGE_GAP	256
+
+	if (prev->size - size > ZS_MAX_MERGE_GAP)
+		return false;
+
 	if (prev->zpdescs_per_zspage == zpdescs_per_zspage &&
 		prev->objs_per_zspage == objs_per_zspage)
 		return true;

The second issue is partial read. If the order-2 allocation for the
swapped-in folio fails and falls back to order-0, we must decompress
the entire 16 KiB block just for a 4 KiB swapin.

v3's 4/4 ("mm: fall back to four small folios if mTHP allocation
fails") handled this by building four small folios. Usama asked whether
defrag=always could replace this patch. But we only need direct reclaim
for the do_swap_page order-2 allocation; otherwise all anonymous mTHP
allocations would enter direct reclaim. So the new 4/4 adds
__GFP_RECLAIM to the order-2 swapin allocation in do_swap_page().

We measured the cost of entering direct reclaim in the swapin path on
an i7-14700HX with no_turbo=1: a 1 GiB memcg, zram (zstd), 16 KiB mTHP,
and an arm64 defconfig vmlinux build with -j20 in the background. The
bench was pinned to one CPU and the build to the rest. We compared
forcing direct reclaim with the existing behavior, 10 totals per case,
each total 30 rounds of 100 MiB anonymous pageout/swapin.

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <time.h>

static double now(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec + ts.tv_nsec / 1e9;
}

int main(void)
{
	const size_t size = 100UL << 20;
	unsigned long *p, sum = 0;
	size_t i, off;
	double t0, t1;

	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (p == MAP_FAILED) {
		perror("mmap");
		return 1;
	}

	for (i = 0; i < size / sizeof(*p); i++)
		p[i] = i & 0xfff;

	t0 = now();
	if (madvise(p, size, MADV_PAGEOUT)) {
		perror("madvise(MADV_PAGEOUT)");
		return 1;
	}
	t1 = now();
	printf("pageout %.6f\n", t1 - t0);

	t0 = now();
	for (off = 0; off < size; off += 4096)
		sum += *(volatile unsigned long *)((char *)p + off);
	t1 = now();
	printf("swapin %.6f sum %lu\n", t1 - t0, sum);

	return 0;
}

                         w/o DR          DR
partial reads            235,832         218
swapin total (s)         24.85 +/- 0.56    22.80 +/- 0.73
pswpout (pages)          11.4M           11.3M

Here, partial reads is the zram_bio_read_multi_pages_partial counter.
The direct-reclaim case did not show a measurable cost. Almost all
partial decompressions were eliminated, making swapin 8.3% faster.

-v4:
 * Rebased onto latest akpm mm-new.
 * Patch 1: Fixed multi-page page accounting (NR_ZSPAGES, zs_compact,
   and debugfs) to use physical pages via class_pages_per_zspage().
 * Patch 2: Adapted to upstream's new zcomp read/write stream separation;
   added a preallocated decomp_buf in zcomp_dstrm for partial reads to
   avoid memory allocation in the swapin path.
 * Patch 3: Updated zstd backend to pass ZCOMP_MULTI_PAGES_SIZE to
   zstd_setup_params().
 * Patch 4: Dropped v3's 4/4 fallback and added a new patch to allow
   direct reclaim for synchronous multi-page swapin.

[1] v3: https://lore.kernel.org/all/20241121222521.83458-1-21cnbao@gmail.com/

Barry Song (1):
  zram: backend_zstd: use multi-page size for zstd parameter setup

Nanzhe Zhao (1):
  mm: swap: allow direct reclaim for synchronous multi-page swapin

Tangquan Zheng (2):
  mm: zsmalloc: support objects compressed based on multiple pages
  zram: support compression at the granularity of multi-pages

 drivers/block/zram/Kconfig        |   9 +
 drivers/block/zram/backend_zstd.c |   4 +-
 drivers/block/zram/zcomp.c        |  31 +-
 drivers/block/zram/zcomp.h        |  19 +-
 drivers/block/zram/zram_drv.c     | 499 +++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h     |  43 +++
 include/linux/zsmalloc.h          |  10 +-
 mm/Kconfig                        |  29 +-
 mm/swap_state.c                   |   7 +
 mm/zsmalloc.c                     | 242 ++++++++++-----
 10 files changed, 757 insertions(+), 136 deletions(-)

-- 
2.43.0

