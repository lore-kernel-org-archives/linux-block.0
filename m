Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiFWX0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:15 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22152E67
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:14 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id w24so1058371pjg.5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTLxuQEEkdEPzGrA/9/qnJZUc0U6t5sn8h6Rs+LkkCQ=;
        b=JJJbSwRrIutPZqN5crpNK2FvoabC1AN97IY47gfvr5nfaeS8lhQgmtJrV0xNbWfOwA
         WfVwzvLrs1XanF2NONjbxGZJOU/GIXDipoptqUtGQXrGn35hOWBRpg+zzB/Zz48pm+pS
         /4l1FRglsC2TRSz/J5tHucy6r6e+t+XXPzAsUzw340yuDHAEUSh0vWtkvDrnbYe5nFCu
         EkYL8EdAJNlTGpPp8lov1CI+6xwin3LlT/fVlgGUp2Xk9SuAfonFESXtf8yyP7Yzbpar
         9iAgexYlwixi3MbbwC+BeNeNxzZwv7og/M7imsAM74DiTRwr8CcER34+KFpjUOWFfwyP
         oeZw==
X-Gm-Message-State: AJIora995HxlWw5yWVlyN24FPmRCnqx3t+R4ghgXiQ5oS7s+RBC/zxS4
        8phs5nEV7qvBrGaFgHRgWaI=
X-Google-Smtp-Source: AGRyM1tiBmwjVp9iHdEpayq9QehC7y8OrJaqeykxyR8ydEMlWdpmbmomavNM3UqZPui74T2oW7tPRg==
X-Received: by 2002:a17:90b:1c8e:b0:1ea:4b95:1348 with SMTP id oo14-20020a17090b1c8e00b001ea4b951348mr431092pjb.153.1656026774265;
        Thu, 23 Jun 2022 16:26:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 3/6] block: Introduce a request queue flag for pipelining zoned writes
Date:   Thu, 23 Jun 2022 16:26:00 -0700
Message-Id: <20220623232603.3751912-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
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
index 2904100d2485..fcaa06b9c65a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -581,6 +581,8 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+/* Writes for sequential write required zones may be pipelined. */
+#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 31
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -624,6 +626,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
+static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
+{
+	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &(q)->queue_flags);
+}
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
