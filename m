Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D784C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF166101D
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWPEX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:04:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC72C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZYTWT1x1aj8+1YwAzNumqNw6wJ39vs/Vr6slb7e5rnE=; b=TNkhv4My3FGtmxZcN+TPpbczq9
        cuSOtwijBcn2yL0d/x0Dcvnt06wMjwzf9PoZ6XDt6RC+EvsOCGfpXc7KsxOC34OwZpgfGlQSetOFL
        3qbJe4OWShf+HUWLEcMg8O2csupVoaM3u908zqREnaBX8+uDBOzROeygBl9tQJWHHA3IDjhlEasLR
        6geQtisRwyk7i+OzSA18li1EuN49sx1NuT8jKxs2hwnCYEMydd/8MxB24hHesCw+QmG/8o0Z3jQeh
        TrcJ3/ck0V2NP1qvhnoZTxkoVNYJt3GLtmw6JJDMgOUhK6eMPEyWQUUQQkxsxqQ8Qk7aqX49Bss7N
        z9Sy7B1A==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4Nk-00FXy3-Fy; Wed, 23 Jun 2021 15:01:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/9] loop: don't call loop_lookup before adding a loop device
Date:   Wed, 23 Jun 2021 16:59:03 +0200
Message-Id: <20210623145908.92973-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_add returns the right error if the slot wasn't available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8392722d0e12..b1e7e420563b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2219,14 +2219,12 @@ static int loop_lookup(struct loop_device **l, int i)
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
-	struct loop_device *lo;
 
 	if (max_loop && idx >= max_loop)
 		return;
 
 	mutex_lock(&loop_ctl_mutex);
-	if (loop_lookup(&lo, idx) < 0)
-		loop_add(idx);
+	loop_add(idx);
 	mutex_unlock(&loop_ctl_mutex);
 }
 
@@ -2243,11 +2241,6 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
-		ret = loop_lookup(&lo, parm);
-		if (ret >= 0) {
-			ret = -EEXIST;
-			break;
-		}
 		ret = loop_add(parm);
 		break;
 	case LOOP_CTL_REMOVE:
-- 
2.30.2

