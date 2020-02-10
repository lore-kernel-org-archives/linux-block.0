Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881ACC352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3E20870
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 07:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgBJHd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:33:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgBJHd4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 02:33:56 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 28D5B2F7CEFFAE2091B8;
        Mon, 10 Feb 2020 15:33:50 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 15:33:41 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <mchristi@redhat.com>,
        <sunke32@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [v3] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
Date:   Mon, 10 Feb 2020 15:32:41 +0800
Message-ID: <20200210073241.41813-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open /dev/nbdX first, the config_refs will be 1 and
the pointers in nbd_device are still null. Disconnect
/dev/nbdX, then reference a null recv_workq. The
protection by config_refs in nbd_genl_disconnect is useless.

To fix it, just add a check for a non null task_recv in
nbd_genl_disconnect.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v1 -> v2:
Add an omitted mutex_unlock.

v2 -> v3:
Add nbd->config_lock, suggested by Josef.
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b4607dd96185..870b3fd0c101 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2008,12 +2008,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+	mutex_lock(&nbd->config_lock);
 	if (!refcount_inc_not_zero(&nbd->refs)) {
+		mutex_unlock(&nbd->config_lock);
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
+	if (!nbd->recv_workq) {
+		mutex_unlock(&nbd->config_lock);
+		mutex_unlock(&nbd_index_mutex);
+		return -EINVAL;
+	}
+	mutex_unlock(&nbd->config_lock);
 	mutex_unlock(&nbd_index_mutex);
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		nbd_put(nbd);
-- 
2.17.2

