Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25451C4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbhKWROM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbhKWROM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:12 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB115C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 14so28709523ioe.2
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obLep7hKn/j/EoRL8hQqMnp3Wbyin21r4clAytoEnPo=;
        b=ZMlpb2GAFTKUPTURx50fJst+8Gol+ffBBhtExcfky83LdAqP7SMElpuz/tejcHe7z8
         3r8pJfvbcwrT3YBvC/pDrrYwcIg69pB+EIZulWNNAyym6wg2+zLhIfoglwjy/mXhfgfT
         TJvMQmVVG9J/I9kx4m78Xfv5yjfAg+NwhB/R8ckHwIb4G27fPSIjuyfOR3AsexOOnWDK
         A0Lkx59fN3pcdxJ+BGnJcrsYilCaH/ML5h588lonQiIBS+nFwy2wAX6e/nc3oJYH8pF7
         Ja2F+Q8IkJcUuVcZtm0tf4LHfgqhVDlhpQHw3o69zyQ7ISL2XwLewudEnn3h8F3Il8ew
         B14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obLep7hKn/j/EoRL8hQqMnp3Wbyin21r4clAytoEnPo=;
        b=CNaXJX1XtXxAdj/HUplJrJ578+y33g7IubIxCzg0aHg8bPoktft77l6H3MMTSEyJPk
         5DCDkXRnPxbG9LlMdU9aq1vRVLbaLJH5tFjxI7pJfxPcTDCWRx01pPlSw4hit/y2+dr8
         qsqT+eAkjFRWZqA0lR1azFLkbYquYQQvqbpZgTzDnHPvTCO8lQRZ6jQECWAHTBXjdmdu
         OaZyUCo9h62b8RiioX7a1s0yIbw0hK8zYhgxnog+bMDYCJPJK/Nnd6Yid0GR7bgsJVcW
         RSeLkjQ9gYKduOcFp1GfGNGBIHZqW9CX8+4PZnLxZG2CN30yUp5lywm80UUbF8tIR6bF
         XuoQ==
X-Gm-Message-State: AOAM5338nxfMPBWhgUqEiYNiGwFXpLAasJ9aBeCyUdEeNgtymzRQTi9D
        YJh1B/3+c5JE0hkvxPD07Tn2TXaH6wxBSR41
X-Google-Smtp-Source: ABdhPJyp1CXd3JMpFO6fBE5/sIVLd5PeMerSD45dlq/EzsQCS4De68fNl18HKBdWikviqMI4mK7kRw==
X-Received: by 2002:a02:6666:: with SMTP id l38mr7815860jaf.146.1637687461732;
        Tue, 23 Nov 2021 09:11:01 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm8251283iow.9.2021.11.23.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:11:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] blk-ioprio: don't set bio priority if not needed
Date:   Tue, 23 Nov 2021 10:10:57 -0700
Message-Id: <20211123171058.346084-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123171058.346084-1-axboe@kernel.dk>
References: <20211123171058.346084-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't need to write to the bio if:

1) No ioprio value has ever been assigned to the blkcg
2) We wouldn't anyway, depending on bio and blkcg IO priority

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-ioprio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 332a07761bf8..2e7f10e1c03f 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -62,6 +62,7 @@ struct ioprio_blkg {
 struct ioprio_blkcg {
 	struct blkcg_policy_data cpd;
 	enum prio_policy	 prio_policy;
+	bool			 prio_set;
 };
 
 static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
@@ -112,7 +113,7 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 	if (ret < 0)
 		return ret;
 	blkcg->prio_policy = ret;
-
+	blkcg->prio_set = true;
 	return nbytes;
 }
 
@@ -190,6 +191,10 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
 			       struct bio *bio)
 {
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
+	u16 prio;
+
+	if (!blkcg->prio_set)
+		return;
 
 	/*
 	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
@@ -199,8 +204,10 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
 	 * bio I/O priority is not modified. If the bio I/O priority equals
 	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
 	 */
-	bio->bi_ioprio = max_t(u16, bio->bi_ioprio,
-			       IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
+	prio = max_t(u16, bio->bi_ioprio,
+			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
+	if (prio > bio->bi_ioprio)
+		bio->bi_ioprio = prio;
 }
 
 static void blkcg_ioprio_exit(struct rq_qos *rqos)
-- 
2.34.0

