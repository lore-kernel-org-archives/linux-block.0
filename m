Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30391FF7D1
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069145; cv=none; b=Vts76KkALZGWTbyaZ5kLWjJBGzdu+bD/xOCnuKm10j06vjpHtlKff6EMLSmVzG+9AiIF18VvemPySX3o1NtGd3DeeWnITP4XWG6KdmjxybwJBBVNZx+eT9jdlMCdGODbDMQ/OsO3l4r+yVi6TRK+IoKrpURLE9ak0oeYUkG1pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069145; c=relaxed/simple;
	bh=R/lFzmoNHUPJ0GFmczeB76uYY7/w8QZvShsSKhHEmg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPPeCzm23VGsojnaXREehcSl60qeWb5PWRRDtPKaGBZUWOkwP7VZgpOUDsBpOYX/P+kFKmO8iCnn+PZ5/ibh/HdklS4thLtO/mnHGNWJbElwOCEd6qQv4VHFT8st08sO8sqmKr5PVnrFLflBBRcMmghd2R5WVRWEkCvPdVsr+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yvy0nyj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvy0nyj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbEMjuPd2uCEOUpA6vfBrOxViJf3EYuCzRakJ/t6CTs=;
	b=Yvy0nyj9bpaTYGufCi1GC1G5w+MGE6QqI0rhlxg+jwk8248tSFxjmg/DOwrt5U1SSKZoeM
	VSKNox3wUEAelHo/vNlQza5pxt57EVvR8XPNLaShNEdGdgxbvhGC8g/bFaYivmcPul9EF7
	yiMTdjmbv7sA6HchFdap99PKtdy3H+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-lq4AxDHjN3aXORDxbpwpYg-1; Thu,
 27 Mar 2025 05:52:18 -0400
X-MC-Unique: lq4AxDHjN3aXORDxbpwpYg-1
X-Mimecast-MFC-AGG-ID: lq4AxDHjN3aXORDxbpwpYg_1743069137
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43A801956070;
	Thu, 27 Mar 2025 09:52:17 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5B5819560AB;
	Thu, 27 Mar 2025 09:52:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 09/11] ublk: rename ublk_rq_task_work_cb as ublk_cmd_tw_cb
Date: Thu, 27 Mar 2025 17:51:18 +0800
Message-ID: <20250327095123.179113-10-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The new name is aligned with ublk_cmd_list_tw_cb(), and looks
more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f97919460515..355a59c78539 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1264,8 +1264,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
-static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd,
-				 unsigned int issue_flags)
+static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
+			   unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
@@ -1280,7 +1280,7 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_io *io = &ubq->ios[rq->tag];
 
-	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
+	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_tw_cb);
 }
 
 static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
-- 
2.47.0

