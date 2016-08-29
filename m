Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34894 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755242AbcH2Tzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 15:55:46 -0400
Date: Mon, 29 Aug 2016 15:55:40 -0400
From: Tejun Heo <tj@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Rabin Vincent <rabin@rab.in>, Jens Axboe <axboe@fb.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] bdev: fix NULL pointer dereference in sync()/close() race
Message-ID: <20160829195540.GE28713@mtj.duckdns.org>
References: <20160827070728.12432-1-vegard.nossum@oracle.com>
 <20160827090328.GA9457@dator>
 <a4a122ba-ed36-f890-56c3-96d1660378a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4a122ba-ed36-f890-56c3-96d1660378a4@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Sat, Aug 27, 2016 at 11:30:22AM +0200, Vegard Nossum wrote:
> > Don't know what's the right fix, but I posted a slightly different one
> > for the same crash some months ago:
> > https://patchwork.kernel.org/patch/8556941/
> > 
> 
> Ah, I'm sorry, I didn't see that.
> 
> Your patch is 100% identical to my first attempt at a fix and I can
> confirm that it also fixes the problem for me.
> 
> If people who are more savvy in block/fs code could ack the locking bits
> I think we should apply the patch ASAP because it's an easy local DOS if
> you have (open/read) access to any block device.

I think the right thing to do there is doing blkdev_get() /
blkdev_put() around func() invocation in iterate_bdevs() rather than
holding bd_mutex across the callback.  Can you please verify whether
that works?

Thanks.

-- 
tejun
