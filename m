Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C483C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673C1610E8
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhI0WDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhI0WDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:36 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11BC061203;
        Mon, 27 Sep 2021 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8Tqj5TdypJFI9LKCX1GYcX8SMXGQKJv6MnhgBe11KFw=; b=mzs3LZQa/W+/kFjAVDF2BntjfL
        PZjeTLtE7vD4VHrvKk12WqIjPIkdNzWkdRxHe9pzEFQOBs9JLDVJTk0h8oEvECSLdYuCeL6EYHCz/
        F63qAuwhJrIvKlVPT9Ekp9vi8B4CJz5gX9/F9r6rfdskHPMHSs2hxpQOVZyksJOuA6R35xeQadBua
        nR0n+PkjEzzjVunTdZGw8qirchD3uQ73eLPSp7TGeQy9lO+jLtGXu0jRtXqpfVLtpz9WZbWilltyq
        wTZDY4U5UMhtjlic8pV3eaHBYf/47UYExbcFDQmhE5zO/I2HzzBt90ikAf+Kpxrwc52vZ5THOvWes
        0mHDoFNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygS-004TPi-8D; Mon, 27 Sep 2021 22:01:12 +0000
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
Subject: [PATCH v2 13/15] pcd: fix ordering of unregister_cdrom()
Date:   Mon, 27 Sep 2021 15:01:08 -0700
Message-Id: <20210927220110.1066271-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
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

