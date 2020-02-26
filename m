Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80933C4BA13
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6112824698
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBZLLt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:11:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727891AbgBZLLs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FC2E719D1F313B2E02F;
        Wed, 26 Feb 2020 19:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:41 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 4/7] bdi: create a new function bdi_get_dev_name()
Date:   Wed, 26 Feb 2020 19:18:48 +0800
Message-ID: <20200226111851.55348-5-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We prepare a new function bdi_get_dev_name() to copy device
kobj->name into buffer passed by caller. The function is covered
by RCU. Thus, caller can access ->dev and copy integral device name.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/linux/backing-dev.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 67e429b203a1..89d1cb7923f5 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -514,4 +514,29 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
 	return dev_name(&bdi->rcu_dev->dev);
 }
 
+/**
+ * bdi_get_dev_name - copy bdi device name into buffer
+ * @bdi: target bdi
+ * @dname: Where to copy the device name to
+ * @len: size of destination buffer
+ */
+static inline void bdi_get_dev_name(struct backing_dev_info *bdi,
+			char *dname, int len)
+{
+	struct bdi_rcu_device *rcu_dev;
+
+	if (!bdi) {
+		strlcpy(dname, bdi_unknown_name, len);
+		return;
+	}
+
+	rcu_read_lock();
+
+	rcu_dev = rcu_dereference(bdi->rcu_dev);
+	strlcpy(dname, rcu_dev ? dev_name(&rcu_dev->dev) :
+			bdi_unknown_name, len);
+
+	rcu_read_unlock();
+}
+
 #endif	/* _LINUX_BACKING_DEV_H */
-- 
2.16.2.dirty

