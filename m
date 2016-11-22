Return-Path: <Yang.Shi@windriver.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Yang Shi <yang.shi@windriver.com>
Subject: Is it a possible memory leak in CFQ?
Message-ID: <06441268-93be-5ce0-58c9-f7eec027a07d@windriver.com>
Date: Tue, 22 Nov 2016 09:29:01 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi folks,


When I create some big file (i.e. dd if=/dev/zero of=/home/test/big_file 
bs=1024k count=10240, then run sync, umount) with kmemleak enabled, 
kmemleak may report some memory leak occasionally. I would say it 
happens randomly. Please see the below log:


unreferenced object 0x99249e70 (size 176):
   comm "kworker/u4:2", pid 2872, jiffies 1263855 (age 435.790s)
   hex dump (first 32 bytes):
     01 00 00 00 10 00 00 00 00 08 c5 b3 7c 9e 24 99 ............|.$.
     00 00 00 00 00 00 00 00 27 dd 75 42 c4 0b 00 00 ........'.uB....
   backtrace:
     [<809c47cc>] kmemleak_alloc+0x40/0x74
     [<80348534>] kmem_cache_alloc+0x140/0x2c8
     [<805d0d70>] cfq_get_queue+0xf4/0x238
     [<805d2150>] cfq_set_request+0x100/0x290
     [<805ae8e0>] elv_set_request+0x2c/0x38
     [<805b3520>] get_request+0x6b4/0x7e0
     [<805b5ef0>] blk_queue_bio+0x90/0x3a0
     [<805b3fb8>] generic_make_request+0xc0/0x174
     [<805b40b4>] submit_bio+0x48/0x14c
     [<8039038c>] submit_bh_wbc+0x1a8/0x1bc
     [<80390608>] __block_write_full_page+0x268/0x3a0
     [<803908bc>] block_write_full_page+0x88/0xf4
     [<803931f8>] blkdev_writepage+0x20/0x28
     [<80306974>] __writepage+0x24/0x48
     [<80307324>] write_cache_pages+0x358/0x42c
     [<80307444>] generic_writepages+0x4c/0x68


Not sure if this is a real memory leak or false positive.


Thanks,

Yang
