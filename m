Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DF4749D7
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946775; cv=none; b=MXFYXOEDy6ynfz8bT3Dk7/PL4rEuJz1nt3wbpQxdai88Jec+4Ke9f8GSxW3x99ljn+i/luQrmrBfmkwFazDCSK+bWckpyVAGjhTOPCRIkI1xUlWxP1WUsUe8ohEC6TWkL0q04Wq0qoIfjCnbYCoqlEcrn2NcEvYuBNdR3PtJDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946775; c=relaxed/simple;
	bh=wVrMGR9QCOw+v/JyHVNBxfh2lOjKqIsVe9hfT4X8OU4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=FovgRgXqRyMvcOiS5HiYNuU4DDAmtlO4pFtFLWawagcs5fXojQOEZT7/ek9KT3j2wJK5/iONMW0FJBjJ/G30IQGiRVUCEE4l8TG5L8OsqZGTZG1VVN9F+QrLl98HGTZVlTPpWyI3ti7oJ7P/+oH/tTdUA8FvU2Ecqt3xfS35Pl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRjFQH+C; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRjFQH+C"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-86cba60d4f2so41358777b3.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788946767; x=1789551567; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zuAVjWjM0/S4ZIDkng7bHRKao4SeQxFnkO87c7tfhg=;
        b=hRjFQH+Cp7NvX4IkKbE1u2wRB51gMwRo0EbjccvTIh6ZvBvgXmj4V0WRz9yv6W4dsx
         5bPUtfCtegVHazs0bvTiAQpX6DHIG9mw+JKaG32vYvAsxyOnObf9EGRTrQZIJ+lGqVpA
         wvVuJxyjQ2WkeNiJlcfa0eM/ZWgH/hL9737ugVRr6D3Xu2EPM+ghuT4Z2N4Wnb4vIdmg
         4w3yxTdHL7s+1RY6MUmhQEvc4jkXXty3aY+YXbpXuDjbB+dALJfvTed+jkhbHdwjMked
         c8PxVBgwMrkWa6l3JbwgBXZfm4Kv5CvtoDgoX32Q8/18TXrhRcWXqK+zgwzrjduqcdzs
         PS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946767; x=1789551567;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0zuAVjWjM0/S4ZIDkng7bHRKao4SeQxFnkO87c7tfhg=;
        b=UUekYEE8wO7uUmnlVELbpfCYpXhrdroFg0tI2hvPwZnzTXGJVR0cAQOeeObPaPhvJE
         yErZSUeqX5u43N62QIyIb2DXq0XywDWojDlZpmgoyTDy2Lo2o3soh6x5IcL/PGv7ouxP
         hp43GRvuZ7vwzEeUR69/lpCI+thgwT36pbbsY2tueK0BoUzBghYt7KlAwvNe3aKbp0lP
         LXUf0FhT64sulK3WZ11JRfsR+CY8EzSoSe1hJja7Jw0gOtXC9h2tIPhsgzleXicSACsA
         6f9comHrOjTeP+LBtUICE7jcrPIOm3sVrabuO7cFxffzeZDb05dvLfoEeHr+IIgVMtdN
         uAog==
X-Forwarded-Encrypted: i=1; AKwUvBzgIvJ/vPE/ZCiURexgUjqykUmQH/wDzIzUWzfTtEA6nD4vqmSrDCmvfZ41UWFGgL8kDFpstyuXEzyEqg==@vger.kernel.org
X-Gm-Message-State: AFuF++nTCdUgcHJmYzDxda47a+V4nsN1Skp8j53A7jCB0aHMqoRwll4O
	bL6s9d4GASMK9+8NlWNchSRI55+R6QmQamYzLVuN6f6YPBYZlfQsT7FIBzMQFhyH9g==
