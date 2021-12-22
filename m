Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7293AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhLVVwo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:52:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35972 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbhLVVwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 16:52:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 212D5B81D17
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 21:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB39C36AE8;
        Wed, 22 Dec 2021 21:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640209961;
        bh=TRPaF3ET+3tv7R9DSMssYX7C0fD3j7Op/HrutG9nIsg=;
        h=From:To:Cc:Subject:Date:From;
        b=F8fdMqBpehMmP47elRPWEEhEDBZqO68Dyehk2gFttzsKFae4wQJghD/sPoYI2po8w
         /TMeqT6Ve78ecEZhe4LqvW0B4yxJ28hv0qYUgd6JonirCImORsyQc2iF7GO60Q1alE
         ur0rbFVfOaXIjwsWDlkjaReO1eNXhCtjktQ5usSnHLeWNGAiqHGZBVZfpwq9xZrF9d
         aRwj5DOvo4yOpjWMdB7Pt50wEXTpX7ys7OediXfNK3DTXw8nSzWwrKM2JCYJljEVx1
         Zzxv33vt4ih4pXvRm/XLZ92a4fkIqtHkaxWeNTaYkTkBjhqTtN5qg5ctoUzveOu20g
         9ApYMV37hY51Q==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: remove unnecessary trailing '\'
Date:   Wed, 22 Dec 2021 13:52:39 -0800
Message-Id: <20211222215239.1768164-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While harmless, the blank line is certainly not intended to be part of
the rq_list_for_each() macro. Remove it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5fb7282e6e..22746b2d6825 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1363,7 +1363,7 @@ struct io_comp_batch {
 })
 
 #define rq_list_for_each(listptr, pos)			\
-	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos)) \
+	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
 
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
-- 
2.25.4

