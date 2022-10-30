Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FFC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJ3KHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJ3KHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D55DBA0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1msJsx8ZMQjw177ZA773RTU7Mxll44+5XhXEtiVW5Qg=; b=H1P/miFyRadNfHvNsr7RHDIL/z
        +Gh+pAT6APgtLRREMPIQHlfOnXWfo6iMVMmtuLQ27Yfr/+JjJzluKktA0+ZpnTmfIks2BcjJ0XEZZ
        Q+gYPMDkXUTPxDE3JjFD9PHB8rCOMUQ2lia3WGinSB5CbxfuTeJ9XioSeYPBoO4EawXB1QXGPaWNQ
        5IOzPOIU471do7DVIqOuNPQ/9gUKi3qJg47VXdEdxuWLoKh6gsXDukAJvV344BCMxmD7HvNwFIxHQ
        OfdLus31mdipyKd1uD9BmzE/kMN8J1e2tQu+L81mBjNE+DuiTiWlPvbzSb4ZcWkd0eyzOu4yMdZ9g
        nyLUT55w==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5E9-00F8Qb-AY; Sun, 30 Oct 2022 10:07:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: simplify the check for the current elevator in elv_iosched_show
Date:   Sun, 30 Oct 2022 11:07:12 +0100
Message-Id: <20221030100714.876891-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just compare the pointers instead of using the string based
elevator_match.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4fc0d2f539295..77c16c5ef04ff 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -786,7 +786,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(e, &elv_list, list) {
-		if (cur && elevator_match(cur, e->elevator_name, 0)) {
+		if (e == cur) {
 			len += sprintf(name+len, "[%s] ", cur->elevator_name);
 			continue;
 		}
-- 
2.30.2

