Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E548C4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbiC3Fb4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiC3Fbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6A1C9B4C
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iKVovW4uIyzgVX9Pz8vm4rwMt/WHATrR/wo4lu+Ta5E=; b=QUcf4CQO2tUhDnEpTv3fxyZ3Kx
        SYkHXeTAbtJWLUS4gX4ICbJ/FkF7gJ1T9ShvXN93/i9nO20AUsjyM7AEb5EikZrKPL0reNFs3JsSA
        qzaptlJgpFCkbuJMpgbfsvyKgnT0L/RwE84aBdkl7p1ZuRUPjiWVlIKjqiSwrIKUEvymXeR8TlBKQ
        Ev2lvkh5M8Jn5SRH8rDsr1gtSj46fUYxBdRZ13xVUFac6hdvkx4AHStFYjiIy5QjuqQT73/IECWUM
        PTUG8G8Wrf/N4dZFTplM4pfMojEOUjt8Eb1PoHpGTJkWzcShSie8s0UwVPKrDBMMK+Gu+c4vCNNXV
        /Fw0DNsQ==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQu4-00ELOV-Ic; Wed, 30 Mar 2022 05:29:57 +0000
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
Subject: [PATCH 09/15] loop: don't freeze the queue in lo_release
Date:   Wed, 30 Mar 2022 07:29:11 +0200
Message-Id: <20220330052917.2566582-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
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

