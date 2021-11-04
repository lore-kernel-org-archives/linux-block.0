Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E315EC4332F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97EB61216
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDPYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhKDPYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FBFC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c2-20020a056830348200b0055a46c889a8so8723054otu.5
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bsj5ZLlquf/pPLdn6lhiC7/HYQDntfsyVm6vIVzVNlU=;
        b=AfH/GRjr0rU3aByHLtinkU2lHLDEQ7zFDv3L0CLAmNk+sMGtOAzWkNNF49Lg2iLsoC
         CHxy1/dpVIV+MYl1NpZbOodSqX0/TBbi8DH05AIavAC4VpsnLBcTZNCvWJX11ldsti/N
         nyVv6kcDBTClfE5hQuPbb9my98r9M4Bc58jnvCXH+flsmnyPzAcJAePyV5DhqvoBpdXj
         BmgdRg9gdChBi0pcbWRenEYWLe4xq8qkSE94ipS8xNFEpn+EIqOltIhKYrU2NYjDWpJK
         fND9T161ITF5tJt/ZaOYQez1T/zez4ENiVYooWfVs9bVASQOsVwl30lGtbEipVkvIYvj
         JOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bsj5ZLlquf/pPLdn6lhiC7/HYQDntfsyVm6vIVzVNlU=;
        b=xdwSvwA5G0DwdSf/RzLMCcK1RMVa88/s2zVgwET4hkA0x92EuAhT5Ya3PId+zQZoMk
         a6yPUKy70HGO2j22wBhumcauIQuhU2IkRRzDejG3ElUVHBk6vA7OcPbtbI1yhVSK5Vul
         7h/83yiEiOE9hp7NwMY+GOzLUL3SrqMdi4HqRJtzaPdV/fBl40vvmtUOiaZDmui5hYWn
         /zK+I3r2N3FDIwuhRd44o+OK5UAgILiWstGpwew0w79vjoyJC9LNzujAtWbQZmlXMLhA
         TGvRFGCA77STRVdNRCjU9TTaks9BxNszGYIpO+Sn2YArL4hZ2yBBh8u4FO4J4XLJ4gCF
         7Yiw==
X-Gm-Message-State: AOAM531J3R8a9P0VdgVcT/OXonvexTrr91qHU9xO57Hk+4vlP6BHKlRy
        pUsV53r2s2o7jWgrdHbsrNw+koihHoG7Mg==
X-Google-Smtp-Source: ABdhPJwuoOUSJL6lAc9NTU1el/i3Lj+5LRC4d+3l8UABkXHiOgd5a+aFyPJ6xF/vQMAs9A4ceoKXXA==
X-Received: by 2002:a9d:f67:: with SMTP id 94mr11254034ott.32.1636039328466;
        Thu, 04 Nov 2021 08:22:08 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] block: make blk_try_enter_queue() available for blk-mq
Date:   Thu,  4 Nov 2021 09:22:01 -0600
Message-Id: <20211104152204.57360-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104152204.57360-1-axboe@kernel.dk>
References: <20211104152204.57360-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just a prep patch for shifting the queue enter logic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 26 +-------------------------
 block/blk.h      | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c2d267b6f910..e00f5a2287cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -386,30 +386,6 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
-static bool blk_try_enter_queue(struct request_queue *q, bool pm)
-{
-	rcu_read_lock();
-	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
-		goto fail;
-
-	/*
-	 * The code that increments the pm_only counter must ensure that the
-	 * counter is globally visible before the queue is unfrozen.
-	 */
-	if (blk_queue_pm_only(q) &&
-	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
-		goto fail_put;
-
-	rcu_read_unlock();
-	return true;
-
-fail_put:
-	blk_queue_exit(q);
-fail:
-	rcu_read_unlock();
-	return false;
-}
-
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -442,7 +418,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	return 0;
 }
 
-static inline int bio_queue_enter(struct bio *bio)
+int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
diff --git a/block/blk.h b/block/blk.h
index 7afffd548daf..f7371d3b1522 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,6 +55,31 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
+int bio_queue_enter(struct bio *bio);
+
+static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
+{
+	rcu_read_lock();
+	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
+		goto fail;
+
+	/*
+	 * The code that increments the pm_only counter must ensure that the
+	 * counter is globally visible before the queue is unfrozen.
+	 */
+	if (blk_queue_pm_only(q) &&
+	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
+		goto fail_put;
+
+	rcu_read_unlock();
+	return true;
+
+fail_put:
+	blk_queue_exit(q);
+fail:
+	rcu_read_unlock();
+	return false;
+}
 
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
-- 
2.33.1

