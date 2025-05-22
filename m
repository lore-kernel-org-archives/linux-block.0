Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCB28DEE8
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924565; cv=none; b=VS/3J2zWDR/IzL0Ud7TMVeKFPk2FKkQYvqDxydBBMN5W5g9SAgm+PtsZsoliBjK+6QpBKvQHc8iN7GJzADxAd7xyYypeTxd00jSDTOHpsXoIs/UJc3LCtKJz29RW3ktDIKuWIMM28fdW3z+4DQMAWxeM+r7OaaVTT8pjqitwb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924565; c=relaxed/simple;
	bh=OlZK/YX5fzH4gdeaGTIfo7UWEtTyE4V8naUP4FWknXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4G9HsuID2DG/TSrzSs9bdjhH/Q0LGhSLIQntF9q8gN/GqD70Fz8EiQ4764zdiln5NQB83yJWcI336GYIocMmLKqicCh9Y9CQlFsKR+Nc6aOpShCzeCJDNYQKe4UEa+6NgDpXl0EgasnPMQW+KT8Jrp0oDMXIcSpiMi972G++8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI6uPAF+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI6uPAF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747924561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ydV6UEOcswumfu973Fc5tP+cwrCxjXWQovjR/LtdD50=;
	b=dI6uPAF+PZk5WaHQp7RVtN+PmQwGWMPbOXzYyXuVDnkIHUg2sbkR7I9YNJ3XJOuBP4aVb4
	o7gIaQEE38U5S3Zb+LIo4P+01PHsFup1ST0DD7ep3+/zRwBIEZag5BieSbOyop/mRy8G/y
	ayuu2wpnajc9Ur/hKVhOY4yLfrMYq04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-dzaXzWieP7Sd1dljbX-exA-1; Thu,
 22 May 2025 10:36:00 -0400
X-MC-Unique: dzaXzWieP7Sd1dljbX-exA-1
X-Mimecast-MFC-AGG-ID: dzaXzWieP7Sd1dljbX-exA_1747924559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE7E1956089;
	Thu, 22 May 2025 14:35:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFBB230001A1;
	Thu, 22 May 2025 14:35:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] loop: add fs_start_write() and fs_end_write()
Date: Thu, 22 May 2025 22:35:47 +0800
Message-ID: <20250522143547.395304-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

fs_start_write() and fs_end_write() should be added around ->write_iter().

Recently we switch to ->write_iter() from vfs_iter_write(), and the
implied fs_start_write() and fs_end_write() are lost.

Also we never add them for dio code path, so add them back for covering
both.

Cc: Jeff Moyer <jmoyer@redhat.com>
Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered I/O")
Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 46cba261075f..5107cc9a1872 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -308,11 +308,14 @@ static void lo_complete_rq(struct request *rq)
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct loop_device *lo = rq->q->queuedata;
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
+	if (req_op(rq) == REQ_OP_WRITE)
+		file_end_write(lo->lo_backing_file);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -387,9 +390,10 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		cmd->iocb.ki_flags = 0;
 	}
 
-	if (rw == ITER_SOURCE)
+	if (rw == ITER_SOURCE) {
+		file_start_write(lo->lo_backing_file);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	else
+	} else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-- 
2.47.1