X-Gm-Gg: AYBFou3RE7Whkt6wpl20ts4XGY1J3Sg7OfGKz1ysPSbXJhaLAetIDFUL/9LrqoP/jAA
	ADxV/53ODEku7cZU4sDsGLC3S3eta3XamEnka3c81Fuo9s0jvkFCVDWmdLLR1oubw00LNM+yeTw
	JoGcShXctwMaN/VzIVS0GFL4p5zNESeCo9C+vFEB0bFi3xUqUX3MQTfK8eNlVytvdrIFNYMbLJp
	TBQiM0hwLL6QAQ9eo7+2+KeKxEzVNnoLEyfYEm6A/fq/Vw9aU6ZTB2doyZjiue5X7CgQKKibqyL
	r3kPYvXxwvX7Daa2xEkHUtSsZlOp7ToAljoa5FIQKTzmLBREkMdvFv09yMwk3bCArkGPfQOOGjt
	LyKEmZOPehU665Q52rcgUlRbRiHIN0sjmWRJDqqBxTKe6nEjPnYaYfZ0LcWnTxBebdeHf8jfzNj
	vNm3SQy5+xi1w4zKwLYXrxCrV625eZMf2XsDQFGntZeHPSPkvzqfUbCeBWSL6hyz534eujiD1tn
	AKDiZORUmOY0hCHSG6eD8UYEIRBzECmJV3TuCZZ4haojmZxk2VdGmC4w8A=
X-Received: by 2002:a05:690c:d84:b0:870:96e4:6709 with SMTP id 00721157ae682-87122985ba4mr131380887b3.9.1788946766316;
        Wed, 09 Sep 2026 02:39:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316347sm108893927b3.15.2026.09.09.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:39:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
Message-ID: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()

This series was prompted by lru_add_drain_all() appearing in watchdog
backtraces: not to blame, but blocked on an unresponsive CPU to run
its workqueue. lru_add_drain_all() is a heavyweight operation, which
we often hope to avoid by a much lighter lru_add_drain(); but even
those local drains can aggravate the lruvec lock contention which
per-cpu fbatches are intended to ease.

Now let the folios on the lru_add and other per-cpu fbatches remain
there, isolatable, with PG_lru set and refcount unraised, just like
when on an actual LRU. Then many calls to lru_add_drain() and _all()
can be removed.

It's something I've wanted to do for years, tried several times, but
only hit on a good way to do it a few weeks ago: now it's uncomfortable
to watch others wrestling with the drainage, while I'm sitting on this.

The key idea came from the "if (!folio_test_clear_lru(folio)) continue;".
If we don't mind missing to take an action on rare occasions, then maybe
we won't mind taking an action on the wrong folio on rare occasions, so
long as it is a folio consenting to PG_lru rules.

No new locking, but relies on folio_try_get() and folio_test_clear_lru()
even on the lru_add fbatch; with use of bits not set in aligned pointers,
and some try_cmpxchg()ing.  Speculative references to folios are already
accepted: this adds another source of them.

Performance? You (and the bots) tell me. I'm considering this as a
cleanup, to make life easier for developers. I expect that some loads
will show improvement, but also expect some disappointments (perhaps
I go too far against lru_cache_disable()? or not far enough).

The timing is not good: I'm taking three weeks off today; but it's best
to get this out in the open early. If it's welcome in principle for 7.4,
but changes needed, maybe someone else can step up to shepherd it
through; otherwise, I can take it up again for 7.5.

Rebased and retested on Linus's v7.3-rc2 tree, after adding two mm.git
dependencies which did not get into rc2, but can be expected in rc3:
Shakeel's "mm/mlock: use the IRQ-safe accessor for NR_MLOCK in
__munlock_folio()" and Ackerley's "mm/folio: EXPORT_SYMBOL_FOR_KVM(
lru_cache_drain_for_folio)". Those two are now in mm-hotfixes-stable
(e14a34548064 and 7891fbb9512f respectively: thanks to Andrew) as of
mm-everything-2026-09-09-06-32, and the series applied and briefly
tested over 09-09's earlier mm-everything, so I'm giving a hopeful
but not entirely honest base-commit below.

v1 posted on 24 August had 25 patches, with 26/25 added later:
Link: https://lore.kernel.org/linux-mm/14a16945-529b-8bc0-ab38-3ea97e54e223@google.com/

01/26 mm/fbatch: remove !CONFIG_SMP special case of folio_activate()
  v2: added Ack from David, R-b Vlastimil
02/26 mm/fbatch: allow folios_put_refs() to skip xa_is_value() entries
  v2: added Ack from David, R-b Vlastimil
03/26 mm/fbatch: temporarily disable lazyfree and mlock+munlock batching
  v2: added R-b Vlastimil
04/26 mm/fbatch: lru bit set, no extra ref, while folio on per-cpu fbatch
  v2: added comment on Bit 1 of page->lru.next per Kiryl and Matthew
      READ/WRITE_ONCE smp_mb__before_atomic per 07/25 discussion with Kiryl
      fixed (commented out) BUG_ON in lru_add_del_folio()
