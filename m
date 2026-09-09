Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E148EC73
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992958; cv=none; b=hV3YYRySBUXNTu6pwNbk3v1YJyOQwlo4EHRdLISi+qUuz8tjm1WzBgHRDjB+OGAamyKDSb3pl/tr+WQeaO7MdH0WbJWyz2qRAcBLdFx2leT2h9pAVrv4PihhXpbVBJpb/4n9k1rRxdRAbFSCgpyYdN0pQlky2htJJj9Ndcm9odY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992958; c=relaxed/simple;
	bh=Y6jx5aTPCjcHCvNdP8/O5bbbCvk9DUcwaVIqR2GXaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0CUdBkZ9EKJTFTG10NE7Crrk+RdBVNssUWjrWCVs4s/P9HV/tILoBCpmFuIIVy/Va4D2j3JJF/t6YasuC5smMsmuaguhpo0ySPjlduWab4BxIx9PhpIDZaomBrZQu3ScDZ7eWR35Ky9nB46ypBsLoICDNnFK82yDuMDszVDato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U3zYG8FG; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U3zYG8FG"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2db3728f0c4so396605ad.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/XCD1uvPOJyUiPbDDQ58GyUdQGYRiCCBtvMcX3nnGY=;
        b=U3zYG8FGJozjx9rGIndZZqS+MVtMIeRoO/iKFGLw9gpeFcDeX42e98DT19YD+B1Pt/
         AMkfyg4isW06WQlhf2REXSWlrAlKgGKw2yMDxuoX1sUX4EBLRnypR3e8mMv4ui3puay2
         ClLvJC+wCSefPB5m/UjhgxwP3RFA35/09ruGxKnCm6GZZhEZZnSbrdG9EA4dxzmpMYdv
         SWuMrc2a/PlPOGbWpcnUiUMwW/YMsTt7K6bM4V3wBOy0VHDl9W+81CZl/yMnv+yJhnEN
         GromVttp92g68II/uSWS0Q59q6WyKNLxw3yNWWFhlZxf2u6O56XHn97qo/mAsyfWUPSW
         s63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/XCD1uvPOJyUiPbDDQ58GyUdQGYRiCCBtvMcX3nnGY=;
        b=PtsFtOHirj+UMrGmB16k5iw1CAEGUemM9XdGYYp+B5HpkiY7MlddGX64TFZNaxaMFf
         bA/RKNOQv+GL+9J0B0qql7msy8tv3T/P2TlhBVVE3+1it58qMsTGaYZXlODWoexjx0v/
         d1QHOn6iaBhjFyfZdCJg8jTdbjnE2PcxE10bGLTGjI+vi/NiYkWRRzWFyV6f8JR9cPE9
         0jU7xDbkHGvhSaAaMJyJxqf7oFaNYy0uKGWsLQWk7RxUr9IXXT5G0urB8IB4jiu2PxO6
         Yr5ke1VMvDKY+mztVoP3hK8xZZN6MEg9i5ShxkFKxRQLTJSImruZupTgADnestYwur8b
         EH0g==
X-Forwarded-Encrypted: i=1; AKwUvBwmZuNhCmUd2dAfznGxDiQF7A6Xhu5gA7jWyWnOBOsilE4ALeE96qs9y9PK58gRvChe+Ta1ziolN2sC8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mCuwwrLGk4YYzZAeQeHCyFosTrYW95usQ7L4F1P+DjRPVApeVR
	56xjfCiUaz+JnLAILee0QFKHg9G4xq0LJppKDjX505zsyqz4tPpeEHx3GUbdIGaHsT0tc0FS8nJ
	MN6Y3ImwOEvNeZJSWTbNrzYrav9VznqqaUCfu
