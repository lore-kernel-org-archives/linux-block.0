Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D887CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiA1NAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiA1NAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C98C06174A
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QDm3fYqgGVotU+TnRX5ZYymK6UBugb4L15WsvcVh0rI=; b=ALdkJBqzL01IZ1mkfzhi/gzZ2J
        w4JFVukNfLtuVmDsnvVzDzBqkOnYZyufW7LVW+XQj2+rD4q0FVtG4u6RztMd9Pt70cluxyVk50aw7
        EBmSJzTjc2FSjuaEnGJN+Bz4TBeE/mXhzzj8LHJovTYmTCU+wSeKxAorHo58h5dksB++/Dc6/YWDl
        0wEck6JYsJoRR/GLJYIHEm4+JoitVblfAUUYG8G10NlJ8v4DV66cbcn1fOUX5vIGFGdlffwwaV7Zo
        pOEovoReZgxQiSlbtqxiVFRSs8T2kGBGX7kqZL6vTQLJNauPcqz+7t0vsJ0ItaqvYc21ns/RbBP3v
        F4dlgglA==;
Received: from [2001:4bb8:180:4c4c:73e:e8c7:4199:32d7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDQrp-0028yj-IB; Fri, 28 Jan 2022 13:00:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 6/8] loop: don't freeze the queue in lo_release
Date:   Fri, 28 Jan 2022 14:00:20 +0100
Message-Id: <20220128130022.1750906-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128130022.1750906-1-hch@lst.de>
References: <20220128130022.1750906-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By the time the final ->release is called there can't be outstanding I/O.
For non-final ->release there is no need for driver action at all.

Thus remove the useless queue freeze.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f349ddfc0e84a..1ca70f735b5bc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1766,13 +1766,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 */
 		loop_schedule_rundown(lo);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
-		blk_mq_freeze_queue(lo->lo_queue);
-		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
 out_unlock:
-- 
2.30.2

