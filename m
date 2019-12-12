Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E6C00454
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C48E2464B
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576175364;
	bh=pN2pj4aju2pVRKrp/+C58v3IcKaDpQl9YVDd8VndA3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kc0rHx7MCTPLxK3cbP5RbIvVoug3u5LxNRFRMu8+Migo0Wtu8+CO1bBnz+JepRpRo
	 QQGvdT4DsoJy3b6beKsSc7pM4rxMO9V2IzT/4o8K2PwIXyNn9mCqceLegoK1nC1acw
	 nV9ncmwirgXe03eZxELvLx5L+W4o3xvveeQa+b6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfLLS3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:29:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38740 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbfLLS3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 13:29:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so3384929ljh.5
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFYeLe4AYUGFszSVCe9rzGReH5534Kp7HFzyL7IgJoo=;
        b=gaEqyEltnYHeY4bwG67JYh7XhezoYwB/vlBuat5eb9B1wDrnC3gxSKR6wn2/kJ9gaN
         xQV2GF7RBP8bhWsGKKAD6uojhcOpaKl/HoD3iV1ESQk4Ak3DGeXjvNFW7PMlrhdEMozD
         y6r7JlXMbpP8G/nes7/wTMJB8Ait6DP/0iQww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFYeLe4AYUGFszSVCe9rzGReH5534Kp7HFzyL7IgJoo=;
        b=SdDhPo0UIgQYdk2gXItZp7yNCr7N9vxb3314mMfGaLAwUie/ElBj8n7zMLJNWTyCPf
         IdOtJNvLxc8Ue1QYwDC+rug9gGbNGbRUlzIaX2HELHYRxQgJD2FDPzyndmM4HMn0tqN2
         OVphHMHbG4+yRXziLMDNeovfD1SwEIYEnoyWC+wEw8Hn2o2crAWc4eLCvqfzmxZMmfll
         Yi1cmcWnuIAcTe1dd7HmH4kS9Gqpzu53+AHWYZHmrPiFY+YAelI5dbnXDTqr0nJ7P+wM
         agwWRWkZPvkqDd6gt7v3mw3ZighV1zlVLESZIaT8/HR1KSqKOdTVz38KQbI5k7jw1yoK
         kJcA==
X-Gm-Message-State: APjAAAXrENl7QDPbq3tcGKElSC/8uIAoeKKLTNsB8et+vMq15c3FuGQ+
        v735WT0zDjfXoQ73dBXblgaT8ufAwio=
X-Google-Smtp-Source: APXvYqyOu5J9oxpY6tCrxTPP6uxHZ3DSVHSG5jGgEvduqnZ1jovhtZLaCATN2rvwNJE9mrzmCopmlg==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr6964844ljg.198.1576175360460;
        Thu, 12 Dec 2019 10:29:20 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q25sm3487522lji.7.2019.12.12.10.29.19
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:29:19 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 9so2421241lfq.10
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 10:29:19 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr6767957lfj.61.1576175358789;
 Thu, 12 Dec 2019 10:29:18 -0800 (PST)
MIME-Version: 1.0
References: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org> <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
 <20191212175200.GS32169@bombadil.infradead.org>
In-Reply-To: <20191212175200.GS32169@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 10:29:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
Message-ID: <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 9:52 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> 1. We could semi-sort the pages on the LRU list.  If we know we're going
> to remove a bunch of pages, we could take a batch of them off the list,
> sort them and remove them in-order.  This probably wouldn't be terribly
> effective.

I don't think the sorting is relevant.

Once you batch things, you already would get most of the locality
advantage in the cache if it exists (and the batch isn't insanely
large so that one batch already causes cache overflows).

The problem - I suspect - is that we don't batch at all. Or rather,
the "batching" does exist at a high level, but it's so high that
there's just tons of stuff going on between single pages. It is at the
shrink_page_list() level, which is pretty high up and basically does
one page at a time with locking and a lot of tests for each page, and
then we do "__remove_mapping()" (which does some more work) one at a
time before we actually get to __delete_from_page_cache().

So it's "batched", but it's in a huge loop, and even at that huge loop
level the batch size is fairly small. We limit it to SWAP_CLUSTER_MAX,
which is just 32.

Thinking about it, that SWAP_CLUSTER_MAX may make sense in some other
circumstances, but not necessarily in the "shrink clean inactive
pages" thing. I wonder if we could just batch clean pages a _lot_ more
aggressively. Yes, our batching loop is still very big and it might
not help at an L1 level, but it might help in the L2, at least.

In kswapd, when we have 28 GB of pages on the inactive list, a batch
of 32 pages at a time is pretty small ;)

> 2. We could change struct page to point to the xa_node that holds them.
> Looking up the page mapping would be page->xa_node->array and then
> offsetof(i_pages) to get the mapping.

I don't think we have space in 'struct page', and I'm pretty sure we
don't want to grow it. That's one of the more common data structures
in the kernel.

                         Linus
