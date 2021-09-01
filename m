Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A5C4320E
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EC2610A2
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhIAVCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhIAVCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 17:02:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4BC061760;
        Wed,  1 Sep 2021 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IGHq/zn5r0bFrYNjymK6TXitnBNWw/sSmMius/3bC28=; b=QJ5f7z+OE61XbaAFEq2U1l3Fy5
        isECM2X2glqEsQygexTtwsU+FK7Kt84fO215nlhGmSeWEI8dkR2nsYBSiGZK08xLI2twc3NKJqT2G
        tlfuVts2g2QyCw4NnqeKp/wOFcfV+Sz4Bzi6gXdFivWnL6aMy8353RHitW8wCEkycmFh75epy6Ctt
        LfGR8Kp9UwI6AWO1+faElk5/zNZd/vZs+DO1PKNj7uUoUZxeHW6hF6BRT2gQ+UJ6qtXOslVC5o42W
        bmXviV3Vo/btQqMLp60lRhz4FjceTB0NZAeSA90keRnPgHRwEBix15hO9W5kToBJRw7Ig9IqkrXZQ
        mxVoHhMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLXLR-007LW7-Bq; Wed, 01 Sep 2021 21:00:29 +0000
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
Subject: [PATCH 03/10] ps3disk: add error handling support for add_disk()
Date:   Wed,  1 Sep 2021 14:00:21 -0700
Message-Id: <20210901210028.1750956-4-mcgrof@kernel.org>
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
 drivers/block/ps3disk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 8d51efbe045d..3054adf77460 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -467,9 +467,13 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->sbd.core, gendisk, NULL);
-	return 0;
+	error = device_add_disk(&dev->sbd.core, gendisk, NULL);
+	if (error)
+		goto fail_cleanup_disk;
 
+	return 0;
+fail_cleanup_disk:
+	blk_cleanup_disk(gendisk);
 fail_free_tag_set:
 	blk_mq_free_tag_set(&priv->tag_set);
 fail_teardown:
-- 
2.30.2

