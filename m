Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AA338913
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233593; cv=none; b=dFfPduzJAHBpBVxbmUU3d6sMcHsXLSQxaHrJAuQhWUiMb/fSQka0jZO9G3RiwQOaYoHfLOPonhPGc++VWJfS3uuUmUAPkUqeBc8a/8l4ww1rBaD47FiuwCef/IOkMkKRsYOAB+WO8vmBBw/nxho4PhH0tCZqdIzozKfHxGrpSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233593; c=relaxed/simple;
	bh=43d8QPIzY3KzvqB8qhAlJwz7Elog9g+LlaBF8sJyiHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAtRIPfsGsVAWE9wCqKx0bC97B4XkIDA7YZ0yQ3RTD/sC+F2MvWKW5KYbFJCo1yjbAdYUITFY+w0zMScf45KNok5rZZe7lqkkjL3CyQ4gxWZdzyPr+n+jmFMSdm8OcIKfpTiGTpzNWuRlEKRE790UKMSWUl9tomCD1qbXa7m0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+0oamRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+0oamRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8qJ58ko29KNmOP7S9QuDk9cQcuS5q3cBtDYZz21tk4=;
	b=i+0oamRaI1FmCAmD3pHng8E/R86omKFRSfLFVIq8WRFuxoh3y9p0fNowa73dPgxfA3aDyb
	8DHVWs+OKXzkURGFsxZ7ODR7I166Hm2D2YjZWKI9HyEecH61worIQpUT3rWPEnLFf2UQKt
	r0JzwYY8ftZJnT2opnKaooXnZe+K2dk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-uSbuZtfXO1-hFgD78hZcxA-1; Thu,
 23 Oct 2025 11:33:05 -0400
X-MC-Unique: uSbuZtfXO1-hFgD78hZcxA-1
X-Mimecast-MFC-AGG-ID: uSbuZtfXO1-hFgD78hZcxA_1761233584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89D1195399A;
	Thu, 23 Oct 2025 15:33:03 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA912180045B;
	Thu, 23 Oct 2025 15:33:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 04/25] ublk: add helper of __ublk_fetch()
Date: Thu, 23 Oct 2025 23:32:09 +0800
Message-ID: <20251023153234.2548062-5-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add helper __ublk_fetch() for the coming batch io feature.

Meantime move ublk_config_io_buf() out of __ublk_fetch() because batch
io has new interface for configuring buffer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 46 +++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a11ccf3d96d6..a44e40d1118b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2300,39 +2300,41 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 	return 0;
 }
 
-static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
-		      struct ublk_io *io, __u64 buf_addr)
+static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
+			struct ublk_io *io)
 {
-	int ret = 0;
-
-	/*
-	 * When handling FETCH command for setting up ublk uring queue,
-	 * ub->mutex is the innermost lock, and we won't block for handling
-	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
-	 */
-	mutex_lock(&ub->mutex);
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
-	if (ublk_dev_ready(ub)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (ublk_dev_ready(ub))
+		return -EBUSY;
 
 	/* allow each command to be FETCHed at most once */
-	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (io->flags & UBLK_IO_FLAG_ACTIVE)
+		return -EINVAL;
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
 	ublk_fill_io_cmd(io, cmd);
-	ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
-	if (ret)
-		goto out;
 
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub);
-out:
+
+	return 0;
+}
+
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	int ret;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	ret = __ublk_fetch(cmd, ub, io);
+	if (!ret)
+		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
-- 
2.47.0

