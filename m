Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E31C84DC
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512619; cv=none; b=P8ytJNSfjtw9ogSOX1VyDS+EYiVL5xBgeBx7vjQyD8R2k0g+GcS7aqoD+oZJdM0b9aGAXDTYY8zzsCqySwboVKTIuAc2BwoYBKJrOXzkNg0ZpRHzcf0IgcMYRlaGAPOBukEpMkLPvcTl9o2snC+kD4W9BjDGCdunx/emCqwYet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512619; c=relaxed/simple;
	bh=xlQl2MVL20F2cU3JmYsv2STKwVjbDQRdEKAWTXrgR0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyGj+hvCvV5MzeZpuPJ/UiHim0+SQc1dZ6rNZ2hcxOcbISVtEAVDiHs70OqzPVmnUS81ApBLvpM02q7s6NRQYdcdUlX8vlD6BZg1U3mfujLz/mkCPcYcRPEYfJ8XHLASP/vt1fWYP5pWka/jjo6DDpU/O/BFesFHn6fPe+3eZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW62ZGyJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW62ZGyJ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so3466496a12.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763512617; x=1764117417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yH0cZL/s9sZEN1l4izxVJKR+dHvLhkS3+a3jIonNo8=;
        b=ZW62ZGyJsWd530sT3fi0d4BBIJgb/hniJJbdOD3Mz4VC1eqmr/ZrS/H0Q82ELJbA8r
         h7LBU45YL3xzbUjVLrFKcEULfY4jOswFUgZQVA+yXbtC4B6yqxIKJHhD8sk/AgX4YYcX
         SQNzOLrem05rwibFpECeiDlmOqm2gJWPaZ7SYaRdPFwfeg20ECl9uc34mP0U4sfy41Sd
         JPq4FlUSRZHgR0dgeunIqVnuhQawA9EgNZbw810f/xDguHh0vtV3Tnf7g0ESI+rqgVP6
         xWCPJpJmGVwLdACLoflCHC/grkrFbqDcnoDGxfuwULMSOQSMUYStwKKZXfVjVTnKU3xa
         7bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512617; x=1764117417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yH0cZL/s9sZEN1l4izxVJKR+dHvLhkS3+a3jIonNo8=;
        b=kq8r6nFPcU/npfZ6tVU+MHGfClBax6zqHnZH6onCejjvRouJSC0RCe8z+7SQVTBWn0
         w50GtuTUxhRcRlP4g5Z5xfSZLoEb8/WOg0v3W+e5mKS92dTsfsGCP9aGG59qbJnOTg/K
         b0r0j487otd8/G8WDk/42RXEUGggk5Bw+rBgyYMPJxZKCq+Iz1Wz/e522wOfKkEvh+dd
         ReTpkTjQdJhIDl8BqDARMA36y6PiJ5nhAm1PmyfjPjGKot4/gxNMdBh5OgEDjJav0kvb
         9/2Wxl9hPV70N3gj1vrKuooLOHrQfTwhAFlD8ZUxVRd0WB7szD1vxn7x/kiqCAgHD1Bq
         /iDw==
X-Gm-Message-State: AOJu0YxlGaPb+pHL4EmTRWPEj73Jv5fF7BQfhXba7v3qJLIT0KltG3bT
	evC+3v804PsTeqllIDt7M0erbNCgQzYr/ZOlY0OXtyiXlh0LvxgXcM7bbjz18w==
X-Gm-Gg: ASbGncuAthZkhwFDuFL8epGyK2UshKNCn9SMyGwlVisXuRXhVG0eQ2EKiQv5HqEJnGu
	s500wH3H1R0QoIsX4X5VqQWc+93ebVpBxzlQp7a/3Jz46ZJ8j6j8kYYC2tI9uIjsXg3kxWLFGdy
	w+mx0uDokV1brfqOEW6Zi2EWn2duhq4rv1yLNZZVj3MMJwjCc/KkDMM7S2RMgXmf3Pvdc8L0jws
	cCD+VPfdZaFFy9FmqAHpt6wRCr1LLXIe1pWaICTgC3TW9+ewiAUkoAiR680QddNRhhjBmaIp/8v
	Qpf72mV9TWCFyFsh8DLdXzh21ACE1YLDHL1uI6leZwTrB7g+LGO38PrSCQvRUEj4VySR8kbgao8
	G4wFMEsanQ8rM2fq6HXhd058EQO/Wc5zqljbcT/SXQO899Sl/4fpMKoFCQB0J7X3mZ3k6ZvZHJm
	fY3fqoRJkBD3Vvx+AU+6Thzh2+2W53XYOpBtqHkNqzB3oOuG2KcWRlZgW6rOJA4n9STnCq
X-Google-Smtp-Source: AGHT+IGSvbPvWCgAa9sTIN24LyOTcygXL4/xs97Auo8jpA7GeJsn3KlGHxbb4PiWEDZqfW4RdJjdzw==
X-Received: by 2002:a05:7300:cb13:b0:2a4:3593:4686 with SMTP id 5a478bee46e88-2a4abe12565mr7168115eec.34.1763512617065;
        Tue, 18 Nov 2025 16:36:57 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db4a36asm48924288eec.5.2025.11.18.16.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:36:56 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 2/2] zloop: clear REQ_NOWAIT before workqueue submission
Date: Tue, 18 Nov 2025 16:36:47 -0800
Message-Id: <20251119003647.156537-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251119003647.156537-1-ckulkarnilinux@gmail.com>
References: <20251119003647.156537-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zloop advertises REQ_NOWAIT support via BLK_FEAT_NOWAIT (set by default
for all blk-mq devices), but delegates I/O processing to workqueues
where blocking operations are allowed.

Since REQ_NOWAIT is not valid in the workqueue context, clear the
REQ_NOWAIT flag before handing the request over to the workqueue. This
avoids unnecessary non-blocking constraints in a context where blocking
is acceptable.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/block/zloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..22a245259622 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -620,6 +620,8 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
+	rq->cmd_flags &= ~REQ_NOWAIT;
+
 	INIT_WORK(&cmd->work, zloop_cmd_workfn);
 	queue_work(zlo->workqueue, &cmd->work);
 
-- 
2.40.0

