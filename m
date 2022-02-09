Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12762C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiBIU1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:27:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBIU1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 15:27:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6CE039E0D
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 12:27:08 -0800 (PST)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E5A93F203
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644438427;
        bh=AtXokR3oJPuhsRT2oWOhOAX8IfwP7C3uyJKFJh+ngIg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=NyPXIysHKnjTH63ZpJGLQKp1SZY04ogOFX6bhmUipnxHQ3kxvKm/D89ZRNft2PsPY
         jWSjHVtNvHOxR97ho4OraeXTJnv6dRvinzcxeS9xZ2pMGS58M2DfjeZMuzAsg1KscM
         /Mco0ABv8XysScHy7zxvnEKvsP8Xl2MMa/ny4bXdZTL18pD3ZvmdyF5cxjEyv4PHl0
         bExcJ2/4ZM62Qzo/1TIp6vGPdb28wpgfo1quhZQ0S83SBeUpJTbE/4xUcR3Y57qL4j
         GSYg4PxCArV7wIuqf/nvqvifT5HguvjKhCWKtndEEM3FEVz2Thzspu8EMKz9y26+mZ
         d8BnvBLZwLmXA==
Received: by mail-ot1-f71.google.com with SMTP id h5-20020a9d5545000000b0059ecbfae94eso2083228oti.17
        for <linux-block@vger.kernel.org>; Wed, 09 Feb 2022 12:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtXokR3oJPuhsRT2oWOhOAX8IfwP7C3uyJKFJh+ngIg=;
        b=VdtH+piYRWEaraMlag/mP4Jutan5hAtclK1dhKT6i7h8IbY5mOKh9Y101eKe2Hltnr
         ihGDXeaZT18Mrp9S+/2gu6KfGT7RM2xonrax1VTpA0pva+gWI2l06LURMvAZyU4YI7Sr
         D6jPnJuoAHN1GhpRF2i3Jfb4FHmsxmiZzNlhUpBHwssx+qAIJ5+nAJx3uJDm3rA+2HQX
         K3e/tiwyAXvR0FcHQA9klCXXD+QVDQgFE30ssRA3fcqeToGNRVPbaSWflH3V82c2j7mz
         226nymAtrIWw2X/IE3+00+Ic4b+MOuJPQktBwhkQ2FUw6es/6ptfB9yjO8T/Du9Clnpw
         Ew2g==
X-Gm-Message-State: AOAM5336ZeFmH+1jOGgAHGAVhTFhSZ9v2+/h8bCJgrGgcN2Kp5Yd/dMm
        pQ5C7YltoQ0f8T+b0qs9mgbc77dAP7Zc91vK/6MKDveEOtDUxIflVfPSZJdUoz6eb7bsTlisuD4
        MV8Mx0k6qurABL6bRKCWbQ8ptTP1g4SmYxvtdDroy
X-Received: by 2002:a05:6870:1301:: with SMTP id 1mr1306743oab.138.1644438424909;
        Wed, 09 Feb 2022 12:27:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPUiD33GH6qiWfQobuxxrodTm2R6fOnBZ81MRmci1RpQlMJQ/gXRRkZHMcfhodAsfALo9EKg==
X-Received: by 2002:a05:6870:1301:: with SMTP id 1mr1306738oab.138.1644438424549;
        Wed, 09 Feb 2022 12:27:04 -0800 (PST)
Received: from mfo-t470.. ([2804:14c:4e1:8732:230c:92fd:d1dc:e418])
        by smtp.gmail.com with ESMTPSA id p7sm504238otf.8.2022.02.09.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:27:04 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v4] mm: fix race between MADV_FREE reclaim and blkdev direct IO read
Date:   Wed,  9 Feb 2022 17:26:59 -0300
Message-Id: <20220209202659.183418-1-mfo@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Problem:
=======

