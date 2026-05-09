Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B038E5DA
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315538; cv=pass; b=oJFyUaxMyxbzIuhApewF55Bt+pPsViLPqo2LRRgQkR5+lYUFwnGTSLht9PzGC+ydJsHTn/3ezcXcOXFTwi3n7A5QRbmt72E7FDMT31ZNdduDD1v+dMz1+t4Sh+rNJ7R8CV8MNrkVxGoBFvYJZT15Y6Fa/Ga9HTViBrtWqVIMLVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315538; c=relaxed/simple;
	bh=rBrgYd/I1k5P8A/N0DQqIF4CdIqoccE1Fflqez0Cl04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbg8u03dHKlPQOi6fUiRxKcNamDH8r9VtmNouXevUyIHhrk1TKVh6ocdvmpP1ur0bF/0FH3BtyfVpcd7HNDZdyVJJ5U9DI1VO45YxGZxLYFDNECqq43QxKU+cTPewlfn5uvyo3J0vDYK/lN8jFE/fEXxw+OfhqitbakwL7NDul0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax9pd5tf; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax9pd5tf"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bc83e74aso2868241d50.2
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 01:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778315535; cv=none;
        d=google.com; s=arc-20240605;
        b=b/yhv81XSV8NslNnkQ1qdustHGiFjgw/Sllzb5xNfF2S1IjTwyLfucat4VzepLMOxD
         5g3kRdnBYFQXHcgkL1BxCvOovOrXM58z9ChSKpIM1wuGg6UeCJI75i+zIqDR19mnDNDZ
         tg4sU/MS9ctXQpUX/TOCvPEMMU08z0llttt4kms7YJ566Vl/p2EqjaxBH42/KVXySB4v
         d+JS0kYI3F0+KNFp+HvLNBbYu60ErHdtIlJzMBSFp1we4P6wn1XxfZp09iUZVF+7qXsn
         Gec2mMfegQGAt+80CtKt9jKZntCE2ARsrk3v7nmJCzJQ3ge1YkQHV1Ni2jZ5kHR9JPsr
         S32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFCUPxEdozXw9KoevvKNfef1+tdjRi6G60+cl7ZPQoA=;
        fh=BryWQXLb5n+PP1fZXCDfDZIuKg2ZMOP+JZnOm0isuZ4=;
        b=E7PfrtH3Lxqq9tgSHyXKWaJJq4Pxh0amPzRz3sPfjQ84VkpdOQd8klcbeU5Y/URQ+D
         ZEUxwJKeYN9BcuVeVLd6j2x9ojr5EpxjqV2qtRAyVuP3vwzBTJqWoeZwqkz7kBGpdNqq
         lSEDBQAxLlzyr0llGZs2QRuDL5FG0fnlSgLEWRqdzaLkytMkQ24F9V3PjiJ4/iD9YidU
         oLBrdcVhhNWcVhBy2A7bIZ6rTyefkgMarhsEyGpsIssuNfXr4gCcpGhUyQu8PQuZZb2E
         lhvaaNadFH7dpzegbokkvOoWS3LWRvYufU/u3o/0ALatmzWh0cSeVcxBAHdEm94XuVPM
         8O3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778315535; x=1778920335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFCUPxEdozXw9KoevvKNfef1+tdjRi6G60+cl7ZPQoA=;
        b=ax9pd5tfQmRmpQi6qvoEbwjQIJQ8rjQC5ma5piWmNw+1iiKqVqBWFNjfYSthBdCcUS
         mSmooII27vPwHg2ocA9RrMlVTdAzG+bixjhz/eWBHE4RjfqxUZ604cjNRLaarobe1/in
         1lU1YwmFcXQPtE/Izt2x6j0deAQFKwXkIWexe6IO+z2kspAmR1dJEOKKsh66R84i1kvO
         lRrtD40bL5pxIIzTD8P6zlWw4N1wI3zPqeXJTn1mOMCbisaI9Lg/qpy7aHQlJCNMj2EC
         GN0rSRq2U/3ktAAZlKhjAamZKXbj14JJxBvag8og85y35+05dYpBxCP8E7ZBt5FkDhqA
         euPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778315535; x=1778920335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFCUPxEdozXw9KoevvKNfef1+tdjRi6G60+cl7ZPQoA=;
        b=UniP18zqERN2NTjJOTFII+sjkeKxOUdqvJnPRkoqyemzCFXgZPGGgsI5khdGGdwVLn
         UQamNUqI/mq4cJRvqDpZhSRKlvm4o047NAVhPU2kUDZy0s0VwgYZzCbYYJ+o0Z3+/GqQ
         de0tTU5K0+/FvbWMfAq2hB3XXrM0R76D9+JBczA5vKlrQfZ+fwZZUBSUx2hO+qcpPOOQ
         boa+oAie/+n0MGTveFtynfIHf/BVVwnN3qxnbZ5xOPvZjWiC0BSLHEgl/q73wrg2X0t9
         1GG9Qvto9wexyMMNcZRxl5YCDwJJ0f9dulF5uNbkCNPvdXYh86f9v7436knoQd1PchPx
         0d+w==
