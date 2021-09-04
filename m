Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A6C433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BC3610F7
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbhIDBgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350922AbhIDBgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B204C061764;
        Fri,  3 Sep 2021 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4imHp2CJ0meb7xhuvqWowaDJhq/kim8sGOgKxWzbOuY=; b=rsWDM6q7QeXdE2aNmyfdcVAIQa
        kX1s1sl5PHieDOsF/uCBzFE2i27dLAOT57UmA7RdhyKQbP619LigOi6i4FAJvB/z5nQFoF4mcl/mv
        YZRMrUmEgosi7P/06kMfThxtaQbVEl9XzN1F62M/vqliF8TcWNN3BRL9xT99RXa58IklDX2aQ3fjc
        x2hbpZrg/cQf9mlfO25zbypVVJrBU5IuDsEQRjbyg2fd17GY+/xq/Vv+OsfnDiK+JXU876HWewXZd
        6yRbvc88G7pmblFoRrnQ+LT6p8j7K/onrgxgcvUJ8W85OwWBBhuwLEsCz+6ypSoFveeIB6+pNJOec
        Qff1MkRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbT-RT; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 14/14] block/ataflop add error handling support for add_disk()
Date:   Fri,  3 Sep 2021 18:35:36 -0700
Message-Id: <20210904013536.3181237-15-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
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
 drivers/block/ataflop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index e9d874f51597..5dc9b3d32415 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2081,7 +2081,9 @@ static int __init atari_floppy_init (void)
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		add_disk(unit[i].disk[0]);
+		ret = add_disk(unit[i].disk[0]);
+		if (ret)
+			goto err_out_dma;
 		unit[i].registered[0] = true;
 	}
 
@@ -2092,6 +2094,8 @@ static int __init atari_floppy_init (void)
 
 	return 0;
 
+err_out_dma:
+	atari_stram_free(DMABuffer);
 err:
 	while (--i >= 0)
 		atari_cleanup_floppy_disk(&unit[i]);
-- 
2.30.2

