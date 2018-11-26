Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF151C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AA420659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HsHW5XSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AA420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeK0Da4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38873 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK0Da4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:56 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so14301067ioj.5
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+3qzXhfJkyKm0ac9rnSYO7z3XNAZpFNPEOllN9qF64=;
        b=HsHW5XSiXqzM6T9q8jzNDAiPzXj7Brt8W5gyNtxhHxxE1Lv+UE37gAKG55IsGnMMyK
         ft4msdtjG4jEwo3FzVk4pXZV5J3B+LqIo119NPTFZ/uAzI9ZyaBEPWcbtj7n6SyOPQoz
         4sgL3UDjdvwLaLzygitl2HRd0dVv61+z0DPbofpVBTnmW2nNLJn0uldSseQBLXxzXpAf
         6wesSKt+5snbjfPsNdEaql7NiZDjvro8oD+igRW6bYGIJk2dQ6+xQsL+DeMmUjo1o1xx
         kZTF49vqBtuDb0nqHkVleEa/vPngTH8v7M3ZlTEcihr2cogTOLONyOa0Z+9KUMNhjSqS
         MYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+3qzXhfJkyKm0ac9rnSYO7z3XNAZpFNPEOllN9qF64=;
        b=iHlDHO0o36rMWr2BUlF4NeK2L9sxBeIwYWredZO5Q+oVuesEHmf1kFS/DJqy2eeAyM
         E1/fIyEAO+m5GxRBu22VgBATFawz3YAkjzyeqzFVsGHrVIrguvlhaKiKeEcblOt5I0BL
         URMgaQo17H+KsjX20fnLwLj9OzWUT2sy0jnlyZv6n2aC9WsME7PQ58ku3CbUXen1nDWa
         +OudhM+16NYbGQX2YBp3EtbTxwUMENVpFymMDSUBmalDuF6aOF1si/+iWae1DFskDhuk
         E+nLBMiJY7YOG2sopoPZNclDqB3iD6VwsSUVOH7K4THCTvq5VV8VZTyAbbuwwpcrLLv5
         /m5A==
X-Gm-Message-State: AA+aEWZwU1whu7b+m/fbFHng4+sZKIveCe1hr5JPHnHTaLScHcqM99k4
        vXIegBVs9rhkFmwUdt40amARYvbvkws=
X-Google-Smtp-Source: AFSGD/Wxm5jgDXfCZr2swfnwRChizBSWgWReuHnFfm5/Xmiq2ifhp8G2eOcUYyZnX63D/4vav+X4MA==
X-Received: by 2002:a6b:4e14:: with SMTP id c20mr20270853iob.65.1543250178384;
        Mon, 26 Nov 2018 08:36:18 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] blk-mq: add plug case for devices that implement ->commits_rqs()
Date:   Mon, 26 Nov 2018 09:35:56 -0700
Message-Id: <20181126163556.5181-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have that hook, we know the driver handles bd->last == true in
a smart fashion. If it does, even for multiple hardware queues, it's
a good idea to flush batches of requests to the device, if we have
batches of requests from the submitter.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a12cec0b426..232f4914c8db 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1953,6 +1953,32 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 		plug->rq_count++;
 		plug->do_sort = true;
+	} else if (plug && q->mq_ops->commit_rqs) {
+		/*
+		 * If we have a ->commit_rqs(), then we know the driver can
+		 * batch submission doorbell updates. Add rq to plug list,
+		 * and flush if we exceed the plug count only.
+		 */
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_put_ctx(data.ctx);
+
+		/*
+		 * If we have requests for more than one queue here, we
+		 * should sort the list when it's flushed.
+		 */
+		if (!plug->do_sort && !list_empty(&plug->mq_list)) {
+			same_queue_rq = list_first_entry(&plug->mq_list,
+						struct request, queuelist);
+			if (same_queue_rq->q != q)
+				plug->do_sort = true;
+		}
+
+		list_add_tail(&rq->queuelist, &plug->mq_list);
+		plug->rq_count++;
+		if (plug->rq_count >= BLK_MAX_REQUEST_COUNT) {
+			blk_flush_plug_list(plug, false);
+			trace_block_plug(q);
+		}
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
-- 
2.17.1

