Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7183E4C61
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271189; cv=none; b=efFFAVDeAS6zhyOpoOtHgVBxqe75cBOL/1RDTsDT4KLjUTu0BvDE/XzaIRDV+i6tS349t4yWQ9/z5mglV+yQGFhQQZnuBG2cgadK+Kh7JuRvm9qxOtGP8bZBQwVDYOPbSKasD/mhIEZ3KDpZlsxh4wcV571CeKb6QK9N7OfB5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271189; c=relaxed/simple;
	bh=ctngZu+aSAHhDu3PSjz9OJb24VmabpcYprQlPT4iRQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5dYgGhK+56lauokJiUaCtxRfbjJog1KiSVjEtmctSJyCUAZGyC3uF86jdZIPgAOhJEWEAjzqmUQAzU8QWrvo5mHTil+TOuLwsRNvk8QkaCRnD1KSqmSKx6v690Zp6nLKmvTGv+n4xJsPBScgOxvzc4xcYoPZIWajSE1s90eFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDOUuD6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDOUuD6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF99AC2BCF5
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271188;
	bh=ctngZu+aSAHhDu3PSjz9OJb24VmabpcYprQlPT4iRQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IDOUuD6l08tpao6KddG0HnQQ+2CBWwKcCOhbwnk+AgSNvoGV4nBoZ6PvKcVM70CX/
	 yxgNyGNVflIbUau5zlPW7EGSsuRJuJENJ1NATtQy6ujr6z4o4nkfJvPBSHXgDv03JY
	 FVjYXI8/kOENaRqs03a6EnuVWVkvgSdP+Yy6BayVznnAO3n14rmOLjJBytFtLDRJ6/
	 SJ3KxIUybj3B8wjNtwAuB3WytZ2XmiImYYkmfyz8o5PCcN9jSSqR5z6OxjDcTnn5Be
	 4tBkYRr/VTDFbZiy+wei2TtJYMJBaMm4ql6iT+UVHDVSH2jMmocrEUkqIOOUODYbSv
	 NTAyfiC/8BWGg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bc64ad08bf9so381594166b.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 13:13:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+FwoV3lUfL6tzXqOHGjnWcNec6mwuRLqSgnz9zE6uO7d8z+uRSeIv/gFaHL5q7+lvN9YFnG2O37ZhfwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdP9RnNP2GdIYsMNMdS5IN+DH6v22vIPeROCj3iSJDH91m38XW
	u76VNVpk19P9VI1fzHl8n/qlRDtkNgUyfFjvYWb1rlOjetPq6r6aaFHWvgcAQNrWHZ8poPNgLP1
	l5R/IOu5DUwzxT/swSxgwvF+EzGZcYyA=
X-Received: by 2002:a17:907:1c2a:b0:ba4:a7a3:d03f with SMTP id
 a640c23a62f3a-bc56dd1a4a5mr752154166b.27.1778271187725; Fri, 08 May 2026
 13:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
In-Reply-To: <20260508060724.3810904-1-haowenchao@xiaomi.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 8 May 2026 13:12:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO3GrMLDV57aRaiwRvZhwcduihKhc3rBpFGkbZKoq_iSw@mail.gmail.com>
X-Gm-Features: AVHnY4J5AOuTir0jOtNhvbYTTtEs__nYFSDyU1jMgmuDCshQa-U3e6S9kx4Bids
Message-ID: <CAO9r8zO3GrMLDV57aRaiwRvZhwcduihKhc3rBpFGkbZKoq_iSw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to
 accelerate swap entry release
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

()

On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Swap freeing can be expensive when unmapping a VMA containing many swap
> entries. This has been reported to significantly delay memory reclamation
> during Android's low-memory killing, especially when multiple processes
> are terminated to free memory, with slot_free() accounting for more than
> 80% of the total cost of freeing swap entries.
>
> Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
> to asynchronously collect and free swap entries [1][2], but the design
> itself is fairly complex.
>
> When anon folios and swap entries are mixed within a process, reclaiming
> anon folios from killed processes helps return memory to the system as
> quickly as possible, so that newly launched applications can satisfy
> their memory demands. It is not ideal for swap freeing to block anon
> folio freeing. On the other hand, swap freeing can still return memory
> to the system, although at a slower rate due to memory compression.
>
> This series introduces a callback-based deferred free framework in
> zsmalloc. Callers (zram, zswap) register push/drain callbacks to
> define what gets buffered and how it gets drained. The entire free
> path including caller-side bookkeeping (slot_free, zswap_entry_free)
> is deferred to a background worker.

How much of the speedup comes from avoiding the per-class lock,
free_zspage(), other work in zswap, etc.

