Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3EC001E0
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGZTfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGZTfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:04 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0001BE3
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:03 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6687466137bso199314b3a.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400103; x=1691004903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRbmBTjr8uNkUCS+MmlXaDe5TIY3it4ulF691kaB6aA=;
        b=I23imBklO8Sob93UDKsgy3SUBdVyicuHu8zEF3uWilJl/Vy4J9+1ofci2DOf+pPiDO
         +oRzJNPPXIDhAuVOMmWq27P8278ePi6TyKxK1KqdxS9NPr+1TO5mss1SG646D+atJYxE
         +AHIzyBFAyMsLzZc5lpL9U7TA8a+/AWMqt+zZOkgHNhrErVLEi1Wix39yDO5XTgqfxta
         Wq0SpOw20hcVvIp09XFBie6yMpIQeXxFvk2TEaat9rbElxmAbh+3q56fTQ1dd7oDcB8+
         GGha8P/6Yr/gHc1odrFrZW8jwJ1bq8GEp96C8lEJqUiF+kbz3PHQ21r612YpttjJzGZJ
         YKLA==
X-Gm-Message-State: ABy/qLbPL8AWYT7WYdOR8pHGZbK/zuU5QBryYIUew8IKjNnkci95ZxbV
        3SaJZ7/XJWxvGBXb4SL21vk=
X-Google-Smtp-Source: APBJJlHw5dCGZMqy8PYK9aNa8fLWNecqEk1y46e/Od/tm+rMRhAis2mlPbG83XhJkBDIJqAzwX85LQ==
X-Received: by 2002:a05:6a00:994:b0:64f:7a9c:cb15 with SMTP id u20-20020a056a00099400b0064f7a9ccb15mr3573711pfg.11.1690400102601;
        Wed, 26 Jul 2023 12:35:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 1/7] block: Introduce the flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Date:   Wed, 26 Jul 2023 12:34:05 -0700
Message-ID: <20230726193440.1655149-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726193440.1655149-1-bvanassche@acm.org>
References: <20230726193440.1655149-1-bvanassche@acm.org>
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
can request that zone write locking is disabled.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f5371b8482c..066ac395f62f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -534,6 +534,11 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+/*
+ * Do not use the zone write lock for sequential writes for sequential write
+ * required zones.
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
 
