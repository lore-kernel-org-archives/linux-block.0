Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA3DC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C7461029
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhDOXMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234961AbhDOXMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618528314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87XIeGmfMSn6PYgAuCw5PK3YgEGDh3R/61XjULGPf1I=;
        b=VpGvG/hh6ljWfmBYkSaHvj/W9uGGH5e9J4O+/V85f+wkPD+mQR76hDR3emLJvi7M7QQn1X
        LlOI0QDEyehc2dHeNXFUvJB+RJaUW0Ibu4a4V4Oq/9BTigjLWntKelV8BuFEN2s7fqsPQd
        bLLYr/PS6vRwagXZ3VUeJsyKnejLraQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-3_9hY8ujOpSPBxn4nFBxkQ-1; Thu, 15 Apr 2021 19:11:52 -0400
X-MC-Unique: 3_9hY8ujOpSPBxn4nFBxkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21BFB1883521;
        Thu, 15 Apr 2021 23:11:51 +0000 (UTC)
Received: from localhost (thegoat.4a2m.lab.eng.bos.redhat.com [10.16.209.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 026C25D71F;
        Thu, 15 Apr 2021 23:11:41 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: nvme: decouple basic ANA log page re-read support from native multipathing
Date:   Thu, 15 Apr 2021 19:11:25 -0400
Message-Id: <20210415231126.8746-3-snitzer@redhat.com>
In-Reply-To: <20210415231126.8746-1-snitzer@redhat.com>
References: <20210415231126.8746-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BZ: 1948690
Upstream Status: RHEL-only

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

rhel-8.git commit b904f4b8e0f90613bf1b2b9d9ccad3c015741daf
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Tue Aug 25 21:52:47 2020 -0400

    [nvme] nvme: decouple basic ANA log page re-read support from native multipathing
    
    Message-id: <20200825215248.2291-10-snitzer@redhat.com>
    Patchwork-id: 325179
    Patchwork-instance: patchwork
    O-Subject: [RHEL8.3 PATCH 09/10] nvme: decouple basic ANA log page re-read support from native multipathing
    Bugzilla: 1843515
    RH-Acked-by: David Milburn <dmilburn@redhat.com>
    RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
    RH-Acked-by: Ewan Milne <emilne@redhat.com>
    
    BZ: 1843515
    Upstream Status: RHEL-only
    
    Whether or not ANA is present is a choice of the target implementation;
    the host (and whether it supports multipathing) has _zero_ influence on
    this.  If the target declares a path as 'inaccessible' the path _is_
    inaccessible to the host.  As such, ANA support should be functional
    even if native multipathing is not.
    
    Introduce ability to always re-read ANA log page as required due to ANA
    error and make current ANA state available via sysfs -- even if native
    multipathing is disabled on the host (e.g. nvme_core.multipath=N).
    
    This affords userspace access to the current ANA state independent of
    which layer might be doing multipathing.  It also allows multipath-tools
    to rely on the NVMe driver for ANA support while dm-multipath takes care
    of multipathing.
    
    And as always, if embedded NVMe users do not want any performance
    overhead associated with ANA or native NVMe multipathing they can
    disable CONFIG_NVME_MULTIPATH.
    
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>

---
 drivers/nvme/host/core.c      |    2 ++
 drivers/nvme/host/multipath.c |   23 ++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |    4 ++++
 3 files changed, 24 insertions(+), 5 deletions(-)

Index: linux-rhel9/drivers/nvme/host/core.c
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/core.c
+++ linux-rhel9/drivers/nvme/host/core.c
@@ -347,6 +347,8 @@ static inline void nvme_end_req_with_fai
 	if (unlikely(nvme_status & NVME_SC_DNR))
 		goto out;
 
+	nvme_update_ana(req);
+
 	if (!blk_path_error(status)) {
 		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
 			 blk_status_to_errno(status));
Index: linux-rhel9/drivers/nvme/host/multipath.c
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/multipath.c
+++ linux-rhel9/drivers/nvme/host/multipath.c
@@ -65,10 +65,25 @@ void nvme_set_disk_name(char *disk_name,
 	}
 }
 
+static inline void __nvme_update_ana(struct nvme_ns *ns)
+{
+	if (!ns->ctrl->ana_log_buf)
+		return;
+
+	set_bit(NVME_NS_ANA_PENDING, &ns->flags);
+	queue_work(nvme_wq, &ns->ctrl->ana_work);
+}
+
+
+void nvme_update_ana(struct request *req)
+{
+	if (nvme_is_ana_error(nvme_req(req)->status))
+		__nvme_update_ana(req->q->queuedata);
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & 0x7ff;
 	unsigned long flags;
 
 	nvme_mpath_clear_current_path(ns);
@@ -78,10 +93,8 @@ void nvme_failover_req(struct request *r
 	 * ready to serve this namespace.  Kick of a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
-	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
-		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
-		queue_work(nvme_wq, &ns->ctrl->ana_work);
-	}
+	if (nvme_is_ana_error(nvme_req(req)->status))
+		__nvme_update_ana(ns);
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
Index: linux-rhel9/drivers/nvme/host/nvme.h
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/nvme.h
+++ linux-rhel9/drivers/nvme/host/nvme.h
@@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
+void nvme_update_ana(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(ch
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_update_ana(struct request *req)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }

