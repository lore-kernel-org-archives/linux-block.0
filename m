Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41100C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765A20659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="c01+0JKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfGPUTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42442 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so15650176qkm.9
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bTSNcfyeNuJX18rXrTxBmXYwd6To1Z5x97hHlskS8FA=;
        b=c01+0JKPZsveVFXSuvUZNzxEVDTTpKypRmqi6thGNAe0l4M3PZEL6o/0LyGgoEGgDN
         T6oVXpY1K9F5Yz0LAU9Epm0tDZgM5LxfKn+fBB0Rr6JokfVL4P2q0OiCQvHd4yp7pUbt
         UWjO+hS5lCKKD+X3BNnbQeSXrnKL12ltWbL7RIOSCuv6o7NdV6YXjnTyv+At1JZUeIa6
         Xs9mx4WKqsRUWSbqh0nkEKrjjIbDbQxuvY58cZH1aUixYVMKjVeXIR6AKbHvGHL3M7no
         +vc9nceng2OruCu9pllIvEIOdosXvW7kCpLVTdKHjN58b6T2RFV1cqfl1Gnr1BW6CDLe
         tipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bTSNcfyeNuJX18rXrTxBmXYwd6To1Z5x97hHlskS8FA=;
        b=Ztmuw55t2aTflS5XOh5So0W3dweOmYeK4zCk0oB/lSWfzpbvCbIrBcF2Ceyqu5Gaua
         m2wCJSlQ3lWp4OZIB0WuPu+eB4nine9XMNHxcr+p8b0H7XeymGhQt0Eqzj/CEH40fYKk
         mzX2Jo+Q28abjxaPN2X/dGMz33/f7DhvV3DycNC6hIEZ+QS8+MzxC/Agv4s916S/MUV0
         6+MQZLJNmhzYXwlixg7TqKgktJL84GRfY3hBxC/Q5+wUffpn38gz+qaFMgE4NxivWpsC
         JIsPs/0YGzULKpcG+oza0R/30cF8jMkGOUYr/1D2+vOIiGa0BHFMtWRcXzcSWs5AaqzB
         OqjA==
X-Gm-Message-State: APjAAAWRFK21xfr73M9iOduAtW9X1IZq63HYO4tRQ5LL5EjZ0VUa8StV
        hgxi9FLP8zlUZkXRGuOjnDI=
X-Google-Smtp-Source: APXvYqzeRRDzZEKx2VIjYdjatndvqEEZjHV7SSgPYpff27eEQHUmXd74Sj0M3yhnCN2TUo6erAEh+A==
X-Received: by 2002:a37:de18:: with SMTP id h24mr23039925qkj.147.1563308379253;
        Tue, 16 Jul 2019 13:19:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id z50sm11688579qtz.36.2019.07.16.13.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 3/5] rq-qos: don't reset has_sleepers on spurious wakeups
Date:   Tue, 16 Jul 2019 16:19:27 -0400
Message-Id: <20190716201929.79142-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we raced with somebody else getting an inflight counter we could fail
to get an inflight counter with no sleepers on the list, and thus need
to go to sleep.  In this case has_sleepers should be true because we are
now relying on the waker to get our inflight counter for us.  And in the
case of spurious wakeups we'd still want this to be the case.  So set
has_sleepers to true if we went to sleep to make sure we're woken up the
proper way.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 67a0a4c07060..69a0f0b77795 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -261,7 +261,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			break;
 		}
 		io_schedule();
-		has_sleeper = false;
+		has_sleeper = true;
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
-- 
2.17.1

