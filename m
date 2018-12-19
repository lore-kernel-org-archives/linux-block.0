Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CABC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC7C20874
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259407;
	bh=khG0VTDSS0TEceC5lmWb1tQDGcGirTIvbpPWt9IY/SY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t0X+8R2d6tE/2+4Sb54NxAfxi7aGHgA2ht0nujT0eHo2A3qn66jz5Cuo9nSMA9T1Y
	 q4zOPrMdsxNUg6ttBy7FFYOS99RoTjoswSwERE5KzF4+wvmlAp0VRirNU+tjJdRGFD
	 n+jYfY8mKK6sZGx5zSxhS8CIyWYAwxY3HkDDBu7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeLSWn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:43:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37779 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSWn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 17:43:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so21413862qtt.4;
        Wed, 19 Dec 2018 14:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0eHvRoBrCDiLr1EMXsJ+QvqbIlFS3bCPji7tPHogKgc=;
        b=fy0N6wUPp50tDVcOX59zVOQeJW924Mx2/hmJTP7Bwp1I/TA9l8eFl/6iApRFcU+Tao
         jyjyllsTU0AFLqQvTrBO4AegWxfVGLbY5AK/lPJ+5Djd8nxTwleZTcLSZWdFSC8Wdtvc
         AN7N/P9Jxe7q1HdxDTCb1nEguI2hFH+torUP/bzx4o+gK+6iT6ZBmy8ZO0QHhjP0zMuK
         JnF7W/i1URob9mmVCISzQl+ELwrnuM+LlbRC3q2pOzzHBLdcly+V/xjJF2M8Ho2rsdf5
         y9cGT6jnjCAhIsICtWNYRq4Qr/T0uwTgxEvisUJjuVFNlkFIeROYuKG9A/V3MaYA5oZ5
         m+SA==
X-Gm-Message-State: AA+aEWZDeDkuH+7E12jblphi2EBScM1dx1J0pNIbzx1bZheoQ2kv8XCG
        rLEKGwd4YQs8uoII3GSkIu4=
X-Google-Smtp-Source: AFSGD/WtTAhpiwxDoNDSD4dW7meye5d/ykqXDyOH1OXxX582bqDkkNoj94C4RfvgPua8OtNQztt56A==
X-Received: by 2002:a0c:b044:: with SMTP id l4mr23755408qvc.80.1545259405124;
        Wed, 19 Dec 2018 14:43:25 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id o34sm2297817qte.4.2018.12.19.14.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 14:43:24 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: clean up blkg_tryget_closest()
Date:   Wed, 19 Dec 2018 16:43:21 -0600
Message-Id: <20181219224321.32624-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The implementation of blkg_tryget_closest() wasn't super obvious and
became a point of suspicion when debugging [1]. So let's clean it up so
it's obviously not the problem.

[1] https://lore.kernel.org/linux-block/a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk/

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/blk-cgroup.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f025fd1e22e6..76c61318fda5 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -499,22 +499,33 @@ static inline void blkg_get(struct blkcg_gq *blkg)
  */
 static inline bool blkg_tryget(struct blkcg_gq *blkg)
 {
-	return percpu_ref_tryget(&blkg->refcnt);
+	return blkg && percpu_ref_tryget(&blkg->refcnt);
 }
 
 /**
  * blkg_tryget_closest - try and get a blkg ref on the closet blkg
  * @blkg: blkg to get
  *
- * This walks up the blkg tree to find the closest non-dying blkg and returns
- * the blkg that it did association with as it may not be the passed in blkg.
+ * This needs to be called rcu protected.  As the failure mode here is to walk
+ * up the blkg tree, this ensure that the blkg->parent pointers are always
+ * valid.  This returns the blkg that it ended up taking a reference on or %NULL
+ * if no reference was taken.
  */
 static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 {
-	while (blkg && !percpu_ref_tryget(&blkg->refcnt))
+	struct blkcg_gq *ret_blkg = NULL;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	while (blkg) {
+		if (blkg_tryget(blkg)) {
+			ret_blkg = blkg;
+			break;
+		}
 		blkg = blkg->parent;
+	}
 
-	return blkg;
+	return ret_blkg;
 }
 
 /**
-- 
2.17.1

