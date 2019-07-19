Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E679C76188
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05F420873
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510914;
	bh=mxrsFRAx3PeEIwmrJvTX63q6ItA8/OWjca6l7bYHLhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7BLd92/IEHwi7j13fpojpUanaVu2KRRlp+zF1RdUP6NJRveeMdoKEYKkkCc+yz4G
	 cbflTVSght10I6EcbvwyiS5M5746G2IN9XZVJ+9lMrTsldia2Ne5HDh0Nf6wUC9shx
	 LJ9lairT2Fifu9om+sL1OTJJ60YAq/B79PneVKlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfGSEBf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfGSEBf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55035218A6;
        Fri, 19 Jul 2019 04:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508894;
        bh=mxrsFRAx3PeEIwmrJvTX63q6ItA8/OWjca6l7bYHLhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCVoVyKQrIqdnrW6i465CPDsK4ag8OzMXi0/YNnxnSQzIxGxplyUy69TEqZsx3AXR
         NpyRiRVqHQgX/1mq83IIk2tC0DPtWER3vukWOLKJ1DozTAnrOkcJ9SGq80ON5vix3+
         Hb8aSVQ2/7vt6cpUJlY+XIFPmfScjtChpw+grl8E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 142/171] block: init flush rq ref count to 1
Date:   Thu, 18 Jul 2019 23:56:13 -0400
Message-Id: <20190719035643.14300-142-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
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
index 8340f69670d8..5183fca0818a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -117,6 +117,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
+	refcount_set(&rq->ref, 1);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
-- 
2.20.1

