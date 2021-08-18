Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5DC4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8007610E5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhHROth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbhHROte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:49:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50495C061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dd55p9fRZ62wbbImD+QX9EdhgJeWc+nuOzXi0JKVyCA=; b=l1zryiyRtXQPptsS1l9A+4Sqtn
        nHMccNf1gP8hz7L/4grDR/MKMkhM/kfGq3BqJW54rM70ipoVvrBe3opca6BApu/FT3wWRoxOBXlOb
        uBZtCXZnWVj2yirVmWcQ7rUDDfZxHETVddp4bPqtoIEMjW1fLk1FR2rLP1EZjzQ3vHCC7bDaGy208
        xC9jf6QqxiMtY1FWckUOpsakdguw927pb42aCqS61quTjS+bLD7DpuMQTcxRMiIHOBU4k2VwtUfCh
        NKobUpcO6yKRFprCPkT7LEdHRlNyKXVwiqPMcPWtEB6JJjcbsIvdS6XsPIZGMUqTXHITQURa/4ojd
        2kbEIpRQ==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMq4-003wVQ-5w; Wed, 18 Aug 2021 14:46:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 01/11] block: add a sanity check for a live disk in del_gendisk
Date:   Wed, 18 Aug 2021 16:45:32 +0200
Message-Id: <20210818144542.19305-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a sanity check to del_gendisk to do nothing when the disk wasn't
successfully added.  This papers over the complete lack of add_disk
error handling, which is about to get fixed gradually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 02cd9ec93e52..935f74c652f1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -579,7 +579,7 @@ void del_gendisk(struct gendisk *disk)
 {
 	might_sleep();
 
-	if (WARN_ON_ONCE(!disk->queue))
+	if (WARN_ON_ONCE(!disk_live(disk)))
 		return;
 
 	blk_integrity_del(disk);
-- 
2.30.2

