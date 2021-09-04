Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA87C433FE
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D08610A2
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350879AbhIDBgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350746AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4FFC061760;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YC09ub7H5zBS0+xaUnAKeTnZGFxVdKsA0MqfDrrsdEA=; b=rhFFrfYby5J7n7BidZvpg4kOV9
        7tcB2oy4PpWb5FT2YeOnOdNzEt4XJBZajbEoZEE1UN6eIepqMg+naEklTaaXumUBm+ReDaNqnqn3b
        oNWn+c/TpilNuAvMGx/+azVhm4/oK4Jq42LvWCdVvhNspufTpYab1Ahkj/O+wI/jxssca5qNqP8x4
        18b7D69OQ58U2ITa+V5s0TikbHgr8CLLICvHpSRSJi7E1f45jqH0he5cNZJ20N/YkuAeZd8ekWxqC
        HnZ8aT3FD32rXXK/bcYP4LYJmNEssBCn3+ScHBe50FpVHb5KmpASZSuwvPaSxD2sC7w6p+kiVgxO9
        7v5fTNKg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbA-Dk; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 05/14] floppy: add error handling support for add_disk()
Date:   Fri,  3 Sep 2021 18:35:27 -0700
Message-Id: <20210904013536.3181237-6-mcgrof@kernel.org>
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
 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3592a6277d0b..0434f28742e7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4696,8 +4696,10 @@ static int __init do_floppy_init(void)
 
 		registered[drive] = true;
 
-		device_add_disk(&floppy_device[drive].dev, disks[drive][0],
-				NULL);
+		err = device_add_disk(&floppy_device[drive].dev,
+				      disks[drive][0], NULL);
+		if (err)
+			goto out_remove_drives;
 	}
 
 	return 0;
-- 
2.30.2

