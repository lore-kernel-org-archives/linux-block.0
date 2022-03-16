Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10FDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiCPIqv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiCPIqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790E64BD1
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R0FK3mzMobKYU6iSMO3tDE5ai7szZ2Nwhxp/sFGZ6ME=; b=yZIzEQphrqWnKV+XEBrXxmO4/n
        KfQDkark6gRAC3PTR3rhxXK7Ud4/Nv2iZAE2K47Z05YSADijQs/faKuNk/fcSDSvGOgvFcCBaJQS3
        AUaUXMYynJqp60QiJeJhK6G9ZBY5w9OFuigxQGtf9VTYaFFLscJ0BvUh3rDDcAUyMPLquKA/9XYYz
        gvr1XIESsWpySLr7dnxIrHkCY6pZv1uO3EWmkzTXqcKvqGTM7zUGkd2cG1x/0PkVyUkjKr1/aDop7
        9b6ehi/n/T+Ye887c9tgw7Bqq7k/wRknhkTNya/yD7Sg81GSbX496Y9DfWFElx7V2zDota4bm793a
        90Y0MB4A==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHh-00CCCT-MD; Wed, 16 Mar 2022 08:45:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] loop: don't freeze the queue in lo_release
Date:   Wed, 16 Mar 2022 09:45:15 +0100
Message-Id: <20220316084519.2850118-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
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
index e3361c6b22150..87d77464c2800 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1753,13 +1753,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 */
 		__loop_clr_fd(lo, true);
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

