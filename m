Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34256 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbcH2Xtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 19:49:33 -0400
Date: Mon, 29 Aug 2016 19:49:29 -0400
From: Tejun Heo <tj@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Rabin Vincent <rabin@rab.in>, Jens Axboe <axboe@fb.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] bdev: fix NULL pointer dereference in sync()/close() race
Message-ID: <20160829234929.GJ28713@mtj.duckdns.org>
References: <20160827070728.12432-1-vegard.nossum@oracle.com>
 <20160827090328.GA9457@dator>
 <a4a122ba-ed36-f890-56c3-96d1660378a4@oracle.com>
 <20160829195540.GE28713@mtj.duckdns.org>
 <14b09a61-8e8f-166d-45b9-7dd07922286e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14b09a61-8e8f-166d-45b9-7dd07922286e@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Aug 29, 2016 at 11:33:41PM +0200, Vegard Nossum wrote:
> On 08/29/2016 09:55 PM, Tejun Heo wrote:
> > I think the right thing to do there is doing blkdev_get() /
> > blkdev_put() around func() invocation in iterate_bdevs() rather than
> > holding bd_mutex across the callback.  Can you please verify whether
> > that works?
> 
> Didn't work for me, I kept getting use-after-free in __blkdev_get() on
> bdev->bd_invalidated after it calls bdev->bd_disk->fops->open(). I tried
> a few related things without much luck.

I see.  It could be that it's doing blkdev_get() on a dying device.

> The only thing that worked for me without holding the mutex across the
> call was this:
...
> +		mutex_lock(&bdev->bd_mutex);
> +		bdev->bd_openers++;
> +		bdev->bd_holders++;
> +		mutex_unlock(&bdev->bd_mutex);
> +
> +		func(bdev, arg);
> +
> +		mutex_lock(&bdev->bd_mutex);
> +		bdev->bd_openers--;
> +		bdev->bd_holders--;
> +		mutex_unlock(&bdev->bd_mutex);

And this might not be too far fetched.  I think what we want is

* Bump bd_openers if there are other users already; otherwise, skip.

* blkdev_put() after the callback is finished.

Thanks.

-- 
tejun
