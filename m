Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C0C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F86361423
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhGBPa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:30:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61109 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGBPa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 11:30:28 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 162FRPlO067098;
        Sat, 3 Jul 2021 00:27:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 03 Jul 2021 00:27:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 162FRLph067016
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Jul 2021 00:27:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] loop: remove unused variable in loop_set_status()
Date:   Sat,  3 Jul 2021 00:27:14 +0900
Message-Id: <20210702152714.7978-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 0384264ea8a39bd9 ("block: pass a gendisk to bdev_disk_changed")
changed to pass lo->lo_disk instead of lo->lo_device.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc0e8c39a48b..9f5a93688164 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1434,7 +1434,6 @@ static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
-	struct block_device *bdev;
 	kuid_t uid = current_uid();
 	int prev_lo_flags;
 	bool partscan = false;
@@ -1503,7 +1502,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		bdev = lo->lo_device;
 		partscan = true;
 	}
 out_unlock:
-- 
2.18.4
