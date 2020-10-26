Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64564C56201
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 23:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E01920773
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756783;
	bh=cGWIoh6h6aOYlfAIP7Hm21DZreYR0Se6xpETKsgYV8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHz+wMv3c5TnvhP8SBrqgVHWTuGLRsvr8XHlIpamCJisBQf0P3HAXq+GFJjKEtPWQ
	 3hR6juWspxcx+RQT44FvazLMNOOWWKHkpOWuFGr8YX62RKHKzpuU0lgNP2E1cF+4ju
	 CrUjan3Ic5JQ5pbF9DA4peTs/gT/8LeQL6udDVPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410899AbgJZX7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436621AbgJZX4v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 19:56:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCA520882;
        Mon, 26 Oct 2020 23:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756611;
        bh=cGWIoh6h6aOYlfAIP7Hm21DZreYR0Se6xpETKsgYV8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvexm3YBGmxPaCliIvS4g18uCwtzLrkgfUxyJF5SSEFev4tfd9oCJoHdRRv30QriH
         fjkQqs+Sa5UvUp8ka7ibKrJ++3b9gagdJR6z3EW8/MKTJcIN0nRsOLQYQWUNSFzZh+
         9mqzT0fjU3N+W2JUqf7EfJEXhf0YHYhqJ/haVjsg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.4 78/80] nbd: make the config put is called before the notifying the waiter
Date:   Mon, 26 Oct 2020 19:55:14 -0400
Message-Id: <20201026235516.1025100-78-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 87aac3a80af5cbad93e63250e8a1e19095ba0d30 ]

There has one race case for ceph's rbd-nbd tool. When do mapping
it may fail with EBUSY from ioctl(nbd, NBD_DO_IT), but actually
the nbd device has already unmaped.

It dues to if just after the wake_up(), the recv_work() is scheduled
out and defers calling the nbd_config_put(), though the map process
has exited the "nbd->recv_task" is not cleared.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7c577cabb9c3b..742f8160b6e28 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -787,9 +787,9 @@ static void recv_work(struct work_struct *work)
 
 		blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
 	}
+	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
-	nbd_config_put(nbd);
 	kfree(args);
 }
 
-- 
2.25.1