Userspace might read the zero-page instead of actual data from a
direct IO read on a block device if the buffers have been called
madvise(MADV_FREE) on earlier (this is discussed below) due to a
race between page reclaim on MADV_FREE and blkdev direct IO read.

- Race condition:
  ==============

During page reclaim, the MADV_FREE page check in try_to_unmap_one()
checks if the page is not dirty, then discards its rmap PTE(s) (vs.
remap back if the page is dirty).

However, after try_to_unmap_one() returns to shrink_page_list(), it
might keep the page _anyway_ if page_ref_freeze() fails (it expects
exactly _one_ page reference, from the isolation for page reclaim).

Well, blkdev_direct_IO() gets references for all pages, and on READ
operations it only sets them dirty _later_.

So, if MADV_FREE'd pages (i.e., not dirty) are used as buffers for
direct IO read from block devices, and page reclaim happens during
__blkdev_direct_IO[_simple]() exactly AFTER bio_iov_iter_get_pages()
returns, but BEFORE the pages are set dirty, the situation happens.

The direct IO read eventually completes. Now, when userspace reads
the buffers, the PTE is no longer there and the page fault handler
do_anonymous_page() services that with the zero-page, NOT the data!

A synthetic reproducer is provided.

- Page faults:
  ===========

If page reclaim happens BEFORE bio_iov_iter_get_pages() the issue
doesn't happen, because that faults-in all pages as writeable, so
do_anonymous_page() sets up a new page/rmap/PTE, and that is used
by direct IO. The userspace reads don't fault as the PTE is there
(thus zero-page is not used/setup).

But if page reclaim happens AFTER it / BEFORE setting pages dirty,
the PTE is no longer there; the subsequent page faults can't help:

The data-read from the block device probably won't generate faults
due to DMA (no MMU) but even in the case it wouldn't use DMA, that
happens on different virtual addresses (not user-mapped addresses)
because `struct bio_vec` stores `struct page` to figure addresses
out (which are different from user-mapped addresses) for the read.

Thus userspace reads (to user-mapped addresses) still fault, then
do_anonymous_page() gets another `struct page` that would address/
map to other memory than the `struct page` used by `struct bio_vec`
for the read.  (The original `struct page` is not available, since
it wasn't freed, as page_ref_freeze() failed due to more page refs.
And even if it were available, its data cannot be trusted anymore.)

Solution:
========

One solution is to check for the expected page reference count
in try_to_unmap_one().

There should be one reference from the isolation (that is also
checked in shrink_page_list() with page_ref_freeze()) plus one
or more references from page mapping(s) (put in discard: label).
Further references mean that rmap/PTE cannot be unmapped/nuked.

(Note: there might be more than one reference from mapping due
to fork()/clone() without CLONE_VM, which use the same `struct
page` for references, until the copy-on-write page gets copied.)

So, additional page references (e.g., from direct IO read) now
prevent the rmap/PTE from being unmapped/dropped; similarly to
the page is not freed per shrink_page_list()/page_ref_freeze()).

- Races and Barriers:
  ==================

The new check in try_to_unmap_one() should be safe in races with
bio_iov_iter_get_pages() in get_user_pages() fast and slow paths,
as it's done under the PTE lock.

The fast path doesn't take the lock, but it checks if the PTE has
changed and if so, it drops the reference and leaves the page for
the slow path (which does take that lock).

The fast path requires synchronization w/ full memory barrier: it
writes the page reference count first then it reads the PTE later,
while try_to_unmap() writes PTE first then it reads page refcount.

And a second barrier is needed, as the page dirty flag should not
be read before the page reference count (as in __remove_mapping()).
(This can be a load memory barrier only; no writes are involved.)

Call stack/comments:

- try_to_unmap_one()
  - page_vma_mapped_walk()
    - map_pte()			# see pte_offset_map_lock():
        pte_offset_map()
        spin_lock()

  - ptep_get_and_clear()	# write PTE
  - smp_mb()			# (new barrier) GUP fast path
  - page_ref_count()		# (new check) read refcount

  - page_vma_mapped_walk_done()	# see pte_unmap_unlock():
      pte_unmap()
      spin_unlock()

