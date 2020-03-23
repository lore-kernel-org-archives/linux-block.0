Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3131C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8894320735
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgCWN0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:26:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728344AbgCWN0G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 09:26:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF0DCD6CE5994E5528E7;
        Mon, 23 Mar 2020 21:25:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Mar 2020
 21:25:28 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/4] bdi: add new bdi_get_dev_name()
Date:   Mon, 23 Mar 2020 21:22:52 +0800
Message-ID: <20200323132254.47157-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200323132254.47157-1-yuyufen@huawei.com>
References: <20200323132254.47157-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We add this new function to copy device name into buffer.
This is prepare for following patch.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/linux/backing-dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f88197c1ffc2..82d2401fec37 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -19,6 +19,8 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
+#define BDI_DEV_NAME_LEN	32
+
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
@@ -514,4 +516,21 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
 	return dev_name(bdi->dev);
 }
 
+/**
+ * bdi_get_dev_name - copy bdi device name into buffer
+ * @bdi: target bdi
+ * @dname: Where to copy the device name to
+ * @len: size of destination buffer
+ */
+static inline char *bdi_get_dev_name(struct backing_dev_info *bdi,
+			char *dname, int len)
+{
+	if (!bdi || !bdi->dev) {
+		strlcpy(dname, bdi_unknown_name, len);
+		return NULL;
+	}
+
+	strlcpy(dname, dev_name(bdi->dev), len);
+	return dname;
+}
 #endif	/* _LINUX_BACKING_DEV_H */
-- 
2.17.2

