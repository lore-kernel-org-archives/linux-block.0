Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C31BCCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiFWHvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiFWHso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77A2C643
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BB381FD42;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XShOVy+XtTozsCdsQOdsSaoQ9uJ1HILWluwpZp3vhJw=;
        b=J3kZj9X7xOhjp8bKn+Bx7gZssjvi54W35C6iUwMtPG362m/evCNXlIO2OXv5tNMi6AJyRf
        HcQHLuxZR2cXfdtkhfr/QW0AfgBsIN/akCvE3GC1bOz7XJt4Jy2OVcnsQ0qYY9VRxlA3u0
        MNcEylGC4Zin3pXyN5Aq/SrUGAn1ZNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XShOVy+XtTozsCdsQOdsSaoQ9uJ1HILWluwpZp3vhJw=;
        b=b/oqteHPoDStGH/ewpf5UB0wDp3PwP7QoNozVoaknmxYei/SX1Eacs9Oc2qWZfeIHkYPeM
        PDflX/tfn6bPkGDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F6782C16E;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C538DA063B; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/9] block: Make ioprio_best() static
Date:   Thu, 23 Jun 2022 09:48:29 +0200
Message-Id: <20220623074840.5960-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; h=from:subject; bh=Y2FBsRgMq5JsaN1zwMeKVun8U5TAAsYgfzfvXCApjQY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrMtdOK2pJ+9C1oyvZHl0+uQkWDvGzKY/1cBJgs eQq1n0CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQazAAKCRCcnaoHP2RA2cTyB/ 0dFyI9r/nCa5zybam6dnIfz9Y8UIc/znD79w/uop+iKCEly2memfaDjaFdKAomTWzMyPP8nWgcjP/S bw6QvoFFrsZQ7gTXx9BK+8GeBVEXHJq/FhIuHXYczRxLuuDseVJgkCM545p3oxQM5R2FRzk+f8B8o/ 9CZcAV4iuOzGNV3RblRTgHD5KoZgkadoWuRm5JAeDhXQy2inpwyWGjZYgGciLCwc2Bcj1LLLx1gPsN Zf6OXdyzexuSMcEPzPfhL3Cb3wa8hfCyHzIGilouTdVYLqtziO7mxTutF3JSLpgvbszH/ZfgLakc7E KPS2ib6KRIzA0dd+CWLwiZEQJXISeP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nobody outside of block/ioprio.c uses it.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 2 +-
 include/linux/ioprio.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index c4e3476155a1..8c46f672a0ba 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -180,7 +180,7 @@ static int get_task_ioprio(struct task_struct *p)
 	return ret;
 }
 
-int ioprio_best(unsigned short aprio, unsigned short bprio)
+static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
 		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 9752cf4a9c7c..7578d4f6a969 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -60,11 +60,6 @@ static inline int get_current_ioprio(void)
 	return __get_task_ioprio(current);
 }
 
-/*
- * For inheritance, return the highest of the two given priorities
- */
-extern int ioprio_best(unsigned short aprio, unsigned short bprio);
-
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
 #ifdef CONFIG_BLOCK
-- 
2.35.3

