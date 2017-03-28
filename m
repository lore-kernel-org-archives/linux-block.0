Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753838AbdC1GdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:33:23 -0400
Date: Mon, 27 Mar 2017 23:33:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: convert remaining drivers which share a
 request queue
Message-ID: <20170328063319.GB11751@infradead.org>
References: <cover.1490681910.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 11:28:41PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is clearly the pinnacle of my career: converting all remaining
> block drivers which share a request queue across gendisks to use a
> separate request queue per gendisk. These are all compile tested (but
> the last two platform-specific ones involved hacking the Kconfig and
> commenting out a bunch of arch-dependent code to get the rest to
> compile), no runtime testing at all.
> 
> Let me know if I missed any. Even better, let me know if we can just
> delete some of these entirely.

Weren't the floppy drivers the prime example of shared request queue?
I haven't looked at any of them for a while, so I'm not sure if that's
still the case.
