Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1718E25
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720994; cv=none; b=krAX0qsKYfQ5IB62PV3SZL276cG/yTj4cN6uYkoPslROhRVfdDfB6clGd6PNWrAj4mQiJ9cmXAP7QWi+zli+6BUR0c5Hv1ue6TwmRYj6BzlL/sIX2sHDtTKdDoLLAvKzEQvGTqtgNy2tn7pH0UNMRk8Cod823Rr5MdpW5yM5UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720994; c=relaxed/simple;
	bh=7tcOFB+xU08Og2s1kXzZqGlykqaC3T7z4dRnqj9Mzjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRqBmadS4iF9mFeggev+nSEnW3cmmpvoePponB5XK7zPWcsWHWcKfr6BbMHR3wG0OTIPnuTp9rXyagvJUTbcpwKQwHchGGm0Nv79DTDl6wW3ChsU1KTYj51Ps241vzlvbsdeiPj13I07D6nIixkuVmQ4S0cShdVmiWxvPqG3riM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpeqnRrJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpeqnRrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw8wVaRLuZUlByglYW5d5mEnth1cKmKQRbNUIpyfUko=;
	b=NpeqnRrJ73DLhmKR8IMeFAzkKed/gdpTyu+/NHpYL4/lXlWAiPGW0B87Fl6uue4DgcEH+l
	X3wFyA5WFNfEgg1eFlrmqux5nuHhQTe71iJLuaXGxaZKgV6cPkzAahQu4xSFe7W0DRRTzg
	cq8u3IXEMW/wq5s3IEjrFTTEVpMn03A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-bg3roWnxPaOqXufE1s6sfQ-1; Mon,
 01 Sep 2025 06:03:09 -0400
X-MC-Unique: bg3roWnxPaOqXufE1s6sfQ-1
X-Mimecast-MFC-AGG-ID: bg3roWnxPaOqXufE1s6sfQ_1756720988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86E519560B0;
	Mon,  1 Sep 2025 10:03:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC6F51955EA4;
	Mon,  1 Sep 2025 10:03:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/23] ublk: add helper of __ublk_fetch()
Date: Mon,  1 Sep 2025 18:02:21 +0800
Message-ID: <20250901100242.3231000-5-ming.lei@redhat.com>
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

Add helper __ublk_fetch() for the coming batch io feature.

Meantime move ublk_config_io_buf() out of __ublk_fetch() because batch
io has new interface for configuring buffer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e53f623b0efe..f265795a8d57 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2206,18 +2206,12 @@ static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
 	return 0;
 }
 
-static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
-		      struct ublk_io *io, __u64 buf_addr)
+static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+			struct ublk_io *io)
 {
 	struct ublk_device *ub = ubq->dev;
 	int ret = 0;
 
-	/*
-	 * When handling FETCH command for setting up ublk uring queue,
-	 * ub->mutex is the innermost lock, and we won't block for handling
-	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
-	 */
-	mutex_lock(&ub->mutex);
 	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 	if (ublk_queue_ready(ubq)) {
 		ret = -EBUSY;
@@ -2233,13 +2227,28 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
 	ublk_fill_io_cmd(io, cmd);
-	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
-	if (ret)
-		goto out;
 
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
+	return ret;
+}
+
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	struct ublk_device *ub = ubq->dev;
+	int ret;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
+	if (!ret)
+		ret = __ublk_fetch(cmd, ubq, io);
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
-- 
2.47.0

