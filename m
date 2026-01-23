Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B327B347
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159767; cv=none; b=LSSs0WeIbmCkBp1howeghtb0i857xamCzTdLZBUxai5G6cpa9Qga5w1Us3MoV6g7ki9HxzdtL0GaAWOldhqMfh1r7krgx2v1DyuDlv1JInwA6rz6ncv40mwbtg7p+Y3i+0fCL7DQuilyxPwzmRgqXW3zGtmVL4TFQCMx3Q/9c3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159767; c=relaxed/simple;
	bh=+IIerOJwQsN+dmjCQXbYf0nhpSUT02zQKDbzly8Xqpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLGfUbvBeuYb45Qn67rycY06lUyGaBUa77S3j+Z4yLy/xw4S9qZ/cxqwapnSI/X6/TZSQstIRDBGYd5jyF66ONsbZouQdN2iPDq3kGLH9KLLXSciG0cuXSzOgXZORsfA3Cz8Ui35vttD8A81q9ana0JytyHQFS7xZ5WF+En8Uf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GohJBwjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GohJBwjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769159765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0W9QA6MXImgIpdADbIkt4hCZEX9eiEPPu3Q7MNCfbk=;
	b=GohJBwjpChUl6DKKhXdh1B+o36u5LdVuT1IbjLw4w3zPo39PkNjYNJfQmU3A1TPR+bSIS4
	ilqtCOCbtbZTE/U3VyRNX6GNCeZuxLTEGqgAGWlmR/y2Ia8MiYWjUOcEndwnw4tDG5OVW2
	l4psc4PluJAWLBuxFjVBHPzFM0v3T3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-VvO-WiiEPuqQ9Z8yjpfVcQ-1; Fri,
 23 Jan 2026 04:15:57 -0500
X-MC-Unique: VvO-WiiEPuqQ9Z8yjpfVcQ-1
X-Mimecast-MFC-AGG-ID: VvO-WiiEPuqQ9Z8yjpfVcQ_1769159756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D01718002C2;
	Fri, 23 Jan 2026 09:15:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 491EC180099A;
	Fri, 23 Jan 2026 09:15:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] ublk: move ublk_mark_io_ready() out of __ublk_fetch()
Date: Fri, 23 Jan 2026 17:15:42 +0800
Message-ID: <20260123091547.2164984-2-ming.lei@redhat.com>
In-Reply-To: <20260123091547.2164984-1-ming.lei@redhat.com>
References: <20260123091547.2164984-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ublk_batch_prep_io() calls __ublk_fetch() while holding io->lock
spinlock. When the last IO makes the device ready, ublk_mark_io_ready()
tries to acquire ub->cancel_mutex which can sleep, causing a
sleeping-while-atomic bug.

Fix by moving ublk_mark_io_ready() out of __ublk_fetch() and into the
callers (ublk_fetch and ublk_batch_prep_io) after the spinlock is
released.

Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: b256795b3606 ("ublk: handle UBLK_U_IO_PREP_IO_CMDS")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1e374ecbf0f1..31279a8238b8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3064,7 +3064,6 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		WRITE_ONCE(io->task, NULL);
 	else
 		WRITE_ONCE(io->task, get_task_struct(current));
-	ublk_mark_io_ready(ub, q_id);
 
 	return 0;
 }
@@ -3083,6 +3082,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	ret = __ublk_fetch(cmd, ub, io, q_id);
 	if (!ret)
 		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
+	if (!ret)
+		ublk_mark_io_ready(ub, q_id);
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
@@ -3484,6 +3485,9 @@ static int ublk_batch_prep_io(struct ublk_queue *ubq,
 		io->buf = buf;
 	ublk_io_unlock(io);
 
+	if (!ret)
+		ublk_mark_io_ready(data->ub, ubq->q_id);
+
 	return ret;
 }
 
-- 
2.47.0

