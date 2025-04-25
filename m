Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFA130A7D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545084; cv=none; b=EWEbS33A8KvFUAl6mBHyE4ukVhTwOFjAut+J89lzMRbq9WXE3nXgJIk3PGk/QqzjzQxcCAJ8X7rB4+HDyTiI9H9zXHvg+fH8PMBH1TxTtA7jLFGSil0Av63ZgQ+fWYr6fT1S3UYDeUsMXjWdM1LfvYzXVoA5PutnrjPRgG2VJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545084; c=relaxed/simple;
	bh=TheVPnFkLrEx8ILf1sM3QiW2onw3QHnjgoxZHoeJnA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzFRn9qVumJfO4I/uKYNYVJ05TQSLkXt17GwW4cp4m5EuibCm1Z9QAaSgsGyS43LY8cn3VL+xYGeYLgEZI8Zw+lpNKQjZyFuIX62aW9P+wUKq8aFUKJ9HWAOgMtYTF2/Zvs/T38l/XoljdfddnG3sqKG/hSAVZu1ijYxRR/40vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjA5Rr26; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjA5Rr26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uncF2vmeyDGME1w+xqtW8M+oJuc7acVUjJmT9kUbg6A=;
	b=gjA5Rr26BcJ2EFpA0X5BEx5eWq4wvtI7DlrYxoyjZg0NJ4CiPDjFWuSOWd7xci78bo0ifb
	4ZGeE8G5yZP7Xg3HJEtNnB/wUxoZ3R5krK+/anTYOkVcbq4GgWzGFQml7omzYJP7afnZtc
	LrBzvvOH++HjPdAFudxKnZmmyC5/1b8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-AOLkwMcDPdOlqF1bYf6fvg-1; Thu,
 24 Apr 2025 21:37:56 -0400
X-MC-Unique: AOLkwMcDPdOlqF1bYf6fvg-1
X-Mimecast-MFC-AGG-ID: AOLkwMcDPdOlqF1bYf6fvg_1745545075
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8A081800876;
	Fri, 25 Apr 2025 01:37:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9863180045C;
	Fri, 25 Apr 2025 01:37:53 +0000 (UTC)
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
Subject: [PATCH V2 1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
Date: Fri, 25 Apr 2025 09:37:39 +0800
Message-ID: <20250425013742.1079549-2-ming.lei@redhat.com>
In-Reply-To: <20250425013742.1079549-1-ming.lei@redhat.com>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

We call io_uring_cmd_complete_in_task() to schedule task_work for handling
UBLK_U_IO_NEED_GET_DATA.

This way is really not necessary because the current context is exactly
the ublk queue context, so call ublk_dispatch_req() directly for handling
UBLK_U_IO_NEED_GET_DATA.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Tested-by: Jared Holzman <jholzman@nvidia.com>
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

