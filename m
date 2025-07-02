Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AD1E5B73
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429076; cv=none; b=APQE8fRhTpQZvKQJR1ZWFekbD+08sbUpk55iflRP4XZbd+6vmDO/68ULlPfbrut5hRNxxe+GCJpuBMJLfP1b4fcuCyKpk5JXQkUszl9CVuMTHBh6BBaleG1UH4SCmj2+PUuOIPTCozwuSaHTFDDtVJ6C62JTr08rXhgqecsmje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429076; c=relaxed/simple;
	bh=XZG/sN+EikZW6cQ/sWlKJh4ll24hGovAvV7xav2EzbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOw16BoOjHC0+JvSUx6lhNe1GCauZQD/D/B38jP/IqKAAYbPrSKx10+tApYRbmxHc1PlZqlnFugVM1qwUC1SrQfQcXev0eAmCuu9rmCjtrOJULjHKuvYj/HqVuP4dJRKZdFtBwRkdip+C7a+6tK76wyunJH5hENdu+DlR01aFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhpgmJRl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhpgmJRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Onv9fxqrpnfsNfY8CDAJTJhvbz1WYot0btChTVdA0Pk=;
	b=RhpgmJRlUtpeq4GqB5vlFhF+K2plmheyN9vHSV2cS4Z+uMkK7dLpLpitNrZWkFVPtXyuQE
	uwA1sFj4q6YRBDULDPZ2MxIGHX34VaVgHfbJksOyx4N+TWUkOfvJux1Gw+JjjxQvFur/Lp
	GzAmBNG+L5v8egbjcI3IDlpmwkfEBfg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-HPLbtWgRMjSaxY9RQx704Q-1; Wed,
 02 Jul 2025 00:04:28 -0400
X-MC-Unique: HPLbtWgRMjSaxY9RQx704Q-1
X-Mimecast-MFC-AGG-ID: HPLbtWgRMjSaxY9RQx704Q_1751429066
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5DA518011DF;
	Wed,  2 Jul 2025 04:04:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3EBA195608F;
	Wed,  2 Jul 2025 04:04:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/16] ublk: add helper ublk_check_fetch_buf()
Date: Wed,  2 Jul 2025 12:03:31 +0800
Message-ID: <20250702040344.1544077-8-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add helper ublk_check_fetch_buf() for checking buffer only.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6d3aa08eef22..7fd2fa493d6a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2146,6 +2146,22 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
+{
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!buf_addr && !ublk_need_get_data(ubq))
+			return -EINVAL;
+	} else if (buf_addr) {
+		/* User copy requires addr to be unset */
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		      struct ublk_io *io, __u64 buf_addr)
 {
@@ -2172,19 +2188,6 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
-	if (ublk_need_map_io(ubq)) {
-		/*
-		 * FETCH_RQ has to provide IO buffer if NEED GET
-		 * DATA is not enabled
-		 */
-		if (!buf_addr && !ublk_need_get_data(ubq))
-			goto out;
-	} else if (buf_addr) {
-		/* User copy requires addr to be unset */
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ublk_fill_io_cmd(io, cmd, 0);
 	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
 	if (ret)
@@ -2297,6 +2300,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
+		ret = ublk_check_fetch_buf(ubq, ub_cmd->addr);
+		if (ret)
+			goto out;
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
-- 
2.47.0

