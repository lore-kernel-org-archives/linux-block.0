Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD780039
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031633; cv=none; b=IQc1xGzLleBjHChgretX1WDv0pB2II/WLXu4oOy313syA0OM3Plpf9wYFGfx3ZbFwffILAuZKMRUGth4w2W7sSDxxiYJ/mbuI2+iYdN/NkT4yUZWsZJAsdhMR+BNFqJubSAgqugCI6Nd+WhO14YwafwO6pAtG1MUhDtAZP3+OZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031633; c=relaxed/simple;
	bh=Tl6mGZbZRuoiBadYjH325snqUfqroPfSghWqjGW9KLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIlGE3Bu4FZaEmrTQRoKrzUJefbFlTi2uJw6Lkdw/vn7CJNRBwtgf/bqk928LiPBr2Ukj0AemKEamwm650vx7uP+1iW2yj6PF7khlVVJX8dJ0Sf2t1PJWcAW5oH59QY5+qW0gb6jire+AMRWxIAJKEe5xZp/Ent3kIcTAQRjuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x5B+dyZH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x5B+dyZH"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so61743339f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031630; x=1706636430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9WFpwLwL00WE/4klKg8cmhjNxww+jJcfBSHYS0F1rQ=;
        b=x5B+dyZHHG9y4Q3AcunSGUYCw3HUrFdXHIpWI97YQO6LHiIEdjYpeYG66W7/G2lb1Y
         nlPk0rdsYU42+LSUfO8wd/baKWlrWvNmnsrFSoSVyl7l0u14Ovyoveot9INwGinV8L4g
         U1qJZD3rfWb0QRRoNIHoJn/wZVukJuSG0QpKNPZ4rL+lfbuEGe9KeSAEkjI+/7TlQNRT
         IRyRPyAVlA3dmZgsKAqnqkrbwtieDqHIeTpLPy3Qt7Gp8yrUHQoU3BGYFnwxVv218lSO
         iar3aJEU2FmyI6qQxHZIOeebPFXYMwokmKEE8HdkSrnhoGZvmFZYMqNPUyRUHxjIj5Fa
         iW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031630; x=1706636430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9WFpwLwL00WE/4klKg8cmhjNxww+jJcfBSHYS0F1rQ=;
        b=wv91Z/VmLiGsp5bRZzqmIlhe5gCoODr9ZDMnhgyYZ64AwhJyfotY6YKC51kzuS5jML
         hgPise5Zvlvjgv94Nc1TWMqza+RurY03tLiyMymigqlhLyP1wb1L28tBuZNd1pzF4rQY
         uSSQGkKHBpwKg2hY0gdafaQldWDLtdniT8QP8qlycHZ6tbR1W/B3eQ/rWk3l/yXf6p+o
         oAxHx7sXw7UUc4hIvtIXKR8ZmlY4nWNYDk4Roz3prOeoibffo3TnXY4jbG39y+TcZgPH
         oudoqqqxTJ6m0vDTmTBgfp73nVtAiQN/RXuKwMQc14AEeQ8pvA1Ozg5bnSbGCokn5sum
         ujsw==
X-Gm-Message-State: AOJu0YzupFmlRaMLr162Z5ezC4MJ2EaqLN/Ti3qGSe02TnbT18jTi8XD
	EjRVp9O0LhsVOSCcvwglSjeUaYR+Ivc495k4M70AbO8Rnf5ZuCwdRQtiyHa2WxqNcM3mglHBfSq
	q4UU=
X-Google-Smtp-Source: AGHT+IF+wuBuYw+1lcVuH4lifKJFYDhSKr8AqqbOkvb5vR1nP/qK4JZjjUmCAA62nyMk+olY9wK3AQ==
X-Received: by 2002:a05:6602:4145:b0:7bf:60bc:7f1e with SMTP id bv5-20020a056602414500b007bf60bc7f1emr11477190iob.1.1706031629792;
        Tue, 23 Jan 2024 09:40:29 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] block/mq-deadline: skip expensive merge lookups if contended
Date: Tue, 23 Jan 2024 10:34:15 -0700
Message-ID: <20240123174021.1967461-4-axboe@kernel.dk>
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

We do several stages of merging in the block layer - the most likely one
to work is also the cheap one, merging direct in the per-task plug when
IO is submitted. Getting merges outside of that is a lot less likely,
but IO schedulers may still maintain internal data structures to
facilitate merge lookups outside of the plug.

Make mq-deadline skip expensive merge lookups if the queue lock is
already contended. The likelihood of getting a merge here is not very
high, hence it should not be a problem skipping the attempt in the also
unlikely event that the queue is already contended.

Perf diff shows the difference between a random read/write workload
with 4 threads doing IO, with expensive merges turned on and off:

    25.00%    +61.94%  [kernel.kallsyms]  [k] queued_spin_lock_slowpath

where we almost quadruple the lock contention by attempting these
expensive merges.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 79bc3b6784b3..740b94f36cac 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -800,7 +800,19 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 	struct request *free = NULL;
 	bool ret;
 
-	spin_lock(&dd->lock);
+	/*
+	 * bio merging is called for every bio queued, and it's very easy
+	 * to run into contention because of that. If we fail getting
+	 * the dd lock, just skip this merge attempt. For related IO, the
+	 * plug will be the successful merging point. If we get here, we
+	 * already failed doing the obvious merge. Chances of actually
+	 * getting a merge off this path is a lot slimmer, so skipping an
+	 * occassional lookup that will most likely not succeed anyway should
+	 * not be a problem.
+	 */
+	if (!spin_trylock(&dd->lock))
+		return false;
+
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 	spin_unlock(&dd->lock);
 
-- 
2.43.0

