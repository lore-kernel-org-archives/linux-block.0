Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F509C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjAJNVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjAJNVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:21:44 -0500
Received: from smtp.tiscali.it (michael-notr.mail.tiscali.it [213.205.33.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAF216396
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:21:41 -0800 (PST)
Received: from localhost.localdomain ([87.5.164.230])
        by michael.mail.tiscali.it with 
        id 71Md2900Y4yaPbr011Mdwr; Tue, 10 Jan 2023 13:21:39 +0000
x-auth-user: fantonifabio@tiscali.it
From:   Fabio Fantoni <fantonifabio@tiscali.it>
To:     corbet@lwn.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Fantoni <fantonifabio@tiscali.it>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2] documentation: fix Generic Block Device Capability
Date:   Tue, 10 Jan 2023 14:21:04 +0100
Message-Id: <20230110132104.12499-1-fantonifabio@tiscali.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1673356899; bh=4ehCFwkoEkiw+WDml9IeFtgWOApI2Gi6ZWXqobEfgyQ=;
        h=From:To:Cc:Subject:Date;
        b=q1xJBbZFMLttacksgnTnc2YciRmj6wfcF3zNX1dOzH8rIdh24kiBImpgcCngxdLwx
         MvaV0gUI3qgOXxFCDikHeh2InMu9Y9Jgr8Ix33bMF0SpV0jvwNp6Mo6K22AkidWo3k
         AHF4nNcDDOXIpaCmnEswC3/E6jEsGASr/+LYxqgg=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While adding documentation for blkfilter, new lines of documentation was
added in the file include/linux/blkdev.h. Sergei Shtepa spotted that
this changed Documentation/block/capability.rst output.
Checking the documentation of previous versions, for example
https://www.kernel.org/doc/html/v5.10/block/capability.html I also saw
that the output of recent versions was already "broken" before.
This patch restore the output only relate to generic block device
capability and also added the hexadecimal values that was removed from
doc comment in commit 430cc5d (block: cleanup the GENHD_FL_*
definitions).
This will make this documentation page return to "documents the sysfs
file block/<disk>/capability" including the printed value in hexadecimal.

Co-developed-by: Sergei Shtepa <sergei.shtepa@veeam.com>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
---
Note: v1 was included in blksnap v2 serie

Changes from v1:
- Documentation/block/capability.rst: removed other blkdev.h functions
  and keep only ":DOC: genhd capability flags"
- added changes of include/linux/blkdev.h

 Documentation/block/capability.rst |  1 +
 include/linux/blkdev.h             | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
index 2ae7f064736a..e5d58e0d81ba 100644
--- a/Documentation/block/capability.rst
+++ b/Documentation/block/capability.rst
@@ -8,3 +8,4 @@ This file documents the sysfs file ``block/<disk>/capability``.
 capabilities a specific block device supports:
 
 .. kernel-doc:: include/linux/blkdev.h
+    :DOC: genhd capability flags
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43d4e073b111..71ca547ab19f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -74,16 +74,16 @@ struct partition_meta_info {
 /**
  * DOC: genhd capability flags
  *
- * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
+ * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to
  * removable media.  When set, the device remains present even when media is not
  * inserted.  Shall not be set for devices which are removed entirely when the
  * media is removed.
  *
- * ``GENHD_FL_HIDDEN``: the block device is hidden; it doesn't produce events,
- * doesn't appear in sysfs, and can't be opened from userspace or using
- * blkdev_get*. Used for the underlying components of multipath devices.
+ * ``GENHD_FL_HIDDEN`` (0x02): the block device is hidden; it doesn't produce
+ * events, doesn't appear in sysfs, and can't be opened from userspace or
+ * using blkdev_get*. Used for the underlying components of multipath devices.
  *
- * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
+ * ``GENHD_FL_NO_PART`` (0x04): partition support is disabled. The kernel will not
  * scan for partitions from add_disk, and users can't add partitions manually.
  *
  */
-- 
2.25.1

