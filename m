Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E634C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E687420851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeLDSgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:40 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33916 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLDSgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:20 -0500
Received: by mail-yw1-f67.google.com with SMTP id g75so7407940ywb.1;
        Tue, 04 Dec 2018 10:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJQmC45q0sHPUKqFY2eBFa9J9cofiA6jo93q1bYXOEY=;
        b=p4wskd8r2gbeM5Vb45XWNFcTrDuYamrkk5zKmLAULa1aseM9m7rdLWhKcB4agjbRnP
         3i4xm3d//eqJxq9uVtiGO8cNzk9y6evQX/J1K4DmH7OM6yOa+x5LjeSfBFFvTRAGS6lK
         7I2yQb/7MzfbpJJZhXB8AAcCc+pEPa0dMQkQ1pzrHk06IBOQ6va2zJPObJRN2VfUPwgi
         2CLGhXRmVvFLtfiAheMZuXnn+OS5mIP9evBJcPBImyxrHZFx718KaSyT1SAMb4QpVKIn
         dTkszcuVWoXcBW8JoD9QUspuAFwJ3cqIgqODC4WfQ5eUyvz7oPmrpGPZHFOUR8HrxaHj
         DF/g==
X-Gm-Message-State: AA+aEWbrxv9wtvjnzFP00Ka0UQA/jXyj2hGWrz/slUFCQe4WE4s7AmLE
        JbyLaozU3ilvJ9Gx2q22BLVfCQVVqHQ=
X-Google-Smtp-Source: AFSGD/Wg1rF8zoY3ZEdGW9CSsUJA2odbV4C5lyx41J7/4TAGK1URHIWFVV+fHASXlEMKYiIBq6eEVg==
X-Received: by 2002:a81:c90d:: with SMTP id o13mr22130543ywi.348.1543948579745;
        Tue, 04 Dec 2018 10:36:19 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:18 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/14] blkcg: remove bio_disassociate_task()
Date:   Tue,  4 Dec 2018 13:35:58 -0500
Message-Id: <20181204183600.99746-13-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that a bio only holds a blkg reference, so clean up is simply
putting back that reference. Remove bio_disassociate_task() as it just
calls bio_disassociate_blkg() and call the latter directly.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c         | 11 +----------
 include/linux/bio.h |  2 --
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ce1e512dca5a..7ec5316e6ecc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -244,7 +244,7 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 
 void bio_uninit(struct bio *bio)
 {
-	bio_disassociate_task(bio);
+	bio_disassociate_blkg(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
 
@@ -2073,15 +2073,6 @@ void bio_associate_blkg(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg);
 
-/**
- * bio_disassociate_task - undo bio_associate_current()
- * @bio: target bio
- */
-void bio_disassociate_task(struct bio *bio)
-{
-	bio_disassociate_blkg(bio);
-}
-
 /**
  * bio_clone_blkg_association - clone blkg association from src to dst bio
  * @dst: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 84e1c4dc703a..7380b094dcca 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -516,7 +516,6 @@ void bio_disassociate_blkg(struct bio *bio);
 void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css);
-void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline void bio_disassociate_blkg(struct bio *bio) { }
@@ -524,7 +523,6 @@ static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg_from_css(struct bio *bio,
 					       struct cgroup_subsys_state *css)
 { }
-static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
-- 
2.17.1

