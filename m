Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0C60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhI0WEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhI0WDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79010C06125D;
        Mon, 27 Sep 2021 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=08q31EIVp0CLnjZ3JOSG2pLmduRMGbbY0RWG/PagZSQ=; b=dTfOGMG3AUYtr1bbCvG0t/klmk
        LajkDYnCSmLe5sT2mHlX5un+6JkZTlg6PVmWy4n5/jgMM/1A6QdINqzW+2KuF4kDyJ8nTkrt8z8n0
        jjusumjxb+KSwZv+kU0wBQHA6Hkv2iykZTStpVHwwFltABaYnNs1hWEIhYff0sMAjxbUs350a55K3
        JHrs2nbuUBT1jU9cWK+1XZTDN41Hf4nMBTqsRDCdL2otKu/9pw25SXrc2JgTutuxeRBmL442aIUba
        XEFhwVvAydc/G8adPf7VLVpBDx4OAGF3Weps0t52oIP5WeiDl/FWVvLlY7imcJkluXUwBIZTO7S1v
        WUzWDZGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPI-N2; Mon, 27 Sep 2021 22:01:11 +0000
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
Subject: [PATCH v2 02/15] aoe: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:00:57 -0700
Message-Id: <20210927220110.1066271-3-mcgrof@kernel.org>
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
 drivers/block/aoe/aoeblk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 06b360f7123a..e436b0e8eff5 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -417,7 +417,9 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	device_add_disk(NULL, gd, aoe_attr_groups);
+	err = device_add_disk(NULL, gd, aoe_attr_groups);
+	if (err)
+		goto out_disk_cleanup;
 	aoedisk_add_debugfs(d);
 
 	spin_lock_irqsave(&d->lock, flags);
@@ -426,6 +428,8 @@ aoeblk_gdalloc(void *vp)
 	spin_unlock_irqrestore(&d->lock, flags);
 	return;
 
+out_disk_cleanup:
+	blk_cleanup_disk(gd);
 err_tagset:
 	blk_mq_free_tag_set(set);
 err_mempool:
-- 
2.30.2

