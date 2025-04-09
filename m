Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A156237
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161318; cv=none; b=UKHtr1G2ep09VfTePF6zj9aVQdxHnGezYOaCiGZ0H/UCaK3od/swBz7q+sCSbZazh0H+iHHo9ViJKeBdvB8oYZiPW2OaCxWWtF623dkGA3HsURR7QJmxIWVBJvLtH+XXkfXSUE1XaM2nDhRIb7kULCwXxeZsvK6ONrOCpNpx0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161318; c=relaxed/simple;
	bh=NkvJUa67NuQAEBMSbkixgf7v1SPBOdLzrFCRTywBiCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltGf1H42BsuRMXAl16jJIIwaTaeualOGg/a34dE4U5vxu6ni7UoFcOqQxrmPuk2osHeTAQ79hU+rL04S6ZiKDshMTITfAqWteifVwrVj1xN0JLchy8ZeD0Sf+f4xJZzF8UUrIHMYn5ecpC3iqSQNuwQ1Y5xU7Ns+8V9EWV7LDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd4NgMAS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd4NgMAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744161312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr9eb9fwiL6iLk0VnR2hA8cQwLKNTaPAlkafeN70d14=;
	b=Xd4NgMASrTbIuzs+vndcQG2xWHropAWhRocaboAQT50plDrUl2RH/yct/e7mJxE4lII0EG
	fSqaENV4KVu32rTybw7UcqI9p5Blj9I9V8riaFftgH3sC8XvYzC8mzuuuvg0LNtmRLUSlS
	VHO+3u1SFxdYsjyu8KYpqkBMvfdWrRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-Bja7TvzZOCmfV_8NclIYrg-1; Tue,
 08 Apr 2025 21:15:07 -0400
X-MC-Unique: Bja7TvzZOCmfV_8NclIYrg-1
X-Mimecast-MFC-AGG-ID: Bja7TvzZOCmfV_8NclIYrg_1744161304
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95DB9180AB1C;
	Wed,  9 Apr 2025 01:15:03 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7530F1801766;
	Wed,  9 Apr 2025 01:15:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/2] ublk: fix handling recovery & reissue in ublk_abort_queue()
Date: Wed,  9 Apr 2025 09:14:41 +0800
Message-ID: <20250409011444.2142010-2-ming.lei@redhat.com>
In-Reply-To: <20250409011444.2142010-1-ming.lei@redhat.com>
References: <20250409011444.2142010-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 8284066946e6 ("ublk: grab request reference when the request is handled
by userspace") doesn't grab request reference in case of recovery reissue.
Then the request can be requeued & re-dispatch & failed when canceling
uring command.

If it is one zc request, the request can be freed before io_uring
returns the zc buffer back, then cause kernel panic:

[  126.773061] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[  126.773657] #PF: supervisor read access in kernel mode
[  126.774052] #PF: error_code(0x0000) - not-present page
[  126.774455] PGD 0 P4D 0
[  126.774698] Oops: Oops: 0000 [#1] SMP NOPTI
[  126.775034] CPU: 13 UID: 0 PID: 1612 Comm: kworker/u64:55 Not tainted 6.14.0_blk+ #182 PREEMPT(full)
[  126.775676] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[  126.776275] Workqueue: iou_exit io_ring_exit_work
[  126.776651] RIP: 0010:ublk_io_release+0x14/0x130 [ublk_drv]

Fixes it by always grabbing request reference for aborting the request.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Closes: https://lore.kernel.org/linux-block/CADUfDZodKfOGUeWrnAxcZiLT+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com/
Fixes: 8284066946e6 ("ublk: grab request reference when the request is handled by userspace")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..41bed67508f2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1140,6 +1140,25 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
+static void ublk_do_fail_rq(struct request *req)
+{
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else
+		__ublk_complete_rq(req);
+}
+
+static void ublk_fail_rq_fn(struct kref *ref)
+{
+	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
+			ref);
+	struct request *req = blk_mq_rq_from_pdu(data);
+
+	ublk_do_fail_rq(req);
+}
+
 /*
  * Since ublk_rq_task_work_cb always fails requests immediately during
  * exiting, __ublk_fail_req() is only called from abort context during
@@ -1153,10 +1172,13 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		ublk_put_req_ref(ubq, req);
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		kref_put(&data->ref, ublk_fail_rq_fn);
+	} else {
+		ublk_do_fail_rq(req);
+	}
 }
 
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
-- 
2.47.0

