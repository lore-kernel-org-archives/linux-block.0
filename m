Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbiFTQMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181BA20BD1
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A791F1F924;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqpItv11q9RFz4JOFsyAcCZ02pSGUPVwPnv55+p1+qw=;
        b=gurNjIr+YH+R1zUs7WmBIjLE+z32kTw6Ain8Jyk2kKj+Ocsg03vfMLphsGte1Pn7rPmZKs
        1n0hcZdNoeGlWOq5kdq6vxyHmsc+ztZaEJG8tBQ0aqQ0DfFZB2pe057TvO90cPH4LGDjTY
        OAaWIJgo3JB2Gv0RLGPuvkr0eBc7138=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqpItv11q9RFz4JOFsyAcCZ02pSGUPVwPnv55+p1+qw=;
        b=MjS8xhFQV83g01p4ClZa5QUbd4Zu8ux9xQnemCDbN5rZu3Xp3MYtJImjN+Gbcv6bmrfxL3
        vJKJ3vS8hmioMjBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B2052C146;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 524D0A063B; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] blk-ioprio: Remove unneeded field
Date:   Mon, 20 Jun 2022 18:11:46 +0200
Message-Id: <20220620161153.11741-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; h=from:subject; bh=aeKHE3LvhJoWaFM7YpJcwiDk+5O0mTw/oPPCBn0n9AM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJxCzGQLNJUmPklWz6HkDZPusSIiVep4XVNpKKnw dxcwcHeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcQgAKCRCcnaoHP2RA2YLdB/ 97kmPnv4ixFwOZxukUu/5pRg7aKDOsjhz0gvG6F2l8FJ8wGDjRwWp3Va+dr70hKFRV02brD0XkYcXz cn9zz150B9Ea6rHJYXYjHTxyztidRZXpRpqBjFgj4y4GqnCbwPWTDuU9oenVRRh9TNImR6xMHkmfrw 3O9xNG7IyZIF887lFAfbva3sZVRpjOKSpEBFu86IpAEBEAQPBzO6ZyXAxf/P/O36LZH4KJzJOHBu7z tlP5wMhW5hdGQjFlg6pCPhfip23NN2Q2NdprK/G9MEzz8gVj9yCyr2nbvgpfYk4O00+ke5yMcdY7UE 81E9Tm12PiFTZ8AvPQMf9idYW9UHVt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg->ioprio_set field is not really useful except for avoiding
possibly more expensive checks inside blkcg_ioprio_track(). The check
for blkcg->prio_policy being equal to POLICY_NO_CHANGE does the same
service so just remove the ioprio_set field and replace the check.

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

