Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3BC636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 15:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBGPIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 10:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBGPIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 10:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD033C1F
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675782436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yCsy72Lhaq3zU8TqDsFrJMTmRrA3i9fAMdz+8ZX+okA=;
        b=SV2exPS713YsuXaHrbLjSvd5/y1AKoJ5P9eGNxTB87DymJ3QhLMQ7F4U605Mq1ijh4xZAG
        lHOD6xfkypWGCGmYGbec38hi6TLmDkTNiIAr8IkDtfYcEMi1dTxvlx1baAIjW0gVQctQL0
        ONfanEAFqmuZ5DbOHWz9yZYDrb/xB0g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-PieQk4upOTa3TvTspm5vjw-1; Tue, 07 Feb 2023 10:07:07 -0500
X-MC-Unique: PieQk4upOTa3TvTspm5vjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96B9C2A59569;
        Tue,  7 Feb 2023 15:07:07 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9FC8140EBF4;
        Tue,  7 Feb 2023 15:07:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH] block: ublk: improve handling device deletion
Date:   Tue,  7 Feb 2023 23:07:00 +0800
Message-Id: <20230207150700.545530-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside ublk_ctrl_del_dev(), when the device is removed, we wait
until the device number is freed with holding global lock of
ublk_ctl_mutex, this way isn't friendly from user viewpoint:

1) if device is in-use, the current delete command hangs in
ublk_ctrl_del_dev(), and user can't break from the handling
because wait_event() is used

2) global lock is held, so any new device can't be added and
other old devices can't be removed.

Improve the deleting handling by the following way, suggested by
Nadav:

1) wait without holding the global lock

2) replace wait_event() with wait_event_interruptible()

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Suggested-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d83fe2c2b3ba..e6eceee44366 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -150,6 +150,7 @@ struct ublk_device {
 
 #define UB_STATE_OPEN		0
 #define UB_STATE_USED		1
+#define UB_STATE_DELETED	2
 	unsigned long		state;
 	int			ub_number;
 
@@ -1804,20 +1805,33 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 	if (ret)
 		return ret;
 
-	ublk_remove(ub);
+	if (!test_bit(UB_STATE_DELETED, &ub->state)) {
+		ublk_remove(ub);
+		set_bit(UB_STATE_DELETED, &ub->state);
+	}
 
 	/* Mark the reference as consumed */
 	*p_ub = NULL;
 	ublk_put_device(ub);
+	mutex_unlock(&ublk_ctl_mutex);
 
 	/*
 	 * Wait until the idr is removed, then it can be reused after
 	 * DEL_DEV command is returned.
+	 *
+	 * If we returns because of user interrupt, future delete command
+	 * may come:
+	 *
+	 * - the device number isn't freed, this device won't or needn't
+	 *   be deleted again, since UB_STATE_DELETED is set, and device
+	 *   will be released after the last reference is dropped
+	 *
+	 * - the device number is freed already, we will not find this
+	 *   device via ublk_get_device_from_id()
 	 */
-	wait_event(ublk_idr_wq, ublk_idr_freed(idx));
-	mutex_unlock(&ublk_ctl_mutex);
+	wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx));
 
-	return ret;
+	return 0;
 }
 
 static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
-- 
2.38.1

