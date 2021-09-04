Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D1C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F62610A2
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350871AbhIDBgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332EC061575;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5/KxCfQiey/MtVRClHtspmiQ1YyvZXCUQ0jBAHLWIRA=; b=nNxjmuRKSBgbrgOslmRl1e8Yys
        tpZbl2fGmNOY3pzs9qNfk35JkwU6ERi7wtkNtqT+FJSU7L5Bh1oFeSiCfz35WtG2r0o+Zej8c49iV
        feb4fJXtsA8HMMFyneR7V+vWKhfI9Er2bBjCb8Ajyx8I+Bo9C4+pSLEED31tc9NBflswiIg/S/MIE
        vVhIK3sFvR1LLF1V1epFyU7bW8yOCsRgXQSLLwjZOAfu/XWqea5LgTlYvNe0c7zmWvd+wjpMCaXqC
        C6Gyx33WgYqd1GUplEd+yIk9aGQ0BDd1ghgyS+KkGTL7S8Hg+df2O5cTfO+RrcF5Ir0erHw9VMfiH
        F417lsNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbC-Fx; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 06/14] amiflop: add error handling support for add_disk()
Date:   Fri,  3 Sep 2021 18:35:28 -0700
Message-Id: <20210904013536.3181237-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. The caller for fd_alloc_disk() deals with
the rest of the cleanup like the tag.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/amiflop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 8b1714021498..7da6a7532cde 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1780,6 +1780,7 @@ static const struct blk_mq_ops amiflop_mq_ops = {
 static int fd_alloc_disk(int drive, int system)
 {
 	struct gendisk *disk;
+	int err;
 
 	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL);
 	if (IS_ERR(disk))
@@ -1798,8 +1799,10 @@ static int fd_alloc_disk(int drive, int system)
 	set_capacity(disk, 880 * 2);
 
 	unit[drive].gendisk[system] = disk;
-	add_disk(disk);
-	return 0;
+	err = add_disk(disk);
+	if (err)
+		blk_cleanup_disk(disk);
+	return err;
 }
 
 static int fd_alloc_drive(int drive)
-- 
2.30.2

