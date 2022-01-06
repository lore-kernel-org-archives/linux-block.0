Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF2C433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 23:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiAFXPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jan 2022 18:15:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB3C061245
        for <linux-block@vger.kernel.org>; Thu,  6 Jan 2022 15:15:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l15so3528070pls.7
        for <linux-block@vger.kernel.org>; Thu, 06 Jan 2022 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kNZG/GDbG3gaOO0TfzwISLZiF8eXfIO7CCTktdMzJxM=;
        b=N2RoELFn3uYqV7HEvYMIeiSBTl1sBC8ymJ7hPlAy/maqYuW0kYQiGsqafxHrcsU6Ik
         KuyifA/yWqvcwpmSezWIpYXlxmAswjUcrSsmHsSU21DGm/BufphULj3RLDICbxtFeTZn
         sQvU+EHGKYuFh8ytY6KQFqxC1ZmR+6n67LlqENgLFfP/W+OJ2/gGm0VB8Id1xIF9VlYI
         RYemFCLK3ZAQMikTwotiAfdMs1NmcQk8YvP5vEZRDKohzM8SW0klQ5EBRm5NzN0FV64F
         89OfNpuVYwnwQSyR9M3h4TL7TeU6D8B93tBUtzw3TOx4hYA8Vtibh8lxwRmkf19S7vNZ
         NP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kNZG/GDbG3gaOO0TfzwISLZiF8eXfIO7CCTktdMzJxM=;
        b=BjK5KXCnb4KKZsQUKpT0G5ccdHCTSxYC++/r5KW0fLUHKWdGqyCWUodJcwOTiVerzL
         ePwJy2QzO2PKETzCSnsJHVS5hAlWcf2Z72v9zPJFUZSaicloAvyDkQZJhIQIr2qalfcg
         9XkoSP8uTH/dVK93zzQkmNAKyMJAioaMKp7uSjeWKFWADvlQn6fLY7fBSpMbyYPhxy/1
         yV9Q9NZSV8GRtyaWY1IWpAaLZMlFtmJ6tANFejvU6SVH6UdcmrzVoqCRFDP3dLOMyGW/
         QieUNJbdKrZ7fvEFtTX2k1P1CrNzSbsq2wiwP02kg2/s/7LF5AP/sqnwtGqlhtwyh2qO
         jCyQ==
X-Gm-Message-State: AOAM530xt8juY+eFk2V2fMj0EWU45R5epqN9TWx5rQqZWA8Hl6Ic9pIH
        58bRWA4YmSbcS5cj5FSQ1ao=
X-Google-Smtp-Source: ABdhPJzoK8YzY5GKzKTkdZvboNSeTzIebpie96mHCGNmtSVJ8/z3gkERjU4o6LN8/FA9jGhceYyAMw==
X-Received: by 2002:a17:90b:4ac6:: with SMTP id mh6mr12598589pjb.47.1641510953251;
        Thu, 06 Jan 2022 15:15:53 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e32:b92d:27fe:aa55])
        by smtp.gmail.com with ESMTPSA id o11sm3733636pfu.150.2022.01.06.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:15:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Jan 2022 15:15:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Ydd4JqeJimkpjyzS@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105233440.63361-1-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> Problem:
