Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EEEC433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9E8610FD
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 12:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbhIXMZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245047AbhIXMZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 08:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632486256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WM6qzuajtDerx7+xJbX90UnsPZusQ5oE4A/EzIJi6m8=;
        b=ci6q9erGpTSvvynbEXSd1TOpMyu3sSPN44S/vBF7Xnx9aH9bl6G5DNnYOPkK0iccYawsDi
        yVGxJk8OcoVey4DLACiwvtg2yPPhgqxHY7F9hQFc0cI+A4RVnkx1jXlunwAV0XsQ5fjjsu
        RxL+0eCj9+GRE3KlXXFCvGoAIC4fZF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-hTWUkiV3Oyel7UoG2cjRwg-1; Fri, 24 Sep 2021 08:24:15 -0400
X-MC-Unique: hTWUkiV3Oyel7UoG2cjRwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4E0835DE0;
        Fri, 24 Sep 2021 12:24:14 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6ECF19C87;
        Fri, 24 Sep 2021 12:24:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Tejun Heo <tj@kernel.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH] block: only allocate blkcg->fc_app_id when starting to use it
Date:   Fri, 24 Sep 2021 20:24:16 +0800
Message-Id: <20210924122416.1552721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far the feature of BLK_CGROUP_FC_APPID is only used for LPFC, and
only when it is setup via sysfs. It is very likely for one system to
never use the feature, so allocate the application id buffer in case
that someone starts to use it, then we save 129 bytes in each blkcg
if no one uses the feature.

Cc: Muneendra Kumar <muneendra.kumar@broadcom.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c         |  3 +++
 include/linux/blk-cgroup.h | 15 ++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 38b9f7684952..e452adf5f4f6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1061,6 +1061,9 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 
 	mutex_unlock(&blkcg_pol_mutex);
 
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+	kfree(blkcg->fc_app_id);
+#endif
 	kfree(blkcg);
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b4de2010fba5..75094c0a752b 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -58,7 +58,7 @@ struct blkcg {
 
 	struct list_head		all_blkcgs_node;
 #ifdef CONFIG_BLK_CGROUP_FC_APPID
-	char                            fc_app_id[FC_APPID_LEN];
+	char                            *fc_app_id;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
@@ -699,7 +699,16 @@ static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_le
 	 * the vmid from the fabric.
 	 * Adding the overhead of a lock is not necessary.
 	 */
-	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	if (!blkcg->fc_app_id) {
+		char *buf = kzalloc(FC_APPID_LEN, GFP_KERNEL);
+
+		if (cmpxchg(&blkcg->fc_app_id, NULL, buf))
+			kfree(buf);
+	}
+	if (blkcg->fc_app_id)
+		strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	else
+		ret = -ENOMEM;
 	css_put(css);
 out_cgrp_put:
 	cgroup_put(cgrp);
@@ -714,7 +723,7 @@ static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_le
  */
 static inline char *blkcg_get_fc_appid(struct bio *bio)
 {
-	if (bio && bio->bi_blkg &&
+	if (bio && bio->bi_blkg && bio->bi_blkg->blkcg->fc_app_id &&
 		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
 		return bio->bi_blkg->blkcg->fc_app_id;
 	return NULL;
-- 
2.31.1

