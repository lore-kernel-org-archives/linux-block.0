Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFBC43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiF0Xnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiF0Xny (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:54 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E817584
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:53 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d5so9514572plo.12
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJDQo1edv17A+CGMDNmnBvmmgGLDtDKHNKtqJiAWE30=;
        b=IWgwBt5Dpg3Ll++hSGlkVvtKN6ihzowRIPHd82h7L6PWrE5HWmHfRDXtHrEdhzCiga
         +OXSrpB6np63UESnXTkKzHzB64YnMtWuMGd+qCvU+mxdLWYJ9uOxRqwyyDHnIHGNr7a0
         CP0busBSQxyy0ErvOVJ+fajmcYdgI89sui6goDjCyU/RI0RLfjnF+VXCwu8sDx+ZPLNq
         GfNlR6Vv7O1p+xdkJQJj5w9R1o9VNbk5cmbAeiTz8l6TIBvN7gPoASmBOLuq8orH1Y1m
         K1q37lC4Qn1B1xCJzeJ+JeAwQMHrVLcVWgIGVjkPhQqP6SpqUrS7pwrWFdUaAc1dkr6H
         KH9A==
X-Gm-Message-State: AJIora9FSBbNrQp/3GkDw7+hH/17bfJz7Ls666kCSNMLCaXQn0QZ412I
        pdrPOyDfONU7W0DTe6MA1mFY4fq9XIo=
X-Google-Smtp-Source: AGRyM1u0rLcDrR1B4LTJyVOdpbLzf8IFL59EIrNA6o+JSHy/lalShn2UyoYKepzVX+xJollSGiOi0A==
X-Received: by 2002:a17:902:c94b:b0:16a:6427:ae5d with SMTP id i11-20020a170902c94b00b0016a6427ae5dmr669244pla.127.1656373432879;
        Mon, 27 Jun 2022 16:43:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 3/8] block: Introduce a request queue flag for pipelining zoned writes
Date:   Mon, 27 Jun 2022 16:43:30 -0700
Message-Id: <20220627234335.1714393-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
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
index 6491250ba286..7ee59e507fbf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -580,6 +580,8 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+/* Writes for sequential write required zones may be pipelined. */
+#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 31
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -623,6 +625,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
+static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
+{
+	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &(q)->queue_flags);
+}
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
