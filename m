Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A1EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 05:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGKFBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 01:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKFBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 01:01:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6389FE
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 22:01:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A0A768B05; Tue, 11 Jul 2023 07:01:02 +0200 (CEST)
Date:   Tue, 11 Jul 2023 07:01:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Message-ID: <20230711050101.GA19128@lst.de>
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKx2jVONy35B0/S1@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think that's because it doesn't look at sbi->s_ndevs in
destroy_device_list.  Let's try the variant below, which also fixes
the buildbot warning for non-zoned configfs:

---
From 645d8dceaa97b6ee73be067495b111b15b187498 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 7 Jul 2023 10:31:49 +0200
Subject: f2fs: don't reopen the main block device in f2fs_scan_devices

f2fs_scan_devices reopens the main device since the very beginning, which
has always been useless, and also means that we don't pass the right
holder for the reopen, which now leads to a warning as the core super.c
holder ops aren't passed in for the reopen.

Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
Fixes: 0718afd47f70 ("block: introduce holder ops")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c |  2 +-
 fs/f2fs/super.c   | 20 ++++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca31163da00a55..30883beb750a59 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1561,7 +1561,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
+		if (i > 0)
+			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4190,16 +4191,12 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	sbi->aligned_blksize = true;
 
 	for (i = 0; i < max_devices; i++) {
-
-		if (i > 0 && !RDEV(i).path[0])
+		if (i == 0)
+			FDEV(0).bdev = sbi->sb->s_bdev;
+		else if (!RDEV(i).path[0])
 			break;
 
-		if (max_devices == 1) {
-			/* Single zoned block device mount */
-			FDEV(0).bdev =
-				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
-						  sbi->sb->s_type, NULL);
-		} else {
+		if (max_devices > 1) {
 			/* Multi-device mount */
 			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
 			FDEV(i).total_segments =
@@ -4215,10 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
+				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
+					mode, sbi->sb->s_type, NULL);
 			}
-			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
-							  sbi->sb->s_type,
-							  NULL);
 		}
 		if (IS_ERR(FDEV(i).bdev))
 			return PTR_ERR(FDEV(i).bdev);
-- 
2.39.2

