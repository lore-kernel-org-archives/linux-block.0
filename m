Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56148946A;
	Tue, 12 May 2026 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544080; cv=none; b=sau16jzARjSHu6mAIxaFYvd6YqinwIFlcC9dmlCbNVtk+4V2OFGMcHFfDXFO8V9RPBwzZiEhDgbAa13eVfXO7vP1v2waBzvwcUr5B44QN+4GxvVUpp817Wz6Ho14ilzXi1/ics1nI9XTBQowFTrMtJa5+9zqUT32SQ+/f0EKfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544080; c=relaxed/simple;
	bh=lxS+xrMxyMqeQ2Uc3VsxxruNoLpj5OEXbZ+YMCjKNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUktbyDxr7MR+NkPwxiYIBdYtZvMSLIo9beTb1tL+AsYCosEuKBZhmRALA/X3Db/hG9FVtJkpDykFa9l7XFvCwBbDxza0PXs7WWOqIBUKwuYnEmrDHfdMNKi5lMT/KfdJhSIP8WBgXPSRxVUvfeFG9VvHvPJri7TXwN2bdl24rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHJl1G85; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHJl1G85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF3AC2BCB0;
	Tue, 12 May 2026 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544080;
	bh=lxS+xrMxyMqeQ2Uc3VsxxruNoLpj5OEXbZ+YMCjKNdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHJl1G85/YJp5rqU3eQ4CU0FVvAvkuV1YWkG4jjOTEOanLn5pIPBLwEpUs8CsgtUg
	 nIsF5pdFsR0rdb+kx7eJ1xkDQloOOBGvV7U8JbgygkvTRJm6QmzsVmHAx+NmTOZoR3
	 u8NGZ4tROdEfW7GeWhMay/j7WY+wuTFs4852SbPl2P4O5FBpSHXdF6IEYoH0dEXF/i
	 i+korJYaMRt2NPLp01pjGAuN4FMJfVA4gGLfXLwBj6wBunqCSpBT/YnNoUEz+O6vAk
	 SrKxyfJI3T/rbhi+dhmRa4pkREhnLbxhG5yIBPvmxw5+T/r9snPjrijoilAkkrb7/T
	 uanPaFCXTm+Jg==
Date: Tue, 12 May 2026 00:01:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Wenchao Hao <haowenchao@xiaomi.com>
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to
 accelerate swap entry release
Message-ID: <agJslV2eNj9FLFqI@google.com>
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
 <CAO9r8zO3GrMLDV57aRaiwRvZhwcduihKhc3rBpFGkbZKoq_iSw@mail.gmail.com>
 <CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn3_Zb350ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn3_Zb350ow@mail.gmail.com>

On Sat, May 09, 2026 at 04:32:04PM +0800, Wenchao Hao wrote:
> On Sat, May 9, 2026 at 4:13 AM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > On Thu, May 7, 2026 at 11:08 PM Wenchao Hao <haowenchao22@gmail.com> wrote:
> > >
> > > Swap freeing can be expensive when unmapping a VMA containing many swap
> > > entries. This has been reported to significantly delay memory reclamation
> > > during Android's low-memory killing, especially when multiple processes
> > > are terminated to free memory, with slot_free() accounting for more than
> > > 80% of the total cost of freeing swap entries.
> > >
> > > This series introduces a callback-based deferred free framework in
> > > zsmalloc. Callers (zram, zswap) register push/drain callbacks to
> > > define what gets buffered and how it gets drained. The entire free
> > > path including caller-side bookkeeping (slot_free, zswap_entry_free)
> > > is deferred to a background worker.
> >
> > How much of the speedup comes from avoiding the per-class lock,
> > free_zspage(), other work in zswap, etc.
> 
> This series doesn't avoid the per-class lock. The pool->lock part
> has been split out and posted as a separate series, so this series
> focuses purely on the defer scheme:
> 
> https://lore.kernel.org/linux-mm/20260508061910.3882831-1-haowenchao@xiaomi.com/
> 
> >
> > I ask because I think the design here is still fairly complex. I don't
> > like how zswap and zram are registering callbacks into zsmalloc to do
> > their own freeing work, and they fill the buffers on behalf of
> > zsmalloc which seems like a layering violation.
> 
> The callback design was motivated by code reuse -- deferring only
> zs_free() inside zsmalloc gave less speedup, and the machinery
> needed to defer caller-side bookkeeping turns out to be the same
> on both sides (per-cpu page buffer, drain worker, fallback). So I
> folded the common parts into zsmalloc.
> 
> I agree it's not clean from a layering standpoint, and I'm happy to
> revisit if the reuse isn't worth the cost.
> 
> >
> > I wonder how much of the speedup we get by just deferring
> > free_zspage()?
> 
> Below is the perf breakdown, sampled only during munmap() of a
> 256MB zram-filled VMA on a Raspberry Pi 4B.
> 
> Base kernel:
> 
>   # Samples: 491  of event 'cycles'
>   # Event count (approx.): 214056923
>   #
>   # Children      Self  Symbol
>   # ........  ........  ..........................................
>       99.55%     0.41%  [k] __zap_vma_range
>       97.27%     2.91%  [k] swap_put_entries_cluster
>       94.37%     1.65%  [k] __swap_cluster_free_entries
>       88.99%     8.91%  [k] zram_slot_free_notify
>       79.87%    10.78%  [k] slot_free
>       56.27%     5.99%  [k] zs_free
>       47.61%     4.35%  [k] free_zspage

Seems like most of the zsmalloc overhead comres from free_zspage(),
right? I think we significantly simplify things if we only defer that
part. Instead of having a page pool and buffers were we stores the
handles for async free, we can just remove the zspage from from the
fullness list and put it on a deferred freeing list.

We can probably even explore not doing per-CPU and just use a single
global worker with a single lockless list (llist), then the worker can
just do llist_del_all() to atomically empty the list and process it
locally. If that turns out to be expensive we can do per-CPU lists.

WDYT? I think this can simplify things significantly.

>       36.85%     4.96%  [k] __free_zspage
>       19.27%     0.21%  [k] __folio_put
>       12.64%     2.91%  [k] __free_frozen_pages
>        9.50%     6.40%  [k] kmem_cache_free
>        8.28%     8.28%  [k] _raw_spin_unlock_irqrestore
>        6.83%     1.85%  [k] dec_zone_page_state
>        5.18%     5.18%  [k] _raw_spin_unlock
>        5.18%     5.18%  [k] folio_unlock
>        4.98%     4.98%  [k] mod_zone_state
>        4.12%     4.12%  [k] _raw_spin_lock
>        3.30%     3.30%  [k] __swap_cgroup_id_xchg
> 
> Perf of the zsmalloc-only variant (same 256MB zram workload):
> 
> My first attempt for this RFC was exactly that -- defer only the
> handle free inside zsmalloc, keep zram/zswap caller-side bookkeeping
> synchronous. (I would post this version after this thread)
[..]
