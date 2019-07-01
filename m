Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D666BC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452321479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfGAPmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:42:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45187 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfGAPmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:42:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so6760498pfq.12
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7HppAsTvOgVLoaEVfL9rVQpSo+OVVN0OGx8cG98PLk=;
        b=kxk6MeKPvJBAURL1FcaDATfK53nTs/UoWUavrqPuGzWJlIIBay22swNyBTaj0XmgYD
         dguKjfY5db8ZrEDCHy5YL2T4DBHBpvavpyFk+7BYj6SdIeBuuxFJB++eBJcuYIGzcJMl
         IEe9L3O51CsSRP0E3MF57xsL4kfo0rA+bktWdGdU6XcrE9Z8RLvPQpe2iHcVTICP12hm
         ozg7ojrlh04k97BX7kGYnSNu3+goLpLGPXwKNb2DEtYoYNRxTLUdI7rbtE/ERIpZU+ss
         hSVpzXSur2RFMd411xJVtT5rCIyIFHvP7JwcOFZHpEzsR5ml9wny3FAs1KLjPbRAQHDU
         EP/Q==
X-Gm-Message-State: APjAAAU6bMb6OBzHQFBaLbDMNbDptBTxW6/UF0Y2uNCA/bT5L3iF63g4
        3pROdvY3MYxspmeug1aHh9c=
X-Google-Smtp-Source: APXvYqw6PBWufdEsKkAD9PmE+9E+W3xeaqMuoYNfTbCcyaSXYn4eyNoHV0LxNnKNtTXHl7MjVcPhTg==
X-Received: by 2002:a63:4c0b:: with SMTP id z11mr25767916pga.440.1561995756117;
        Mon, 01 Jul 2019 08:42:36 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n98sm12043027pjc.26.2019.07.01.08.42.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:42:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH] block: Fix a comment in blk_cleanup_queue()
Date:   Mon,  1 Jul 2019 08:42:30 -0700
Message-Id: <20190701154230.202921-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change a reference to the legacy block layer into a reference to blk-mq.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2e5e677d1cee..6361419f0b6e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -346,7 +346,8 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-	 * prevent that q->request_fn() gets invoked after draining finished.
+	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
+	 * after draining finished.
 	 */
 	blk_freeze_queue(q);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

