Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037803;
	b=3aCSw1L6n8yGnTmWV5F22cmpsHNK3p/N6oZvCRBDGZu+2kqzP6/q94tzyZnrAwzLTWGf
	 kocV6JL05NzKB7en7xCtuNnoufrag6T6zCGGiLxq4oG9+8zpjUZ6TsffTPMbpjGzTVRr3
	 EZ/pCu5vZeIyeo9wLxS1dytexckungd05ITbqbq5lxAmUe5XRIGXjBrVkvSoZzx5DrdO7
	 KkXSISpRymrzIr5A68698B4B4/a4LOulYEPdfV1RJY0Nn6Ykz5kBhJ7jd86BKWO2xk/vg
	 EUD+Ogr9LyZBgo6Eq1v7mc4d12zGwMNsRHTkJ0JrAsnX2T0S6UIUbwhQyuvnpQ+s3bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PTc7ppHJ4lMykoz5PJpIQu+5Hn27M/f7qYx8yuQcu48=;
	b=C6j7xVP2pCOaBwG2YPQJODK4zkzNaxSddAFZhVP+XWnpHU743BcADrV5QlDsiFrb88Cr
	 b+NWwFiJ4bKBf8JNVljRkpj+R2mwdIklhw9b6uMa+N6C64pvmllujO0NHe5Om2SJYJbg6
	 1LW34Xrcy63W6icaPqSqF+JvYuSIWCJU/F8CKHUzm1BASHAln+N2Pf6ccBrfnEZb4A+7N
	 AA3WISr/bvlfUPyHcRdOymcvb+KqKOnjSt3lWbU4Tgmx6UDkIpzI4ruTGNJj25A3Fm6UG
	 URE3yU9GkzyJHqj45Vgi7KWITTZtAusp7tgKcBbrszl5DbXHhSBF27dVfGnEdqZWv7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vrme0XPk;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9B606A320
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD9B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vrme0XPk
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4d07494b0so3579717b3.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037802; x=1795642602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PTc7ppHJ4lMykoz5PJpIQu+5Hn27M/f7qYx8yuQcu48=;
        b=Vrme0XPkA4/m3Uf562TE17DfJNOn6qRrnSsP0Vfv4Ghf+IabqBpXXr3lhTpLxkBa0Q
         USEQcrk/bRWuxgR/afGsTSQE+jBa+WpsWcoogapKVK8YdGQhmT9Wk05Mt82o7sBoBvbh
         r/9MjM3RuoskpAniVxzTxMtq0iZwnRVZsvLstoDHx1O5+p+vdE2ikNCmIJ5pJ4NYrfHV
         T33GFx2+EycbB0q4OSID8DQtnTrPEZq7NLUGBTFQ2UhjU9X+d959A5B11NpIICp44waf
         uRqsHBky/AoeYmxXZLSAsR3O5KviQ2ORITdiGJ6Ghn1TOmf4p/HhDEoqXeDcUe361M/W
         EwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037802; x=1795642602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTc7ppHJ4lMykoz5PJpIQu+5Hn27M/f7qYx8yuQcu48=;
        b=kkcF0aUljOpHphwExwhGeYXYWqvUpcYW7n3K3dFxdAAEXJ353z98Mviw+yDW1QtR3B
         FGVvvt7lR4Sb2fmNJUDA5cVrS/JlElsejF5d5rrfUAWWqiG22rxWPdmhmJyt08rPJdWN
         8ky9QMaNoHpPGzzwFiL9XMaaFNVVArHCObmqeXWDlZLBNk7NtlA6yIL3aQo8vGsybQiu
         DUay1B4xwpn8XODVIKTl52z6uN5jiLyoY4CUrm2snIbRMMo4pK4bix71gHkUrC/YXJ9V
         rAZVgbte/r0c1feCo7PwvfcODYA5J7HHYldNyovHgMlkhRHhtmdiz3T7cmdl7zHUfI8b
         /gvg==
X-Forwarded-Encrypted: i=1; AL+hErG+EAOIC6u2Oorj561zPR3h9SuXvGfn+hLqN4poLM5zwNL02cxcX4X7eNU4r10GTulNHVMivYD33vNVWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8j+r5zvMIw3JH/oJpmXLHzIYuGBLAhTGWwDabj9sCQz+DNeL6j
	oTEn2eS5B+hXT5UjoeZl6VXxq/bCbuGU/e91v62JPbleovBry0ZQPA20
