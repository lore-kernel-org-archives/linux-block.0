Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D081DDC07
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429058; cv=none; b=itF3t2rTGsRTehjOWDqma7aSSirq9sBMY4/5K+OOrmvTfFZRsa45o7bY4Iam5OrQO4XnUlMe4xAJr5yZvZx2G/9Z7Q9m7BZvEcxHTYlsHUV8bVulfhbG82MWK4vo1pgWLUXsL61AAPCxkVi1621cuL5sbIytzs7SxSX+00u46Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429058; c=relaxed/simple;
	bh=nMzsli9aaoOiHPszQBcOdTcYbt0MWhCLJfXs/4oamjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av7MTFuxnVJok9SOoKR6TlLzlrdxvqo7DG9MpD0iCmX0Uh+v+kvIBDrQJg1hfS28So+q6YKL/mRAhxQPVdeAAm0U88Yc7zUae/SpZnHpl04MwbW3jSTyl0kO5JlCC0p+tJgpcqOa9Mu4y23hN3HLv+YSg4Yq+3erHLD1mTnXpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtMe6msv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtMe6msv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNBYxsoLo49C5FNAm5FDprWBG+vCX7QYMmha5L+DWgI=;
	b=OtMe6msvvdKqy9c+XE3+Y3e0ZCUgxwJ5oTkqE9Ti3VWUWazChaPOhU0d9vn3cy24xu3CnR
	f4mYHZxh8ruknDSm51jMM7leVGqsbenVglq9ZcBEGFFkkVm63Ec5PDr2qDrIf2zcm/u4dH
	gqt6idhwWbJuLhmidmf+h3UEqrvtJAc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-dor671eHOMmT1Baw01dOWg-1; Wed,
 02 Jul 2025 00:04:10 -0400
X-MC-Unique: dor671eHOMmT1Baw01dOWg-1
X-Mimecast-MFC-AGG-ID: dor671eHOMmT1Baw01dOWg_1751429050
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E159C19560AD;
	Wed,  2 Jul 2025 04:04:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1DE61956087;
	Wed,  2 Jul 2025 04:04:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/16] ublk: let ublk_fill_io_cmd() cover more things
Date: Wed,  2 Jul 2025 12:03:27 +0800
Message-ID: <20250702040344.1544077-4-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index 834d4db3b07e..2dc6962c804a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1984,11 +1984,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
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
@@ -2146,7 +2151,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 			goto out;
 	}
 
-	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_fill_io_cmd(io, cmd, buf_addr, 0);
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
@@ -2202,11 +2207,7 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
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
@@ -2326,8 +2327,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

