Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiDMIvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDMIvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 04:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F2194D255
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649839727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WrI3OQEUfBcdGVnmfYTqU5sVa21b6b59N7LBxcup3vA=;
        b=f1mNh9pD1ErSHn4ITPk3LrhEqyPlBQpfE3Ja/MLxkaL4d5IvMt7cydLKl0o0Yoq9dYEEft
        KQF5E5huzFchLjekLNoQIXA//VaJjQXoXo9AX+mPmfq2+MiyN87AkbanCLWmXD0hPLdq1j
        UkuKEzFVC+09iN/NftqMb+BRql273RM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-7NRnhpTeOHip0GyMkko4AQ-1; Wed, 13 Apr 2022 04:48:46 -0400
X-MC-Unique: 7NRnhpTeOHip0GyMkko4AQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3F4D811E76;
        Wed, 13 Apr 2022 08:48:45 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4CAB2166B4F;
        Wed, 13 Apr 2022 08:48:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: null_blk: end timed out poll request
Date:   Wed, 13 Apr 2022 16:48:36 +0800
Message-Id: <20220413084836.1571995-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When poll request is timed out, it is removed from the poll list,
but not completed, so the request is leaked, and never get chance
to complete.

Fix the issue by ending it in timeout handler.

Fixes: 0a593fbbc245 ("null_blk: poll queue support")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..c441a4972064 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1600,7 +1600,7 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 	 * Only fake timeouts need to execute blk_mq_complete_request() here.
 	 */
 	cmd->error = BLK_STS_TIMEOUT;
-	if (cmd->fake_timeout)
+	if (cmd->fake_timeout || hctx->type == HCTX_TYPE_POLL)
 		blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
-- 
2.31.1

