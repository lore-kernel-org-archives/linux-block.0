Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E806C7EE31
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjEWHzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjEWHy4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:56 -0400
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4A10E9
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3e9xM+cFaiQk63MgyqtMwBRgFQ57bZZTtqHOWTANd0=;
        b=UMvSGsUPNoE3WYcw0sjSfjWctn2JbvrpBiRDYxWzZDSpwQKbgbmCvX0e3E4X0c7aOOaztG
        BbsYcGPfcU4akfAWqUNWtJsb5TOEb8H/wCrXuNvA2JrTiWyiBLGNPSne4X8PgYRFKLndij
        ibUG8d6JYTdZFJmKxcYBv+Lh8PMRJuw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 06/10] block/rnbd-srv: rename one member in rnbd_srv_dev
Date:   Tue, 23 May 2023 15:53:27 +0800
Message-Id: <20230523075331.32250-7-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It actually represents the name of rnbd_srv_dev.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 14 +++++++-------
 drivers/block/rnbd/rnbd-srv.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index b4c880759a52..e51eb4b7f6e6 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -176,7 +176,7 @@ static void destroy_device(struct kref *kref)
 
 	WARN_ONCE(!list_empty(&dev->sess_dev_list),
 		  "Device %s is being destroyed but still in use!\n",
-		  dev->id);
+		  dev->name);
 
 	spin_lock(&dev_lock);
 	list_del(&dev->list);
@@ -427,7 +427,7 @@ static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(struct block_device *bdev)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	snprintf(dev->id, sizeof(dev->id), "%pg", bdev);
+	snprintf(dev->name, sizeof(dev->name), "%pg", bdev);
 	kref_init(&dev->kref);
 	INIT_LIST_HEAD(&dev->sess_dev_list);
 	mutex_init(&dev->lock);
@@ -442,7 +442,7 @@ rnbd_srv_find_or_add_srv_dev(struct rnbd_srv_dev *new_dev)
 
 	spin_lock(&dev_lock);
 	list_for_each_entry(dev, &dev_list, list) {
-		if (!strncmp(dev->id, new_dev->id, sizeof(dev->id))) {
+		if (!strncmp(dev->name, new_dev->name, sizeof(dev->name))) {
 			if (!kref_get_unless_zero(&dev->kref))
 				/*
 				 * We lost the race, device is almost dead.
@@ -477,7 +477,7 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 			ret = 0;
 		} else {
 			pr_err("Mapping device '%s' for session %s with RW permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
-			       srv_dev->id, srv_sess->sessname,
+			       srv_dev->name, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
 			       rnbd_access_modes[access_mode].str);
 		}
@@ -488,14 +488,14 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 			ret = 0;
 		} else {
 			pr_err("Mapping device '%s' for session %s with migration permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
-			       srv_dev->id, srv_sess->sessname,
+			       srv_dev->name, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
 			       rnbd_access_modes[access_mode].str);
 		}
 		break;
 	default:
 		pr_err("Received mapping request for device '%s' on session %s with invalid access mode: %d\n",
-		       srv_dev->id, srv_sess->sessname, access_mode);
+		       srv_dev->name, srv_sess->sessname, access_mode);
 		ret = -EINVAL;
 	}
 
@@ -770,7 +770,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
 	mutex_unlock(&srv_dev->lock);
 
-	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->id);
+	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name);
 
 	kfree(full_path);
 
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index f5962fd31d62..6b5e5ade18ae 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -35,7 +35,7 @@ struct rnbd_srv_dev {
 	struct kobject                  dev_kobj;
 	struct kobject                  *dev_sessions_kobj;
 	struct kref                     kref;
-	char				id[NAME_MAX];
+	char				name[NAME_MAX];
 	/* List of rnbd_srv_sess_dev structs */
 	struct list_head		sess_dev_list;
 	struct mutex			lock;
-- 
2.35.3

