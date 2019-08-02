Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13514C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FA2173E
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752010;
	bh=ritnmQKeXCNUkl00pdK+bMvgCPeyD/nYb7rU9HK3wAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KFKcyyJH9+GIuoUgjF+uY3lqmsT16WV0qxg1aGHSa7RAHRQHTNper3wK2iM4oXJ0d
	 yM2cCTOdBWeksehFQPr3bm+lFzBovPopDUJI3zPQrTd/DaII2+YjaYksPZB7m2H9Qx
	 pWABXVkglZ5+k6WMutVgdMPMzwBRqZCRi+HuFUGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393291AbfHBNUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393281AbfHBNUJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D19218A3;
        Fri,  2 Aug 2019 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752008;
        bh=ritnmQKeXCNUkl00pdK+bMvgCPeyD/nYb7rU9HK3wAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvXV1hSIK+Ae3Gj1VvZ8kwBVeWWfKa+aEfIUNKxDJN5vYfnkuIn+Q7Tegab0RUPxO
         LssHxI/JAZf7sDnhL7ldvHNBZBVVEpOgepEHn3BN1S8HNxPFP0fDhQlY9FEWiCY/2j
         rGgVlurPZTj0S2uDxEp6d6x3dxZVoHILsXLHjow4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 14/76] rq-qos: use a mb for got_token
Date:   Fri,  2 Aug 2019 09:18:48 -0400
Message-Id: <20190802131951.11600-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit ac38297f7038cd5b80d66f8809c7bbf5b70031f3 ]

Oleg noticed that our checking of data.got_token is unsafe in the
cleanup case, and should really use a memory barrier.  Use a wmb on the
write side, and a rmb() on the read side.  We don't need one in the main
loop since we're saved by set_current_state().

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-rq-qos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e3ab75e4df9ea..06d024204f504 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -202,6 +202,7 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
+	smp_wmb();
 	list_del_init(&curr->entry);
 	wake_up_process(data->task);
 	return 1;
@@ -245,6 +246,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
 	do {
+		/* The memory barrier in set_task_state saves us here. */
 		if (data.got_token)
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
@@ -255,6 +257,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			 * which means we now have two. Put our local token
 			 * and wake anyone else potentially waiting for one.
 			 */
+			smp_rmb();
 			if (data.got_token)
 				cleanup_cb(rqw, private_data);
 			break;
-- 
2.20.1

