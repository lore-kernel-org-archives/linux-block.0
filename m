Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2CC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA8F613C4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhDFHhx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhDFHhx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:37:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D4C061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:37:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh7so10350717ejb.12
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pr6f4CgNg/vO7af8Lnbc0By2HHIYCME5N2QMNGWGV18=;
        b=QNGflsDu121Be1+y9fmBcBzZBBqRf09KL7HUyjNkq7pRN9BQTOZI8dJ3bHQT6g2mWM
         qV3pEY37UU7H1bjr5amEY3hbJu1i9cEvj+e/YVFPXatwuK36B/UV6jHjbODV+8de4MS8
         d8sQYeUjyq+/XosEbMSazgaex9tq5ImOYFPUiA1ij3ohzU3MuwoENe5ZYgrwNy5pJYGP
         Qu7nAZK1V22IqdiV1NHKb9MJYsuFj2d4t8kQTqKIHqz7Z7Xo4TpPNinrlxZx4XZ8TxYZ
         cgHQomuaKtn0mrx7thRnHy03WO4vgJ3hgMVACWd9TZifO+6iPdWda5u/2XMtWrI9YfhD
         rsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pr6f4CgNg/vO7af8Lnbc0By2HHIYCME5N2QMNGWGV18=;
        b=dfAYG2UdDxUNgEhRLaCKtiQiflOlAs4XDoQtyUfgErJ7Bq2KKukRG3YwDt0kQxElEW
         xVJWGL8ls64B/Ttm3EgLqaRBE9a4p7v8Jcgu4qjtiiTvEdAjdOOdXXZc5SKlZvuWlY9W
         54u6K7rLhNwzHcLSw1wDjh5TVYJUYpiBsH4C7euYE4Y5mL1yvYH1j1l1bZlauk5WAjpd
         0XoCj4oI2sQYWt4m/1clQDxVC6wQkArzMCNtrm1pt0WRVxZJPzhAma68DiPR5+5R+VJd
         GairfhYcLBQyAJwp/lXszt7846jwtvRxiu8giiRwsC5zuY+cBvCal+ihIc3tUh7SjBnf
         iHBA==
X-Gm-Message-State: AOAM532AyNEAukoYhj265BqWVHcnBIVF25Vw6LeJBM399W2IS1DaHPNz
        vP9WP9jNoNSG8mqxJCqj/iwc4pHaOP7lmt7C
X-Google-Smtp-Source: ABdhPJzvt9H6SSr55xEkCNfddBwDAZA98e1KM1sqVHN8GOpOF8btQCeyH7vWhMknR0jLpS8h26GsYw==
X-Received: by 2002:a17:906:5906:: with SMTP id h6mr3095904ejq.288.1617694664682;
        Tue, 06 Apr 2021 00:37:44 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id o6sm12843305edw.24.2021.04.06.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:37:44 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 3/5] block/rnbd-clt: Inject some fault points
Date:   Tue,  6 Apr 2021 09:37:25 +0200
Message-Id: <20210406073727.172380-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406073727.172380-1-gi-oh.kim@ionos.com>
References: <20210406073727.172380-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

