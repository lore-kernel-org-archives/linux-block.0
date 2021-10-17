Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81266C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E31360F8F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbhJQCIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJQCIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B49C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n7so12312274iod.0
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0KZzxnbSs7XF6vV0kQd43FeM70rIf1FqGXI5pxksKQ=;
        b=JSyOEopMiVH9WNksAwm625nmRXzP5HlOlPOSERHqxqjZ5cDa+9rw2op0W9VWvFZUg6
         WBHrg65HdHsjnOEga4Bk0EF5TyLzyzqbewva3ns1L5rZ+qeXY0rprjAXsk20wyBlhGY2
         oIV0jkDCZbT+hk8ybwRdu2KPz0xYRKKLRB0etNPkcvYVBe7Aqkav1+VlJLJEQ+YwYSXj
         BgEuk78Pc98YnYddWiDajuoIEsFwThe2B5NRpF+C4EZYzxWaQ7w2VELkyfEJb1eBKz8E
         V/LI3mP2Sm6GziWEgpBcuaJwidcxbuMBFteVKCflTofqse6jRUkkcgwkbQV44y2FFmsW
         rycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0KZzxnbSs7XF6vV0kQd43FeM70rIf1FqGXI5pxksKQ=;
        b=O7M3zNt2pqBev+g7xT6fgaUhlOUJQSukAbINmYdU3AgjDRbJaTU8ylSOvlLlnz2MHe
         hIUFTsG1cNoE9Gbxy3QwBiiAhRA3Ytbp+Tr5LGBfQ0hqjnfkHOKERBP8wuWrfUGHeBZ6
         HpgMuVWj/SDbJq+C7PHjLVU7XPkWN2Z5ahwpgNfTkzU/CeTWbcIkFfRQmhCWxgkoRlUX
         Jpr3h3toeJ5mv/ObmzrM/jBRwZCpFDTTqMP7iFrfOiF68YyB8wwDLqrB0KnMs7Lu2Pyx
         nwPmjeXfgemCHRfMuqxmRx379QIQZwnV7FIJ3ERZk32p2HlMJLNlzGNvNJrbIGbiQVXc
         nevA==
X-Gm-Message-State: AOAM532eAUcLSxOsN0hYMIA817WI2fud/Ask9n9OGP4l9JWygzed4Qjr
        lJlaG2P0Q/ebqG7tTLw4mcpBwUFR9n++MA==
X-Google-Smtp-Source: ABdhPJzLN3uYoR0FCgtQiXze3MM6I4ArOa0QCuier11CJQrNNltN3gUK52EoxCTLtOJ1pQKPlDq48w==
X-Received: by 2002:a05:6638:3396:: with SMTP id h22mr13577234jav.13.1634436390862;
        Sat, 16 Oct 2021 19:06:30 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] nvme: wire up completion batching for the IRQ path
Date:   Sat, 16 Oct 2021 20:06:23 -0600
Message-Id: <20211017020623.77815-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017020623.77815-1-axboe@kernel.dk>
References: <20211017020623.77815-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trivial to do now, just need our own io_comp_batch on the stack and pass
that in to the usual command completion handling.

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
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e916d5e167c1..fdb0716614c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1075,7 +1075,13 @@ static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
 
 static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	return nvme_poll_cq(nvmeq, NULL);
+	DEFINE_IO_COMP_BATCH(iob);
+	int found;
+
+	found = nvme_poll_cq(nvmeq, &iob);
+	if (iob.req_list)
+		nvme_pci_complete_batch(&iob);
+	return found;
  }
 
 static irqreturn_t nvme_irq(int irq, void *data)
-- 
2.33.1

