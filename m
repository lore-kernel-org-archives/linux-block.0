Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EF450F2
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798088; cv=none; b=r0XFJDGKnujQmeTput+7tu3csaelfJ0abkTmI1q8QGMQ3iDjtG9WfAVCHuYs03Jm3/vDa8aEVoojM1MLk//2GWw/b1p79xzflnvWqXqlXlrN3z2DQ/k9TK2UEl3RFJI/w9IsqJgaEGw1xZjGEoBBPo8rcyT9H2/+yuAyIa5KiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798088; c=relaxed/simple;
	bh=9YJWkJAZGaiKuwWtut35OPWXFZMzpp5M0lyBBGoKPfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYN6qpReEvurN+mcyjz5DXoDaWjKJatbhOLoF+Axc0DZ9Aq0JeRkpg60RKKYdhwl7AnwQZI8K+nLuYg+MSBf/X4+BwHdNQTcyJtMnKkcFXdQvxGx/9l8BSY3Hymjgsn5dM7kJW8HX2BkWMIJSwh8l4AMu5fw3wSafmqVxLnef/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMyCFDdD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMyCFDdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773798086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HxkDYR8QR6lzy9ttIMQsAtwgRvAWKYnMXhKGhySf2XY=;
	b=WMyCFDdDf+44WCqWtbHU4aYRwjSD9OTlKitHi/K28N+2EBcFYbJdZCArWR8ULk920Ve6Ms
	xYf/Ny/5+d3uI2cv3Ucr0J6vrI1AR1ylGee100lPrcuIcicIn1XeG2HbuitXYdERJyDLFU
	6ONRf5I/5LHOsKgV5RIbkk/0/tPxw5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-svZNPguYNu--NifijAGUMg-1; Tue,
 17 Mar 2026 21:41:23 -0400
X-MC-Unique: svZNPguYNu--NifijAGUMg-1
X-Mimecast-MFC-AGG-ID: svZNPguYNu--NifijAGUMg_1773798082
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F39EF1800344;
	Wed, 18 Mar 2026 01:41:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4221F180075B;
	Wed, 18 Mar 2026 01:41:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: move cold paths out of __ublk_batch_dispatch() for icache efficiency
Date: Wed, 18 Mar 2026 09:41:12 +0800
Message-ID: <20260318014112.3125432-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mark ublk_filter_unused_tags() as noinline since it is only called from
the unlikely(needs_filter) branch. Extract the error-handling block from
__ublk_batch_dispatch() into a new noinline ublk_batch_dispatch_fail()
function to keep the hot path compact and icache-friendly. This also
makes __ublk_batch_dispatch() more readable by separating the error
recovery logic from the normal dispatch flow.

Before: __ublk_batch_dispatch is ~1419 bytes
After:  __ublk_batch_dispatch is ~1090 bytes (-329 bytes, -23%)

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 70 ++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 63aeb7a76a8c..dc8720ad6115 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1789,7 +1789,7 @@ static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
  * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
  * Returns the new length after filtering.
  */
-static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
+static noinline unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
 					    unsigned int len)
 {
 	unsigned int i, j;
@@ -1805,6 +1805,41 @@ static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
 	return j;
 }
 
+static noinline void ublk_batch_dispatch_fail(struct ublk_queue *ubq,
+		const struct ublk_batch_io_data *data,
+		unsigned short *tag_buf, size_t len, int ret)
+{
+	int i, res;
+
+	/*
+	 * Undo prep state for all IOs since userspace never received them.
+	 * This restores IOs to pre-prepared state so they can be cleanly
+	 * re-prepared when tags are pulled from FIFO again.
+	 */
+	for (i = 0; i < len; i++) {
+		struct ublk_io *io = &ubq->ios[tag_buf[i]];
+		int index = -1;
+
+		ublk_io_lock(io);
+		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
+			index = io->buf.auto_reg.index;
+		io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
+		io->flags |= UBLK_IO_FLAG_ACTIVE;
+		ublk_io_unlock(io);
+
+		if (index != -1)
+			io_buffer_unregister_bvec(data->cmd, index,
+					data->issue_flags);
+	}
+
+	res = kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
+		tag_buf, len, &ubq->evts_lock);
+
+	pr_warn_ratelimited("%s: copy tags or post CQE failure, move back "
+			"tags(%d %zu) ret %d\n", __func__, res, len,
+			ret);
+}
+
 #define MAX_NR_TAG 128
 static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 				 const struct ublk_batch_io_data *data,
@@ -1848,37 +1883,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 
 	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * tag_sz);
 	ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
-	if (unlikely(ret < 0)) {
-		int i, res;
-
-		/*
-		 * Undo prep state for all IOs since userspace never received them.
-		 * This restores IOs to pre-prepared state so they can be cleanly
-		 * re-prepared when tags are pulled from FIFO again.
-		 */
-		for (i = 0; i < len; i++) {
-			struct ublk_io *io = &ubq->ios[tag_buf[i]];
-			int index = -1;
-
-			ublk_io_lock(io);
-			if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
-				index = io->buf.auto_reg.index;
-			io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
-			io->flags |= UBLK_IO_FLAG_ACTIVE;
-			ublk_io_unlock(io);
-
-			if (index != -1)
-				io_buffer_unregister_bvec(data->cmd, index,
-						data->issue_flags);
-		}
-
-		res = kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
-			tag_buf, len, &ubq->evts_lock);
-
-		pr_warn_ratelimited("%s: copy tags or post CQE failure, move back "
-				"tags(%d %zu) ret %d\n", __func__, res, len,
-				ret);
-	}
+	if (unlikely(ret < 0))
+		ublk_batch_dispatch_fail(ubq, data, tag_buf, len, ret);
 	return ret;
 }
 
-- 
2.47.0

