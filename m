Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790429C330
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893807; cv=none; b=Oc8aG/8rOtwL2EvOPlZW93P36uGBreekQ8dY20ncAhlLvps1hgsfmuhUvg2989TTzwXiLNJnE9b0HWWO0PDwKflMh/hh66TpD/WKQA46I/YV3vBIgauyfB3WAhtblYLz/zoV1Scn979gL3PQp5iXTbVfTgk1lhIEpcDflWJl69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893807; c=relaxed/simple;
	bh=7NN186CT8CJAdaWV0j0NG5Lut9iL7tdeve9CeVitu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8KX2uOqbz3SYntl5cRj/MK6+/Tgxjcg9B7EtozGnY6RYi9QGGc77H7D7sWQ6DVwhn9i5lsZr697mr+v6UOh7/+F437xv5VM84QT1jmOJ2TrLyG5oZDxOXL5Tb3d70hxFhuu1FoKj/uJEu73ae4G844FZ2ZxuFXin4AaOh3C/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTbLhjAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTbLhjAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745893804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2SOrSEkw2c9XB3ydIfbVCEE1PQH0GoWk0aP+fX5u0A=;
	b=FTbLhjASqGMN73lHDAqqfRM4Uks6e/dAQseaYNozSQZWkshobh+XnIw9DILSDeIRBLZJv2
	3FiV0jhgT5nYNb5D8QTNqLpZmTzfqEWUKJdl8oUf+u+20iU8KXmyTvnHNXFcCA0Rsw/Vqj
	qsrhcv8sMm+qiUXKeCS5IfrC7haRp7U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-h7N_jTdQNWePCbVukbGiUQ-1; Mon,
 28 Apr 2025 22:30:03 -0400
X-MC-Unique: h7N_jTdQNWePCbVukbGiUQ-1
X-Mimecast-MFC-AGG-ID: h7N_jTdQNWePCbVukbGiUQ_1745893802
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 169951956096;
	Tue, 29 Apr 2025 02:30:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.57])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 100391956094;
	Tue, 29 Apr 2025 02:30:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 v2 3/4] ublk: enhance check for register/unregister io buffer command
Date: Tue, 29 Apr 2025 10:29:38 +0800
Message-ID: <20250429022941.1718671-4-ming.lei@redhat.com>
In-Reply-To: <20250429022941.1718671-1-ming.lei@redhat.com>
References: <20250429022941.1718671-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
register/unregister io buffer easily, so check it before calling
starting to register/un-register io buffer.

Also only allow io buffer register/unregister uring_cmd in case of
UBLK_F_SUPPORT_ZERO_COPY.

Also mark argument 'ublk_queue *' of ublk_register_io_buf as const.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0a3a3c64316d..c624d8f653ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -201,7 +201,7 @@ struct ublk_params_header {
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset);
+		const struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
@@ -1949,13 +1949,20 @@ static void ublk_io_release(void *priv)
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
-				struct ublk_queue *ubq, unsigned int tag,
+				const struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	const struct ublk_io *io = &ubq->ios[tag];
 	struct request *req;
 	int ret;
 
+	if (!ublk_support_zero_copy(ubq))
+		return -EINVAL;
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
@@ -1971,8 +1978,17 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
+				  const struct ublk_queue *ubq, unsigned int tag,
 				  unsigned int index, unsigned int issue_flags)
 {
+	const struct ublk_io *io = &ubq->ios[tag];
+
+	if (!ublk_support_zero_copy(ubq))
+		return -EINVAL;
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
@@ -2076,7 +2092,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
+		return ublk_unregister_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
@@ -2128,7 +2144,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset)
+		const struct ublk_queue *ubq, int tag, size_t offset)
 {
 	struct request *req;
 
-- 
2.47.0

