Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6175C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D5061053
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhJMQ4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbhJMQ4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30571C06174E
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d11so401171ilc.8
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6GVj+VGurrqDHVBNA0HHjEZpwWFZJrLtzTyFowWRbw=;
        b=eVuUAlCM8/qj0n/oCc6R3BfPwPWPesXR04LH38vjObMabE6ziFFbde54TMF0QqkKvW
         IydqXTfV9KQg3/UkMQc0qFhdHMCD6pCMJa97fB53IUkuZhOswaUwCZikdmBM9qydhTJp
         P2691ofF/uhHa0KP51590b/z44nNxDlxkDn9AWFQIHcDuwkq/fwcGuQpZ2GAIoLaLN4M
         ijA8NxlZ6xd0UaQAFj/nijbctA1sNsqI4iAQiAIH+CP9Sbd7gIGM4FwDCsh1EFOGjzu/
         NfMmZpyAUec9CjyS34yuyaPKAxtEIetGg3FJfXg766Mr4MocZwFgVOBWYuxmWVqnxEqk
         7VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6GVj+VGurrqDHVBNA0HHjEZpwWFZJrLtzTyFowWRbw=;
        b=on+/v7OUS5XkAVlQtyudhfARjxBIIbcFK+aNFTpjNriqDu7xKkLP9yKYn5vXugo2jj
         1uFs1Q1BG6vg2N6aFsWFsozFxrT6QvsN026Gsdc9/mJ+AayXMGZvKDBYNwpO8jSI8dUu
         vQFMFFkfNs6vjnxTqEdjYZQhVjLuM4gekMEd9KsaV0mEfmzPmIkwgAMrNZs7aniNC4n3
         DNbY433fdxTC3aESIOsyXp/Mt7zjjq9bxGSSfK2wu7G2svkQR+zhe3UUQPsudukjaMJl
         ftUNATO8IF5KmN9WFeSlUkwEHEHby023+0oGbm/8t0fu9iZT+Hsp2k3iKE7Iz01cIG8M
         rruQ==
X-Gm-Message-State: AOAM530iaM0kKDWt/ts/2bp87mLSWhv6GHew+QEbYzKLYnwywLvPtmZb
        +AfRu8WaW9kERmg1P06aeW6pScgKmpd0lA==
X-Google-Smtp-Source: ABdhPJxYZ73FtvBxrm+5xjOAmv8nj52rXg//pBZfA2+hllzFjassYveU3xzMbCGiFBmx0EHj3Mm79A==
X-Received: by 2002:a92:c244:: with SMTP id k4mr124927ilo.3.1634144066482;
        Wed, 13 Oct 2021 09:54:26 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
Date:   Wed, 13 Oct 2021 10:54:16 -0600
Message-Id: <20211013165416.985696-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
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
 drivers/nvme/host/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ae253f6f5c80..061f0b1cb0ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1061,6 +1061,7 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 
 static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 {
+	DEFINE_IO_BATCH(iob);
 	int found = 0;
 
 	while (nvme_cqe_pending(nvmeq)) {
@@ -1070,12 +1071,15 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, NULL, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, &iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
-	if (found)
+	if (found) {
+		if (iob.req_list)
+			nvme_pci_complete_batch(&iob);
 		nvme_ring_cq_doorbell(nvmeq);
+	}
 	return found;
 }
 
-- 
2.33.0

