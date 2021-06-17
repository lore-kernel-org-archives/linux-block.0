Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACDC61375
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 22:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFQWO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:14:29 -0400
Received: from mail.klausen.dk ([157.90.24.29]:51186 "EHLO mail.klausen.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhFQWO2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 18:14:28 -0400
From:   Kristian Klausen <kristian@klausen.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klausen.dk; s=dkim;
        t=1623967938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q7RbCKgSk5h1jem9dXNZ5yqfit5y4sv6R9H/UHSF8xg=;
        b=18dAxXYSeh3O6HtlKbvDbc35tXLIHZCBiVTqkScX+7q5NKHJdIijAy8GnBMMGR1TIcPYSv
        HKyn6VJeqFrNPy3WmpjeYQmueaLiwXhxTO7GJY1ofEAjSK4pOEsY1oBiwrbCZexKYhSQmJ
        1WA2QzQKBxTgtuGxi5E/yqxt8WU/404=
To:     linux-block@vger.kernel.org
Cc:     Kristian Klausen <kristian@klausen.dk>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] loop: Fix missing discard support when using LOOP_CONFIGURE
Date:   Fri, 18 Jun 2021 00:11:57 +0200
Message-Id: <20210617221158.7045-1-kristian@klausen.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc: <stable@vger.kernel.org> # 5.8.x-
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
Signed-off-by: Kristian Klausen <kristian@klausen.dk>
---
Tested like so (without the patch):
losetup 2.37<= uses LOOP_CONFIGURE instead of LOOP_SET_STATUS64[1]

# fallocate -l100M disk.img
# rmmod loop
# losetup --version
losetup from util-linux 2.36.2
# losetup --find --show disk.img
/dev/loop0
# grep '' /sys/devices/virtual/block/loop0/queue/*discard*
/sys/devices/virtual/block/loop0/queue/discard_granularity:4096
/sys/devices/virtual/block/loop0/queue/discard_max_bytes:4294966784
/sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:4294966784
/sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
/sys/devices/virtual/block/loop0/queue/max_discard_segments:1
# losetup -d /dev/loop0
# [update util-linux]
# losetup --version
losetup from util-linux 2.37
# rmmod loop
# losetup --find --show disk.img
/dev/loop0
# grep '' /sys/devices/virtual/block/loop0/queue/*discard*
/sys/devices/virtual/block/loop0/queue/discard_granularity:0
/sys/devices/virtual/block/loop0/queue/discard_max_bytes:0
/sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:0
/sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
/sys/devices/virtual/block/loop0/queue/max_discard_segments:1


With the patch applied:

# losetup --version
losetup from util-linux 2.37
# rmmod loop
# losetup --find --show disk.img
/dev/loop0
# grep '' /sys/devices/virtual/block/loop0/queue/*discard*
/sys/devices/virtual/block/loop0/queue/discard_granularity:4096
/sys/devices/virtual/block/loop0/queue/discard_max_bytes:4294966784
/sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:4294966784
/sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
/sys/devices/virtual/block/loop0/queue/max_discard_segments:1

[1] https://github.com/karelzak/util-linux/pull/1152

 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 76e12f3482a9..ec957f6d8a49 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1168,6 +1168,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
 
+	loop_config_discard(lo);
+
 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */

base-commit: 70585216fe7730d9fb5453d3e2804e149d0fe201
-- 
2.32.0

