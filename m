Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294AFC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B33A2173E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGAVmm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:42:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41277 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAVmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:42:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so7176473pff.8
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 14:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMIB+NJ9pk5Mr/BbVFnvI+yoF7k9qUYHjOCtdJ2IJpI=;
        b=l3CZaK0pGRnXWFc8XxmUAKmIkBN52yY0f5o56rCNTdyYQO3RZd/DUrHnMTzY3lN0J2
         OA+y3VeRngO5EAxQJWksKgKcISpnys7EyW84DprFhxx2dnCTHVeSPsBSznKZCR3yuj1J
         ILCH9tks7xL+bJRlaxZ8yPfF1otfX7obZ2/WFyc7lUUVCuSlAOSVCQf9CLF99uePxq1q
         +tGKXuYS3Ez6/z2dko2hwoWoaLN8rp1f0xOaVNbQWqp5XxtFi+FBAoEaM4nBeEsYtqL/
         I660WFDaxhx4y5VMlghFTcEA1T4pZDS2dvajrz9khpC72vatPfiuhYJzSGhv9nj81A3H
         6EXA==
X-Gm-Message-State: APjAAAU/kdyt9rw71XQGx5h7xImnj7iR4dPKmYar4klPZTQTnzARRN1s
        /eOXb/Us+0dZoPGv1OVcnCQ=
X-Google-Smtp-Source: APXvYqx+bYBeyktv1qxlchYk3UE9z3gF2k6QVEkvqXMXim8t/1hwlmR1paFZIvPUYu2Q8XkWEQioPw==
X-Received: by 2002:a17:90a:26ef:: with SMTP id m102mr1552532pje.50.1562017361582;
        Mon, 01 Jul 2019 14:42:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c83sm15892282pfb.111.2019.07.01.14.42.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:42:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH liburing 1/2] __io_uring_get_cqe(): Use io_uring_for_each_cqe()
Date:   Mon,  1 Jul 2019 14:42:31 -0700
Message-Id: <20190701214232.29338-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701214232.29338-1-bvanassche@acm.org>
References: <20190701214232.29338-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use io_uring_for_each_cqe() inside __io_uring_get_cqe() such that it
becomes possible to test the io_uring_for_each_cqe() implementation
from inside the liburing project.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Roman Penyaev <rpenyaev@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/queue.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/src/queue.c b/src/queue.c
index 85e0c1e0d10f..bec363fc0ebf 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -14,26 +14,14 @@
 static int __io_uring_get_cqe(struct io_uring *ring,
 			      struct io_uring_cqe **cqe_ptr, int wait)
 {
-	struct io_uring_cq *cq = &ring->cq;
-	const unsigned mask = *cq->kring_mask;
 	unsigned head;
 	int ret;
 
-	*cqe_ptr = NULL;
-	head = *cq->khead;
 	do {
-		/*
-		 * It's necessary to use a read_barrier() before reading
-		 * the CQ tail, since the kernel updates it locklessly. The
-		 * kernel has the matching store barrier for the update. The
-		 * kernel also ensures that previous stores to CQEs are ordered
-		 * with the tail update.
-		 */
-		read_barrier();
-		if (head != *cq->ktail) {
-			*cqe_ptr = &cq->cqes[head & mask];
+		io_uring_for_each_cqe(ring, head, *cqe_ptr)
+			break;
+		if (*cqe_ptr)
 			break;
-		}
 		if (!wait)
 			break;
 		ret = io_uring_enter(ring->ring_fd, 0, 1,
-- 
2.22.0.410.gd8fdbe21b5-goog

