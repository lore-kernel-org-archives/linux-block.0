Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A7C43462
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7481D61131
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350873AbhDNMYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350878AbhDNMYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC68C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 18so23472978edx.3
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ePz6lp1H8XPms57626BqgZS+4gSQvoWIqmoz2pSCAg=;
        b=cGEsOECRqpKH5ERgwCQTLmZ6kD9QYyB4CQzE4B9irNl+BJz6ACovjTAK9b+HNaT6Tp
         yD6YThWX5CfGWavyTU9IaBUHPJEyFHLMa4uz31xHmvHdpqTKGpom4l6qkYZBAYbIwvH/
         pVe8g2j6D0cH8f/x22DHHoO3p2QTfpveco/06X733PiUNJoGnJIqtx8RsEXVlbmyaTVx
         2q0/VhVqmmBoAQjd+EqsSD2bvtbkU/S6Qxnit401icUuuQyD936a/GERW+RexyE9G2bP
         SMQW2Z2kBAkSryJgDhPVw239DgXBbyLSfKZosTIy6KxlnlAFbnjyF8EXqF8mNSBlK2wV
         323Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ePz6lp1H8XPms57626BqgZS+4gSQvoWIqmoz2pSCAg=;
        b=OoiqIRiSixOGw+GT3Jpugaj5Cl6jEyqOxaL0ELdrl/AjDAeGbRh/R9J3cRu8TQZa1P
         0xVePTd5tOf/NXvRBT6z3ia7ky/vcsYw6QWBNmBqkwPKCitGv67YiJh1euFKIlaHhIrp
         6hxnWtK4/pls+iRbsau91TgEt/5ZqqECYx5CdB3oYqd+P/mCtG+XMWGQGTyK33FdLhvw
         Zp33rWhCiBHK1pS0rfAyg6VKUL8nv1eCT9Kp9u9TSBYyp81EGD96kjeVdXbqLoVgMkAL
         3aXRc0hutFJwfiAUj8bRQL2m276yYiNK7XMib3rgM0V5uDQwO+hR/5hwx7pR+cqxzTpv
         ABkg==
X-Gm-Message-State: AOAM531q7l6TYUiYMHuvnuo7joKu+5OW4ZTfOI/M5uriz4EFIZiqp0sY
        QTn1se3X/xJPwjlUDGVR0dLEyi5nTe7/ZZS8
X-Google-Smtp-Source: ABdhPJzADE24Zlixulbf74kbQHh2H6gLmr7R4izgF9BOaRE2pA6QiXNWCleMp0nr0g9uXarrs7QvPA==
X-Received: by 2002:aa7:cc94:: with SMTP id p20mr41239430edt.353.1618403065323;
        Wed, 14 Apr 2021 05:24:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 19/19] block/rnbd: Use strscpy instead of strlcpy
Date:   Wed, 14 Apr 2021 14:24:02 +0200
Message-Id: <20210414122402.203388-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

During checkpatch analyzing the following warning message was found:
  WARNING:STRLCPY: Prefer strscpy over strlcpy - see:
  https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Fix it by using strscpy calls instead of strlcpy.

Signed-off-by: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +++---
 drivers/block/rnbd/rnbd-clt.c       | 4 ++--
 drivers/block/rnbd/rnbd-srv.c       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 062c52e7a468..66316cdc2a92 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -99,7 +99,7 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
 				kfree(p);
 				goto out;
 			}
-			strlcpy(opt->sessname, p, NAME_MAX);
+			strscpy(opt->sessname, p, NAME_MAX);
 			kfree(p);
 			break;
 
@@ -142,7 +142,7 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
 				kfree(p);
 				goto out;
 			}
-			strlcpy(opt->pathname, p, NAME_MAX);
+			strscpy(opt->pathname, p, NAME_MAX);
 			kfree(p);
 			break;
 
@@ -511,7 +511,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	int ret;
 	char pathname[NAME_MAX], *s;
 
-	strlcpy(pathname, dev->pathname, sizeof(pathname));
+	strscpy(pathname, dev->pathname, sizeof(pathname));
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 7446660eb7f2..76556fd6f153 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -578,7 +578,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_OPEN);
 	msg.access_mode	= dev->access_mode;
-	strlcpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
+	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
 
 	WARN_ON(!rnbd_clt_get_dev(dev));
 	err = send_usr_msg(sess->rtrs, READ, iu,
@@ -800,7 +800,7 @@ static struct rnbd_clt_session *alloc_sess(const char *sessname)
 	sess = kzalloc_node(sizeof(*sess), GFP_KERNEL, NUMA_NO_NODE);
 	if (!sess)
 		return ERR_PTR(-ENOMEM);
-	strlcpy(sess->sessname, sessname, sizeof(sess->sessname));
+	strscpy(sess->sessname, sessname, sizeof(sess->sessname));
 	atomic_set(&sess->busy, 0);
 	mutex_init(&sess->lock);
 	INIT_LIST_HEAD(&sess->devs_list);
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index abacd9ef10d6..899dd9d7c10b 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -298,7 +298,7 @@ static int create_sess(struct rtrs_srv *rtrs)
 	mutex_unlock(&sess_lock);
 
 	srv_sess->rtrs = rtrs;
-	strlcpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
+	strscpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
 
 	rtrs_srv_set_sess_priv(rtrs, srv_sess);
 
@@ -437,7 +437,7 @@ static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(const char *id)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	strlcpy(dev->id, id, sizeof(dev->id));
+	strscpy(dev->id, id, sizeof(dev->id));
 	kref_init(&dev->kref);
 	INIT_LIST_HEAD(&dev->sess_dev_list);
 	mutex_init(&dev->lock);
@@ -589,7 +589,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	kref_init(&sdev->kref);
 
-	strlcpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
+	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
 	sdev->rnbd_dev		= rnbd_dev;
 	sdev->sess		= srv_sess;
-- 
2.25.1