X-Gm-Gg: AZFdTZeM5963GSDWQWS8Ioh0aCVvVg9Db+EGvl4wuKHfxrWiYRj8B+sHutbR/p6F6Ep
	0G7u9KSukebfNa+varqjYojqWHGzhsejIJYjebpD6Q2XaTpzQ3MDI5C3YyngAj00D+4OvI1XvX0
	2cVbfEZhlbMri9rWD6lSExBxM1kaxn3vFV9iOY6OrpGAkw9BBwVpLMDNeiBsHeI1vY2kY/zK8kA
	bT8kW0H9TMwxjP8f4JuyGikLxzxDVBlqKeVhSVFwBJZPduE3KKoq5ZjxAR6BYJWQINQhOfmUCPA
	n0rvE0sPkBdN5UEfDQzGPvlub34rTtRACI64KmPZeNhmbLs3Euz+sHKsSU+HlMuINej50lTU0f0
	yHJEk3lTnMWAv0CIqSyRs4Nf3JjUh5BiOUAEC5tCp3/MkBMw9AWqlkbmbtyvPWiNvPadR8m2nFe
	KE82gk0qJN7PCPnGMn+7J46fkGYrEANnL2BdNn0ofnHqnPEGRIrfJ3shAJ1NqJDGKI4YJ+QRWlq
	ANbdGALwhzr2SEaA63pllo6IFiSMS0HZ55eZ72xl8yk+adecBEslgEop61natxWSh/ECj1pitM0
	zD3FKXKohPwVrNrUJemN9kYUwstcROfhJAQmIf2sg2o3Nx3c/+u0ye8=
X-Received: by 2002:a05:690c:6b10:b0:8ae:b617:712d with SMTP id 00721157ae682-8b5104a9bc1mr3344367b3.13.1795037801404;
        Wed, 18 Nov 2026 13:36:41 -0800 (PST)
Received: from 5163NRD-SPrabh2.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030be2sm24565697b3.10.2026.11.18.13.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:36:41 -0800 (PST)
From: Swarna Prabhu <sw.prabhu6@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	riel@surriel.com,
	yeoreum.yun@arm.com,
	hch@lst.de,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [RFC PATCH 0/5] gup: introduce folio-range interface for pinning user memory
Date: Wed, 18 Nov 2026 13:34:53 -0800
Message-ID: <20261118213458.377258-1-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Swarna Prabhu <s.prabhu@samsung.com>

This series is an RFC to gather design feedback to introduce a folio-range 
interface for pinning user memory in the GUP fast path. Pinned memory is 
returned as folio ranges instead of a page array: a run of consecutive PTEs 
mapping consecutive pages of one folio is pinned once and handed back as a single 
range. Block direct I/O converts each range into a single bvec, hence reducing the 
per-page pin and merge work.

Base and dependencies
=====================

This series is rebased on the following two series applied:

  - "mm: gup: batch PTE-mapped large folios in gup_fast_pte_range()"
    v4 (Yeoreum Yun; originally posted by Yuan-Hao Hsu [3]), applied to
    mm/core.git gup-7.5.ptebatch [4]. It batches the reference grabs for
    PTE-mapped large folios in GUP-fast.

  - "batch lookups in follow_page_mask()" v5 (Rik van Riel) [5]. It makes
    follow_page_mask() return a page count and record pages through
    gup_fill_pages().

    Note: "[PATCH v5 1/8] mm/gup: break out gup_fill_pages() helper" was
    posted just as testing for this RFC was done. To avoid delaying
    feedback on the overall design, this RFC retains the tested base
    linked in [5] and will be rebased onto the latest revision for next
    version.

This series builds on both: the run detection in gup_fast_pte_range() and
the batched slow-path lookup are reused, and this series changes how the
result of a run is recorded and returned.

Background
==========

Kundan's LPC '24 talk "Transitioning get_user_pages to folio based mapping"
[1] proposed a struct folio_vec (based on bcachefs) passed in place of a
pages array. Building on that and on suggestions from the community [2], 
this series exposes folio + index + nr_pages, where each range spans a 
single folio:

        struct folio_range {
                struct folio *folio;
                unsigned int  idx;
                unsigned int  nr_pages;
        };

Design
======

A "struct gup_out" descriptor in mm/gup.c holds either the page array or
the folio-range array. The fast and slow page-table walkers append to the
descriptor instead of advancing a pages[] pointer, so a single walk
serves both interfaces without duplicating the walkers.

