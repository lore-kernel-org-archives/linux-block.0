Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiF2XcX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiF2XcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:21 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B5630B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:21 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id x8so12166768pgj.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPXs8Q8lnpYX7JFmLaP5YiJxE5u6WR4X6bNitOIYS4=;
        b=DeLt7FQ7483aMB2ERX36dOs1hXvq2wCLLW7vZg8+jaYB/OA8bFm1Fzaj18vnN44ISy
         /CI/LyOHMmnWuWD7i+mr4BInds4mfm52Q81xA523VFTG7UYljFM36WNINPAG/07t8t4q
         SG9PxrgqFMyQmkkbl6st8Q+AJKd/do1DD4qPueZIq7YqMVzx4Gs5YfWaporvXX73XTz7
         oTKAGPKU81v6yp0Ia7LdKVv34ntEOCb0UoAliBgzSR6fKktsdBIMKlnmMFmkHs25Vpq3
         0Z9oOU5NZonyBYObU1WbPhLg+O//xayZadoFuFEGAuFhRcHWlwEuNP6DGgyAJ2mTlArl
         G7+A==
X-Gm-Message-State: AJIora+ozlZAENyNd17eRtaaFGPFsLhPfgVUvm+kGAWuCJPKwqzhs3yH
        tRHwiYE73sLJKHTvPljDSCo=
X-Google-Smtp-Source: AGRyM1tkjWmLSIXcTqOC/8sRJ/8j46CXzWew/3Y9MCkl5daB67ykPZV50xEk/TrBYwiUlradod0dfA==
X-Received: by 2002:a05:6a00:179c:b0:525:6823:2972 with SMTP id s28-20020a056a00179c00b0052568232972mr12552235pfg.60.1656545540659;
        Wed, 29 Jun 2022 16:32:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH v2 17/63] xen-blkback: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:30:59 -0700
Message-Id: <20220629233145.2779494-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for request
operations and the new blk_opf_t type for request flags.

Cc: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/xen-blkback/blkback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index a97f2bf5b01b..a5cf7f1e871c 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -442,7 +442,7 @@ static void free_req(struct xen_blkif_ring *ring, struct pending_req *req)
  * Routines for managing virtual block devices (vbds).
  */
 static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
-			     int operation)
+			     enum req_op operation)
 {
 	struct xen_vbd *vbd = &blkif->vbd;
 	int rc = -EACCES;
@@ -1193,8 +1193,8 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	struct bio *bio = NULL;
 	struct bio **biolist = pending_req->biolist;
 	int i, nbio = 0;
-	int operation;
-	int operation_flags = 0;
+	enum req_op operation;
+	blk_opf_t operation_flags = 0;
 	struct blk_plug plug;
 	bool drain = false;
 	struct grant_page **pages = pending_req->segments;
