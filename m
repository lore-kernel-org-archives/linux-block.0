Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DAAC433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236F76103B
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhKCQnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhKCQnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 12:43:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6931CC061714;
        Wed,  3 Nov 2021 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0qrxHNDIFk+edOnwg1RDygcWfmb5ExZeJL85X5Z4aFk=; b=iJuXfpma4uCw5qA5MICtL7C9VR
        k9BfUV9v5hZfLEKhHTn0Zacyur9jdV8B5eZKtenl1NtgOYzm4Ree6GHKUXOcD+BSHWLnCD3opeJEy
        CXtXH4Vmjn/qzuJDaT9wFAGpIH8HcwWb5iS9+gbb6UgufuRB0wOiZcUf3qbs7kjPP7jAOD6zrXLAz
        hBt2/S3hnF6/9G+8TVbdpLEGHKlUDWs13ctDYGRcipkPgNL4Vm2SS6frxytGDhsH5KZsHM2Zg/DXu
        BbksajzzYhxMukVzyyx+KhUBT8/MuQWGhnqutaV9GPS3s+FUE/SXRHXALQERR+xO+7LF+cYXL2wdZ
        UmckpeTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miJJQ-005oHb-2i; Wed, 03 Nov 2021 16:40:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hare@suse.de, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] block: fix device_add_disk() kobject_create_and_add() error handling
Date:   Wed,  3 Nov 2021 09:40:23 -0700
Message-Id: <20211103164023.1384821-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 83cbce957446 ("block: add error handling for device_add_disk /
add_disk") added error handling to device_add_disk(), however the goto
label for the kobject_create_and_add() failure did not set the return
value correctly, and so we can end up in a situation where
kobject_create_and_add() fails but we report success.

Fixes: 83cbce957446 ("block: add error handling for device_add_disk / add_disk")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index be4775c13760..b0b484116c3a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -478,8 +478,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	if (!disk->part0->bd_holder_dir)
 		goto out_del_integrity;
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
-	if (!disk->slave_dir)
+	if (!disk->slave_dir) {
+		ret = -ENOMEM;
 		goto out_put_holder_dir;
+	}
 
 	ret = bd_register_pending_holders(disk);
 	if (ret < 0)
-- 
2.33.0

