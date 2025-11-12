Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C22F90EA
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940341; cv=none; b=coekc3sJ+HGnyXSKbnCcfeu3TTJiKY5n/D1OLrmuQMU3Ys2iYunvNWXdA9QNaiIZ2Lt9jv4aRkia3fStAsi89hxTTFrt+ynyOp23zv0el9WEGGhE4BRQX7qI+IHtXDLp2DV2C2to54mvlPRn8Jnbftl50gYfiWwaveHrkb+yWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940341; c=relaxed/simple;
	bh=NQZWsOEQbPn+vCPqEybqXRGlPONtZ1FRQPBv4hG7hhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1gTSBFu+Kp7jYZiFFJuxtxcJKfYXiHVPZnewb6DBQXi5T7OSVGEAaZPDHjFklgY5k0JXqQWtr+bxBnWqtlV6ANWtxh7MV4jW3bw3YaNtXlgo1L2+mM4Hpo9BfxlG2JrW27L52NwLdrljvPLQxoOsbsv5qrGdRTnIL+jVTDT9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2TYPQuE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2TYPQuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQwxSoMyy1EE+h2folUEm/rEUMUBUsPlDN9rNRjoQ8w=;
	b=E2TYPQuE3sa0VzUekkRjBSTyQ71v0GCh9aafhYa7siHQBY7Wev1n/99sBrvTVHbDkYYZOL
	tDFv1ykmlyJm1J79HHvMhQaGIGKYcKzT303ANBHuYtUzNrTWCX9otNqJ17kYERJ2o48WMP
	WSHvHZ7uQ89ShF8ehfVmkHWJrtc1RJo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-pNR5lSwXO1y4t4mmODw3Zw-1; Wed,
 12 Nov 2025 04:38:57 -0500
X-MC-Unique: pNR5lSwXO1y4t4mmODw3Zw-1
X-Mimecast-MFC-AGG-ID: pNR5lSwXO1y4t4mmODw3Zw_1762940336
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24AD519560AE;
	Wed, 12 Nov 2025 09:38:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A9BC30044E7;
	Wed, 12 Nov 2025 09:38:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 06/27] ublk: add helper of __ublk_fetch()
Date: Wed, 12 Nov 2025 17:37:44 +0800
Message-ID: <20251112093808.2134129-7-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add helper __ublk_fetch() for refactoring ublk_fetch().

Meantime move ublk_config_io_buf() out of __ublk_fetch() to make
the code structure cleaner.

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

