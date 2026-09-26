Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00D25B087
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790388471; cv=none; b=fpFVeqlqZxNdkIedU51JfB/FzQ8OZRCBgqnBNNpaKyB/g2GOmlgsMAdxRaaTTGZTgqitww565PSho1E1/8b8mILy6+GbhDk8YojHAlB2FIQ5uOa3bryH6llT0aMbPsFaG6sUDJK3RF4UxpqVkxZzdnWIuU5V9yORnd7o5g9z1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790388471; c=relaxed/simple;
	bh=DdcObnhLvU3ls0cGmHLGHqKMExuQVY9LIWDky3y/b9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClW5DGJiVYqz6Bcx3iim7a/IcwkaiJeH4Fqkwt/7vUapEkLlo3TM6jWKqiLdLNN0nr8dGieezEHNsNSomDJUNAHU4v6E4FpwHYP6VJCzMsCGxc6/B6i8q84wOx2b9GgDPtke9aKGbfY176fJkZRu4EDfdkHLqdFkhZTZxyiq5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0EnFYvP; arc=none smtp.client-ip=95.215.58.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0EnFYvP"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DdcObnhLvU3ls0cGmHLGHqKMExuQVY9LIWDky3y/b9w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790388466; v=1; x=1790993266;
 b=N0EnFYvPbwJNqGGEs2snSOcK35y6DNSXTPG0DcUOdgu8uZos7L/pwK/pUI180f2T/ZwJVXUn
 tPijOZOy/sffRVGQEvEuyy4YYE773vQYyf4ad6yW96fpAbtFHYfzc1lAmQMeF+t4zO+2gl86TTj
 xQ06tnVLQN9sO9aAsB+ZGvOQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6f0838c226c85a64;
	Sat, 26 Sep 2026 02:07:43 +0000
X-Mizu-Trace-ID: 6f0838c226c85a64
X-Migadu-Flow: FLOW_OUT
Message-ID: <064255ee-c8be-4a82-8be0-fa209eac8637@linux.dev>
Date: Fri, 25 Sep 2026 19:07:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>,
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Content-Language: en-US
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugh,

