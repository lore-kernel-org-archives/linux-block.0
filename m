Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32773 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755524AbcH2Uyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 16:54:43 -0400
Date: Mon, 29 Aug 2016 16:54:39 -0400
From: Tejun Heo <tj@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Rabin Vincent <rabin@rab.in>, Jens Axboe <axboe@fb.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] bdev: fix NULL pointer dereference in sync()/close() race
Message-ID: <20160829205439.GG28713@mtj.duckdns.org>
References: <20160827070728.12432-1-vegard.nossum@oracle.com>
 <20160827090328.GA9457@dator>
 <a4a122ba-ed36-f890-56c3-96d1660378a4@oracle.com>
 <20160829195540.GE28713@mtj.duckdns.org>
 <5c8ff17a-27ba-0987-401d-9eeeb66b52f2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c8ff17a-27ba-0987-401d-9eeeb66b52f2@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Aug 29, 2016 at 10:49:57PM +0200, Vegard Nossum wrote:
> That didn't work at all. I guess bd_acquire() would just do a bdgrab()
> and not touch ->bd_holders, whereas blkdev_get() would increment

Yeah, bdev has two different refs - one for bdev struct itself and the
other for the actual accessors.

> bd_holders and therefore prevent __blkdev_put() from freeing the block
> device? Too confusing...

I think you'll need to do the actual blkdev_get or one of its
variants.

Thanks.

-- 
tejun
