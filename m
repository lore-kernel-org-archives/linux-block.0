Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED1C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7175613B9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFPHST (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFPHST (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 03:18:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E7C061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zm6FtkoeVrO8gN137xjP28ebIq+PPfLbIMErm1MwNks=; b=mJ89QXbQQQSSBNv2u8mJYorJtP
        8wmb92eZQFHhPPROBGvN8kyOteLuLpem70xUgd3ge7pJa6+XR/AaRkWO7NGT86RVywaaGADIrbbU8
        elkbkb8Agtx3tkFQP8zU6pC0sDXrgFy5JR6CMoDl9tjv4oiSsuYS8tsDdRwwRblJwx4H4OV9HoRkL
        gIYpSxB1tY/bUPVNJ1vkIhnsRjXikAAiAym7I9jFzh5/rFOHQoLyEB6eoxSsZJ2bdIghaCcSlR1XK
        m4ZB3GEwuFaUsSGW1bEOp22H4L9o8xBeYK9AjTUCZLnR9jTGej/q5gRVIq4OyCme+oOAzazPiS97k
        UrT0qdaw==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltPmN-007jjY-6A; Wed, 16 Jun 2021 07:16:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, bgoncalv@redhat.com,
        m.szyprowski@samsung.com
Subject: [PATCH 2/2] loop: fix order of cleaning up the queue and freeing the tagset
Date:   Wed, 16 Jun 2021 09:15:47 +0200
Message-Id: <20210616071547.1156283-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616071547.1156283-1-hch@lst.de>
References: <20210616071547.1156283-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We must release the queue before freeing the tagset.

Fixes: 1c99502fae35 ("loop: use blk_mq_alloc_disk and blk_cleanup_disk")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a48b3f9a15c..e0c4de392eab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2172,8 +2172,8 @@ static int loop_add(struct loop_device **l, int i)
 static void loop_remove(struct loop_device *lo)
 {
 	del_gendisk(lo->lo_disk);
-	blk_mq_free_tag_set(&lo->tag_set);
 	blk_cleanup_disk(lo->lo_disk);
+	blk_mq_free_tag_set(&lo->tag_set);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
-- 
2.30.2