X-Gm-Gg: AYBFou2Ul+NIEIIxrotr09VPG64EX6Ohzdm/Lnu4e8frccQNPmb65rLYspBPxurR5W9
	UKfw6/QkLxggII1h8Q3qa+1MPFkAM7DuBeQl5DjHj3SOqaPJu7uIPqBGg4qP5PV4gDa5MAiAAW4
	0bnQ9mEZztqMGXuaxccqF8cfClii4poEjNgLZZZ4QScO/Boyg2Dh9J6tH0gxYKOsgWMLgr3mgSR
	M4uSjXFBCtJBPsVT4NGwyceuAWEiQ6LYJ17VvYMoIP5g8P2DcYS3fXP5zwMbgQOPKVvWKxw1N6J
	iTFsWNRN7PuJTzsyMBr7BHSFZq9sYe1Uer+4t0cvATtinmVc77LLtqf5DpPPlM97itjG4c294wC
	oOKZx98Eks/HY5vDA3FkUj/QrH4V1z8vh
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id 98e67ed59e1d1-39b3d86acf2mr28286214a91.5.1788992944093;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d77406179sm490126a91.5.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6EFA1401CC;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6C2CBE40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] nvme/ioctl: pass iov_iter to nvme_map_user_request()
Date: Wed,  9 Sep 2026 16:28:34 -0600
Message-ID: <20260909222836.2475352-5-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow nvme_map_user_request() to accept an io_uring registered buffer
(represented as a ITER_BVEC iov_iter) for the metadata buffer, pass it
as an iov_iter argument. Move the conversions from user address-length
pairs into iov_iters to the callers. A NULL iov_iter pointer represents
no metadata buffer.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e69c49c334a0..8e722184ecf1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -152,21 +152,20 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct iov_iter *iter, unsigned int flags)
+		unsigned bufflen, struct iov_iter *iter,
+		struct iov_iter *meta_iter, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
-	bool has_metadata = meta_buffer && meta_len;
 	int ret;
 
-	if (has_metadata && !supports_metadata)
+	if (meta_iter && !supports_metadata)
 		return -EINVAL;
 
 	if (iter)
 		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
 	else
@@ -174,16 +173,12 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
 	if (ret)
 		return ret;
 
-	if (has_metadata) {
-		struct iov_iter meta_iter;
-
-		iov_iter_ubuf(&meta_iter, rq_data_dir(req), meta_buffer,
-			      meta_len);
-		ret = blk_rq_integrity_map_user(req, &meta_iter);
+	if (meta_iter) {
+		ret = blk_rq_integrity_map_user(req, meta_iter);
 		if (ret)
 			goto out_unmap;
 	}
 
 	return ret;
@@ -210,12 +205,20 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
-		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags);
+		struct iov_iter meta_iter;
+		struct iov_iter *map_meta_iter = NULL;
+
+		if (meta_buffer && meta_len) {
+			iov_iter_ubuf(&meta_iter, rq_data_dir(req), meta_buffer,
+				      meta_len);
+			map_meta_iter = &meta_iter;
+		}
+		ret = nvme_map_user_request(req, ubuffer, bufflen, NULL,
+					    map_meta_iter, flags);
 		if (ret)
 			goto out_free_req;
 	}
 
 	bio = req->bio;
@@ -480,18 +483,19 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
 							       struct nvme_uring_cmd);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
 	struct nvme_command c;
-	struct iov_iter iter;
-	struct iov_iter *map_iter = NULL;
+	struct iov_iter iter, meta_iter;
+	struct iov_iter *map_iter = NULL, *map_meta_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	u32 metadata_len, data_len;
 	u64 metadata, addr;
 	u32 timeout_ms;
+	int ddir;
 	int ret;
 
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -520,13 +524,12 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	addr = READ_ONCE(cmd->addr);
 	data_len = READ_ONCE(cmd->data_len);
 	metadata_len = READ_ONCE(cmd->metadata_len);
 	timeout_ms = READ_ONCE(cmd->timeout_ms);
 
+	ddir = nvme_is_write(&c) ? WRITE : READ;
 	if (data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		int ddir = nvme_is_write(&c) ? WRITE : READ;
-
 		if (vec)
 			ret = io_uring_cmd_import_fixed_vec(ioucmd,
 					u64_to_user_ptr(addr), data_len,
 					ddir, &iter, issue_flags);
 		else
@@ -535,10 +538,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		if (ret < 0)
 			return ret;
 
 		map_iter = &iter;
 	}
+	if (data_len && metadata && metadata_len) {
+		iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
+			      metadata_len);
+		map_meta_iter = &meta_iter;
+	}
 
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
 	}
@@ -549,13 +557,13 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 
 	if (data_len) {
-		ret = nvme_map_user_request(req, addr, data_len,
-			nvme_to_user_ptr(metadata), metadata_len,
-			map_iter, vec ? NVME_IOCTL_VEC : 0);
+		ret = nvme_map_user_request(req, addr, data_len, map_iter,
+					    map_meta_iter,
+					    vec ? NVME_IOCTL_VEC : 0);
 		if (ret)
 			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
-- 
2.55.0

