Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5311EC388F3
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD902053B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfI3XBC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so6457913pfb.7
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gONO+eawvhG9dGAqmnmHeqA2HilJJZze++x5pSgsNdY=;
        b=KqtS5g6YvPYpLT+1AmvQ/NjA0FBJz05lhO7p2zBUaUXh01AQfwT3vvVxIGY6aqKOIl
         iP/yaSgDQXgL66CivihY6Tb505gg0Hncjg1VLiEM/kD5myDF0ETAzOtjGLQHD4HR63Gk
         l/AKyZSMrVTCqaTL0fDSJ/dG5vRD5LWCRfQFnRVZsLvlFCnLmVu0uw3Ht7tR4UgQMIvW
         clPKJcfc/sNlzzkyYXpR2qH3W8EdBB9ajD8doz3nNSiQo8ICHMxfiMtxO1uhYsPotq9Z
         1I+sGlAwwsbpT5DmdCvm8kYvEBhHV9Ko5rJdSRSkhM4Yit/Fn1X+o234gi3j9dnVHsP2
         nxxQ==
X-Gm-Message-State: APjAAAUKvUSmrV89DdufIFruzhiCn+k/RCKiHB12KWRDuc0tBg9rp2a5
        alW1CYXq3BsmXH44S+fUo/M=
X-Google-Smtp-Source: APXvYqxfEbgUGwH5EoQjEMJeSHoXQK6rsDVyoD4duNzu6+nwJrfshaTm6eeoTiNZCCZsUHbrfUq4oQ==
X-Received: by 2002:a62:8702:: with SMTP id i2mr24197492pfe.187.1569884461856;
        Mon, 30 Sep 2019 16:01:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:01:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 5/8] block: Reduce sysfs_lock locking inside blk_cleanup_queue()
Date:   Mon, 30 Sep 2019 16:00:44 -0700
Message-Id: <20190930230047.44113-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_cleanup_queue() is called after blk_unregister_queue() and
since that last function removes all sysfs attributes, serializing
any code in blk_cleanup_queue() against sysfs callback methods nor against
I/O scheduler changes is necessary. Hence remove the syfs_lock locking
calls from the start of blk_cleanup_queue().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8b51d9ec8ae3..ae506ac2dd48 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -339,13 +339,11 @@ void blk_cleanup_queue(struct request_queue *q)
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
-	mutex_lock(&q->sysfs_lock);
 	blk_set_queue_dying(q);
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	mutex_unlock(&q->sysfs_lock);
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-- 
2.23.0.444.g18eeb5a265-goog

