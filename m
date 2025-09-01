Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0677BA4A
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720997; cv=none; b=PokwMCbLnFeUqw8joFPhXCWDdr88L/kTvmcRRNtsOqPlsKTqB9Hsg6PAfYV2U8Mv9klFWMd+lSvnCCEiYxtevxhnmgUawIIT5v052leWl7MKWlRi2iQp0knf30BvNBeVL37yW/Gs07YnqIDsE6MgdEvVxG4LpmP1UfDA7khtFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720997; c=relaxed/simple;
	bh=q0o9sED7BnYpWM9x8pTlqhMMD8xIecKmMcNCH7gXEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALThRNIJzdahOHb7TnAXR7RfuPdgIJ8C5dciXv/9lyv5HNpdXiZhzILKzYYPsqaGD6xpFG3KYPwvcMsqOTnPDNpCw90DUnpH/r8Uuv/0D5JaR3li3JGXnpPFmpj+pTiYNAG6UZimMuLyxtEhSDpyazZZloysD8NnUZh8BkrS/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkb+cAm/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkb+cAm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVdu5GR5R5NV+uHg+QpYm+IUmG/YLFZvS/Tp2a6hFOE=;
	b=Jkb+cAm/LsP865Gt2QjYvel07+WXbU9SwDjEG9rXMEuRiZQRt9HKtIN1epwsniyASkrEce
	ein++CqMt9zzpxqzd75Ms6p7Z457h+pBfxOPGubJ7GVVKeakcRq1igDHFunxWm8+CyIjBr
	a1EoRiOT3V7eB4z8e1+kMGefGcf6z2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-yYD6clO2Ma2Ghy4gqqfdPA-1; Mon,
 01 Sep 2025 06:03:12 -0400
X-MC-Unique: yYD6clO2Ma2Ghy4gqqfdPA-1
X-Mimecast-MFC-AGG-ID: yYD6clO2Ma2Ghy4gqqfdPA_1756720991
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8223A18004D4;
	Mon,  1 Sep 2025 10:03:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1E4B1955EA4;
	Mon,  1 Sep 2025 10:03:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/23] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
Date: Mon,  1 Sep 2025 18:02:22 +0800
Message-ID: <20250901100242.3231000-6-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Introduces the basic structure for a batched I/O feature in the ublk driver.
It adds placeholder functions and a new file operations structure,
ublk_ch_batch_io_fops, which will be used for fetching and committing I/O
commands in batches. Currently, the feature is disabled and returns
-EOPNOTSUPP.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f265795a8d57..a0dfad8a56f0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -256,6 +256,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
+static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
+{
+	return false;
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2509,6 +2514,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
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
@@ -2624,6 +2635,16 @@ static const struct file_operations ublk_ch_fops = {
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
 	int size = ublk_queue_cmd_buf_size(ub, q_id);
@@ -2761,7 +2782,10 @@ static int ublk_add_chdev(struct ublk_device *ub)
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

