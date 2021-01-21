Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44528C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 17:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E521F21973
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 17:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbhAURwc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:52:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:36688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbhAURwB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 12:52:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611251472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mxouExbipMyRyBzMn5WW0h/s7htQTmCWj0dFW9Ap/EI=;
        b=e1eReTIRIgzh2oZtRLeof8M/Ye6vU0gg0o9i53k3Vyl8/+FPE7jN8gUtKBiS0XvDF7zaUX
        AblOJ8D8mQT1v5U7U/f1IyHutSUwKEUMeb6jdhdEEUasGp/Z8WnkHX3tQrontHxw5I3LJw
        VNhROEnjsgqXKFzfS6CP4KFj/8I/Tl8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7037ABD6;
        Thu, 21 Jan 2021 17:51:12 +0000 (UTC)
From:   mwilck@suse.com
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Alasdair G Kergon <agk@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2] dm: avoid filesystem lookup in dm_get_dev_t()
Date:   Thu, 21 Jan 2021 18:50:56 +0100
Message-Id: <20210121175056.20078-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

This reverts commit
644bda6f3460 ("dm table: fall back to getting device using name_to_dev_t()")

dm_get_dev_t() is just used to convert an arbitrary 'path' string
into a dev_t. It doesn't presume that the device is present; that
check will be done later, as the only caller is dm_get_device(),
which does a dm_get_table_device() later on, which will properly
open the device.
So if the path string already _is_ in major:minor representation
we can convert it directly, avoiding a recursion into the filesystem
to lookup the block device.
This avoids a hang in multipath_message() when the filesystem is
inaccessible.

Fixes: 644bda6f3460 ("dm table: fall back to getting device using name_to_dev_t()")

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/md/dm-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 188f41287f18..4acf2342f7ad 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -363,14 +363,23 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 {
 	int r;
 	dev_t dev;
+	unsigned int major, minor;
+	char dummy;
 	struct dm_dev_internal *dd;
 	struct dm_table *t = ti->table;
 
 	BUG_ON(!t);
 
-	dev = dm_get_dev_t(path);
-	if (!dev)
-		return -ENODEV;
+	if (sscanf(path, "%u:%u%c", &major, &minor, &dummy) == 2) {
+		/* Extract the major/minor numbers */
+		dev = MKDEV(major, minor);
+		if (MAJOR(dev) != major || MINOR(dev) != minor)
+			return -EOVERFLOW;
+	} else {
+		dev = dm_get_dev_t(path);
+		if (!dev)
+			return -ENODEV;
+	}
 
 	dd = find_device(&t->devices, dev);
 	if (!dd) {
-- 
2.29.2

