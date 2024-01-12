Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091857317A
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hCReqnP+"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-360412acf3fso2950965ab.0
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705076116; x=1705680916; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMfsGIjmGbpGyu09DdYvcRhuqBxJ3Uac2JE4FVYGgfU=;
        b=hCReqnP+HMNtztq6HmHEzJsUoPJDcN8T8/Ti7MmjYHSn67M8cyfDuBp3ETVrLb6jqN
         EBxQmEaxNAp4SVtvg/cnHuErVrkXPPq2d0XacYEkGsURyJU0A4RSSNIjOedf1UHg8zt8
         5ytjP7gH6M2Lp0/U8JmS9kQgbyf7Krj2JOEBETwoe1WnLZu0JNq+mdbz6wqSXws7btyL
         ZgPUfqBYmnyWpX87Ym++jGTqMRBHF3dM+L1hvOYkxk0C3+LXN+0nHch6vpza9cbuojOX
         CrtJhnvNVFpDANteq9pdT1abBPAqYIJ+ZB7uqWYkCe+wUtmwbqR4tBysKgS7r/gw5AvD
         XqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076116; x=1705680916;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMfsGIjmGbpGyu09DdYvcRhuqBxJ3Uac2JE4FVYGgfU=;
        b=ZxM274UPTeyQ8RYOnU1G4Q5xNSLdjOeZqxSxjr0oZ8Fz197O/AKwvo8w2UYIMnEBSU
         YjQ+zygc3uGhfTBzHZd9wX9b7gCbRkCzU8knHRPKDu3Q4Sm4uBaT892YKY5m/YQFVZye
         2I/8wF9E24IcUb7NiTkxFjhAmLgleS3waf7CqTEpVxBaU0ezPR/GZ42t7j0UCeOebFN6
         wJvUslBdHnB8Gdj7L0KVNDkPdC45SS1iVVpOhVp0Pw7suIB65zBLSeQ7mrPg5aku0h1Z
         5QXteLhIHGdXVpYzsii6/QsnfrrmgrH8q13pImzHgSE8w9vf6cD8a7fkQVWEwwqB/xzr
         16NA==
X-Gm-Message-State: AOJu0Yw1ZQVxtO6c3VzRU+1NkY5SifaXpiQVeq6MgrqlJ7IBjW0avTLJ
	HyNm8H14oBdEVGmgZkuqky8IaYa2lG3Tu/chYWU+XOlmpCAHtQ==
X-Google-Smtp-Source: AGHT+IEoK0dVwgBaFVanmjof3ndJnHBZ62ikl0Ij2Y8rGsYlgHZYrrZBYWB5jDsFlJIUg+aWkfh0zw==
X-Received: by 2002:a6b:7e01:0:b0:7be:e328:5e3a with SMTP id i1-20020a6b7e01000000b007bee3285e3amr2072229iom.0.1705076116635;
        Fri, 12 Jan 2024 08:15:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r4-20020a6b4404000000b007bc3ebacf3esm845833ioa.46.2024.01.12.08.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:15:16 -0800 (PST)
Message-ID: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
Date: Fri, 12 Jan 2024 09:15:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: ensure we hold a queue reference when using queue
 limits
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

q_usage_counter is the only thing preventing us from the limits changing
under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold
it while calling into it.

Move the splitting inside the region where we know we've got a queue
reference. Ideally this could still remain a shared section of code, but
let's keep the fix simple and defer any refactoring here to later.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f57b86d6de6a..e02c4b1af8c5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2964,12 +2964,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	if (bio_may_exceed_limits(bio, &q->limits)) {
-		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-		if (!bio)
-			return;
-	}
-
 	bio_set_ioprio(bio);
 
 	if (plug) {
@@ -2978,6 +2972,11 @@ void blk_mq_submit_bio(struct bio *bio)
 			rq = NULL;
 	}
 	if (rq) {
+		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
+			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+			if (!bio)
+				return;
+		}
 		if (!bio_integrity_prep(bio))
 			return;
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
@@ -2988,6 +2987,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	} else {
 		if (unlikely(bio_queue_enter(bio)))
 			return;
+		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
+			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+			if (!bio)
+				goto fail;
+		}
 		if (!bio_integrity_prep(bio))
 			goto fail;
 	}

-- 
Jens Axboe

