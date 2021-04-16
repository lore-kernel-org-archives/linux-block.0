Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DAC43461
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE0A61166
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhDPXyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 19:54:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77AC061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id d1so2728474qvy.11
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6W4dFuQZFZDxrcjNEtMiTx3DGVpbYyuLvbl05NbuH68=;
        b=iCDnN0TcD52pcBDWvZyNoGF+BkPDWGIe5uDS4cKKGP9YY2a4hlr0Z4q4Y3d75SNPvL
         ubKGKLnjxaJ2YsNM+A9O0JzXzsvM7k85bTCUQwKPPc/HeTPbd9b9tSizDy81e/yvakuy
         3lh2DUBiUsLxj6yn5qDz95ZMXw/WpAECviYxGuCdxgN8la/cJHygPOaYvYn0A+vbL0KT
         iktznhNE3ErCMkc5uxGwSbVThavjgQ1gGIPSPycjmgkSQYTt/rkzL49pIeMQqPiFfPGy
         NDSKmSC+SqwQhFE03WCCHB8LC1mz+nlZvidwljqPMMa5kUcJwRarhH/ifunqIPRiBv6K
         gTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6W4dFuQZFZDxrcjNEtMiTx3DGVpbYyuLvbl05NbuH68=;
        b=oh6BuHGhavErzftzMvJ3rOvtCR7sbh4cGbI791hUZg+Y/TK66zYRCjZU61T/sgBErD
         lBmBmxsoiZDHAxGF5G20IyHKNxn7LioZMF93mNeUFw/w/ukS0tgBHbgt3cdrbOuvK7Op
         GxCMP0NkZkjA9yyFhqjWJySWvAmGiyYfvq3JRF/wZe6i4/BT8Kt+diIqk1SXv79jQnF+
         ihQwcGgs0EMfiIGW172uRrYkjrf0mKVEjUKiJWxAjAfEQvZSnJP6lkrE2UsJbmoduBLs
         LCektwUzKKzMm4Gcv0SLMoiWioO21igZO89+FhsS6W9TC5QPE/pkGueVoRFOEirm2dxt
         8ngA==
X-Gm-Message-State: AOAM532m7Msfm8mNpmpRiPLgi0KTDD/Cig201b3Jgfx470gegYeMQio5
        eQN6oR/kF26bjkTW5viC0pA=
X-Google-Smtp-Source: ABdhPJwh6XHQ4W/sFJBzn//P5eE+pQK3iiAapSkSAHYWj127GoJpxUHJsFoe6ImvSyp0IpaHo7CJxA==
X-Received: by 2002:a0c:b38b:: with SMTP id t11mr11025259qve.25.1618617214793;
        Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l199sm768557qke.118.2021.04.16.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read support from native multipathing
Date:   Fri, 16 Apr 2021 19:53:29 -0400
Message-Id: <20210416235329.49234-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Whether or not ANA is present is a choice of the target implementation;
the host (and whether it supports multipathing) has _zero_ influence on
this. If the target declares a path as 'inaccessible' the path _is_
inaccessible to the host. As such, ANA support should be functional
even if native multipathing is not.

Introduce ability to always re-read ANA log page as required due to ANA
error and make current ANA state available via sysfs -- even if native
multipathing is disabled on the host (e.g. nvme_core.multipath=N).
This is achieved by factoring out nvme_update_ana() and calling it in
nvme_complete_rq() for all FAILOVER requests.

This affords userspace access to the current ANA state independent of
which layer might be doing multipathing. This makes 'nvme list-subsys'
show ANA state for all NVMe subsystems with multiple controllers. It
also allows userspace multipath-tools to rely on the NVMe driver for
ANA support while dm-multipath takes care of multipathing.

And as always, if embedded NVMe users do not want any performance
overhead associated with ANA or native NVMe multipathing they can
disable CONFIG_NVME_MULTIPATH.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a12b10a1383c..83ca96292157 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -340,6 +340,8 @@ static inline void nvme_end_req(struct request *req)
 
 static inline void nvme_failup_req(struct request *req)
 {
+	nvme_update_ana(req);
+
 	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 	nvme_end_req(req);
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..7d94250264aa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,23 +65,29 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+void nvme_update_ana(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
-	unsigned long flags;
-
-	nvme_mpath_clear_current_path(ns);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
-	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * ready to serve this namespace.  Kick off a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
 	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
+}
+
+void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	nvme_mpath_clear_current_path(ns);
+	nvme_update_ana(req);
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..4eed8536625c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
+void nvme_update_ana(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_update_ana(struct request *req)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.15.0

