Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81439C43603
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65207611F2
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbhDNMYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350879AbhDNMYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73DC061342
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so31093166ejo.13
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4l0uTtiV7ZxDBIfEDONSIU85jI5qJ0lBYkiqNJSWw1E=;
        b=dCPCH3hr2OAq1M4O0j9BrXEXIpo7zx31fuXMOX9G4DQtbTkcKD3hndKHC7XIORGDgJ
         x0FF67Tecv5yba2qwg0ajlM0yo3wSKy7zNJJ0d6DWVArFawaYQAfaI10YRI+e0MsOfJI
         xbhnVTJQZ8GktMneNmdGBmcC8+Zo3LKXpUC4LwwHou16OW0rqy4Z9JtKWPv7JxodKwok
         xNe9YWhSrHmISauzRi+3F9qGFX2GlZ+Fepg37dDiCbK8tOy9eEB1yvdOKV16WV2ledch
         eyfVzMS1OxTFyq9+/SIZXpUZiTjFAiW9wuBCRpZQq5eCxrmkKtbM6U5TKM5cu1k62s20
         7/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4l0uTtiV7ZxDBIfEDONSIU85jI5qJ0lBYkiqNJSWw1E=;
        b=W/6+sl42perD+5cN0XBNZ/5WC38cP5+W6uth+oMjAjZF7japS1eSIE8b1TTsL1f2lS
         Pw0al7vz/Agd/OuKG7ZJ2lrCUcxy6fGi1SL71Kx9ZBSpRBTf2UJdVT6/pDKAxOSFmKem
         BuIYVVAWCUcFb18xPqR3TNIbCITIpR5ER4XjVM7iliUz0K+4F7G4Q2K+SXwABiQbDIXv
         eBZ4/z2OZGwpBIqqzeuYqqhTRhVBG/OCk4GgM5riy6CNs2w6TVFJodcI/FeXv5BJ0HBf
         LWxz1DQkHJ7Shw69Z493Q+sOp9bhWdU115NOU0U+DTtsyRnwFEBTJ5+eH1MH9zKTk+W0
         yF4Q==
X-Gm-Message-State: AOAM53077YjZdkHm0zmBJVIr6/0VjTedxnrfLBUtGoL5Iv2RxITuhVv2
        I6Koo5FK8CUt2wIPLtqRQN0uguX7WGlm3jmp
X-Google-Smtp-Source: ABdhPJy1KD5Y+nhuyqgpdKjj8b8GtAtLpE/nsYV5TGiJONG/N0Ru4k7gdbIo7Ti3wpLGy/TsBlR9vA==
X-Received: by 2002:a17:907:770d:: with SMTP id kw13mr1441199ejc.339.1618403062853;
        Wed, 14 Apr 2021 05:24:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:22 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv4 for-next 16/19] block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes
Date:   Wed, 14 Apr 2021 14:23:59 +0200
Message-Id: <20210414122402.203388-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
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

