Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791DC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CAC610CB
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhHRO6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhHRO6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:58:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6AC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u6sEDEKJeyn9agbo4RDBEcfLQX3zqAiVl3J9mU164jo=; b=cK5PHZyBu1zPCgh9RW9JlNUKY/
        9iH0Qc/tdTCdxS248AKd9K3H3ddDYHQJy4mQG/4PDNmYG4tBBejJAvkeFpWijr245NaUFuwVeNabU
        PPlc6Wgr3Taco6Y0PWMwP8EjpiMw1sKbY//n8vxPj1r/NpY9dw/LGNDdJ/Sji8tPyOmeUvo0tQo+F
        Y2tVQ3uj7mOOvenrkpwlKfoBKG/Z/R9ag+UGpNPQIXt5LK5VSf3ItbfMa/rmRl/UfpiSAajj40EhK
        rjdL8l0ISfBhP9p/GaDpm+lOq135fDlW6n77hEFodVJ+JzigUZS/p+34l+k59BWt/dJdcrOBpXQlB
        M+jngDmQ==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMzd-003x9R-W7; Wed, 18 Aug 2021 14:56:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 11/11] null_blk: add error handling support for add_disk()
Date:   Wed, 18 Aug 2021 16:45:42 +0200
Message-Id: <20210818144542.19305-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. The actual cleanup in case of error is
already handled by the caller of null_gendisk_register().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f128242d1170..187d779c8ca0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1717,8 +1717,7 @@ static int null_gendisk_register(struct nullb *nullb)
 			return ret;
 	}
 
-	add_disk(disk);
-	return 0;
+	return add_disk(disk);
 }
 
 static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
-- 
2.30.2