- bio_iov_iter_get_pages()
  - __bio_iov_iter_get_pages()
    - iov_iter_get_pages()
      - get_user_pages_fast()
        - internal_get_user_pages_fast()

          # fast path
          - lockless_pages_from_mm()
            - gup_{pgd,p4d,pud,pmd,pte}_range()
                ptep = pte_offset_map()		# not _lock()
                pte = ptep_get_lockless(ptep)

                page = pte_page(pte)
                try_grab_compound_head(page)	# inc refcount
                                            	# (RMW/barrier
                                             	#  on success)

                if (pte_val(pte) != pte_val(*ptep)) # read PTE
                        put_compound_head(page) # dec refcount
                        			# go slow path

          # slow path
          - __gup_longterm_unlocked()
            - get_user_pages_unlocked()
              - __get_user_pages_locked()
                - __get_user_pages()
                  - follow_{page,p4d,pud,pmd}_mask()
                    - follow_page_pte()
                        ptep = pte_offset_map_lock()
                        pte = *ptep
                        page = vm_normal_page(pte)
                        try_grab_page(page)	# inc refcount
                        pte_unmap_unlock()

- Huge Pages:
  ==========

Regarding transparent hugepages, that logic shouldn't change, as
MADV_FREE (aka lazyfree) pages are PageAnon() && !PageSwapBacked()
(madvise_free_pte_range() -> mark_page_lazyfree() -> lru_lazyfree_fn())
thus should reach shrink_page_list() -> split_huge_page_to_list()
before try_to_unmap[_one](), so it deals with normal pages only.

(And in case unlikely/TTU_SPLIT_HUGE_PMD/split_huge_pmd_address()
happens, which should not or be rare, the page refcount should be
greater than mapcount: the head page is referenced by tail pages.
That also prevents checking the head `page` then incorrectly call
page_remove_rmap(subpage) for a tail page, that isn't even in the
shrink_page_list()'s page_list (an effect of split huge pmd/pmvw),
as it might happen today in this unlikely scenario.)

MADV_FREE'd buffers:
===================

So, back to the "if MADV_FREE pages are used as buffers" note.
The case is arguable, and subject to multiple interpretations.

The madvise(2) manual page on the MADV_FREE advice value says:

1) 'After a successful MADV_FREE ... data will be lost when
   the kernel frees the pages.'
2) 'the free operation will be canceled if the caller writes
   into the page' / 'subsequent writes ... will succeed and
   then [the] kernel cannot free those dirtied pages'
3) 'If there is no subsequent write, the kernel can free the
   pages at any time.'

Thoughts, questions, considerations... respectively:

1) Since the kernel didn't actually free the page (page_ref_freeze()
   failed), should the data not have been lost? (on userspace read.)
2) Should writes performed by the direct IO read be able to cancel
   the free operation?
   - Should the direct IO read be considered as 'the caller' too,
     as it's been requested by 'the caller'?
   - Should the bio technique to dirty pages on return to userspace
     (bio_check_pages_dirty() is called/used by __blkdev_direct_IO())
     be considered in another/special way here?
