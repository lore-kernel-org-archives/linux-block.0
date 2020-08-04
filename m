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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BCC433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182BB206DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XdKKdxmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHDJHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgHDJHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1557C061756
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l13so12305356qvt.10
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QQ5SWJbXNQxm9XdpbHedBI4tomXq7IgJ5hXPLUA4gnk=;
        b=XdKKdxmi4CeJxMFtqCyOGx687HcP7gqA2YosCNiQqgmLuSQz+3M1lDbEA1UFQYiN6B
         /flf3Uy3rANVRZE4eRpArw2c2C1Sva0T2XzcxZym5IJ/sC7isx4YKbhOrTaXOI7nrkie
         FaVbOeNodHGf9RM08NDKYQwLPkkEoeDqQmW/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QQ5SWJbXNQxm9XdpbHedBI4tomXq7IgJ5hXPLUA4gnk=;
        b=amfuAodvqud3p6Z+M28lytm0er1oJ7ye11ia6zEhEAZ+yJe0+WYI0I91qDJJbzs42Z
         ZCJmUzeVelHdS0iXl+zZE73isgKWR4NYlYL0ixPR7PqAAQDoXR0Fx03bgz3xPdWj0b3L
         LZu44WPgDy1wIOggrpsH/HdWbZhFu1n+GELV3qAdu+PXicX+7v3suWMmIeLlHe8M8dUy
         +5UMw/rVjiGs4TfK2rAXRVIYd5Zt4Esi34eD/bM4yMjyx1VnVJAqX9or7uHNhQw39MPF
         slEniJy+kLHxpPRq3jq7KmnYumMJWRWScQgb+mjW7MWWWLoxSmokHnKGUlBL5AVfY9mz
         UxsA==
X-Gm-Message-State: AOAM530BkOgoMaN+RQPrFZN1rRHi19eMIRua4bcExDHAszQzPXYk42LW
        WquqDEdLaHEf4MCyqwZxyEYawHz9so0cSzt7bcI/WDhZ0SjzIPpauhWKdAoccho2NQ2bH13FNYR
        Kezt9fut40MH2mChUbm4wadb955J9MDfbm1D9Piif6YWxle4gcpEPorgq9rnRF5LbXRCAD5KMiq
        uKKJ6BfnM=
X-Google-Smtp-Source: ABdhPJxzTwtI4/EtEsPogoTFux2DkrCKTIJSa+agw5CO+iGLn1CTdIL5eu2ZQYRmZ5Dw4RSajWt+Tw==
X-Received: by 2002:a0c:9b89:: with SMTP id o9mr9460302qve.77.1596532033660;
        Tue, 04 Aug 2020 02:07:13 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:13 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 03/16] lpfc: vmid: API to check if VMID is enabled.
Date:   Tue,  4 Aug 2020 07:43:03 +0530
Message-Id: <1596507196-27417-4-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This API will determine if VMID is enabled by the user or not.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 4258d05a7032..1b950d6641a2 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1507,3 +1507,27 @@ static const char *routine(enum enum_name table_key)			\
 	}								\
 	return name;							\
 }
+
+/**
+ * lpfc_is_vmid_enabled - returns if VMID is enabled for either switch types
+ * @phba: Pointer to HBA context object.
+ *
+ * Relationship between the enable, target support and if vmid tag is required
+ * for the particular combination
+ * ---------------------------------------------------
+ * Switch    Enable Flag  Target Support  VMID Needed
+ * ---------------------------------------------------
+ * App Id     0              NA              N
+ * App Id     1               0              N
+ * App Id     1               1              Y
+ * Pr Tag     0              NA              N
+ * Pr Tag     1               0              N
+ * Pr Tag     1               1              Y
+ * Pr Tag     2               *              Y
+ ---------------------------------------------------
+ *
+ **/
+static inline int lpfc_is_vmid_enabled(struct lpfc_hba *phba)
+{
+	return phba->cfg_vmid_app_header || phba->cfg_vmid_priority_tagging;
+}
-- 
2.18.2

