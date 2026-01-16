Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2526328B49
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573159; cv=none; b=X0FRFCGTqGFCR/RpD7UMIf0XHHQa5k8g9hetXK3QFy237ke2VWqeB7xWHaxLmS4CJET5D4oWmlWy878xtR5FFTZH7C0TxsjBlKvKgRNVf5UZyQYITt8F3hwRwFvxuCYF/gk9dssvmCivHIOaFs4FGMkKlnfqjNlylPeJwiWZb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573159; c=relaxed/simple;
	bh=2gCvFNSUM5zNOY5TNtDET/xUO4NpprvNZd25n4pxBTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBbJBKrwn79oWKvbKp3kjzZFkeRCHv3JLk4bXuoN+HuluQkf3LRF9PI7bW9ZwfWW5mreI3eCgoEDRKlM1ghEvUg2yqr7nNXtfCI0+yzqALIBBPCC+LUkJ5aD4++1uDVsnQsjZJbz0aCpoxWh+TzIwJL7v18uerHhBAMqOpxVXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Exh7tbgd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exh7tbgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1l+w8NQcRuKCFheKrJCsaS7JmnZfpFxc+2BuXevCoQ=;
	b=Exh7tbgdHxvRrSckjj70J2Dvd4Mf1X+VDZnmIxaN7uHH2FQXoU/gRsFTPXkJREJ//YnBvs
	Z0jDe8+l2SpUnVUyz+uhmeJh5NvJIR0ZYkZGAlFoXOBjgD+LYnW+22oRpLjFzQOQWo1iSg
	XK+FsSxil6r2mto3klxB5cOZyjLKR/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-tz_1txiXP5qeLFA1iePdhg-1; Fri,
 16 Jan 2026 09:19:11 -0500
X-MC-Unique: tz_1txiXP5qeLFA1iePdhg-1
X-Mimecast-MFC-AGG-ID: tz_1txiXP5qeLFA1iePdhg_1768573150
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21FAC195609F;
	Fri, 16 Jan 2026 14:19:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E27819560A7;
	Fri, 16 Jan 2026 14:19:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 01/24] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
Date: Fri, 16 Jan 2026 22:18:34 +0800
Message-ID: <20260116141859.719929-2-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Introduces the basic structure for a batched I/O feature in the ublk driver.
It adds placeholder functions and a new file operations structure,
ublk_ch_batch_io_fops, which will be used for fetching and committing I/O
commands in batches. Currently, the feature is disabled.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1385f414bce..dfb5b1177cfd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -263,6 +263,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
+static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
+{
+	return false;
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2679,6 +2684,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
+				       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool ublk_check_ubuf_dir(const struct request *req,
 		int ubuf_dir)
 {
@@ -2798,6 +2809,16 @@ static const struct file_operations ublk_ch_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
+static const struct file_operations ublk_ch_batch_io_fops = {
+	.owner = THIS_MODULE,
+	.open = ublk_ch_open,
+	.release = ublk_ch_release,
+	.read_iter = ublk_ch_read_iter,
+	.write_iter = ublk_ch_write_iter,
+	.uring_cmd = ublk_ch_batch_io_uring_cmd,
+	.mmap = ublk_ch_mmap,
+};
+
 static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
 	struct ublk_queue *ubq = ub->queues[q_id];
@@ -2958,7 +2979,10 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	if (ret)
 		goto fail;
 
-	cdev_init(&ub->cdev, &ublk_ch_fops);
+	if (ublk_dev_support_batch_io(ub))
+		cdev_init(&ub->cdev, &ublk_ch_batch_io_fops);
+	else
+		cdev_init(&ub->cdev, &ublk_ch_fops);
 	ret = cdev_device_add(&ub->cdev, dev);
 	if (ret)
 		goto fail;
-- 
2.47.0

