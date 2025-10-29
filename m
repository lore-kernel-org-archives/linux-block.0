Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2D1C8605
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707455; cv=none; b=od6dmKBI3Qpx+Y8WJavZj9PPxkJLO8iC6KHikiEHw9sRv3rTT/+wCQRcLB5Hp0k/ch8+6qLUf+vs9ADs0AhoQK7VJnRifU1+hPaMonir3Dc4DtNeApHn5madm+kUJAnvJChQE1eZ+dYfmjE2U6mR2OnkylOv+RXxf1dUvH36Rrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707455; c=relaxed/simple;
	bh=Cvb+TeBFTh8sAtvLguAB4Z8VMm0xF59LiB/N2rhA8ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkw8QMXCnIyL4ylcjqSM2wTHOCIu9ee1cTgdeaB/JGvUiKxIdI8swh7bABPs/lngPsCjs+ba4nULkqtgqg8M6F6fm0N296JVFY1iy+PaL48zyogoI11k4p7eELyFPkV2q+STZi3NrjzrOGgDMgq0gfeWW0UQCw2NCrYJi79NRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeS2eAVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeS2eAVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761707452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoDeeDTWNsdkyxfFh+UNMWEaxxXgKp2i3lC0MjKtAA4=;
	b=SeS2eAVoXWldYxGbkkUZ+YyUPqLLIO476TNAZyfmhPNVTM2yed9Tt1rJty9j2lCL3URb8j
	ETj0rMHFdZPOpujqidUl/70yWsz3PpbyxC+ecIv8W3/sy7yUERaGXsQN9YRoogbI6jMWls
	MYoqst+fiI+yUdcc/ApMB6XkPJr6A9M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-Za-O2DTYMneD50fW_PRWrA-1; Tue,
 28 Oct 2025 23:10:50 -0400
X-MC-Unique: Za-O2DTYMneD50fW_PRWrA-1
X-Mimecast-MFC-AGG-ID: Za-O2DTYMneD50fW_PRWrA_1761707449
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AF6A19541B7;
	Wed, 29 Oct 2025 03:10:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3417130001A2;
	Wed, 29 Oct 2025 03:10:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/5] ublk: reorder tag_set initialization before queue allocation
Date: Wed, 29 Oct 2025 11:10:27 +0800
Message-ID: <20251029031035.258766-2-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-1-ming.lei@redhat.com>
References: <20251029031035.258766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move ublk_add_tag_set() before ublk_init_queues() in the device
initialization path. This allows us to use the blk-mq CPU-to-queue
mapping established by the tag_set to determine the appropriate
NUMA node for each queue allocation.

The error handling paths are also reordered accordingly.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..2569566bf5e6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3178,17 +3178,17 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
 
-	ret = ublk_init_queues(ub);
+	ret = ublk_add_tag_set(ub);
 	if (ret)
 		goto out_free_dev_number;
 
-	ret = ublk_add_tag_set(ub);
+	ret = ublk_init_queues(ub);
 	if (ret)
-		goto out_deinit_queues;
+		goto out_free_tag_set;
 
 	ret = -EFAULT;
 	if (copy_to_user(argp, &ub->dev_info, sizeof(info)))
-		goto out_free_tag_set;
+		goto out_deinit_queues;
 
 	/*
 	 * Add the char dev so that ublksrv daemon can be setup.
@@ -3197,10 +3197,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ret = ublk_add_chdev(ub);
 	goto out_unlock;
 
-out_free_tag_set:
-	blk_mq_free_tag_set(&ub->tag_set);
 out_deinit_queues:
 	ublk_deinit_queues(ub);
+out_free_tag_set:
+	blk_mq_free_tag_set(&ub->tag_set);
 out_free_dev_number:
 	ublk_free_dev_number(ub);
 out_free_ub:
-- 
2.47.0