> =======
> 
> Userspace might read the zero-page instead of actual data from a
> direct IO read on a block device if the buffers have been called
> madvise(MADV_FREE) on earlier (this is discussed below) due to a
> race between page reclaim on MADV_FREE and blkdev direct IO read.
> 
> Race condition:
> ==============
> 
> During page reclaim, the MADV_FREE page check in try_to_unmap_one()
> checks if the page is not dirty, then discards its PTE (vs remap it
> back if the page is dirty).
> 
> However, after try_to_unmap_one() returns to shrink_page_list(), it
> might keep the page _anyway_ if page_ref_freeze() fails (it expects
> a single page ref from the isolation).
> 
> Well, blkdev_direct_IO() gets references for all pages, and on READ
> operations it sets them dirty later.
> 
> So, if MADV_FREE pages (i.e., not dirty) are used as buffers (more
> later) for direct IO read from block devices and page reclaim runs
> during __blkdev_direct_IO[_simple]() AFTER bio_iov_iter_get_pages()
> but BEFORE it sets pages dirty, that situation happens.
> 
> The direct IO read eventually completes. Now, when userspace reads
> the buffers, the PTE is no longer there and the page fault handler
> do_anonymous_page() services that with the zero-page, NOT the data!
> 
> A synthetic reproducer is provided.
> 
> Page faults:
> ===========
> 
> The data read from the block device probably won't generate faults
> due to DMA (no MMU) but even in the case it wouldn't use DMA, that
> happens on different virtual addresses (not user-mapped addresses)
> because `struct bio_vec` stores `struct page` to figure addresses
> out (which are different from/unrelated to user-mapped addresses)
> for the data read.
> 
> Thus userspace reads (to user-mapped addresses) still fault, then
> do_anonymous_page() gets another `struct page` that would address/
> map to other memory than the `struct page` used by `struct bio_vec`
> for the read (which runs correctly as the page wasn't freed due to
> page_ref_freeze(), and is reclaimed later) -- but even if the page
> addresses matched, that handler maps the zero-page in the PTE, not
> that page's memory (on read faults.)
> 
> If page reclaim happens BEFORE bio_iov_iter_get_pages() the issue
> doesn't happen, because that faults-in all pages as writeable, so
> do_anonymous_page() sets up a new page/rmap/PTE, and that is used
> by direct IO. The userspace reads don't fault as the PTE is there
> (thus zero-page is not used.)
> 
> Solution:
> ========
> 
> One solution is to check for the expected page reference count in
> try_to_unmap_one() too, which should be exactly two: one from the
> isolation (checked by shrink_page_list()), and the other from the
> rmap (dropped by the discard: label). If that doesn't match, then
> remap the PTE back, just like page dirty does.
> 
> The new check in try_to_unmap_one() should be safe in races with
> bio_iov_iter_get_pages() in get_user_pages() fast and slow paths,
> as it's done under the PTE lock. The fast path doesn't take that
> lock but it checks the PTE has changed, then drops the reference
> and leaves the page for the slow path (which does take that lock).
> 
> - try_to_unmap_one()
>   - page_vma_mapped_walk()
>     - map_pte() # see pte_offset_map_lock():
>         pte_offset_map()
>         spin_lock()
>   - page_ref_count() # new check
>   - page_vma_mapped_walk_done() # see pte_unmap_unlock():
>       pte_unmap()
>       spin_unlock()
> 
> - bio_iov_iter_get_pages()
>   - __bio_iov_iter_get_pages()
>     - iov_iter_get_pages()
>       - get_user_pages_fast()
>         - internal_get_user_pages_fast()
> 
>           # fast path
>           - lockless_pages_from_mm()
>             - gup_{pgd,p4d,pud,pmd,pte}_range()
>                 ptep = pte_offset_map() # not _lock()
>                 pte = ptep_get_lockless(ptep)
>                 page = pte_page(pte)
>                 try_grab_compound_head(page) # get ref
>                 if (pte_val(pte) != pte_val(*ptep))
>                         put_compound_head(page) # put ref
>                         # leave page for slow path
>           # slow path
>           - __gup_longterm_unlocked()
>             - get_user_pages_unlocked()
>               - __get_user_pages_locked()
>                 - __get_user_pages()
>                   - follow_{page,p4d,pud,pmd}_mask()
>                     - follow_page_pte()
>                         ptep = pte_offset_map_lock()
>                         pte = *ptep
>                         page = vm_normal_page(pte)
>                         try_grab_page(page) # get ref
>                         pte_unmap_unlock()
> 
> Regarding transparent hugepages, that number shouldn't change, as
> MADV_FREE (aka lazyfree) pages are PageAnon() && !PageSwapBacked()
> (madvise_free_pte_range() -> mark_page_lazyfree() -> lru_lazyfree_fn())
> thus should reach shrink_page_list() -> split_huge_page_to_list()
> before try_to_unmap[_one](), so it deals with normal pages only.
> 
> (And in case unlikely/TTU_SPLIT_HUGE_PMD/split_huge_pmd_address()
> happens, which it should not or be rare, the page refcount is not
> two, as the head page counts tail pages, and tail pages have zero.
> That also prevents checking the head `page` then incorrectly call
> page_remove_rmap(subpage) for a tail page, that isn't even in the
> shrink_page_list()'s page_list (an effect of split huge pmd/pmvw),
> as it might happen today in this unlikely scenario.)
> 
> MADV_FREE'd buffers:
> ===================
> 
> So, back to the "if MADV_FREE pages are used as buffers" note.
> The case is arguable, and subject to multiple interpretations.
> 
> The madvise(2) manual page on the MADV_FREE advice value says:
> - 'After a successful MADV_FREE ... data will be lost when
>    the kernel frees the pages.'
> - 'the free operation will be canceled if the caller writes
>    into the page' / 'subsequent writes ... will succeed and
>    then [the] kernel cannot free those dirtied pages'
> - 'If there is no subsequent write, the kernel can free the
>    pages at any time.'
> 
> Thoughts, questions, considerations...
> - Since the kernel didn't actually free the page (page_ref_freeze()
>   failed), should the data not have been lost? (on userspace read.)
> - Should writes performed by the direct IO read be able to cancel
>   the free operation?
>   - Should the direct IO read be considered as 'the caller' too,
>     as it's been requested by 'the caller'?
>   - Should the bio technique to dirty pages on return to userspace
>     (bio_check_pages_dirty() is called/used by __blkdev_direct_IO())
>     be considered in another/special way here?
> - Should an upcoming write from a previously requested direct IO
>   read be considered as a subsequent write, so the kernel should
>   not free the pages? (as it's known at the time of page reclaim.)
> 
> Technically, the last point would seem a reasonable consideration
> and balance, as the madvise(2) manual page apparently (and fairly)
> seem to assume that 'writes' are memory access from the userspace
> process (not explicitly considering writes from the kernel or its
> corner cases; again, fairly).. plus the kernel fix implementation
> for the corner case of the largely 'non-atomic write' encompassed
> by a direct IO read operation, is relatively simple; and it helps.
> 
> Reproducer:
> ==========
> 
> @ test.c (simplified, but works)
> 
> 	#define _GNU_SOURCE
> 	#include <fcntl.h>
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 
> 	int main() {
> 		int fd, i;
> 		char *buf;
> 
> 		fd = open(DEV, O_RDONLY | O_DIRECT);
> 
> 		buf = mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
>                 	   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> 		for (i = 0; i < BUF_SIZE; i += PAGE_SIZE)
> 			buf[i] = 1; // init to non-zero
> 
> 		madvise(buf, BUF_SIZE, MADV_FREE);
> 
> 		read(fd, buf, BUF_SIZE);
> 
> 		for (i = 0; i < BUF_SIZE; i += PAGE_SIZE)
> 			printf("%p: 0x%x\n", &buf[i], buf[i]);
> 
> 		return 0;
> 	}
> 
> @ block/fops.c (formerly fs/block_dev.c)
> 
> 	+#include <linux/swap.h>
> 	...
> 	... __blkdev_direct_IO[_simple](...)
> 	{
> 	...
> 	+	if (!strcmp(current->comm, "good"))
> 	+		shrink_all_memory(ULONG_MAX);
> 	+
>          	ret = bio_iov_iter_get_pages(...);
> 	+
> 	+	if (!strcmp(current->comm, "bad"))
> 	+		shrink_all_memory(ULONG_MAX);
> 	...
> 	}
> 
> @ shell
> 
> 	# yes | dd of=test.img bs=1k count=16
> 	# DEV=$(losetup -f --show test.img)
> 	# gcc -DDEV=\"$DEV\" -DBUF_SIZE=16384 -DPAGE_SIZE=4096 test.c -o test
> 
> 	# od -tx1 $DEV
> 	0000000 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a
> 	*
> 	0040000
> 
> 	# mv test good
> 	# ./good
> 	0x7f1509206000: 0x79
> 	0x7f1509207000: 0x79
> 	0x7f1509208000: 0x79
> 	0x7f1509209000: 0x79
> 
> 	# mv good bad
> 	# ./bad
> 	0x7fd87272f000: 0x0
> 	0x7fd872730000: 0x0
> 	0x7fd872731000: 0x0
> 	0x7fd872732000: 0x0
> 
> Ceph/TCMalloc:
> =============
> 
> For documentation purposes, the use case driving the analysis/fix
> is Ceph on Ubuntu 18.04, as the TCMalloc library there still uses
> MADV_FREE to release unused memory to the system from the mmap'ed
> page heap (might be committed back/used again; it's not munmap'ed.)
> - PageHeap::DecommitSpan() -> TCMalloc_SystemRelease() -> madvise()
> - PageHeap::CommitSpan() -> TCMalloc_SystemCommit() -> do nothing.
> 
> Note: TCMalloc switched back to MADV_DONTNEED a few commits after
> the release in Ubuntu 18.04 (google-perftools/gperftools 2.5), so
> the issue just 'disappeared' on Ceph on later Ubuntu releases but
> is still present in the kernel, and can be hit by other use cases.
> 
> The observed issue seems to be the old Ceph bug #22464 [1], where
> checksum mismatches are observed (and instrumentation with buffer
> dumps shows zero-pages read from mmap'ed/MADV_FREE'd page ranges).
> 
> The issue in Ceph was reasonably deemed a kernel bug (comment #50)
> and mostly worked around with a retry mechanism, but other parts
> of Ceph could still hit that (rocksdb). Anyway, it's less likely
> to be hit again as TCMalloc switched out of MADV_FREE by default.
> 
> (Some kernel versions/reports from the Ceph bug, and relation with
> the MADV_FREE introduction/changes; TCMalloc versions not checked.)
> - 4.4 good
> - 4.5 (madv_free: introduction)
> - 4.9 bad
> - 4.10 good? maybe a swapless system
> - 4.12 (madv_free: no longer free instantly on swapless systems)
> - 4.13 bad
> 
> [1] https://tracker.ceph.com/issues/22464
> 
> Thanks:
> ======
> 
> Several people contributed to analysis/discussions/tests/reproducers
> in the first stages when drilling down on ceph/tcmalloc/linux kernel:
> 
> - Dan Hill <daniel.hill@canonical.com>
> - Dan Streetman <dan.streetman@canonical.com>
> - Dongdong Tao <dongdong.tao@canonical.com>
> - Gavin Guo <gavin.guo@canonical.com>
> - Gerald Yang <gerald.yang@canonical.com>
> - Heitor Alves de Siqueira <halves@canonical.com>
> - Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> - Jay Vosburgh <jay.vosburgh@canonical.com>
> - Matthew Ruffell <matthew.ruffell@canonical.com>
> - Ponnuvel Palaniyappan <ponnuvel.palaniyappan@canonical.com>
> 
> v2: check refcount against mapcount rather than a static 2.
>     Thanks: Minchan Kim <minchan@kernel.org>
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> ---
>  mm/rmap.c   | 15 ++++++++++++++-
>  mm/vmscan.c |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 163ac4e6bcee..8671de473c25 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  
>  			/* MADV_FREE page check */
>  			if (!PageSwapBacked(page)) {
> -				if (!PageDirty(page)) {
> +				int ref_count = page_ref_count(page);
> +				int map_count = page_mapcount(page);
> +
> +				/*
> +				 * The only page refs must be from the isolation
> +				 * (checked by the caller shrink_page_list() too)
> +				 * and one or more rmap's (dropped by discard:).
> +				 *
> +				 * Check the reference count before dirty flag
> +				 * with memory barrier; see __remove_mapping().
> +				 */
> +				smp_rmb();
> +				if ((ref_count - 1 == map_count) &&
> +				    !PageDirty(page)) {

Thanks. Looks good to me.

I'd like to invite more folks for better eyes since this could
be a rather subtle issue.
