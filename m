Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055FBC46CA1
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 22:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjIOWui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjIOWu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 18:50:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C12726
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 15:48:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58dfe2d5b9aso36732037b3.1
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694818136; x=1695422936; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq86mg3eRdpsafcpXL3Gsx54l0Vjtu7ZVdR51WnNflM=;
        b=WrDpy1p6ueZ1/jU1o2pLHVMTh6H1cQLtnEkt0u1n1urkGTgbSYZHmbDBckyxVqdmdc
         1ZBaKCFj4z1Ild10mjXgROKqhb0XFSDFByxAtB/J6uBbMag/Qh6x3BajcOVD43ieIj3k
         JhQsaYGoW0Ehj85ak5SN1dbQzlSTNB9zlJp0sNyq9IstqAG5wRPh9GvXc6h/vjCx2x5J
         fsdTwodyjV/lIJWMKEryQsdyxXpWIAJz0Q9+tiC7FpTqEwFKF7HZSUgXUGuXcbMzT02o
         MRkV6x625X5g2CHd+5CBXvkP9IQublkI8fwikJ888yIxmbbQg7Qu+mPdeWIRW+d9C07S
         P/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818136; x=1695422936;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq86mg3eRdpsafcpXL3Gsx54l0Vjtu7ZVdR51WnNflM=;
        b=BhYD/PB1RYWzOb17hJzbZZEdRFOaXyevfVPv1vKgdgoaPcM2fh4vacDFPgi1ocODe0
         dZzBJGDxzPHptN0rFxw7dm/lJw/kxxBH5hqjwnca6VvX1U0tANjgSiRWz9VfHZLuzs+8
         X9Pm8Iy21zS6ctiSvkXiX2ejWyKrCwTU1weH9rgpD+QVuWbPdmW+Ibd1jt+f7JTYicz5
         V8iQQ2a4asUzTMEGTzvLc8WhRg1/seNw5nq3vzIergMRwFvAWKWTwBM0992PQ+7P4Eqe
         ONRQBUQBI7SAMuR6cyolh8sNx9SWgBxwDl5X79U2GcKi1AJ5DR/l5DuH0eytqERUzubh
         OI6A==
X-Gm-Message-State: AOJu0YwjSkjyzZMKMsYtbYIYlepcpZk0OJXbpcpWrw7UufJ9x9Ny4+fd
        UsThoCSmlZqavjU9TJSlZbexlg==
X-Google-Smtp-Source: AGHT+IGV8EQmN5iciBjKTh6qnafWh9qWiM4wQiJhWZJkGYYDZqNaPa1xjuzUpW3/8KCcC5Nt80/rUQ==
X-Received: by 2002:a81:6c4c:0:b0:56d:4d1e:74ab with SMTP id h73-20020a816c4c000000b0056d4d1e74abmr7022615ywc.23.1694818136008;
        Fri, 15 Sep 2023 15:48:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z13-20020a81a24d000000b0054f9e7fed7asm1092349ywg.137.2023.09.15.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 15:48:54 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:48:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hannes Reineke <hare@suse.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
In-Reply-To: <ZQRoWVntO22VWL8K@casper.infradead.org>
Message-ID: <1fa6119e-6e5-5e8-21d8-571814f6a99e@google.com>
References: <20230814144100.596749-1-willy@infradead.org> <94635da5-ce28-a8fb-84e3-7a9f5240fe6a@google.com> <ZQRoWVntO22VWL8K@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Sep 2023, Matthew Wilcox wrote:
> On Wed, Aug 16, 2023 at 01:27:17PM -0700, Hugh Dickins wrote:
> > > This problem predates the folio work; it could for example have been
> > > triggered by mmaping a THP in tmpfs and using that as the target of an
> > > O_DIRECT read.
> > > 
> > > Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
> > 
> > No. It's a good catch, but bug looks specific to the folio work to me.
> > 
> > Almost all shmem pages are dirty from birth, even as soon as they are
> > brought back from swap; so it is not necessary to re-mark them dirty.
> > 
> > The exceptions are pages allocated to holes when faulted: so you did
> > get me worried as to whether khugepaged could collapse a pmd-ful of
> > those into a THP without marking the result as dirty.
> > 
> > But no, in v6.5-rc6 the collapse_file() success path has
> > 	if (is_shmem)
> > 		folio_mark_dirty(folio);
> > and in v5.10 the same appears as
> > 		if (is_shmem)
> > 			set_page_dirty(new_page);
> > 
> > (IIRC, that or marking pmd dirty was missed from early shmem THP
> > support, but fairly soon corrected, and backported to stable then.
> > I have a faint memory of versions which assembled pmd_dirty from
> > collected pte_dirtys.)
> > 
> > And the !is_shmem case is for CONFIG_READ_ONLY_THP_FOR_FS: writing
> > into those pages, by direct IO or whatever, is already prohibited.
> > 
> > It's dem dirty (or not dirty) folios dat's the trouble!
> 
> Thanks for the correction!  Could it happen with anon THP?
> They're not kept dirty from birth ... are they?

Anon pages, THP or other, are not marked dirty from birth, right.
But nor are they considered for freeing without writeout:
shrink_folio_list() does add_to_swap() on them without considering
dirtiness, and add_to_swap() does an unconditional folio_mark_dirty().
Well, not quite unconditional: it is conditional on allocating swap,
but shrink_folio_list() just reactivates when swap is not allocated.

So, I see no opportunity for data loss there.

When it's read back from swap later on, the folio will be left clean
while it matches swap: I haven't bothered to recheck the latest details
of what happens when it's CoWed, or the swap is deleted, those details
won't matter given the behavior above.  But might there be a direct IO
problem while that anon folio (large or small) remains clean in swapcache,
when reclaim's pageout() might be liable to free it without rewriting?

There ought not to be: get_user_pages()/follow_page_pte() have taken
care of that for many years with the FOLL_TOUCH+FOLL_WRITE
	if (flags & FOLL_TOUCH) {
		if ((flags & FOLL_WRITE) &&
		    !pte_dirty(pte) && !PageDirty(page))
			set_page_dirty(page);
and follow_trans_huge_pmd() dirties the pmd when FOLL_TOUCH+FOLL_WRITE.
I forget why follow_page_pte() prefers to dirty page rather than pte,
but either approach should be good enough to avoid the data loss.

However, I don't see equivalent FOLL_TOUCH+FOLL_WRITE code where
get_user_pages_fast() goes its fast route; nor pin_user_pages_fast()
used by lib/iov_iter.c; and it looks odd that pin_user_pages_remote()
and pin_user_pages_unlocked() use FOLL_TOUCH but pin_user_pages() not.

Problem?  Not particularly for anon or for large, but for any?  Or not
a problem because of final set_page_dirty() or folio_mark_dirty() on
release - only a problem while that PageCompound check remains?

(Of course filesystems hate behind-the-back dirtying for other reasons,
that they may lose the data without proper notice: separate discussion
we'd better not get back into here.)

I've spent much longer trying to answer this than I could afford,
expect no more from me, back to you and GUP+PIN experts.

Hugh