On 9/9/26 2:39 AM, Hugh Dickins wrote:
> [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
> 
> This series was prompted by lru_add_drain_all() appearing in watchdog
> backtraces: not to blame, but blocked on an unresponsive CPU to run
> its workqueue. lru_add_drain_all() is a heavyweight operation, which
> we often hope to avoid by a much lighter lru_add_drain(); but even
> those local drains can aggravate the lruvec lock contention which
> per-cpu fbatches are intended to ease.
> 
> Now let the folios on the lru_add and other per-cpu fbatches remain
> there, isolatable, with PG_lru set and refcount unraised, just like
> when on an actual LRU. Then many calls to lru_add_drain() and _all()
> can be removed.
> 
> It's something I've wanted to do for years, tried several times, but
> only hit on a good way to do it a few weeks ago: now it's uncomfortable
> to watch others wrestling with the drainage, while I'm sitting on this.
> 
> The key idea came from the "if (!folio_test_clear_lru(folio)) continue;".
> If we don't mind missing to take an action on rare occasions, then maybe
> we won't mind taking an action on the wrong folio on rare occasions, so
> long as it is a folio consenting to PG_lru rules.
> 
> No new locking, but relies on folio_try_get() and folio_test_clear_lru()
> even on the lru_add fbatch; with use of bits not set in aligned pointers,
> and some try_cmpxchg()ing.  Speculative references to folios are already
> accepted: this adds another source of them.
> 
> Performance? You (and the bots) tell me. I'm considering this as a
> cleanup, to make life easier for developers. I expect that some loads
> will show improvement, but also expect some disappointments (perhaps
> I go too far against lru_cache_disable()? or not far enough).
> 
I found one source of regression but I think it's fixable.

Using a test of 4 processes repeatedly write faulting anon pages then
discarding with MADV_DONTNEED, the perf A/B below shows that the series
(minus patch 27) spends more time in __page_cache_release due to new
lru_lock traffic.

baseline (7891fbb9512f):
  0.03%  folio-churn  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
  0.26%  folio-churn  [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
  0.01%  folio-churn  [kernel.kallsyms]  [k] folio_lruvec_lock_irqsave
  0.00%  folio-churn  [kernel.kallsyms]  [k] folio_lruvec_relock_irqsave
  0.03%  folio-churn  [kernel.kallsyms]  [k] __page_cache_release

series (without patch 27):
      6.97%  folio-churn  [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
             |
             ---_raw_spin_lock_irqsave
                |
                 --6.96%--folio_lruvec_lock_irqsave
                           folio_lruvec_relock_irqsave
                           |
                            --6.72%--__page_cache_release
                                      folios_put_refs
                                      free_pages_and_swap_cache
                                      tlb_flush_mmu
                                      tlb_finish_mmu
                                      do_madvise
                                      __x64_sys_madvise
                                      do_syscall_64
                                      entry_SYSCALL_64_after_hwframe
                                      __madvise

      6.62%  folio-churn  [kernel.kallsyms] [k] queued_spin_lock_slowpath
             |
             ---queued_spin_lock_slowpath
                _raw_spin_lock_irqsave
                folio_lruvec_lock_irqsave
                folio_lruvec_relock_irqsave
                |
                 --6.43%--__page_cache_release
                           folios_put_refs
                           free_pages_and_swap_cache
                           tlb_flush_mmu
                           tlb_finish_mmu
                           do_madvise
                           __x64_sys_madvise
                           do_syscall_64
                           entry_SYSCALL_64_after_hwframe
                           __madvise

There was a pre-existing dead folio optimization [0] which allowed
caller-released folios remaining on batches to be cleaned up at drain
time without lru_lock acquisition. This series removes it which makes
sense since the batch reference concept is gone. But now that callers
effectively invoke the cleanup when refcounts go directly to zero,
there's a point in which an lru_lock will be taken for pending folios
that are dead (refcount zero but still on batch). That's seen in the
call graphs above and is unnecessary since these folios haven't been
inserted into the LRU. Luckily It looks like the new API call
lru_add_del_folio() can be used to avoid this, since it returns true
after cleaning up the pending LRU batch state. I applied this diff and
re-ran the same benchmark. The new locking overhead was nearly all
eliminated. The perf output afterward shows the fractional amount that
remains.

@@ -64,8 +64,10 @@ static void __page_cache_release(struct folio *folio, 
struct lruvec **lruvecp,
                 unsigned long *flagsp)
  {
         if (folio_test_lru(folio)) {
-               folio_lruvec_relock_irqsave(folio, lruvecp, flagsp);
-               lruvec_del_folio(*lruvecp, folio);
+               if (!lru_add_del_folio(folio)) {
+                       folio_lruvec_relock_irqsave(folio, lruvecp, flagsp);
+                       lruvec_del_folio(*lruvecp, folio);
+               }
                 __folio_clear_lru_flags(folio);
         }
  }

series modified with patch above (without patch 27):
      0.77%  folio-churn  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
             |
             ---queued_spin_lock_slowpath
                _raw_spin_lock_irqsave
                |
                 --0.77%--folio_lruvec_lock_irqsave
                           folio_lruvec_relock_irqsave
                           |
                            --0.52%--__page_cache_release
                                      folios_put_refs
                                      free_pages_and_swap_cache
                                      tlb_flush_mmu
                                      tlb_finish_mmu
                                      do_madvise
                                      __x64_sys_madvise
                                      do_syscall_64
                                      entry_SYSCALL_64_after_hwframe
                                      __madvise

      0.37% folio-churn [kernel.kallsyms] [k] _raw_spin_lock_irqsave
      0.04% folio-churn [kernel.kallsyms] [k] folio_lruvec_lock_irqsave
      0.01% folio-churn [kernel.kallsyms] [k] folio_lruvec_relock_irqsave

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm?id=9669b87065a6fe96198f3df2c3d125c5f5c1f210
