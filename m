Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A130CC07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCDC20837
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aIU4M1qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCDC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLISVt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:21:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46413 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLISVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 13:21:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3883593pgp.13
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 10:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AZTQ+gKaLlV5gBP48gUGcZybNYVas6fKgxDHplrXZ3U=;
        b=aIU4M1qbae3AcXy50ZXKjQbi07SOBngKBX/GQxaTvBM8fgpndSKWZyhyAYiv4Tiicb
         FglH9b01Wqb9pWDgLmz5D1gNg+frjxPr8zMXv0X2Kgq1PQ8Mct8fDzJRLGtQrfy5Rwj/
         gFABDLqsKxmuLHsCDkZRdlxfU2XR3gi5SkmH2uJu0UNp8U0F2U0LWst2Wr4eBygOrHAJ
         6cNufVrlPkMN4wgeR1J3cjbpuBA8QLJIU87N0A7rT9AYa4kzH4jnPkucva3ZXxR8+bkq
         wIKXRgisqVEnbkvuNkfZsdyvQPS0X2ige5oEOz7vVi8x6iYl520Mwwh3w/PGzaaHQqBF
         DItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AZTQ+gKaLlV5gBP48gUGcZybNYVas6fKgxDHplrXZ3U=;
        b=bhfoC2aadIT8hcCJk2AFblcYvt/5DfJsPUxWXM6aFrHH9qHM1Ql/CAzrNc4ZXsydlz
         z18TLaTH1wmh1Vn0iaGwyC4yHNrvQkAgNcZbkKIXcmjux2Xj0Oe802dvbGepYaKGwxXb
         AKJQC/2vZ0mEs+v6UneBLVOTOx0zfJ09lqFRvjq1AU90zBKX1uAmUA7eXQpRt2eLu7SS
         lz859Sytlj48mkC7qwN8di/33dxGE1+9elYMgk0B6hqwNU/lJvbT+0OM256hMIvpq//a
         Eq51DX5Ao1dHsCEktoWZB4f/bMjhhWA7FSKSEXFz99xOQ4eHlhprsdnzl9WE3XSdv8JK
         sDeA==
X-Gm-Message-State: AA+aEWbQEI7uTCv8t5QcLjHmyvk19FQbc8YDVMDhVoBwlyCZ4haZQc5c
        QGFLRxNwZaZM5PIs4uYkR7C0OQ==
X-Google-Smtp-Source: AFSGD/XIQAY7cID8xFbYrV21PsEG8IQrlfO3L+JF7GcmpqbDRO77fixOLEAEROTxO02CF2XPdILswg==
X-Received: by 2002:a62:6cc8:: with SMTP id h191mr9995511pfc.89.1544379708166;
        Sun, 09 Dec 2018 10:21:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v14sm17217950pgf.3.2018.12.09.10.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:21:47 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: fix irq vs io_queue calculations
Message-ID: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
Date:   Sun, 9 Dec 2018 11:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Guenter reported an boot hang issue on HPPA after we default to 0 poll
queues. We have two issues in the queue count calculations:

1) We don't separate the poll queues from the read/write queues. This is
   important, since the former doesn't need interrupts.
2) The adjust logic is broken.

Adjust the poll queue count before doing nvme_calc_io_queues(). The poll
queue count is only limited by the IO queue count we were able to get
from the controller, not failures in the IRQ allocation loop. This
leaves nvme_calc_io_queues() just adjusting the read/write queue map.

Reported-by: Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7732c4979a4e..0fe48b128aff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2030,60 +2030,40 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
+static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 {
 	unsigned int this_w_queues = write_queues;
-	unsigned int this_p_queues = poll_queues;
 
 	/*
 	 * Setup read/write queue split
 	 */
-	if (nr_io_queues == 1) {
+	if (irq_queues == 1) {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
 		return;
 	}
 
-	/*
-	 * Configure number of poll queues, if set
-	 */
-	if (this_p_queues) {
-		/*
-		 * We need at least one queue left. With just one queue, we'll
-		 * have a single shared read/write set.
-		 */
-		if (this_p_queues >= nr_io_queues) {
-			this_w_queues = 0;
-			this_p_queues = nr_io_queues - 1;
-		}
-
-		dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
-		nr_io_queues -= this_p_queues;
-	} else
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
-
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
 	 * one read queue
 	 */
-	if (this_w_queues >= nr_io_queues)
-		this_w_queues = nr_io_queues - 1;
+	if (this_w_queues >= irq_queues)
+		this_w_queues = irq_queues - 1;
 
 	/*
 	 * If 'write_queues' is set to zero, reads and writes will share
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = nr_io_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
 	}
 }
 
-static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int irq_sets[2];
@@ -2093,6 +2073,20 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		.sets = irq_sets,
 	};
 	int result = 0;
+	unsigned int irq_queues, this_p_queues;
+
+	/*
+	 * Poll queues don't need interrupts, but we need at least one IO
+	 * queue left over for non-polled IO.
+	 */
+	this_p_queues = poll_queues;
+	if (this_p_queues >= nr_io_queues) {
+		this_p_queues = nr_io_queues - 1;
+		irq_queues = 1;
+	} else {
+		irq_queues = nr_io_queues - this_p_queues;
+	}
+	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
 	/*
 	 * For irq sets, we have to ask for minvec == maxvec. This passes
@@ -2100,7 +2094,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 	 * IRQ vector needs.
 	 */
 	do {
-		nvme_calc_io_queues(dev, nr_io_queues);
+		nvme_calc_io_queues(dev, irq_queues);
 		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
 		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
 		if (!irq_sets[1])
@@ -2111,11 +2105,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * 1 + 1 queues, just ask for a single vector. We'll share
 		 * that between the single IO queue and the admin queue.
 		 */
-		if (!(result < 0 && nr_io_queues == 1))
-			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
+		if (!(result < 0 || irq_queues == 1))
+			irq_queues = irq_sets[0] + irq_sets[1] + 1;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
-				nr_io_queues,
+		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
+				irq_queues,
 				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 
 		/*
@@ -2125,12 +2119,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * likely does not. Back down to ask for just one vector.
 		 */
 		if (result == -ENOSPC) {
-			nr_io_queues--;
-			if (!nr_io_queues)
+			irq_queues--;
+			if (!irq_queues)
 				return result;
 			continue;
 		} else if (result == -EINVAL) {
-			nr_io_queues = 1;
+			irq_queues = 1;
 			continue;
 		} else if (result <= 0)
 			return -EIO;

-- 
Jens Axboe

