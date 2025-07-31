Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32335947;
	Thu, 31 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965219; cv=none; b=oU0m1PLlJTsNeaOfH0MYXAIRrd13wrd8/qRaawWKIYLqnTEuKvz3DYiKUfPP57zNP+ZsfyHIk9qEa8TYGqnJcRa+0GWf/1qci+b5x7nk5tVTDZx8HXs+dV+ADYrm9aBaWS/S4roKZqa6+Z3H19QuIkD2/qKVsU4NAWV2AtLHEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965219; c=relaxed/simple;
	bh=qHPfHCfn6kgsHPzp5dCmEFMS26jIA83Y8ZGsjCJzbOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rd2jtnppgfz43nomBq+GUtk8iLXy8IDOO2A7t8ZdMSiTMRGDCMq36Mlp0nnBldg2M/yUYlhIDjMV3ya3zZWwbbcpq+b9FNi5DqsigJqVlMC/o8kPZV1GBZi68x1qfeShJUgeMYZ3tXoy2EVExsl6dUflWgyqykNIKp+2fRAdQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJoXmKkM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJoXmKkM"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so567742a12.1;
        Thu, 31 Jul 2025 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753965215; x=1754570015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/36nYe2WCOObs9eQmPyTwjtNHg3LkxY/OMOrZAoHJJI=;
        b=ZJoXmKkMUrVaibyMIflRcLGxBqvrKXfNzKTse904lzUeqmTsTPruW9ZG2lL1jW+IMF
         R6LuYMM6XjUtUrVF6z5UrFBCFJzJJhSeWjaP7isPO30+kdc1BQnRo7IrXXAIUvg81F8g
         RJv5juZOmZz/YbISMKfX0RLf/8I/ncdh722Rf8jhOZeMl9o6QCffRtG9yZMa8dzSyLE0
         TKxERunipdUNrTucoRCr9dkjYBhoT8fQJVvPQSV7oO2GF2uQ0Dj/0hsMclm5IzeZRCpR
         VEwXhMDTHsacjYOXgj5tv/jdPh0Wp47VtLJe23YISZ2mEzeXNv0N+WGNfoyq9TV5nQh3
         mTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753965215; x=1754570015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/36nYe2WCOObs9eQmPyTwjtNHg3LkxY/OMOrZAoHJJI=;
        b=PHrl4DKS4m8nxSel2QQ3106EMkZTlwMHjgpPtr2OG61bhCHX8Bd9DUdtQnkadLNhff
         h2UQh9415yo67SbG8hJE/rH3t+i8aYlaEPgl0aebMqyUs3H7AeNU8HT0NgZ1t4E69CjM
         qYOLI2z+bPo8BL6l3LqT0Mm4QuFMPYNpCXvyHNogcN3tngTTN0ZNdr5NPijMOZ7SryBA
         dilReIk5XIadtEmr/83uBf0y/Rk8eUNrM1SjnuzNLhUih9fDz8AkQbYMeqRvvo39HXC/
         AVa3TtNnetUIxDSUaWdyoCTCHv/GHqfzlC5RQkiqm79rY0+quOBX3eQo+M/pyRT16RYz
         ZlOA==
X-Forwarded-Encrypted: i=1; AJvYcCWJURTaD2lAdmcZjfGnqXYRbdHjZunKjnukGGKLe88WUABC9sNstK8nnr4AxEB41Wated2tDYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUvUHEPZ2LC2jixNXlLnmHv9RYFK+gV/0XQdSXkz0k4DbrH6k
	Nmw5MNx/9qsAonfHdoQG7jVCS9sqLnM0nJdg5kteNcEYbqpSJAuu8mP0f1TTWPXjZXc=
