Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9CDC43462
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1B861422
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhELRc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhELQyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 12:54:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEEC06134E
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LnOZdM199sgRBQAQQNQHEuJjslE5h07AOS56jCCV/lM=; b=SDxI592YIDOL7euX1Bm7qsFAOE
        ai3jARlgeJAJdpk2K075d/Sbcro4BvtApwQ6/gKLFgh/y+fMzNSokaW3W4Y8A04sJTozy7Umqn92I
        oq9RRSONwQBqgWZwlxojRevZfDLdlIyWmFuBo8GEN8D3qFX90B+9iXtSI76s16lsRXhHbKGTirMkG
        yR5c/RvSwh+F3OWHWR/3CKGXLNM1XH0gX7c9hpALt0PZ67o87KPwiYPwsrl/9nqRrYIkwNaBRUYUc
        w1SG2RrZu55Hw1XgWtqeCE0HNGFE7Pr7fm4Oz+RDZASCqHBN2xMuIG1mx1O+JTXjvLwRXJEBgwXXp
        pe8CIH9Q==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgs4X-00AcHK-BM; Wed, 12 May 2021 16:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPART
Date:   Wed, 12 May 2021 18:50:50 +0200
Message-Id: <20210512165050.628550-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512165050.628550-1-hch@lst.de>
References: <20210512165050.628550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gulam Mohamed <gulam.mohamed@oracle.com>

When BLKRRPART is called concurrently with del_gendisk, the partitions
rescan can create a stale partition that will never be be cleaned up.

Fix this by checking the the disk is up before rescanning partitions
while under bd_mutex.

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index de1a760da62d..577f112c3818 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1244,6 +1244,9 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
+	if (!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
+
 rescan:
 	if (bdev->bd_part_count)
 		return -EBUSY;
-- 
2.30.2

