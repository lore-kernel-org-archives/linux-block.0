Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D87E110
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761800; cv=none; b=IGIp+Ke99X3OPfykwTsOzrrtCwL2Vf6shZdKBtM/0zCEe0Tf5/MKpjueHOyYDersTH7qpPCUjw+Ys/vJtCDNRw370ND5ZmmI6jIU8DTWb4d7J+DcfZkFzL0gEWP+jSLSte8+fREBMPMfwkvr7sxrFfeGxUK4Suu/3+woP3yOXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761800; c=relaxed/simple;
	bh=Wd84OjH6K69QyRsADU1xSCN/L8XlChHY486bup6yxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH9/2lW3RAm4jReXL6bzFiZQWIxu5J607ZST4wj50E9F2CTN0/3auZkFkz9Sbo6HdOSHjhoEP367Il5yoJ0uxNy3kbCA19NhERFTf4SHmgHT7X2hVKKnpRQvqU6gxUhvnzYxtrB3PGbs9CbubyB8bU9kGP++Sk7Bfr5HqUqGmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXi7MsjW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXi7MsjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745761798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qwho21ldxENYlaVLPakGXGz2WMwPpJOkMjIzVuFlJB4=;
	b=bXi7MsjWl3rDT+iN8ABmwj26/Cf/ouZhERhWNWfh1IiE8tHOP7gdJgI5u1hoTekI6cq5zo
	kw3amvYdPx9hBqNSel4ISOeRK4xXZGE1ZKFGh7GakzGUeY65a4Y1oFaAyydWd6CyhgiyzT
	q50OlFlh+JbTD5ond6KES+E2VZWh3cg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-WE5BsF0cO0ewiiOGpPB4Lw-1; Sun,
 27 Apr 2025 09:49:54 -0400
X-MC-Unique: WE5BsF0cO0ewiiOGpPB4Lw-1
X-Mimecast-MFC-AGG-ID: WE5BsF0cO0ewiiOGpPB4Lw_1745761793
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28E911800264;
	Sun, 27 Apr 2025 13:49:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.119])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F8B41800368;
	Sun, 27 Apr 2025 13:49:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 2/3] ublk: decouple zero copy from user copy
Date: Sun, 27 Apr 2025 21:49:28 +0800
Message-ID: <20250427134932.1480893-3-ming.lei@redhat.com>
In-Reply-To: <20250427134932.1480893-1-ming.lei@redhat.com>
References: <20250427134932.1480893-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY are two different
features, and shouldn't be coupled together.

Commit 1f6540e2aabb ("ublk: zc register/unregister bvec") enables
user copy automatically in case of UBLK_F_SUPPORT_ZERO_COPY, this way
isn't correct.

So decouple zero copy from user copy, and use independent helper to
check each one.

Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 40f971a66d3e..0a3a3c64316d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -205,11 +205,6 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
-static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
-}
-
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_ZONED;
@@ -609,14 +604,19 @@ static void ublk_apply_params(struct ublk_device *ub)
 		ublk_dev_param_zoned_apply(ub);
 }
 
+static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
-	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
+	return ubq->flags & UBLK_F_USER_COPY;
 }
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq);
+	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -624,8 +624,11 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	/*
 	 * read()/write() is involved in user copy, so request reference
 	 * has to be grabbed
+	 *
+	 * for zero copy, request buffer need to be registered to io_uring
+	 * buffer table, so reference is needed
 	 */
-	return ublk_support_user_copy(ubq);
+	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
@@ -2245,6 +2248,9 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 	if (!ubq)
 		return ERR_PTR(-EINVAL);
 
+	if (!ublk_support_user_copy(ubq))
+		return ERR_PTR(-EACCES);
+
 	if (tag >= ubq->q_depth)
 		return ERR_PTR(-EINVAL);
 
@@ -2783,13 +2789,18 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
-	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ublk_dev_is_user_copy(ub))
+	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
+	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
-	/* Zoned storage support requires user copy feature */
+	/*
+	 * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
+	 * returning write_append_lba, which is only allowed in case of
+	 * user copy or zero copy
+	 */
 	if (ublk_dev_is_zoned(ub) &&
-	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !ublk_dev_is_user_copy(ub))) {
+	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
+	     (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
 		ret = -EINVAL;
 		goto out_free_dev_number;
 	}
-- 
2.47.0

