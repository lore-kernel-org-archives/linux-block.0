Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFCC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79A32133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545075759;
	bh=EN58Tdnk5GF+aQXgkQLZW/TmJCLRyFE087/5+XXvFhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0U3GHea7oAePXQb6TKqd3hinNkUHMh+JTQHChDkckdmqBMcrd0rxVo26IQ53ehoHZ
	 p+8I5ESVn9rucirZLQj39rGOm6eNc2Gsxrdtmjsl1nztuvUHz9zYZ3Bi3gPI6WAZOu
	 BSqwjZwS/1awc8G243amjiuI6iEiTXhnrHAfmb2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeLQTmj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbeLQTmi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 14:42:38 -0500
Received: from localhost (unknown [104.132.0.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CDE2133F;
        Mon, 17 Dec 2018 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545075758;
        bh=EN58Tdnk5GF+aQXgkQLZW/TmJCLRyFE087/5+XXvFhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1lD5mkDwdh/flqSBusgcG3jJMgDlIbn1vtl3zCw+ink5IaCH1tfN01vQHUWfZpNyw
         VWx9bq+f1Pm6jRUj5XU+Jlmum/n/+G5Pvz+gHbH9ag2qV/UjRNPHjvYlYdnWMHeoCm
         kjZd/fN4vV/buFwyghuaQzheO7VGwOXtufnBHh0U=
Date:   Mon, 17 Dec 2018 11:42:36 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: drop caches if offset or block_size are changed
Message-ID: <20181217194236.GA50659@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181214203223.7063-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214203223.7063-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we don't drop caches used in old offset or block_size, we can get old data
from new offset/block_size, which gives unexpected data to user.

For example, Martijn found a loopback bug in the below scenario.
1) LOOP_SET_FD loads first two pages on loop file
2) LOOP_SET_STATUS64 changes the offset on the loop file
3) mount is failed due to the cached pages having wrong superblock

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Reported-by: Martijn Coenen <maco@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

v1 to v2:
 - cover block_size change

 drivers/block/loop.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb0cc8685076..382557c81674 100644
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
@@ -1388,6 +1394,15 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
 
+	/* Don't change the size if it is same as current */
+	if (lo->lo_queue->limits.logical_block_size != arg) {
+		struct block_device *bdev = lo->lo_device;
+
+		/* drop stale caches likewise set_blocksize */
+		sync_blockdev(bdev);
+		kill_bdev(bdev);
+	}
+
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	return 0;
-- 
2.19.0.605.g01d371f741-goog

