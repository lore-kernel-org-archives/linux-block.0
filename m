Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53964C432BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3308661090
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhIAVCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhIAVCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 17:02:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68AC061575;
        Wed,  1 Sep 2021 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OEudjQURI1tjI6DN2XbbpoNvfS6WRIGCcJ/ZL9K/jW0=; b=TtU/t4kvFK6bEeZ18kuRWXiRWI
        f41EP2CiOJWyhfaFk8uWcVaUtPsaqnsuQzVb3IN7e5WDNe9pVLhxJwynLPDTE0tAh8k3TLIPmx0G5
        ftjwFVyVY34qZzZ7b10mfmkD39uZ8tnDHnbtOPQVu2ctwehoNZdjRUYMqECyp0adjYO71ccBfoscp
        2IIVJ3mZbiCRhaASuz6rn/4gUWv6NUJ9PmNmEwpZzdOlNw5yHv2/wM0H6gR1JLDgClh9pDWd5v8Qk
        KYjZyZan3WoR46X37fwEN41/2qTzhMQmCq6T5Ktj3vCSJDVTPGqdqbFTV3D/rIWSWlLM1/cvFWP0M
        PqbIKOFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLXLR-007LWN-Nr; Wed, 01 Sep 2021 21:00:29 +0000
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
Subject: [PATCH 10/10] mtd/ubi/block: add error handling support for add_disk()
Date:   Wed,  1 Sep 2021 14:00:28 -0700
Message-Id: <20210901210028.1750956-11-mcgrof@kernel.org>
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
 drivers/mtd/ubi/block.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index e003b4b44ffa..062e6c2c45f5 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -447,12 +447,18 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	list_add_tail(&dev->list, &ubiblock_devices);
 
 	/* Must be the last step: anyone can call file ops from now on */
-	add_disk(dev->gd);
+	ret = add_disk(dev->gd);
+	if (ret)
+		goto out_destroy_wq;
+
 	dev_info(disk_to_dev(dev->gd), "created from ubi%d:%d(%s)",
 		 dev->ubi_num, dev->vol_id, vi->name);
 	mutex_unlock(&devices_mutex);
 	return 0;
 
+out_destroy_wq:
+	list_del(&dev->list);
+	destroy_workqueue(dev->wq);
 out_remove_minor:
 	idr_remove(&ubiblock_minor_idr, gd->first_minor);
 out_cleanup_disk:
-- 
2.30.2

