Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2BA13AF2
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937507; cv=none; b=jM6MuUmoQkENt9ba+Z8aYED89kFYFv2WA6papWylr45N2qAWKwzGh4qm5Sy+LcviAlnjVOgAVAHalugNOA9Rice4mK2jjZCOBOkEhXBv3U9nqMGM58Gs9qLdODS2piR8ZQiUfQI/xrbfYuFFxGVAQw8OLG69/dvpT7LkosUmwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937507; c=relaxed/simple;
	bh=C4keWRi3Vo/IHcFVsnQNNtI0zMm5s8X9hPdy1kg4NMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvIPfyAfynR5OLb/NZRlWiMl61JhSuIrJw7eGsLC4+BJzeXW7RqhhlXUMvRMWmX7W7UISwaE9Cuode7C1yV5LafyD8rId4cDiCzL4shPVIiQU0aKfRSA9kwGt5XkSiKkbVA/Ds2wegiNSihzuXaVqmEenR7QDyGai0dgKzyCBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKznebXE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKznebXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLA6ky5ZxpJmbIDF9hRYT/xaIkJimJV2XbHaGhsH7wU=;
	b=LKznebXEtcG7XmQnMTLhaxdkiAJw3W8S/noWuuJ2D8RAtD1qtJAQdV6Zmaqd9A84PstteI
	Cshr4MhdGJPWYNLZMRuLmN0L7l12l2knp+fJzSlLhHsdxiwkxuJ9oBce30kb94UTmh1TeV
	Wp+32EZnkqa36cRFXK+Q03v8l+S2lUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-1-4y1iamNfKLZDyEB_cc2A-1; Mon,
 07 Jul 2025 21:18:21 -0400
X-MC-Unique: 1-4y1iamNfKLZDyEB_cc2A-1
X-Mimecast-MFC-AGG-ID: 1-4y1iamNfKLZDyEB_cc2A_1751937500
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5420C180135B;
	Tue,  8 Jul 2025 01:18:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21C821956087;
	Tue,  8 Jul 2025 01:18:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/16] ublk: add helper ublk_check_fetch_buf()
Date: Tue,  8 Jul 2025 09:17:34 +0800
Message-ID: <20250708011746.2193389-8-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add helper ublk_check_fetch_buf() for checking buffer only.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 04bc34c654f4..0e12fb67867e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2164,6 +2164,22 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
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
@@ -2190,19 +2206,6 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
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
@@ -2315,6 +2318,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

