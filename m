Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274A146D57
	for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299057; cv=none; b=K8J0g9xm9vilVcG7jL7f++uWQH91/XgFwxZzSgF48NNGTC6D76g+It7bvCzAoRN8f2qkaaP8YupyYRV91msw1+f5/Nx5C1DCCEydbCqV01klTOHJv2FzY0ocZV9iaK2UV3BN33X/r5m6BtndgedbxaMcINdC6w3R1BYrik5dNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299057; c=relaxed/simple;
	bh=NfYRJbO+n9KlpHo78YK1kJWVU0JEHSyMKcCC/4kPv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZULghLnmd58vFW5UMSrEsmZqKEU5rlRom8YflXEtoPh/yLIy2bTQf66AHBM2Tvow9TTn6Tg6jn0kN1Aaji3RJMHLCS8k3x/WBPe2GbShou/e0XAc0rTSHNiGFN9FV+5Z17ajklO6GQRy8yZrqoHMmvmWNUs8vzX+KTaJlFEfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PB4Qvvdw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PB4Qvvdw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e1ce7e84so2130289b3a.1
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726299055; x=1726903855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=PB4Qvvdwm51+gOBZprDFm8tkkOYMvdxGtcu/a3L47vXsT/g3hHUPcJEYLh+ZmSEWWJ
         XTqy1V/u4qeNrXYw3q6/HOxsOROKvgnNhAPV8pCPcjVRnQ7PEYmW18RnfDSKt8uYRcjr
         Iv0l+yRu9jLmkSRGFAClJHMShW/H6ncFlO8+NgDFbAas+6HyWk12oYDdVkaPiHX4dFNk
         bA/gtBFo0HkLbvLl208uiYIM/wpnSYoC9CghPGAsZkWz5BmylCEo8Wh4wtJohOT1TJvy
         VOGzSSkYfZOId6C3JaF5spIk10XNg+FhiXKAMH1fhJoyDT2kdh3jDvKFzVkG+MltYMeC
         r4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726299055; x=1726903855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=NfBpCQ/Rksqhb4drYUhI6mpc188x2npbWNe/tld8nqXu9lsfiP/P4ZZRbKFNwdGxjj
         ip089U8ATIZi86IMmg+7TX/slOwREgnYpU8+hBpqf+nieedBOXHvxW4BV072DXtBCuNO
         FEGlzbCrBiYZNvm/26Z1e7hdJzDXRdvqm1J8NkFrSoniHbXXBJQNHeOpLrqZfE3AB5n0
         o/eNCp879DH8f1pLabMKNkuHCzW91deWMcj2V1pPwFyo3R0C6TBvPhhSMbf92Z34dMME
         WIuyd08WdsA6HEK/0G5ySSoFBH+aWvcPEbPksZoi4XMahKWX4PkSwJFnMXB/SCBr9NzE
         eYRw==
X-Gm-Message-State: AOJu0YwDsA/oOAp2Cj6SrZAOwrqemmdrI5d+11HVCUlF7f+c+0gCTq1i
	BxJzHxm3Bq7gPIqriw7R5kS7Po19GRoJCuq29b9kIkjm0zHTRb4hrXDG1RDNvsg=
X-Google-Smtp-Source: AGHT+IHDTQbRO6cV5Mbr0x+fq++p+seJtKKFdtV1cqhsFN5NWwbtCCv5rOqEpU4gF1AdgNhIZhWkdQ==
X-Received: by 2002:a05:6a00:993:b0:714:157a:bfc7 with SMTP id d2e1a72fcca58-71926084bb4mr13041594b3a.15.1726299055036;
        Sat, 14 Sep 2024 00:30:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ac05sm555687b3a.155.2024.09.14.00.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 00:30:54 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Sat, 14 Sep 2024 15:28:42 +0800
Message-Id: <20240914072844.18150-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240914072844.18150-1-songmuchun@bytedance.com>
References: <20240914072844.18150-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                    CPU1                    CPU2

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                                                virtblk_done()
                        blk_mq_try_issue_directly()
                          if (blk_mq_hctx_stopped())
  blk_mq_request_bypass_insert()                  blk_mq_run_hw_queue()
  blk_mq_run_hw_queue()     blk_mq_run_hw_queue()
                            blk_mq_insert_request()
                            return

After CPU0 has marked the queue as stopped, CPU1 will see the queue is
stopped. But before CPU1 puts the request on the dispatch list, CPU2
receives the interrupt of completion of request, so it will run the
hardware queue and marks the queue as non-stopped. Meanwhile, CPU1 also
runs the same hardware queue. After both CPU1 and CPU2 complete
blk_mq_run_hw_queue(), CPU1 just puts the request to the same hardware
queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly()
should handle a similar situation. Fix it as well.

Fixes: d964f04a8fde ("blk-mq: fix direct issue")
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

