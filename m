Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A0C48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FABC20663
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFYRzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:55:46 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:42126 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbfFYRzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 13:55:46 -0400
Received: from lab-pc01.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 354B41F40D;
        Tue, 25 Jun 2019 19:55:43 +0200 (CEST)
From:   Florian Knauf <florian.knauf@stud.uni-hannover.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     linux-kernel@i4.cs.fau.de, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Knauf <florian.knauf@stud.uni-hannover.de>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: [PATCH v2] drivers/block/loop: Replace deprecated function in option parsing code
Date:   Tue, 25 Jun 2019 19:55:17 +0200
Message-Id: <20190625175517.31133-1-florian.knauf@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch removes the deprecated simple_strtol function from the option
parsing logic in the loopback device driver. Instead kstrtoint is used to
parse int max_loop, to ensure that input values it cannot represent are
ignored.

Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>
Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>
---
Thank you for your feedback.

There's no specific reason to use kstrtol, other than the fact that we
weren't yet aware that kstrtoint exists. (We're new at this, I'm afraid.)

We've amended the patch to make use of kstrtoint, which is of course much
more straightforward.

drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..adfaf4ad37d1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2289,7 +2289,7 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	kstrtoint(str, 0, &max_loop);
 	return 1;
 }
 
-- 
2.17.1

