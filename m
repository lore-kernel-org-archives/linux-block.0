Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7673FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiGNSII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiGNSIG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:06 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528F6871C
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:04 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso3830860pjj.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+za9RTQYPCikdyPKzx6tiqZdmHMEpaCUMC8nfDJOC9A=;
        b=jqBYzDPEhq3RUyhxReJ01Z9J1XH3D0/llSe9F7TD+gFrWDniHSmCfYl/8QqKyBZ1qi
         BMf3CNIh5nxcls5QMV/WAS3zokuwtSAsDbBsz8gevwYeeqcYaPezqPlRSQKvtF9/p/IQ
         uNDA0dqzYuwvqOzj6alUzopxfXJ/wxriW1Z284QQ7VXq492cZgbwPV/bQshIAuRKyvnr
         keC2H7zT4Ze3Py/hN1/2v7d/MuNn99U3Wvj/vmG8XxVl1qP4NNS0JXNmB5LbWomLgRua
         qRWnySTg5JVTZHVThIlVGXYAij9VOa/bCaRfmvx9ZWzJkK4J69zJz/lTm2b0D5qDuCWi
         Dl2w==
X-Gm-Message-State: AJIora/EzOpTnTxR4YiA7KNlYnNq160YDBM+tTQpa50ByC1gp0wyp+EO
        NGpZ1ihFyR4WkCYaEq0reMcB4Pqj8Ak=
X-Google-Smtp-Source: AGRyM1s+6DDaKJlCB3fptZHV+c7OXAli8lSiN4d0Duj/RoY1713+DP1Jg7cgP88yy89Tih9b9v0b1w==
X-Received: by 2002:a17:903:3093:b0:16b:deea:4d36 with SMTP id u19-20020a170903309300b0016bdeea4d36mr9410926plc.126.1657822083704;
        Thu, 14 Jul 2022 11:08:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH v3 17/63] xen-blkback: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:06:43 -0700
Message-Id: <20220714180729.1065367-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for request
operations and the new blk_opf_t type for request flags.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
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
