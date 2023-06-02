Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172CC7EE29
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjFBPlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 11:41:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454BB3
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 08:41:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E35F68AA6; Fri,  2 Jun 2023 17:41:30 +0200 (CEST)
Date:   Fri, 2 Jun 2023 17:41:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: fail writes to read-only devices
Message-ID: <20230602154130.GA26710@lst.de>
References: <20230601072829.1258286-1-hch@lst.de> <20230601072829.1258286-4-hch@lst.de> <CAHk-=wj3TrM-NWUcFUivefNwzbfGdfcgDGfGP12m6WBfH9JpWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3TrM-NWUcFUivefNwzbfGdfcgDGfGP12m6WBfH9JpWg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[quoting your reply out of order, because I think it makes sense that
 way]

On Thu, Jun 01, 2023 at 09:02:25PM -0400, Linus Torvalds wrote:
> So honestly, that whole test for
> 
> +       if (op_is_write(bio_op(bio)) && bio_sectors(bio) &&
> +           bdev_read_only(bdev)) {
> 
> may look "obviously correct", but it's also equally valid to view it
> as "obviously garbage", simply because the test is being done at the
> wrong point.
> 
> The same way you can write to a file that was opened for writing, but
> has then become read-only afterwards, writing to a device with a bdev
> that was writable when you *started* writing is not at all necessarily
> wrong.

files, or more specifically file descriptors really are the wrong
analogy here.  A file descriptor allows you to keep writing to
a file that you were allowed to write to at open time.  And that's
fine (at least most of the time, people keep wanting a revoke and
keep implementing broken special cases of it, but I disgress).

The struct block_device is not such a handle, it's the underlying
object.  And the equivalent here is that we allow writes to inodes
that don't even implement a write method, or have the immutable
bit set.

> The logic wrt "bdev_read_only()" is not necessarily a "right now it's
> read-only", but more of a thing that should be checked purely when the
> device is opened. Which is pretty much exactly what we do.

Except the whole make a thing readonly just for fun is the corner case.
DM does it, and we have a sysfs file to allow it.  But the usual
case is that a block device has been read-only all the time, or has
been force to be read-only by the actual storage device, which
doesn't know anything about the file descriptor model, and will
not be happy.

So maybe a lazy read-only after the last writer goes away would be
nice (not that we actully track writers right now, but that whole
area is comletely fucked up and I'm looking into fixing it at the
moment).

And for extra fun blkdev_get_by_dev doesn't check for read-only
because we've historically allowed to open writable file descriptors
on read-only block devices for ioctls (in addition to the magic
(flags & O_ACCMODE) == 3 mode just ioctl). 

