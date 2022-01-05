Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A7C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiAECQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 21:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiAECQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 21:16:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD5C061761
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 18:16:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so155780762edd.8
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 18:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1G6HNKa55RLwCD7LGVOtTxAjXZre5R3pZHN2xGvky/o=;
        b=OremXFtNneXeQsj09XJDz4RDB+OPwoNznT4G6QCdXTfjSXCsLP81XN6SclYfZ803cp
         yBta5IkTYN3+i7RJS+1g72gbudHgNaKqKL+pcQ/a+ETLQ/0AMscjybfAbAcbGa5hnjRh
         v/oWlAFqn+0k6VneTM54gv4I/R5D/xAxL4c3imEBgjkOTTL+NRKXsyuEv7Br7acidJGq
         hnv8sTPXomsP+SPTpnVN6DaXoAUvvPRfGLE4vd4+oCe3G+kZrEZW9tgMZHBZSa2F5cm7
         A1qOy6nNkeEOpqgqm1t5cDvxIi6oOhplQvwYlOFWOv6VHOuLDD8sUCxA/oRuYK2uuxy+
         7bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1G6HNKa55RLwCD7LGVOtTxAjXZre5R3pZHN2xGvky/o=;
        b=cBkRlS1EiQyG1YlE5dDNnT20Zt+BBvaMxs9nRzZ3XrdzEAiOzlLF9/h7h6svNo3qqZ
         tMO9qjQRtp5CsoWBZEBeR8FA+8zltNn1PbfClp7iccMyZhRRvKfkRGv+5MSVZqXD7C8o
         NPilLQuE5cTsE/4seMk7D+5TUuqRQ5TXrj3vV6rvxkkEKQrEQjZEG9vUmz8iMBNDbdjQ
         02/yct3shCa1hC9MmKpoDuiXppXi8e7Y8ouuEdVmW5PLGrs0+8Sm/vlsvfkf6Uge0WGw
         nchOQx7J7vCXxHIz81hM/evuVxKJEQlqtzw0mREM1NIjrlJ0KN5Gc2IKFvympCx/EmU/
         k5PA==
X-Gm-Message-State: AOAM533j8lspjB68OFrGWtw+S9K14c2+jCQk0HGCCQNOd2dYjxRbi+bn
        i52/kc0FxoHM2Ow05l81PWEVFGrgAuAfkHji9R4=
X-Google-Smtp-Source: ABdhPJwHwa8xoncaSi2kjY+vzI5E1UpiD0v4jUhlvIYuD5+V3zY1Pi532N3OJLRbpTlo5DOJTH0NXFnoQ3onp+keOI4=
X-Received: by 2002:a17:907:6ea6:: with SMTP id sh38mr40006598ejc.644.1641348990689;
 Tue, 04 Jan 2022 18:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20211211022115.1547617-1-mfo@canonical.com> <CAHbLzkoZXHQ2WuuQGafuo0YV_KOML91g2ZkDjyzw_J7E40yVsA@mail.gmail.com>
 <878rvv58ej.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkpStYwMVz+KBGUZOF4C6iKwyPNLjCjUzJgjo4tt=X9LAA@mail.gmail.com>
 <874k6j556q.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874k6j556q.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 4 Jan 2022 18:16:18 -0800
