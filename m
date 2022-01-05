Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F2DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiAERF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:05:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49710 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbiAERF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:05:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBD3AB81BBA
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B78C36AEF;
        Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402326;
        bh=CXd24YzqYAqII94cHDbP9cfZzq/4lctBKXJnnDewKUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3Yqw0D/U8orvCZylc01mAIK11/iuESuY1/8HoM/FNFQahnOl81G4543EUIqehYiG
         MK5dOgVdR9Egq58TI387PTAPMKZ7KShtDta7NmCewkwxdZv6lFpcVUMCG5VDkHXWLv
         V3xfFfB4asAJQKFHRMysMlVcrOW66ljGUdI93ygGhP1BAx+FBWVWXIT8d4rkkjJI1V
         c3EB0nIHTrhaic4ui+EFyYqr09gd2k9snC+0DWZsPGNzP1VfuvPKpKgJJBNF0mmR1n
         yA+6ZMNrlLSlgYQZttEoSgmPMG1kz7AK5oni9vkziCq5duC7AvG7Sm+37hoS1OsM6L
         J9WRcoD1eNKqA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/4] block: introduce rq_list_for_each_safe macro
Date:   Wed,  5 Jan 2022 09:05:16 -0800
Message-Id: <20220105170518.3181469-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While iterating a list, a particular request may need to be removed for
special handling. Provide an iterator that can safely handle that.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index bf64b94cd64e..1467f0fa2142 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -242,6 +242,10 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_list_for_each(listptr, pos)			\
 	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
 
+#define rq_list_for_each_safe(listptr, pos, nxt)			\
+	for (pos = rq_list_peek((listptr)), nxt = rq_list_next(pos);	\
+		pos; pos = nxt, nxt = pos ? rq_list_next(pos) : NULL)
+
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
-- 
2.25.4

