Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA9CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 06:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356243AbiCYGlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358474AbiCYGlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:41:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02470931
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iKVovW4uIyzgVX9Pz8vm4rwMt/WHATrR/wo4lu+Ta5E=; b=B2o/5MLn4w3Hv3cXwjyzf4c+kC
        1adgd65hQk2eEnLCFe64QfiYIorBPy66W0Iv/hJ1KWtOsqsfk2f6Hg82MltxRVcAjIHDsW/TyANuK
        H77KvRRLDfrF+lPd5YLAAoWiq1pDRvu6jwHKjcSGsVpkzoU2tUWO3UlTfTtIbUJRpb3vP6m2lnxlY
        Vg1qJex0w+LWunOkoes/L9HTrNvOnVkJ7RoCKIJj1iiPUB+3t2PddLSGCcZItrAJ61x4mO4Jr4yMK
        WSxTfwMyjvItgiq0FvY4ZB/p2GXbVgUcZnTnSAnjJbn+piDIPbSP2ac75nomzP60un9AVmhWq+E/F
        T80E1pHw==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdcE-001HOh-PY; Fri, 25 Mar 2022 06:40:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 09/14] loop: don't freeze the queue in lo_release
Date:   Fri, 25 Mar 2022 07:39:24 +0100
Message-Id: <20220325063929.1773899-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
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
index 25a71fd7b59da..c57acbcf9be6a 100644
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

