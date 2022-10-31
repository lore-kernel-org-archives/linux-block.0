Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB2FA3740
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 12:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJaMHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJaMHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 08:07:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8532614F
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 05:07:12 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1BbX0ZNzzVj7H;
        Mon, 31 Oct 2022 20:02:16 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 20:07:10 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <efremov@linux.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] block/floppy: Fix memory leak in do_floppy_init()
Date:   Mon, 31 Oct 2022 12:04:43 +0000
Message-ID: <20221031120443.78993-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A memory leak was reported when floppy_alloc_disk() failed in
do_floppy_init().

unreferenced object 0xffff888115ed25a0 (size 8):
  comm "modprobe", pid 727, jiffies 4295051278 (age 25.529s)
  hex dump (first 8 bytes):
    00 ac 67 5b 81 88 ff ff                          ..g[....
  backtrace:
    [<000000007f457abb>] __kmalloc_node+0x4c/0xc0
    [<00000000a87bfa9e>] blk_mq_realloc_tag_set_tags.part.0+0x6f/0x180
    [<000000006f02e8b1>] blk_mq_alloc_tag_set+0x573/0x1130
    [<0000000066007fd7>] 0xffffffffc06b8b08
    [<0000000081f5ac40>] do_one_initcall+0xd0/0x4f0
    [<00000000e26d04ee>] do_init_module+0x1a4/0x680
    [<000000001bb22407>] load_module+0x6249/0x7110
    [<00000000ad31ac4d>] __do_sys_finit_module+0x140/0x200
    [<000000007bddca46>] do_syscall_64+0x35/0x80
    [<00000000b5afec39>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff88810fc30540 (size 32):
  comm "modprobe", pid 727, jiffies 4295051278 (age 25.529s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007f457abb>] __kmalloc_node+0x4c/0xc0
    [<000000006b91eab4>] blk_mq_alloc_tag_set+0x393/0x1130
    [<0000000066007fd7>] 0xffffffffc06b8b08
    [<0000000081f5ac40>] do_one_initcall+0xd0/0x4f0
    [<00000000e26d04ee>] do_init_module+0x1a4/0x680
    [<000000001bb22407>] load_module+0x6249/0x7110
    [<00000000ad31ac4d>] __do_sys_finit_module+0x140/0x200
    [<000000007bddca46>] do_syscall_64+0x35/0x80
    [<00000000b5afec39>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

If the floppy_alloc_disk() failed, disks of current drive will not be set,
thus the lastest allocated set->tag cannot be freed in the error handling
path. A simple call graph shown as below:

 floppy_module_init()
   floppy_init()
     do_floppy_init()
       for (drive = 0; drive < N_DRIVE; drive++)
         blk_mq_alloc_tag_set()
           blk_mq_alloc_tag_set_tags()
             blk_mq_realloc_tag_set_tags() # set->tag allocated
         floppy_alloc_disk()
           blk_mq_alloc_disk() # error occurred, disks failed to allocated

       ->out_put_disk:
       for (drive = 0; drive < N_DRIVE; drive++)
         if (!disks[drive][0]) # the last disks is not set and loop break
           break;
         blk_mq_free_tag_set() # the latest allocated set->tag leaked

Fix this problem by free the set->tag of current drive before jump to
error handling path.

Fixes: 302cfee15029 ("floppy: use a separate gendisk for each media format")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ccad3d7b3ddd..487840e3564d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4593,8 +4593,10 @@ static int __init do_floppy_init(void)
 			goto out_put_disk;
 
 		err = floppy_alloc_disk(drive, 0);
-		if (err)
+		if (err) {
+			blk_mq_free_tag_set(&tag_sets[drive]);
 			goto out_put_disk;
+		}
 
 		timer_setup(&motor_off_timer[drive], motor_off_callback, 0);
 	}
-- 
2.17.1

