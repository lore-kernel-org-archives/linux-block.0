Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADA4A3E
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400267; cv=none; b=MXoDwWZz0mRIdfCYQzs9JGMZD5BkSjBBt7Ie/s5B6kAB1aK6zczP7kbmpRkBjiagOlSICuXc97bPj6RDi41pMwiS9MtXltX4JDvVhTo6dGek1JJKdSUAjEweb66bjFLI84VWcIKZihzJTqd+qBc+4lkvdc7RkmzkA4L28fyXEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400267; c=relaxed/simple;
	bh=V/SJu41zxdvSPYcDkfhxsw1mau6otJXuBufuKBbpgGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKjYf0ygVicJZeaGFT+GopdM6YOdI1OTpBMhNK8NrDexP+KigUaYR1iJnc4jcWLUi/6wLb8QJKHBui5Oi43Qk7b+0DugkIMuKGtePUpcnPo6vBHWBsAdnjVe7/zKFnF1Zi9gi0FuMXTUqmfIHgWm/dF0eeISLHuaEUAm3VufvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikXX+kqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikXX+kqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745400264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PSURhPiPIxrqsxjHVtGqLwNN8MNJQ5Rw2z9VhgHYTo=;
	b=ikXX+kqrqCAtJWjVKlnq4wKhVeaa2Sihkd6MxoKuc+iyxiQbeTOOfzXhwF/i6N1xkZjZUN
	wZzSutjV0RholzKCYwfWXFGTHG5LFRa+UeZ9tYpvPUHJySNqTJ305GnVu3uO2na8vVR8ML
	Oqlg2yLxsiUb0Gpn3QCvB8cL6ybGF+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-eibwIKUsMOGI_r-wCK3AaQ-1; Wed,
 23 Apr 2025 05:24:22 -0400
X-MC-Unique: eibwIKUsMOGI_r-wCK3AaQ-1
X-Mimecast-MFC-AGG-ID: eibwIKUsMOGI_r-wCK3AaQ_1745400260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF8B5180034E;
	Wed, 23 Apr 2025 09:24:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBFDA18001D5;
	Wed, 23 Apr 2025 09:24:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>,
	Ofer Oshri <ofer@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
Date: Wed, 23 Apr 2025 17:24:02 +0800
Message-ID: <20250423092405.919195-2-ming.lei@redhat.com>
In-Reply-To: <20250423092405.919195-1-ming.lei@redhat.com>
References: <20250423092405.919195-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The in-tree code calls io_uring_cmd_complete_in_task() to schedule
task_work for dispatching this request to handle
UBLK_U_IO_NEED_GET_DATA.

This ways is really not necessary because the current context is exactly
the ublk queue context, so call ublk_dispatch_req() directly for handling
UBLK_U_IO_NEED_GET_DATA.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2de7b2bd409d..c4d4be4f6fbd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1886,15 +1886,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
-static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
-		int tag)
-{
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
-
-	ublk_queue_cmd(ubq, req);
-}
-
 static inline int ublk_check_cmd_op(u32 cmd_op)
 {
 	u32 ioc_type = _IOC_TYPE(cmd_op);
@@ -2103,8 +2094,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
-		break;
+		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
+		ublk_dispatch_req(ubq, req, issue_flags);
+		return -EIOCBQUEUED;
 	default:
 		goto out;
 	}
-- 
2.47.0

