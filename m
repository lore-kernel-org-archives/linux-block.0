Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2F79C2
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518096; cv=none; b=BPStSeo1tDHledh/IXIs79Cywzv/Q3w5j9xsTK3TGXjbIpt5yJRry0s0nIhOfUM1fejCLfb+XYWqaubqPqsW3WTycDp0bg7bwShVCTV7Ez031jSq2sUQBFrocuwhP74tKOZf67nIzP7uFasGPWaWi0kxSf3O089bEa3UA3jN8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518096; c=relaxed/simple;
	bh=vwVkl2AvR207GF3yS7P18meBn53mtP3g/XP/6BqwQCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pl7qWkmxRQvAYJRMgSELn+8HO3jMc+pwhOX/LXvUNWklVA3zD/xJWD+iWf4nWMc0Q4wyFSLMGVlmNtdViiM2EbrmN1jjArkWZ4Mq1fUVbkE3nHATT6HRteVn0QiDWI5HtWKoKOMYtQeNPTAVMeA+kU2BDj7ChdfOOswvy80iyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiTx3l9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiTx3l9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742518092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uSXy+/A4Aie58AzmTbsuDZnEYoP8mJ9RD+6yp+n/J6A=;
	b=FiTx3l9TzlKLoxhEqKMHqSPmVsq2A+C79CAr5TWI7gQtTrpN/rUds0AyRxt8SpqvY30f9Y
	METq+9Pv96tHyVkr43qE9fe1LPcs4B0wqFPfuz/FpwQaoGNJnYvuhkwh4+ib31Gr9+i56b
	PWIfc83pkXyzK0rdz8Oj9A/nYSu2oDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-Z8x6wdUkPOqZy2L9eOfHuA-1; Thu,
 20 Mar 2025 20:48:08 -0400
X-MC-Unique: Z8x6wdUkPOqZy2L9eOfHuA-1
X-Mimecast-MFC-AGG-ID: Z8x6wdUkPOqZy2L9eOfHuA_1742518086
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FDA5180049D;
	Fri, 21 Mar 2025 00:48:05 +0000 (UTC)
Received: from localhost (unknown [10.72.120.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27D091955DCE;
	Fri, 21 Mar 2025 00:48:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: fix write cache implementation
Date: Fri, 21 Mar 2025 08:47:58 +0800
Message-ID: <20250321004758.152572-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

For loop target, write cache isn't enabled, and each write isn't be
marked as DSYNC too.

Fix it by enabling write cache, meantime fix FLUSH implementation
by not taking LBA range into account, and there isn't such info
for FLUSH command.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 38e68b414962..8a07356eccaf 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -123,10 +123,7 @@ static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 		sqe = ublk_queue_alloc_sqe(q);
 		if (!sqe)
 			return -ENOMEM;
-		io_uring_prep_sync_file_range(sqe, 1 /*fds[1]*/,
-				iod->nr_sectors << 9,
-				iod->start_sector << 9,
-				IORING_FSYNC_DATASYNC);
+		io_uring_prep_fsync(sqe, 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
 		q->io_inflight++;
 		sqe->user_data = build_user_data(tag, ublk_op, UBLK_IO_TGT_NORMAL, 1);
@@ -187,6 +184,7 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 	struct ublk_params p = {
 		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN,
 		.basic = {
+			.attrs = UBLK_ATTR_VOLATILE_CACHE,
 			.logical_bs_shift	= 9,
 			.physical_bs_shift	= 12,
 			.io_opt_shift	= 12,
-- 
2.47.1

