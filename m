Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB8C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiFWHs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFWHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBF2CE0E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DE0121D3E;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02jsHGCYECcrORsmJgplcrBdxZZ3tsQTZklav0bRcY8=;
        b=gvbLHXnVJuttfvRVnDmySixyTqnIDwqSVarjdUJDNZBDdh8sBs+8s1ZoZfv5KP1Awva41k
        aRF1NzO8jD/nkOfeOrU98B73EKaY4Ajv9ZBgrJYdrvQU/pLdZCbvYK5LlEgfjP3LFEhDTq
        rZgZ8x1tWN50QZqAFJiXYncNCdfo4os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02jsHGCYECcrORsmJgplcrBdxZZ3tsQTZklav0bRcY8=;
        b=6+v0bFlKWqCgQqoblYsS4sX6d7KOqUopCiKPrw5PN1kbSe9TZbMTEE3POIEuWydDxzOvKj
        Th5JnDZP52bfPNCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5EEE2C145;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2BA3A063D; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] blk-ioprio: Remove unneeded field
Date:   Thu, 23 Jun 2022 09:48:31 +0200
Message-Id: <20220623074840.5960-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; h=from:subject; bh=TvQ37LVU1nkBVVpWfKskESMfETYuFiKG2oEvfs86ANI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrOHVYqsam6Fzw+rQ9gi4PbcqT1FMajDyGOaYFO R0tBLkCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQazgAKCRCcnaoHP2RA2bEZB/ 0XTHjIp9dJsjw5+THTv1StASlcGA/z6WyIM6BUdBHRLvZ4Ukex91v2GeYoZvH6bebHSlubO6oP2wzx cjwcSD6F2+h+1JMeGOHvSaDwyW0YSssOgd9qzuaQY0eHsHNb32m2Cic70SMVAvBbMwkjn6EeWrnKL+ J4c8B+ueicIGQT8B/eiMRFw0q0EJzlTrKA3aull1o7GgUN+cu6QQBsqCZtKdjn/lPDCyPF2drxX7Ip OTberSIRKOdYqsH0z6OXC/ZwYe8YD9tKy+NsIxfta42bqLbzCoswEByotvryxI2OPvxmT8KACN+8AL IZh8w4gw4RVaK8l9breVSvvzUbM+eL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg->ioprio_set field is not really useful except for avoiding
possibly more expensive checks inside blkcg_ioprio_track(). The check
for blkcg->prio_policy being equal to POLICY_NO_CHANGE does the same
service so just remove the ioprio_set field and replace the check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioprio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 79e797f5d194..3f605583598b 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -62,7 +62,6 @@ struct ioprio_blkg {
 struct ioprio_blkcg {
 	struct blkcg_policy_data cpd;
 	enum prio_policy	 prio_policy;
-	bool			 prio_set;
 };
 
 static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
@@ -113,7 +112,6 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 	if (ret < 0)
 		return ret;
 	blkcg->prio_policy = ret;
-	blkcg->prio_set = true;
 	return nbytes;
 }
 
@@ -193,16 +191,15 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
 	u16 prio;
 
-	if (!blkcg->prio_set)
+	if (blkcg->prio_policy == POLICY_NO_CHANGE)
 		return;
 
 	/*
 	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
 	 * correspond to a lower priority. Hence, the max_t() below selects
 	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
-	 * If the cgroup policy has been set to POLICY_NO_CHANGE == 0, the
-	 * bio I/O priority is not modified. If the bio I/O priority equals
-	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
+	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
+	 * priority is assigned to the bio.
 	 */
 	prio = max_t(u16, bio->bi_ioprio,
 			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
-- 
2.35.3

