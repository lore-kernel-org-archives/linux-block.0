Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49972C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2B52082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029880;
	bh=8yCbP85SCsl5jYFdv43g52Dd3CujS7zzrGrQcgEiBgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxahS944LmzO0CTzCGNVMh90HqFHN4C3gPGLP3Dn5T5BIB7GXvzHQJiMpcgRtj3N+
	 z0wiZYVo7yLdEhmV59Vw+w805ehpRRj69Pxx9fqBsv+rbPZ6wVt2A1GmGeJehip+BN
	 OWlkYQM3GkQ9HyH7u5gYo7a1TYqh7lSnRMRk5eJw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2B52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeLERLO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:11:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbeLERLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:11:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so23093288qtl.5;
        Wed, 05 Dec 2018 09:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4RJ1tad/iwAWBQQeHHB2twpexhanjcCN74RMuiZIAtk=;
        b=kmYpE1gweKQul0lI5r6bn7ORrRXmtiPUM3XG5sM76WAdv8UTmKYxDOTuwBvn3d1Mf+
         kn0xipPefMUzT0YLZxN5fUgRr+pwCf4lIe6ujUSIf9Rq5T8WdyUNuR5dcJzvA0Wa6O1v
         qAn/H73ENz0wzL5uGbpJHikb2dO8n/YnqtLfxOaOCO9MuTIhNDbZAMDp+ldyByc8s8qu
         ocXh4w+3mBdaZpUdiHIlk1zho7y+YKmx6lbRSQwZkcTbF/IYNGXsBJhuoOAE3XGELEkL
         0fejnZUWcuG+jOY7h15sbOthXzK6AIDW+XuZRIu86VVIVSbc+FoGyTZNkV9Gmy4Njbrl
         uPrQ==
X-Gm-Message-State: AA+aEWaK2ZqBsdNmTOWsmVYaxURmYG4uqP9FQprB5GF8KHVL0Im88ZhJ
        uZ4Jyx02fpPEyr9sjE1EZYciwfxXxI8=
X-Google-Smtp-Source: AFSGD/ULOaMhyogQlXxeSBzKEbzztc/aVocCQj1WC7ttVagQsYB9D52lMSrhQfVxmzACQ+0Ykw5jJQ==
X-Received: by 2002:aed:39a1:: with SMTP id m30mr23603353qte.354.1544029858679;
        Wed, 05 Dec 2018 09:10:58 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:57 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/14] blkcg: remove bio_disassociate_task()
Date:   Wed,  5 Dec 2018 12:10:37 -0500
Message-Id: <20181205171039.73066-13-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that a bio only holds a blkg reference, so clean up is simply
putting back that reference. Remove bio_disassociate_task() as it just
calls bio_disassociate_blkg() and call the latter directly.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

