Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507CC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 07:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6EF64F67
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 07:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhBDHIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 02:08:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12021 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhBDHIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 02:08:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWV2t46yCzjJqp;
        Thu,  4 Feb 2021 15:06:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 15:07:42 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v4 2/2] nbd: share exception handling code by goto put_nbd
Date:   Thu, 4 Feb 2021 02:09:10 -0500
Message-ID: <20210204070910.1401239-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210204070910.1401239-1-sunke32@huawei.com>
References: <20210204070910.1401239-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the following two statements by the statement “goto put_nbd;”

	nbd_put(nbd);
	return 0;

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3c9b3bf3f4c2..ecae81e43122 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2029,12 +2029,11 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	}
 	mutex_unlock(&nbd->config_lock);
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

