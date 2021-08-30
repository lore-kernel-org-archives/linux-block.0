Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F0C43216
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A48060F57
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbhH3WLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbhH3WL0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A8DC061575;
        Mon, 30 Aug 2021 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BcUF+qNITddSgWWUKSwV6xy+2M578+kqxDNel0HR7xE=; b=o0TQ9UmqscxJfJ8NJhzA1rtmw9
        25/6M0a8/6erBaku4x6rnGDwEEua4Zrl8B46jt9Ih1h25ucZTprNrGBtE9SVJWkP4vJZH45dc+Pkv
        KJX1Apei2BWqYHqQwQ1oVlnGYqyrXjzTIlUBjZ8WTKAhdNbmlANxwyf63SPLkYGhL7szqPrTixnaj
        laRicyXPR12pSErHI7n02kt4UJcLQZD0Xiazv8J/7yZ5sGNgoSSnpTaeDf+Mac87uSa+nCCfDqIP2
        +sgGUYYBuQPN+cxlQx6Qy1MUNGZs96eMAChAf/iaZIktFgV8B5YgBpm7GexWeWVViYmA0IjKnjVgz
        uOrEhLCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000khe-90; Mon, 30 Aug 2021 22:10:08 +0000
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
Subject: [PATCH 12/15] pcd: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 15:09:57 -0700
Message-Id: <20210830221000.179369-13-mcgrof@kernel.org>
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
 drivers/block/paride/pcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 93ed63626232..a7fab3830d7b 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -941,9 +941,13 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	cd->present = 1;
 	pcd_probe_capabilities(cd);
 	register_cdrom(cd->disk, &cd->info);
-	add_disk(cd->disk);
+	ret = add_disk(cd->disk);
+	if (ret)
+		goto out_unreg_cdrom;
 	return 0;
 
+out_unreg_cdrom:
+	unregister_cdrom(&cd->info);
 out_pi_release:
 	pi_release(cd->pi);
 out_free_disk:
-- 
2.30.2

