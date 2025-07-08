Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246D35968
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937492; cv=none; b=uBb5CQmm6DBwVTMToWmpPWcQi9t5AFKPlzQTScNJ//lIBpqFHznTEQq9vMxWoj+PoGVxIdp+EFAQU0Q4A20xpqrlj99un9PiYp0In+D+wWJnvm6qia6F2tdIujDwdB/b6jqu5seeGQukWNI0H5YGHpWyPca1Fa0dzB0X7AmiSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937492; c=relaxed/simple;
	bh=iwBNKyZiD2c507qRaZbbEhXAFxqt6FtfhDvOIryy83o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfo24Hr6vwLPwI/pL4hIo+tVcQPQMf1B7VfC9dxVgACD7YvTJLopSRbPaSxpa/Zz5kacmOzla8bIXBe7gjF5LmHgz+akbSLOw1T26RfifZ5Ro+0Znqc7OEp0G6E5vz1EGyusNjOwm+HEu4qR+YQ2ERIMNXzT274KItGHzpr9VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rcspysov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rcspysov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjoc7OlAdckqTCgFwcPi4jwGgFWwww0S3W0r/mNSJk=;
	b=RcspysovG/4Ec8tp/P7KvTW3YyoGoOoHMteG6e9DvlStZMNKXLIUAaI2YqT1OrfVovQibG
	cGCOsdqd4NjT0MYgiUBcvUYX6sPqxKOocBSWtqNdzkXG/8ubOcBJs3KsLNAowhgqsGUbrR
	G6CKFyT0iBiMokNajQxNPTgjSPlgekQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-jV6efqcrP4yflWh0yJOiig-1; Mon,
 07 Jul 2025 21:18:05 -0400
X-MC-Unique: jV6efqcrP4yflWh0yJOiig-1
X-Mimecast-MFC-AGG-ID: jV6efqcrP4yflWh0yJOiig_1751937485
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7D251956061;
	Tue,  8 Jul 2025 01:18:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C997B19560AB;
	Tue,  8 Jul 2025 01:18:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 03/16] ublk: let ublk_fill_io_cmd() cover more things
Date: Tue,  8 Jul 2025 09:17:30 +0800
Message-ID: <20250708011746.2193389-4-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Let ublk_fill_io_cmd() cover more things:

- store io command result

- clear UBLK_IO_FLAG_OWNED_BY_SRV

It is fine to do above for ublk_fetch(), ublk_commit_and_fetch() and
handling UBLK_IO_NEED_GET_DATA.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d7b5ee96978a..1ab2dc74424f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2003,11 +2003,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 }
 
 static inline void ublk_fill_io_cmd(struct ublk_io *io,
-		struct io_uring_cmd *cmd, unsigned long buf_addr)
+		struct io_uring_cmd *cmd, unsigned long buf_addr,
+		int result)
 {
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
 	io->addr = buf_addr;
+	io->res = result;
+
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 }
 
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
@@ -2165,7 +2170,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 			goto out;
 	}
 
-	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_fill_io_cmd(io, cmd, buf_addr, 0);
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
@@ -2221,11 +2226,7 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 			return ret;
 	}
 
-	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-
-	/* now this cmd slot is owned by ublk driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->res = ub_cmd->result;
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
@@ -2345,8 +2346,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * request
 		 */
 		req = io->req;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+		ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0

