Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C6C43216
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144D360F42
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbhIAVCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbhIAVCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 17:02:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D2C0613D9;
        Wed,  1 Sep 2021 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6NZfHmNoX5N/dbslA9tEZ3wm71g//v2MOeHuD/3FoC0=; b=JbKHmZMaqVAxm6cl00sFMC5SCj
        aCjZcL7uSMwtO8GUwPvTU6v18DXdVUTNyRQ/ZUCRYcD4XxYgslxZbtB82QNykdkKIANHunCzsHrAB
        iDpLzyPWFcXhf2ofBZaCZB7Q0CcrfIZBKysT24q8obus8VZk6WrH4u/vSm/R/zDVnWaKgn3lIBU4l
        9PV9qK4XzK06i2ZyBnQeBNKGWp5D7NPqSHeyQm7V92qj5hmJ3/RWw4X++wxFObgSq1yjOyIfITWcx
        S238uMNcCFzbSZ1IrrJVUYLA4WMCA1RaVN1Jbbgk/YggT3Fk0XMeFUC9NoD3ugPbyCRKXxNI8wVz1
        C30MKfvQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLXLR-007LW9-E5; Wed, 01 Sep 2021 21:00:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 04/10] ps3vram: add error handling support for add_disk()
Date:   Wed,  1 Sep 2021 14:00:22 -0700
Message-Id: <20210901210028.1750956-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901210028.1750956-1-mcgrof@kernel.org>
References: <20210901210028.1750956-1-mcgrof@kernel.org>
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
 drivers/block/ps3vram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index c7b19e128b03..af2a0d09c598 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -755,9 +755,14 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	dev_info(&dev->core, "%s: Using %llu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->core, gendisk, NULL);
+	error = device_add_disk(&dev->core, gendisk, NULL);
+	if (error)
+		goto out_cleanup_disk;
+
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(gendisk);
 out_cache_cleanup:
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
-- 
2.30.2

