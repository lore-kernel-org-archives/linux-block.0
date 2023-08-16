Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EBC25B4F
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbjHPU1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjHPU12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 16:27:28 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7723B268F
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 13:27:27 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58d41109351so3448397b3.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692217646; x=1692822446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6nAd4B+hY09XKdSdHx5sCH4iOSgPQT2h6trGlM+vNA=;
        b=dveIXLQA89ZUWYHabJVtI3oEEzpIr9fV/lirVBfekKiFOXn1lGgA2uPGEcOlkOZjBD
         a1aBpoGF8QaJMHqlLM0UKvL9kaKpzS6zyOvmB6Zbc1eS7EEJ6VlfQkXyzLpNQhfG3OEw
         eCGtvZNYLyrmkoj5+tJuw3HMFHCP3sqPuk8fbd3spP0mYw93n9H7+8N80JmbfIs4qiXv
         pYw7bvDGtSSGmN6GSey1TNwmTvBJC5JMT671NM0B4mgv/BXoWeH/4YzxKbh3yB570fS0
         aJREuoDn9t0m4s+z3u9TOwbz2TQ5vLr7L5z9o4q0UsNVHdnnboFQwrHaMLNNgfIPCdb7
         au3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217646; x=1692822446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6nAd4B+hY09XKdSdHx5sCH4iOSgPQT2h6trGlM+vNA=;
        b=NiEw46kIg4hWmKyrZvYn1SHN9w1wnmhxZi0o5ZFO84b7C8b607S978GBizkLWU4TPy
         oYU4xG5KkKHFiF6K8NhYyKvKvFsD/3UH3vau4PpAag0v+p86aSoDWnYgyPYLX24DVnWb
         G0sPblog5mh+fuCqTYN2q4Neax1uJzxH6tj6ZkJpqL3aI9xdwNZYT7kVTtIpCZryhBJt
         dHlMB6hBZaUiKr5i07SuSyLdBRzG0s8AiJ+HYGlVE5RJLkyjvArx2S0GlmvlEmlqerB5
         qbnByDU07mj9LDA3p3GALyG8cUwJ0578WFDfZaL908ZEIIJmSQTWYRjPegAhGYZ8Hke0
         Da8Q==
X-Gm-Message-State: AOJu0YynsVeZxgqq4NN26Fsa7gNprUCZ7y0jFwr+ZEk8/5tZVQKcOUSy
        vOqMIFqHcrlY5uWgmrnUi9w+dw==
X-Google-Smtp-Source: AGHT+IEO5uc8CKDzvfrW8shdjb35Kp27HpuCfrFDLQV5dylLk8ofwbkbKcaFpgjeKtRhrvd/mx2svA==
X-Received: by 2002:a0d:d641:0:b0:56c:e5a3:3e09 with SMTP id y62-20020a0dd641000000b0056ce5a33e09mr850661ywd.15.1692217646555;
        Wed, 16 Aug 2023 13:27:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z16-20020a81c210000000b005463e45458bsm4189762ywc.123.2023.08.16.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:27:25 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:27:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, Hannes Reineke <hare@suse.de>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
Message-ID: <94635da5-ce28-a8fb-84e3-7a9f5240fe6a@google.com>
References: <20230814144100.596749-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

a.k.a "Fix rare user data corruption when using THP" :)

On Mon, 14 Aug 2023, Matthew Wilcox (Oracle) wrote:

> The special casing was originally added in pre-git history; reproducing
> the commit log here:
> 
> > commit a318a92567d77
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Sun Sep 21 01:42:22 2003 -0700
> >
> >     [PATCH] Speed up direct-io hugetlbpage handling
> >
> >     This patch short-circuits all the direct-io page dirtying logic for
> >     higher-order pages.  Without this, we pointlessly bounce BIOs up to
> >     keventd all the time.
> 
> In the last twenty years, compound pages have become used for more than
> just hugetlb.  Rewrite these functions to operate on folios instead
> of pages and remove the special case for hugetlbfs; I don't think
> it's needed any more (and if it is, we can put it back in as a call
> to folio_test_hugetlb()).
> 
> This was found by inspection; as far as I can tell, this bug can lead
> to pages used as the destination of a direct I/O read not being marked
> as dirty.  If those pages are then reclaimed by the MM without being
> dirtied for some other reason, they won't be written out.  Then when
> they're faulted back in, they will not contain the data they should.
> It'll take a pretty unusual setup to produce this problem with several
> races all going the wrong way.
> 
> This problem predates the folio work; it could for example have been
> triggered by mmaping a THP in tmpfs and using that as the target of an
> O_DIRECT read.
> 
> Fixes: 800d8c63b2e98 ("shmem: add huge pages support")

No. It's a good catch, but bug looks specific to the folio work to me.

Almost all shmem pages are dirty from birth, even as soon as they are
brought back from swap; so it is not necessary to re-mark them dirty.

The exceptions are pages allocated to holes when faulted: so you did
get me worried as to whether khugepaged could collapse a pmd-ful of
those into a THP without marking the result as dirty.

But no, in v6.5-rc6 the collapse_file() success path has
	if (is_shmem)
		folio_mark_dirty(folio);
and in v5.10 the same appears as
		if (is_shmem)
			set_page_dirty(new_page);

(IIRC, that or marking pmd dirty was missed from early shmem THP
support, but fairly soon corrected, and backported to stable then.
I have a faint memory of versions which assembled pmd_dirty from
collected pte_dirtys.)

And the !is_shmem case is for CONFIG_READ_ONLY_THP_FOR_FS: writing
into those pages, by direct IO or whatever, is already prohibited.

It's dem dirty (or not dirty) folios dat's the trouble!

Hugh

> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
