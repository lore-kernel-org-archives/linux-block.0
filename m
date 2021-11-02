Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77201C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57929610E5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBNjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBNi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635860184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbffNhyee4yw6x7uC2yIBuuxxia7kKUlE4aVJ0fnabE=;
        b=F/hUmpSXurmSm1WB7jfcuMVHCSCuh2jYD19gMjTwEfG3VM5iMHs6j7y3G4NpFN9tDGQue8
        PARj+ifWASyC/IaYUoRgQAkRp5fkqDPPb82bByL8Zv6JuGEKNNRLfDkZ6PuZzXx+frXpMw
        7Yqw1ccr/webom81VDGq59Ue9pCDxoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-mZqzxZDfPGS4-o6UKNhcnQ-1; Tue, 02 Nov 2021 09:36:23 -0400
X-MC-Unique: mZqzxZDfPGS4-o6UKNhcnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6BD11B4744;
        Tue,  2 Nov 2021 13:36:22 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 756825F4EF;
        Tue,  2 Nov 2021 13:35:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] blk-mq: only try to run plug merge if request has same queue with incoming bio
Date:   Tue,  2 Nov 2021 21:35:00 +0800
Message-Id: <20211102133502.3619184-2-ming.lei@redhat.com>
In-Reply-To: <20211102133502.3619184-1-ming.lei@redhat.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is obvious that io merge can't be done between two different queues, so
just try to run io merge in case of same queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index df69f4bb7717..893c1a60b701 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1101,9 +1101,11 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		 * the same queue, there should be only one such rq in a queue
 		 */
 		*same_queue_rq = true;
+
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+				BIO_MERGE_OK)
+			return true;
 	}
-	if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
-		return true;
 	return false;
 }
 
-- 
2.31.1