X-Forwarded-Encrypted: i=1; AFNElJ+Z//vb8ta+Q0v0iYEKRIi8KU1ppcGuKkm2RH0/bjhcg09jTM17/ijUHsVHslKJlEmRZvs9qeUmF9luTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LPRsGpjRgEpETbmc2BvcGEVJZLUO14k3J4w1BJhHIrZ6hhbX
	F87x3fJqteP1NyJqxBXmV8J+c7pW+7WuUVW+US56F/TcLBTfHKcBMYsdkmeQI3x7+yrfY5j93sA
	H9XxpZgWfvDtupYFitVhIRAFOO95ecok=
X-Gm-Gg: Acq92OHmt1l9iOkpOTWWVytuqIB7TSzcD9W24HQUI5uSj6Wkg6DpQktp32DpKT1lvG0
	Iga+qVqBFDAl+9lkPLIkSHQZELIhGTZUDy2PdEl7bACtlsL/eBxvx/5kG+8lFI2ScaFth/GuJbN
	M3hMKBMBxOfU8E1p/0kPUg07PV2flTjGfWEYYPoVALtSnC2BYp72EXn2L3LiSyJgcnQ339HSNP8
	il+Kq6aGh4629bcy8QVst4ehx83LW8RMh1o8idHCIbOE2F9+FAFcJ3rtuBEEleHusqKWGyjIHLe
	hKtIERgf
X-Received: by 2002:a53:bf12:0:b0:65c:6220:5fcf with SMTP id
 956f58d0204a3-65c79e5a8a0mr12116257d50.62.1778315535310; Sat, 09 May 2026
 01:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com> <CAO9r8zO3GrMLDV57aRaiwRvZhwcduihKhc3rBpFGkbZKoq_iSw@mail.gmail.com>
In-Reply-To: <CAO9r8zO3GrMLDV57aRaiwRvZhwcduihKhc3rBpFGkbZKoq_iSw@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Sat, 9 May 2026 16:32:04 +0800
X-Gm-Features: AVHnY4LyhWnyTyP9L5IXX7-e7r_8EAGOYym_9fMZjc7c86Jp2ckAZ-ir_9aaUu4
Message-ID: <CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn3_Zb350ow@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to
 accelerate swap entry release
To: Yosry Ahmed <yosry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:13=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > Swap freeing can be expensive when unmapping a VMA containing many swap
> > entries. This has been reported to significantly delay memory reclamati=
on
> > during Android's low-memory killing, especially when multiple processes
> > are terminated to free memory, with slot_free() accounting for more tha=
n
> > 80% of the total cost of freeing swap entries.
> >
> > This series introduces a callback-based deferred free framework in
> > zsmalloc. Callers (zram, zswap) register push/drain callbacks to
> > define what gets buffered and how it gets drained. The entire free
> > path including caller-side bookkeeping (slot_free, zswap_entry_free)
> > is deferred to a background worker.
>
> How much of the speedup comes from avoiding the per-class lock,
> free_zspage(), other work in zswap, etc.

This series doesn't avoid the per-class lock. The pool->lock part
has been split out and posted as a separate series, so this series
focuses purely on the defer scheme:

https://lore.kernel.org/linux-mm/20260508061910.3882831-1-haowenchao@xiaomi=
.com/

>
> I ask because I think the design here is still fairly complex. I don't
> like how zswap and zram are registering callbacks into zsmalloc to do
> their own freeing work, and they fill the buffers on behalf of
> zsmalloc which seems like a layering violation.

The callback design was motivated by code reuse -- deferring only
zs_free() inside zsmalloc gave less speedup, and the machinery
needed to defer caller-side bookkeeping turns out to be the same
on both sides (per-cpu page buffer, drain worker, fallback). So I
folded the common parts into zsmalloc.

I agree it's not clean from a layering standpoint, and I'm happy to
revisit if the reuse isn't worth the cost.

>
> I wonder how much of the speedup we get by just deferring
> free_zspage()?

Below is the perf breakdown, sampled only during munmap() of a
256MB zram-filled VMA on a Raspberry Pi 4B.

