Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC073B0AF8
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707142; cv=none; b=RzebdRiTXm7DPRgrHe0PlGSLx1ltZIfUeFxLAt7zkgVsXRiQbX9KSAcY2wsV51kT8tc8sjarvB7ZCaH6hKRZhWA+ZDHXNA+qYjuCcVph+yiwJ313IrfiAd8PEXTAAubNXi0afi0rBjJ1KB2LpcMbATiZNoT85A3AuwA0N64/MZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707142; c=relaxed/simple;
	bh=MGgdaCEh0VVf+4B/Ue9J9fNwUy2/6sWovfRR+7FIpYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAlw5pgh/0VCZo5ryezjOo9oVotOVI1YqEyFh4KFHomX2zceXKw+jKp3EHU2QWRe5DaXfVK9+fHMz0PVWlqeE+PTgNvOu9lMnGN8BW8hqcEN9hlr9sUiI6Z3F/QFQU54prtDSlEnHox16geI2CZSmwwR8CFAnoGYkSmfyKH7mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NYtcs8Rb; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NYtcs8Rb"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7dbb4fdc04eso834077a34.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778707140; x=1779311940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RL+c9P8SmaEdh8EwEPUVpE5hpSk6rZenkEZDNdBL5U=;
        b=NYtcs8RbJxughkEl+3ls+6XzCSkauLxbQOhGgeZa7WlOuTtE6bMP907O3aEe4tMfnk
         JECQFpK2Z7bLbWfwwOVlgLI4nuC1KfIeG0KDEAKHhBWQIA7Vr7H81DfjmWIF1MUuypx5
         8R5IxAMM7BvcU7xNtPH5fLkcuYcVp9EXKZqCqPIWQ1yk9Ls0AReTUqbXJEaGxL7hFlHG
         azewSEWhYb31Wh/PuYDxOz1A7bB4lUINd7Hyg1Vk9x2MWXpRn6HLGJVrTxSn5ZwT6fdx
         psUzjvHzmoBckJ1XV9Bxig5GBK3C7PiYaPuPI87ksr8eAIpUwX9yLAUwXuNj+qRJaQy5
         jF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707140; x=1779311940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RL+c9P8SmaEdh8EwEPUVpE5hpSk6rZenkEZDNdBL5U=;
        b=rfGR6A21gZKKRKFWTMJktG8vz6vE37SgD+8iygKcDS3h4nQtkd+P2m1YL/P0kGnaOS
         QUWq2wil9Pmn6yXAjgACR+kHwF5boYejDCMu+6JDJYHvXNjhM2KZNyWTA/18On6pC5l6
         IrdvFJSeX93DIViS+PcWLanzlWsDtTMqBPqraYU8yjob1FE7cbokYDMLydeYAQLF6LrZ
         2a1dFxmWhg7Ml+Iyi7MfPZEbS+Cxz0byTIpazQV5OyMUK7jKsjUohLajDDkErmsiLziw
         /CKiwyMJtgniuxyggi/QL1pQBpRemeykozkx/JbmaJ/c9HuHSoJimCYISkUuWtYaoEgz
         lt2w==
X-Gm-Message-State: AOJu0YwRv6YPS6mvqrmXAZJpyOdZU1lfBfRpKUtii1SiPT+7TevFBXo0
	aeraavfjDP/y1JoPb01t3oPDJ/20/AZ1Q8e01C81leNvc95Mgb9Bvd6x7k9V0SZk7kw3yGmEM+5
	YwBhjMN0klFfBbvrAJc2afe3GQT3NHUshkN4+
X-Gm-Gg: Acq92OEDHZMJEFZu3N+FdH1L7BRPn4ZfE/hdoKg3efwKqsbdyrVFmgeBdPN5+LOWS8o
	/GunPQi53UgnbcyNiibN8YlAfNn0bssmFq6omEFrVqS4agHT5nrr22tufBpC9mH4OmVdW4nfmrO
	janw8QVrAvNZ8lkt2fF+javi4E4LCeRMWEm8A/KVEHCz7Z6HFJ4Nthe3QYMhh0qhjdFQ9ytfR5d
	ZmgTKUQxSImnanLwZrXuMHlp8MbWtnFR/XMJut8ai1mxrAsrBkjrUGPovlsFCqMgrB2Kx++p8h5
	mCw7+vrq3tdEJeVfaUdyGpWqIiwfybQ19hkP+VQVC1QbpfuMUA2toa5U3dpf5nvOPPmZ5n/ncYo
	siltwzw0DBuAAT89ZoJxCDb2aA8l7kxBJaM2xEgH9O+ZILX1AqBDr7pD5fgq2rQVo
