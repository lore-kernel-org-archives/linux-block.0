Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C71C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0286060F35
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbhHYQhE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242068AbhHYQhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:37:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25371C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ocFxBn/XAj3qFajqqWfv+beTwyzY2/I4pXg8QJ/kqm4=; b=IPwVsg8wwA3RiMz5RmY1NB9Sde
        o+NQKD0LUwyAXUAZDIxAXfj4rrUAIfmSIUawjHKinkKVBY6bb0ervPQASXzxEHnF6mgD2X3xdM3W5
        y7MVgnJ3jheIcbc/eq9slS6lM/++NzmHPaxIu7KH2MMSUecOGgKWeDC+udURA5O/3PgKV7Nh2FSJi
        PpLETllUf9Y/X7xFIqQyN+zA8JYs6QEe6BfxnuZ7X5uPtFsueuT/YaVsrxFVGURqa8yLRP+LjL4Nt
        gu4JzMVR/n/m/GjLSYgFmOmBlGi8Xh+oSCvF3dbHVOVZGggsG+mmrxfHhtyBxlwbKT086q2gkQ2Yg
        nBezQS8Q==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvqm-00CThz-B9; Wed, 25 Aug 2021 16:34:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/6] nbd: add missing locking to the nbd_dev_add error path
Date:   Wed, 25 Aug 2021 18:31:03 +0200
Message-Id: <20210825163108.50713-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

idr_remove needs external synchronization.

Fixes: 6e4df4c64881 ("nbd: reduce the nbd_index_mutex scope")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c5e2b4cd697f..2c63372a31dd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1774,7 +1774,9 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	return nbd;
 
 out_free_idr:
+	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, index);
+	mutex_unlock(&nbd_index_mutex);
 out_free_tags:
 	blk_mq_free_tag_set(&nbd->tag_set);
 out_free_nbd:
-- 
2.30.2

