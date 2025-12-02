Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B80311C32
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677991; cv=none; b=b5YKlBgaK0UI5nxsZvvc6c0xAKklPgqv5l4682VjuTwuk7I0cmr5wlr9Wf8lZLvJrmhKVrMLvuhNhqcxRlCljNTS1e1RnO+JjTA8GqolEsZU+kGOl41wguejGoIY7mFifVIX6g5XF03T+GR1a730uqJdcYJp6fmgzvBgxOoLrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677991; c=relaxed/simple;
	bh=R3seLI8FNCKCQa9DM0ikgR+asSU/auf6EKY6BL7QVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGi8Bok2Eurs4VR3wfAmNbLmjB2airOs1O3QoBcG5qwfh7joF3JNhl4NSdIle99Ll8ByxfpKWSFCUqmKIwEjbRik/0rkhROvcqUYIJwJPGFsBiVMxNpRj88CZU/zkRVuKEDc5aZ6Xlu/x5lZIXv+FQjfrI9nuDw4VBvGdH6uXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSz4wxzd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSz4wxzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764677989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MthCLlk49Z7fztmr3dh2cnJW2OPZdngvjA5V3D2wIBA=;
	b=hSz4wxzdOg53wUNQVKoMyRBBKEuhP+gy/k5mSPq1orfZeFHxwB2Z6DIyygmR30560tSeTT
	bZjTL11JPHT3Ab1npf2rwhIMhPo4ry6djJJdVGFRYOXK5aA4XHCqtcj5CsbkgfxoB6X343
	1rMqNLbWdTO/p8pGBIBfA5GK5OttKwU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-sHeVc-UzPD2AQ5tQ5sN6nw-1; Tue,
 02 Dec 2025 07:19:46 -0500
X-MC-Unique: sHeVc-UzPD2AQ5tQ5sN6nw-1
X-Mimecast-MFC-AGG-ID: sHeVc-UzPD2AQ5tQ5sN6nw_1764677985
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 251851956095;
	Tue,  2 Dec 2025 12:19:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA9F21800876;
	Tue,  2 Dec 2025 12:19:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 01/21] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
Date: Tue,  2 Dec 2025 20:18:55 +0800
Message-ID: <20251202121917.1412280-2-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index c2250172de4c..7219ccbd6364 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -254,6 +254,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
+static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
+{
+	return false;
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2512,6 +2517,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
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
@@ -2618,6 +2629,16 @@ static const struct file_operations ublk_ch_fops = {
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
@@ -2778,7 +2799,10 @@ static int ublk_add_chdev(struct ublk_device *ub)
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

