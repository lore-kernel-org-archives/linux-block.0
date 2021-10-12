Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A7C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0982561050
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhJLST6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLST4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B34C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n7so15840085iod.0
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02YgnQreYCX7+Oxqq3CeMBFEG37oqt2Ce2mb0JVD220=;
        b=Eux1eS+TTL560c91wPLqapoKifb21C7tey/OZpPpoGKzlGsNJl79vwVMDUPcZOkSU2
         GJpDYNmzoZa+aPmTqTBIuQkf6fFclenH2wgXmgr2o7Wy1SKcyfABIasO65EClQJEKmNO
         WeKHOymXE0PqhjPBUyl1S9sEhbAFubc2+3liCuGGWQZLSQ0nBKImxfHAzoOJNO97x5Kw
         rZkRuwBNf/mTH27ptlF8GiU+5XcdedWl+V4u1MBpbAaXEJ8m7DB4FpyPaG+4+lYY0gDJ
         UXBBEzH7trA1BaxyS1iTb5b82DNvHmNYw2KwVSc0AM3VrcnP8SJlietGdzBGZSy9AWau
         U4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02YgnQreYCX7+Oxqq3CeMBFEG37oqt2Ce2mb0JVD220=;
        b=RSLzmg3qviXL+DiX29FOAlyojgjRM2+vLuMbdTevtbN06ckslSMG/2ZDqc3bvNdmdH
         2ndCvsjchxdKBGvlv7hNBjW/oCU7Q43rPOn+Sggx7bnJ5SY/mLezApctXYr6wwKqEq/E
         B2U02zZWL4kIePYyteK8K7bDimTIpaVDko/CT1OSHyoJQEODPV92ZRiwGXRLvA7l+eBL
         vb/C3BurwnB1T2qPl5wLhDw59hPaoSkiNmAhsvPSnwCnuQgJsbhIPaA/ZBmucXvv5Fbn
         1wbEAj2U64BVThTZddgZQDl8tOKasqYdYZRQlIDhV5do8UcA80hY1yvL+r174pwkhxbe
         MaMQ==
X-Gm-Message-State: AOAM532+/6eEUNhL1EHi+Rn3S1oedDe6NVo/xzEN1C3X8xbp86/MKjiy
        uhBkZW+fiGZG5SAQKoZr3Z4wKpKZUW1r+A==
X-Google-Smtp-Source: ABdhPJzLXeyV1eoE+dHJLaLxkTDH6LP3vtSkQOg0svef2OUCzcEZ92ZiNVNGpY5iVdx/jUpkl6Z5bA==
X-Received: by 2002:a6b:3b85:: with SMTP id i127mr24321080ioa.111.1634062671161;
        Tue, 12 Oct 2021 11:17:51 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
Date:   Tue, 12 Oct 2021 12:17:42 -0600
Message-Id: <20211012181742.672391-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trivial to do now, just need our own io_batch on the stack and pass that
in to the usual command completion handling.

I pondered making this dependent on how many entries we had to process,
but even for a single entry there's no discernable difference in
performance or latency. Running a sync workload over io_uring:

t/io_uring -b512 -d1 -s1 -c1 -p0 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1

yields the below performance before the patch:

IOPS=254820, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
IOPS=251174, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
IOPS=250806, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)

and the following after:

IOPS=255972, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
IOPS=251920, BW=123MiB/s, IOS/call=1/1, inflight=(1 1)
IOPS=251794, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)

which definitely isn't slower, about the same if you factor in a bit of
variance. For peak performance workloads, benchmarking shows a 2%
improvement.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4713da708cd4..fb3de6f68eb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1076,8 +1076,10 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 
 static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 {
+	struct io_batch ib;
 	int found = 0;
 
+	ib.req_list = NULL;
 	while (nvme_cqe_pending(nvmeq)) {
 		found++;
 		/*
@@ -1085,12 +1087,15 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, NULL, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, &ib, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
-	if (found)
+	if (found) {
+		if (ib.req_list)
+			nvme_pci_complete_batch(&ib);
 		nvme_ring_cq_doorbell(nvmeq);
+	}
 	return found;
 }
 
-- 
2.33.0

