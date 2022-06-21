Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD82CCA482
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiFUKZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiFUKZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:25:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1628992
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A60221FB2D;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffB8Pj64vekbITtCYJ1AqOBYUgDlfoSBwpNPKYJ4wEY=;
        b=VFs6lHxPTf2zrrIYfdDyB/GVBlucsr74dYs/aPSzihJ2/zgjnCBPwK5CiScmlfluHP56IC
        xZih4E9BSjctL2mN633TXEcmhUQ+tR9OEsWP+cRM9k0BlDqESCntjqZ120BbOg/8XdfqyT
        LqVAz4MQAyTJuaEomPdgP5rDFMBT+sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffB8Pj64vekbITtCYJ1AqOBYUgDlfoSBwpNPKYJ4wEY=;
        b=mCw9tOH5XmbiQ0ysBfVq3L8RQkflVExmIRU/CAIojyskJQt1Y+tS8LGbZM7hfpI3heLgkZ
        3QjiemkS8wPNpyAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 926342C14F;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F24BFA063D; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] blk-ioprio: Remove unneeded field
Date:   Tue, 21 Jun 2022 12:24:43 +0200
Message-Id: <20220621102455.13183-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; h=from:subject; bh=BfCOkvsJnWQ3WtVgtAsGeIzxv1lGgzAZRrnzSnIYV4g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxqCitFMm4vfu5zWXI7jiJnSmNgLHVkIK2+HbMi 0X4+NdiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcagAKCRCcnaoHP2RA2TPZB/ 0bv69/wsrMZDcKYp21+bwdiamWi+gm1Cvn05wBKxbyGFMgeHCzf0azjaYZNIijeSFiy871SEV5269/ qV/Om+1qsgjzZfAB8Volke19mpY3EN5hfOQz06y5fS3iPYrY0uqj0YtSMl8dKs6sm7aCejNIwjr5E6 AV399JlX24jcUhOmzJ7dafS8TtSrsKfLsYjEllr3SLd+P3DI9xlBXZlD/6oM5+4HrvGbGhS/Gw8fxP Y308lmXQF3WjhGa/edGSOeDTAx+SGM9sj2c0iXGyGm7CWXaFh/ymx8hUVd7wvKz82kQzwxEku2sZol hiyLDv1IBX4zMElPkhZnPmFjZQb9Sw
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

