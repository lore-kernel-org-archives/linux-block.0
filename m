Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA50C64E7C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0E52158C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Iww8gclc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbgKZKrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbgKZKrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEEC0617A7
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:30 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so2259058ejj.5
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nScNWpcvWCbr9GrL76w7aGhuZfbqsjrDUOvB71U8dg8=;
        b=Iww8gclc9LmTtuenEOthHM14L/k5WIoRTAk6KUaPwNV0L9C8AUtqPNjZd7Pp0JfbU2
         /ovdkwyxkXy83L3IsoIw8/1SH+0v401h5+De5dXfjoZlLX2d1tiSp4N7Oro+LaAcnDeq
         JEe28b0/O/dTFYzVFQMap0ntRKW9MHd8+smQ1Lg2cvN0o/3O+7cIFfyofkGdmSpSSjNd
         aDB5qhi3km+GUOxMVvIE1+tjjIVIrEoOdFqCLPQjnCxVVdM/Ja3yCgoTK66E7WgGhop3
         iF7g1QYfdGUjOYUkABWpblj7yLCsWSL4TOjs/38NoDYubjRQ6czxR0a8mzju0yTe51ui
         uqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nScNWpcvWCbr9GrL76w7aGhuZfbqsjrDUOvB71U8dg8=;
        b=tX5rLrsnmyYWs9h7M0/XrjRkwtAidg8fA4h7R/KhCkX0uvT6lXouoBe3LwJXoNuPVx
         rqnU9j84wDkVrVhONR2eGU0ki9fwDZfi5aixKGfpmtaiPnX97FPxO7joBNteqHN7UMfN
         qDJhMBr16IMGqLAgn962CWIm1IwgRkm1UuHoF5WXn1JBBIXmk4r+ewdC2aOB29TUYabR
         gGzyHOeRRZVSgGBWendEMnqlf6wgT6MzXl3tvg07LJwhoP6hQyPwR62OJ2OuM4kPbiL2
         QcN5EPpZyGWvZQoJe68hZdZTvekXImjsD9gnUAXikTpmWflfJt1f9fxuhRDRWJhZZop6
         8uRg==
X-Gm-Message-State: AOAM5334qmS2YfHBN1EFSShfVRThe7StDLHXhq7p3qqn4g1QcMdI9TU8
        sqzeV3C6e7rqo20LQI0YmLtHjp1/1OBlow==
X-Google-Smtp-Source: ABdhPJx60qB6RglE6+ICc0AAzUmB43Ch2I8WiLFqh2gVgdNB1+wwp990Tg6XnJR01n7gyQs98a2/JQ==
X-Received: by 2002:a17:906:b18:: with SMTP id u24mr2126860ejg.501.1606387649335;
        Thu, 26 Nov 2020 02:47:29 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 5/8] block/rnbd-srv: close a mapped device from server side.
Date:   Thu, 26 Nov 2020 11:47:20 +0100
Message-Id: <20201126104723.150674-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>

The forceful close of an exported device is required
for the use case, when the client side hangs, is crashed,
or is not accessible.

There have been cases observed, where only some of
the devices are to be cleaned up, but the session shall
remain.

When the device is to be exported to a different
client host, server side cleanup is required.

Signed-off-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 38 ++++++++++++++++++++++++++++-
 drivers/block/rnbd/rnbd-srv.c       | 19 +++++++++++++--
 drivers/block/rnbd/rnbd-srv.h       |  4 ++-
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 106775c074d1..08ffb492ebfa 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -120,10 +120,46 @@ static ssize_t mapping_path_show(struct kobject *kobj,
 static struct kobj_attribute rnbd_srv_dev_session_mapping_path_attr =
 	__ATTR_RO(mapping_path);
 
+static ssize_t rnbd_srv_dev_session_force_close_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_srv_dev_session_force_close_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+
+	if (!sysfs_streq(buf, "1")) {
+		rnbd_srv_err(sess_dev, "%s: invalid value: '%s'\n",
+			      attr->attr.name, buf);
+		return -EINVAL;
+	}
+
+	rnbd_srv_info(sess_dev, "force close requested\n");
+
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
+	rnbd_srv_sess_dev_force_close(sess_dev);
+
+	return count;
+}
+
+static struct kobj_attribute rnbd_srv_dev_session_force_close_attr =
+	__ATTR(force_close, 0644,
+	       rnbd_srv_dev_session_force_close_show,
+	       rnbd_srv_dev_session_force_close_store);
+
 static struct attribute *rnbd_srv_default_dev_sessions_attrs[] = {
 	&rnbd_srv_dev_session_access_mode_attr.attr,
 	&rnbd_srv_dev_session_ro_attr.attr,
 	&rnbd_srv_dev_session_mapping_path_attr.attr,
+	&rnbd_srv_dev_session_force_close_attr.attr,
 	NULL,
 };
 
@@ -145,7 +181,7 @@ static void rnbd_srv_sess_dev_release(struct kobject *kobj)
 	struct rnbd_srv_sess_dev *sess_dev;
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
-	rnbd_destroy_sess_dev(sess_dev);
+	rnbd_destroy_sess_dev(sess_dev, sess_dev->keep_id);
 }
 
 static struct kobj_type rnbd_srv_sess_dev_ktype = {
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index e1bc8b4cd592..d1ee72ed8384 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -212,12 +212,20 @@ static void rnbd_put_srv_dev(struct rnbd_srv_dev *dev)
 	kref_put(&dev->kref, destroy_device_cb);
 }
 
-void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev)
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 {
 	DECLARE_COMPLETION_ONSTACK(dc);
 
-	xa_erase(&sess_dev->sess->index_idr, sess_dev->device_id);
+	if (keep_id)
+		/* free the resources for the id but don't  */
+		/* allow to re-use the id itself because it */
+		/* is still used by the client              */
+		xa_cmpxchg(&sess_dev->sess->index_idr, sess_dev->device_id,
+			   sess_dev, NULL, 0);
+	else
+		xa_erase(&sess_dev->sess->index_idr, sess_dev->device_id);
 	synchronize_rcu();
+
 	sess_dev->destroy_comp = &dc;
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
@@ -328,6 +336,13 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 	}
 }
 
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
+{
+	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	sess_dev->keep_id = true;
+
+}
+
 static int process_msg_close(struct rtrs_srv *rtrs,
 			     struct rnbd_srv_session *srv_sess,
 			     void *data, size_t datalen, const void *usr,
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 5a8544b5e74f..b157371c25ed 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -56,6 +56,7 @@ struct rnbd_srv_sess_dev {
 	struct rnbd_srv_dev		*dev;
 	struct kobject                  kobj;
 	u32                             device_id;
+	bool				keep_id;
 	fmode_t                         open_flags;
 	struct kref			kref;
 	struct completion               *destroy_comp;
@@ -63,6 +64,7 @@ struct rnbd_srv_sess_dev {
 	enum rnbd_access_mode		access_mode;
 };
 
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev);
 /* rnbd-srv-sysfs.c */
 
 int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
@@ -73,6 +75,6 @@ int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
 void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
 int rnbd_srv_create_sysfs_files(void);
 void rnbd_srv_destroy_sysfs_files(void);
-void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id);
 
 #endif /* RNBD_SRV_H */
-- 
2.25.1

