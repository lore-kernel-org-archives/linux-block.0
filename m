Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE94EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGJSC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGJSCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:24 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCC11B
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:23 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1b060bce5b0so4124480fac.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012142; x=1691604142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MriTkQt0C3boYQDOV/LvSCg2biMhVn5vndXXr9b78HU=;
        b=ZxBRWGoP6/MBwZUMMiApX7SefuFXfuSETyCRWgxNgfKJe/ObcvOpFuOgVB2Hu1g0p2
         hCB1Lovg9Z8haeKfBzUNsBnzqL9Z5EKtda1gSpIo/vWglrRkU+PIs73hg1xUksOP8g6p
         2YLpUdCwdFhExoMbKzmKewSfe1WaPS+Q/17eU9Ic9xtXURZCXBWXocpcV/xGhBg/vCtU
         VJYAzM8G/X42DLduwclE9hT9pyqo+61j97EvYzUFzgtLAj2cP3tUQnT/bm7iTjzZZ5yg
         4c/V3f31Yg4gBhyQxOK8nx9YfCisL9FT3EMtP4aPYdpCnMJyXIjz5XfWcr9luVmkcra1
         HsHg==
X-Gm-Message-State: ABy/qLZeZ2iKJi8YKh06nT3/5pYtzfwIvmeazzYuaxCEegDwSt+S3G+p
        iqjg2Ntol8gM2Xt0GDxtNDY=
X-Google-Smtp-Source: APBJJlELzuC7updyF+1xMdghxfYzZJWWNfqiIGRGXvOjIVrrA+4VV1/JBHTwvCD4M91G76u0Dgzpaw==
X-Received: by 2002:a05:6870:5607:b0:1b3:df19:b1b9 with SMTP id m7-20020a056870560700b001b3df19b1b9mr13771350oao.15.1689012142431;
        Mon, 10 Jul 2023 11:02:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 1/5] block: Introduce a request queue flag for pipelining zoned writes
Date:   Mon, 10 Jul 2023 11:01:38 -0700
Message-ID: <20230710180210.1582299-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230710180210.1582299-1-bvanassche@acm.org>
References: <20230710180210.1582299-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Writes in sequential write required zones must happen at the write
pointer. Even if the submitter of the write commands (e.g. a filesystem)
submits writes for sequential write required zones in order, the block
layer or the storage controller may reorder these write commands.

The zone locking mechanism in the mq-deadline I/O scheduler serializes
write commands for sequential zones. Some but not all storage controllers
require this serialization. Introduce a new flag such that block drivers
can request pipelining of writes for sequential write required zones.

An example of a storage controller standard that requires write
serialization is AHCI (Advanced Host Controller Interface). Submitting
commands to AHCI controllers happens by writing a bit pattern into a
register. Each set bit corresponds to an active command. This mechanism
does not preserve command ordering information.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..805012c5a6ab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -534,6 +534,8 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+/* Writes for sequential write required zones may be pipelined. */
+#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 8
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
@@ -596,6 +598,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_skip_tagset_quiesce(q) \
 	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
+static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
+{
+	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &q->queue_flags);
+}
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
