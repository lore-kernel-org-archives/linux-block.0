Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6929C4320A
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48C96101B
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 22:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhH3WLe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbhH3WLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9761C0617AD;
        Mon, 30 Aug 2021 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8Tqj5TdypJFI9LKCX1GYcX8SMXGQKJv6MnhgBe11KFw=; b=s2mRwTN9A0ayu3FLnaCaRM2c2O
        2FWBh6vzZHYtgRmh76EyjTtWzXh2kQ9FFa60d6x5SAImBhBj+YRqHg7yA7RD93ODV5eWnIo9v+1TE
        GLc9R75Q5HI6Fp/LOmUNOZkyyeuBEAlUHDguBEP5vTKBNyo0xOOXkUYhGv8e6LCrHlCyu8FzKEUem
        AnUY7M86GN0BWDjYGKT2GFQ6HpJXa2aoh3Zj7ny2ZiOKWJxSeTydFgIICno9j0gq37CNAKsNsARSw
        ogYjb1A/XK+wuHTf1FhZnInJPOjCva+/yOJyMIL9Wipztb/LFOvE5FsJQziBMIYbvjHq1Uy31kKR8
        IUBB5zMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000khg-AZ; Mon, 30 Aug 2021 22:10:08 +0000
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
Subject: [PATCH 13/15] pcd: fix ordering of unregister_cdrom()
Date:   Mon, 30 Aug 2021 15:09:58 -0700
Message-Id: <20210830221000.179369-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We first register cdrom and then we add_disk() and
so we we should likewise unregister the cdrom first and
then del_gendisk().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/paride/pcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a7fab3830d7b..82a654fc4db8 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -1021,9 +1021,9 @@ static void __exit pcd_exit(void)
 		if (!cd->present)
 			continue;
 
+		unregister_cdrom(&cd->info);
 		del_gendisk(cd->disk);
 		pi_release(cd->pi);
-		unregister_cdrom(&cd->info);
 		blk_cleanup_disk(cd->disk);
 
 		blk_mq_free_tag_set(&cd->tag_set);
-- 
2.30.2

