Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A8DEB64DA
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjGGJnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGGJm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:42:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6F2107
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5d6vyJDauj9RC15hQqGhsr8qw63XZAz6bliXZfCu1yc=; b=43bQet3K0BizfCUnEyounCCnuX
        Zep6UwFplVOU0wRkGMxPoxmAg3XqhHFHy+E32OFgeBvVSjxNROmD1oTeZ6xM4VhFhr8wdl5Waw1Bj
        /UavSSQy977EtSjsIlnx1uzVs6HmazpEpLfGRorJJN/E1RahDLAlGN9XIkiwToc2qlEk0bfQ52fxB
        I+UYdFqvRdjIp7xBIYgp/bhYRvR9yIe/VP3PCdUeKD/XPaoCFkFW+GhVDCFxklbt6xJoFeHh1bgSw
        xOPedkvukEfzeYgz10fbFGIVC8BnfkNtRkoKu1fc41qWIRYivMbpF/WDQrlzvRTPnmS9sn6RCMfw3
        7Vemx0Rg==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHhzK-0049JP-37;
        Fri, 07 Jul 2023 09:42:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: cleanup queue_wc_store
Date:   Fri,  7 Jul 2023 11:42:38 +0200
Message-Id: <20230707094239.107968-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094239.107968-1-hch@lst.de>
References: <20230707094239.107968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the local queue_wc_store variable and handling setting and
clearing the QUEUE_FLAG_WC flag diretly instead the if / else if.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index afc797fb0dfc48..0cde6598fb2f4d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -449,21 +449,13 @@ static ssize_t queue_wc_show(struct request_queue *q, char *page)
 static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 			      size_t count)
 {
-	int set = -1;
-
 	if (!strncmp(page, "write back", 10))
-		set = 1;
+		blk_queue_flag_set(QUEUE_FLAG_WC, q);
 	else if (!strncmp(page, "write through", 13) ||
 		 !strncmp(page, "none", 4))
-		set = 0;
-
-	if (set == -1)
-		return -EINVAL;
-
-	if (set)
-		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
+	else
+		return -EINVAL;
 
 	return count;
 }
-- 
2.39.2

