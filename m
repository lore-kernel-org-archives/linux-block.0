Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27761 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755599AbcH2UvR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 16:51:17 -0400
Subject: Re: [PATCH] bdev: fix NULL pointer dereference in sync()/close() race
To: Tejun Heo <tj@kernel.org>
References: <20160827070728.12432-1-vegard.nossum@oracle.com>
 <20160827090328.GA9457@dator>
 <a4a122ba-ed36-f890-56c3-96d1660378a4@oracle.com>
 <20160829195540.GE28713@mtj.duckdns.org>
Cc: Rabin Vincent <rabin@rab.in>, Jens Axboe <axboe@fb.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <5c8ff17a-27ba-0987-401d-9eeeb66b52f2@oracle.com>
Date: Mon, 29 Aug 2016 22:49:57 +0200
MIME-Version: 1.0
In-Reply-To: <20160829195540.GE28713@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2016 09:55 PM, Tejun Heo wrote:
> Hello,
>
> On Sat, Aug 27, 2016 at 11:30:22AM +0200, Vegard Nossum wrote:
>>> Don't know what's the right fix, but I posted a slightly different one
>>> for the same crash some months ago:
>>> https://patchwork.kernel.org/patch/8556941/
>>>
>>
>> Ah, I'm sorry, I didn't see that.
>>
>> Your patch is 100% identical to my first attempt at a fix and I can
>> confirm that it also fixes the problem for me.
>>
>> If people who are more savvy in block/fs code could ack the locking bits
>> I think we should apply the patch ASAP because it's an easy local DOS if
>> you have (open/read) access to any block device.
>
> I think the right thing to do there is doing blkdev_get() /
> blkdev_put() around func() invocation in iterate_bdevs() rather than
> holding bd_mutex across the callback.  Can you please verify whether
> that works?

Hrmph, I tried this patch first:

     diff --git a/fs/block_dev.c b/fs/block_dev.c
     index e17bdbd..489473d 100644
     --- a/fs/block_dev.c
     +++ b/fs/block_dev.c
     @@ -1884,6 +1884,7 @@ void iterate_bdevs(void (*func)(struct 
block_device *, void *), void *arg)
             spin_lock(&blockdev_superblock->s_inode_list_lock);
             list_for_each_entry(inode, &blockdev_superblock->s_inodes, 
i_sb_list) {
                     struct address_space *mapping = inode->i_mapping;
     +               struct block_device *bdev;

                     spin_lock(&inode->i_lock);
                     if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
     @@ -1905,7 +1906,11 @@ void iterate_bdevs(void (*func)(struct 
block_device *, void *), void *arg)
                     iput(old_inode);
                     old_inode = inode;

     -               func(I_BDEV(inode), arg);
     +               bdev = bd_acquire(inode);
     +               if (bdev) {
     +                       func(bdev, arg);
     +                       bdput(bdev);
     +               }

                     spin_lock(&blockdev_superblock->s_inode_list_lock);
             }

That didn't work at all. I guess bd_acquire() would just do a bdgrab()
and not touch ->bd_holders, whereas blkdev_get() would increment
bd_holders and therefore prevent __blkdev_put() from freeing the block
device? Too confusing...

I'll give your suggestion a try.


Vegard
