Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B382C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DDB2086A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osE8Z3S2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DDB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeKPXUj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:20:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeKPXUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 18:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rBJZ53f3zea3swUYpw2mgfm7abw5jZrZWZpTl6sP6kk=; b=osE8Z3S2G6NC1Bq88zNzviyxKs
        xbT+hvIfxbGGiqJCAaNMUsLetpo9RfcCyM5Ae43gq02EH+HUKP2LUG6P9iWwoY+jecpREc9Y2GGkH
        pacpgDasK6MicZBb5oLP7+OHC3ABiQR0DP2GWiI3ixQCJ94DhNjn4Ob+3+DKYKKLix3j9iwiyHwjK
        O4V8abof2oW6KHsZvrCdvWMbE/IHMOgLFT8FKFLIdhmSeKQ4Dc2RjMZEeyIreKofUKVM2PMWIvyui
        RXMahtrijYbs/yu1QT1mkzaxotM1FyUZKuA+5dAPOaKH+PTLD5JmvslgQ1y6D9cnZa2HtCfqBl6Yi
        4Fw+yrcA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNdr3-0004yM-6q; Fri, 16 Nov 2018 13:08:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 2/2] nvme: create slaves/holder entries for multipath devices
Date:   Fri, 16 Nov 2018 14:08:05 +0100
Message-Id: <20181116130805.16225-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116130805.16225-1-hch@lst.de>
References: <20181116130805.16225-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows tools like distro installers easily track the relationship.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      |  5 +++--
 drivers/nvme/host/multipath.c | 12 ++++++++++--
 drivers/nvme/host/nvme.h      | 12 ++++++++----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f172d63db2b5..ff0ce5ef1040 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -371,7 +371,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_remove_nshead(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct_quiesced(&head->srcu);
@@ -3118,7 +3118,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 
-	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_ns(ns, id);
 	nvme_fault_inject_init(ns);
 	kfree(id);
 
@@ -3142,6 +3142,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_ns(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b82b0d3ca39a..457d5ad7cfe9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -515,7 +515,7 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
+void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		mutex_lock(&ns->ctrl->ana_lock);
@@ -528,9 +528,17 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		nvme_mpath_set_live(ns);
 		mutex_unlock(&ns->head->lock);
 	}
+
+	bd_link_disk_holder(&ns->disk->part0, ns->head->disk);
+}
+
+void nvme_mpath_remove_ns(struct nvme_ns *ns)
+{
+	if (ns->head->disk)
+		bd_unlink_disk_holder(&ns->disk->part0, ns->head->disk);
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 32a1f1cfdfb4..e20353bbf6a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -470,8 +470,9 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
-void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id);
+void nvme_mpath_remove_ns(struct nvme_ns *ns);
+void nvme_mpath_remove_nshead(struct nvme_ns_head *head);
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
@@ -515,11 +516,14 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
+static inline void nvme_mpath_add_ns(struct nvme_ns *ns,
 		struct nvme_id_ns *id)
 {
 }
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_remove_ns(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
-- 
2.19.1