X-Received: by 2002:a05:6830:3105:b0:7de:427d:34a8 with SMTP id 46e09a7af769-7e3da48d68dmr2072852a34.3.1778707139768;
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7e3f3bc2ed7sm49525a34.5.2026.05.13.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n22m09-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:449])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EF74341BA7;
	Wed, 13 May 2026 15:18:59 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 47DA6E41188; Wed, 13 May 2026 15:18:59 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 2/2] ublk: optimize ublk_rq_has_data()
Date: Wed, 13 May 2026 15:18:46 -0600
Message-ID: <20260513211846.1956810-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513211846.1956810-1-csander@purestorage.com>
References: <20260513211846.1956810-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_rq_has_data() currently uses bio_has_data(), which involves 2
indirections and several branches. Use blk_rq_has_data() instead to save
an indirection and NULL check.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e5f3738c203..4d7efc12247c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1170,15 +1170,10 @@ static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
 		int qid)
 {
 	return dev->queues[qid];
 }
 
-static inline bool ublk_rq_has_data(const struct request *rq)
-{
-	return bio_has_data(rq->bio);
-}
-
 static inline struct ublksrv_io_desc *
 ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
@@ -1387,16 +1382,16 @@ static size_t ublk_copy_user_integrity(const struct request *req,
 }
 #endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
 
 static inline bool ublk_need_map_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
+	return blk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
 static inline bool ublk_need_unmap_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) &&
+	return blk_rq_has_data(req) &&
 	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
 static unsigned int ublk_map_io(const struct ublk_queue *ubq,
 				const struct request *req,
@@ -1506,11 +1501,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
 
 	/* Try shmem zero-copy match before setting addr */
-	if (ublk_support_shmem_zc(ubq) && ublk_rq_has_data(req)) {
+	if (ublk_support_shmem_zc(ubq) && blk_rq_has_data(req)) {
 		u32 buf_idx, buf_off;
 
 		if (ublk_try_buf_match(ubq->dev, req,
 					  &buf_idx, &buf_off)) {
 			iod->op_flags |= UBLK_IO_F_SHMEM_ZC;
@@ -1796,11 +1791,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
 	}
 
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+	if (ublk_support_auto_buf_reg(ubq) && blk_rq_has_data(req)) {
 		ublk_auto_buf_dispatch(ubq, req, io, io->cmd, issue_flags);
 	} else {
 		ublk_init_req_ref(ubq, io);
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 	}
@@ -1817,11 +1812,11 @@ static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
 	struct io_uring_cmd *cmd = data->cmd;
 
 	if (!ublk_start_io(ubq, req, io))
 		return false;
 
-	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+	if (ublk_support_auto_buf_reg(ubq) && blk_rq_has_data(req)) {
 		res = ublk_auto_buf_register(ubq, req, io, cmd,
 				data->issue_flags);
 
 		if (res == AUTO_BUF_REG_FAIL)
 			return false;
@@ -3198,11 +3193,11 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
 		return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
 					    issue_flags);
 
-	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
+	if (!ublk_dev_support_zero_copy(ub) || !blk_rq_has_data(req))
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret)
@@ -3481,11 +3476,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		return NULL;
 
 	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
 		goto fail_put;
 
-	if (!ublk_rq_has_data(req))
+	if (!blk_rq_has_data(req))
 		goto fail_put;
 
 	return req;
 fail_put:
 	ublk_put_req_ref(io, req);
@@ -4054,11 +4049,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		/* On daemon, io can't be completed concurrently, so skip ref */
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			return -EINVAL;
 
 		req = io->req;
-		if (!ublk_rq_has_data(req))
+		if (!blk_rq_has_data(req))
 			return -EINVAL;
 	} else {
 		req = __ublk_check_and_get_req(ub, q_id, tag, io);
 		if (!req)
 			return -EINVAL;
-- 
2.54.0

