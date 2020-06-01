Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7866C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 00:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FD72067B
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 00:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgFAAz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 20:55:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFAAz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 20:55:28 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jfYje-00049Q-I9
        for linux-block@vger.kernel.org; Mon, 01 Jun 2020 00:55:26 +0000
Received: by mail-qt1-f197.google.com with SMTP id e8so8521136qtq.22
        for <linux-block@vger.kernel.org>; Sun, 31 May 2020 17:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Pzz5zxhVl7hYkJ54F01MWFYXZMMN0HGsDMY/3v7yz4=;
        b=PVTFIkqONP1MMwGzslnGv+M4EKRKpuJJ543g364BwNpsLo5vVpI/4xhdOGcbeQQ4R8
         f4Bu+DMb1hXiWpEY1SkvF7Mt/H+2chRaRnpVCRJQSp+4++VtZH4yoGpqFSy7l/j1mtR0
         mxJibDSTbDOBUuUiyOPtg9wx0gG7uI1LO3ngqeeeCgUa5ebmVhzZJ52HlxHokksK65si
         qIgwjcK7xxqkqUTQj0YV6SCeKIOdDmTcJe8E7XG7po9F6+1dGSe+BOpGwv9dFQQx9Dlu
         eO3zQz95BmyWkV+jYu8U8RfOKv4nNeG+Da/JwznzhvC5gM6zvNJQpIGG6LYPout/Grng
         4oWw==
X-Gm-Message-State: AOAM533yswhXeXR7P58XBiUY7rvb5DWudQCEkHZZvREqqnw20ddAkgPv
        fZ5LIIDnguLkm5VpeUjmBWyLaYA6xBDJpzRUzEh78FEXqX8ve8+XCVrRVUIcJU6m5FUX+uu300m
        1PiPKM5tcsrwpgjW+bpvwmUVOvGgtH1t+KHxve42T
X-Received: by 2002:a0c:ca08:: with SMTP id c8mr18288768qvk.237.1590972925515;
        Sun, 31 May 2020 17:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxehgu4MjbasPDk0C3AB7KLo5n4bdBhfyAznHKwfTlN3EhO8pUBi0QwtPCb68SjNQVn8nakfQ==
X-Received: by 2002:a0c:ca08:: with SMTP id c8mr18288756qvk.237.1590972925206;
        Sun, 31 May 2020 17:55:25 -0700 (PDT)
Received: from localhost.localdomain ([179.159.56.229])
        by smtp.gmail.com with ESMTPSA id h77sm13680767qke.37.2020.05.31.17.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 17:55:24 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] block: check for page size in queue_logical_block_size()
Date:   Sun, 31 May 2020 21:55:20 -0300
Message-Id: <20200601005520.420719-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's possible for a block driver to set logical block size to
a value greater than page size incorrectly; e.g. bcache takes
the value from the superblock, set by the user w/ make-bcache.

This causes a BUG/NULL pointer dereference in the path:

  __blkdev_get()
  -> set_init_blocksize() // set i_blkbits based on ...
     -> bdev_logical_block_size()
        -> queue_logical_block_size() // ... this value
  -> bdev_disk_changed()
     ...
     -> blkdev_readpage()
        -> block_read_full_page()
           -> create_page_buffers() // size = 1 << i_blkbits
              -> create_empty_buffers() // give size/take pointer
                 -> alloc_page_buffers() // return NULL
                 .. BUG!

Because alloc_page_buffers() is called with size > PAGE_SIZE,
thus it initializes head = NULL, skips the loop, return head;
then create_empty_buffers() gets (and uses) the NULL pointer.

This has been around longer than commit ad6bf88a6c19 ("block:
fix an integer overflow in logical block size"); however, it
increased the range of values that can trigger the issue.

Previously only 8k/16k/32k (on x86/4k page size) would do it,
as greater values overflow unsigned short to zero, and queue_
logical_block_size() would then use the default of 512.

Now the range with unsigned int is much larger, and one user
with an (incorrect) 512k value, which happened to be zero'ed
previously and work fine, hits the issue -- the zero is gone,
and queue_logical_block_size() does return 512k (> PAGE_SIZE)

Fix this for the general case in queue_logical_block_size(),
regardless of the driver-side fault/fix, to prevent current
and future issues, while drivers adjust to the right values.

Test-case:

    # IMG=/root/disk.img
    # dd if=/dev/zero of=$IMG bs=1 count=0 seek=1G
    # DEV=$(losetup --find --show $IMG)
    # make-bcache --bdev $DEV --block 8k
      < see dmesg >

Before:

    # uname -rv
    5.7.0-rc7

    [   55.944046] BUG: kernel NULL pointer dereference, address: 0000000000000000
    ...
    [   55.949742] CPU: 3 PID: 610 Comm: bcache-register Not tainted 5.7.0-rc7 #4
    ...
    [   55.952281] RIP: 0010:create_empty_buffers+0x1a/0x100
    ...
    [   55.966434] Call Trace:
    [   55.967021]  create_page_buffers+0x48/0x50
    [   55.967834]  block_read_full_page+0x49/0x380
    [   55.972181]  do_read_cache_page+0x494/0x610
    [   55.974780]  read_part_sector+0x2d/0xaa
    [   55.975558]  read_lba+0x10e/0x1e0
    [   55.977904]  efi_partition+0x120/0x5a6
    [   55.980227]  blk_add_partitions+0x161/0x390
    [   55.982177]  bdev_disk_changed+0x61/0xd0
    [   55.982961]  __blkdev_get+0x350/0x490
    [   55.983715]  __device_add_disk+0x318/0x480
    [   55.984539]  bch_cached_dev_run+0xc5/0x270
    [   55.986010]  register_bcache.cold+0x122/0x179
    [   55.987628]  kernfs_fop_write+0xbc/0x1a0
    [   55.988416]  vfs_write+0xb1/0x1a0
    [   55.989134]  ksys_write+0x5a/0xd0
    [   55.989825]  do_syscall_64+0x43/0x140
    [   55.990563]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [   55.991519] RIP: 0033:0x7f7d60ba3154
    ...

After:

    # uname -rv
    5.7.0-rc7.chkpgsz1

    [   46.313306] bcache: register_bdev() registered backing device loop0

    # grep ^ /sys/block/bcache0/queue/*_block_size
    /sys/block/bcache0/queue/logical_block_size:512
    /sys/block/bcache0/queue/physical_block_size:8192

Reported-by: Ryan Finnie <ryan@finnie.org>
Reported-by: Sebastian Marsching <sebastian@marsching.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..fb9dfc8c7e68 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1297,7 +1297,8 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
 
-	if (q && q->limits.logical_block_size)
+	if (q && q->limits.logical_block_size &&
+		 q->limits.logical_block_size <= PAGE_SIZE)
 		retval = q->limits.logical_block_size;
 
 	return retval;
-- 
2.17.1

