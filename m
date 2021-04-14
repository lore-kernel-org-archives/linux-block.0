Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E5C43462
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6161107
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbhDNMYl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350858AbhDNMYk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E4C061756
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so31147813ejc.4
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WusjvsYw5StKARzVGPy5VqECBTOsgPT1toBxn5pBW8=;
        b=b7TiuO7/bxORRnGzdGleS17uNYFwxnL8LtYsfLrECcsZZm/juxBVED1GV55vQV3lyZ
         u8vzDtWBBEdSdufXqLaVmKZMgZEuEWcZoHbq/LuL5qqOJmYKIc/FpxFR/YEiDXdzOVB8
         yYfC0Dhe8Jm976fA9F6BMYzcNfXV4SUMXOqDLhG0x6VbvqDxVhoq1yFLt+eXiFHAAwH7
         r/uY58l+FIVS3+D3dTJB16wc1lbFkmEkaIFAe2nupr2CIQB44SeRq2gzVNBZ1XzXf1Ea
         R9AYrd9J1lcWF3MOXPWsxgjwNiv4w71Rm+88sISAHERm0mGmkvhtdUGgEkRUtsj8yRXU
         oXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WusjvsYw5StKARzVGPy5VqECBTOsgPT1toBxn5pBW8=;
        b=LfXNunjGJG+HY1A+Ss82tDERoNGMgEu1Hvt0kyACFNGofr/QegFGjsk1nKaDnGrusS
         2eBZRTpuLHGcfso+nOzGEvegAEq5A03Bx4/rKstWxaT/d2u0y4Kd9CvjVWdMDVCtzVk8
         i/MuTPgnz80/fEWjzOMrwHZf6ujvCpnzVGs4cXZNdbv9IbY7YS4J5wSU07wf3hP+KJoU
         AdjQ+UfpZ9+Ji7OH5KtGBJjCJIySo21bDZeAmSH7Nf4AFfb2vt6QphjmJqG2GND3Rotc
         1buEXA4Wc8MvbN7ZB+BLi1Ub2FDMNpSmodiSYRKeevqUOwuAyYKvUtcX9RPh40uD546d
         upoQ==
X-Gm-Message-State: AOAM532JZZ+l2Uf2wh2aKZMgXW6JkRGc6RmElAzKoeyQOXFLxIRXvWsw
        yk9iXbFfusBlc24ovzgr8P9p+GPgj+O5L979
X-Google-Smtp-Source: ABdhPJx1PgaMnJwZR6bBocN/ZLJs/D6E+6A8oh52rdSpoKkJhCawQb2m1jsPC4RIwjQa/jeaphD/zQ==
X-Received: by 2002:a17:906:dfd6:: with SMTP id jt22mr20830400ejc.161.1618403057920;
        Wed, 14 Apr 2021 05:24:17 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:17 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv4 for-next 10/19] block/rnbd-srv: Remove force_close file after holding a lock
Date:   Wed, 14 Apr 2021 14:23:53 +0200
Message-Id: <20210414122402.203388-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

We changed the rnbd_srv_sess_dev_force_close to use try-lock
because rnbd_srv_sess_dev_force_close and process_msg_close
can generate a deadlock.

Now rnbd_srv_sess_dev_force_close would do nothing
if it fails to get the lock. So removing the force_close
file should be moved to after the lock. Or the force_close
file is removed but the others are not removed.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 5 +----
 drivers/block/rnbd/rnbd-srv.c       | 5 ++++-
 drivers/block/rnbd/rnbd-srv.h       | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 05ffe488ddc6..acf5fced11ef 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -147,10 +147,7 @@ static ssize_t rnbd_srv_dev_session_force_close_store(struct kobject *kobj,
 	}
 
 	rnbd_srv_info(sess_dev, "force close requested\n");
-
-	/* first remove sysfs itself to avoid deadlock */
-	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
-	rnbd_srv_sess_dev_force_close(sess_dev);
+	rnbd_srv_sess_dev_force_close(sess_dev, attr);
 
 	return count;
 }
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1549a6361630..a9bb414f7442 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -329,7 +329,8 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 	}
 }
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr)
 {
 	struct rnbd_srv_session	*sess = sess_dev->sess;
 
@@ -337,6 +338,8 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 	/* It is already started to close by client's close message. */
 	if (!mutex_trylock(&sess->lock))
 		return;
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&sess->lock);
 }
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index b157371c25ed..98ddc31eb408 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -64,7 +64,8 @@ struct rnbd_srv_sess_dev {
 	enum rnbd_access_mode		access_mode;
 };
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr);
 /* rnbd-srv-sysfs.c */
 
 int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
-- 
2.25.1

