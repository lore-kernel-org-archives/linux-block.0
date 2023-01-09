Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56048C67871
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjAIX2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbjAIX1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:53 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5898DB49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:52 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id b12so7000990pgj.6
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXlrFhwH4HhJPFIyGLm6XVz2plcq5CCa62cjFU51M2c=;
        b=ey0ubQptrxbLVVU1Ep4D6JUQXhCeuJeFgXG/0MkgsHrEgmPAdyj/LO89Kue9heKWMK
         L5Hm2ogJ6IQULq9ongJJfbcHfGBshDeAD4j1VJuliq8AQZc1/T5FQGpMdcnHIOhhB1n9
         0o2cmxDQpcroPA9F2AV2lKhacSi1KBXcv+1sCLyEgLBeDi8hPKzYZ5uGFFhY/GiFP0JV
         mECfsTTue9cIYq1d48J4gLKo0E/rFg7Nv2iHsgXdJnCu9wa5nF44AUMwUnAsZoBbLWK7
         P/rh+oEF+hgmOPD8aS8pFrJezEth1D6VECO1dTMo6+FT3f0tfwlArAIpPJITLgd/l0m4
         DtjA==
X-Gm-Message-State: AFqh2kraOFxI86ghgkpJjVfJfoWU68hEBQRSJ9BEvt01Ofgw0vc8WDvB
        +EDZgJkBEnOsn+2+uYdxFlE=
X-Google-Smtp-Source: AMrXdXuLLP7vdW0TU4ha5YBneNSs7AAwwRAgp53VQUxLBV4Mu8Pjxonk3doxkmTW8f/2ZNoO3hdMKQ==
X-Received: by 2002:aa7:96f9:0:b0:582:7007:3fec with SMTP id i25-20020aa796f9000000b0058270073fecmr30005701pfq.11.1673306871791;
        Mon, 09 Jan 2023 15:27:51 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:50 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 3/8] block: Introduce a request queue flag for pipelining zoned writes
Date:   Mon,  9 Jan 2023 15:27:33 -0800
Message-Id: <20230109232738.169886-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
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
index ef93e848b1fd..b4b4cd3f2912 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -553,6 +553,8 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+/* Writes for sequential write required zones may be pipelined. */
+#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 8
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
@@ -614,6 +616,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_skip_tagset_quiesce(q) \
 	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
+static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
+{
+	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &q->queue_flags);
+}
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
