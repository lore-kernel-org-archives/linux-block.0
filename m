Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C22C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C95206CB
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgJFTPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:15:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgJFTPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:15:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D565629A897
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
Subject: [RESEND PATCH v2] block: Consider only dispatched requests for inflight statistic
Date:   Tue,  6 Oct 2020 15:15:09 -0400
Message-Id: <20201006191509.2482378-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Reviving this, hopefully for the upcoming merge window, following the
suggestion that we let it sit there and see if people complain about the
metric fix.  As I mentioned, I'm also happy to change the documentation
plus create a new in_device metric to track only requests submitted, if
you prefer.

Thanks,

>8

According to Documentation/block/stat.rst, inflight should not include
I/O requests that are in the queue but not yet dispatched to the device,
but blk-mq identifies as inflight any request that has a tag allocated,
which, for queues without elevator, happens at request allocation time
and before it is queued in the ctx (default case in blk_mq_submit_bio).

In addition, current behavior is different for queues with elevator from
queues without it, since for the former the driver tag is allocated at
dispatch time.  A more precise approach would be to only consider
requests with state MQ_RQ_IN_FLIGHT.

This effectively reverts commit 6131837b1de6 ("blk-mq: count allocated
but not started requests in iostats inflight") to consolidate blk-mq
behavior with itself (elevator case) and with original documentation,
but it differs from the behavior used by the legacy path.

This version differs from v1 by using blk_mq_rq_state to access the
state attribute.  Avoid using blk_mq_request_started, which was
suggested, since we don't want to include MQ_RQ_COMPLETE.

Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e4b3cad2a61..c5fefd39d0c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
-- 
2.28.0

