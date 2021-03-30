Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF31C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02A061883
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC3Hip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhC3HiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DFC061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so16992454edu.10
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzPBTlBw1MjHnrff8Rt1PN/OBBefnhXSEo3ZW0EmbAU=;
        b=bbArIyYc+Agi+s2EyURgl/1IBAtSupFhrqJeJVFieKqC6DrK0VxEQGrjnjyQli60sN
         3TJ+29XTA1n9Y+0eiM2JUR64szIF5FVN1bTWwc5F7PaLQFOAmGjtlxnZp1hRoJ3I3Q+Q
         Vs3yp2MrK/gfMllKsWQZT27WHACMVwNgUczOFH73R54vn9i1Unsm+I4i0KFr3MBodgY6
         aZv0bxw8w9UZeVRlha9YGY9mUaHH9VeXIjbUphVeVAVtMI3L70LvguE/q6ma+2KWmeVU
         jNGBL6LVg+7/m7T2YTz4583aPm8jSIg+eA04u/ufHoTShUglX4h2plvcUGDLmXxI0/Km
         3XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzPBTlBw1MjHnrff8Rt1PN/OBBefnhXSEo3ZW0EmbAU=;
        b=ug8EsmpdKFdxX8yk9eXmXV6La5NJkxlJ4l0dYefrzISv19zhbUksQ6XWhYKTd3VxKl
         SUURsGHQc0FDPNWDhum/2hPgju+NPxvGgx6htQXINcUmlwEfeK2SJVR+n85hgiba1AMI
         JO1d9hRIquVhOtGAOyIClVfWDrkQrT45UxQ9mpJOc8i8OFaCtzJ57GjK+Wvh92iVHlpf
         DeXwRivyT1v+6/iD7zuScuB9Dq3+pv63TEuceobCNv9aQcBxRjNIQFoN3ebfii7OVfHk
         grpspVvS81u64BdgjypgKNhjO70CioFG721Vjmrw7jrQCvh4osFOvHyrFQ+IpMAG65lJ
         DMDQ==
X-Gm-Message-State: AOAM533ktNpIvUcqwHtWKzCmf6Aii2xqEzXRnM36VNuWXYG90fdSuvMT
        yjHI4HT1FFNRVeXAz3W6wtRFjWoA8Yv4CWAn
X-Google-Smtp-Source: ABdhPJytZKYkL3tcAScufRusigsym4RlmZ6xECFID60oCDH2h9TEwBWONMMWE4BrTcbpThkOgUN5sg==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr32424798edw.303.1617089893730;
        Tue, 30 Mar 2021 00:38:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 21/24] block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes
Date:   Tue, 30 Mar 2021 09:37:49 +0200
Message-Id: <20210330073752.1465613-22-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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
index 998cadd73d47..6f3ca2e3bc02 100644
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

