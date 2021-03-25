Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76062C4345B
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B9A61A28
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCYPaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhCYPaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC4C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so3553707ejz.11
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p40ssgeSKac7cQW0T1VPKfk+9gMkzlX/SAuD/doNUHc=;
        b=LVe5RTBsPO2n/o+HPmQMMVihrZDTN5b0ua8IZ2QTZWkgwunr9T0oaMabIqcBLH5mGz
         JHsodU8/DL+7DTyGCZkDU8H+9AIjrryHptgtaUuY34sAUPxHU13u7FB5+yiSqnBHGMRc
         Icrqo+VAFVGp7zHRBeiDU1objw2wFyZ7E+RMjkKo8XMPU7j7Drxk4riEdiAH0sO/YgCc
         ngoGHV64MgmwAe/sNKDb01PO+G1LgYD71FFR8ZT74hSjZ+2p1WFozi+BrhKri/NB4IXo
         qq09LJ97DvZDgwv2rvLk+Ve9Xyp/x4kpeZdiPFo8wfLSKlRtJxwuV7++urozfh2eRb7N
         jJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p40ssgeSKac7cQW0T1VPKfk+9gMkzlX/SAuD/doNUHc=;
        b=oElcbl1oEZKq/pdH/M0WH7jhTta61L3xWiZBtRPBt4PLukT5/FCKX6tBW8k7INsh6R
         hJSrHHHFNPIbb9KwMHaTjMSzzNOknI/XRRhxWhwjYKvYh2mTi26n6d6RdhFbCFWt819Z
         r35C0oepYNNysqOxN/I/EVVHMJ7WCE363VjO2gGUkPtdjLW0hRmz6z7ihgIBZlpWvhMl
         ZSLFHH7HNqRKvzSOgnFVaTc74SZm7wYeFzxFHpGOXhvcCDf7pHnhQIisj/9unrUf9O75
         V6Dd3Oj+JsZOx0XdNVjQlns7mL7WsQH8EZ5cFr0dBMbA0Gd4tak4tMuDIgdF/oKdAhXz
         tSSQ==
X-Gm-Message-State: AOAM531Vebn3FIcq4bTVcLZL7xsgIPkZKIySDpB3cb+NqHn+qhMTX21D
        3KH79L3LA6MMBma+xjiCsCR+GaksB/yO1oXd
X-Google-Smtp-Source: ABdhPJzdoC8dg5RvXF8Cm5nOXkPXvV80NcPkj7Isn3k4sCfqhsAGz/pbq1LXd0AMmQEMBuo04HqklA==
X-Received: by 2002:a17:906:379b:: with SMTP id n27mr10467935ejc.182.1616686206864;
        Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 21/24] block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes
Date:   Thu, 25 Mar 2021 16:29:08 +0100
Message-Id: <20210325152911.1213627-22-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

When an RTRS session state changes, the transport layer generates an event
to RNBD. Then RNBD will change the state of the RNBD client device
accordingly.

This commit add kobject_uevent when the RNBD device state changes. With
this udev rules can be configured to react accordingly.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 1 +
 drivers/block/rnbd/rnbd-clt.c       | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 9ea4da7f894a..630351574d1b 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -491,6 +491,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
 			      ret);
 		kobject_put(&dev->kobj);
 	}
+	kobject_uevent(gd_kobj, KOBJ_ONLINE);
 
 	return ret;
 }
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 3df2c11e9f53..60410115c4f4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -110,6 +110,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 				struct rnbd_msg_open_rsp *rsp)
 {
+	struct kobject *gd_kobj;
 	int err = 0;
 
 	mutex_lock(&dev->lock);
@@ -128,6 +129,8 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 		 */
 		if (dev->nsectors != nsectors)
 			rnbd_clt_change_capacity(dev, nsectors);
+		gd_kobj = &disk_to_dev(dev->gd)->kobj;
+		kobject_uevent(gd_kobj, KOBJ_ONLINE);
 		rnbd_clt_info(dev, "Device online, device remapped successfully\n");
 	}
 	err = rnbd_clt_set_dev_attr(dev, rsp);
@@ -654,14 +657,18 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, enum wait_type wait
 static void set_dev_states_to_disconnected(struct rnbd_clt_session *sess)
 {
 	struct rnbd_clt_dev *dev;
+	struct kobject *gd_kobj;
 
 	mutex_lock(&sess->lock);
 	list_for_each_entry(dev, &sess->devs_list, list) {
 		rnbd_clt_err(dev, "Device disconnected.\n");
 
 		mutex_lock(&dev->lock);
-		if (dev->dev_state == DEV_STATE_MAPPED)
+		if (dev->dev_state == DEV_STATE_MAPPED) {
 			dev->dev_state = DEV_STATE_MAPPED_DISCONNECTED;
+			gd_kobj = &disk_to_dev(dev->gd)->kobj;
+			kobject_uevent(gd_kobj, KOBJ_OFFLINE);
+		}
 		mutex_unlock(&dev->lock);
 	}
 	mutex_unlock(&sess->lock);
-- 
2.25.1

