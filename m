Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B7C43460
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33464610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhDSHie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbhDSHid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991EC06138D
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i3so13746139edt.1
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koUJHeoML3k46NNPXj9dMUKxYAz5KAM+xwZ8yCLc7gM=;
        b=EIqLgm5JkISwRDkiUimpG8pdJXO+7/OwKB+W6AuZaIpKSwmf0YiNlNAf2HOcx/Enav
         JeCBg6UQrlRXlnzD1W+4Vxu+dg/jIJanpAtqjX0Kf0mwBo8GMBLn/VYxWVPtJtxtTHKj
         +Qfgd3LeaLJyN00oRUwQA2TFi2YnFS7U8ZAwOq2XEwNts0fDNKQfxwprHQWRuehp7zQv
         mMfG9NuGvmCHAPhTYSOFnZUNP4L63f4G9+CPeZ0uVUcySdg4v9rFDdd64JkoxjC+X3WG
         UWktXT9OX/cpDAIGYfDx0+4iwCEPJarwPslyBIcx1vLPc6j6+/XSxhANPMVJVyTulYRm
         7hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koUJHeoML3k46NNPXj9dMUKxYAz5KAM+xwZ8yCLc7gM=;
        b=i3cZa9DBxlu91DNhKI6Kl7IUm5rC/beJ57liOqiEMPa+qXsCs9L2dP7Sk/YQlqE03I
         yhj3MKnrRyrXnFmEKBnRJACh81vnWzs50T+FyC7LjUKRfEKweSKQhaecsAVnZziJHKoW
         YDX+TqZegSYkfncX3hWLyB7202zwN2DHOCLltsboXAbrBTulqvEBjsGG85LCQo3Fy6h6
         8j/O9LzpWQQ2fSgR3IfEXoFzIvYfBIB1F5A6fE/7t7Yy6Mn33VcqI3C/hkoxflVoZ3Jn
         pieRxKy9/INhVKHyOtYTfhXm8/beURix0z8Y9W1AtOPdlBpvB/tl4/4i5BiIcyRn1JEz
         rqlw==
X-Gm-Message-State: AOAM530b7PQ42szki1wps1yKtNDOWVPbp7XdjvUJwWZoEMMrVR0/9iho
        lweHZN24OErGcvyq46gtXpH+xHX5w6ZloJja
X-Google-Smtp-Source: ABdhPJzekF9b/HaJDbRj1r61YsexOEYOLJ6tTl/xGCLJgYw5WSJs7P0Klmsn4LAjyqL3Bi0NfP5Rog==
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr1977010edc.67.1618817882360;
        Mon, 19 Apr 2021 00:38:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:38:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv5 for-next 16/19] block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes
Date:   Mon, 19 Apr 2021 09:37:19 +0200
Message-Id: <20210419073722.15351-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
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
index 2b6305ecfd5f..f3a5a62b2062 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -490,6 +490,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
 			      ret);
 		kobject_put(&dev->kobj);
 	}
+	kobject_uevent(gd_kobj, KOBJ_ONLINE);
 
 	return ret;
 }
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index ea98124e8ce9..01f67e08afc3 100644
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

