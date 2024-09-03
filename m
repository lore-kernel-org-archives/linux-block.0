Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B45205E13
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351434; cv=none; b=W4/6pqFUdoMMD13gvBDfE86PZ2kncpisCxInhL+KWKBQIPPM5NUFyHQYbINJpMpFX6G73ZY9ui6Nl/oHwHtxWsIeBSWZcKw21Scx7OCJsgGuccz4WSFwQFYoQXZAbU58IKLBjR0wVagsBiluklpN49e+GUpzPghHYH4sQu4OvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351434; c=relaxed/simple;
	bh=SDvrf8Qpiz7hwXgQkgMbvx6pHfwmjuJf1BI3qF5qsUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQiSR96Ae2JYq38sEwhzcNxd4lL54BvDR5zThXcsZfUMblpTrpPWs2blBq6HvCzVZdFfEJfymmYjzOkYwJDJJDfFfj/zOe0G0m5vl0Z+X2Z+u2qwn8gWoYCKWZYBawNFWz6c5ajU8Q2E2txUJBl00I4vx0ospTzUL1Sljs5MdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XN9Jxqps; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XN9Jxqps"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3579845a12.2
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351432; x=1725956232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=XN9Jxqps54SlOFrHvi6vO+cbKpfK3kPweI6WP6vaDsWZSIFMh+7VsAHJGJYxcMKf97
         2N/z8vP67KV5V6Q5CQn14BWkYGyVreexvTSgms5H52L96pvfEik9tdnq7Xpi58Rvvv8y
         tSAnBPGjEf7f3NGf30cEyvGrdf75SxS1V6d7pxDbx75SL5tEyUp7LYdxWzS9/eXBDcHo
         YLgosILWZaIPKiic/3n8VF1RIL8IiizgViTtkWKuid8WldJYFeCoE7r7z8nZxrkeiPF5
         Ct3QVu5mk52F6egzD1WJHFDYORDJ3G8ZFMH+UukSZmncN1//o6aVsmFdicgkWcGL94MG
         /yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351432; x=1725956232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=bGMUWXZSnhsdIri6cAJ4SWo23Gi1Dx380KucG1fM9wcuOWZp5rMHjMFksqeuoqU2IX
         chKai8v00sewYf0PyjWmTL70M+JTaRyPVc6eoIxvlwuCZYXRzZMzlTqMEsYOieYLkJER
         nx895rqIBRKtgOQe55Zi6x0rHRyct5eoeX7TgR1X7H1xlXGaeoGYGYzreS2c4R+n//Zy
         iREtxoAA8LnUBQR6eHBBvu1JljC6thq2CJIVq3b9jINuL2APrsDWpK6QPbzH6S/oSs3j
         IMepo8ExcSNZ+e8NrFkBiKxUdgAprF303T8ws7dfQtrTu87N4LXGZZYDESqHwpXnznXh
         Emvw==
X-Gm-Message-State: AOJu0YxNPxQMXiWYE8kvwKZVY3Fm1ZHRngI/BCnWSdMNww7yHVetCFt5
	qJN99cQkOCr2tyexOVPV1zHppE3s8hnrvPd3DiYpalDBkcHJ1t7I298jxz9ALR4=
X-Google-Smtp-Source: AGHT+IH8T062SK2gcp022LHlt/cN78AcsQ9Ou2pVs6Q14mJRrrNfE/3voyxn4xjoc1ocTKZsy05PnQ==
X-Received: by 2002:a17:903:26c5:b0:202:4666:f018 with SMTP id d9443c01a7336-20584193b42mr34059395ad.15.1725351432090;
        Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:11 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Tue,  3 Sep 2024 16:16:51 +0800
Message-Id: <20240903081653.65613-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240903081653.65613-1-songmuchun@bytedance.com>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                                    CPU1                                    CPU2

blk_mq_try_issue_directly()
    __blk_mq_issue_directly()
        q->mq_ops->queue_rq()
            virtio_queue_rq()
                blk_mq_stop_hw_queue()
                                        blk_mq_try_issue_directly()             virtblk_done()
                                            if (blk_mq_hctx_stopped())
    blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
    blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
                                                blk_mq_insert_request()
                                                return // Who is responsible for dispatching this IO request?

After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
of completion of request, so it will run the hardware queue and marks the queue
as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
hardware queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly() should handle
a similar situation. Fix it as well.

Fixes: d964f04a8fde8 ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b553..b2d0f22de0c7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2619,6 +2619,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2649,6 +2650,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return BLK_STS_OK;
 	}
 
-- 
2.20.1

