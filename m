Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90908C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiC3MtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbiC3Mqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 08:46:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53237DE26
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 05:43:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6FBC71F86C;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648644181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHU+Vg8Ryhg4yA0LaoIt150oR2BYg7vBbUFce/su5YI=;
        b=BKbYja+W3WcXgC+xRUCLbENx7rlJeGTpvvJ76Vjn9E9QBpckYOq+ar/XyOgz6kKlCsazuH
        9qMB1e9OP85Loa25+ttv7X7sZY+ZqMnVGJVOWDkjhPbrGowNvi6S3TI3JYqqdIbSkk0kpe
        z5q286b86PX/t6KxsJjbxcfwjyYmy5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648644181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHU+Vg8Ryhg4yA0LaoIt150oR2BYg7vBbUFce/su5YI=;
        b=hiR7y5QDlfGcmR0lgnTn9qKZ3pHTB+7Iku0fM24wkoEL/BDz3w/zJlYtiCvPu8wOBNlH16
        RrUENKyy2ZTL7UDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 613D9A3B9F;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 89E74A061D; Wed, 30 Mar 2022 14:42:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/9] bfq: Track whether bfq_group is still online
Date:   Wed, 30 Mar 2022 14:42:50 +0200
Message-Id: <20220330124255.24581-7-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330123438.32719-1-jack@suse.cz>
References: <20220330123438.32719-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; h=from:subject; bh=cd0xiQ5rstrE4vCdYR2bomPdo6Kc8upLVhtCRL+Ukpk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRFBJkeiymotY/RfT315UBgzw5+Ib/fW3cQL89/sN AOy4g8uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkRQSQAKCRCcnaoHP2RA2T3PB/ 9AJ0tCn2GBuVgxtSibGF3nwqMkxTE0ScwlhJ3GdLUyn0+3Xg9JJKbB3IQQWNJ9nE+93Xm+Mq4pXHF6 +p/WzK4Ztq/LNYvwJ+xvL+i5K3Iicb/2WkzXrIE51jjVCbkSTHOmx/KUyuFUojSNmM3jaOKxHGCVUr NZDoAiUUrquW0FcIlD5+UFaOUHHWUAP0KxqU54YXlrTys5JgHIf5+8gpmBdHJWEFrL2R6/pznq+JUL ixHquYeU86s6UWU2xWIAaAQseBl1NUcMeHSy9IjdNsXEyXOlY9riomcSDT/go8kAEvir6dtT5iWfH7 ZYSIXTP5kP3gdxDFTx3O5tW761D7ge
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Track whether bfq_group is still online. We cannot rely on
blkcg_gq->online because that gets cleared only after all policies are
offlined and we need something that gets updated already under
bfqd->lock when we are cleaning up our bfq_group to be able to guarantee
that when we see online bfq_group, it will stay online while we are
holding bfqd->lock lock.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 3 ++-
 block/bfq-iosched.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9352f3cc2377..879380c2bc7e 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
@@ -603,7 +604,6 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	struct bfq_entity *entity;
 
 	bfqg = bfq_lookup_bfqg(bfqd, blkcg);
-
 	if (unlikely(!bfqg))
 		return NULL;
 
@@ -979,6 +979,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 
 put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
+	bfqg->online = false;
 
 	spin_unlock_irqrestore(&bfqd->lock, flags);
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a56763045d19..4664e2f3e828 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -928,6 +928,8 @@ struct bfq_group {
 
 	/* reference counter (see comments in bfq_bic_update_cgroup) */
 	int ref;
+	/* Is bfq_group still online? */
+	bool online;
 
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
-- 
2.34.1

