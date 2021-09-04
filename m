Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5522EC4332F
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4157261051
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350908AbhIDBgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350862AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7ABC06179A;
        Fri,  3 Sep 2021 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Fh2lmOhLx61pNto8wOBpgjdx63cIFvAcZhSgHtAR7M=; b=WUi0DvwaN8T0Mb6sSB6PaZUIGw
        vWuDGJuqwxCs3Kiku9KDVW1bKllnY5huKdYl6qSNSE+dR6X8djndvvLupIPKhMscN41u4vcE+mLMJ
        RHOqKLhOIkNG07siin3mCNqe/noEDkSqBK7oulAzSLMS2yWA66Jx0USyv0FjS9JXQlZNm4eA56JfT
        uHUQdZj1idszhSKUchlgYydVRC2XJoOQgRYBS+T3GeFq2g57IPFxwq1RZenv69xykp+oJZMuThmIW
        ty0Q4gfqg2u4TO1O8/mzCzPKzINiD2RJA+f5JLZF1wJp5lz1/OAokTOA5y/4YQLbMKAzBF1YcLwNt
        Yepalabw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLb2-56; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/14] block/swim3: add error handling support for add_disk()
Date:   Fri,  3 Sep 2021 18:35:23 -0700
Message-Id: <20210904013536.3181237-2-mcgrof@kernel.org>
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
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 965af0a3e95b..f7e3482e846b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1229,7 +1229,9 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", floppy_count);
 	set_capacity(disk, 2880);
-	add_disk(disk);
+	rc = add_disk(disk);
+	if (rc)
+		goto out_cleanup_disk;
 
 	disks[floppy_count++] = disk;
 	return 0;
-- 
2.30.2