3) Should an upcoming write from a previously requested direct IO
   read be considered as a subsequent write, so the kernel should
   not free the pages? (as it's known at the time of page reclaim.)

At last:

Technically, the last point would seem a reasonable consideration
and balance, as the madvise(2) manual page apparently (and fairly)
seem to assume that 'writes' are memory access from the userspace
process (not explicitly considering writes from the kernel or its
corner cases; again, fairly).. plus the kernel fix implementation
for the corner case of the largely 'non-atomic write' encompassed
by a direct IO read operation, is relatively simple; and it helps.

Reproducer:
==========

@ test.c (simplified, but works)

	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <stdio.h>
	#include <unistd.h>
	#include <sys/mman.h>

	int main() {
		int fd, i;
		char *buf;

		fd = open(DEV, O_RDONLY | O_DIRECT);

		buf = mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
                	   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

		for (i = 0; i < BUF_SIZE; i += PAGE_SIZE)
			buf[i] = 1; // init to non-zero

		madvise(buf, BUF_SIZE, MADV_FREE);

		read(fd, buf, BUF_SIZE);

		for (i = 0; i < BUF_SIZE; i += PAGE_SIZE)
			printf("%p: 0x%x\n", &buf[i], buf[i]);

		return 0;
	}

@ block/fops.c (formerly fs/block_dev.c)

	+#include <linux/swap.h>
	...
	... __blkdev_direct_IO[_simple](...)
	{
	...
	+	if (!strcmp(current->comm, "good"))
	+		shrink_all_memory(ULONG_MAX);
	+
         	ret = bio_iov_iter_get_pages(...);
	+
	+	if (!strcmp(current->comm, "bad"))
	+		shrink_all_memory(ULONG_MAX);
	...
	}

@ shell

        # NUM_PAGES=4
        # PAGE_SIZE=$(getconf PAGE_SIZE)

        # yes | dd of=test.img bs=${PAGE_SIZE} count=${NUM_PAGES}
        # DEV=$(losetup -f --show test.img)

        # gcc -DDEV=\"$DEV\" \
              -DBUF_SIZE=$((PAGE_SIZE * NUM_PAGES)) \
              -DPAGE_SIZE=${PAGE_SIZE} \
               test.c -o test

        # od -tx1 $DEV
        0000000 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a
        *
        0040000

        # mv test good
        # ./good
        0x7f7c10418000: 0x79
        0x7f7c10419000: 0x79
        0x7f7c1041a000: 0x79
        0x7f7c1041b000: 0x79

        # mv good bad
        # ./bad
        0x7fa1b8050000: 0x0
        0x7fa1b8051000: 0x0
        0x7fa1b8052000: 0x0
        0x7fa1b8053000: 0x0

Note: the issue is consistent on v5.17-rc3, but it's intermittent
with the support of MADV_FREE on v4.5 (60%-70% error; needs swap).
[wrap do_direct_IO() in do_blockdev_direct_IO() @ fs/direct-io.c].

- v5.17-rc3:

        # for i in {1..1000}; do ./good; done \
            | cut -d: -f2 | sort | uniq -c
           4000  0x79

        # mv good bad
        # for i in {1..1000}; do ./bad; done \
            | cut -d: -f2 | sort | uniq -c
           4000  0x0

        # free | grep Swap
        Swap:             0           0           0

- v4.5:

        # for i in {1..1000}; do ./good; done \
            | cut -d: -f2 | sort | uniq -c
           4000  0x79

        # mv good bad
        # for i in {1..1000}; do ./bad; done \
            | cut -d: -f2 | sort | uniq -c
           2702  0x0
           1298  0x79

        # swapoff -av
        swapoff /swap

        # for i in {1..1000}; do ./bad; done \
            | cut -d: -f2 | sort | uniq -c
           4000  0x79

Ceph/TCMalloc:
=============

For documentation purposes, the use case driving the analysis/fix
is Ceph on Ubuntu 18.04, as the TCMalloc library there still uses
MADV_FREE to release unused memory to the system from the mmap'ed
page heap (might be committed back/used again; it's not munmap'ed.)
- PageHeap::DecommitSpan() -> TCMalloc_SystemRelease() -> madvise()
- PageHeap::CommitSpan() -> TCMalloc_SystemCommit() -> do nothing.

Note: TCMalloc switched back to MADV_DONTNEED a few commits after
the release in Ubuntu 18.04 (google-perftools/gperftools 2.5), so
the issue just 'disappeared' on Ceph on later Ubuntu releases but
is still present in the kernel, and can be hit by other use cases.

The observed issue seems to be the old Ceph bug #22464 [1], where
checksum mismatches are observed (and instrumentation with buffer
dumps shows zero-pages read from mmap'ed/MADV_FREE'd page ranges).

The issue in Ceph was reasonably deemed a kernel bug (comment #50)
and mostly worked around with a retry mechanism, but other parts
of Ceph could still hit that (rocksdb). Anyway, it's less likely
to be hit again as TCMalloc switched out of MADV_FREE by default.

(Some kernel versions/reports from the Ceph bug, and relation with
the MADV_FREE introduction/changes; TCMalloc versions not checked.)
- 4.4 good
- 4.5 (madv_free: introduction)
- 4.9 bad
- 4.10 good? maybe a swapless system
- 4.12 (madv_free: no longer free instantly on swapless systems)
- 4.13 bad

[1] https://tracker.ceph.com/issues/22464

Thanks:
======

Several people contributed to analysis/discussions/tests/reproducers
in the first stages when drilling down on ceph/tcmalloc/linux kernel:

- Dan Hill <daniel.hill@canonical.com>
- Dan Streetman <dan.streetman@canonical.com>
- Dongdong Tao <dongdong.tao@canonical.com>
- Gavin Guo <gavin.guo@canonical.com>
- Gerald Yang <gerald.yang@canonical.com>
- Heitor Alves de Siqueira <halves@canonical.com>
- Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
- Jay Vosburgh <jay.vosburgh@canonical.com>
- Matthew Ruffell <matthew.ruffell@canonical.com>
- Ponnuvel Palaniyappan <ponnuvel.palaniyappan@canonical.com>

Reviews, suggestions, corrections, comments:

- Minchan Kim <minchan@kernel.org>
- Yu Zhao <yuzhao@google.com>
- Huang, Ying <ying.huang@intel.com>
- John Hubbard <jhubbard@nvidia.com>
- Christoph Hellwig <hch@infradead.org>

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
v4: - fixed Fixes: tag to first support, after tests on v4.5;
      updated commit message/reproducer section with results.
    - tested on v5.17-rc3 and v4.5.
    - shorten comment line; remove inner braces in the check.
      (Thanks: Christoph Hellwig <hch@infradead.org>)
    - clarify comment about __remove_mapping()
      (Thanks: Yu Zhao <yuzhao@google.com>)

v3: - add full memory barrier to sync against GUP fast path;
      update comments. (Thanks: Yu Zhao <yuzhao@google.com>)
    - add Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
      (no significant changes from v2).
    - add Fixes: tag.
    - minor changes/corrections to the commit message.
    - tested on v5.17-rc2.

v2: - check refcount against mapcount rather than a static 2.
      (Thanks: Minchan Kim <minchan@kernel.org>)

 mm/rmap.c   | 25 ++++++++++++++++++++++++-
 mm/vmscan.c |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..6e25737dcd27 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 
 			/* MADV_FREE page check */
 			if (!PageSwapBacked(page)) {
-				if (!PageDirty(page)) {
+				int ref_count, map_count;
+
+				/*
+				 * Synchronize with gup_pte_range():
+				 * - clear PTE; barrier; read refcount
+				 * - inc refcount; barrier; read PTE
+				 */
+				smp_mb();
+
+				ref_count = page_count(page);
+				map_count = page_mapcount(page);
+
+				/*
+				 * Order reads for page refcount and dirty flag
+				 * (see comments in __remove_mapping()).
+				 */
+				smp_rmb();
+
+				/*
+				 * The only page refs must be one from isolation
+				 * plus the rmap(s) (dropped by discard:).
+				 */
+				if (ref_count == 1 + map_count &&
+				    !PageDirty(page)) {
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..0dbfa3a69567 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1729,7 +1729,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				mapping = page_mapping(page);
 			}
 		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
+			/* Split file/lazyfree THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
-- 
2.32.0

