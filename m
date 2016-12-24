Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35527 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcLXKH7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2016 05:07:59 -0500
Date: Sat, 24 Dec 2016 11:07:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Chris Leech <cleech@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
        iscsi_tcp_segment_done+0x20d/0x2e0
Message-ID: <20161224100756.GA16741@lst.de>
References: <CA+55aFyb1jcdpavyZgZ4nedA0=6tLognyWcJXfOJjMPFTm5GWA@mail.gmail.com> <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org> <20161222051322.GF4758@dastard> <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com> <20161222065012.GI4758@dastard> <20161222185030.so4btkuzzkih3owz@straylight.hirudinean.org> <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com> <20161223000356.dxwkgsei32w7hc4f@straylight.hirudinean.org> <20161223100014.GA29467@lst.de> <CA+55aFxA1LE+4jdR8YXZyRVJ-MpOCUVob=ESBsMPuW=Qb=px-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFxA1LE+4jdR8YXZyRVJ-MpOCUVob=ESBsMPuW=Qb=px-A@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 23, 2016 at 11:42:45AM -0800, Linus Torvalds wrote:
> Ugh. This patch is nasty.

It's the same SCSI has done for ages - except that is uses a separate
kmalloc for the sense buffer.

> I think we should just fix blk_execute_rq() instead.

As you found out below it's not just blk_execute_rq, it's the whole
architecture of the BLOCK_PC code, which expects a caller provided
sense buffer.  But with the way blk-mq allocates request structures
we can actually fix it, but I first need to extent the way it allows
drivers to allocate private data to the old request code.  I've
actually already implemented that for SCSI long time ago, and have
started to life it to the block layer.

Once that is done the callers won't need a sense buffer at all, and
can just look at the driver provided one.  Which currently is missing
in virtio-blk, so we'd need something similar to the above patch
anyway.
