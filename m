Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804EC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823DE223E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgLWTbH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 14:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgLWTbG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 14:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608751780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xTTbekLN43CvnFCG6plT22h7BWmUKb8wS413UYgxl6o=;
        b=dNFAjN1e0CpkqB3mc7/hKiJ54sBQaI/LtaJaRV0tpEYVmbeB0S+ZKvAAvcM2gtwcM11QEJ
        ZWipewgrKdQo8DxID3V7FqnP+y3atNU+am/n3dI8ztyFXjgqOhwedfYxV4/PBXWYTy8Q7R
        vva994csvUPP0e2yd/UGdGr5om5zhZg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-c_w8vm8KNUSQ9CkreqQbRg-1; Wed, 23 Dec 2020 14:29:38 -0500
X-MC-Unique: c_w8vm8KNUSQ9CkreqQbRg-1
Received: by mail-qv1-f71.google.com with SMTP id cc1so185833qvb.3
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 11:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTTbekLN43CvnFCG6plT22h7BWmUKb8wS413UYgxl6o=;
        b=BB51qmB0K2VY4oRB5aFxiArbdvPgNcpmcu/8UeXCNhvOrpO/JnlCyaUo9EeWVT318H
         XqFpm03GVpz+BPel/pkuoNRJoq6Lx90+5uLVuxvlKBpOw+S7fKvaQZT0C4f4zU9sPWhB
         aAm/IVRhMBAa/8s4yzIzu7pBmYHOTeSxRVNpX25V6WEqep0u1/ymTIevply/spIOI8ny
         /zWo/Ru0WWQlmiixRIYEP6PmUpye3mEbVL+B5Mi+Rd5pv0f548oUZmIWFEjy8v8JpKma
         v5580J28KEIZPgSvpeqdsMcnVbsmESqd3A5GUaw0B8zrM3JFsjXZJqzzhbieT7sEQ+vd
         /dzw==
X-Gm-Message-State: AOAM533zkWZg1SdbD/ZMGJmyZOesuiODVKGCku9scbqf5aaVpr8C6XdU
        W9SHn/HuVfmoh5qk74SDayx4JBG7gfyXlyuHSiGKZFkfL7r2pDIoqFh1KS2SdKGoVqLnxVHq/VS
        SGTID3bdqR3D9F0e+jvfvWZo=
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr28621408qkg.473.1608751778126;
        Wed, 23 Dec 2020 11:29:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCjxF568qOP1Tpkyc6qjgmXjcXnP0DqGEG1lwU+eDQXT9IQQVeZD9PTcl5sEtpqni/aPJymg==
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr28621392qkg.473.1608751777904;
        Wed, 23 Dec 2020 11:29:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a11sm15407136qtd.19.2020.12.23.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:29:37 -0800 (PST)
From:   trix@redhat.com
To:     jonathan.derrick@intel.com, revanth.rajashekar@intel.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] block: sed-opal: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:29:31 -0800
Message-Id: <20201223192931.122370-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadbb88ca..9be24559ee9a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2540,7 +2540,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 
 		ret = __opal_lock_unlock(dev, &suspend->unlk);
 		if (ret) {
-			pr_debug("Failed to unlock LR %hhu with sum %d\n",
+			pr_debug("Failed to unlock LR %u with sum %d\n",
 				 suspend->unlk.session.opal_key.lr,
 				 suspend->unlk.session.sum);
 			was_failure = true;
-- 
2.27.0

