Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD99EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGTJtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGTJt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:49:27 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008F197
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:47:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYyPqspkOuXVMavHO7B8mxFBAqzpe8Xduz/Ay3699EE=;
        b=pw5sQb18kA//kymlNb+qvXIDo6jCV6+mmT0zU6VFQozPJNN8PoBdLacoMJrd/1FqdpJvcW
        VwuVolXq85zUUtFfX40ZQSiEGTsPAgEbohducF49YxBq9Q/Wf59Odv9Bl0BlUS6IqohIJQ
        /iml5vko4ls+yXcePH2pF7w/oW2Of3U=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 6/6] sbitmap: check ws_active before check waitqueues
Date:   Thu, 20 Jul 2023 17:45:55 +0800
Message-ID: <20230720094555.1397621-7-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

When !ws_active, we don't need to check waitqueues at all. So add
this check in sbitmap_queue_wake_all(), like we do in
sbitmap_queue_wake_up().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 6778ab3fc6a5..38c265e4ef9d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -672,6 +672,10 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	 * sbitmap_queue_wake_up().
 	 */
 	smp_mb();
+
+	if (!atomic_read(&sbq->ws_active))
+		return;
+
 	wake_index = READ_ONCE(sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
-- 
2.41.0

