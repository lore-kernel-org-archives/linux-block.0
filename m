Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246CC433E1
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8F922B45
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bZx+qeQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgHDJHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgHDJHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8EC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so36026637qkn.4
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bj4lP8kXGq9EEmnYvOw1C7HGTKb+GmEaUZ3cDS8+HA4=;
        b=bZx+qeQd3Uum5k56rhDJ1mNAInEGOt7zpz5SaNfyuWrN9DBpPPFaxU5U2/KDO7r42r
         OURTq6B/NUvInZvSIdBuJ07dL2wy55aVZA81JJXIrTg/C7vChMTTBOdIRJIoK072Cpv9
         Mangworc+tmbsyklJRmkeaWYGafVYNY17gISA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bj4lP8kXGq9EEmnYvOw1C7HGTKb+GmEaUZ3cDS8+HA4=;
        b=at03APwRMhKUso3VauPdtcuN+5brw81x4MPq5azkBbwX1NpnhmzdsSn2GUhQxdSmUV
         WiCZrfesqxHKpM3Y64jj+JhsJ+ZcJafgX62TJjbLG+NQn0Ire2VJy+MMfvXcIhxwz9oU
         6DyAEmpkUuL9o1myP2s3GmzNJuVGPH4NxWk7AHDk3VnxO8S5c+WvJJTBhdmhBz2aLO8k
         ZN457WEdhyINjzb29v5PwY8N5Kdo6kE0F58jbzMufjmaW6kH+bqGGSif9MKIv4FB2mUU
         EizzKbRwhCsFu5E+RFHn2AWpxvjyvGJnEAu2//KPMis5tIwg5A5cJN++jBi6YDiTRI9Y
         1KLQ==
X-Gm-Message-State: AOAM530L0c5eRpL0ONtWxETtwXAuFk+y2dzKcygW+b0YoBFn0/UEjpn/
        J+qgP9ymoGvkrga5gCkpwuUwb34gOROfFVLtpT3og4Q1BXItVhWvc3VGLFm9rCohGlf3i25nE0w
        1eTt9umK/5hMZFKo3WgW+RR0b3AU2zCR3NDqCuuJZJy3K/d7bV4XmbyTVQq/LRKhjVVEfnGEiRr
        lTXxLJUhs=
X-Google-Smtp-Source: ABdhPJwfTohWPVYYMc/l8Y/1+QrLNjJ6MaDwmh2626IM/UVMNQsHKSXaXeZIULstREwMiW2FIDwxCA==
X-Received: by 2002:a05:620a:12bb:: with SMTP id x27mr21335237qki.202.1596532055379;
        Tue, 04 Aug 2020 02:07:35 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:34 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 09/16] lpfc: vmid: cleanup vmid resources
Date:   Tue,  4 Aug 2020 07:43:09 +0530
Message-Id: <1596507196-27417-10-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

The patch cleans up the vmid resources and stops the timer.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_init.c |  4 ++++
 drivers/scsi/lpfc/lpfc_scsi.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 2936a15f7441..419d7372e5c5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -2843,6 +2843,10 @@ lpfc_cleanup(struct lpfc_vport *vport)
 	if (phba->link_state > LPFC_LINK_DOWN)
 		lpfc_port_link_failure(vport);
 
+	/* cleanup vmid resources */
+	if (lpfc_is_vmid_enabled(phba))
+		lpfc_vmid_vport_cleanup(vport);
+
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 		if (!NLP_CHK_NODE_ACT(ndlp)) {
 			ndlp = lpfc_enable_node(vport, ndlp,
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 5e802c8b22a9..7bc1fd69b715 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4711,6 +4711,27 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+/*
+ * lpfc_vmid_vport_cleanup - cleans up the resources associated with a vports
+ * @vport: The virtual port for which this call is being executed.
+ */
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport)
+{
+	/* delete the timer */
+	if (vport->port_type == LPFC_PHYSICAL_PORT)
+		del_timer_sync(&vport->phba->inactive_vmid_poll);
+
+	/* free the resources */
+	kfree(vport->qfpa_res);
+	kfree(vport->vmid_priority.vmid_range);
+	kfree(vport->vmid);
+
+	/* reset variables */
+	vport->qfpa_res = NULL;
+	vport->vmid_priority.vmid_range = NULL;
+	vport->vmid = NULL;
+	vport->cur_vmid_cnt = 0;
+}
 
 /**
  * lpfc_abort_handler - scsi_host_template eh_abort_handler entry point
-- 
2.18.2

