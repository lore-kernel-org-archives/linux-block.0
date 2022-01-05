Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B7C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiAERF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiAERF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:05:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A0C061245
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 09:05:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CB061830
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DEC36AE3;
        Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402327;
        bh=+XQTZk3ubgunqyEYSBvBH7FNv+2vNL2x2STiFK+7xVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUv91FY+XbaScxPCnY65ap951HrSwbcsxBme3YMO8BrxR0go5m4laqctjvQeRqvCP
         v22/mim3vpwzf7ZuZ4nPF5He5t4PeGpYNHTRWpRMbDqy5722UF34rLl5oi8h6ucDyu
         cyXtzzNlHW0D8XTsmBsVYdJ+r3EnVr6LaC6s8eJPLTOI156scT+kTm/gSYjQbbg3z5
         N+AQN1ANxE1buEO2g/HRtmz39KBTsYc+/tlYdUTU894jhhMSrvHb640CVKdxx7ZPtK
         xeptnBP+pmKp7wqgZQ6/a/wc/TKrpj/CCAKDJtG3z4W+Qz+fCym3dBOCVXTDLPVzEM
         tajuVOJg90VtA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/4] block: introduce rq_list_move
Date:   Wed,  5 Jan 2022 09:05:17 -0800
Message-Id: <20220105170518.3181469-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When iterating a list, a particular request may need to be moved for
special handling. Provide a helper function to achieve that so drivers
don't need to reimplement rqlist manipulation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1467f0fa2142..f40a05ecca4a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -249,6 +249,23 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
+/**
+ * rq_list_move() - move a struct request from one list to another
+ * @src: The source list @rq is currently in
+ * @dst: The destination list that @rq will be appended to
+ * @rq: The request to move
+ * @prev: The request preceding @rq in @src (NULL if @rq is the head)
+ */
+static void inline rq_list_move(struct request **src, struct request **dst,
+				struct request *rq, struct request *prev)
+{
+	if (prev)
+		prev->rq_next = rq->rq_next;
+	else
+		*src = rq->rq_next;
+	rq_list_add(dst, rq);
+}
+
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
-- 
2.25.4

