Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205982;
	b=FoqPqTa+TopZYCBCs4bB74IRhONrRiFhqsFxVebqGOaE7DfBfxiAL2luKgM8RoRnENMz
	 nBL6wJBBlBEosHr6YHcrkPNoyPpl0tEGU6f0JL/wOY9Kzk4i/VvKJKbBcFHzGQQv5FJmt
	 cpVPkqU6gQ3Ed/4Ocu5SBtEi+H/Y9j1bWUcnSfl7fj+QoAE0EoSvA5O87fgXiwhBIXnFO
	 /Sx/JQrWXho9D1/GuTpJEKqnj7ZubI4r7prCWRS2dFmcVDpklU/tbvBUVCWq9pel9QOYw
	 9Y9WUo4z09YxPDlpeHGUz2oxj8BOj+9DVYoWQ4E7sfHH2MC6dNPAflfGgorj5K89gOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z94OlTxWFV89lMHcDuzDnL7mKsEKz7PFTVKN55w/xqk=;
	b=jvyvx0BlEbRZ7osimVl7MI8UTYQ0B/CuKSWZ2Ch82VEtO2ZfB5g+RxS1o6oHGtQXv8a+
	 y8teqg8YrnEhJjU4iDtmbLYU9CNb6SXpO437/Sn4Id8oB3jgOL2yUvPOOcaNd7B7gsm9V
	 zxHYSQo9gRcO5w2S5yOlEgW82vXr88C5D2r+Xy3Fqaae6jEUXj0qcuxyizovJ82jROVg9
	 ifcowv8jn2Md7Mp0adDl592AC630quglNiBRXM6FnmaoqLs+LSDRTQfCYDafdQ0xbwoGy
	 pjFdmjRmfBaCNG/yLpGmz0KOCMn7XeH0d+W+azxxgb/LhH7Y5U9AcuFIM9tGig/C30A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X2Sj1ESb;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8260A2635
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C8260A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X2Sj1ESb
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-844a8bf7e25so799493a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205981; x=1793810781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z94OlTxWFV89lMHcDuzDnL7mKsEKz7PFTVKN55w/xqk=;
        b=X2Sj1ESbLhFs1KsO+HU7cytqCQImDJIJBo/B7iuU2VLB8YM5URxKJrXg0FdI+p3lW8
         WL3qgbqO79Xa4lUbSqrCoXWXcX6VwwIYjwyDmJcx502K0d/18AuOFd0AnWQ21J/aDWza
         R6govYrxbxODjD3uWiGFgYlAqjwJ9Ac0HdqSk8KW2b5cE++eHWrLJ1z3vU+SpjCtB0yn
         ZnJXaQerqJJHAUh2pEqzEd/2VXCYSnUo/HkLJyU/5PYelzngyifzepGMx1D5KwVkX0GJ
         xabrZLU1GhzWvnv+lNwizmz427XiQgFKzhSG3xeuJ6hnevpSvd+KOfEAiGfD2XoXnG4n
         OSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205981; x=1793810781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z94OlTxWFV89lMHcDuzDnL7mKsEKz7PFTVKN55w/xqk=;
        b=CO4ZMVRHkUI035m4/5mZHcoGnOi3bKwM+/fwNtox6MVtN+YfSh6KknQeBVwo6ozlcD
         hHTvReuR0BRTpus6vrcADDBniI0hdZlsmZgV580Y5G75Y0cP0R977O6aGmcMAob4LJoO
         VhZVGYmKx4qswPygjQko+UAPbzhQR/gYHGGP5E6lhEodvsj3k02n3thD5OX0Pgm/iNX1
         rJ1ei17wDPmldgqrbMWdEyJvRLtFdGnAlv2qwnqK9SMbQPOE9rvFblzYSkgHhI1+Zn9E
         sepW8g9haeWTwh6UeLGp2+Vwil+KOgnGiQcjDzTwRJDDjebT7e6K6pNjmUrBilY1jouE
         MYyA==
