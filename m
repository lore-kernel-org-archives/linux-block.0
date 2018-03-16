Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35114 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeCPSQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:16:51 -0400
Received: by mail-qk0-f196.google.com with SMTP id s188so12004169qkb.2
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:16:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 16 Mar 2018 11:16:49 -0700
Message-ID: <CAJ+L6qdOc-8RV5nXDwGzpgWiqrR=kq2170SA3EdZ2CzEjYC5rQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] bcache: Compiler, sparse and smatch fixes
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Bart & everyone,

I'll dig through these.  In the future can you please send things off
the linux-bcache list?  I'm a bit off my normal workflow this way.

Thanks,

Mike

On Thu, Mar 15, 2018 at 8:07 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Hello Michael, Coly and Christoph,
>
> A few weeks ago I analyzed the compiler (W=1), sparse and smatch warnings
> triggered by the bcache driver. This patch series is what I came up with.
> Although none of these patches have been tested I think these patches are
> worth a closer look. Feedback is welcome.
>
> Thanks,
>
> Bart.
>
> Bart Van Assche (16):
>   bcache: Fix indentation
>   bcache: Add __printf annotation to __bch_check_keys()
>   bcache: Annotate switch fall-through
>   bcache: Fix kernel-doc warnings
>   bcache: Remove an unused variable
>   bcache: Suppress more warnings about set-but-not-used variables
>   bcache: Reduce the number of sparse complaints about lock imbalances
>   bcache: Fix a compiler warning in bcache_device_init()
>   bcache: Remove a redundant assignment
>   bcache: Suppress a compiler warning in bch_##name##_h()
>   bcache: Check the d->disk pointer before using it
>   bcache: Make it easier for static analyzers to analyze
>     bch_allocator_thread()
>   bcache: Make bch_dump_read() fail if copying to user space fails
>   bcache: Make csum_set() implementation easier to read
>   bcache: Fix an endianness bug
>   bcache: Fix endianness annotations
>
>  drivers/md/bcache/alloc.c     |   7 +--
>  drivers/md/bcache/bcache.h    |  22 ++++++--
>  drivers/md/bcache/bset.c      |   4 +-
>  drivers/md/bcache/bset.h      |   5 +-
>  drivers/md/bcache/btree.c     |   4 +-
>  drivers/md/bcache/closure.c   |   8 +--
>  drivers/md/bcache/debug.c     |   5 +-
>  drivers/md/bcache/extents.c   |   2 -
>  drivers/md/bcache/journal.c   |   4 +-
>  drivers/md/bcache/request.c   |   1 +
>  drivers/md/bcache/super.c     |  23 ++++----
>  drivers/md/bcache/util.c      |  33 +++++++-----
>  drivers/md/bcache/writeback.h |   2 +-
>  include/uapi/linux/bcache.h   | 118 ++++++++++++++++++++++--------------------
>  14 files changed, 131 insertions(+), 107 deletions(-)
>
> --
> 2.16.2
>
