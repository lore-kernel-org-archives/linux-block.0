Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E407AC76195
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8C72054F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203361;
	bh=3jtqXFsdy9+nN0Tz9J17po0Nvk+gwLyZ0NOhRPT6fiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6CtSiZNy1NmhDx/KmoMLFo7MpvI+fnehC/syJf9GVGV2mzCOq35XsxASmuyzbqqF
	 upR6xxj/ouv6fNjp6Aw6kI6EcztJbXTeb22VvnJYBjEMlxKYEeUIzbVSKrs5X+jWnb
	 /HMMCGyJSfCkj6BEJL1fhs/2fCYMCAO/VwCgK4Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfGON5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732378AbfGON5L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 09:57:11 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5B420C01;
        Mon, 15 Jul 2019 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199030;
        bh=3jtqXFsdy9+nN0Tz9J17po0Nvk+gwLyZ0NOhRPT6fiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfR32nCtKz8xD9WS4lRGJ7KWIV4gmH8X34QtasGm+iXgRy41+Qz4x2AlTLP52Nv9I
         nrDyMmxGFIpBq9oSPZ4VsMgGRBKb3jmKxP6aW51bXeUhwXoB6ThCKQj/QGDT3Dzqok
         upMLmaGOsJnvxMjnUiKNWretx3DnJk1dRPhufpWw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 169/249] block, bfq: fix rq_in_driver check in bfq_update_inject_limit
Date:   Mon, 15 Jul 2019 09:45:34 -0400
Message-Id: <20190715134655.4076-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit db599f9ed9bd31b018b6c48ad7c6b21d5b790ecf ]

One of the cases where the parameters for injection may be updated is
when there are no more in-flight I/O requests. The number of in-flight
requests is stored in the field bfqd->rq_in_driver of the descriptor
bfqd of the device. So, the controlled condition is
bfqd->rq_in_driver == 0.

Unfortunately, this is wrong because, the instruction that checks this
condition is in the code path that handles the completion of a
request, and, in particular, the instruction is executed before
bfqd->rq_in_driver is decremented in such a code path.

This commit fixes this issue by just replacing 0 with 1 in the
comparison.

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e5db3856b194..404e776aa36d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5398,8 +5398,14 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 * total service time, and there seem to be the right
 	 * conditions to do it, or we can lower the last base value
 	 * computed.
+	 *
+	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
+	 * request in flight, because this function is in the code
+	 * path that handles the completion of a request of bfqq, and,
+	 * in particular, this function is executed before
+	 * bfqd->rq_in_driver is decremented in such a code path.
 	 */
-	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 0) ||
+	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
 		bfqq->last_serv_time_ns = tot_time_ns;
 		/*
-- 
2.20.1