Base kernel:

  # Samples: 491  of event 'cycles'
  # Event count (approx.): 214056923
  #
  # Children      Self  Symbol
  # ........  ........  ..........................................
      99.55%     0.41%  [k] __zap_vma_range
      97.27%     2.91%  [k] swap_put_entries_cluster
      94.37%     1.65%  [k] __swap_cluster_free_entries
      88.99%     8.91%  [k] zram_slot_free_notify
      79.87%    10.78%  [k] slot_free
      56.27%     5.99%  [k] zs_free
      47.61%     4.35%  [k] free_zspage
      36.85%     4.96%  [k] __free_zspage
      19.27%     0.21%  [k] __folio_put
      12.64%     2.91%  [k] __free_frozen_pages
       9.50%     6.40%  [k] kmem_cache_free
       8.28%     8.28%  [k] _raw_spin_unlock_irqrestore
       6.83%     1.85%  [k] dec_zone_page_state
       5.18%     5.18%  [k] _raw_spin_unlock
       5.18%     5.18%  [k] folio_unlock
       4.98%     4.98%  [k] mod_zone_state
       4.12%     4.12%  [k] _raw_spin_lock
       3.30%     3.30%  [k] __swap_cgroup_id_xchg

Perf of the zsmalloc-only variant (same 256MB zram workload):

My first attempt for this RFC was exactly that -- defer only the
handle free inside zsmalloc, keep zram/zswap caller-side bookkeeping
synchronous. (I would post this version after this thread)

  # Samples: 164  of event 'cycles'
  # Event count (approx.): 68803872
  #
  # Children      Self  Symbol
  # ........  ........  ..........................................
      99.24%     1.28%  [k] __zap_vma_range
      94.17%     4.49%  [k] swap_put_entries_cluster
      87.77%    12.09%  [k] __swap_cluster_free_entries
      43.62%    24.33%  [k] zram_slot_free_notify
      21.80%    21.80%  [k] slot_free_extract
      19.29%     6.42%  [k] zs_free_deferred
      12.23%     0.64%  [k] zs_free         <- sync fallback only
       8.96%     8.96%  [k] __swap_cgroup_id_xchg
       4.51%     1.93%  [k] __free_frozen_pages

Zsmalloc-internal items drop out or shrink dramatically. zs_free at
0.64% is only the synchronous fallback when the per-cpu page pool is
temporarily empty. zram_slot_free_notify remains high (24.33%)
because slot_free_extract() still runs synchronously on the hot path
-- it's a new helper this variant introduces to do the zram-side
cleanup (slot flag clears, atomic stats updates, handle extraction)
before the handle is queued.

The perf numbers showed that zram also has non-trivial caller-side
bookkeeping cost -- the work in slot_free_extract() in particular.
I tried to reduce that without deferring it (per-cpu stats, swapping
the bit-lock for a different primitive), but the results were
basically a wash and sometimes slightly worse. That's what led to v3
extending the defer to cover the caller side as well, via the
push/drain callbacks.

v3 (this series, defer all zram slot notify):

  # Samples: 82  of event 'cycles'
  # Event count (approx.): 33089591
  #
  # Children      Self  Symbol
  # ........  ........  ..........................................
      91.46%     1.32%  [k] __zap_vma_range
      75.77%     8.35%  [k] swap_put_entries_cluster
      64.71%    10.72%  [k] __swap_cluster_free_entries
      33.36%    17.43%  [k] zram_slot_free_notify
      18.03%    18.03%  [k] __swap_cgroup_id_xchg
      13.31%    11.82%  [k] zs_free_deferred
       9.10%     9.10%  [k] lookup_swap_cgroup_id
       4.03%     4.03%  [k] zswap_invalidate
       3.94%     3.94%  [k] swap_pte_batch

Absolute cycles in the unmap window drop from 214M to 33M (~6.5x),
matching the observed munmap latency (57ms -> 9ms). The defer path
moves the following items out of the hot path (base kernel Self%):

  _raw_spin_unlock_irqrestore  8.28   class/pool locks
  kmem_cache_free              6.40   zspage struct slab free
  zs_free                      5.99
  _raw_spin_unlock             5.18
  folio_unlock                 5.18
  __free_zspage                4.96   zspage teardown
  mod_zone_state               4.98   zone stats
  free_zspage                  4.35
  _raw_spin_lock               4.12
  __free_frozen_pages          2.91   buddy page release
  _raw_spin_trylock            2.48
  dec_zone_page_state          1.85
  free_frozen_page_commit      1.66

That accounts for ~55% of the base-kernel munmap hot path, all
moved to the drain worker.

Benchmark (zram, single process, avg of 3):

  size    base     v3       zs-only     v3/base   zs-only/base
  64MB     14.38    2.12     4.34        6.8x      3.3x
  128MB    29.73    4.26     8.54        7.0x      3.5x
  256MB    57.93    8.54    19.90        6.8x      2.9x
  512MB   116.77   55.41    47.90        2.1x      2.4x
  1024MB  234.43  150.11   105.06        1.6x      2.2x

