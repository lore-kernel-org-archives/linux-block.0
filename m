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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E6C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A7D206DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d+HZH/bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgHDJH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgHDJHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698FC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so37686606qke.11
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w2O4WXjjgCfyGgKQCGUU014IFp1lecEtROCJ3ny281Y=;
        b=d+HZH/bjwjyD9eXG1VDAC/lcc21j2mCmOKq4izP144xckLW0aI0k8/3uEKNbbdYhuy
         4nHh8vZdM4y6B6FA4crU/xtzjbIVBRepAXM0QSLYPy7hZNZ5kzJCXhpEXAHrcHKRyG90
         O73IfqknUM87TaGdPm11CKBr5+CKdQEhKVrNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w2O4WXjjgCfyGgKQCGUU014IFp1lecEtROCJ3ny281Y=;
        b=XZOhAHxf/eMbv3VXvqETdR2T+hXXSlpCktQ75G7DtgAuGFQIkTdYuJZUEq2C3adURL
         05Rand6y8Q8fQRH24p8yCPdcSqAvOBr7uIKuMbAFb/rs2TkEkNp83jRJF3qJ1ocfi6KC
         l605woJzcOUZ5jDY7JDCAd7rbIpkfRU21jcpKF6zAkiVbGsgkmJIGTrqO6uimptUx2hW
         ZRV5bRq5Cx/9Aa7nvgXeehf2q/ACgRc73yu2GJIwWG88eukEJdrDVe50rZpOkn2PrJ6X
         XiIfl8NTmahnctIXb2BsD8xrdSk9tG++SVb3E/b8Xydp6wdKVH4A+W8SlJUrj/d1CLii
         KG+g==
X-Gm-Message-State: AOAM533xVMY6LGRhkEXYROeRy9sP4Pbz9ZGdlXxIL9W5KLwof+lGNN+K
        VjVYXONA3tbTTv+QhGzkeJp6vPQ4L+nrXdbCN/5BalRyIItUPxuZC5lxHeUZJDGsKoomxDNcbht
        ylM2/U2K0fZlsmRNfAPPe+//Q+YM9lH3VH0kk+zCDNFvT5ET9RGWd3cwDlUrNX3mot6uvEeZDKh
        WHFjPPenI=
X-Google-Smtp-Source: ABdhPJyT13GLpK3Yn4EeI2k7NnlsAKa4tkKUs6IFKTbVjMKiw7f4IDGl2nBZW+u+c3wSxx2ZTeVp1g==
X-Received: by 2002:a37:674d:: with SMTP id b74mr20684840qkc.84.1596532044198;
        Tue, 04 Aug 2020 02:07:24 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:23 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 06/16] lpfc: vmid: Add support for vmid in mailbox command
Date:   Tue,  4 Aug 2020 07:43:06 +0530
Message-Id: <1596507196-27417-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds supporting datastructures for mailbox command which helps
in determining if the firmware supports appid or not.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_hw4.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index c4ba8273a63f..56be81002cb2 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -272,6 +272,9 @@ struct lpfc_sli4_flags {
 #define lpfc_vfi_rsrc_rdy_MASK		0x00000001
 #define lpfc_vfi_rsrc_rdy_WORD		word0
 #define LPFC_VFI_RSRC_RDY		1
+#define lpfc_ftr_ashdr_SHIFT            4
+#define lpfc_ftr_ashdr_MASK             0x00000001
+#define lpfc_ftr_ashdr_WORD             word0
 };
 
 struct sli4_bls_rsp {
@@ -2943,6 +2946,9 @@ struct lpfc_mbx_request_features {
 #define lpfc_mbx_rq_ftr_rq_mrqp_SHIFT		16
 #define lpfc_mbx_rq_ftr_rq_mrqp_MASK		0x00000001
 #define lpfc_mbx_rq_ftr_rq_mrqp_WORD		word2
+#define lpfc_mbx_rq_ftr_rq_ashdr_SHIFT          17
+#define lpfc_mbx_rq_ftr_rq_ashdr_MASK           0x00000001
+#define lpfc_mbx_rq_ftr_rq_ashdr_WORD           word2
 	uint32_t word3;
 #define lpfc_mbx_rq_ftr_rsp_iaab_SHIFT		0
 #define lpfc_mbx_rq_ftr_rsp_iaab_MASK		0x00000001
@@ -2974,6 +2980,9 @@ struct lpfc_mbx_request_features {
 #define lpfc_mbx_rq_ftr_rsp_mrqp_SHIFT		16
 #define lpfc_mbx_rq_ftr_rsp_mrqp_MASK		0x00000001
 #define lpfc_mbx_rq_ftr_rsp_mrqp_WORD		word3
+#define lpfc_mbx_rq_ftr_rsp_ashdr_SHIFT         17
+#define lpfc_mbx_rq_ftr_rsp_ashdr_MASK          0x00000001
+#define lpfc_mbx_rq_ftr_rsp_ashdr_WORD          word3
 };
 
 struct lpfc_mbx_supp_pages {
@@ -4383,6 +4392,9 @@ struct wqe_common {
 #define wqe_nvme_SHIFT        4
 #define wqe_nvme_MASK         0x00000001
 #define wqe_nvme_WORD         word10
+#define wqe_appid_SHIFT       5
+#define wqe_appid_MASK        0x00000001
+#define wqe_appid_WORD        word10
 #define wqe_oas_SHIFT         6
 #define wqe_oas_MASK          0x00000001
 #define wqe_oas_WORD          word10
-- 
2.18.2

