Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D26C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2326E610F7
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhDPWHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDPWHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 18:07:10 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC6C06175F
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e13so20621186qkl.6
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDUiV58X75hPG1P5uWek/G5MSETfeVhGHbmBONCaZ8U=;
        b=CKj5b28UASeTOfqPWz2oTGQYrduQxQZ2eAG3FT5PPVb8fdVDOOEKtJWkRcoYjAzuFc
         sn0wYTkzxYbNVPpJ3G6aPgjV986ykrnqPpLuTeHUlplzLZCEjLzD35cvh96xpre24pgJ
         qn1zA9POnl5XUHMKv+5bLtr94YthtfWjPwvNjLwjMKR3nGxy6UaGKhz+OAiN+RNG4GFK
         2a1aJY/O9wImAS/STIru/YR9iWLevZtnYSmqyncOgWv6rRizKsXMdOPozJIgniljDwET
         EO477RXXJbHey8Y3MjWjpyQq60MAarpTff+yOghpQW1Srv8llLnIRInzD2lSZYnY95X7
         V/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rDUiV58X75hPG1P5uWek/G5MSETfeVhGHbmBONCaZ8U=;
        b=dHgkNnyWUo4450KxvCs2sL8Lx2rLlPPRk6iSP737J+vpig2Nqves+cATABPQENA8W6
         aq7cnp41E3fEKuTE/ntVHKE361GfimRE5cQ0bFFclMu0Fx6h4PnEMkg/RDC00G3JEJs8
         1XzHJG3niRvwYYIpq3pVZ+iaE7BndDkmxyWsAVog/AeVAgJCrFZRkdoVoJewPnAWwlhF
         Ju8NDLcHr4sGN5YTE+ZE5xQl+but1ABoWh9CfcKQsPnjrvxAP5IkORkiCSPq7cmsCrvl
         /pg8TDhxKSg6QtHBYZ0t45r+IOATlHada+OgaW8VST4vDtKkXtMjonDQrTRTqbgBTD77
         e9Kw==
X-Gm-Message-State: AOAM530/tWpWkDzuXIJKAE+RC94iZrqZGn49Lp1nQKENfX1BImzrvMgZ
        EzaySu/fq9XternaI8Usm8g=
X-Google-Smtp-Source: ABdhPJwQGhrESLAHtZ/cMgCEXSH14BFWFw6ZctlPgcT4kjH9HsxQmaXkprC7Mn2+sEKVYnurrbUTtQ==
X-Received: by 2002:a37:a1d3:: with SMTP id k202mr1452014qke.97.1618610804004;
        Fri, 16 Apr 2021 15:06:44 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 132sm5094410qkn.52.2021.04.16.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:06:43 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/4] nvme: decouple basic ANA log page re-read support from native multipathing
Date:   Fri, 16 Apr 2021 18:06:37 -0400
Message-Id: <20210416220637.41111-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
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
index 605ffba6835f..9a878a599897 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -349,6 +349,8 @@ static void nvme_failup_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_update_ana(req);
+
 	/* Ensure a retryable path error is returned */
 	if (WARN_ON_ONCE(!blk_path_error(status))) {
 		/*
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

