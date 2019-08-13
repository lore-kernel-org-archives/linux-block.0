Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577AAC32753
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287F520651
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfHMQj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60987 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfHMQj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C18230D0FDD;
        Tue, 13 Aug 2019 16:39:57 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0B5349D3;
        Tue, 13 Aug 2019 16:39:56 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 3/4] nbd: add missing config put
Date:   Tue, 13 Aug 2019 11:39:51 -0500
Message-Id: <20190813163952.23486-4-mchristi@redhat.com>
In-Reply-To: <20190813163952.23486-1-mchristi@redhat.com>
References: <20190813163952.23486-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 13 Aug 2019 16:39:58 +0000 (UTC)
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c6ff8f922fd7..ebc98cf76365 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -373,8 +373,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
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

