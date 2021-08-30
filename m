Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF0C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F8A600D4
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhH3WLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbhH3WLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F6C0617AF;
        Mon, 30 Aug 2021 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lal2NXQqjpgVXT5qKBKMi1UaOalfu5XptBbZ07KGrZw=; b=QVHiTlNbaPcesPvOauCe7X1MmY
        9OZgT7JOImNgPMZS5Tl5Mhov3exlnqyg0ntEMixp7CZEX738tgCR0/noKGbjAI5qSiD9Os4zDEPBD
        ztYSTAxwK4QMQZVHttVH4VOB20LGJYHU11zMWiZBze9VeiIjiswuPPDHaXwziWrMZQap8F5Dy4t/C
        WwRBvxBJdOrWZhfrtNA21KNeq7JWMltJg+o2bMcC5mMy5wS48aKyRP34eFvaHSIF7NADt2cQME4yx
        XsqYy9MgCq5ZCIamQID/iTS67vsVcn1kfYfFUlPC/+4jSrBoQciNpNAh2mkXZYp1GXSK4dVBuxJD9
        I46T5glg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000khi-C0; Mon, 30 Aug 2021 22:10:08 +0000
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
Subject: [PATCH 14/15] pcd: capture errors on cdrom_register()
Date:   Mon, 30 Aug 2021 15:09:59 -0700
Message-Id: <20210830221000.179369-15-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
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

