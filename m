Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFFC46470
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF98251EB
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189656;
	bh=nI/XTBVuAqM8axkiFf/VzEf3Bc+uambo+F/BfG6LJJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lba8nzuCtB4UhylQOrLylbu2eAKgJ0d95a21NRVyeKH95C1ToMMAJ+Rx0cVUjxi1+
	 AutQe9b/zqBsfFQxgG+9JQugduRwYbqHBJykaPnPLDBs/DnP7gjw5ixU71p4O5Avsp
	 UNOIHw7nDuVcaJATyROXncagsHChFZWs10ZUXaq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfE3EOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 00:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbfE3DQO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 23:16:14 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1EE22458C;
        Thu, 30 May 2019 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186173;
        bh=nI/XTBVuAqM8axkiFf/VzEf3Bc+uambo+F/BfG6LJJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DX6gHY10iCkuSwf0n2bw1Rf2XE48MVQOehV+NSaEgAJGS4Ns+bHYcr7pq7oW9v9Na
         GC2WMOq1fuN59VdQeYI0YoRBmmzTsLGzLLrWwc7x+lmoxUCSj9jpSJTMjLjg8uSTAm
         wIwUaCnmCufAbLciI+zdnun59RQ71zf7PhHieutw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: [PATCH 4.19 007/276] sbitmap: fix improper use of smp_mb__before_atomic()
Date:   Wed, 29 May 2019 20:02:45 -0700
Message-Id: <20190530030523.903699362@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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
@@ -356,7 +356,7 @@ static void sbitmap_queue_update_wake_ba
 		 * to ensure that the batch size is updated before the wait
 		 * counts.
 		 */
-		smp_mb__before_atomic();
+		smp_mb();
 		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}


