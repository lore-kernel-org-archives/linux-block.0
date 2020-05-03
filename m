Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87748C3A5A9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568C021835
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 01:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVfSybSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgECByn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 21:54:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28555 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726686AbgECByn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 May 2020 21:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588470881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jyDQB8idN4qhBI+Q1Y2EhaDv8P7H+to/XfsoaMGUBjI=;
        b=WVfSybSCSiyOn42+God1hzOGFs1H30IYTdKZLbImM7bucg+3qfeTai1g5CJWiZZFtjQ7N/
        mahlya4SkslC52OibMBREIwCwAWC76B1dYV7njWWDDLX2/pwNlVp3yZI9xUuAKVWJrLDC2
        I2fN2LnF2uDJm0ZH5iWb9JqWLc89zmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-ExmCqEWkM22xsNHQqDjF-A-1; Sat, 02 May 2020 21:54:34 -0400
X-MC-Unique: ExmCqEWkM22xsNHQqDjF-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A07A10073AD;
        Sun,  3 May 2020 01:54:33 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4A75D9CD;
        Sun,  3 May 2020 01:54:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2] block: add blk_io_schedule() for avoiding task hung in sync dio
Date:   Sun,  3 May 2020 09:54:22 +0800
Message-Id: <20200503015422.1123994-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sync dio could be big, or may take long time in discard or in case of
IO failure.

We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
so apply the same trick for prevent task hung from happening in sync dio.

Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
task hung warning.

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- drop helper of blk_default_io_timeout()


 fs/block_dev.c         |  4 ++--
 fs/direct-io.c         |  2 +-
 fs/iomap/direct-io.c   |  2 +-
 include/linux/blkdev.h | 12 ++++++++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5eb30a474f6d..3b396f8c967c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -256,7 +256,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct =
iov_iter *iter,
 			break;
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(bdev_get_queue(bdev), qc, true))
-			io_schedule();
+			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
=20
@@ -450,7 +450,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)
=20
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(bdev_get_queue(bdev), qc, true))
-			io_schedule();
+			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
=20
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 00b4d15bb811..6d5370eac2a8 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -500,7 +500,7 @@ static struct bio *dio_await_one(struct dio *dio)
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
 		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
-			io_schedule();
+			blk_io_schedule();
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
 		dio->waiter =3D NULL;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 20dde5aadcdd..fd3bd06fabb6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -561,7 +561,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 			    !dio->submit.last_queue ||
 			    !blk_poll(dio->submit.last_queue,
 					 dio->submit.cookie, true))
-				io_schedule();
+				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f00bd4042295..222eb5f32279 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/sched/sysctl.h>
=20
 struct module;
 struct scsi_ioctl_command;
@@ -1827,4 +1828,15 @@ static inline void blk_wake_io_task(struct task_st=
ruct *waiter)
 		wake_up_process(waiter);
 }
=20
+static inline void blk_io_schedule(void)
+{
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	unsigned long timeout =3D sysctl_hung_task_timeout_secs * HZ / 2;
+
+	if (timeout)
+		io_schedule_timeout(timeout);
+	else
+		io_schedule();
+}
+
 #endif
--=20
2.25.2

