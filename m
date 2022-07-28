Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54265C19F29
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiG1Mjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiG1Mjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 08:39:43 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAF6BD64
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 05:39:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKfiKRc_1659011979;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKfiKRc_1659011979)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 20:39:39 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH V4 1/2] ublk_cmd.h: add one new ublk command: UBLK_IO_NEED_GET_DATA
Date:   Thu, 28 Jul 2022 20:39:15 +0800
Message-Id: <c8a64b6b51c78340da7daa9e1054608695e79619.1659011443.git.ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one new ublk command: UBLK_IO_NEED_GET_DATA. It is prepared for a new
feature designed for a user application who wants to allocate IO buffer
and set IO buffer address only after it receives an IO request from
ublksrv.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 include/uapi/linux/ublk_cmd.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ca33092354ab..51a1ef9051ab 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -28,12 +28,21 @@
  *      this IO request, request's handling result is committed to ublk
  *      driver, meantime FETCH_REQ is piggyback, and FETCH_REQ has to be
  *      handled before completing io request.
+ *
+ * NEED_GET_DATA: only used for write requests to set io addr and copy data
+ *      When NEED_GET_DATA is set, ublksrv has to issue UBLK_IO_NEED_GET_DATA
+ *      command after ublk driver returns UBLK_IO_RES_NEED_GET_DATA.
+ *
+ *      It is only used if ublksrv set UBLK_F_NEED_GET_DATA flag
+ *      while starting a ublk device.
  */
 #define	UBLK_IO_FETCH_REQ		0x20
 #define	UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
+#define	UBLK_IO_NEED_GET_DATA	0x22
 
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
+#define UBLK_IO_RES_NEED_GET_DATA	1
 #define UBLK_IO_RES_ABORT		(-ENODEV)
 
 #define UBLKSRV_CMD_BUF_OFFSET	0
@@ -54,6 +63,15 @@
  */
 #define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << 1)
 
+/*
+ * User should issue io cmd again for write requests to
+ * set io buffer address and copy data from bio vectors
+ * to the userspace io buffer.
+ *
+ * In this mode, task_work is not used.
+ */
+#define UBLK_F_NEED_GET_DATA (1UL << 2)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.34.1