I ask because I think the design here is still fairly complex. I don't
like how zswap and zram are registering callbacks into zsmalloc to do
their own freeing work, and they fill the buffers on behalf of
zsmalloc which seems like a layering violation.

I wonder how much of the speedup we get by just deferring
free_zspage()? That part can be done much more simply by just putting
the pages on a per-class list and having an async worker or a kthread
consume them and batch-free them. If the rest of zs_free() is also
expensive, we can do the deferred freeing on that level although it
would be more complicated as we need to have a fixed size buffer to
store them and handle running out of space.

A breakdown of where the slowdown is coming from would be helpful to
understand what to focus on.

>
> Implementation:
>   - Each CPU owns a single-page buffer. The hot path writes a value
>     via the push callback with preemption disabled (no locks).
>   - When the buffer fills, it is swapped with a fresh page from a
>     pre-allocated page pool. The full page is queued to a WQ_UNBOUND
>     worker for drain.
>   - The drain callback performs the actual expensive work (zs_free,
>     slot_free, zswap_entry_free, etc.) in batch, off the hot path.
>   - If no free page is available, the caller falls back to synchronous
>     processing.
>
> The speedup comes from moving expensive swap slot freeing off the
> munmap hot path into a background worker, so that intact anonymous
> folios are released back to the system without blocking. The worker
> drains at a slower rate since compressed objects are small and freeing
> a single handle may not release an entire page until the zspage is
> fully empty.
>
> Performance results (Raspberry Pi 4B, ARM64, 8GB RAM):
>
> Test 1: munmap latency for 256MB swap-filled VMA (zram backend)
>
>   mode        Base       Patched     Speedup
>   single      61.82ms    8.62ms      7.17x
>   multi 2p    94.75ms    54.11ms     1.75x
>   multi 3p    154.64ms   104.83ms    1.48x
>
> Test 2: munmap latency for different sizes (zram, single process)
>
>   Size       Base         Patched     Speedup
>   64MB       14.11ms      2.18ms      6.47x
>   128MB      29.45ms      4.48ms      6.57x
>   192MB      43.85ms      6.62ms      6.62x
>   256MB      57.01ms      9.08ms      6.28x
>   512MB      115.13ms     55.58ms     2.07x
>   1024MB     229.66ms     153.28ms    1.50x
>
> Test 3: munmap latency for 256MB swap-filled VMA (zswap backend)
>
>   mode        Base       Patched     Speedup
>   single      152.14ms   51.26ms     2.97x
>   multi 2p    186.56ms   105.42ms    1.77x
>   multi 3p    205.83ms   153.32ms    1.34x
>
> Test 4: munmap latency for different sizes (zswap, single process)
>
>   Size       Base         Patched     Speedup
>   64MB       37.83ms      13.26ms     2.85x
>   128MB      75.11ms      26.73ms     2.81x
>   256MB      150.78ms     52.97ms     2.85x
>   512MB      303.04ms     130.38ms    2.32x
>   1024MB     599.95ms     287.10ms    2.09x
>
> [1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.co=
m/
> [2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@vivo.=
com/
> [3] https://lore.kernel.org/linux-mm/20260412060450.15813-1-baohua@kernel=
.org/
>
> Changes since v2:
> - Use per-cpu single-page buffers instead of a global list; the hot
>   path only writes into the local CPU's buffer with preemption disabled
> - Add a page pool for buffer rotation: when the current buffer is full,
>   swap it with a free page from the pool and queue the full page for
>   drain
> - Introduce push/drain callback ops so that zram and zswap can each
>   define their own element size and drain logic (zram stores u32 slot
>   indices, zswap stores unsigned long handles)
> - Drop the lock optimization patches it will be submitted separately
>   as part of a dedicated zsmalloc lock contention series
> - Link to v2: https://lore.kernel.org/all/20260421121616.3298845-1-haowen=
chao@xiaomi.com/
>
> Barry Song (1):
>   zram: use zsmalloc deferred free callback for async slot free
>
> Wenchao Hao (3):
>   mm/zsmalloc: introduce deferred free framework with callback ops
>   mm/zswap: use zsmalloc deferred free callback for async invalidate
>   zram: batch clear flags in slot_free with single write
>
>  drivers/block/zram/zram_drv.c |  44 ++++++-
>  drivers/block/zram/zram_drv.h |   6 +
>  include/linux/zsmalloc.h      |  16 +++
>  mm/zsmalloc.c                 | 208 +++++++++++++++++++++++++++++++++-
>  mm/zswap.c                    |  38 ++++++-
>  5 files changed, 306 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