Message-ID: <CAHbLzkrPDEwouAEz76_rXqPXhWFRFLgKgEQVEo0kA4ajV2KN8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 4, 2022 at 5:42 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Tue, Jan 4, 2022 at 4:32 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >> > On Fri, Dec 10, 2021 at 6:22 PM Mauricio Faria de Oliveira
> >> > <mfo@canonical.com> wrote:
> >> >>
> >> >> Problem:
> >> >> =======
> >> >>
> >> >> Userspace might read the zero-page instead of actual data from a
> >> >> direct IO read on a block device if the buffers have been called
> >> >> madvise(MADV_FREE) on earlier (this is discussed below) due to a
> >> >> race between page reclaim on MADV_FREE and blkdev direct IO read.
> >> >>
> >> >> Race condition:
> >> >> ==============
> >> >>
> >> >> During page reclaim, the MADV_FREE page check in try_to_unmap_one()
> >> >> checks if the page is not dirty, then discards its PTE (vs remap it
> >> >> back if the page is dirty).
> >> >>
> >> >> However, after try_to_unmap_one() returns to shrink_page_list(), it
> >> >> might keep the page _anyway_ if page_ref_freeze() fails (it expects
> >> >> a single page ref from the isolation).
> >> >>
> >> >> Well, blkdev_direct_IO() gets references for all pages, and on READ
> >> >> operations it sets them dirty later.
> >> >>
> >> >> So, if MADV_FREE pages (i.e., not dirty) are used as buffers (more
> >> >> later) for direct IO read from block devices and page reclaim runs
> >> >> during __blkdev_direct_IO[_simple]() AFTER bio_iov_iter_get_pages()
> >> >> but BEFORE it sets pages dirty, that situation happens.
> >> >>
> >> >> The direct IO read eventually completes. Now, when userspace reads
> >> >> the buffers, the PTE is no longer there and the page fault handler
> >> >> do_anonymous_page() services that with the zero-page, NOT the data!
> >> >>
> >> >> A synthetic reproducer is provided.
> >> >>
> >> >> Page faults:
> >> >> ===========
> >> >>
> >> >> The data read from the block device probably won't generate faults
> >> >> due to DMA (no MMU) but even in the case it wouldn't use DMA, that
> >> >> happens on different virtual addresses (not user-mapped addresses)
> >> >> because `struct bio_vec` stores `struct page` to figure addresses
> >> >> out (which are different from/unrelated to user-mapped addresses)
> >> >> for the data read.
> >> >>
> >> >> Thus userspace reads (to user-mapped addresses) still fault, then
> >> >> do_anonymous_page() gets another `struct page` that would address/
> >> >> map to other memory than the `struct page` used by `struct bio_vec`
> >> >> for the read (which runs correctly as the page wasn't freed due to
> >> >> page_ref_freeze(), and is reclaimed later) -- but even if the page
> >> >> addresses matched, that handler maps the zero-page in the PTE, not
> >> >> that page's memory (on read faults.)
> >> >>
> >> >> If page reclaim happens BEFORE bio_iov_iter_get_pages() the issue
> >> >> doesn't happen, because that faults-in all pages as writeable, so
> >> >> do_anonymous_page() sets up a new page/rmap/PTE, and that is used
> >> >> by direct IO. The userspace reads don't fault as the PTE is there
> >> >> (thus zero-page is not used.)
> >> >>
> >> >> Solution:
> >> >> ========
> >> >>
> >> >> One solution is to check for the expected page reference count in
> >> >> try_to_unmap_one() too, which should be exactly two: one from the
> >> >> isolation (checked by shrink_page_list()), and the other from the
> >> >> rmap (dropped by the discard: label). If that doesn't match, then
> >> >> remap the PTE back, just like page dirty does.
> >> >>
> >> >> The new check in try_to_unmap_one() should be safe in races with
> >> >> bio_iov_iter_get_pages() in get_user_pages() fast and slow paths,
> >> >> as it's done under the PTE lock. The fast path doesn't take that
> >> >> lock but it checks the PTE has changed, then drops the reference
> >> >> and leaves the page for the slow path (which does take that lock).
> >> >>
> >> >> - try_to_unmap_one()
> >> >>   - page_vma_mapped_walk()
> >> >>     - map_pte() # see pte_offset_map_lock():
> >> >>         pte_offset_map()
> >> >>         spin_lock()
> >> >>   - page_ref_count() # new check
> >> >>   - page_vma_mapped_walk_done() # see pte_unmap_unlock():
> >> >>       pte_unmap()
> >> >>       spin_unlock()
> >> >>
> >> >> - bio_iov_iter_get_pages()
> >> >>   - __bio_iov_iter_get_pages()
> >> >>     - iov_iter_get_pages()
> >> >>       - get_user_pages_fast()
> >> >>         - internal_get_user_pages_fast()
> >> >>
> >> >>           # fast path
> >> >>           - lockless_pages_from_mm()
> >> >>             - gup_{pgd,p4d,pud,pmd,pte}_range()
> >> >>                 ptep = pte_offset_map() # not _lock()
> >> >>                 pte = ptep_get_lockless(ptep)
> >> >>                 page = pte_page(pte)
> >> >>                 try_grab_compound_head(page) # get ref
> >> >>                 if (pte_val(pte) != pte_val(*ptep))
> >> >>                         put_compound_head(page) # put ref
> >> >>                         # leave page for slow path
> >> >>           # slow path
> >> >>           - __gup_longterm_unlocked()
> >> >>             - get_user_pages_unlocked()
> >> >>               - __get_user_pages_locked()
> >> >>                 - __get_user_pages()
> >> >>                   - follow_{page,p4d,pud,pmd}_mask()
> >> >>                     - follow_page_pte()
> >> >>                         ptep = pte_offset_map_lock()
> >> >>                         pte = *ptep
> >> >>                         page = vm_normal_page(pte)
> >> >>                         try_grab_page(page) # get ref
> >> >>                         pte_unmap_unlock()
> >> >>
> >> >> Regarding transparent hugepages, that number shouldn't change, as
> >> >> MADV_FREE (aka lazyfree) pages are PageAnon() && !PageSwapBacked()
> >> >> (madvise_free_pte_range() -> mark_page_lazyfree() -> lru_lazyfree_fn())
> >> >> thus should reach shrink_page_list() -> split_huge_page_to_list()
> >> >> before try_to_unmap[_one](), so it deals with normal pages only.
> >> >>
> >> >> (And in case unlikely/TTU_SPLIT_HUGE_PMD/split_huge_pmd_address()
> >> >> happens, which it should not or be rare, the page refcount is not
> >> >> two, as the head page counts tail pages, and tail pages have zero.
> >> >> That also prevents checking the head `page` then incorrectly call
> >> >> page_remove_rmap(subpage) for a tail page, that isn't even in the
> >> >> shrink_page_list()'s page_list (an effect of split huge pmd/pmvw),
> >> >> as it might happen today in this unlikely scenario.)
> >> >>
> >> >> MADV_FREE'd buffers:
> >> >> ===================
> >> >>
> >> >> So, back to the "if MADV_FREE pages are used as buffers" note.
> >> >> The case is arguable, and subject to multiple interpretations.
> >> >>
> >> >> The madvise(2) manual page on the MADV_FREE advice value says:
> >> >> - 'After a successful MADV_FREE ... data will be lost when
> >> >>    the kernel frees the pages.'
> >> >> - 'the free operation will be canceled if the caller writes
> >> >>    into the page' / 'subsequent writes ... will succeed and
> >> >>    then [the] kernel cannot free those dirtied pages'
> >> >> - 'If there is no subsequent write, the kernel can free the
> >> >>    pages at any time.'
> >> >>
> >> >> Thoughts, questions, considerations...
> >> >> - Since the kernel didn't actually free the page (page_ref_freeze()
> >> >>   failed), should the data not have been lost? (on userspace read.)
> >> >> - Should writes performed by the direct IO read be able to cancel
> >> >>   the free operation?
> >> >>   - Should the direct IO read be considered as 'the caller' too,
> >> >>     as it's been requested by 'the caller'?
> >> >>   - Should the bio technique to dirty pages on return to userspace
> >> >>     (bio_check_pages_dirty() is called/used by __blkdev_direct_IO())
> >> >>     be considered in another/special way here?
> >> >> - Should an upcoming write from a previously requested direct IO
> >> >>   read be considered as a subsequent write, so the kernel should
> >> >>   not free the pages? (as it's known at the time of page reclaim.)
> >> >>
> >> >> Technically, the last point would seem a reasonable consideration
> >> >> and balance, as the madvise(2) manual page apparently (and fairly)
> >> >> seem to assume that 'writes' are memory access from the userspace
> >> >> process (not explicitly considering writes from the kernel or its
> >> >> corner cases; again, fairly).. plus the kernel fix implementation
> >> >> for the corner case of the largely 'non-atomic write' encompassed
> >> >> by a direct IO read operation, is relatively simple; and it helps.
> >> >>
> >> >> Reproducer:
> >> >> ==========
> >> >>
> >> >> @ test.c (simplified, but works)
> >> >>
> >> >>         #define _GNU_SOURCE
> >> >>         #include <fcntl.h>
> >> >>         #include <stdio.h>
> >> >>         #include <unistd.h>
> >> >>         #include <sys/mman.h>
> >> >>
> >> >>         int main() {
> >> >>                 int fd, i;
> >> >>                 char *buf;
> >> >>
> >> >>                 fd = open(DEV, O_RDONLY | O_DIRECT);
> >> >>
> >> >>                 buf = mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
> >> >>                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >> >>
> >> >>                 for (i = 0; i < BUF_SIZE; i += PAGE_SIZE)
> >> >>                         buf[i] = 1; // init to non-zero
> >> >>
> >> >>                 madvise(buf, BUF_SIZE, MADV_FREE);
> >> >
> >> > IIUC, you are expecting to get the old data after MADV_FREE? TBH, you
> >> > should not expect so at all after MADV_FREE since those pages may get
> >> > freed at any time.
> >> >
> >>
> >> Per my understanding, if direct IO reading is done after MADV_FREE, I
> >> think we want to get the new data instead of old data.
> >
> > Here "old data" means the data written by "buf[i] = 1;" before
> > MADV_FREE in that test code.
>
> OK.  I found that the expected data isn't "1", but "0x79", which is read
> from disk image after MADV_FREE.  Re-paste as below,

Err, sorry for the confusion. Yes, the "old data" means the data on
disk. "buf[i] = 1" should be used to allocate pages for the buffer in
that test code IIUC. Just came back from holiday, need to refresh my
brain :-(

>
>         # mv test good
>         # ./good
>         0x7f1509206000: 0x79
>         0x7f1509207000: 0x79
>         0x7f1509208000: 0x79
>         0x7f1509209000: 0x79
>
> Best Regards,
> Huang, Ying
