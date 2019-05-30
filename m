Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034AEC28CC2
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D173326049
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192349;
	bh=5HFNcEidiS625lqjNdCy7zgxF5XscqP3STPmvUdBR2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+lNZDV62eNRTljq8+N27CsyM340Ci9m5az7prIone0V3RgdhOx+8vOiCA8Uo4bD9
	 wHlAfiz1QjroD+uCr+pjU6E6zyVlRjSRbGsa94QEJlq1w/8fH98PUNEvBoccEzOKnP
	 xO58ufyQpQ7rNoNF+9/Ajf45Ngxe2y2Ub1by69FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfE3DJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfE3DJn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 23:09:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908D82447A;
        Thu, 30 May 2019 03:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185782;
        bh=5HFNcEidiS625lqjNdCy7zgxF5XscqP3STPmvUdBR2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BghmTt6JjHA1mVdalHzbGxD9GLa+1QuKPsLV9qGnIxBz1BqNQ94irMWhmfeaDKKK1
         X1zEQx5WXmjA9+LFSpVgZmeCLYrKhYouoJQM+rScFP9aeC5ZosN4QK1CUC8fCzdONQ
         TI7AIz5RBKVK1wFWHim+nwld3RFqptBIn5XCps2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 5.1 006/405] bio: fix improper use of smp_mb__before_atomic()
Date:   Wed, 29 May 2019 20:00:04 -0700
Message-Id: <20190530030540.693129039@linuxfoundation.org>
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
@@ -224,7 +224,7 @@ static inline void bio_cnt_set(struct bi
 {
 	if (count != 1) {
 		bio->bi_flags |= (1 << BIO_REFFED);
-		smp_mb__before_atomic();
+		smp_mb();
 	}
 	atomic_set(&bio->__bi_cnt, count);
 }


