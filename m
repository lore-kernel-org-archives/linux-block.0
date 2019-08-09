Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F46C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F170B20844
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfHIV0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfHIV0Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34EDC30821A8;
        Fri,  9 Aug 2019 21:26:25 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96FA460872;
        Fri,  9 Aug 2019 21:26:24 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 3/4] nbd: add missing config put
Date:   Fri,  9 Aug 2019 16:26:09 -0500
Message-Id: <20190809212610.19412-4-mchristi@redhat.com>
In-Reply-To: <20190809212610.19412-1-mchristi@redhat.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 09 Aug 2019 21:26:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix bug added with the patch:

commit 8f3ea35929a0806ad1397db99a89ffee0140822a
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Jul 16 12:11:35 2018 -0400

    nbd: handle unexpected replies better

where if the timeout handler runs when the completion path is and we fail
to grab the mutex in the timeout handler we will leave a config reference
and cannot free the config later.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 131b541d07c3..93294000ce55 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -371,8 +371,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock))
+	if (!mutex_trylock(&cmd->lock)) {
+		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
+	}
 
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
-- 
2.20.1

