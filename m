Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A722C7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202B32190F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfGVRM1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40938 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRM1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so17671157pfp.7
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYs1psmKSo4dwLQmfCgpezaUpRcFNkV2ILZlTlqS0ok=;
        b=Un0X/Ed3RakQiUkpe0Qu+OccLQnwOWtUjoKlmrRX5Sz3EM7xpWetQE1DT78hgRe1i+
         DVmvXUDx9GSLAZLGHqsNXxMog7v5it6vxQcG0BlYOC/BS203ULvCobdCmwO6AbKQ1CRD
         +shaWLGOgSanh3fZhCbaq5yGHEKwn/G8DNxyaL+4AvbY4z/S1vt592BE3PWhZeKfAgeG
         JEAttTwDxMzHlzBjNoJEwJPF9/uElku7gI6m1Pd5VfBtOMgZuSYsg7fdCKNPUZf0Jgi+
         ojQLjPyUg4tmL1AxMl62ccn/IZ/JZ/43dy7n9V61rlltbgISyghiibIwozUIg1ht12da
         rN9A==
X-Gm-Message-State: APjAAAWXY04gENAXgqOjGx6NCZ2xDgetfBqcGb47TiZEb0vfpoiFyX5P
        +XfhxTB1X6lLecuFiOMcRLIHx2z1
X-Google-Smtp-Source: APXvYqyjQdilrJufoLXTNcT2lfXRi8I00GvmOuuZ7VYvM3dO/HAFP1NpgEtW1WMSkcixwAIVdiVMrg==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr77601013pjn.125.1563815546637;
        Mon, 22 Jul 2019 10:12:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 5/5] block: Improve physical block alignment of split bios
Date:   Mon, 22 Jul 2019 10:12:10 -0700
Message-Id: <20190722171210.149443-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722171210.149443-1-bvanassche@acm.org>
References: <20190722171210.149443-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider the following example:
* The logical block size is 4 KB.
* The physical block size is 8 KB.
* max_sectors equals (16 KB >> 9) sectors.
* A non-aligned 4 KB and an aligned 64 KB bio are merged into a single
  non-aligned 68 KB bio.

The current behavior is to split such a bio into (16 KB + 16 KB + 16 KB
+ 16 KB + 4 KB). The start of none of these five bio's is aligned to a
physical block boundary.

This patch ensures that such a bio is split into four aligned and
one non-aligned bio instead of being split into five non-aligned bios.
This improves performance because most block devices can handle aligned
requests faster than non-aligned requests.

Since the physical block size is larger than or equal to the logical
block size, this patch preserves the guarantee that the returned
value is a multiple of the logical block size.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a6bc08255b1b..48e6725b32ee 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -132,16 +132,29 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
 }
 
+/*
+ * Return the maximum number of sectors from the start of a bio that may be
+ * submitted as a single request to a block device. If enough sectors remain,
+ * align the end to the physical block size. Otherwise align the end to the
+ * logical block size. This approach minimizes the number of non-aligned
+ * requests that are submitted to a block device if the start of a bio is not
+ * aligned to a physical block boundary.
+ */
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
 	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
-	unsigned mask = queue_logical_block_size(q) - 1;
+	unsigned max_sectors = sectors;
+	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
+	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
+	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
 
-	/* aligned to logical block size */
-	sectors &= ~(mask >> 9);
+	max_sectors += start_offset;
+	max_sectors &= ~(pbs - 1);
+	if (max_sectors > start_offset)
+		return max_sectors - start_offset;
 
-	return sectors;
+	return sectors & (lbs - 1);
 }
 
 static unsigned get_max_segment_size(const struct request_queue *q,
-- 
2.22.0.657.g960e92d24f-goog

