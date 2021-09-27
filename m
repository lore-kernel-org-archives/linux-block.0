Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8A360EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbhI0WFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhI0WFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:15 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED19C061212;
        Mon, 27 Sep 2021 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o2jFAXs2S20ugcqcgWqTKDs1dtJRAdxtjSIxmQce0yE=; b=iQqCgxcPEfR/tT7BcOih0IqCUi
        rZdLXA0BoJeyuJkOjXPbJPzPcoH/n8om7Tlhp3EbM7OSRMoMphiBNgLlwwBwNWALgBi+SXNBFIrcV
        PztSxSBtZFEkZMGMUJH/VyeWYSs+3AukRv4/nVnwwqJTKR9J/mqF0WS2/8EZCDMu7s51CVp3tcs17
        A6lsDP6CF3ZUUakYShG24S7IGolFmr38eHbCdQ5/dAImALfBYSOZCN9ZpgkGOryTnBnDnr71vzG6N
        jXTHg5V26wp0VGHY1Vmzt2e3YBLG7cM1+PRa62Z67gQ1DmT6aJp1MlesGumQUbskBH1IsCi77cm5t
        RmUC9XbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJX-Ie; Mon, 27 Sep 2021 22:01:58 +0000
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
Subject: [PATCH v2 06/10] block/rsxx: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:53 -0700
Message-Id: <20210927220157.1069658-7-mcgrof@kernel.org>
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
 drivers/block/rsxx/core.c |  4 +++-
 drivers/block/rsxx/dev.c  | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 83636714b8d7..8d9d69f5dfbc 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -935,7 +935,9 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 			card->size8 = 0;
 	}
 
-	rsxx_attach_dev(card);
+	st = rsxx_attach_dev(card);
+	if (st)
+		goto failed_create_dev;
 
 	/************* Setup Debugfs *************/
 	rsxx_debugfs_dev_new(card);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 1cc40b0ea761..b2d3ac3efce2 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -192,6 +192,8 @@ static bool rsxx_discard_supported(struct rsxx_cardinfo *card)
 
 int rsxx_attach_dev(struct rsxx_cardinfo *card)
 {
+	int err = 0;
+
 	mutex_lock(&card->dev_lock);
 
 	/* The block device requires the stripe size from the config. */
@@ -200,13 +202,17 @@ int rsxx_attach_dev(struct rsxx_cardinfo *card)
 			set_capacity(card->gendisk, card->size8 >> 9);
 		else
 			set_capacity(card->gendisk, 0);
-		device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
-		card->bdev_attached = 1;
+		err = device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
+		if (err == 0)
+			card->bdev_attached = 1;
 	}
 
 	mutex_unlock(&card->dev_lock);
 
-	return 0;
+	if (err)
+		blk_cleanup_disk(card->gendisk);
+
+	return err;
 }
 
 void rsxx_detach_dev(struct rsxx_cardinfo *card)
-- 
2.30.2

