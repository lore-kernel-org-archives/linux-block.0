Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D15EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 09:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUJ65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 05:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGUJ6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 05:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAC230D0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689933472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b0nHwjWcsp+W/OaOjkY6STKOBbOkup/xTzmeKyNAZZc=;
        b=BE/lMtibgOVSDE+Y3Y8tI/lRZ0TI4x5WKyaKHicIHEJH2ikL+AmMAc54ewsUomLWoaP+MA
        pcbaJbG3muLivy3DNHH0S0aka4bQ6QqVX6hnqfYxG0uNwumkTpQ1ruGbC2f4EQeFPO4xx8
        cSfoIBw2+MLTAoA88Hji1Ddpjr5oY5Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-mBmg0NjjMO2IcULtc4akeA-1; Fri, 21 Jul 2023 05:57:50 -0400
X-MC-Unique: mBmg0NjjMO2IcULtc4akeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28D2F293248C;
        Fri, 21 Jul 2023 09:57:50 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D58E940C206F;
        Fri, 21 Jul 2023 09:57:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH] sbitmap: fix batching wakeup
Date:   Fri, 21 Jul 2023 17:57:15 +0800
Message-Id: <20230721095715.232728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: David Jeffery <djeffery@redhat.com>

Current code supposes that it is enough to provide forward progress by just
waking up one wait queue after one completion batch is done.

Unfortunately this way isn't enough, cause waiter can be added to
wait queue just after it is woken up.

Follows one example(64 depth, wake_batch is 8)

1) all 64 tags are active

2) in each wait queue, there is only one single waiter

3) each time one completion batch(8 completions) wakes up just one waiter in each wait
queue, then immediately one new sleeper is added to this wait queue

4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
wait queue

5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
can't be waken up anymore.

Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
single batch.

Cc: David Jeffery <djeffery@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/sbitmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index eff4e42c425a..d0a5081dfd12 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -550,7 +550,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
 static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
-	int i, wake_index;
+	int i, wake_index, woken;
 
 	if (!atomic_read(&sbq->ws_active))
 		return;
@@ -567,13 +567,12 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 		 */
 		wake_index = sbq_index_inc(wake_index);
 
-		/*
-		 * It is sufficient to wake up at least one waiter to
-		 * guarantee forward progress.
-		 */
-		if (waitqueue_active(&ws->wait) &&
-		    wake_up_nr(&ws->wait, nr))
-			break;
+		if (waitqueue_active(&ws->wait)) {
+			woken = wake_up_nr(&ws->wait, nr);
+			if (woken == nr)
+				break;
+			nr -= woken;
+		}
 	}
 
 	if (wake_index != atomic_read(&sbq->wake_index))
-- 
2.40.1

