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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553CAC433E1
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C71922B40
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LRMCQo84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHDJHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgHDJHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA9C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so37716911qkk.7
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwc5XEl4O2o+hE7DRlQUfDXCQqqEy1KsOMTAIWJ0v2c=;
        b=LRMCQo84cVdwZs7SmQZ2KVjI/s9F9duVyO4m8CpGSIkQfefpPpPYnZd8ReWXQv6aWJ
         HC9ltOsNi5R2njnkcToSjB/+TPtEi5jATfTx0kwTd2SBhNZX1JXMIOgfT+bn8+8xAn0+
         RfTtK4q96m2EhBOnzCtYsVa8V8Ax2c52Ps7Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwc5XEl4O2o+hE7DRlQUfDXCQqqEy1KsOMTAIWJ0v2c=;
        b=D2f8e7RswuIrTqcREzoDJzxdQr4vq5rhJNGG2uL+W/TbHFXHq5fH7LEo+cB/eGEdmU
         6ghjNWJhBltmoFYZjiW5e89UrNB7Mx2J/5pwsqImBsHh+mb79AF/a7rGl5+sKT3B03IG
         d44LLb2o87Iq9M5kaTv4dxiUHmIRYBBMlLj7jiv0uoxsAZ7FjYrG705mo539z3W0cHT6
         gKdI4gy0iJYxeMEXhFJ9Hr3HaQZR1tN3jV8HM+ftRS/C9t1ehvi18lyNFE5Ze5/v4BHr
         Tj40tsrBnZbKQlLTKxU7KP50q7AB7WEt9a+MLb2elYVIAHU/5w5agxldvnSn6QM5tFPM
         kOuw==
X-Gm-Message-State: AOAM533/GdDLZ2x6db1g/3MXRYXE2+oysDEk8e0pw5LsTcMvNMOWx3MK
        ieZctlqrU0d/HEwmtaA1lRuyXQH7ecIoV8bC98f2Ch2AABiEagjilT7KI7ZX/5A7yrQSBAePkfp
        6li36OiwUkyelKzLi6hCG10PvK1FBHtgxa1OQTNa02OW4KUbOjJpeOqGNHkyTFnBoauVo1ISpi8
        ozSvhhX9c=
X-Google-Smtp-Source: ABdhPJxcYPU6ndIfIW886pQZVBvPhSelG22PDsuvFqDuXTnc6W6ms5YLZ+omNJNHzu+m5cahi/euiw==
X-Received: by 2002:a05:620a:15e5:: with SMTP id p5mr13829126qkm.414.1596532040818;
        Tue, 04 Aug 2020 02:07:20 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:20 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 05/16] lpfc: vmid: Forward declarations for APIs
Date:   Tue,  4 Aug 2020 07:43:05 +0530
Message-Id: <1596507196-27417-6-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch contains the forward declarations of commonly used APIs which
are used outside the scope of the file.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 782f6f76f18a..74ca5860ca8e 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -600,3 +600,14 @@ extern int lpfc_enable_nvmet_cnt;
 extern unsigned long long lpfc_enable_nvmet[];
 extern int lpfc_no_hba_reset_cnt;
 extern unsigned long lpfc_no_hba_reset[];
+
+/* vmid interface */
+int lpfc_vmid_uvem(struct lpfc_vport *vport, struct lpfc_vmid *vmid, bool ins);
+u32 lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport);
+int lpfc_vmid_cmd(struct lpfc_vport *vport,
+		  int cmdcode, struct lpfc_vmid *vmid);
+int lpfc_vmid_hash_fn(char *vmid, int len);
+struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
+					      u32 hash, u8 *buf);
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
+int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
-- 
2.18.2

