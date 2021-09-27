Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45741C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D26A60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhI0WDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhI0WDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:31 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92983C061777;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=agaE6D36LcS3m3yT/hy8ziCroVpqabvNI/EGY/bikug=; b=rDrGuHRz4Mi4O2WZ9Vjqozc2xM
        CSr3B1VsRIE9vtSInYTpOIu1qJalD6Q0vH2rQMNi3CwU2tQzdDNESJGwx7O+l/gVpNhJKNyZwI9eB
        YmmTn48w6S0dIZLJDvW6TBlKRWwqsTHZ762pxA03ZfpctLtyj/5rMrvep9ql7yGu+dLv0K9R3kcAb
        mVnaUpxsWZD8jUIT+1rxojGXC7rLv47JGzZ7YU0KvblzGaAfG0s4V/uwSiJUZaz2E7fmDNuvLTJ7P
        5azHIToaMRwuzlbEopQB3a1YJbbXGC/jdVLAkmmCKc2JxSPEgkKIGG3PisxTcjpH/Xz3JnFVxgM9y
        8kdmOM9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPK-OB; Mon, 27 Sep 2021 22:01:11 +0000
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
Subject: [PATCH v2 03/15] m68k/emu/nfblock: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:00:58 -0700
Message-Id: <20210927220110.1066271-4-mcgrof@kernel.org>
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

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/m68k/emu/nfblock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 9a8394e96388..4de5a6087034 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -100,6 +100,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 {
 	struct nfhd_device *dev;
 	int dev_id = id - NFHD_DEV_OFFSET;
+	int err = -ENOMEM;
 
 	pr_info("nfhd%u: found device with %u blocks (%u bytes)\n", dev_id,
 		blocks, bsize);
@@ -130,16 +131,20 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	sprintf(dev->disk->disk_name, "nfhd%u", dev_id);
 	set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
 	blk_queue_logical_block_size(dev->disk->queue, bsize);
-	add_disk(dev->disk);
+	err = add_disk(dev->disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	list_add_tail(&dev->list, &nfhd_list);
 
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(dev->disk);
 free_dev:
 	kfree(dev);
 out:
-	return -ENOMEM;
+	return err;
 }
 
 static int __init nfhd_init(void)
-- 
2.30.2

