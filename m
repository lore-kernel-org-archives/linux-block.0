Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75028AAEB
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690378; cv=none; b=VnDDxVRgvPyHmPFg4JYb+D5oqEITu+xA8LkqInfG5u+oLHhtdLJ1WWanSZf8h6fm41kwoffJ2lQfKz8l/dMIjmJPGD05kpL+FPGZ4GAyiULQ5aml8f2MvEp4riUBfIvU+cGloARV9CXwEfOl7ts0PpwG7iCbNFPr23duCgPjuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690378; c=relaxed/simple;
	bh=CfhiXF2toJi0vOqff2Us/WG6eVGDX1+2SysinflwNOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKrXWsnHBe+9qWjqJnZXaJ8j89t6N7bmYhrdhdYgtavlNczGt35IAuOy5aS4nvClVLctzadHZ6lnlUxY19uL93egt0SODSaZ8jCHXhclOtjVpMQgOZQHzVQy5SFMmCTswUxiGUPw7P05X0vW86kInUaroDUE64sen1vxDdDSnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grRZOdVa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grRZOdVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdG/qIdtYpcV+p//szbolXF2Zwd6nFqi0cnvJj6VANg=;
	b=grRZOdValNMLbhoTgiMCvmzIgCSVwpJjl681vn8D1STzRgcBL6z6+jsStWYg4hN8yStku+
	kXKFRZoi3jh/serMYH+tj3RycXfvdJ745ysTUso/5fsqPFLns6rLIIrlecLb4swW3CDu2/
	MXx8laZ+T9xgdKUm5U8XeRyQbVUgS9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-RZAl_U91Mo6wYkaFH5Qcgw-1; Thu,
 20 Nov 2025 20:59:30 -0500
X-MC-Unique: RZAl_U91Mo6wYkaFH5Qcgw-1
X-Mimecast-MFC-AGG-ID: RZAl_U91Mo6wYkaFH5Qcgw_1763690369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48A741954B17;
	Fri, 21 Nov 2025 01:59:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 411A5180049F;
	Fri, 21 Nov 2025 01:59:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 06/27] ublk: add helper of __ublk_fetch()
Date: Fri, 21 Nov 2025 09:58:28 +0800
Message-ID: <20251121015851.3672073-7-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add helper __ublk_fetch() for refactoring ublk_fetch().

Meantime move ublk_config_io_buf() out of __ublk_fetch() to make
the code structure cleaner.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 46 +++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e83c1b2a69e..dd9c35758a46 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2234,39 +2234,41 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
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

