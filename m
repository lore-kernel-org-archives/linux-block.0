Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8CCC76188
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E2921849
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510518;
	bh=GR4SIol2VzsKNVqc9HUATBFbm3+d6wZOlhp3mC9c6/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F2Jdnyrngu4L36DGEDdJxN9v1G5JrXfA4shR0+UHkZNR94ZxqF6FqlnayIfmSkZ/e
	 C8F9BVmC1+6q8QSjAbX4MEvjsf6LGpa7RYpwVFYmkqUa113+XM6VYz1VYDfAfuzQmf
	 qwPPFOwjHh6qX8Zo1B4W9Y7GV6AzPmeFDND+7Qr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfGSE2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732114AbfGSEG0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 00:06:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81BC218B8;
        Fri, 19 Jul 2019 04:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509185;
        bh=GR4SIol2VzsKNVqc9HUATBFbm3+d6wZOlhp3mC9c6/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDdC5cVdtZejU1kAM7QhthFlELGj9MhjedA++Yx8pjq1Km2pN1VojdDOpRhjy4qMP
         ZQi79QfgKdpxwW0oVqxQxzmpT+zKDYHJ7qnXTusLC/0+Y/zKWbhQjtZO+IBalTgiJr
         4vsFbR0SZIzLGdTaZbHqow/+MjD59sfu1fHeYJhM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 113/141] block: init flush rq ref count to 1
Date:   Fri, 19 Jul 2019 00:02:18 -0400
Message-Id: <20190719040246.15945-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit b554db147feea39617b533ab6bca247c91c6198a ]

We discovered a problem in newer kernels where a disconnect of a NBD
device while the flush request was pending would result in a hang.  This
is because the blk mq timeout handler does

        if (!refcount_inc_not_zero(&rq->ref))
                return true;

to determine if it's ok to run the timeout handler for the request.
Flush_rq's don't have a ref count set, so we'd skip running the timeout
handler for this request and it would just sit there in limbo forever.

Fix this by always setting the refcount of any request going through
blk_init_rq() to 1.  I tested this with a nbd-server that dropped flush
requests to verify that it hung, and then tested with this patch to
verify I got the timeout as expected and the error handling kicked in.
Thanks,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2dd94b3e9ece..aac658392d60 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,6 +116,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
+	refcount_set(&rq->ref, 1);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
-- 
2.20.1

