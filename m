Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40991 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758444AbdLSIe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 03:34:26 -0500
Received: by mail-wr0-f195.google.com with SMTP id p69so9036788wrb.8
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2017 00:34:26 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <koalinux@gmail.com>
To: linux-block@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <koalinux@gmail.com>
Subject: [PATCH] Disable pm only when scsi mq is default by config.
Date: Tue, 19 Dec 2017 10:34:40 +0200
Message-Id: <20171219083440.17831-1-koalinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch allow pm on systems that explicitly disable scsi mq as
a default.

Signed-off-by: José Pekkarinen <koalinux@gmail.com>
---
 block/blk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 33ee583cfe45..68183bc5933f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3440,9 +3440,11 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
+#ifdef CONFIG_SCSI_MQ_DEFAULT
 	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
 	if (q->mq_ops)
 		return;
+#endif
 
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
-- 
2.13.6
