Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60DC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF14206A5
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0Wy+UJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgD1Hr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:47:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgD1Hr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 03:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588060045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFRnN4gpMhE4Cra02GHZc5YcFHN5+JBIHBpN3w76bbE=;
        b=K0Wy+UJUxDw6t6VjBMDervFUSRT+9Z9SJNVPX2Zt0GRSFnpfFeya8YqbmKYmUQ+4Xz4Jei
        jX1kBe/5fO/m3UFxC0WnebLEh5TERzYQlfiIyzPYhlJuTvP4VdXpy7DRSTEKZEn+QWk5vt
        QSGsAfCyvzg6/TkqoMjctja1wyfw28w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-AFd4xgE1O0-gB7cmck8IZA-1; Tue, 28 Apr 2020 03:47:23 -0400
X-MC-Unique: AFd4xgE1O0-gB7cmck8IZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8DA107ACF2;
        Tue, 28 Apr 2020 07:47:22 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC3C5C1B2;
        Tue, 28 Apr 2020 07:47:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] block: add blk_io_schedule() for avoiding task hung in sync dio
Date:   Tue, 28 Apr 2020 15:46:57 +0800
Message-Id: <20200428074657.645441-3-ming.lei@redhat.com>
In-Reply-To: <20200428074657.645441-1-ming.lei@redhat.com>
References: <20200428074657.645441-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sync dio could be big, or may take long time in discard or in case of
IO failure.

We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
so apply the similar trick for prevent task hung from happening in
sync dio.

Add helper of blk_io_schedule() and use io_schedule_timeout(
blk_default_io_timeout()) to prevent task hung warning.

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c         | 4 ++--
 fs/direct-io.c         | 2 +-
 fs/iomap/direct-io.c   | 2 +-
 include/linux/blkdev.h | 6 ++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

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
index 3d594406b96c..c47c76cbbd97 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -28,6 +28,7 @@
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched.h>
=20
 struct module;
 struct scsi_ioctl_command;
@@ -1837,4 +1838,9 @@ static inline unsigned long blk_default_io_timeout(=
void)
 	return sysctl_hung_task_timeout_secs * (HZ / 2);
 }
=20
+static inline void blk_io_schedule(void)
+{
+	io_schedule_timeout(blk_default_io_timeout());
+}
+
 #endif
--=20
2.25.2