This patch injects two fault points:
1. generate an IO error
2. generate a unmap failure

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 53 +++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-clt.c       | 17 +++++++++
 drivers/block/rnbd/rnbd-clt.h       | 15 ++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d4aa6bfc9555..d83415875960 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -651,3 +651,56 @@ void rnbd_clt_destroy_sysfs_files(void)
 	device_destroy(rnbd_dev_class, MKDEV(0, 0));
 	class_destroy(rnbd_dev_class);
 }
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void rnbd_clt_fault_inject_init(struct rnbd_clt_fault_inject *fault_inject,
+				const char *dev_name)
+{
+	rnbd_fault_inject_init(&fault_inject->fj, dev_name, -EBUSY);
+	/* injection points */
+	rnbd_fault_inject_add(fault_inject->fj.dir,
+			      "fail-request", &fault_inject->fail_request);
+	rnbd_fault_inject_add(fault_inject->fj.dir,
+			      "fail-unmap", &fault_inject->fail_unmap);
+}
+
+void rnbd_clt_fault_inject_final(struct rnbd_clt_fault_inject *fault_inject)
+{
+	rnbd_fault_inject_final(&fault_inject->fj);
+}
+
+int rnbd_clt_should_fail_request(struct request *req)
+{
+	struct rnbd_clt_dev *dev = req->rq_disk->private_data;
+	struct rnbd_clt_fault_inject *fault_inject = &dev->fault_inject;
+
+	if (fault_inject->fail_request && should_fail(&fault_inject->fj.attr, 1))
+		return fault_inject->fj.status;
+	return 0;
+}
+
+int rnbd_clt_should_fail_unmap(struct rnbd_clt_dev *dev)
+{
+	struct rnbd_clt_fault_inject *fault_inject = &dev->fault_inject;
+
+	if (fault_inject->fail_unmap && should_fail(&fault_inject->fj.attr, 1))
+		return fault_inject->fj.status;
+	return 0;
+}
+#else
+void rnbd_clt_fault_inject_init(struct rnbd_clt_fault_inject *fault_inj,
+				const char *dev_name)
+{
+}
+void rnbd_clt_fault_inject_final(struct rnbd_clt_fault_inject *fault_inject)
+{
+}
+int rnbd_clt_should_fail_request(struct request *req)
+{
+	return 0;
+}
+int rnbd_clt_should_fail_unmap(struct rnbd_clt_dev *dev)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 45a470076652..8c9a02c8b8bd 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -411,6 +411,11 @@ static void msg_io_conf(void *priv, int errno)
 	struct rnbd_clt_dev *dev = iu->dev;
 	struct request *rq = iu->rq;
 	int rw = rq_data_dir(rq);
+	int fail_err = 0;
+
+	fail_err = rnbd_clt_should_fail_request(rq);
+	if (unlikely(fail_err)) /* over-write error */
+		errno = fail_err;
 
 	iu->errno = errno;
 
@@ -1161,6 +1166,7 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(rq);
+
 	err = rnbd_client_xfer_request(dev, rq, iu);
 	if (likely(err == 0))
 		return BLK_STS_OK;
@@ -1545,6 +1551,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		goto send_close;
 	}
 
+	rnbd_clt_fault_inject_init(&dev->fault_inject, dev->gd->disk_name);
+
 	rnbd_clt_info(dev,
 		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
 		       dev->gd->disk_name, dev->nsectors,
@@ -1599,8 +1607,16 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 	struct rnbd_clt_session *sess = dev->sess;
 	int refcount, ret = 0;
 	bool was_mapped;
+	int fail_err = 0;
 
 	mutex_lock(&dev->lock);
+
+	fail_err = rnbd_clt_should_fail_unmap(dev);
+	if (unlikely(fail_err)) {
+		ret = fail_err;
+		goto err;
+	}
+
 	if (dev->dev_state == DEV_STATE_UNMAPPED) {
 		rnbd_clt_info(dev, "Device is already being unmapped\n");
 		ret = -EALREADY;
@@ -1618,6 +1634,7 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 	dev->dev_state = DEV_STATE_UNMAPPED;
 	mutex_unlock(&dev->lock);
 
+	rnbd_clt_fault_inject_final(&dev->fault_inject);
 	delete_dev(dev);
 	destroy_sysfs(dev, sysfs_self);
 	destroy_gen_disk(dev);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 537d499dad3b..5ecbe8dedf24 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -107,6 +107,14 @@ struct rnbd_queue {
 	struct blk_mq_hw_ctx	*hctx;
 };
 
+struct rnbd_clt_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct rnbd_fault_inject fj;
+	bool fail_unmap;
+	bool fail_request;
+#endif
+};
+
 struct rnbd_clt_dev {
 	struct rnbd_clt_session	*sess;
 	struct request_queue	*queue;
@@ -139,6 +147,7 @@ struct rnbd_clt_dev {
 	char			*blk_symlink_name;
 	refcount_t		refcount;
 	struct work_struct	unmap_on_rmmod_work;
+	struct rnbd_clt_fault_inject fault_inject;
 };
 
 /* rnbd-clt.c */
@@ -163,4 +172,10 @@ void rnbd_clt_destroy_default_group(void);
 
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
 
+void rnbd_clt_fault_inject_init(struct rnbd_clt_fault_inject *fault_inj,
+			    const char *dev_name);
+void rnbd_clt_fault_inject_final(struct rnbd_clt_fault_inject *fault_inject);
+int rnbd_clt_should_fail_request(struct request *req);
+int rnbd_clt_should_fail_unmap(struct rnbd_clt_dev *dev);
+int rnbd_clt_should_fail_request_timeout(struct request *req);
 #endif /* RNBD_CLT_H */
-- 
2.25.1

