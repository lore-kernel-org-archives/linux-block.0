Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F9C32771
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 10:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIUKBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIUKBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 06:01:21 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21918B2E3;
        Wed, 21 Sep 2022 03:01:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQNuDpk_1663754457;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQNuDpk_1663754457)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 18:01:03 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V4 8/8] Documentation: document ublk user recovery feature
Date:   Wed, 21 Sep 2022 17:58:49 +0800
Message-Id: <20220921095849.84988-9-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for user recovery feature of ublk subsystem.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 Documentation/block/ublk.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 2122d1a4a541..3f1bfd51898b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -144,6 +144,31 @@ managing and controlling ublk devices with help of several control commands:
   For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
   responsibility to save IO target specific info in userspace.
 
+- ``UBLK_CMD_RESTART_DEV``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. The old
+  process has exited and ublk device is quiesced. Then, user should start a new
+  process which opens ``/dev/ublkc*`` and gets all ublk queues be ready. Finally
+  user should send this command. When this command returns, ublk device is
+  unquiesced and new I/O requests are passed to the new process.
+
+- user recovery feature description
+
+  Two new features are added for user recovery: ``UBLK_F_USER_RECOVERY`` and
+  ``UBLK_F_USER_RECOVERY_REISSUE``.
+
+  With ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublksrv io handler) is
+  dying, ublk does not release ``/dev/ublkc*`` or ``/dev/ublkb*`` but requeues all
+  inflight requests which have not been issued to userspace. Requests which have
+  been issued to userspace are aborted.
+
+  With ``UBLK_F_USER_RECOVERY_REISSUE`` set, after one ubq_daemon(ublksrv io
+  handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``, requests which have been
+  issued to userspace are requeued and will be re-issued to the new process after
+  handling ``UBLK_CMD_RESTART_DEV``. ``UBLK_F_USER_RECOVERY_REISSUE`` is designed
+  for backends who tolerate double-write since the driver may issue the same
+  I/O request twice. It might be useful to a read-only FS or a VM backend.
+
 Data plane
 ----------
 
-- 
2.27.0