X-Gm-Gg: ASbGncuaQxQpifPd3W3OV75v0FXET29FDU4HbUjaXcbKL3AhDilIgQKFgK5vCjS4XRh
	KKd/rLqVM48g5RCnyLoLhbQ1ngzIkJEqSBxT90XlbvghK1aliNZ7E/2AIwZDYsHs7T7y2XbRo7E
	8JFB6QF/j1CUa6s4PSiOLhAQ44ZtDjDDFmg97ugDQS5dOZff4tSA2nZTqH+mmzA76TPTZEWKtSh
	5PF+kEU+rPI8+A/qkQEtO+xe1fy4YMaaDjq2vQS/iPU46ZYpdoIVBXfIPrp15MGNQdgPXezYtq5
	1Iw0EDpyvoZgYPEqBLGYAS3tHZSqWxj+nO69ulm7ZuTbexu+u1bwJdoRsh62ElBlhCi94X80p+p
	jnMSf8gkzwajOQW7WdxDPvplxOuU=
X-Google-Smtp-Source: AGHT+IF2ybQ8rJvr1FVMyaRTLAkALRfeQzNbDaB4aLKXP+SgtQ2Jtdrfb0hi0qxG5LbP7m4tpLY8WA==
X-Received: by 2002:a17:90b:1fcf:b0:312:f0d0:bc4 with SMTP id 98e67ed59e1d1-31f5dd9ccc8mr9023739a91.5.1753965214501;
        Thu, 31 Jul 2025 05:33:34 -0700 (PDT)
Received: from localhost ([121.30.179.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cc41sm4590375a91.32.2025.07.31.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:33:33 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
X-Google-Original-From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@vger.kernel.org,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
Date: Thu, 31 Jul 2025 20:33:19 +0800
Message-Id: <20250731123319.1271527-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, we encountered the following hungtask:

INFO: task kworker/11:2:2981147 blocked for more than 6266 seconds
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/11:2    D    0 2981147      2 0x80004000
Workqueue: cgroup_destroy css_free_rwork_fn
Call Trace:
 __schedule+0x934/0xe10
 schedule+0x40/0xb0
 wb_wait_for_completion+0x52/0x80
 ? finish_wait+0x80/0x80
 mem_cgroup_css_free+0x3a/0x1b0
 css_free_rwork_fn+0x42/0x380
 process_one_work+0x1a2/0x360
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x110/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x30

This is because the writeback thread has been continuously and repeatedly
throttled by wbt, but at the same time, the writes of another thread
proceed quite smoothly.
After debugging, I believe it is caused by the following reasons.

When thread A is blocked by wbt, the I/O issued by thread B will
use a deeper queue depth(rwb->rq_depth.max_depth) because it
meets the conditions of wb_recent_wait(), thus allowing thread B's
I/O to be issued smoothly and resulting in the inflight I/O of wbt
remaining relatively high.

However, when I/O completes, due to the high inflight I/O of wbt,
the condition "limit - inflight >= rwb->wb_background / 2"
in wbt_rqw_done() cannot be satisfied, causing thread A's I/O
to remain unable to be woken up.

Some on-site information:

>>> rwb.rq_depth.max_depth
(unsigned int)48
>>> rqw.inflight.counter.value_()
44
>>> rqw.inflight.counter.value_()
35
>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
(unsigned long)3
>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
(unsigned long)2
>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
(unsigned long)20
>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
(unsigned long)12

cat wb_normal
24
cat wb_background
12

To fix this issue, we can use max_depth in wbt_rqw_done(), so that
the handling of wb_recent_wait by wbt_rqw_done() and get_limit()
will also be consistent, which is more reasonable.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
---
 block/blk-wbt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55f41..d6a2782d442f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -210,6 +210,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
 	else if (blk_queue_write_cache(rwb->rqos.disk->queue) &&
 		 !wb_recent_wait(rwb))
 		limit = 0;
+	else if (wb_recent_wait(rwb))
+		limit = rwb->rq_depth.max_depth;
 	else
 		limit = rwb->wb_normal;
 
-- 
2.20.1

