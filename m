Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52157 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbdKISpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 13:45:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id b9so19780120wmh.0
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 10:45:35 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] block: fail op_is_write() requests to read-only partitions
Date: Thu,  9 Nov 2017 19:45:00 +0100
Message-Id: <1510253101-10291-2-git-send-email-idryomov@gmail.com>
In-Reply-To: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
References: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Regular block device writes go through blkdev_write_iter(), which does
bdev_read_only(), while zeroout/discard/etc requests are never checked,
both userspace- and kernel-triggered.  Add a generic catch-all check to
generic_make_request_checks() to actually enforce ioctl(BLKROSET) and
set_disk_ro(), which is used by quite a few drivers for things like
snapshots, read-only backing files/images, etc.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b8d1aa2d1008..139ff47caf4a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2022,6 +2022,20 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 	return 0;
 }
 
+static inline bool bio_check_ro(struct bio *bio)
+{
+	struct hd_struct *p;
+	int ret = false;
+
+	rcu_read_lock();
+	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	if (!p || (p->policy && op_is_write(bio_op(bio))))
+		ret = true;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
@@ -2044,11 +2058,18 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	if (bio_check_ro(bio)) {
+		printk(KERN_ERR
+		       "generic_make_request: Trying to write "
+			"to read-only block-device %s (partno %d)\n",
+			bio_devname(bio, b), bio->bi_partno);
+		goto end_io;
+	}
+
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
 	 */
-
 	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
 		goto not_supported;
 
-- 
2.4.3
