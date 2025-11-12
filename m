Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155A2264B8
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940347; cv=none; b=hktRcDKKFQKkD+CE12Wx77HhQXLgbj9SRU2b5X7NLgqVeDwcg37SMqKHt4AVfQ+Y15CKZUdZYwsgsojnh7/bowCaCnarh2gCssL2bYyc92jMlq8/zFnGgGA1u1sTcDP9KcI9z6HvlQ9NgVvEP1lnq8NQO0TpS4UcDxIhHCGod04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940347; c=relaxed/simple;
	bh=9lz/zTnuBVl9xO+Syb30DgeeOR4F5ieQ9i3f2HRRm7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBS8k3pSofecfHAoONYEdSI6eCOWz+JHKGMlRI74ZEgvDYKJEFQSh8WyBa1wtYTYvUzOrm4YR23kybc8LbM07weMKJdiAIPac2tqjOs9WjHJSST+175zTYDGUTKBsGtPVKCZXpzhJUjk3TZMUALcU5f+AepNq0uadre1JcxSpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXMRqFIX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXMRqFIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PO6f5jz42DBlQAUhK3se1j7b6gW7jvpeEuu1PFTGky4=;
	b=CXMRqFIXGCtG7qiNlBuXMMz5pDv5Ml3ServMj/Db5ZOEoISYcp/Br1NK37SFNPBKSwQwu1
	qVc2ilZudIifLrpEBAbES7AAWcxmDTQSTgw+eyOmmnXyXiL3nWQ6D0rhk+Cl5p6RCJ4HGs
	kpTxSVTwuqy1NAsMKSEP9s13f4CSN24=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-C1-Wsqt8No2iOIzub486XQ-1; Wed,
 12 Nov 2025 04:39:01 -0500
X-MC-Unique: C1-Wsqt8No2iOIzub486XQ-1
X-Mimecast-MFC-AGG-ID: C1-Wsqt8No2iOIzub486XQ_1762940340
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A96F195608D;
	Wed, 12 Nov 2025 09:39:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 097881800451;
	Wed, 12 Nov 2025 09:38:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 07/27] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
Date: Wed, 12 Nov 2025 17:37:45 +0800
Message-ID: <20251112093808.2134129-8-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
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
index dd9c35758a46..1fcca52591c3 100644
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

