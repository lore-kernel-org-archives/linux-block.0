Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4393C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9096E64E5F
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBVJs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:48:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:45648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhBVJsx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 04:48:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CDF3AED2;
        Mon, 22 Feb 2021 09:48:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 17C561E14ED; Mon, 22 Feb 2021 10:48:11 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH v2] block: Try to handle busy underlying device on discard
Date:   Mon, 22 Feb 2021 10:48:09 +0100
Message-Id: <20210222094809.21775-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 384d87ef2c95 ("block: Do not discard buffers under a mounted
filesystem") made paths issuing discard or zeroout requests to the
underlying device try to grab block device in exclusive mode. If that
failed we returned EBUSY to userspace. This however caused unexpected
fallout in userspace where e.g. FUSE filesystems issue discard requests
from userspace daemons although the device is open exclusively by the
kernel. Also shrinking of logical volume by LVM issues discard requests
to a device which may be claimed exclusively because there's another LV
on the same PV. So to avoid these userspace regressions, fall back to
invalidate_inode_pages2_range() instead of returning EBUSY to userspace
and return EBUSY only of that call fails as well (meaning that there's
indeed someone using the particular device range we are trying to
discard).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=211167
Fixes: 384d87ef2c95 ("block: Do not discard buffers under a mounted filesystem")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 235b5042672e..c33151020bcd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -118,13 +118,22 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 	if (!(mode & FMODE_EXCL)) {
 		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
 		if (err)
-			return err;
+			goto invalidate;
 	}
 
 	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
+
+invalidate:
+	/*
+	 * Someone else has handle exclusively open. Try invalidating instead.
+	 * The 'end' argument is inclusive so the rounding is safe.
+	 */
+	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+					     lstart >> PAGE_SHIFT,
+					     lend >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL(truncate_bdev_range);
 
-- 
2.26.2

