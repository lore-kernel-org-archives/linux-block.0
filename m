Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E073C433FE
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A80C611C1
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhJOXzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 19:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbhJOXzI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 19:55:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30161C061762;
        Fri, 15 Oct 2021 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7R5PYVFPXskQk20vzfFqzumtxD4zBhl8b3RLHCGuP34=; b=bA1zIwdhWBpvlfjPHf65YiWw1w
        wNKSsZycfKU6wTo+TriKrwHhsylyC8eMhzSF0i7XqaBSV9dMtcoJk5uBzoLZCuWHqAJPs4dhdPV+q
        S0GVi7stXEDsLti3GghX0YK306V30lxJcY2QeyKFi5sry6O3IOwJdxPd1N4J0z6KXmrD0rOVcpCn3
        yvEnSxF2UYqoZdvec8gr0V7GX1sNtN9FOWzqjb1O5OqYYjndYWTsx0gJJlK8uyVSJ12gIWFem2lsk
        h2GuzJdczHuexPRYg/FSSqNpsJTDLZbJXCRvYTM13PUle1YJcEgXxka426Nkl54BSAznT4EB7w/RK
        xoviz0/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbWzt-009C3D-99; Fri, 15 Oct 2021 23:52:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/13] z2ram: add error handling support for add_disk()
Date:   Fri, 15 Oct 2021 16:52:15 -0700
Message-Id: <20211015235219.2191207-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. Only the disk is cleaned up inside
z2ram_register_disk() as the caller deals with the rest.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/z2ram.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 4eef218108c6..ccc52c935faf 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -318,6 +318,7 @@ static const struct blk_mq_ops z2_mq_ops = {
 static int z2ram_register_disk(int minor)
 {
 	struct gendisk *disk;
+	int err;
 
 	disk = blk_mq_alloc_disk(&tag_set, NULL);
 	if (IS_ERR(disk))
@@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
 		sprintf(disk->disk_name, "z2ram");
 
 	z2ram_gendisk[minor] = disk;
-	add_disk(disk);
-	return 0;
+	err = add_disk(disk);
+	if (err)
+		blk_cleanup_disk(disk);
+	return err;
 }
 
 static int __init z2_init(void)
-- 
2.30.2

