Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF6C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D6A2080F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544819550;
	bh=pRgCTIOsiEvEuttqrH8YrexzH/2Tl0/O+NJvbjuss00=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MXZb0r1Yi6Pb8oyVcjSiJpGAfyWFrcT+6/sH2kifUHzc+fgo+1gukanplnEdVDDvf
	 4O+xshrks2HpcqtmOYYEzEld/xTFPgRV2QNlw9NKy18zw9SJxfkK/1DUcO3TGk6w57
	 5GLuht9t52EoVB5iZJ44VZAT/WyHq8Dox2AVkMcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeLNUc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbeLNUc3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 15:32:29 -0500
Received: from localhost (unknown [104.132.0.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113EB2080F;
        Fri, 14 Dec 2018 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544819549;
        bh=pRgCTIOsiEvEuttqrH8YrexzH/2Tl0/O+NJvbjuss00=;
        h=From:To:Cc:Subject:Date:From;
        b=zYZchJJ/wTQAq2nqnpMKRyi/o/mWnQnaIy/hj606dBPVi+0mUiZTPrlyr+O5j4KO2
         INVfXqkD+A84fA+ooyfeVIOF6GYlZRX1X1nwn9PMqTYHEIa7vALfLPLFidfmwnJPEn
         PVLFZAgVuwdxmzynryAXyN8JKLtTjr1L/KwfM94g=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] loop: drop caches if offset is changed
Date:   Fri, 14 Dec 2018 12:32:23 -0800
Message-Id: <20181214203223.7063-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we don't drop caches used in old offset, we can get old data from new
offset, which gives unexpected data to user.

Martijn found a loopback bug in the below scenario.
1) LOOP_SET_FD loads first two pages on loop file
2) LOOP_SET_STATUS64 changes the offset on the loop file
3) mount is failed due to the cached pages having wrong superblock

This patch drops caches when we change lo->offset.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Reported-by: Martijn Coenen <maco@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/block/loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb0cc8685076..f073a3f1a7cd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1154,6 +1154,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		struct block_device *bdev = lo->lo_device;
+
+		/* drop stale caches used in old offset */
+		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto exit;
-- 
2.19.0.605.g01d371f741-goog

