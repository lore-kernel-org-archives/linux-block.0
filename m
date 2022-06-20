Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA067CCA479
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiFTQL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A806205FF
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2A81C1F74D;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkQ5fnBmFcfHxnZx1ReNjXm4y069ZH0k8lDyjKcQQ1Y=;
        b=QjiO4PrXPxkLDIrsC6r89oEM4v0+SwNq7QsiSawWKRCKFolFCBbBpWGd8fW2rWXHmKNn8w
        1ht9bAWHnYHT9L8/Ms8E4W9trtxtfYbm1/ucfp/w/VyTm2ceBo3oRbqtDJZ3O8VYQq8ovH
        3q0js/2rP+jji+SMpNQzfTEGTEo5IIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkQ5fnBmFcfHxnZx1ReNjXm4y069ZH0k8lDyjKcQQ1Y=;
        b=DWXWj3cEP4mB4itMa/mkLvo1M0jo6d044sCv0cTC166IcudwaoWSlLyUa0TUQtWiwMNAAc
        KCovaufGjFzswyBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4F3E2C141;
        Mon, 20 Jun 2022 16:11:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F878A0638; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] block: Return effective IO priority from get_current_ioprio()
Date:   Mon, 20 Jun 2022 18:11:43 +0200
Message-Id: <20220620161153.11741-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; h=from:subject; bh=D0lCQnDH8VrDiIGIyNdnu6/lqX72S5p5jWumi4VOzGk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJw/gD/OntD7HMqvoCUG6Bp1gOuAFStnAO9I0u4L 1JaFXeuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcPwAKCRCcnaoHP2RA2VFxB/ 9aBY3ZNGoFUEUvI+YpXl1F73mzewmdXg0B7zQVSwzAATH28oOCIr+LpfC6Vhni/Ssx/b6/B48RKklU /gsqdjmnrhJxAIcj0/O7aCs/FmZxGQzKIq53jyoDyxB4wAAzXGG8X3WkAbHFkJ6A0PpuZXTsykEsFQ epphzpOb40F9ah1xUC84KpqkP9Oa9cV0a/3uPGiR3xt/7kAcDC1HEHNEbQAGS6cE+phdMY9EfYREsa Mdi7kicOI6h8qg7MBdwuAuafvKtaH0H8NaTvk4ZqHfiLShf1ZtJ6cn5B7cLlP5HLyCMg5VnLdNPnzb LteryvbPyO1+CsJ4BjLteKvsc0RZFb
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

