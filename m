Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B3CCA473
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbiFAOvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiFAOvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 10:51:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC45DD1E
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 07:51:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A92621AE9;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654095071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTz8ZVve7ICu7ezzDrVXZ+LmahVFfCLd1uVrOnwq32w=;
        b=h/03BKw4627BrOicSvXkUKVIdt+Paj0lQHUP1VALnfUWK2s6YWEHKq29bvWbj+XOwyMn4e
        cdurL0JSFLoz4yMiqUz2dxXgeyL+bboGaAyYggs2GJJb8FUjnKAqCc8yRXdYAk002DSMf9
        boNkMJ/Pj45jYyPQ1KTfhUaHZGvjjPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654095071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTz8ZVve7ICu7ezzDrVXZ+LmahVFfCLd1uVrOnwq32w=;
        b=JkRgz3vU3RWJfv2LPLvMxRPUFnWlf90+kt4C3ExzHBp8B5I7/qLCjTnOCnoZZp1Vxrfm3p
        l1XUw6XpU4ZKOvAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D1A62C141;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C3ED9A0635; Wed,  1 Jun 2022 16:51:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] block: Make ioprio_best() static
Date:   Wed,  1 Jun 2022 16:51:05 +0200
Message-Id: <20220601145110.18162-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220601132347.13543-1-jack@suse.cz>
References: <20220601132347.13543-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; h=from:subject; bh=rPhukKpylibo4V7blrFwToaoTXpiIOZKaKcKjvnBkH8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBil3zZL3CrP+llnmWK8hvTtjpQrXA8t+2r7TnX2j/R XDlm+QKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYpd82QAKCRCcnaoHP2RA2b/lCA Dr01+n9N+mt1BZVhsQz7922ta3w7crfcaYPGSq41A+LG5zK4Q/0BY3x6V4Cz1jPMtXh6odvu4AGxED sdeBTVISKjcvT9o0l+RZ+FwWfGxh53Bj7zybYGHbudBOLr45fw2Mz7R6K5JwIT3X6yNYsIb6HpbwDI 7u88RvasUZ0vhD2oJQwk0b5zjGR7v99ZTWnxr68yTVC1I2mGAU1GTvOpdVBiOP61gzvCuNBAM3QPOR yreCa4yZZI4ICYqEZsPYjbG66SKOH79xsqU5QCrWgwQ5n95HD63ZOJXu4G1MdTYg1cuBMn4aaDdGdw 4QZqYjkz9/xGwBNaOiIDPh7klJEpqn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nobody outside of block/ioprio.c uses it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 2 +-
 include/linux/ioprio.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 62890391fc80..18f7e16882fe 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -154,7 +154,7 @@ static int get_task_ioprio(struct task_struct *p)
 	return ret;
 }
 
-int ioprio_best(unsigned short aprio, unsigned short bprio)
+static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
 		return bprio;
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 3f53bc27a19b..774bb90ad668 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -59,11 +59,6 @@ static inline int get_current_ioprio(void)
 	return IOPRIO_DEFAULT;
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

