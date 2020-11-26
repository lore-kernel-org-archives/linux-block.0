Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59972C64E7D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA9721527
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QSRGZm4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgKZKre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgKZKrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:33 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F34C0617A7
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:33 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so1812562edl.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4cvh6HyOuMNhHZbDU7N8V5pKfLuDMvs/XUaQs3r6Mgo=;
        b=QSRGZm4LWcLrV18IP8RyMgz8YSZ1BOaXwqudeV3nmtr/yyHNO3HwkN1zbHbuPzPgAx
         ifmg+7LH9YKC+v902Xzt/6RYPr3dxQdVQfMDPil5iv21N381eLSrz5N6iGhihJflyRhs
         LMu6yCW676GrRofZ7HTU83iFeTKN9D13ZuHrI/pRXRHYKci2XHlTH94702fIM6gXEm8G
         HOrUaYFAktNrb4tuBX1Xz9ypiD6+ZZtFuxkzs9T/75LXPtu3UY2DoO5lYnkKlhLwJ5NS
         m4JojMtRoLgR85luuHeAKogCbl1VItLPKkWAUOvLBNpMyZz3L31+EimWKdw1pTZU7YWB
         Sn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cvh6HyOuMNhHZbDU7N8V5pKfLuDMvs/XUaQs3r6Mgo=;
        b=tcKKxwOK7nekuacfDAtEFoHP093PMpGmTG6FQ0b3RkO/0aOxwioWkxHpLSyfV8evAw
         RKg+UkLi0GdUPb6ONz7kSNBO9zzU5n8VfKg7g1VmCOThvhuUDS95a8vC6uyyQO8tmecj
         /VLSRfFUuvMhEnpKieKCYRN1mjG6jeVxpktgEnFMEQVs8tNJIvCd2fBT7EhWJEp62C9o
         TlFdBmPGkSde9NBMDTob5oogd5D9B3kz986YljC5F8SK8z0F6LRTp0MvD87jWR+h9ofB
         Ii/banv9DsZUfZ2YW7Ju87EOhqJIj2VlzBOodiO3jvNe/NefXED81P1a4Qof6sMGTZqx
         dQsw==
X-Gm-Message-State: AOAM53381DkhQSG+sLoWORAeME2DmrCZZEdcx2PGIy/CD6IO2qcI4PKj
        qWssPaa1OCVwRsmWSiRylAnKXRCAyYTl0Q==
X-Google-Smtp-Source: ABdhPJztqAjyBMAx1ImaIT5o/MfvoiimNXM1RYHKOOUyjR6fl/9GRChdDtF4kuTkESvXsz4/h/fMjg==
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr1907624edb.245.1606387652067;
        Thu, 26 Nov 2020 02:47:32 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:31 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCH for-next 8/8] block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name
Date:   Thu, 26 Nov 2020 11:47:23 +0100
Message-Id: <20201126104723.150674-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

For every rnbd_clt_dev, we alloc the pathname and blk_symlink_name
statically to NAME_MAX which is 255 bytes. In most of the cases we only
need less than 10 bytes, so 500 bytes per block device are wasted.

This commit dynamically allocates memory buffer for pathname and
blk_symlink_name.

Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 12 ++++++++++--
 drivers/block/rnbd/rnbd-clt.c       | 14 +++++++++++---
 drivers/block/rnbd/rnbd-clt.h       |  4 ++--
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index e3c3270b0cee..c3c96a567568 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -434,6 +434,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	 */
 	if (strlen(dev->blk_symlink_name) && try_module_get(THIS_MODULE)) {
 		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+		kfree(dev->blk_symlink_name);
 		module_put(THIS_MODULE);
 	}
 }
@@ -492,10 +493,17 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
 {
 	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
-	int ret;
+	int ret, len;
+
+	len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
+	dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
+	if (!dev->blk_symlink_name) {
+		rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
+		goto out_err;
+	}
 
 	ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
-				      sizeof(dev->blk_symlink_name));
+				      len);
 	if (ret) {
 		rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
 			      ret);
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 1bb495e50931..34bc6083b58d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -59,6 +59,7 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
 	ida_simple_remove(&index_ida, dev->clt_device_id);
 	mutex_unlock(&ida_lock);
 	kfree(dev->hw_queues);
+	kfree(dev->pathname);
 	rnbd_clt_put_sess(dev->sess);
 	mutex_destroy(&dev->lock);
 	kfree(dev);
@@ -1387,10 +1388,17 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		       pathname, sess->sessname, ret);
 		goto out_queues;
 	}
+
+	dev->pathname = kzalloc(strlen(pathname) + 1, GFP_KERNEL);
+	if (!dev->pathname) {
+		ret = -ENOMEM;
+		goto out_queues;
+	}
+	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
+
 	dev->clt_device_id	= ret;
 	dev->sess		= sess;
 	dev->access_mode	= access_mode;
-	strlcpy(dev->pathname, pathname, sizeof(dev->pathname));
 	mutex_init(&dev->lock);
 	refcount_set(&dev->refcount, 1);
 	dev->dev_state = DEV_STATE_INIT;
@@ -1422,8 +1430,8 @@ static bool __exists_dev(const char *pathname, const char *sessname)
 			continue;
 		mutex_lock(&sess->lock);
 		list_for_each_entry(dev, &sess->devs_list, list) {
-			if (!strncmp(dev->pathname, pathname,
-				     sizeof(dev->pathname))) {
+			if (strlen(dev->pathname) == strlen(pathname) &&
+			    !strcmp(dev->pathname, pathname)) {
 				found = true;
 				break;
 			}
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index ed33654aa486..b193d5904050 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -108,7 +108,7 @@ struct rnbd_clt_dev {
 	u32			clt_device_id;
 	struct mutex		lock;
 	enum rnbd_clt_dev_state	dev_state;
-	char			pathname[NAME_MAX];
+	char			*pathname;
 	enum rnbd_access_mode	access_mode;
 	bool			read_only;
 	bool			rotational;
@@ -126,7 +126,7 @@ struct rnbd_clt_dev {
 	struct list_head        list;
 	struct gendisk		*gd;
 	struct kobject		kobj;
-	char			blk_symlink_name[NAME_MAX];
+	char			*blk_symlink_name;
 	refcount_t		refcount;
 	struct work_struct	unmap_on_rmmod_work;
 };
-- 
2.25.1

