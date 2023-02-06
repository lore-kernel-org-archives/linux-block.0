Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29450C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBFPCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBFPCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:02:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC93E388
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1mpOS7kK0Leu4UoX1ccOBGu/Ea+13sJFmxBkt8wK0Sk=; b=s0YBQDUClc24L0BeTRyiRPPPsn
        0MQdO56GLNq/hbjAHdGh3tP0LM1gXkw34fREY9Hagcyxi5wOkj7K1rIdDo6PHhJhgHKAm6tjnU8jt
        Il0MTOd1KSvdkcixdWjXZPZ22s3igOiLZSgi9Z4nxUOqU2jHXm4N8V60nL+T06nGhsItYuYJTozEm
        ShShrYhoimQB38B0v1M009xhBhzY8nfyh1u6eLbX7C0l47o79+FvZ75yJqIovu+hI3ZyitTtSjuKO
        4N0JawN/ZQGkT9LGCc766ujebrkjo7w+DpLIPBT9OkCpf1DfBrRz26QCu3sYXnn/FJEcZhs/ypXCB
        5Cz1cdxQ==;
Received: from [2001:4bb8:182:9f5b:1056:7df9:ac43:37d0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP30O-008qtO-AB; Mon, 06 Feb 2023 15:02:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-cgroup: fix freeing NULL blkg in blkg_create
Date:   Mon,  6 Feb 2023 16:02:01 +0100
Message-Id: <20230206150201.3438972-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

new_blkg can be NULL if the caller didn't pass in a pre-allocated blkg.
Don't try to free it in that case.

Fixes: 27b642b07a4a ("blk-cgroup: simplify blkg freeing from initialization failure paths")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8faeca6022bea0..c46778d1f3c27d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -383,7 +383,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 err_put_css:
 	css_put(&blkcg->css);
 err_free_blkg:
-	blkg_free(new_blkg);
+	if (new_blkg)
+		blkg_free(new_blkg);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.1

