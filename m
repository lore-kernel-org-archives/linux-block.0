Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23401ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 06:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIWGQL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIWGQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:16:09 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614A12387A;
        Thu, 22 Sep 2022 23:16:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVS0gF_1663913750;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQVS0gF_1663913750)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:16:00 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RESEND PATCH V5 2/7] ublk_drv: define macros for recovery feature and check them
Date:   Fri, 23 Sep 2022 14:15:00 +0800
Message-Id: <20220923061505.52007-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define some macros for recovery feature.

UBLK_S_DEV_QUIESCED implies that ublk_device is quiesced
and is ready for recovery. This state can be observed by userspace.

UBLK_F_USER_RECOVERY implies that:
(1) ublk_drv enables recovery feature. It won't let monitor_work to
    automatically abort rqs and release the device.
(2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
    userspace(ublksrv) before crash.
(3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
    ublk_drv requeues rqs.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c39b67d7133d..05bfbaa49696 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -49,7 +49,8 @@
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
-		| UBLK_F_NEED_GET_DATA)
+		| UBLK_F_NEED_GET_DATA \
+		| UBLK_F_USER_RECOVERY)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
@@ -323,6 +324,21 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+static inline bool ublk_queue_can_use_recovery(
+		struct ublk_queue *ubq)
+{
+	if (ubq->flags & UBLK_F_USER_RECOVERY)
+		return true;
+	return false;
+}
+
+static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+{
+	if (ub->dev_info.flags & UBLK_F_USER_RECOVERY)
+		return true;
+	return false;
+}
+
 static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 677edaab2b66..340ff14bde49 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -74,9 +74,12 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+#define UBLK_F_USER_RECOVERY	(1UL << 3)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
+#define UBLK_S_DEV_QUIESCED	2
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.27.0

