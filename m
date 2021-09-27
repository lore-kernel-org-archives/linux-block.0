Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040506101A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhI0WF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhI0WFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462DC06121B;
        Mon, 27 Sep 2021 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IGHq/zn5r0bFrYNjymK6TXitnBNWw/sSmMius/3bC28=; b=moIXcrbmWusHJ1/TJ7/4Mkb6zG
        dNqT6LaggsxiFyDwUnruYVVTTUY6JlN8S/t9JqxBXoJhXTXuvrlb7Q7fXg6la2qmQ8c7MGkqRl5p6
        DcDGffiuQ26Sj49ctiyfwODudZ5QygKVr+HQhAoVyZYUh9E/z/sAr4Al9goZO73vkh2Rvnm+3t/j3
        WBZWRIvUOQnoRvcrlt4vJ26SYn9bMpFUGIZTALggRWC8KH+t/oFO9Bp5tHXDOkyx6Armyc0iMJ/w+
        p8na638LZpqVYKz1zq76yX5XGEKnm5lFFLhM7fc8bqdBEdilBt7wtM6py/V+H1JHoJlEcYCtk7L0Q
        RIaa5UDg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJM-EV; Mon, 27 Sep 2021 22:01:58 +0000
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
Subject: [PATCH v2 03/10] ps3disk: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:50 -0700
Message-Id: <20210927220157.1069658-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220157.1069658-1-mcgrof@kernel.org>
References: <20210927220157.1069658-1-mcgrof@kernel.org>
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

