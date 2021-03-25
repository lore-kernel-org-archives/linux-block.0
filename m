Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50846C433E3
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE3661A28
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhCYPa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYP3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BABC06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt15so3554875ejb.12
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9NQ10bkMHujduDKkZT6Q+c0cfGdFOh0Rt1Prtp1wAk=;
        b=DxYprZth2+6TUxVxRx5ES5ZM7+R+ycEUyUnv0gJ6pIzjTbUUBVJKc4o4GuUQMmw40F
         i7ye+GXoyV+4D2WPE6tiNpFKha+ASGTpmRDRFQUYqDusz/GF/IPue5oIDk7bYNIuQvTX
         S3myKR+AQKF8UMs7ssr0TYrcHo6iQglmrLbd92ogD0p5Gc//NiL8lmKmN47y73iw6wJc
         kybNOYeJ7jhgmrEGh6d7Dm76gFoeJIDRfP6ERgfA3vtbLM1oBcXmCt27y17J7bdOFErH
         evfLIm95VxRyKFVmmoyjBEnGyQlBJ4cueyqh4cR5fjneSNrNzBOVJjriE6ot0WdYQFOJ
         H5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9NQ10bkMHujduDKkZT6Q+c0cfGdFOh0Rt1Prtp1wAk=;
        b=oOf8NYKhZ5nxVMpIoREwQV4YdvPxJI3FzkKV1/w0BJE3cp4EYe9phtP3mttwZpZgVD
         xawcrTCN/iXvKLV0euq4y8iV6JrMsHOQTJAKhqWoWGqFebQ9/IGVctyFVzoGOsk3s54N
         kvVF5IOa+V+0j3p381+nmDmEcD2e28+dQY0hkO0MktHGlPJ156nCve3Q+zp3SIgsSm52
         Lnm/DceOl7k9IoB1AvVgC4Pxn70U4NHgATcFeQpOxpuRL3/Mb3p8cARGU5QsIwsitxe8
         a+pWN36rMPOVL9wYIdb1E6Yy4EYPHyeVNzp+1QelhdlCJFixu+dnXyl+p27LW+JpYRDd
         iX7Q==
X-Gm-Message-State: AOAM530WLnkMypND1r1ByXF+HmyJw7WwfwTESah/+xyaEY0ZWB7nuIrd
        LqGjLXN2ZlJxHKbRoWU4fUpP2AUgkvRMVw==
X-Google-Smtp-Source: ABdhPJxp9ndEgErWLVxggylsIzR3/GFJcbP5Y9KL7OK+KupXNIXAFsCmZFrHyWYw1wnFAQXbLrpqEA==
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr9974359ejg.521.1616686193470;
        Thu, 25 Mar 2021 08:29:53 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:53 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 04/24] block/rnbd-srv: Inject a fault at bio processing
Date:   Thu, 25 Mar 2021 16:28:51 +0100
Message-Id: <20210325152911.1213627-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

If the fault is enabled, it sends an error to the client
so that the client thinks the target device on the server has failed.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 36 +++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv.c       |  7 ++++++
 drivers/block/rnbd/rnbd-srv.h       | 13 +++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 05ffe488ddc6..278a981302b9 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -253,3 +253,39 @@ void rnbd_srv_destroy_sysfs_files(void)
 	device_destroy(rnbd_dev_class, MKDEV(0, 0));
 	class_destroy(rnbd_dev_class);
 }
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void rnbd_srv_fault_inject_init(struct rnbd_srv_fault_inject *fault_inject,
+				const char *dev_name)
+{
+	rnbd_fault_inject_init(&fault_inject->fj, dev_name, -EBUSY);
+	/* injection points */
+	rnbd_fault_inject_add(fault_inject->fj.dir,
+			      "fail-bio", &fault_inject->fail_bio);
+}
+
+void rnbd_srv_fault_inject_fini(struct rnbd_srv_fault_inject *fault_inject)
+{
+	rnbd_fault_inject_final(&fault_inject->fj);
+}
+
+int rnbd_should_fail_bio(struct rnbd_srv_sess_dev *sess_dev)
+{
+	struct rnbd_srv_fault_inject *fault_inject = &sess_dev->fault_inject;
+	if (fault_inject->fail_bio && should_fail(&fault_inject->fj.attr, 1))
+		return fault_inject->fj.status;
+	return 0;
+}
+#else
+void rnbd_srv_fault_inject_init(struct rnbd_srv_fault_inject *fault_inj,
+				const char *dev_name)
+{
+}
+void rnbd_srv_fault_inject_fini(struct rnbd_srv_fault_inject *fault_inject)
+{
+}
+int rnbd_should_fail_bio(struct rnbd_srv_sess_dev *sess_dev)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a6a68d44f517..447fb0718525 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -88,9 +88,14 @@ void rnbd_endio(void *priv, int error)
 {
 	struct rnbd_io_private *rnbd_priv = priv;
 	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
+	int fail_err = 0;
 
 	rnbd_put_sess_dev(sess_dev);
 
+	fail_err = rnbd_should_fail_bio(sess_dev);
+	if (unlikely(fail_err)) /* over-write error which will be sent to client */
+		error = fail_err;
+
 	rtrs_srv_resp_rdma(rnbd_priv->id, error);
 
 	kfree(priv);
@@ -230,6 +235,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
+	rnbd_srv_fault_inject_fini(&sess_dev->fault_inject);
 	rnbd_dev_close(sess_dev->rnbd_dev);
 	list_del(&sess_dev->sess_list);
 	mutex_lock(&sess_dev->dev->lock);
@@ -811,6 +817,7 @@ static int process_msg_open(struct rtrs_srv *rtrs,
 	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->id);
 
 	kfree(full_path);
+	rnbd_srv_fault_inject_init(&srv_sess_dev->fault_inject, kbasename(srv_sess_dev->pathname));
 
 fill_response:
 	rnbd_srv_fill_msg_open_rsp(rsp, srv_sess_dev);
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index b157371c25ed..120e6d64cb82 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -45,6 +45,13 @@ struct rnbd_srv_dev {
 	int				open_write_cnt;
 };
 
+struct rnbd_srv_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct rnbd_fault_inject fj;
+	bool fail_bio;
+#endif
+};
+
 /* Structure which binds N devices and N sessions */
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
@@ -62,6 +69,7 @@ struct rnbd_srv_sess_dev {
 	struct completion               *destroy_comp;
 	char				pathname[NAME_MAX];
 	enum rnbd_access_mode		access_mode;
+	struct rnbd_srv_fault_inject    fault_inject;
 };
 
 void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev);
@@ -77,4 +85,9 @@ int rnbd_srv_create_sysfs_files(void);
 void rnbd_srv_destroy_sysfs_files(void);
 void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id);
 
+void rnbd_srv_fault_inject_init(struct rnbd_srv_fault_inject *fault_inj,
+				const char *dev_name);
+void rnbd_srv_fault_inject_fini(struct rnbd_srv_fault_inject *fault_inject);
+int rnbd_should_fail_bio(struct rnbd_srv_sess_dev *sess_dev);
+
 #endif /* RNBD_SRV_H */
-- 
2.25.1

