Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36A4A15
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419641; cv=none; b=JYFoHlRJq/o0lkfNNJdcw5NWHnf7ncERq8RvcS3X/iwL0VCAlJ4+wm/+bmTMQPRoBQz4aOh118bTYJToeAW0KXmnBRRJCY9t3Xwk47bOYHio8R0LoDzaZh0p+an3tMYbWJRXMChV54WKL1iZrfNy5tW/TTazazpB3FJd0o6/XBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419641; c=relaxed/simple;
	bh=9XGUj6XGwLzz4DJsyrnwN5Lg5WbRgSYtiY2pVsIYnmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbMkJA0VhoUVoeILwjY+vFh/191Oox4Yx6NWM4kCUNOYSfv3Xb0z0ZlNV6L9IVz4EF4uWFy+oD2J7V5vDr5enqKMNEYruuaEjtbIf53srXRpvOUbnLID/khLqAgC38/X6ao6d9iADsu/j7HGyTCVYUv+nYHj/7NbH+ggC1YG1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4i8oU5u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4i8oU5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725419637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=orF6jzXZFAW69kH2X2PTjqIfJ0wYuCpRt1ksXC7XMuQ=;
	b=X4i8oU5uLa8VbbKtWpI6ibatvFP8+OD8UlFjNk3R9X2LByBccEvzVmScBdVI9Eht9YXbdw
	DkIvnmTvWcqCmQ7fCxGrz9acXGfPopZc4wX2165IKJ4H2f0BCcXmkb0fny1d36UfmkkFBh
	fY5YPmH7af23C0gNg5qH5gb3e4EFQTU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ivcZ92TNNuWLn9lD2fEyzw-1; Tue,
 03 Sep 2024 23:13:56 -0400
X-MC-Unique: ivcZ92TNNuWLn9lD2fEyzw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC72A19373D7;
	Wed,  4 Sep 2024 03:13:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133DA19560AA;
	Wed,  4 Sep 2024 03:13:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Changhui Zhong <czhong@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 RESEND] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
Date: Wed,  4 Sep 2024 11:13:48 +0800
Message-ID: <20240904031348.4139545-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Li Nan <linan122@huawei.com>

When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
issue.

Fix it by adding the check in ublk_ctrl_start_recovery() and return
immediately in case of zero 'ub->nr_queues_ready'.

  BUG: kernel NULL pointer dereference, address: 0000000000000028
  RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
  Call Trace:
   <TASK>
   ? __die+0x20/0x70
   ? page_fault_oops+0x75/0x170
   ? exc_page_fault+0x64/0x140
   ? asm_exc_page_fault+0x22/0x30
   ? ublk_ctrl_start_recovery.constprop.0+0x82/0x180
   ublk_ctrl_uring_cmd+0x4f7/0x6c0
   ? pick_next_task_idle+0x26/0x40
   io_uring_cmd+0x9a/0x1b0
   io_issue_sqe+0x193/0x3f0
   io_wq_submit_work+0x9b/0x390
   io_worker_handle_work+0x165/0x360
   io_wq_worker+0xcb/0x2f0
   ? finish_task_switch.isra.0+0x203/0x290
   ? finish_task_switch.isra.0+0x203/0x290
   ? __pfx_io_wq_worker+0x10/0x10
   ret_from_fork+0x2d/0x50
   ? __pfx_io_wq_worker+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
Reported-and-tested-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Li Nan <linan122@huawei.com>
---
v2: add the check to ublk_ctrl_start_recovery().

 drivers/block/ublk_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 890c08792ba8..1d53a3f48a0e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2663,6 +2663,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	mutex_lock(&ub->mutex);
 	if (!ublk_can_use_recovery(ub))
 		goto out_unlock;
+	if (!ub->nr_queues_ready)
+		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
-- 
2.42.0

