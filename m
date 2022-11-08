Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2352CC43219
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiKHEwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiKHEwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:52:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D61C909;
        Mon,  7 Nov 2022 20:52:32 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5wgV4YjwzHvfn;
        Tue,  8 Nov 2022 12:52:06 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:29 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 04/10] block, bfq: use helper macro RQ_BFQQ to get bfqq of request
Date:   Tue, 8 Nov 2022 12:52:18 +0800
Message-ID: <20221108045224.19092-5-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221108045224.19092-1-shikemeng@huawei.com>
References: <20221108045224.19092-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use helper macro RQ_BFQQ to get bfqq of request.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 01fa16047eb5..2c4fe286ead7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6748,14 +6748,14 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		return NULL;
 
 	/*
-	 * Assuming that elv.priv[1] is set only if everything is set
+	 * Assuming that RQ_BFQQ(rq) is set only if everything is set
 	 * for this rq. This holds true, because this function is
 	 * invoked only for insertion or merging, and, after such
 	 * events, a request cannot be manipulated any longer before
 	 * being removed from bfq.
 	 */
-	if (rq->elv.priv[1])
-		return rq->elv.priv[1];
+	if (RQ_BFQQ(rq))
+		return RQ_BFQQ(rq);
 
 	bic = icq_to_bic(rq->elv.icq);
 
-- 
2.30.0

