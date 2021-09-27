Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C928C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C7461058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbhI0WEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhI0WDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344DC06125B;
        Mon, 27 Sep 2021 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tG8cam/XDT2SqSq+KO9LsRJ8EhJRU6E2udZdmJan7KU=; b=g0Vd2Ijjj9zsDyU8t7j0CK91EA
        v7BCEM2ruytnp2jd68hUDBrkHzYUY3FLJiWdR8xhFZZkaeqY1HOdu7egCLMLB7p7kYyXv6p85Acog
        7TNHe3KAQFiZiZ/0K/FVkZjLTY+2ZBsi+T6lrceiHDC3iHRvt80jQCCW3AW7YsnLJn03oTON1aVWG
        kzhuOxkyQpLIbiBm5+sWhYj48Ft+5UhMv/bo7DCYeo1d2euLclfrI/WZ5lavETGaWqL0ECP5vtyM6
        4iRrJu/tEJJWS6rz6GSqxbhdRiVCjk+ZlqN4Yw62pdnYMfZOJ74JZjbO9M8Nm9fxKR7EOrTf6brzq
        OQ9rjZGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPS-UF; Mon, 27 Sep 2021 22:01:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 07/15] n64cart: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:02 -0700
Message-Id: <20210927220110.1066271-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
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
 drivers/block/n64cart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 26798da661bd..35aa5d38f57d 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -117,6 +117,7 @@ static const struct block_device_operations n64cart_fops = {
 static int __init n64cart_probe(struct platform_device *pdev)
 {
 	struct gendisk *disk;
+	int err = -ENOMEM;
 
 	if (!start || !size) {
 		pr_err("start or size not specified\n");
@@ -134,7 +135,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 
 	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
-		return -ENOMEM;
+		goto out;
 
 	disk->first_minor = 0;
 	disk->flags = GENHD_FL_NO_PART_SCAN;
@@ -149,11 +150,18 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	blk_queue_physical_block_size(disk->queue, 4096);
 	blk_queue_logical_block_size(disk->queue, 4096);
 
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	pr_info("n64cart: %u kb disk\n", size / 1024);
 
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
+out:
+	return err;
 }
 
 static struct platform_driver n64cart_driver = {
-- 
2.30.2

