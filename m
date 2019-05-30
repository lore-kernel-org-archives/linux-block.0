Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB8C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C655257FB
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190973;
	bh=YbQkvgE0bIn5q8xDKH9ta8yAnvS0lPi4rnC4B/s7Su8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIiEbMOji3C9H+VTBHawkaZkxUZ1+EaLhYuK/++z62pqYXI0chRspVcwTY3OiMJk3
	 7qNUgXY/AsKP/AcEt/rsIt5QsPU/8aRweZuROMloj0NDAVLmKG/XPNFS7J4NbXJAtE
	 kUcNPzVHlo0BBSU0Wx95q3WZEqilnZrJnya4wwtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfE3EgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 00:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfE3DNC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 23:13:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFB1244EF;
        Thu, 30 May 2019 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185981;
        bh=YbQkvgE0bIn5q8xDKH9ta8yAnvS0lPi4rnC4B/s7Su8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwNGo48+kUd6B+0s4e4rfuy0jpR1vlTNfaQm0mpiASXIQf3E0UpqtC5xaajXvCNTW
         nLjpbknbdRqzT3Q65gNaCfv8imS5sxgEYHmm8FnR2gjcyLOgg1W+AIQxeU2Es2ozF7
         QuTK9VZBK+x4JVsBZ62heu/Ls2eaz5iGa9Le0Kfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 5.0 005/346] bio: fix improper use of smp_mb__before_atomic()
Date:   Wed, 29 May 2019 20:01:18 -0700
Message-Id: <20190530030540.714953042@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

commit f381c6a4bd0ae0fde2d6340f1b9bb0f58d915de6 upstream.

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic_set() primitive.

Replace the barrier with an smp_mb().

Fixes: dac56212e8127 ("bio: skip atomic inc/dec of ->bi_cnt for most use cases")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/bio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -211,7 +211,7 @@ static inline void bio_cnt_set(struct bi
 {
 	if (count != 1) {
 		bio->bi_flags |= (1 << BIO_REFFED);
-		smp_mb__before_atomic();
+		smp_mb();
 	}
 	atomic_set(&bio->__bi_cnt, count);
 }


