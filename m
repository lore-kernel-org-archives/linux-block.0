Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3428C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B40060EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhI0WHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhI0WGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:34 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE14C051744;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5/KxCfQiey/MtVRClHtspmiQ1YyvZXCUQ0jBAHLWIRA=; b=csNVgJevARakf3YxKu9xt1PTJ5
        vEXEJVMLaZ2c4SpFQUknh9mXyPk2sLqdl1je5OvqpX5EdtA/HddHtqokNvgVKZnq1YS1VjU3jJ/0n
        MECfAsrW0LKaMvlVtza5fPWGnlqSDvo/GB+VJHpGSxJlYRKw86LeEOEewxhiDBNTuvhn6hwNmkLw1
        C1qZnVzFt6rzSK3YY9UTwfiMv5Squn2W+ggVZOlfN2xTBxwEc/k1LAt/ZTMc+jCIkiWqJTlv0JZGD
        odgmWSql24btfYZO70GIHxM511nTk2cMog9ZyNylt7/n5vxO1xQE0R2vKIGvo9tgDPjhhnmExT7jX
        Iuir81Fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VIE-KH; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 06/14] amiflop: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:02:54 -0700
Message-Id: <20210927220302.1073499-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
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

