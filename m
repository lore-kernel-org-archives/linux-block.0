Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAB41B365
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971155; cv=none; b=nR2+MYpitTCV7kzBQvLVCKusqelednL7bIHdyuoKMsDDzNnNhw6navUfkUF5ykGQZpgVUH6LcAi4Ax2T+CYnNBkuL71quX37ZIFDe5bgE6bNyoMhhPOkHWBScBTfDZpLBAWy5tOWwN+qai/AG/+bOIS4aBXO429MasCEUJgzeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971155; c=relaxed/simple;
	bh=vRzpUaHNxe1y4u2Wi5A9G+1kAbheQBItPIPb0bpe5X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZDl060E0UXSxZXZgmtJUEu/1/lyF7IAsx3ZL4E4/qVOjCucX57JfBRrszjuHsElGpANCYKKqM0A0wejfAjoY++ip/tjTrPWlToCcI01ymG9/VLgspKhuf35altFJ7Qr1X5JBNMxBNACQrjdZeJA+joKp/FCKwiO/DUS+XGe1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPsZcPT7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPsZcPT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9uiRfTyu9+LMmxIP5fComut/fpLEG50DEFfBWES72M=;
	b=cPsZcPT76yHuSSCUVTLPLcXMd4syOLgT9zTYsB0eWg9Z76kpJC8sMs8PIq5tFsGAxWOPYC
	KM8RGT4RwG3adsTYHoOagDD0Yo6SdJyAg90PmFvUjPe10pnVZDG+Z9Jm1xDe43MjHqZRyj
	7mi/A98C+A49aypHPgncI+qOyJyI1o4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-OIrFp6P2MPK6CdSZt0jk9Q-1; Tue,
 31 Mar 2026 11:32:24 -0400
X-MC-Unique: OIrFp6P2MPK6CdSZt0jk9Q-1
X-Mimecast-MFC-AGG-ID: OIrFp6P2MPK6CdSZt0jk9Q_1774971143
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DB5B1956076;
	Tue, 31 Mar 2026 15:32:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21AE519560AB;
	Tue, 31 Mar 2026 15:32:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 02/10] ublk: add PFN-based buffer matching in I/O path
Date: Tue, 31 Mar 2026 23:31:53 +0800
Message-ID: <20260331153207.3635125-3-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add ublk_try_buf_match() which walks a request's bio_vecs, looks up
each page's PFN in the per-device maple tree, and verifies all pages
belong to the same registered buffer at contiguous offsets.

Add ublk_iod_is_shmem_zc() inline helper for checking whether a
request uses the shmem zero-copy path.

Integrate into the I/O path:
- ublk_setup_iod(): if pages match a registered buffer, set
  UBLK_IO_F_SHMEM_ZC and encode buffer index + offset in addr
- ublk_start_io(): skip ublk_map_io() for zero-copy requests
- __ublk_complete_rq(): skip ublk_unmap_io() for zero-copy requests

The feature remains disabled (ublk_support_shmem_zc() returns false)
until the UBLK_F_SHMEM_ZC flag is enabled in the next patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ac6ccc174d44..d53865437600 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -356,6 +356,8 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static bool ublk_try_buf_match(struct ublk_device *ub, struct request *rq,
+				  u32 *buf_idx, u32 *buf_off);
 static void ublk_buf_cleanup(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
@@ -426,6 +428,12 @@ static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
 	return false;
 }
 
+static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
+					unsigned int tag)
+{
+	return ublk_get_iod(ubq, tag)->op_flags & UBLK_IO_F_SHMEM_ZC;
+}
+
 static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
 {
 	return false;
@@ -1494,6 +1502,18 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
 
+	/* Try shmem zero-copy match before setting addr */
+	if (ublk_support_shmem_zc(ubq) && ublk_rq_has_data(req)) {
+		u32 buf_idx, buf_off;
+
+		if (ublk_try_buf_match(ubq->dev, req,
+					  &buf_idx, &buf_off)) {
+			iod->op_flags |= UBLK_IO_F_SHMEM_ZC;
+			iod->addr = ublk_shmem_zc_addr(buf_idx, buf_off);
+			return BLK_STS_OK;
+		}
+	}
+
 	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
@@ -1539,6 +1559,10 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
+	/* shmem zero copy: no data to unmap, pages already shared */
+	if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
+		goto exit;
+
 	/* for READ request, writing data in iod->addr to rq buffers */
 	unmapped_bytes = ublk_unmap_io(need_map, req, io);
 
@@ -1697,8 +1721,13 @@ static void ublk_auto_buf_dispatch(const struct ublk_queue *ubq,
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
 {
-	unsigned mapped_bytes = ublk_map_io(ubq, req, io);
+	unsigned mapped_bytes;
 
+	/* shmem zero copy: skip data copy, pages already shared */
+	if (ublk_iod_is_shmem_zc(ubq, req->tag))
+		return true;
+
+	mapped_bytes = ublk_map_io(ubq, req, io);
 
 	/* partially mapped, update io descriptor */
 	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
@@ -5458,7 +5487,53 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
 	mtree_destroy(&ub->buf_tree);
 }
 
+/* Check if request pages match a registered shared memory buffer */
+static bool ublk_try_buf_match(struct ublk_device *ub,
+				   struct request *rq,
+				   u32 *buf_idx, u32 *buf_off)
+{
+	struct req_iterator iter;
+	struct bio_vec bv;
+	int index = -1;
+	unsigned long expected_offset = 0;
+	bool first = true;
+
+	rq_for_each_bvec(bv, rq, iter) {
+		unsigned long pfn = page_to_pfn(bv.bv_page);
+		struct ublk_buf_range *range;
+		unsigned long off;
 
+		range = mtree_load(&ub->buf_tree, pfn);
+		if (!range)
+			return false;
+
+		off = range->base_offset +
+			(pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offset;
+
+		if (first) {
+			/* Read-only buffer can't serve READ (kernel writes) */
+			if ((range->flags & UBLK_SHMEM_BUF_READ_ONLY) &&
+			    req_op(rq) != REQ_OP_WRITE)
+				return false;
+			index = range->buf_index;
+			expected_offset = off;
+			*buf_off = off;
+			first = false;
+		} else {
+			if (range->buf_index != index)
+				return false;
+			if (off != expected_offset)
+				return false;
+		}
+		expected_offset += bv.bv_len;
+	}
+
+	if (first)
+		return false;
+
+	*buf_idx = index;
+	return true;
+}
 
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		u32 cmd_op, struct ublksrv_ctrl_cmd *header)
-- 
2.53.0

