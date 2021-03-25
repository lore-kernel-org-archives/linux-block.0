Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585E9C43445
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CF761A27
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCYPak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCYPaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D273C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k10so3660096ejg.0
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apI8UqiXQl80nWpyflSW6p/7evZ8nOLBK4s0OAke2fw=;
        b=ETpToJDNvu3RJS7YpSfpBk1G3Pm1Z89yLabyMya7wxx7k+aeaf5/AFo6MRgg3ZEQoI
         YbUxNIL2UkAzXhCLwg50NZfjnNRIs4V85HaLgGemBHrYOb1Z+vIorxDTY7EDyU6LhPS5
         tvI2xTkLV+T3TfGZ7XClMpOVDkXxoB0p2jcbxHJS7eLFKXgXIrSIFOxg3aQ+A+VHtd82
         2OxhwegTFowsNsI2ozgZ/ZOns6+n3G9pz3RGjkboXlASMl7RViPUjZs0U3kbl4+AC938
         ggseCHOOGjQa+79dIShYqUirdvnGj1SOmyENPVukLM/3fJG8CIAvl4Tf8P2CdAZ3SvaD
         VzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apI8UqiXQl80nWpyflSW6p/7evZ8nOLBK4s0OAke2fw=;
        b=T4jbVzsN2UwzASIPCEkuGDGjDWN9baTID/xZZpbITWfdMwBcDrJTRhBDM8KEgwiygM
         4HnWRuGozz59e2wMa1ttEqmCz890rDnL1PJ+gCy6aH4kqSDk8y1bs6XPCo+wpygBmPjE
         t/OP4y18NR49WiHx5onFBneejpmURK7tqsck63gyHvKCtKmZDn+DvL55/fZS4NuyDnCN
         zb7dqsVtJUz1J5M7E8ms+x6TiBw1Pq5A56vAF/fplqMNfx0BK1N9Wl3zNuVvLA7dh/va
         ekV3GV6DifXA+dUHG6jS2Aj9uAjuah+EJ+ldvSeWAJiZJKS57UJz5ViWPDsxegoou5R7
         3i7w==
X-Gm-Message-State: AOAM5323LdyfOvrmR8AAxj7vWB9l/z+0YJO1rf3C7ywc5lB2snKuS0lm
        7CFgcJNfxBW9kYBV20uqdhLSo2BVMUzvZ8zZ
X-Google-Smtp-Source: ABdhPJxXdDs6TtC5mzYrN76qQpgE5iNa0az2je7MucqSJ96/50I6OVBlKVORWN29SNT/x/efRu7ejw==
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr9872328ejv.383.1616686209165;
        Thu, 25 Mar 2021 08:30:09 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:09 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
Subject: [PATCH for-rc 24/24] block/rnbd: Use strscpy instead of strlcpy
Date:   Thu, 25 Mar 2021 16:29:11 +0100
Message-Id: <20210325152911.1213627-25-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +++---
 drivers/block/rnbd/rnbd-clt.c       | 4 ++--
 drivers/block/rnbd/rnbd-srv.c       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index b1d04115e049..3c3172af08da 100644
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
index 4e876bceb76f..cb7c27000a45 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -583,7 +583,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_OPEN);
 	msg.access_mode	= dev->access_mode;
-	strlcpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
+	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
 
 	WARN_ON(!rnbd_clt_get_dev(dev));
 	err = send_usr_msg(sess->rtrs, READ, iu,
@@ -805,7 +805,7 @@ static struct rnbd_clt_session *alloc_sess(const char *sessname)
 	sess = kzalloc_node(sizeof(*sess), GFP_KERNEL, NUMA_NO_NODE);
 	if (!sess)
 		return ERR_PTR(-ENOMEM);
-	strlcpy(sess->sessname, sessname, sizeof(sess->sessname));
+	strscpy(sess->sessname, sessname, sizeof(sess->sessname));
 	atomic_set(&sess->busy, 0);
 	mutex_init(&sess->lock);
 	INIT_LIST_HEAD(&sess->devs_list);
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 78bd0ce0ebf0..d6ec16d7211d 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -304,7 +304,7 @@ static int create_sess(struct rtrs_srv *rtrs)
 	mutex_unlock(&sess_lock);
 
 	srv_sess->rtrs = rtrs;
-	strlcpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
+	strscpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
 
 	rtrs_srv_set_sess_priv(rtrs, srv_sess);
 
@@ -443,7 +443,7 @@ static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(const char *id)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	strlcpy(dev->id, id, sizeof(dev->id));
+	strscpy(dev->id, id, sizeof(dev->id));
 	kref_init(&dev->kref);
 	INIT_LIST_HEAD(&dev->sess_dev_list);
 	mutex_init(&dev->lock);
@@ -595,7 +595,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	kref_init(&sdev->kref);
 
-	strlcpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
+	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
 	sdev->rnbd_dev		= rnbd_dev;
 	sdev->sess		= srv_sess;
-- 
2.25.1