The PTE batching in gup_fast_pte_range() is provided by Yeoreum Yun's
series [4], which this RFC builds on. This series reuses that batching
and its page-table revalidation logic. For the folio-range interface,
each pinned run is recorded directly as a folio range instead of being
expanded into individual page pointers in the output array.

pin_user_folio_ranges_fast() stops once the caller's range array is
full, so callers size the array in ranges, independently of the number
of pages requested. A single GUP-fast walk is additionally capped at
EXTRACT_MAX_PAGES (1024 pages) to bound the time spent with interrupts
disabled when the buffer is backed by small pages.

unpin_user_folio_ranges() walks the range array and calls gup_put_folio()
once per range, releasing the references pin_user_folio_ranges_fast()
took for it.

In iov_iter_extract_bvecs(), the pinned folio ranges are stored into the 
free slot of the bvec array and converted in place, one bvec per range. 
Block direct I/O picks this up through bio_iov_iter_get_pages() without 
changes to the block layer.

Non-folio mappings
==================

Memory that is not backed by folios, such as pages a driver inserted
into a VM_MIXEDMAP VMA, makes pin_user_folio_ranges_fast() fail with
-EOPNOTSUPP when no pages were pinned; such iterators fall back to the
page-array path.

For folio-range output, gup_fast_folio_allowed() additionally requires
a non-NULL folio->mapping, except for hugetlb folios. If the mapping is
NULL, it falls back to the slow path, where the VMA can be checked.
The existing file-backed and secretmem restrictions remain unchanged.

FOLL_LONGTERM is not supported yet and is rejected.

Testing
=======

Measured the time spent in bio_iov_iter_get_pages() per I/O with
function_graph, on the baseline and the baseline plus this series.
Both kernels ran with the performance governor, boost disabled, all
C-states except POLL disabled, and fio pinned to one CPU:

  trace-cmd record -p function_graph -g bio_iov_iter_get_pages \
    --max-graph-depth 8 -O funcgraph-overhead -O nofuncgraph-irqs -F -c \
    fio --name=io_uring_test --filename=/dev/nvme1n1 --ioengine=io_uring \
        --rw=randwrite --direct=1 --bs=<bs> --iodepth=8 --iomem=mmap \
        --iomem_align=2M --numjobs=1 --size=64M --cpus_allowed=23

Median of calls not interrupted during the walk:

  bs    buffer          baseline        patched          result
  128K  64 kB mTHP      13.08 us        13.09 us         neutral
  1M    64 kB mTHP      63.0 us         63.6 us          neutral
  4M    2 MB THP (PMD)  25.9 us         8.65 us          ~3.0x faster
  8M    2 MB THP (PMD)  49.4 us        ~17.0 us          ~2.9x faster

Note: the baseline is the upstream kernel with Yeoreum Yun's [4] and
Rik van Riel's [5] changes applied.

For larger I/O, the baseline's bio extraction path requests at max
256 pages per GUP call, limited by the available bvec slots. This
series instead uses those slots for folio ranges, each of which can 
describe many pages, thereby allowing the series to request up to 1024 
pages per call which accounts for the speed up observed in 
'bio_iov_iter_get_pages' for 4MB and 8MB DIRECT I/Os.

Testing: Ran selftests gup_test, gup_longterm and cow on the patched kernel
and no regressions were observed.

Link [1]: https://lpc.events/event/18/contributions/1773/
Link [2]: https://lore.kernel.org/all/f2b5189f-10de-4685-97f3-6ee08d159743@kernel.org/
Link [3]: https://lore.kernel.org/all/20260917083747.786-1-aa9736195201@gmail.com/
Link [4]: https://lore.kernel.org/all/20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com/
Link [5]: https://lore.kernel.org/all/20261102193026.3860700-1-riel@surriel.com/

Swarna Prabhu (5):
  mm/gup: add struct gup_out output descriptor
  mm/gup: make the slow path walkers record into struct gup_out
  mm/gup: make the GUP-fast walkers record into struct gup_out
  mm/gup: return pinned memory as folio ranges
  iov_iter: extract bvecs of user-backed iters from folio ranges

 include/linux/mm.h       |  37 +++
 include/linux/mm_types.h |  23 ++
 lib/iov_iter.c           | 100 ++++++
 mm/gup.c                 | 695 +++++++++++++++++++++++++++++++--------
 4 files changed, 717 insertions(+), 138 deletions(-)

-- 
2.43.0

