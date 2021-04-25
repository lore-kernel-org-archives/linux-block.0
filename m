Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5CCC433ED
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18E060233
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 04:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhDYEbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Apr 2021 00:31:08 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:33609 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDYEbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 00:31:07 -0400
Received: by mail-pj1-f54.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso6265689pjb.0
        for <linux-block@vger.kernel.org>; Sat, 24 Apr 2021 21:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAVLWNkTkC088uPSx+MAUlt7CA6HD2Uc5c+QmmVyADA=;
        b=nbmvI/GzNYd2+HewAtWXm4tsEechD9oXIOefLL7uS2mzLEJtekMIKIWRWDO6hCLYGo
         rAjPgrAXDJToJasuhAsWrSR+GIxtducXAQutjx02Oc3yJvm2bXlN4EUJa9xNF7L6Bqbb
         PzVmHgXzkvYRvoov9+YLwO5IbFYt450cxUcGFQfaBGyqzRmqCo8lbGXwEYyGcbKDqKAI
         92iyMe6JqE4stuDUpE8FJWnhPNPOkz0Bxq3r2iA5isDSnQC8er4ytA3Gx323iDTTWJxf
         4rMx3sV/ei8vbM5LbZ6tq4CckSnsFYMIPCpJu5+0p0nd4r6JKWx654OO4BcO7UyNKkFS
         4ufg==
X-Gm-Message-State: AOAM531IbNHG1GXlChNHxc1L/fcaMCym2kCLuv/PX/xQxJgFUm5+LkSI
        vLRqWjJRb7/uVK8oZnsMFVs=
X-Google-Smtp-Source: ABdhPJzqtuIBtnOAm+m7GUWmEIKz2BmDxnqifrz44hqIJzkyR8KTNuWIMWlZ6gpULBXGK5RCvdg7QQ==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr2894998pju.188.1619325028114;
        Sat, 24 Apr 2021 21:30:28 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f072:56db:3625:996f])
        by smtp.gmail.com with ESMTPSA id v64sm8382900pfc.117.2021.04.24.21.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 21:30:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2] block: Improve limiting the bio size
Date:   Sat, 24 Apr 2021 21:30:20 -0700
Message-Id: <20210425043020.30065-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_max_size() may get called before device_add_disk() and hence needs to
check whether or not the block device pointer is NULL. Additionally, more
code needs to be modified than __bio_try_merge_page() to limit the bio size
to bio_max_size().

This patch prevents that bio_max_size() triggers the following kernel
crash during a SCSI LUN scan:

BUG: KASAN: null-ptr-deref in bio_add_hw_page+0xa6/0x310
Read of size 8 at addr 00000000000005a8 by task kworker/u16:0/7
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 show_stack+0x52/0x58
 dump_stack+0x9d/0xcf
 kasan_report.cold+0x4b/0x50
 __asan_load8+0x69/0x90
 bio_add_hw_page+0xa6/0x310
 bio_add_pc_page+0xaa/0xe0
 bio_map_kern+0xdc/0x1a0
 blk_rq_map_kern+0xcd/0x2d0
 __scsi_execute+0x9a/0x290 [scsi_mod]
 scsi_probe_lun.constprop.0+0x17c/0x660 [scsi_mod]
 scsi_probe_and_add_lun+0x178/0x750 [scsi_mod]
 __scsi_add_device+0x18c/0x1a0 [scsi_mod]
 ata_scsi_scan_host+0xe5/0x260 [libata]
 async_port_probe+0x94/0xb0 [libata]
 async_run_entry_fn+0x7d/0x2d0
 process_one_work+0x582/0xac0
 worker_thread+0x8f/0x5a0
 kthread+0x222/0x250
 ret_from_fork+0x1f/0x30

This patch also fixes the following kernel warning:

WARNING: CPU: 1 PID: 15449 at block/bio.c:1034
__bio_iov_iter_get_pages+0x324/0x350
Call Trace:
 bio_iov_iter_get_pages+0x6c/0x360
 __blkdev_direct_IO_simple+0x291/0x580
 blkdev_direct_IO+0xb5/0xc0
 generic_file_direct_write+0x10d/0x290
 __generic_file_write_iter+0x120/0x290
 blkdev_write_iter+0x16e/0x280
 new_sync_write+0x268/0x380
 vfs_write+0x3e0/0x4f0
 ksys_write+0xd9/0x180
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x32/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Changheun Lee <nanich.lee@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Fixes: 15050b63567c ("bio: limit bio max size")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Changes compared to v1: included a fix for direct I/O.

diff --git a/block/bio.c b/block/bio.c
index d718c63b3533..221dc56ba22f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -257,9 +257,9 @@ EXPORT_SYMBOL(bio_init);
 
 unsigned int bio_max_size(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct block_device *bdev = bio->bi_bdev;
 
-	return q->limits.bio_max_bytes;
+	return bdev ? bdev->bd_disk->queue->limits.bio_max_bytes : UINT_MAX;
 }
 
 /**
@@ -1002,6 +1002,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	bool same_page = false;
@@ -1017,7 +1018,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
+				  &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
