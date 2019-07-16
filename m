Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87924C76192
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D4120659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="t2F7t4vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGPUTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39056 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so20978794qtu.6
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kr2XG802Hn4GL9ZD3rFYFWnpPNcGVnzMvAnWfTnII4Q=;
        b=t2F7t4vpZf3J8aVWGrSGt5Kl3Os4II0Ymsw/XqA8yZ3zMBVK0mZSddvn9jkU8CE7WY
         E5dyFhNX9cLuzRRgrYy1imo/6WpFc9QYnW5Lbwu6MD5VdcaJFfkjsnc0JpBUed4PicAZ
         M7/B3P5xulAp8DdMfLmeeO60G+qR35EQZsM65/7P6qv1rpTAdv8EoqFi4vX/NWb9b+rJ
         KaWBta7036V2SWkjBEhhJxtU/THrx3A5kAXjWfLrHXytCYNDd6NyUxfC51Dg+LKwTeqw
         yV7AkbkflOCLuwWKk64TnoEiYiUqOHSpKoV5q5dTVdBInSzME213HOzTg31azZGSC/6o
         Omog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kr2XG802Hn4GL9ZD3rFYFWnpPNcGVnzMvAnWfTnII4Q=;
        b=Ap/7BuDBwv1HrY3+VeV3x9G1ppjYaqTfL0D1s53bXkM+GT/9VlZzN5YKrnjq4g2Ngh
         lInGg+FgMEqpNtAFGCIFb+FTD6oIXfdBjfBLxQugQoMUFc78qiQ6yNLdyXZ1vtwcxkjY
         0XCezsb73CRaG6zq09o9c2cHVxE9p/o//SJDY1epgK7+ssH8p8KLYUX0ebEmN5fnrzi4
         V76tMybeVRw8s2+zktja/2jjr6ykNwqh375mlK8SByEaSLudXIoXBK+WPkfIT6PbOH1u
         61TQpRR0vuL6/cyJqJhX7R4XxadGG078lEueqAiNmdgB3LkmNb5I+7ZK6uNOH6NUuqrC
         35SA==
X-Gm-Message-State: APjAAAXGK4x174Dv6BWBwx2Z82xRswFtLNmUW0uvsfuznVfiuiCMBbI9
        VQ/92P1J8xn6Hb0pRunR6dg=
X-Google-Smtp-Source: APXvYqxWVJbsw2SX+E/ilTHH9Jf7CD/xtBadcxZ6FOT6Hjfmuzwz5IY2/7dCww9jSpMqVewH/sBoDw==
X-Received: by 2002:ac8:2d08:: with SMTP id n8mr24177161qta.383.1563308382867;
        Tue, 16 Jul 2019 13:19:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id k25sm7574655qta.78.2019.07.16.13.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 5/5] rq-qos: use a mb for got_token
Date:   Tue, 16 Jul 2019 16:19:29 -0400
Message-Id: <20190716201929.79142-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oleg noticed that our checking of data.got_token is unsafe in the
cleanup case, and should really use a memory barrier.  Use a wmb on the
write side, and a rmb() on the read side.  We don't need one in the main
loop since we're saved by set_current_state().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index c450b8952eae..3954c0dc1443 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -202,6 +202,7 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
+	smp_wmb();
 	list_del_init(&curr->entry);
 	wake_up_process(data->task);
 	return 1;
@@ -246,6 +247,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
 	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
 	do {
+		/* The memory barrier in set_task_state saves us here. */
 		if (data.got_token)
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
@@ -256,6 +258,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			 * which means we now have two. Put our local token
 			 * and wake anyone else potentially waiting for one.
 			 */
+			smp_rmb();
 			if (data.got_token)
 				cleanup_cb(rqw, private_data);
 			break;
-- 
2.17.1

