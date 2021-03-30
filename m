Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A88C433E4
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F78E61883
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhC3Hij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhC3HiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAAC0613D8
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o19so17039046edc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pr6f4CgNg/vO7af8Lnbc0By2HHIYCME5N2QMNGWGV18=;
        b=dZfLphxgzO0mxIDEGnWi6JgEc3ivjx99R3XeabWd5m5y6KWhs8EHfFrbeqNJ9gl1Li
         fQsQbDVw5hp8SK2e2/SV0yJAsrWGXY5+YvCbGdaM8LR/fZqt4ywV3zTbEPzGyOKjAHic
         uBTwbSKniLHehfYKDXaAtOF2CuPFKzr+JxcFKsaWVH7Fxnu6Qc5rIoCq5XRF+w4oRb3E
         9T1yv5ml6Z69KDsWyarMDawhAqhYoevKuJg3boJxPSes0dT0YoqHXYluAG7rXwCbJdoD
         QJOzBATxk6NSQmULEe8l4DQAYe9BT+YSZ7fMEkGV5yv/ZisnHDyiiO+lUq1ttNjYMGAK
         dcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pr6f4CgNg/vO7af8Lnbc0By2HHIYCME5N2QMNGWGV18=;
        b=Ngvw66Nsp/Du9HrqCmeDJ3Ad1FfSvLath/RQTGEEO3gZ7OEM3j0i9pSg+ha/Uk2WOc
         BS22s6MaiGK7N7EmAGP38B03NGRnAB83hVMo90S5UPviSr0IwvFzyswBuq5OZCIz6qr2
         ZU2M/v64d2HUs+s2hpgrx94Heu2q0zDwf4fdH6+4FBtPA6CiBq+tZeYiqhnaa59ogFSM
         g6LfK8WARv4ziUWTAwR/jnlKnsz5fvnMZXTta9pXsxq/EvQtDi8iGr2lCai9/lJ7sNAl
         thjqV7q53v/9b1+u5h0gSxGAZGJWq4LeYYW+PhANvfKyUSf2OdaRUIKBAvZ/5/Zvg0ev
         KmzQ==
X-Gm-Message-State: AOAM531Y2P8Ed1f9xh38niyb/jIveZB9xpgUarlwN/0uh42Q1tKECt0d
        /R8OACZEZyHA+KaoWNJPz0w2eyDJLlMheA==
X-Google-Smtp-Source: ABdhPJz0FZIg6dOHdNqoTi/XJybcD/ZEs2QxxlekSXGk1BYqd78dL6SYwRP9UDXJ98xs1tylVjiSYA==
X-Received: by 2002:aa7:cdcf:: with SMTP id h15mr31933840edw.28.1617089880308;
        Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 05/24] block/rnbd-clt: Inject some fault points
Date:   Tue, 30 Mar 2021 09:37:33 +0200
Message-Id: <20210330073752.1465613-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

