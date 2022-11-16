Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C466C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 06:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKPGJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKPGJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 01:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C286544
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 22:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668578940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87ejIpbvwqks9afuNQh21Ac6vIaZG3OpnGr3VCaW1Gw=;
        b=C9h2M7BeUDfgSM6hiPEAKwWgzVEd0rUd9BZYvE0yY1j12MdYzfg7yf32tCkoBq5rF2zgFS
        +OEm8gItR1CFSX8MTVJ0eSQn3QoySD/z3lWsVnBPM5cuyPfXuawEV6iY89l7JUQ9ERXRdB
        72i0kJ5EY+4Qt/lmjXlIpqwJ3kwzQFU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-7p6LQm7VN4O7b21Go2Oo9A-1; Wed, 16 Nov 2022 01:08:54 -0500
X-MC-Unique: 7p6LQm7VN4O7b21Go2Oo9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C7003802B81;
        Wed, 16 Nov 2022 06:08:54 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 533D7C1912A;
        Wed, 16 Nov 2022 06:08:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] ublk_drv: don't probe partitions if the ubq daemon isn't trusted
Date:   Wed, 16 Nov 2022 14:08:31 +0800
Message-Id: <20221116060835.159945-3-ming.lei@redhat.com>
In-Reply-To: <20221116060835.159945-1-ming.lei@redhat.com>
References: <20221116060835.159945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If any ubq daemon is unprivileged, the ublk char device is allowed
for unprivileged user, and we can't trust the current user, so not
probe partitions.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fe997848c1ff..a5f3d8330be5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -149,6 +149,7 @@ struct ublk_device {
 
 #define UB_STATE_OPEN		0
 #define UB_STATE_USED		1
+#define UB_STATE_PRIVILEGED	2
 	unsigned long		state;
 	int			ub_number;
 
@@ -161,6 +162,7 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
+	unsigned int		nr_privileged_daemon;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
@@ -1184,9 +1186,15 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		ubq->ubq_daemon = current;
 		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
+
+		if (capable(CAP_SYS_ADMIN))
+			ub->nr_privileged_daemon++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		if (ub->nr_privileged_daemon == ub->nr_queues_ready)
+			set_bit(UB_STATE_PRIVILEGED, &ub->state);
 		complete_all(&ub->completion);
+	}
 	mutex_unlock(&ub->mutex);
 }
 
@@ -1540,6 +1548,10 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		goto out_put_disk;
 
+	/* don't probe partitions if any one ubq daemon is un-trusted */
+	if (!test_bit(UB_STATE_PRIVILEGED, &ub->state))
+		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
-- 
2.31.1

