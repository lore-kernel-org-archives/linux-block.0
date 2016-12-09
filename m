Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLIWBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2016 17:01:04 -0500
Date: Fri, 9 Dec 2016 14:01:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
Message-Id: <20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
In-Reply-To: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu,  8 Dec 2016 02:22:55 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> TL;DR: these patches save 250 KB of memory, with more low-hanging
> fruit ready to pick.
> 
> While browsing through the lib/idr.c code, I noticed that the code at
> the end of ida_get_new_above() probably doesn't work as intended: Most
> users of ida use it via ida_simple_get(), and that starts by
> unconditionally calling ida_pre_get(), ensuring that ida->idr has
> 8==MAX_IDR_FREE idr_layers in its free list id_free. In the common
> case, none (or at most one) of these get used during
> ida_get_new_above(), and we only free one, leaving at least 6 (usually
> 7) idr_layers in the free list.

Please be aware of

http://ozlabs.org/~akpm/mmots/broken-out/reimplement-idr-and-ida-using-the-radix-tree.patch
http://lkml.kernel.org/r/1480369871-5271-68-git-send-email-mawilcox@linuxonhyperv.com

I expect we'll be merging patches 1-32 of that series into 4.10-rc1 and
the above patch (#33) into 4.11-rc1.
