Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36245 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbdC1Ge5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:34:57 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so62764603pge.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:34:57 -0700 (PDT)
Date: Mon, 27 Mar 2017 23:33:59 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: convert remaining drivers which share a
 request queue
Message-ID: <20170328063359.GA14159@vader>
References: <cover.1490681910.git.osandov@fb.com>
 <20170328063319.GB11751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170328063319.GB11751@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 11:33:19PM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2017 at 11:28:41PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This is clearly the pinnacle of my career: converting all remaining
> > block drivers which share a request queue across gendisks to use a
> > separate request queue per gendisk. These are all compile tested (but
> > the last two platform-specific ones involved hacking the Kconfig and
> > commenting out a bunch of arch-dependent code to get the rest to
> > compile), no runtime testing at all.
> > 
> > Let me know if I missed any. Even better, let me know if we can just
> > delete some of these entirely.
> 
> Weren't the floppy drivers the prime example of shared request queue?
> I haven't looked at any of them for a while, so I'm not sure if that's
> still the case.


Those have all been fixed up, besides the swim one in this series:

786029ff810f ("amiga floppy: Stop sharing request queue across multiple gendisks")
639e2f2aa76e ("atari floppy: Stop sharing request queue across multiple gendisks")
488211844e0c ("floppy: switch to one queue per drive instead of sharing a queue")
