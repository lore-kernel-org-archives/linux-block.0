Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6212C4320A
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF6C60241
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhH3WLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbhH3WLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3891C0613A3;
        Mon, 30 Aug 2021 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T9eCqOQRvpBijkMagg7pwr5fiJ/Yqy7eE80sQLHpZoI=; b=Hz594MCnKyKnWeoZCnaBSD8D6N
        zLqy0gysF6Y1Sn7lKrMCH9RKiooERGeeJHe2dnJEEllkfXBUSzcXys0rT3+TZqwwByDgdxpEm9lFg
        FK1/BtKBIQcZY8ohIgCJ0KMhEN082glKMiKCHC+7kyuE7k8oVLK2h4zHZqvfED9+ucH8ky2L0XjKY
        JWDpOj3q/sxA7yG9bE+hy5sIbH4Vnm0PJ1UyJr7EhtnWFiklwpUgQNCduI/vT6bVHOiXZ9YUHgbNo
        JrNEiZYPy5BnI/bmF2YUfv7fCmAwt+0QmUX0FFgcHMN0saYe0/gDdCOEXDSVrCCthEmaaIG1y9Neg
        eZM8MNcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTj-000khQ-W7; Mon, 30 Aug 2021 22:10:07 +0000
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
Subject: [PATCH 06/15] xtensa/platforms/iss/simdisk: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 15:09:51 -0700
Message-Id: <20210830221000.179369-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
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
 arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 3cdfa00738e0..ad85c554cd45 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -259,6 +259,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 		struct proc_dir_entry *procdir)
 {
 	char tmp[2] = { '0' + which, 0 };
+	int err = -ENOMEM;
 
 	dev->fd = -1;
 	dev->filename = NULL;
@@ -267,7 +268,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 
 	dev->gd = blk_alloc_disk(NUMA_NO_NODE);
 	if (!dev->gd)
-		return -ENOMEM;
+		goto out;
 	dev->gd->major = simdisk_major;
 	dev->gd->first_minor = which;
 	dev->gd->minors = SIMDISK_MINORS;
@@ -275,10 +276,18 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
-	add_disk(dev->gd);
+	err = add_disk(dev->gd);
+	if (err)
+		goto out_cleanup_disk;
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &simdisk_proc_ops, dev);
+
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(dev->gd);
+out:
+	return err;
 }
 
 static int __init simdisk_init(void)
-- 
2.30.2

