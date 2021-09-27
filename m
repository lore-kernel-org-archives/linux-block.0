Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE1C4332F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5601A60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhI0WDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhI0WDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76EC06176C;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lal2NXQqjpgVXT5qKBKMi1UaOalfu5XptBbZ07KGrZw=; b=yQSS1ENaqP0/EmeOmEA7TaYNbH
        KkQ1/i0F0uNf9lDdAx9K73d02TPmNN3Ivsk8DSXa6F/9zD4EjLag0VZxHuhK3OO8aBPIIbPAiTfbE
        riPJmPJUNubabBALjMrY6x2rg2Vj/2iDryU9nQlzd0PM4Q/guxMrv+dbeUhtqqPg1LXu7cu4WtdiJ
        8yD2V0n2H+6bpHkWVYpEsu4A35PdKy+5XBgzyZcHCiDssQ9mKhBeNpxaB9umX4LZfNdApZ6YwC/X4
        b/+NQPuXMCqj7bKRlJTiaZbfyxe4pi+SsX1p9gL9t9anUIFqPq3xeX+508J+0d7xf0lP3kPhHV31r
        tYpI3naA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygS-004TPk-9U; Mon, 27 Sep 2021 22:01:12 +0000
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
Subject: [PATCH v2 14/15] pcd: capture errors on cdrom_register()
Date:   Mon, 27 Sep 2021 15:01:09 -0700
Message-Id: <20210927220110.1066271-15-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No errors were being captured wehen cdrom_register() fails,
capture the error and return the error.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/paride/pcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 82a654fc4db8..4cc0d141db78 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -940,7 +940,9 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 
 	cd->present = 1;
 	pcd_probe_capabilities(cd);
-	register_cdrom(cd->disk, &cd->info);
+	ret = register_cdrom(cd->disk, &cd->info);
+	if (ret)
+		goto out_pi_release;
 	ret = add_disk(cd->disk);
 	if (ret)
 		goto out_unreg_cdrom;
-- 
2.30.2

