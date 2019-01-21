Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE634C2F3C7
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2672084C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078833;
	bh=jGuGdLqgpHk+E+/Bbwp81yoJ7Rt9O10fe2Bilcho3KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4X/AB9r//5nb/P/xN1av2prcD8TSl1D78BVTisTh/rKNODk1rSsl1EUqByNV+mUb
	 W4NtNWZBIUYcZXcomfgnCOVP6rYgb4Le1X62kFbfzxZCmokcD/qnkjlb7992leNLHA
	 0aCY69rci+77sdL9FQbvoK5YxF0NaUBkFhTXWTmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfAUNxw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731347AbfAUNxv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD23A2084C;
        Mon, 21 Jan 2019 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078830;
        bh=jGuGdLqgpHk+E+/Bbwp81yoJ7Rt9O10fe2Bilcho3KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veZiTmmrPaWRRt4GtWf/+uE02n0CVpuXk+P8CMSh4N0rUDFlnAkqC/4GehZfFLlAp
         fueR13KRmwkBZXRNwiwdgVDTHF5T+z8H7xcmqhrnTeKZ8BdqdN208AVwdpbEGFMu6f
         fC95C5RXQqkN4TSsTMh4TtHTxbpB6uGoaG6khrPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.14 58/59] loop: drop caches if offset or block_size are changed
Date:   Mon, 21 Jan 2019 14:44:23 +0100
Message-Id: <20190121122503.771813232@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 5db470e229e22b7eda6e23b5566e532c96fb5bc3 upstream.

If we don't drop caches used in old offset or block_size, we can get old data
from new offset/block_size, which gives unexpected data to user.

For example, Martijn found a loopback bug in the below scenario.
1) LOOP_SET_FD loads first two pages on loop file
2) LOOP_SET_STATUS64 changes the offset on the loop file
3) mount is failed due to the cached pages having wrong superblock

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Reported-by: Martijn Coenen <maco@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1097,6 +1097,12 @@ loop_set_status(struct loop_device *lo,
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
 
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
+		sync_blockdev(lo->lo_device);
+		kill_bdev(lo->lo_device);
+	}
+
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
@@ -1125,6 +1131,14 @@ loop_set_status(struct loop_device *lo,
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		/* kill_bdev should have truncated all the pages */
+		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
+			err = -EAGAIN;
+			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+				__func__, lo->lo_number, lo->lo_file_name,
+				lo->lo_device->bd_inode->i_mapping->nrpages);
+			goto exit;
+		}
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto exit;
@@ -1346,22 +1360,39 @@ static int loop_set_dio(struct loop_devi
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
+	int err = 0;
+
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
+	if (lo->lo_queue->limits.logical_block_size != arg) {
+		sync_blockdev(lo->lo_device);
+		kill_bdev(lo->lo_device);
+	}
+
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	/* kill_bdev should have truncated all the pages */
+	if (lo->lo_queue->limits.logical_block_size != arg &&
+			lo->lo_device->bd_inode->i_mapping->nrpages) {
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
-
+out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	return 0;
+	return err;
 }
 
 static int lo_ioctl(struct block_device *bdev, fmode_t mode,


