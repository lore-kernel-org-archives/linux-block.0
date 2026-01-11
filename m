Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8CB318130
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140146; cv=none; b=BxTJSRre0auMt6yI0/pw5MiTXZTorZYXv/Vf6cUgA5Mm4bSE38VCiwTu6byn3YJNdqMWAGg5UydjlFsnUI4eWxKVIv+7ZeL1ejXdol6WPxW7wPetKA1c4wUarWqWqWXLY0VQJGJeTEpZ06LyB7TppuPKaNBEl4OTlULJ1RJfq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140146; c=relaxed/simple;
	bh=Ag0uVGrpnbIG4KPnKUi+2FifwP+WT38R9JhaUMxAsjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3L2yTe5j/jkjcZldLXlsTRvMUYnKSRnaiF1kd74X3EZPyaUxLzbsGkw0VIJB6McQW4TrJZWqrAwkM5h92h93xmSnM5MfTMCA2AoZl3JqOM8z7I71eZkpAtV9ngJN9oB79QGp2G9QolF6Hx2g+/6nR5V2kTqiE0S7hbJ/qG7aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InhV4OMR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InhV4OMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768140143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDKmQ/vBAhuAQJhZdbAywzDYSnEbvSoZy5oL6rPIcJw=;
	b=InhV4OMRuio9IYxsAh/BEsn4391ELYTeCyN/d4m9UaZPHk9mUL6ntf0h3PtDPYFhinOoYV
	B0XK00yEfQEqp04CBQ0GfY9IZuYKHovaYanjQwHLp4k0f3Du7CaY9bWdewp27XnE4QIjbL
	oP/oqgnOIlWL4OtS+gaRBw3LFm9Lubc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-hMe-OensNnu2hIAp1YE6wg-1; Sun,
 11 Jan 2026 09:02:20 -0500
X-MC-Unique: hMe-OensNnu2hIAp1YE6wg-1
X-Mimecast-MFC-AGG-ID: hMe-OensNnu2hIAp1YE6wg_1768140139
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F648180057E;
	Sun, 11 Jan 2026 14:02:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B02CA180009E;
	Sun, 11 Jan 2026 14:02:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18.y] ublk: reorder tag_set initialization before queue allocation
Date: Sun, 11 Jan 2026 22:02:06 +0800
Message-ID: <20260111140206.18409-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

[ Upstream commit 011af85ccd871526df36988c7ff20ca375fb804d ]

Upstream commit 529d4d632788 ("ublk: implement NUMA-aware memory allocation")
is ported to linux-6.18.y, but it depends on commit 011af85ccd87 ("ublk: reorder
tag_set initialization before queue allocation"). kernel panic is reported on
6.18.y:

	https://github.com/ublk-org/ublksrv/issues/174

Move ublk_add_tag_set() before ublk_init_queues() in the device
initialization path. This allows us to use the blk-mq CPU-to-queue
mapping established by the tag_set to determine the appropriate
NUMA node for each queue allocation.

The error handling paths are also reordered accordingly.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 23aba73d24dc..babb58d2dcaf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3280,17 +3280,17 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
@@ -3299,10 +3299,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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

