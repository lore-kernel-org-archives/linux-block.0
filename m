Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35349 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754874AbcH2Ved (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 17:34:33 -0400
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
Message-ID: <14b09a61-8e8f-166d-45b9-7dd07922286e@oracle.com>
Date: Mon, 29 Aug 2016 23:33:41 +0200
MIME-Version: 1.0
In-Reply-To: <20160829195540.GE28713@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2016 09:55 PM, Tejun Heo wrote:
> On Sat, Aug 27, 2016 at 11:30:22AM +0200, Vegard Nossum wrote:
>> If people who are more savvy in block/fs code could ack the locking bits
>> I think we should apply the patch ASAP because it's an easy local DOS if
>> you have (open/read) access to any block device.
>
> I think the right thing to do there is doing blkdev_get() /
> blkdev_put() around func() invocation in iterate_bdevs() rather than
> holding bd_mutex across the callback.  Can you please verify whether
> that works?

Didn't work for me, I kept getting use-after-free in __blkdev_get() on
bdev->bd_invalidated after it calls bdev->bd_disk->fops->open(). I tried
a few related things without much luck.

The only thing that worked for me without holding the mutex across the
call was this:

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 08ae993..586d745 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1885,6 +1885,7 @@ void iterate_bdevs(void (*func)(struct 
block_device *, void *), void *arg)
  	spin_lock(&blockdev_superblock->s_inode_list_lock);
  	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
  		struct address_space *mapping = inode->i_mapping;
+		struct block_device *bdev;

  		spin_lock(&inode->i_lock);
  		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
@@ -1906,7 +1907,19 @@ void iterate_bdevs(void (*func)(struct 
block_device *, void *), void *arg)
  		iput(old_inode);
  		old_inode = inode;

-		func(I_BDEV(inode), arg);
+		bdev = I_BDEV(inode);
+
+		mutex_lock(&bdev->bd_mutex);
+		bdev->bd_openers++;
+		bdev->bd_holders++;
+		mutex_unlock(&bdev->bd_mutex);
+
+		func(bdev, arg);
+
+		mutex_lock(&bdev->bd_mutex);
+		bdev->bd_openers--;
+		bdev->bd_holders--;
+		mutex_unlock(&bdev->bd_mutex);

  		spin_lock(&blockdev_superblock->s_inode_list_lock);
  	}

I'm guessing that's too simple to work in general (especially when you
bring in partitions and stuff; I'm just opening /dev/sr0 in my reproducer).

It's been a long day, I'll have a look tomorrow and see if I didn't just
do something stupid.


Vegard
