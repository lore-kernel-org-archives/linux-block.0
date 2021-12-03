Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D124C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 08:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378844AbhLCIUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 03:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238936AbhLCIUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 03:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638519431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nlYXiKMvLZQg0xZi8ZllLflsaYbX8g/D0UlDyA2AWSI=;
        b=ZJhr1scaaDeugfn8991a1us0xY2kxAI25tnVpSfLzdL+Lz2xFLlUk5n5KbOymV/6Kr+qr5
        CORLYTaZ4RFAxHsM8rwdJtBP1fNOCpzsObNTQy5AX6vCb0IUZkFf2X99VPyZTCdZyl9MMo
        Z6XrktX51lFmWj4VLDfeMjEk0ZzkSGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-200-uHg33CnhM56Iey0VfChACQ-1; Fri, 03 Dec 2021 03:17:10 -0500
X-MC-Unique: uHg33CnhM56Iey0VfChACQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D101090821;
        Fri,  3 Dec 2021 08:17:09 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6575410016F4;
        Fri,  3 Dec 2021 08:17:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: null_blk: batched complete poll requests
Date:   Fri,  3 Dec 2021 16:17:03 +0800
Message-Id: <20211203081703.3506020-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Complete poll requests via blk_mq_add_to_batch() and
blk_mq_end_request_batch(), so that we can cover batched complete
code path by running null_blk test.

Meantime this way shows ~14% IOPS boost on 't/io_uring /dev/nullb0'
in my test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b4ff5ae1f70c..20534a2daf17 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1574,7 +1574,9 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		end_cmd(cmd);
+		if (!blk_mq_add_to_batch(req, iob, cmd->error,
+					blk_mq_end_request_batch))
+			end_cmd(cmd);
 		nr++;
 	}
 
-- 
2.31.1

