Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAF1EF1D
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360064; cv=none; b=ZKE98CaFMkenPxhKBcY8BO4XHVIScp28/LIoJDWRa2Ib02RVwaTE/MAqdCSMmyUAZND2MeB7PbUKufkfr0UOoj3DPiZNIPbG2KUEinWX7d4rwLbuy2L1ODRhX8VBsQWMAILVw1zNyxiCpNt7txG6GBBUoM9XswQfuP8GdelE3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360064; c=relaxed/simple;
	bh=y6MvlNhmAXXJtEPYOWwhZT4H6xGmYLRPpFyR/CXS1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfqbnXyyd9QqfxVnyfTO1CArt6JnRF3L5xBnrPggiYzST1bgXuQpsD6zaeiSQd+zxsSaUT+hIqsgx/A4Jfiw1gtVp/SPX+SWdgIVVwPKn60beYMP1s5nQ65UfNXbOpvxUjRxuODDwlEZuVtWP7r6yCT2ADx4S6nZSk1G7xsUxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy0mQskQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy0mQskQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748360060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1A4hqkJYUzoBoixImpFKQXOAqS8DCfipDAszzv1IUnk=;
	b=Xy0mQskQz8JykgdlcOaTJWuuZZoDjYrdRvWklJJgxPIJjdOukgs6jEovqBbWJRDxOOsbMI
	c8eDodjbSrAis2/X7WyTBaWopH6Fdk7IXtoPQvuLZKzMyqM2sx3cv8JN0S/J6Y7MQrXUyz
	Ph9/pqPnM/S/WQXTw85v02X2twUF7oo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-5HB_0TQYOvW3AUpPjHzo1A-1; Tue,
 27 May 2025 11:34:16 -0400
X-MC-Unique: 5HB_0TQYOvW3AUpPjHzo1A-1
X-Mimecast-MFC-AGG-ID: 5HB_0TQYOvW3AUpPjHzo1A_1748360054
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF6081945108;
	Tue, 27 May 2025 15:34:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C36B195608D;
	Tue, 27 May 2025 15:34:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V2 1/1] loop: add file_start_write() and file_end_write()
Date: Tue, 27 May 2025 23:34:05 +0800
Message-ID: <20250527153405.837216-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

file_start_write() and file_end_write() should be added around ->write_iter().

Recently we switch to ->write_iter() from vfs_iter_write(), and the
implied fs_start_write() and fs_end_write() are lost.

Also we never add them for dio code path, so add them back for covering
both.

Cc: Jeff Moyer <jmoyer@redhat.com>
Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered I/O")
Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix commit log & patch title

 drivers/block/loop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b8ba7de08753..7eca957dc656 100644
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
2.47.0

