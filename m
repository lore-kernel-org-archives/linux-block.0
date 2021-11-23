Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45667C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhKWQVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWQVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:21:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5DC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z26so28586794iod.10
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obLep7hKn/j/EoRL8hQqMnp3Wbyin21r4clAytoEnPo=;
        b=6OvPIEed+0q7rJ2Ent79HCOTOY6y5R9WWfMPopMWqQEEe5iaQyHzpV4qHCayIhR4uM
         Kf6NN1s3M0dxdoakVWJC+DcsSOamApCS493/x656k2+RzLHXK1l6VHiPEX2tC6STEHpv
         dBFpEcuvZzv2rLH3kA8oqDeHoTpbqAFPJ5prSbG53J24jml8cLBbRkBQEXwDUkmOEcDX
         qrQnOfanCQg6IM5KKjffO4xTu4TkLF2rSXZfqa/VIhJup/1tH1T56sdAeQ5Gl2MreCT9
         U0Nz/bJcHph5T0OACMBKoENBcsQTsGOJ+wGK2Q+x1mD6b9SsEQXYhlRm91ODq31WIZsv
         kRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obLep7hKn/j/EoRL8hQqMnp3Wbyin21r4clAytoEnPo=;
        b=yDrwHQlsx0uTi7TtPRTCgboh/cimWNr6czhkAd4I/sHXzdEfYhsj6Gm1mQld/P8v5R
         +zWiV1PmmLjBf8mxxQPyc/zMJMEmGIzV6Rgf3lWde5WHwrFGs6aH/v6bQMGP++x6EJ3Z
         WcrpqNB+jI7tbfECRB55zbQQGcChomMnll3tDjCwflcFsOhKQ0DLGN+RGPgoMgKZ9EO+
         jZypWNepDZom9BaPgmRoEBqtuj+NH1bVrIcP4aEQfox3BgXeeL/z+1UDAuntk/LgiisL
         wY/V6rd6Q5O4qIooUX+9MWN1WvSzXc9gYNbfvYrpW8yvfLFRuNQaHr4Sy5ZueOCxNLoE
         8LTA==
X-Gm-Message-State: AOAM533fUVXaC8H7KkfRyPNORl7npoZPM+MySmneDGGcURMHKVQozzhO
        0z23a1sB+h9rWRMduezF6r4tKLor+QjU+3zS
X-Google-Smtp-Source: ABdhPJwANfSIAVk6C9dAlazToDzoQMmF7XPTpjDVwmd4XvSKb8kgMpt1F2AVGIZMfR0fEhrPxofxug==
X-Received: by 2002:a05:6602:8da:: with SMTP id h26mr7251449ioz.76.1637684296220;
        Tue, 23 Nov 2021 08:18:16 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t188sm7858034iof.5.2021.11.23.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:18:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] blk-ioprio: don't set bio priority if not needed
Date:   Tue, 23 Nov 2021 09:18:12 -0700
Message-Id: <20211123161813.326307-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123161813.326307-1-axboe@kernel.dk>
References: <20211123161813.326307-1-axboe@kernel.dk>
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

