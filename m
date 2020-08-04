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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59066C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB57206DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ePbFfpj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgHDJH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgHDJH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB62C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so37685358qkg.9
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htdOL8CfA1VZWCEu5uaNepps9GbMwF2R3lwfXSRykbs=;
        b=ePbFfpj4PJrg+pXpXl+AMV7n6SheIURob1uNgC8p+94gT6WWsMBI0cN5GRSNIRwjcT
         OV03gh1J+6Hse8PKn5eaHZ6JR2yPS++GlwniW7UsqJT3ftfw9ygy9eLG+iF7PuBo1dTu
         9eB9LKdbWA+uweiOIfUzgS8wjZBMBo5/Qkiw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=htdOL8CfA1VZWCEu5uaNepps9GbMwF2R3lwfXSRykbs=;
        b=uAhT6YU0+KlBPf+q2RDOAlVXZw8mM9+Bj3YQsNrRpeF1+tAQNu8TnhTVPLDvROHYrV
         XfnAGTRlVgLP39C1xuqV51x2VxqyQZdHD4mnXXPR55PbtfTXUV2sDjEUbbVIVEEwDc6s
         pVRubp6KKEsaf5Dxez61wzbYazQlLZc69E/uMTFhyu+kLVCKGHuzTfIglqyuLvqVkH7V
         wQqtRMJGl3KpeIJ4tLn03equZ2l1GHq+j7LU+dkkU5VFyZzPTEDMX1qAoS6DH0lAMgPK
         n+JTTJCDWXGsxJinrmEJKtc2D2+bQ8qvp/toeYDpyGBro6SCtgqr8U02FsHxpCYYXTz0
         ZrPQ==
X-Gm-Message-State: AOAM532TEZrqfR1ZkLIiRJO1LVke1o2EXKxvLdLM1fjevewYr8ySOJjc
        t5SkWKyta8SgcJqPEwD0POwu04L7haPuo87eDM6zdvDJ39bFzs1PGMXjPyVQGzpJvYwTv8s4KXN
        tTn+tclLak3tiJsPWHz0xvPq/MrL+frxrWbV0NEqsi1hSDCkNjVTP6OL+FU0s4xkqijMGMJCf9T
        3F+CzeCMc=
X-Google-Smtp-Source: ABdhPJz46oy7g52lf6N53qsGIBT0AP8QdkwYhffSXmAiDwm6bgdNylkb160rBnd7HmbX6aq0Y4IE1A==
X-Received: by 2002:a37:4c84:: with SMTP id z126mr20636949qka.130.1596532047872;
        Tue, 04 Aug 2020 02:07:27 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:27 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 07/16] lpfc: vmid: VMID params initialization
Date:   Tue,  4 Aug 2020 07:43:07 +0530
Message-Id: <1596507196-27417-8-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch initializes the VMID parameters like the type of vmid, max
number of vmids supported and timeout value for the vmid registration
based on the user input.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index a62c60ca6477..e1aa094ff83d 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -6139,6 +6139,44 @@ LPFC_BBCR_ATTR_RW(enable_bbcr, 1, 0, 1, "Enable BBC Recovery");
  */
 LPFC_ATTR_RW(enable_dpp, 1, 0, 1, "Enable Direct Packet Push");
 
+/*
+ * lpfc_max_vmid: Maximum number of VMs to be tagged. This is valid only if
+ * either vmid_app_header or vmid_priority_tagging is enabled.
+ *       4 - 255  = vmid support enabled for 4-255 VMs
+ *       Value range is [4,255].
+ */
+LPFC_ATTR_RW(max_vmid, LPFC_MIN_VMID, LPFC_MIN_VMID, LPFC_MAX_VMID,
+	     "Maximum number of VMs supported");
+
+/*
+ * lpfc_vmid_inactivity_timeout: Inactivity timeout duration in hours
+ *       0  = Timeout is disabled
+ * Value range is [0,24].
+ */
+LPFC_ATTR_RW(vmid_inactivity_timeout, 4, 0, 24,
+	     "Inactivity timeout in hours");
+
+/*
+ * lpfc_vmid_app_header: Enable App Header VMID support
+ *       0  = Support is disabled (default)
+ *       1  = Support is enabled
+ * Value range is [0,1].
+ */
+LPFC_ATTR_RW(vmid_app_header, LPFC_VMID_APP_HEADER_DISABLE,
+	     LPFC_VMID_APP_HEADER_DISABLE, LPFC_VMID_APP_HEADER_ENABLE,
+	     "Enable App Header VMID support");
+
+/*
+ * lpfc_vmid_priority_tagging: Enable Priority Tagging VMID support
+ *       0  = Support is disabled (default)
+ *       1  = Support is enabled
+ * Value range is [0,1]..
+ */
+LPFC_ATTR_RW(vmid_priority_tagging, LPFC_VMID_PRIO_TAG_DISABLE,
+	     LPFC_VMID_PRIO_TAG_DISABLE,
+	     LPFC_VMID_PRIO_TAG_ALL_TARGETS,
+	     "Enable Priority Tagging VMID support");
+
 struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_nvme_info,
 	&dev_attr_scsi_stat,
@@ -6256,6 +6294,10 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_ras_fwlog_func,
 	&dev_attr_lpfc_enable_bbcr,
 	&dev_attr_lpfc_enable_dpp,
+	&dev_attr_lpfc_max_vmid,
+	&dev_attr_lpfc_vmid_inactivity_timeout,
+	&dev_attr_lpfc_vmid_app_header,
+	&dev_attr_lpfc_vmid_priority_tagging,
 	NULL,
 };
 
@@ -7309,6 +7351,11 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_enable_hba_heartbeat_init(phba, lpfc_enable_hba_heartbeat);
 
 	lpfc_EnableXLane_init(phba, lpfc_EnableXLane);
+	/* VMID Inits */
+	lpfc_max_vmid_init(phba, lpfc_max_vmid);
+	lpfc_vmid_inactivity_timeout_init(phba, lpfc_vmid_inactivity_timeout);
+	lpfc_vmid_app_header_init(phba, lpfc_vmid_app_header);
+	lpfc_vmid_priority_tagging_init(phba, lpfc_vmid_priority_tagging);
 	if (phba->sli_rev != LPFC_SLI_REV4)
 		phba->cfg_EnableXLane = 0;
 	lpfc_XLanePriority_init(phba, lpfc_XLanePriority);
-- 
2.18.2

