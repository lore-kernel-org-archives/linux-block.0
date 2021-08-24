Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21116C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0539E61220
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhHXOq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhHXOq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:46:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6DC061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OdwpcRLtl1ahLWsKatnT9Q3o0yvignVSu46y3PBEPtk=; b=mjS6zJSbYULaN5C5WkwTE72e4+
        P4EWekOxpByL/aQsV6OJmeiIGEECHN9jDJDX5uyuunxTNS91g8O3hheqjnbxz9WUvUYHbtzmkBlhP
        9Ub4fQSHDJb3NZvndxVZk9Xe3OsmELYpHwh9gvfq392M8IafgKZRdPx9v+3DCERTrpK9ljVmjMcWO
        7fFFzLjQV5jH+AwNJMjyb3Jo8RO4w5R2mTnE6zs8hZLJd6nUn/UfIg1gJJy2AS19wFuWiYw6CZ1g0
        TdW4gVX2/RBmKZ3/qtBm1gNDCc4mT8UfyTwG+DE01bFjlTetO22e9w6l9NN0LTKle25OyydakLev4
        BySHF+fQ==;
Received: from [2001:4bb8:193:fd10:b8ba:7bad:652e:75fa] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIXdw-00BBkP-43; Tue, 24 Aug 2021 14:44:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Bruno Goncalves <bgoncalv@redhat.com>
Subject: [PATCH] block: refine the disk_live check in del_gendisk
Date:   Tue, 24 Aug 2021 16:43:10 +0200
Message-Id: <20210824144310.1487816-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hidden gendisks will never be marked live.

Fixes: 40b3a52ffc5b ("block: add a sanity check for a live disk in del_gendisk")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index a925f773145f..6a5c85aa2e31 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -591,7 +591,7 @@ void del_gendisk(struct gendisk *disk)
 {
 	might_sleep();
 
-	if (WARN_ON_ONCE(!disk_live(disk)))
+	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
 		return;
 
 	blk_integrity_del(disk);
-- 
2.30.2

