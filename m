Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E77C072B1
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D845726018
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192348;
	bh=A/qTvWQsG3Ff5F0BoRVW48/iXrDe5cHXZgzWL8eWG+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dgu4+oLzhJoYWJg2ezmyyQnE8/cs6nnHD0mOquSeTrKIsOxO1xel2JBVMv8aU2XXF
	 5RNCWYBIlgIRLN2OKCOeArJQHTXSqHTk5hl8v6HSrPhXj+8BRF48LiZioq4Tws84yv
	 dlHxX70YJAkPZ3HNg75aUm9VptiZI3c95kJWOJdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfE3DJo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfE3DJn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 23:09:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7A124485;
        Thu, 30 May 2019 03:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185783;
        bh=A/qTvWQsG3Ff5F0BoRVW48/iXrDe5cHXZgzWL8eWG+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se+li6CLtBf/Xj/RinfP6ii6EZ7gh1zmXivDlK0GGOpEWYippR1IcIoOgYil8WS8A
         2E7xBmlNQq8dJSZJSuCP5Gw8QJRY+sNTIqQrKUNpUnqRG6qOwZFVlb0u6/BCchwo8Q
         onHFNd3wymcuVvu9z8gtMA8tS9GX6DCDL8zU4CCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: [PATCH 5.1 007/405] sbitmap: fix improper use of smp_mb__before_atomic()
Date:   Wed, 29 May 2019 20:00:05 -0700
Message-Id: <20190530030540.754728543@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

commit a0934fd2b1208458e55fc4b48f55889809fce666 upstream.

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic_set() primitive.

Replace the barrier with an smp_mb().

Fixes: 6c0ca7ae292ad ("sbitmap: fix wakeup hang after sbq resize")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -435,7 +435,7 @@ static void sbitmap_queue_update_wake_ba
 		 * to ensure that the batch size is updated before the wait
 		 * counts.
 		 */
-		smp_mb__before_atomic();
+		smp_mb();
 		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}