X-Gm-Message-State: AFq9FYKSWC26PxCHXrEtaanSa7d/hcDfleTBsTXesYlUuteX9NUbRqaL
	0HE+BVXzqqfppyn7HsU8cR7k1ehFxhq+WocUn4S0P5s+OSKbz6kdNpX/9GzZn05ZxzFMOULFzib
	5gkEg7Co=
X-Gm-Gg: AYBFou1GEl/2zEvWMzcTE5zvlJ/1WEk+umQFupYL15hjVjkR1TTuMxDRtAfdm5Ikt5n
	P84+aYgpvrNnBLbHm3rJo7ILLwFEJKV+nw9h9aLR05vT/iX9+xEuQQc2OZOQ+OSDfsl7zIGt50H
	A1wpiMV0QrUI21BFnBROprR9tKTYQ7Z7QipQfz8Pw44tkREo5gb+wkzqTj0WqQPBIXLmaHsWt8Q
	e71HcSVisY77bXX4DVmb9kLj0hYVtKczkVV43eypCrwx1y1qOUFqgp4ksI1RLDBHUA7xQKzEmsh
	GLj6Tia9IFx6pKio61F+WUUk2RdAK/vL9fjomk3OdB6kzV28Mi4EeBt442jcLBgXyvMNXGlHTk6
	x5zzJvgO3mme2LYwC2ugYjFZjn8bKnUv8iZ7xIq9DSewkcQVhqRk8cILcNhvIeUBdPwl0PdX3+H
	eVljx74IRMPMv/knsCNZ/V6BhkRqO0x6jUHLcmR+Ymkv8pu4Eoye2zt2HeB61OaAhlNvAGSF9aN
	szOJM60oe32DFCyzBQguQoaXvS4eKIv6FicE/8YCHAaa4TssjO4bMIEcHjrJMjWp+2VVDfn3vxl
	JZN+hC0lhpRqqxgeYdCKqR7/WrWsM1UJ9DbhCJQpugzc5UeKR7WOe+4PmvGAFLqrRrHwxn1c/A=
	=
X-Received: by 2002:a05:6830:680c:b0:821:8e71:1bb5 with SMTP id 46e09a7af769-85abcc4070cmr2723348a34.14.1793205980724;
        Wed, 28 Oct 2026 09:46:20 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 95/98] nvmet-rdma: fix double puts after a failed RDMA WRITE
Date: Wed, 28 Oct 2026 10:42:38 -0600
Message-ID: <20261028164415.1262013-96-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

For a read with T10-PI the RDMA WRITE is posted alone and
nvmet_rdma_write_data_done() posts the SEND once the metadata check
result is known. By then the request has been completed and its
references put: __nvmet_req_complete() put ns->ref and the pc_ref, and
nvmet_req_complete() sq->ref, right after queuing the response. The
error branch of nvmet_rdma_write_data_done() copies the one from
nvmet_rdma_read_data_done() and calls nvmet_req_uninit(), which puts
all three again. A WRITE fails whenever the connection ends with reads
in flight, which is up to the host. Depending on timing the sq->ref
count goes to zero early and the queue is freed under the remaining
completions, or never reaches zero and nvmet_sq_destroy() sleeps
forever, or percpu_ref_put() dereferences NULL after percpu_ref_exit().
ns->ref stays too low for good, so disabling the namespace hangs too.
Reproduced with KASAN over rxe with a test patch forcing the PI path.

Drop the nvmet_req_uninit(). The branch still releases the RDMA context
and the response, which is all the request owns at that point.

Fixes: b09160c3996c ("nvmet-rdma: add metadata/T10-PI support")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7cbf1caf3208..994a668f45d6 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -839,7 +839,10 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		nvmet_rdma_rw_ctx_destroy(rsp);
-		nvmet_req_uninit(&rsp->req);
+		/*
+		 * Unlike in nvmet_rdma_read_data_done(), the request has been
+		 * completed and its references are put: no nvmet_req_uninit().
+		 */
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
 			pr_info("RDMA WRITE for CQE failed with status %s (%d).\n",
-- 
2.56.0

