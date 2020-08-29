Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C464C433E6
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F94220791
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 09:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgH2Jiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 05:38:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbgH2Jix (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 05:38:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18FB52DB5BFE21E2EF9B;
        Sat, 29 Aug 2020 17:38:51 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 17:38:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: bio: Trim bio to sensible size in bio_trim()
Date:   Sat, 29 Aug 2020 05:37:33 -0400
Message-ID: <20200829093733.45833-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trim bio to sensible size in bio_trim() or something bad may happen.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..94e4f97d3d4e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1509,7 +1509,8 @@ void bio_trim(struct bio *bio, int offset, int size)
 		return;
 
 	bio_advance(bio, offset << 9);
-	bio->bi_iter.bi_size = size;
+	if (likely(bio->bi_iter.bi_size >= size))
+		bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
 		bio_integrity_trim(bio);
-- 
2.19.1

