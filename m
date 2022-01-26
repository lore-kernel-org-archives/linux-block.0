Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCDC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiAZPvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiAZPvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:51:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18303C06173B
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7mcmGl2N+/REqgFGB4EdVJwF3aTeqcBN/j5srI3AZ+E=; b=Cjg+6cQvCBGGD5UepYRSRWoiv8
        I65MEVJCLkd00skl+DYejH6QYtNJpeFj9d6IdB2vObXhUBGDpYN7USgr/fou6pKKmSzWwApJj1CBN
        1NPDg8XEffvhMaXPW/fwsSEBlIwNhQrVkmv5AatxsDOPbYhkZ1/YTX/LzIzn22JZZn9cp0MMR4/26
        8Lzh4RB/iRaoXngI53Q9QJ/PQyO4NaYLdp4Jv1AtuexKsZWNe1H4XVZhEEDmxzrQaCCOPcVtIn9jj
        j83WPOmlpVvUPN8C0P8VrPiCesYQ/jMDHBisSVAsowwXXqj9r51Ud6ahalrrIo0Nk4ZTv4sItUKw2
        GPmqQo6g==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZX-00CQBV-B4; Wed, 26 Jan 2022 15:50:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] loop: don't freeze the queue in lo_release
Date:   Wed, 26 Jan 2022 16:50:38 +0100
Message-Id: <20220126155040.1190842-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
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
---
 drivers/block/loop.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4b0058a67c48e..d9a0e2205762f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1758,13 +1758,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
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

