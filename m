Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F842E43C
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579398; cv=none; b=q9kpoeKoKWXKccqUWV3ZO/WqPCcc/hEXvuPJBgs3x7qBrAwnTId8Rup8LjihAB3c/XMfpXJ9j9ALVCkvYdgmZCAibktNMHsyVfVGGzKzLDw2tyBC3p9SzvJ0xGP/wvatyjNe44V/XaBLcLQr2dLcfo8rUrRbwOX2aBB5VI7NMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579398; c=relaxed/simple;
	bh=3bHlh+yjzIVaS0rKbfcNVgRQ/8VtW7Bb04pv3uobmpk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=LvKDo7hnb7qebPj/SPoqPhBFsDwSBqEyOdJmgGQuiCH3Ye+iHAhoutH/WnnKVRXFOP4A59xvxRFcJ2Bgkqoa0NEGjG3wiWmG+LdaPN19koYDEQ+/j7lEosw3VEMpYrmyn0ui9goILDkLeHsYdLJ5qYEl7ev64A0knwN4PSm/KvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNosARSw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNosARSw"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c718715fso32798617b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579393; x=1788184193; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wa1iTT9vjhUKkra9WxI7hECThksYL7WKs9jkspFydz8=;
        b=FNosARSwfOfZRX46CtbAlx46mQDvTfxUpbpSlFFGSHWfR7zqncE/ZWK0kvNL8WoCOK
         1WZWRMzCVVKBtwkyR/71t9bcrm4m5vFEQxhljAenWCoXoaE/4qd3xCxg1VrK7l6rQmVx
         SLb/4ITsm2D2HQL0/UmWxm48wxuAKxG3VfR5u4aJt2vi1Fn1v+ImlXAQjhgEp7JU2bO2
         i2fTGXFNAlcgAkOabFUaahTGXAT90iKiAMrnlZV4XVcyp0KODeBAj59LeP04mMpfNIZa
         /wfhoBh1MhX6VkjtGIS6nh5LXvtQ1plxP3X5aV/29lq526uzTFLkQfXxln5NvEeoOooF
         jaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579393; x=1788184193;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wa1iTT9vjhUKkra9WxI7hECThksYL7WKs9jkspFydz8=;
        b=sxLa9sGlV96crgfbcMyDt+wHgkHMkTAsE9vPEJgWNP7JwACXp2g+Rd4SXQeqBQgMiY
         WM12QUL7JkblfKZRkqCzwfuDy0PtPldg7Ll4lFAc7dGLB1hwd2f9+8K2OVHk98Fk+Rf4
         q/mkAYWtD7lhum35ggeuMnGEA7unWOMPCGgi1NmYQnDoEgp4qkQcTQgOmHQceKX6XJLW
         tqr9f2R9TdpxsYzF8/kKPXUxYD4ybqXHfDC2BYPn/+Sez+waL0PKwixT0A7lbYXRWqIR
         21CjDZhf3ozXT8T7p+HXnH2IlnirabFeknYiCmnYg38XL//q5OBcLhYn5kA5lWuR5mDA
         PooA==
X-Forwarded-Encrypted: i=1; AHgh+Rpx1Ew9zya9oQ+ypo0yw98IhYoQ43ynNsUqV8YnBTQJkeNOGDrODK5hR4gd9/23Pti/jptfQTSQ8TiJSw==@vger.kernel.org
X-Gm-Message-State: AFuF++noEza5H59iQhJ4yC6VECBfwwrGV7BO8H99bUsmc2npCBWh7NAK
	lLV8LF5GRIM5TWjHCSKr8Q0IxJhT1h4jesh3kNQYs1z4X3c2Z2pI1tbKEXT7gawNSg==
X-Gm-Gg: AR+sD10tJ9RY8joVfkGkk6vcpe5p90upYeAoh4vGQIRurvyJaAWDvtzZvVohqFNEeML
	mzQVym9oUAP33O9g1VEKt8UHFEqIMCnC27Z9/zfsLKyT9B9CGktVn9nBsLJdFRpOsMGez/XRGe7
	LTfWwNRdu5SX2h9a0zdEy2L4J95v3ErH7IVMTrrirXQfUntS8J8dhQ6W+yIIRjol8p2l4olCIG/
	dRcgQntL1sgFsg2ABe9L/c+9Hdz2geMC2ozYt9oYjvx5TQeMj7XINf+9IWJK4pAYIN3B1cwPIeS
	4t9A4YKZsoJ2pbGzhBdPqsjcIMufy2Egqy2lMINxtWEJ7/c+Hn7oZ15UymN9DpgTNoCMTL/v3l6
	fQHO0hie89FDs2iAa//d8zf5WdHHCCLfEj21nXrR32e9HDqY0mto8Zf2c+NnRXw+R0Ng1HqbwK/
	HpP/azZmYqn1GMVZOc4d3eoNGXKEwj0R/LO8ZBcn+PVXtVwphRrWCO6d6LczLpp5K5CBXQrE+3+
	esGaXtdZSMTuoj6tLTtqVpw5C9b/dglc+NPH/tX0cViCLPM
