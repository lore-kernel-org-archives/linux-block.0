Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE98C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1FE214E0
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=venev.name header.i=@venev.name header.b="Gfi2wlIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392983AbfIFTN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:13:27 -0400
Received: from mtel-bg02.venev.name ([77.70.28.44]:46702 "EHLO
        mtel-bg02.venev.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392981AbfIFTN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 15:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g0KfkkbCzMbLqnICvZM8Jb4Ika4rajIxYnFPe8531kA=; b=Gfi2wlIr1MIPoKdWYEcyPliXdW
        fioVdDt45+zEPiaZSfE9XrjvMFS6fBhuOt/fPBSrnk7hOnUIhnyAAypSg8BaR7AwsnnxPHUaJYkXO
        rngB085boGCg3BkyXV9hXnCMHsfeWJS0fAcKSDS4d1/26sa+v6B/w9zXKYNX1ze+HmzmmAsh40t92
        ORVZTVzVZgAUIxkAWg+aFJRQtGGWmLiPWN4wyp6qWLhIzexIXRhL2DTkZ/JL99cP8B/bt0928cpvJ
        CFZwhd2ND01Z9BfjYzyUktHY+yOqlNv9332b44Bf4l4fUcRUca8iGVMREhqT3V9WmlNqwv8XDVZkI
        qFkNO8euIBQwT8ECAOSks5b1eniciN60zbVY1VLtmX0/8sRI0Heoj30jUSewy7EcgP5znyDpX31aa
        IObfM08MVLOSrWrCeLTIOxmJi9yWr6SKPo4iMK/gqNiNRy3w0CrjHz6yqrbMv/O74Ctx7It4RGlL+
        c/3HKwYV2jJfeAGGF1iXDrn+UpqVg1G3pE4RRR2X2TZeC76li2vjNDmYs1065KB0fAQBONViRcRtz
        wXRmsgEezGIsc3H9cZ77yaXFEprkroQHWA5KZ03wtSQURSZXDggjc5zV0Km7FYFLr7RvePJeej+XE
        mkO50Ow+IJHhdlTheUL8UJi6Qf0rMdiRVpodB7UAM=;
X-Check-Malware: ok
Received: from mtel-bg02.venev.name
        by mtel-bg02.venev.name with esmtpsa
        (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>)
        id 1i6Jfd-00063G-Nm; Fri, 06 Sep 2019 19:13:21 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hristo Venev <hristo@venev.name>
Subject: [PATCH 2/2] liburing: Use the single mmap feature
Date:   Fri,  6 Sep 2019 20:12:52 +0100
Message-Id: <20190906191252.30332-2-hristo@venev.name>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906191252.30332-1-hristo@venev.name>
References: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
 <20190906191252.30332-1-hristo@venev.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 src/setup.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/setup.c b/src/setup.c
index 47b0deb..48c96a0 100644
--- a/src/setup.c
+++ b/src/setup.c
@@ -16,10 +16,30 @@ static int io_uring_mmap(int fd, struct io_uring_params *p,
 	int ret;
 
 	sq->ring_sz = p->sq_off.array + p->sq_entries * sizeof(unsigned);
+	cq->ring_sz = p->cq_off.cqes + p->cq_entries * sizeof(struct io_uring_cqe);
+
+	if (p->features & IORING_FEAT_SINGLE_MMAP) {
+		if (cq->ring_sz > sq->ring_sz) {
+			sq->ring_sz = cq->ring_sz;
+		}
+		cq->ring_sz = sq->ring_sz;
+	}
 	sq->ring_ptr = mmap(0, sq->ring_sz, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_SQ_RING);
 	if (sq->ring_ptr == MAP_FAILED)
 		return -errno;
+
+	if (p->features & IORING_FEAT_SINGLE_MMAP) {
+		cq->ring_ptr = sq->ring_ptr;
+	} else {
+		cq->ring_ptr = mmap(0, cq->ring_sz, PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
+		if (cq->ring_ptr == MAP_FAILED) {
+			ret = -errno;
+			goto err;
+		}
+	}
+
 	sq->khead = sq->ring_ptr + p->sq_off.head;
 	sq->ktail = sq->ring_ptr + p->sq_off.tail;
 	sq->kring_mask = sq->ring_ptr + p->sq_off.ring_mask;
@@ -34,19 +54,14 @@ static int io_uring_mmap(int fd, struct io_uring_params *p,
 				IORING_OFF_SQES);
 	if (sq->sqes == MAP_FAILED) {
 		ret = -errno;
+		if (cq->ring_ptr != sq->ring_ptr) {
+			munmap(cq->ring_ptr, cq->ring_sz);
+		}
 err:
 		munmap(sq->ring_ptr, sq->ring_sz);
 		return ret;
 	}
 
-	cq->ring_sz = p->cq_off.cqes + p->cq_entries * sizeof(struct io_uring_cqe);
-	cq->ring_ptr = mmap(0, cq->ring_sz, PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
-	if (cq->ring_ptr == MAP_FAILED) {
-		ret = -errno;
-		munmap(sq->sqes, *sq->kring_entries * sizeof(struct io_uring_sqe));
-		goto err;
-	}
 	cq->khead = cq->ring_ptr + p->cq_off.head;
 	cq->ktail = cq->ring_ptr + p->cq_off.tail;
 	cq->kring_mask = cq->ring_ptr + p->cq_off.ring_mask;
@@ -105,6 +120,8 @@ void io_uring_queue_exit(struct io_uring *ring)
 
 	munmap(sq->sqes, *sq->kring_entries * sizeof(struct io_uring_sqe));
 	munmap(sq->ring_ptr, sq->ring_sz);
-	munmap(cq->ring_ptr, cq->ring_sz);
+	if (cq->ring_ptr != sq->ring_ptr) {
+		munmap(cq->ring_ptr, cq->ring_sz);
+	}
 	close(ring->ring_fd);
 }
-- 
2.21.0

