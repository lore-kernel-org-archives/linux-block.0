Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdLEFa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Dec 2017 00:30:29 -0500
Date: Mon, 4 Dec 2017 21:30:23 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, jack@suse.cz, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, npiggin@gmail.com,
        rgoldwyn@suse.com, vbabka@suse.cz, mhocko@suse.com,
        pombredanne@nexb.com, vinmenon@codeaurora.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 0/4] lockdep/crossrelease: Apply crossrelease to page
 locks
Message-ID: <20171205053023.GB20757@bombadil.infradead.org>
References: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 04, 2017 at 02:16:19PM +0900, Byungchul Park wrote:
> For now, wait_for_completion() / complete() works with lockdep, add
> lock_page() / unlock_page() and its family to lockdep support.
> 
> Changes from v1
>  - Move lockdep_map_cross outside of page_ext to make it flexible
>  - Prevent allocating lockdep_map per page by default
>  - Add a boot parameter allowing the allocation for debugging
> 
> Byungchul Park (4):
>   lockdep: Apply crossrelease to PG_locked locks
>   lockdep: Apply lock_acquire(release) on __Set(__Clear)PageLocked
>   lockdep: Move data of CONFIG_LOCKDEP_PAGELOCK from page to page_ext
>   lockdep: Add a boot parameter enabling to track page locks using
>     lockdep and disable it by default

I don't like the way you've structured this patch series; first adding
the lockdep map to struct page, then moving it to page_ext.

I also don't like it that you've made CONFIG_LOCKDEP_PAGELOCK not
individually selectable.  I might well want a kernel with crosslock
support, but only for completions.