X-Received: by 2002:a05:690c:c602:b0:81e:ae6d:caed with SMTP id 00721157ae682-849f7262b93mr78114917b3.34.1787579392083;
        Mon, 24 Aug 2026 06:49:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca62f6ad5sm33495767b3.18.2026.08.24.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:49:49 -0700 (PDT)
Date: Mon, 24 Aug 2026 06:49:31 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
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
Subject: [PATCH 00/25] mm/fbatch: drain lru_add_drain() and _all()
Message-ID: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

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

No new locking, but relies on folio_try_get() and  folio_test_clear_lru()
even on the lru_add fbatch; with use of bits not set in aligned pointers,
and some try_cmpxchg()ing.  Speculative references to folios are already
accepted: this adds another source of them.

Performance? You (and the bots) tell me. I'm considering this as a
cleanup, to make life easier for developers. I expect that some loads
will show improvement, but also expect some disappointments (perhaps
I go too far against lru_cache_disable()? or not far enough).

The timing is not so good: middle of a merge window is not a great
time to present new work; but I hope to be taking three weeks off in
two weeks time, so best to get this out in the open early, while I can
respond. If it's welcome in principle for 7.4, but too many changes
are demanded, maybe someone else can step up to shepherd it through.

Rebased and retested on Linus's tree of Sunday afternoon,
base-commit: 4352b8aee98005853aa63f57d6377282de17a33f
which includes the mm/swap.c to mm/folio.c renaming,
but not yet David's mods to mm/gup.c which conflict with my 13/25:
I'll reply to that one with an alternate patch to use once David's
two have gone in (reverting both of them and what was there before).

01/25 mm/fbatch: remove !CONFIG_SMP special case of folio_activate()
02/25 mm/fbatch: allow folios_put_refs() to skip xa_is_value() entries
03/25 mm/fbatch: temporarily disable lazyfree and mlock+munlock batching
04/25 mm/fbatch: lru bit set, no extra ref, while folio on per-cpu fbatch
05/25 mm/fbatch: lru_add_del_folio()+folio_add_lru() after clear_lru()
06/25 mm/fbatch: fbatch_drain_lazyfree(onstack fbatch) before ptl unlock
07/25 mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize folio_activate()
08/25 mm/fbatch: replace mlock_new_folio() by __folio_add_lru(,mlockit)
09/25 mm/fbatch: restore mlock+munlock batching, without extra ref
10/25 mm/fbatch: remove several uses of mlock_drain_local()
11/25 mm/fbatch: remove migration's PAGE_WAS_MLOCKED lru_add_drain()
12/25 mm/fbatch: remove percpu_pvec_drained and folios_put()
13/25 mm/fbatch: no lru_add drain to collect_longterm_unpinnable_folios()
14/25 mm/fbatch: no lru_add_drain() nor _all() for memfd_wait_for_pins()
15/25 mm/fbatch: remove shake_folio() shake_page() from memory-failure
16/25 mm/fbatch: remove lru_cache_disable() from NUMA folio migration
17/25 mm/fbatch: no lru_cache_disable() in __alloc_contig_migrate_range()
18/25 mm/fbatch: remove lru_add_drain() and _all() calls from various
19/25 mm/fbatch: vm/stat_refresh include lru_add_drain() on each cpu
20/25 s390/fbatch: no lru_add_drain_all() in s390_wiggle_split_folio()
21/25 block/fbatch: no lru_add_drain_all() in invalidate_bdev()
22/25 fs/fbatch: drop_caches invalidate_bh_lrus() not lru_add_drain_all()
23/25 fs,mm/fbatch: use invalidate_bh_lrus() not invalidate_bh_lrus_cpu()
24/25 fs,mm/fbatch: lru_cache_disable() keep off buffer_head lrus only
25/25 mm/fbatch: move lru_add_drain_all() declaration to mm/internal.h

 Documentation/mm/unevictable-lru.rst |   2 +-
 arch/s390/kernel/uv.c                |   1 -
 block/bdev.c                         |   1 -
 fs/buffer.c                          |  40 +--
 fs/drop_caches.c                     |   4 +-
 include/linux/buffer_head.h          |   8 +-
 include/linux/folio_batch.h          |   7 +-
 include/linux/huge_mm.h              |   6 +-
 include/linux/mm.h                   |  18 --
 include/linux/mm_inline.h            |  22 ++
 include/linux/mm_types.h             |  12 +-
 include/linux/swap.h                 |  14 +-
 mm/compaction.c                      |  25 +-
 mm/fadvise.c                         |  17 +-
 mm/folio.c                           | 375 +++++++++------------------
 mm/gup.c                             |  14 -
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
 mm/mlock.c                           | 192 ++++++--------
 mm/page_alloc.c                      |   3 -
 mm/rmap.c                            |   4 -
 mm/shmem.c                           |   2 -
 mm/truncate.c                        |  17 +-
 mm/vmscan.c                          |  16 +-
 mm/vmstat.c                          |   1 +
 36 files changed, 344 insertions(+), 612 deletions(-)

Hugh
