Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06FC433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01D360FBF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhJYJta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbhJYJrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOP9rwHSMw0FldXixZurqeParp/5xlzjQIBGTNHgOKg=;
        b=Xp45lVnFK1PoyO+YBANi2LINpaXV3wc/6E39UeLfCva1u7V982KNx0kh6L0tblvw2N2RTN
        LM9MysXIfCjK5oHGSGE3tjq1GXT9EfmZA2mZGxET7EdHBCIpHe77ePik+g27PkqUPAfKtx
        j6Taov82zTnoiPq7z6QlNYHXZwsj5vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hjcuPYa2NeKs1FqnH8dOJw-1; Mon, 25 Oct 2021 05:45:07 -0400
X-MC-Unique: hjcuPYa2NeKs1FqnH8dOJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26543CC636;
        Mon, 25 Oct 2021 09:44:53 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42F331002EE2;
        Mon, 25 Oct 2021 09:44:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] loop: remove always true check
Date:   Mon, 25 Oct 2021 17:44:31 +0800
Message-Id: <20211025094437.2837701-3-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In lo_complete_rq(), in case of !cmd->use_aio, we simply call
blk_mq_end_request(), so the check of cmd->use_aio isn't necessary,
since it is always true when the check is run.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8f140d637435..8c3f5d2affc7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -539,13 +539,11 @@ static void lo_complete_rq(struct request *rq)
 		cmd->ret = 0;
 		blk_mq_requeue_request(rq, true);
 	} else {
-		if (cmd->use_aio) {
-			struct bio *bio = rq->bio;
+		struct bio *bio = rq->bio;
 
-			while (bio) {
-				zero_fill_bio(bio);
-				bio = bio->bi_next;
-			}
+		while (bio) {
+			zero_fill_bio(bio);
+			bio = bio->bi_next;
 		}
 		ret = BLK_STS_IOERR;
 end_io:
-- 
2.31.1

