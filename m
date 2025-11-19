Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2A35770B
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554213; cv=none; b=fIXFC8YSK3pwI5jW5ajVvAfu4OzUQ5dlHcuInDnQ61ercpYhGHTCMePaDAfVahNY1GEqj9T0DbqyBEvAt+KfYG2EETRzLl2iHtnJHWgd7aybzAMK+qGCetrYm6phXJrTWtsgUcxVbOgr1HJ1QpfbCpjFI3zNtPtdqlhD3r2uSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554213; c=relaxed/simple;
	bh=1S/lt9Zam29xp7fhhSXIuuxD/tpk0FikNEvIj8JPyeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrS0uT+jvlqE6RfTMqAOE1Xxoanv4HcC6Rhfd8Df/mchqq5CXmhYL0HJ/G+R7gMQyuYA3w7K39uIOLNpl7TqG9+EWSxGPeHwpXUuNMMOUbYIVlPzX1JYR/SW1rZjOlKWN/zZI+Z4D0Q9VKUbbydPm9zsg44GsxzuuHzgR5MAzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzLCwU/K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzLCwU/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaSk3JrpUYV231Lwa3T+F5uuk1xJEkIDmNk7nRGb8Rg=;
	b=gzLCwU/K5Z2j/Lebmp1SrkTdw7feNVV9CaVZwHdp9DlVgWyZJRsbhf+1EuAv27pjy+fJ1k
	3OmdRPGQ37AAES2dpwTgTTPdjB9a4QP13dRWH2/d1inNd+ssVoE83jChGIrImM68Hauio4
	jBiTbtbmerPH7BpmpZl957E9tjo85dA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-3M4w_OJANfmrxpjskoh-dg-1; Wed,
 19 Nov 2025 07:10:09 -0500
X-MC-Unique: 3M4w_OJANfmrxpjskoh-dg-1
X-Mimecast-MFC-AGG-ID: 3M4w_OJANfmrxpjskoh-dg_1763554208
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F2E71956063;
	Wed, 19 Nov 2025 12:10:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 858E418004A3;
	Wed, 19 Nov 2025 12:10:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] loop: disable writeback throttling and fix nowait support
Date: Wed, 19 Nov 2025 20:09:35 +0800
Message-ID: <20251119120937.3424475-4-ming.lei@redhat.com>
In-Reply-To: <20251119120937.3424475-1-ming.lei@redhat.com>
References: <20251119120937.3424475-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Disable writeback throttling by default for loop devices to avoid deadlock
scenarios when RQOS features are enabled. This way is fine for loop
because the backing device covers writeback throttle too.

Update lo_backfile_support_nowait() to check both backing file's
FMODE_NOWAIT support and the queue's QOS enablement status. This prevents
deadlocks in submit_bio() code path when RQOS takes online wait and blocks
backing file IOs.

Fixes: 0ba93a906dda ("loop: try to handle loop aio command via NOWAIT IO first")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 705373b9668d..31be3db02caa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -443,9 +443,18 @@ static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return ret;
 }
 
+/*
+ * Allow NOWAIT only if the backing file supports it, and loop disk's
+ * RQOS feature isn't enabled.
+ *
+ * RQOS takes online wait in submit_bio() code path, and IOs to backing
+ * file may be blocked, then deadlock is caused, see
+ * submit_bio_noacct_nocheck().
+ */
 static bool lo_backfile_support_nowait(const struct loop_device *lo)
 {
-	return lo->lo_backing_file->f_mode & FMODE_NOWAIT;
+	return (lo->lo_backing_file->f_mode & FMODE_NOWAIT) &&
+		!test_bit(QUEUE_FLAG_QOS_ENABLED, &lo->lo_queue->queue_flags);
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
@@ -2205,6 +2214,8 @@ static int loop_add(int i)
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
+	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT_DEF, lo->lo_queue);
+
 	/*
 	 * Disable partition scanning by default. The in-kernel partition
 	 * scanning can be requested individually per-device during its
-- 
2.47.0

