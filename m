Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D612CC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBDE61989
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhC3Hij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhC3HiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA1C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l18so17031519edc.9
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9NQ10bkMHujduDKkZT6Q+c0cfGdFOh0Rt1Prtp1wAk=;
        b=Tre7V6mWBDYQ36iTgRO2T5UKnYqIbEwlL+0KkVDL8+gl5OttmRxO0NhXyJYLVkJJEe
         dmPkrZFZ4fzH2jY5dTaYgPGcbv3TSp2fgVChHy2KhjXVEZml6oQ0K1JWMI2gRD7BpEV2
         PhpJ8YvVDeR6QSfPvj3b7dREKZYUuhU6gxnsGSRgEpbm67iwwiWdIMVIajVX4F6LoQTQ
         /imLe+q4OvRQ7pgwCrnPHVkqX2MUEXQKDX6a/b8OeTdXn3vqznFj9PpzmbZbUewwlJQ3
         1mVSb8dRYwBLGqvcmwSQ/ko+5kKqPinR3zpcokwtZqnt9k9NTcwmGi7R5HgCCpd2ztfc
         E6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9NQ10bkMHujduDKkZT6Q+c0cfGdFOh0Rt1Prtp1wAk=;
        b=TR4dLxcU2fyyTrsnateAS5tzWFjRGmb77CHhQ4/BqGSVwU2rFV4ignqBqTPjra8qLw
         Kc27aOVnACPnYRfc0sjXSWVimOm39t9qYHi+fsCBpM0I1bESFhBEEQcBJ25/J3g0KusL
         3xgqPbH+6+iWF6TDUa6SjRUsrXOWxBt/bxQ5b1d14Uw7GEkXt9qVD1t9uccwIRRKBjM2
         7yMtglSJq3QWonGL8TWOnCHZ2aMbbmpUI1hY2OHpi+fLJq6/cR5v16QOhFisz6mxmXWW
         2cwmfFKcBDLGD3ZLRyB453DIGwTmt4NAoA48ARPfobfTpkHVOGzvCUTe01EHQoRCKdkp
         LFtA==
X-Gm-Message-State: AOAM5312w1/CBkwGK/5Y3D0X13RkmcXIn9SC33gxluSI0Ue+TI9xEKjn
        cFPVB+jCtXUmO1usLpTeFch+VVY0USwPDQ==
X-Google-Smtp-Source: ABdhPJyebXeX1Hv0ZUhF+QQeHa7kq31E1Mqjz5ZGzprMKdBlSJaIlkiZaCjODJz4nyFmqsCJMQhRxw==
X-Received: by 2002:aa7:c497:: with SMTP id m23mr32027227edq.74.1617089879589;
        Tue, 30 Mar 2021 00:37:59 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:37:59 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 04/24] block/rnbd-srv: Inject a fault at bio processing
Date:   Tue, 30 Mar 2021 09:37:32 +0200
Message-Id: <20210330073752.1465613-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

