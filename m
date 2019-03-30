Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934BC10F05
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410F92064A
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908275;
	bh=Kz+AKR0azGPOFzQ1sEvlXT8YCYVJc7g0vv1o52G8Ngw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdhR3qmxxngKzaZaop2V2ugsKcX41it8Cwtdv3E9D9Komf9yfJgKxQP6MRNb1eoie
	 Nxjn3N5C5+jMjjPTd65PAly9lcbpxeUAOAnK52D1RpFQ2hVgrMm5Tm/MT/Zj3a3ISy
	 /OxYFMwDMZ6Qw4mZxIbaHgAUp9DKXSFSe5X/HN9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfC3AvO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbfC3AvO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6C2218D0;
        Sat, 30 Mar 2019 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907073;
        bh=Kz+AKR0azGPOFzQ1sEvlXT8YCYVJc7g0vv1o52G8Ngw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3xXee2J8Px36rwa4IjbcZKIFkhHWbdgC9iBcD04Fcm0bB8anmb+r1LKYoFurU1JR
         +nbDxx5OLP07XMBYmvK+KGEMSFsZq3YYpg9hQ99JQgKtr2TAs9QXqy+0u/z9YtWbER
         wctMd7VM9Bc+zhMin3rvOdetE3Yry7fZ8D1/dz0I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 19/67] paride/pcd: cleanup queues when detection fails
Date:   Fri, 29 Mar 2019 20:49:59 -0400
Message-Id: <20190330005047.25998-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 81b74ac68c28fddb3589ad5d4d5e587baf4bb781 ]

The driver allocates queues for all the units it potentially
supports. But if we fail to detect any drives, then we fail
loading the module without cleaning up those queues. This is
now evident with the switch to blk-mq, though the bug has
been there forever as far as I can tell.

Also fix cleanup through regular module exit.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/paride/pcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670eefaeb2..377a694dc228 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -749,8 +749,12 @@ static int pcd_detect(void)
 		return 0;
 
 	printk("%s: No CD-ROM drive found\n", name);
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
+	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
+		blk_cleanup_queue(cd->disk->queue);
+		cd->disk->queue = NULL;
+		blk_mq_free_tag_set(&cd->tag_set);
 		put_disk(cd->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
-- 
2.19.1

