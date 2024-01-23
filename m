Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BA80047
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031629; cv=none; b=aNCPLHPZ6fZRUetPfb0em50XSEw6Mcx2dREIL7Fe8X615Pvx1w2tiVXBftK6UvkSR7e5qmBXb1SR0cHXb0ytdk3uJOTbPkHtVFKDME2PMEHFSj3QVMkHzlC8sXM9RsW28n44SeDH111qJ2WmQoYgPI9+7K28QPtHYXz1mQ0mby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031629; c=relaxed/simple;
	bh=YRdOC/K4Kw35Qsd/uJLzZT5xSXTClNa+8FtHHnmdBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK3D1kPWcJui0mmuBi5erG8X+LVybN6l8xomraFbQcXzhXdKXzNZ/IYhKImG74+FFh3BHXZKrbyatg1laU0+Lo7+2SNGoruRAv/JFPbGunSCpY39MDGA7SDLMR+UymMcC41okxf3dIgq04jK0r2K5xJiS1+Sg4hsZm9vVkyCpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SWsq30ly; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SWsq30ly"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bed82030faso59739539f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031626; x=1706636426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMRDiHz7VKi7s1ybtAQ77dKIgD14HxBezBGAiAO6Bmg=;
        b=SWsq30lyCkOFIFdeBm+jzihZEhkJUaYTtxed1Y5g6m+woiTQz2/HpYE/3aqn83QMzl
         d1AP5KnbNHkKvp71CkAyNDNET8gUdSj1T7W3hPtIrhVF1SgHMr5m3R5DVA53K3prF4+K
         5l2Fx0qw/xZbJRaFFw2VJRjqL0DiJ9KHPhsPluAx+MzhPkz8qHIBKU5MawBTItWmVeiw
         SUSaCAdFgVUNmRWfbgqcM6pN5SKz0rF/rTfzRg3MkwLKO3IemfS2YqClgaktHMu2kD8E
         0U+B5wm6F/5RgzQtnU5eHmQaIby7Z1j7AW7iPXklKKsWjnUCV0dRpbgrKBrBWmL1Dpig
         spxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031626; x=1706636426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMRDiHz7VKi7s1ybtAQ77dKIgD14HxBezBGAiAO6Bmg=;
        b=JVT00Myi+4fZD9wfQX0hJgVd8Nc1AlU0WRTNjoEMFyOgdXBzKH1UWm2c8ej05gYgei
         qjbvw6VaNtSnZSLzZMs/k4QNPbceuW7wvAQFHjt7JMozGuMBi9D9b1ZgYRoV4q9VMFHf
         55hkTXgSE823Yfx5gvc69T1pwIeJwiyXH7WDmALgQtegCvAUM9tAZFfY4U5RnFsA2+ZD
         1WnHdBQxUvm3I+X3FkOOfaM8lCn285e7G7vyJo5jcdIe02Al7Hcu2DQQgvsEJHsUNpcy
         fit64jGDPuQF88ecXGo1jRUrG4ehgr3pgpzupW0ECMn2YBrQ4rjNqquneNFeYk42ZIc7
         FTjg==
X-Gm-Message-State: AOJu0YyMsARQXesodJUtgrA0JfnxBaivfk2YLe8mOfnOBq9kdSbcaHj5
	bwsXqRnut0E20W170xFLX7ugn89ZeiKUy1NjvDMQAKNIF/kLF0yEGpspVxrqW0EohtbF3B/Gbaz
	LVX0=
X-Google-Smtp-Source: AGHT+IHyhdGzb5/8J+LIUTuQGHx614+1BWdAD+PE9rIUyz9ezbew8pbKZfK6ahAukBNmkALOmS94oQ==
X-Received: by 2002:a5d:8942:0:b0:7bf:3651:4c6d with SMTP id b2-20020a5d8942000000b007bf36514c6dmr10357780iot.2.1706031626089;
        Tue, 23 Jan 2024 09:40:26 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/8] block/mq-deadline: pass in queue directly to dd_insert_request()
Date: Tue, 23 Jan 2024 10:34:13 -0700
Message-ID: <20240123174021.1967461-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware queue isn't relevant, deadline only operates on the queue
itself. Pass in the queue directly rather than the hardware queue, as
that more clearly explains what is being operated on.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..9b7563e9d638 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -792,10 +792,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 /*
  * add rq to rbtree and fifo
  */
-static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void dd_insert_request(struct request_queue *q, struct request *rq,
 			      blk_insert_t flags, struct list_head *free)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 	u16 ioprio = req_get_ioprio(rq);
@@ -875,7 +874,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
+		dd_insert_request(q, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
 
-- 
2.43.0

