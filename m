Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC676C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFF0206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmVAag0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgD1HrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:47:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbgD1HrX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 03:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588060041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABOfTXwDZUxjx/c4pBduwN4SsNRSV2qSi1ivemkCJ6E=;
        b=ZmVAag0sH3NifiLeL3g41PtBWug6T7HghM5MNcJ0BZEthW628rtEg4BGp2W6muVmQ8wk2g
        sGoLNmbix56TP8NC7HV0mdlawfvKg73Ynwm52RmAHvLxyftLYu7ZHEqot3RF2z8sMVmZFW
        sOSiYFoSiymuDBrvssEqzFEIOXr/jeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-XqI0mGFAMf6uBuuEdPsR3A-1; Tue, 28 Apr 2020 03:47:19 -0400
X-MC-Unique: XqI0mGFAMf6uBuuEdPsR3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCCE464;
        Tue, 28 Apr 2020 07:47:18 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 902815C1D4;
        Tue, 28 Apr 2020 07:47:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding task hung in sync IO
Date:   Tue, 28 Apr 2020 15:46:56 +0800
Message-Id: <20200428074657.645441-2-ming.lei@redhat.com>
In-Reply-To: <20200428074657.645441-1-ming.lei@redhat.com>
References: <20200428074657.645441-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of blk_default_io_timeout(), so that the two current users
can benefit from it.

Also direct IO users will use it in the following patch, so define the
helper in public header.

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c            |  9 +++------
 block/blk-exec.c       |  8 +++-----
 include/linux/blkdev.h | 10 ++++++++++
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..f67afa159de7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1069,18 +1069,15 @@ static void submit_bio_wait_endio(struct bio *bio=
)
 int submit_bio_wait(struct bio *bio)
 {
 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
-	unsigned long hang_check;
+	unsigned long timeout =3D blk_default_io_timeout();
=20
 	bio->bi_private =3D &done;
 	bio->bi_end_io =3D submit_bio_wait_endio;
 	bio->bi_opf |=3D REQ_SYNC;
 	submit_bio(bio);
=20
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check =3D sysctl_hung_task_timeout_secs;
-	if (hang_check)
-		while (!wait_for_completion_io_timeout(&done,
-					hang_check * (HZ/2)))
+	if (timeout)
+		while (!wait_for_completion_io_timeout(&done, timeout))
 			;
 	else
 		wait_for_completion_io(&done);
diff --git a/block/blk-exec.c b/block/blk-exec.c
index e20a852ae432..17b5cf07e1a3 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -80,15 +80,13 @@ void blk_execute_rq(struct request_queue *q, struct g=
endisk *bd_disk,
 		   struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	unsigned long hang_check;
+	unsigned long timeout =3D blk_default_io_timeout();
=20
 	rq->end_io_data =3D &wait;
 	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
=20
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check =3D sysctl_hung_task_timeout_secs;
-	if (hang_check)
-		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
+	if (timeout)
+		while (!wait_for_completion_io_timeout(&wait, timeout));
 	else
 		wait_for_completion_io(&wait);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f00bd4042295..3d594406b96c 100644
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
@@ -1827,4 +1828,13 @@ static inline void blk_wake_io_task(struct task_st=
ruct *waiter)
 		wake_up_process(waiter);
 }
=20
+/*
+ * Used in sync IO for avoiding to triger task hung warning, which may
+ * cause system panic or reboot.
+ */
+static inline unsigned long blk_default_io_timeout(void)
+{
+	return sysctl_hung_task_timeout_secs * (HZ / 2);
+}
+
 #endif
--=20
2.25.2

