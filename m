Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668DC04A94
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGaWPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGaWPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:24 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF0121
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:23 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bbc7b2133fso31819585ad.1
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841723; x=1691446523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXHK95/CmEAoQ1Wi641vQDpGLWHT/1L7/uwvS0Slz8U=;
        b=TCwVvIYYqj7G4/0cnd3YFVqwr815O/Qx0flM1EnDaeraIsT0Ik8n1ixnT0oZxtZKI0
         G8pTtqS0IdFE/jiQTpMHk842lpdcYWLNPssVkm4qyhRZuOc1CWZ1VezwWHDaWozO2X13
         v7lxj792APnvIYCljF5uMELmCpjLm8Aot0I+UQBAO5ktrHk/ufBbIPpJ2SoV7ezA9On3
         FgT6kFvpoEsjZ9uBPtCJs57QlOrvs/UZYMAgBN/q6KWS+WuOP2nTfitPm+RaktU4qEOk
         mGU83ch38z1NaPAfA39opZ7mw3Adgg3BupqhNAqFUP8z1PSjwnxrfgtG9yD+lTCrrIJW
         PGmQ==
X-Gm-Message-State: ABy/qLa19Cbbhh1Sfc5VC6SehX6XmdUhXe+COjBDN4OxDtVTq8Fwrgma
        SthwfvaIW/4dVlnLa5oJqd0=
X-Google-Smtp-Source: APBJJlEHxYmyT8tsF7+LW6TmH+NSui1VGCrg+QiiGWuwG66Dh70wpNXHI7YBcQPJBrLrn4gcV2kYNg==
X-Received: by 2002:a17:903:11d0:b0:1b6:bced:1dd6 with SMTP id q16-20020a17090311d000b001b6bced1dd6mr11851617plh.35.1690841723183;
        Mon, 31 Jul 2023 15:15:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 1/7] block: Introduce the flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Date:   Mon, 31 Jul 2023 15:14:37 -0700
Message-ID: <20230731221458.437440-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
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
require this serialization. Introduce a new request queue flag to allow
block drivers to indicate that they preserve the order of write commands
and thus do not require serialization of writes per zone.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f5371b8482c..de5e05cc34fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -534,6 +534,11 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+/*
+ * Do not serialize sequential writes (REQ_OP_WRITE, REQ_OP_WRITE_ZEROES) sent
+ * to a sequential write required zone (BLK_ZONE_TYPE_SEQWRITE_REQ).
+ */
+#define QUEUE_FLAG_NO_ZONE_WRITE_LOCK 8
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
@@ -597,6 +602,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_skip_tagset_quiesce(q) \
 	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
+static inline bool blk_queue_no_zone_write_lock(struct request_queue *q)
+{
+	return test_bit(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, &q->queue_flags);
+}
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