05/26 mm/fbatch: lru_add_del_folio()+folio_add_lru() after clear_lru()
06/26 mm/fbatch: fbatch_drain_lazyfree(onstack fbatch) before ptl unlock
07/26 mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize folio_activate()
  v2: hunk in lru_add_del_folio() updated according to mods in 04/26
08/26 mm/fbatch: replace mlock_new_folio() by __folio_add_lru(,mlockit)
  v2: updated 04/26 Bit 1 comment on folio_add_lru() to __folio_add_lru()
09/26 mm/fbatch: restore mlock+munlock batching, without extra ref
  v2: rediffed around Shakeel's NR_MLOCK fix, fixed unknowingly in v1
10/26 mm/fbatch: remove several uses of mlock_drain_local()
11/26 mm/fbatch: remove migration's PAGE_WAS_MLOCKED lru_add_drain()
  v2: conversely, use !folio_evictable() in isolate_migratepages_block()
12/26 mm/fbatch: remove percpu_pvec_drained and folios_put()
13/26 mm/fbatch: no lru_add drain to collect_longterm_unpinnable_folios()
  v2: revert David's rc1 lru_cache_drain_for_folio() from mm/folio.c,
      and Ackerley's EXPORT for KVM; but keep an inline stub in swap.h
14/26 mm/fbatch: no lru_add_drain() nor _all() for memfd_wait_for_pins()
15/26 mm/fbatch: remove shake_folio() shake_page() from memory-failure
  v2: added Ack from Miaohe
16/26 mm/fbatch: remove lru_cache_disable() from NUMA folio migration
17/26 mm/fbatch: no lru_cache_disable() in __alloc_contig_migrate_range()
18/26 mm/fbatch: remove lru_add_drain() and _all() calls from various
19/26 mm/fbatch: vm/stat_refresh include lru_add_drain() on each cpu
20/26 s390/fbatch: no lru_add_drain_all() in s390_wiggle_split_folio()
21/26 block/fbatch: no lru_add_drain_all() in invalidate_bdev()
22/26 fs/fbatch: drop_caches invalidate_bh_lrus() not lru_add_drain_all()
23/26 fs,mm/fbatch: use invalidate_bh_lrus() not invalidate_bh_lrus_cpu()
24/26 fs,mm/fbatch: lru_cache_disable() keep off buffer_head lrus only
25/26 mm/fbatch: move lru_add_drain_all() declaration to mm/internal.h
26/26 mm/fbatch: drop reference inside the loop when draining

 Documentation/mm/unevictable-lru.rst |   2 +-
 arch/s390/kernel/uv.c                |   1 -
 block/bdev.c                         |   1 -
 fs/buffer.c                          |  40 +--
 fs/drop_caches.c                     |   4 +-
 include/linux/buffer_head.h          |   8 +-
 include/linux/folio_batch.h          |   7 +-
 include/linux/huge_mm.h              |   6 +-
 include/linux/mm.h                   |  18 --
 include/linux/mm_inline.h            |  29 ++
 include/linux/mm_types.h             |  14 +-
 include/linux/swap.h                 |  23 +-
 mm/compaction.c                      |  27 +-
 mm/fadvise.c                         |  17 +-
 mm/folio.c                           | 436 +++++++++------------------
 mm/gup.c                             |   9 -
 mm/huge_memory.c                     |  16 +-
 mm/hwpoison-inject.c                 |   1 -
 mm/internal.h                        |  15 +-
 mm/khugepaged.c                      |  11 -
 mm/ksm.c                             |  12 -
 mm/madvise.c                         |   9 +-
 mm/memfd.c                           |   6 +-
 mm/memory-failure.c                  |  38 +--
 mm/memory.c                          |  14 +-
 mm/memory_hotplug.c                  |   4 +
 mm/mempolicy.c                       |   7 -
 mm/migrate.c                         |  13 +-
 mm/migrate_device.c                  |   9 -
 mm/mlock.c                           | 211 +++++++------
 mm/page_alloc.c                      |   3 -
 mm/rmap.c                            |   4 -
 mm/shmem.c                           |   2 -
 mm/truncate.c                        |  17 +-
 mm/vmscan.c                          |  16 +-
 mm/vmstat.c                          |   1 +
 36 files changed, 388 insertions(+), 663 deletions(-)

base-commit: 7891fbb9512f127826e1d5dbf380ee212bd15eb0

Hugh
