Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B7CCA481
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiFWHsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiFWHso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B12C640
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17D3A21D3D;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDV83hsVfY2ZNIyLWdNXdAzjSRvhop8S8h3xh9/rThg=;
        b=WbyaFSgTRHXQaWtFeacmi7INA2KFP5125Wf4JBdkbjq7JzH9DG91A2QTJ/zdIk6eOR+Zbh
        q3POb9rY8mxjYle2SnK+QDY75pqQx5r9n6ljNiMJ1pO40/E3tZ+GTdm0rH9+gD1fN/0G16
        2vXh0Gnu2iNFzlIxshOt9W6uG2iPVj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDV83hsVfY2ZNIyLWdNXdAzjSRvhop8S8h3xh9/rThg=;
        b=aRX8U2z/YXMb671/z/uVuYlVCo7b8MzVIVvZmC308NPrFRO60LMBZxdtidT9PcWmowxneR
        dqqf9I2CRqOdcbAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E8DA2C15C;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B77A2A0639; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/9] block: Return effective IO priority from get_current_ioprio()
Date:   Thu, 23 Jun 2022 09:48:27 +0200
Message-Id: <20220623074840.5960-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; h=from:subject; bh=+1Tzs3ltee4pP0iXIHD+6UM/ZVl4By/ycGmxzX3amRQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrL8ZtxsTisTWjL9RIxw38tHqKfJEe+WtHgcdns guTTFumJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQaywAKCRCcnaoHP2RA2YBSB/ 97prQjVmo/UalKzhkgv5/5J7f5dTX3mku66ZOJwH4mUFKdnVvJk9XroHFxSWt8iCIiHrJveU3tA3/g BMKwOXCK8Cmxs+tH41j3xjSy5HIMiZuVUdgJ5iW5FJGum53WPQbq35oY8fAXwqcSpB3OXq0Lbpq10R OUsFXX/lGzmEPPZeDQlQLgkEluVmKLasr2wlg2rMFnzW8xdfBa0gyTZHFX97HfgtgrQA1dSW1IY0k5 O7hMCHbm9zlUy/u51APbK1qnFzGfGbATHlyZnr5wS5hX4mhvUzDmK1dgYY0Ehu9sGt9/xTkIh1IPL1 qX59xkYG76R1OcUMNoNjA9wf3v2FVH
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
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

