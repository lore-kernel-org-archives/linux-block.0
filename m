Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33056 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbcJ1XFi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 19:05:38 -0400
Received: by mail-oi0-f51.google.com with SMTP id y2so147763989oie.0
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2016 16:05:38 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Oct 2016 16:05:37 -0700
Message-ID: <CAPcyv4i8Z0Zuy-yf5_ROvvRfE6DS_XVKrVoSUAO6-FBQXs6k8Q@mail.gmail.com>
Subject: block device shutdown crash in bdev_get_queue()
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

I caught the backtrace below with the libnvdimm unit test.  It's hard
to hit, and as far as I can tell it's been present for a while.
Wanted to get a second opinion on the potential fix.

The failure address of 0000000000000540 corresponds offset 1344 in
struct gendisk according to pahole.

struct gendisk {
[..]
        struct request_queue *     queue;                /*  1344     8 */
[..]
}

which means that bdev->bd_disk was NULL.  I think this means that
blk_get_backing_dev_info() should not assume that it can just use
bdev_get_queue() to get to the bdi.  It seems it needs to hold its own
blkdev_get() reference.


[   44.513201] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000540
[   44.515051] IP: [<ffffffff81485a80>] blk_get_backing_dev_info+0x10/0x20
[..]
[   44.556549] Call Trace:
[   44.557260]  [<ffffffff812c6b19>] __inode_attach_wb+0x319/0x5c0
[   44.560203]  [<ffffffff811ef752>] __filemap_fdatawrite_range+0xf2/0x100
[   44.561399]  [<ffffffff811ef7d0>] filemap_write_and_wait+0x40/0x90
[   44.562551]  [<ffffffff812d6c69>] fsync_bdev+0x49/0x50
[   44.563570]  [<ffffffff8149f474>] invalidate_partition+0x24/0x50
[   44.564693]  [<ffffffff814a0062>] del_gendisk+0xf2/0x210
[   44.565740]  [<ffffffffa003b162>] pmem_release_disk+0x12/0x20 [nd_pmem]
[   44.566933]  [<ffffffff81615e9f>] devm_action_release+0xf/0x20
[   44.568033]  [<ffffffff81616979>] release_nodes+0x129/0x230
[   44.569109]  [<ffffffff81616cec>] devres_release_all+0x3c/0x60
[   44.570216]  [<ffffffff81611c49>] __device_release_driver+0xa9/0x160
[   44.571384]  [<ffffffff81611d25>] device_release_driver+0x25/0x40
