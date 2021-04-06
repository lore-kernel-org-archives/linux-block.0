Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD8C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E58613B8
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbhDFHHu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbhDFHHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452CEC061762
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o19so15225018edc.3
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4l0uTtiV7ZxDBIfEDONSIU85jI5qJ0lBYkiqNJSWw1E=;
        b=eWczOm3r9X3LFsQZu8U8zG959MA0I5PnmHH0TvJQq7h5sNf0u0hTDZKfcCNd/hFUmH
         mQG/g4K0kPq5+jpogkPqKIDSqO6NHDW+mF/aKlXmWAsRnmgHdsYn1HU6rKtVc6APTu0B
         tip0V5ArzOaRrakWOfjdKZskKzfeqgy32e7IwFoKBxXF3bXzOfzfoXt6MJSRXoNh/j/L
         hJfZjIhUOjVuMmdqrqasmwmqPzpsO9jxZxYZ5Ed/33wvG7MeWKXj3OmQN5yFVjLpODRp
         vCRrb2bUgMe/8o8I1KZPzuwsvxrT8WIc0SUCnt83rFLtxLxwhwaLc8lLqLp0jen9bqZQ
         7ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4l0uTtiV7ZxDBIfEDONSIU85jI5qJ0lBYkiqNJSWw1E=;
        b=SyM3RGxJQqWCR3wJeMfR8NWV/MNawgBxnZJ+PJxCr52fVrD1ItNIJBliny6VDPFhY4
         lnbIGNpEB1/PYvTdaMAUM6wCjGoEprAfQ0EMTf8rPdqJoMSKfxSAIZs9kzudZgpQQtN5
         DGrRe90poszXfekD+v6YR9a7713okewb+TJzclWkvjuPZFM/ui+74t1+51sOeaEAC2kY
         hW6iKTAKsWs2+T1fepYKJJHNkTm6bYjIFj0a1DPZPmV4oZAs7yalqWVQIh48o5lA4MJJ
         B5GPoY4OD+n6cpHTfHcprNI8MLD7sGGHubYRy79wXHkCNfeclNJfSbtCd4RIh5kFOp21
         71cg==
X-Gm-Message-State: AOAM530OmVNP5Xsbaufzo8hBTbV30VjBDYw1B9ipLXgZ2ev9xAsWqlbM
        WKi91AqXyY4cBCMoz23yGPzwLzfU3hxGfW1I
X-Google-Smtp-Source: ABdhPJzrgfGzfIV9MLiSgvXcFtJ66B97KA5Dd4YU/8iciFKEPNmqvLCeqC9O/mKyAFOrrTdC4mLAvg==
X-Received: by 2002:a05:6402:40d5:: with SMTP id z21mr36971205edb.20.1617692852838;
        Tue, 06 Apr 2021 00:07:32 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:32 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 16/19] block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes
Date:   Tue,  6 Apr 2021 09:07:13 +0200
Message-Id: <20210406070716.168541-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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
index bd111ebceb75..5609b9cdc289 100644
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
index 63719ec04d58..1fe010ed6f69 100644
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
@@ -649,14 +652,18 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, enum wait_type wait
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