> That part can be done much more simply by just putting
> the pages on a per-class list and having an async worker or a kthread
> consume them and batch-free them. If the rest of zs_free() is also
> expensive, we can do the deferred freeing on that level although it
> would be more complicated as we need to have a fixed size buffer to
> store them and handle running out of space.
>

I hesitated on per-class because there are ~255 classes, so a
worker walking them would often find single-entry or empty lists,
defeating the batching. Using a per-cpu buffer of handles and
sorting by class inside the drain gets "batched under one
class->lock" without the many-short-lists problem.

Thanks,
Wenchao

> A breakdown of where the slowdown is coming from would be helpful to
> understand what to focus on.
>
> >
> > Implementation:
> >   - Each CPU owns a single-page buffer. The hot path writes a value
> >     via the push callback with preemption disabled (no locks).
> >   - When the buffer fills, it is swapped with a fresh page from a
> >     pre-allocated page pool. The full page is queued to a WQ_UNBOUND
> >     worker for drain.
> >   - The drain callback performs the actual expensive work (zs_free,
> >     slot_free, zswap_entry_free, etc.) in batch, off the hot path.
> >   - If no free page is available, the caller falls back to synchronous
> >     processing.
> >
> > The speedup comes from moving expensive swap slot freeing off the
> > munmap hot path into a background worker, so that intact anonymous
> > folios are released back to the system without blocking. The worker
> > drains at a slower rate since compressed objects are small and freeing
> > a single handle may not release an entire page until the zspage is
> > fully empty.
> >
> > Performance results (Raspberry Pi 4B, ARM64, 8GB RAM):
> >
> > Test 1: munmap latency for 256MB swap-filled VMA (zram backend)
> >
> >   mode        Base       Patched     Speedup
> >   single      61.82ms    8.62ms      7.17x
> >   multi 2p    94.75ms    54.11ms     1.75x
> >   multi 3p    154.64ms   104.83ms    1.48x
> >
> > Test 2: munmap latency for different sizes (zram, single process)
> >
> >   Size       Base         Patched     Speedup
> >   64MB       14.11ms      2.18ms      6.47x
> >   128MB      29.45ms      4.48ms      6.57x
> >   192MB      43.85ms      6.62ms      6.62x
> >   256MB      57.01ms      9.08ms      6.28x
> >   512MB      115.13ms     55.58ms     2.07x
> >   1024MB     229.66ms     153.28ms    1.50x
> >
> > Test 3: munmap latency for 256MB swap-filled VMA (zswap backend)
> >
> >   mode        Base       Patched     Speedup
> >   single      152.14ms   51.26ms     2.97x
> >   multi 2p    186.56ms   105.42ms    1.77x
> >   multi 3p    205.83ms   153.32ms    1.34x
> >
> > Test 4: munmap latency for different sizes (zswap, single process)
> >
> >   Size       Base         Patched     Speedup
> >   64MB       37.83ms      13.26ms     2.85x
> >   128MB      75.11ms      26.73ms     2.81x
> >   256MB      150.78ms     52.97ms     2.85x
> >   512MB      303.04ms     130.38ms    2.32x
> >   1024MB     599.95ms     287.10ms    2.09x
> >
> > [1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.=
com/
> > [2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@viv=
o.com/
> > [3] https://lore.kernel.org/linux-mm/20260412060450.15813-1-baohua@kern=
el.org/
> >
> > Changes since v2:
> > - Use per-cpu single-page buffers instead of a global list; the hot
> >   path only writes into the local CPU's buffer with preemption disabled
> > - Add a page pool for buffer rotation: when the current buffer is full,
> >   swap it with a free page from the pool and queue the full page for
> >   drain
> > - Introduce push/drain callback ops so that zram and zswap can each
> >   define their own element size and drain logic (zram stores u32 slot
> >   indices, zswap stores unsigned long handles)
> > - Drop the lock optimization patches it will be submitted separately
> >   as part of a dedicated zsmalloc lock contention series
> > - Link to v2: https://lore.kernel.org/all/20260421121616.3298845-1-haow=
enchao@xiaomi.com/
> >
> > Barry Song (1):
> >   zram: use zsmalloc deferred free callback for async slot free
> >
> > Wenchao Hao (3):
> >   mm/zsmalloc: introduce deferred free framework with callback ops
> >   mm/zswap: use zsmalloc deferred free callback for async invalidate
> >   zram: batch clear flags in slot_free with single write
> >
> >  drivers/block/zram/zram_drv.c |  44 ++++++-
> >  drivers/block/zram/zram_drv.h |   6 +
> >  include/linux/zsmalloc.h      |  16 +++
> >  mm/zsmalloc.c                 | 208 +++++++++++++++++++++++++++++++++-
> >  mm/zswap.c                    |  38 ++++++-
> >  5 files changed, 306 insertions(+), 6 deletions(-)
> >
> > --
> > 2.34.1
> >
