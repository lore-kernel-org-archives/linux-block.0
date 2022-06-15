Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759AC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiFOQTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355270AbiFOQSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271A45526
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CAA41F974;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTz8ZVve7ICu7ezzDrVXZ+LmahVFfCLd1uVrOnwq32w=;
        b=Z52xnl8JQ+IflGRFzIFjDSi9Q4IvTDAgAJGQ8+dYhICPrJj6tPfE5vEDdgdHNDleJBIRck
        SV7+4XFldTnpRvIMFVpo/RPJcyIXyPgKYuFZ1ZMP00h5LHXv8ZqQb8MBVe8BoLLp8GzRfq
        7axvnEQUnYbUCap1/rCkK3zxYEevJek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTz8ZVve7ICu7ezzDrVXZ+LmahVFfCLd1uVrOnwq32w=;
        b=867JSihYk8Zk1gpO/ZczPpxpT+bz/LT/h04RlwzxitutCoh0qvnyk4IAw6YyshPTV2jK6t
        HNLkAQAZOy94gtBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2FB352C143;
        Wed, 15 Jun 2022 16:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF859A0635; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] block: Make ioprio_best() static
Date:   Wed, 15 Jun 2022 18:16:05 +0200
Message-Id: <20220615161616.5055-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; h=from:subject; bh=rPhukKpylibo4V7blrFwToaoTXpiIOZKaKcKjvnBkH8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXFL3CrP+llnmWK8hvTtjpQrXA8t+2r7TnX2j/R XDlm+QKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFxQAKCRCcnaoHP2RA2V5iCA C77nKCaoxw4vNiMOJQI3XPj8lauAzSJX9lxSUcjaY7+3bIZZbKYL3EtlcepSuytKFPS3wLdt2pm4P/ BqnbLh9MnEXE5Fj8L09bLZcuEt4qGkfSo2aYUHnhe6tGhhI0V3BjyfJVcjLFBaSeZEsZ+hqSEogw0X PuG/p49Qs5yOa4BGSHaIYKSxabj8BPGvCmlg0xqoNzslWH5kiWIvYfLVX21JcRxLbAunM7Kyda4NTz E9O1YmeQ7C4CAnQJPiOvmVa2hzFTYm6VZOQOdCl8l7g0e7WneyEo3PZmojNjJyd2teY3XQR/c1sJhc vcW+QncQ0uD2cgl8kJSiV760pLG1LQ
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

