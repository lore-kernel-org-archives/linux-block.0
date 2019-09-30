Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00096C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 01:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D4218DE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 01:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfI3BBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:01:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37825 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726390AbfI3BBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Sep 2019 21:01:50 -0400
Received: (qmail 7255 invoked by uid 500); 29 Sep 2019 21:01:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Sep 2019 21:01:48 -0400
Date:   Sun, 29 Sep 2019 21:01:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
In-Reply-To: <20190929201332.GA3099@lazy.lzy>
Message-ID: <Pine.LNX.4.44L0.1909292056230.5908-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 29 Sep 2019, Piergiorgio Sartor wrote:

> On Wed, Sep 25, 2019 at 02:31:58PM -0400, Alan Stern wrote:
> > On Wed, 25 Sep 2019, Piergiorgio Sartor wrote:
> > 
> > > On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> > > > On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> > > > > On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > > > > > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > > > > > Let's bring this to the attention of some more people.
> > > > > > > 
> > > > > > > It looks like the bug that was supposed to be fixed by commit
> > > > > > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > > > > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> > > > > > > the bug still occurs.
> > > > > > 
> > > > > > Piergiorgio,
> > > > > > 
> > > > > > can you dump the content of max_hw_sectors_kb file for your USB storage
> > > > > > device and send that to this thread?
> > > > > 
> > > > > Hi all,
> > > > > 
> > > > > for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> > > > > the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> > > > > for USB storage devices (2.0 and 3.0).
> > > > > 
> > > > > This is for the PC showing the issue.
> > > > > 
> > > > > In an other PC, which does not show the issus at the moment,
> > > > > the values are 120, for USB2.0, and 256, for USB3.0.

> > One thing you can try is git bisect from 5.1.20 (or maybe just 5.1.0)  
> > to 5.2.8.  If you can identify a particular commit which caused the
> > problem to start, that would help.
> 
> OK, I tried a bisect (2 days compilations...).
> Assuming I've done everything correctly (how to
> test this? How to remove the guilty patch?), this
> was the result:
> 
> 09324d32d2a0843e66652a087da6f77924358e62 is the first bad commit
> commit 09324d32d2a0843e66652a087da6f77924358e62
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue May 21 09:01:41 2019 +0200
> 
>     block: force an unlimited segment size on queues with a virt boundary
> 
>     We currently fail to update the front/back segment size in the bio when
>     deciding to allow an otherwise gappy segement to a device with a
>     virt boundary.  The reason why this did not cause problems is that
>     devices with a virt boundary fundamentally don't use segments as we
>     know it and thus don't care.  Make that assumption formal by forcing
>     an unlimited segement size in this case.
> 
>     Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Ming Lei <ming.lei@redhat.com>
>     Reviewed-by: Hannes Reinecke <hare@suse.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> :040000 040000 57ba04a02f948022c0f6ba24bfa36f3b565b2440 8c925f71ce75042529c001bf244b30565d19ebf3 M      block
> 
> What to do now?

Here's how to verify that the bisection got a correct result.  First, 
do a git checkout of commit 09324d32d2a0, build the kernel, and make 
sure that it exhibits the problem.

Next, have git write out the contents of that commit in the form of a
patch (git show commit-id >patchfile), and revert it (git apply -R
patchfile).  Build the kernel from that tree, and make sure that it
does not exhibit the problem.  If it doesn't, you have definitely shown
that this commit is the cause (or at least, is _one_ of the causes).

Alan Stern

