Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF2C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB5206B7
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfAIU7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:59:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:38502 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAIU7d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 15:59:33 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0DC242CD;
        Wed,  9 Jan 2019 20:59:33 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:59:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: fix kerneldoc comment for blk_attempt_plug_merge()
Message-ID: <20190109135932.7578d716@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 5f0ed774ed29 ("block: sum requests in the plug structure") removed
the request_count parameter from block_attempt_plug_merge(), but did not
remove the associated kerneldoc comment, introducing this warning to the
docs build:

  ./block/blk-core.c:685: warning: Excess function parameter 'request_count' description in 'blk_attempt_plug_merge'

Remove the obsolete description and make things a little quieter.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c78042975737..eba494f528cb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -661,7 +661,6 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
  * @bio: new bio being queued
- * @request_count: out parameter for number of traversed plugged requests
  * @same_queue_rq: pointer to &struct request that gets filled in when
  * another request associated with @q is found on the plug list
  * (optional, may be %NULL)
-- 
2.20.1

