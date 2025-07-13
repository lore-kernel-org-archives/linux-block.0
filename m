Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BB8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417313; cv=none; b=C5qJC22EVQ810B07jJ+ajJ6iU3T4xIth1VIjF8gPezIMt+cBn6TdWWbBuJ+FdurzEEKVt/oanme6kwemwDgDBbWmfBxZlxoil9Tpq2aofsqO/sSemtH55LhHAinK5T0Swnn+DZ+0tU9Oa2g6kM4fhB3ezJB9EiRLKn7HSc0+vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417313; c=relaxed/simple;
	bh=UqnrudaVZxWBeT4fbd9ozraVV0FQBZb97vplG/DUfH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp7md/SHzwoknq9VrtVzIvpZCOMzU40R4N/zXKOaC2rwG+ImuQ6F4PG7cN2vVK0lvLBB2pOhONye0or/skjFDE+tnXWuoKdns+IZ89jYVc0i5Bi3zQR4YdK1P5gUM7KWZs8PwmtMlJ1jWJ2rWPS9XYOv2R1pc7twva7565rUBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXFm6kAn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXFm6kAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPIQp5mrR8dLJmdTt7bFCsbdefi5sxjzxz4fDzPEZCw=;
	b=ZXFm6kAnWRLPIYt9DPGffYH9uJrqeqtGnJDj5QbiIUEhGnk1Xv7oFinzTGWuJQGE5zzACH
	O9jpP41f+oJODpvZAbK0qJtYYsgeBzYpSqO+lIAWjaUVh+IqoS9zMM7iwVVDMmZF8gKcvH
	F5KQZjH4guMgehlsHzlyqSEltGHgpE0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-j_5tRQ1UOxi3WOAZOORMlg-1; Sun,
 13 Jul 2025 10:35:07 -0400
X-MC-Unique: j_5tRQ1UOxi3WOAZOORMlg-1
X-Mimecast-MFC-AGG-ID: j_5tRQ1UOxi3WOAZOORMlg_1752417306
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5559319560AD;
	Sun, 13 Jul 2025 14:35:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75DF019560A3;
	Sun, 13 Jul 2025 14:35:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/17] ublk: add helper ublk_check_fetch_buf()
Date: Sun, 13 Jul 2025 22:34:03 +0800
Message-ID: <20250713143415.2857561-9-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a helper ublk_check_fetch_buf() to validate UBLK_IO_FETCH_REQ's addr.
This doesn't require access to the ublk_io, so it can be done before taking
the ublk_device mutex.

This way also fixes one missing return value of -EINVAL in case of early
failure from ublk_fetch().

Fixes: b69b8edfb27d ("ublk: properly serialize all FETCH_REQs")
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c69d4fafc6cc..1b22fd5f5610 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2165,6 +2165,22 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
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
@@ -2191,19 +2207,6 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
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
 	ublk_fill_io_cmd(io, cmd);
 	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
 	if (ret)
@@ -2316,6 +2319,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

