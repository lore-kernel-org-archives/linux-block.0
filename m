Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B9C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8406C613D6
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhELLhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 07:37:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2716 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhELLhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 07:37:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgCN96dqwz1BLVZ;
        Wed, 12 May 2021 19:33:29 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 19:35:59 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH 2/2] nbd: share nbd_put and return by goto put_nbd
Date:   Wed, 12 May 2021 19:43:31 +0800
Message-ID: <20210512114331.1233964-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210512114331.1233964-1-sunke32@huawei.com>
References: <20210512114331.1233964-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the following two statements by the statement “goto put_nbd;”

	nbd_put(nbd);
	return 0;

Signed-off-by: Sun Ke <sunke32@huawei.com>
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 974da561b8e5..45d2c28c8fc8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2015,12 +2015,11 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	mutex_unlock(&nbd_index_mutex);
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
-		nbd_put(nbd);
-		return 0;
-	}
+	if (!refcount_inc_not_zero(&nbd->config_refs))
+		goto put_nbd;
 	nbd_disconnect_and_put(nbd);
 	nbd_config_put(nbd);
+put_nbd:
 	nbd_put(nbd);
 	return 0;
 }
-- 
2.25.4

