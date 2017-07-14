Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753635AbdGNNmH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 09:42:07 -0400
From: David Sterba <dsterba@suse.com>
To: linux-block@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, bo.li.liu@oracle.com,
        fdmanana@suse.com
Subject: [PATCH] block: note about cloned bios and bio_for_each_segment_all
Date: Fri, 14 Jul 2017 15:40:51 +0200
Message-Id: <20170714134051.22756-1-dsterba@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We've switched to cloned bios in btrfs and hit a nasty bug leading to
corruptions, when cloned bios are iterated by bio_for_each_segment_all.

Report and fix:
https://patchwork.kernel.org/patch/9838535/

As a matter of precaution, we've added assertions to btrfs code to catch
the bad usage pattern:

https://patchwork.kernel.org/patch/9839267/

The cloned/bi_vcnt behaviour seems tobe implementation dependent and is
not documented, so this patch at least warns about this one particular
case but this might still be insufficient.

CC: linux-block@vger.kernel.org
Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/linux/bio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b1cf4ba0902..f1ac84edcf39 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
+ *
+ * Note that cloned bios must not use this as their bi_vcnt may be invalid and
+ * this could lead to silent corruptions.
  */
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
-- 
2.13.0
