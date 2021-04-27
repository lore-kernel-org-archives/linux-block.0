Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D4EC433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA750613C1
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhD0PLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbhD0PLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 11:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619536270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUkMNPgSRxsQpQnzl5iNntxxa5OYWKJ2UBgTtKX54ws=;
        b=isF+7ALsBgbpgVxi06UsjCCjEVG7iHvYmMTLpf6nNKFEqV2otUc/B/nuR/q6GyL3Qf2/ia
        g0TH4JnN0pFWl73HirDrAVJ+nUWoZPcJihTKfYu8sN198bDryJ+raLXC8EIfhD5gFbG2/W
        FXABdxicrcGbdYgm3zoeYs9NSCRnBU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-CE9xpnzYOPGPVUSHmZCNLA-1; Tue, 27 Apr 2021 11:11:06 -0400
X-MC-Unique: CE9xpnzYOPGPVUSHmZCNLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3977107ACC7;
        Tue, 27 Apr 2021 15:11:04 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ADEB5C260;
        Tue, 27 Apr 2021 15:11:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/3] block: avoid double io accounting for flush request
Date:   Tue, 27 Apr 2021 23:10:56 +0800
Message-Id: <20210427151058.2833168-2-ming.lei@redhat.com>
In-Reply-To: <20210427151058.2833168-1-ming.lei@redhat.com>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For flush request, rq->end_io() may be called two times, one is from
timeout handling(blk_mq_check_expired()), another is from normal
completion(__blk_mq_end_request()).

Move blk_account_io_flush() after flush_rq->ref drops to zero, so
io accounting can be done just once for flush request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7942ca6ed321..1002f6c58181 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,8 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 
-	blk_account_io_flush(flush_rq);
-
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
@@ -230,6 +228,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	blk_account_io_flush(flush_rq);
 	/*
 	 * Flush request has to be marked as IDLE when it is really ended
 	 * because its .end_io() is called from timeout code path too for
-- 
2.29.2

