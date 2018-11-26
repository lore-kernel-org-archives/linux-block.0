Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576DC04EBC
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AF021104
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AF021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeK0IPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:33 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39798 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeK0IPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:32 -0500
Received: by mail-yb1-f196.google.com with SMTP id w17-v6so8135345ybl.6;
        Mon, 26 Nov 2018 13:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=090PLFd61t5/5kPTjv45shTyidriuC2aK3z6nlYUPsg=;
        b=clpszmGkdtYfEVVZBHz60glUuOyscqMC3GN6kPn9CIIbfO3ImbfRqTewcSeWYBIwrK
         d2Ib+W/PA47n8LfkTfZISIkNH7b8MNDn+XFspmY5oUeGmiB4WG+lkWWavJupJPc+nZX+
         xQlrGsRFFFQ94sot5mK+fWpGwxYWsXcmRBl7x2jXe9TtNh83Zp2wSrXgaQXPZhUXPgHu
         kCc2t9KRjhjiPj7vCBhdghxgIi8bVCwm+6Lz0bKGHXlKsiRVmZBuIFAhHrM1iT3URklM
         KDDx/la6NNcJ802lW7Jm0Udrhj2XfgPVX6DKNHbuiEcV+7zDr51yI6s2EoyQs94QMU0V
         fkiQ==
X-Gm-Message-State: AA+aEWa5jKNU7iAyMsJOuNSYF7+bAMMKqBV11WQk531WKH+JkP6vLrRt
        mwk+cBfxHm0mB+0rXtyewNQ=
X-Google-Smtp-Source: AJdET5ccpucyelJksY4uUxZssZ9PerAX6wsu7qF3ilXTSfPlPDrj3sIi9WGEzXISc1ZkOx9qJCd3Ig==
X-Received: by 2002:a5b:48a:: with SMTP id n10-v6mr30218632ybp.89.1543267206042;
        Mon, 26 Nov 2018 13:20:06 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:20:04 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 11/13] blkcg: remove bio_disassociate_task()
Date:   Mon, 26 Nov 2018 16:19:44 -0500
Message-Id: <20181126211946.77067-12-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that a bio only holds a blkg reference, so clean up is simply
putting back that reference. Remove bio_disassociate_task() as it just
calls bio_disassociate_blkg() and call the latter directly.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/bio.c         | 11 +----------
 include/linux/bio.h |  2 --
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f713aa236ac5..41cc2ead39f5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -244,7 +244,7 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 
 void bio_uninit(struct bio *bio)
 {
-	bio_disassociate_task(bio);
+	bio_disassociate_blkg(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
 
@@ -2108,15 +2108,6 @@ void bio_associate_blkg(struct bio *bio)
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
index 7b8bb1365977..419fdf5f8ab6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -521,7 +521,6 @@ void bio_disassociate_blkg(struct bio *bio);
 void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css);
-void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline void bio_disassociate_blkg(struct bio *bio) { }
@@ -529,7 +528,6 @@ static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg_from_css(struct bio *bio,
 					       struct cgroup_subsys_state *css)
 { }
-static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
-- 
2.17.1

