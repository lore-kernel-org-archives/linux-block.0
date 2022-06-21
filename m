Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D90C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiFUKZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiFUKY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636C928726
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2281E21C38;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f113dIywoOVYzhnNFWbFdCjn+SuIZl6WdAtY+FhLYPI=;
        b=uo4+i2H4JVjMF4eXP1Kd06v8YqYyn5plHgRRl1phVQ/5REGIx5hX/MUqp3HZPAKZAIW5kH
        m08tNFvSf3iR12IRCa8czMbIWIqompf9KzaRykzN/0+gpQ9Ktre4ARjIpMR8e4h3gl+uaZ
        +jQi+k+TqgBHRKigxpseLtD6NjK6k2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f113dIywoOVYzhnNFWbFdCjn+SuIZl6WdAtY+FhLYPI=;
        b=nI9mPDh2wCikkmw40AUC8os3rLQoHBT1FUprOdbcsIEn8SDQYdvp3sDTnvYqyeIDPKfLH6
        ujyl3TZbMjYm2OCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AF10B2C142;
        Tue, 21 Jun 2022 10:24:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6471A0639; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/9] block: Return effective IO priority from get_current_ioprio()
Date:   Tue, 21 Jun 2022 12:24:39 +0200
Message-Id: <20220621102455.13183-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; h=from:subject; bh=LQysfpFiMQ3cqmtBoDvv++qBY9sUt5tIGAfQXZyR7vE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxnTn0JEceDPlbxY87QGISNPTJdYcb3ah4RzceG uqFigauJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcZwAKCRCcnaoHP2RA2WCTCA CjLphKtL1aVFh8h0Gz/2Za7iUY/tlID5FDMGW0g/xJLuXtPc48CvXOWaMbWfaIVCUWsYCwUOFFZ2xp m8mAEsqfyRxu0mcoIB9NqTYtCUSkZVzMfiElHE2yQylOkpU66HO9DA/74phCV/Hb6xWgLVEJcxeYG0 R9ss7BTuB1UkqtGshZ6Ux/aVl2CSTz+pDV08qtx8jDvovw5nrI8js5Ee7wNK0Cfh8W3Ss1WVgroht5 L0WOIc8z2A56kqHvAY6RODNkv+VX+epc+zHtHgbV/6J+upP2aypgF0w0HrwQGRFDPJDgVbxIuHl2Wq sJIIWiCaZhYfpk0BvfaJOFsdt904sv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_current_ioprio() is used to initialize IO priority of various
requests. As such it should be returning the effective IO priority of
the task (i.e., reflecting the fact that unset IO priority should get
set based on task's CPU priority) so that the conversion is concentrated
in one place.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/ioprio.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 3d088a88f832..61ed6bb4998e 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -53,10 +53,17 @@ static inline int task_nice_ioclass(struct task_struct *task)
 static inline int get_current_ioprio(void)
 {
 	struct io_context *ioc = current->io_context;
+	int prio;
 
 	if (ioc)
-		return ioc->ioprio;
-	return IOPRIO_DEFAULT;
+		prio = ioc->ioprio;
+	else
+		prio = IOPRIO_DEFAULT;
+
+	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
+		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
+					 task_nice_ioprio(current));
+	return prio;
 }
 
 /*
-- 
2.35.3

