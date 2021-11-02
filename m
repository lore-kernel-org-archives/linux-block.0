Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E2C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B05660F5A
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKBPjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231911AbhKBPjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbffNhyee4yw6x7uC2yIBuuxxia7kKUlE4aVJ0fnabE=;
        b=ivy2MMcdi0OrjQ+6nUXewSdDwvDS1WrARfYdTPM3/3smG+tQ9IJ/LkqghbsciGt/qdubQt
        IUOJKbZZwcUljmFVJlfeQb79MT+jItp4C48M6v3D2WV6jCsJtMk1ji23AwZLFl3Y1GqjBd
        2GHsCimQpoKp3fitd7WYTGL3mVB0aMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-s0iuYZorOrOBpt3KBfhFiA-1; Tue, 02 Nov 2021 11:36:36 -0400
X-MC-Unique: s0iuYZorOrOBpt3KBfhFiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE0D112A6A8;
        Tue,  2 Nov 2021 15:36:35 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8B45D9D5;
        Tue,  2 Nov 2021 15:36:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/3] blk-mq: only try to run plug merge if request has same queue with incoming bio
Date:   Tue,  2 Nov 2021 23:36:17 +0800
Message-Id: <20211102153619.3627505-2-ming.lei@redhat.com>
In-Reply-To: <20211102153619.3627505-1-ming.lei@redhat.com>
References: <20211102153619.3627505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

