Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6575C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 09:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29816101B
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhH3JM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhH3JMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 05:12:25 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85764C06175F
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 02:11:32 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:99a5:7017:6f3e:f1d2])
        by albert.telenet-ops.be with bizsmtp
        id nlBW2500Y30rvgn06lBWZq; Mon, 30 Aug 2021 11:11:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mKdKE-000UIr-BI; Mon, 30 Aug 2021 11:11:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mKdKD-007mOH-In; Mon, 30 Aug 2021 11:11:29 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but not used warning
Date:   Mon, 30 Aug 2021 11:11:28 +0200
Message-Id: <20210830091128.1854266-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If CONFIG_BLK_DEBUG_FS=n:

    block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
      274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
	  |            ^~~~~~~~~

Fix this by moving dd_queued() just before the sole function that calls
it.

Fixes: 7b05bf771084ff78 ("Revert "block/mq-deadline: Prioritize high-priority requests"")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Fix prefix in one-line summary.
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 36920670dccc35f3..c2c724d4e668ebea 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -951,6 +945,12 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-- 
2.25.1

