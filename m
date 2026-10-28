Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205862;
	b=3JfoheCjaiaHmUw0hxQavJoq6s9csTUvSjVMYxOk4Xf6E7xgb7s+7OIFqxXa8eDhbqmP
	 SwBl0+jEIj/J/GAQ3U22+fQuA+H/9wcIxbomFYJJDzIunugXry+ZA5Cy6hNtTYMA4k3QR
	 hUJFWrQS0S9l3eS8TF5MVZeGlLJtB1aI+TTaseFDhFbaZRafTtoLkCtM4NGYrDXGFcNVL
	 ZGYMp2frADnpRAd5vyfFM7lePPEbeTtj3esalU3HDxAXGeaeoKjD3Iz1oDCHnkLMWjttP
	 JGPwgxH1bgtkaq7lV/uU1+GaKlobtgTdYwMdp8NM0qhwa0ofP8sUVucyuA8TCtEy/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2x6ZMRwjwD1MoaqG4WqOnxE5UXawezAVCYWm3ixWoRY=;
	b=qbOsVU+/tOUWa+ptUUcJZ08C1iWW3VTsQO7l4vyC40S9vLxqivr246rKjZ6vwC2U1Z1x
	 VqTUBy7lkdx+JrTcIA3fNCZvJNAq1H3WlH4SY6QWJznr8e87bapUtpvTAIVw8mRI6Rksj
	 FB3K4JpY8EjDQNHzCSNIWPa3wY2C7LyQJc9qM0fw9rdUvzX17CcX8r5JrsYXZs/vcbLU0
	 t6ZBk973B3CCrrz4UI+y5qnVmwcEmHBbk49LGv7dP7O8PI6fzu3egorHqEZoV1cAAvU+1
	 xL2Eg2AD4XXbmcxAMR/FgIWa3PbXZA8hj1vpxKW43fzDCtqlzw3/ZqkO6TKYYGVcmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=inLxbOhT;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229D606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F229D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=inLxbOhT
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-847ac7ccd85so792279a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205861; x=1793810661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2x6ZMRwjwD1MoaqG4WqOnxE5UXawezAVCYWm3ixWoRY=;
        b=inLxbOhTp5B8slXntRkuEZvaXq/9gpgrDTyM9kOtAXUBKOUIXAw0iOtu+qiDWKUzQL
         fdS9hcSuJzGn7Df+0UeSeOW8ET9Ayd56Iwe8PZ5TjGYYokN1+d9cejC63j8zKKC8rAy8
         O2LscvkJPqv2fOWWO3DhIsgi0m0eK/DNjwCJd3twhq6sMtl0trvCcmioEhLlFU7IhxIs
         G6GtWlOu7a7wrUjZYqOghn1QwQuPUXr39yGItNBznDtrkT6/3bbeUrdxmWaFLV6ov1pA
         LiXx+7bj/cieJPx3ui/YYF1xFNmBvQVn1+WYdp/CzpDs+EXq82SSvYOqxojV0xg2YeJn
         Siaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205861; x=1793810661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2x6ZMRwjwD1MoaqG4WqOnxE5UXawezAVCYWm3ixWoRY=;
        b=ZWV2UjAKN7hfql2C36B27Xo6cKR2F1lwgcSRp02mzFhj/W0H5VG1u/7TyrjlzUIHNs
         OLla0LYH679ZxawpSp0QIFtOh5LvcZ4qgbX55INgp0K1pe4am7HirjcP+/4XE2LsZcBk
         y3JZx3/soqJfPMIN+ndc5J/VRFDGQp7XjkkXZnsweetbBEfpAP2cqCjz8+5wnlzkLhrR
         ZkrA1f43dAAG5naV7UJI2hINLLBaQPbrE0OLVixYvEYHhqRZCL97WfXPcE4MWgkRXELY
         2/Blt1qclIIOlvBtAeMtBSu5IZBDHsF5xZn8qxRbI19aDhk2DWXKNozkC989Iw4P7bjA
         ljCw==
X-Gm-Message-State: AFq9FYKT+yTrM2Xa1X7kwYqcJkB6uQZbnwFXpxrnCEEU1PRkfvML6mcn
	4xNwofKq5P7xWgFIDD0FXbplpZGgF2tFOPI1sJEnbHWKn0sQ9FQE73m713rPjQ2LG/IcWl4wl9m
	BHxwVNRU=
X-Gm-Gg: AYBFou1ouRSPEbGNmhkZbSV7cadtA0h+bZMW/ziqG7KvZoRdlTeNRkksGL0JD9S+T3H
	YWRZnr7Hmm7z9WC03RrS9gK0iWcZ0HbRqYrup96l/6XsQ05dPEWlNo+ZlgXLSz9LzCI8dZGpAFu
	YG7KskVPgfJ1H5rk89MzluZgIeflOHfkAg0+Ej5Fx26WCV6Tfag33xQC+f4TPa7U+xami6AKEJx
	J7OTtK4FmoqulkCK7KBTCcWyUulxxaFMTxrndclxhVVu6KAonKAHMoRljALEjaMDX55+s/vRl50
	JKmvvHOe+bBIHzvCZjBqi1yQPb9g3xWAT4hUxXh9e/IBdUwL51oF8b+kmhE8Ltxp7frd8Ukj+9i
	54IyEL+zxTN6FajQyZ3TcmVyDWpsrMjNOPR6ZJCB4JMRkJpSY8K4n/gId8X7B8Sekq1xYfxfT++
	KpAXKkXn4FZu/4Og5HYvV9l85mf50CO3MUqcpFeQuIoHVM1lLNOBNV9o3fLcWfJR7q2Pa8iovK6
	gmK4cNrXS/MPCK7GFzTDWrkocUheAAJFBCPGq41JGDQQo02bSJnaTrrfjY+xr65GVEjrSaY+7Nl
	4ll5ng8UmIVHxRe4OA7TKb/WiuiLPwlvGQuasdNG3eOQZ+qmuO6bgMj/VzRrwRPPBVll23hUyQ=
	=
X-Received: by 2002:a05:6830:2316:b0:821:c01c:2ec3 with SMTP id 46e09a7af769-85ab7a13a8emr2711852a34.0.1793205860926;
        Wed, 28 Oct 2026 09:44:20 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/98] blk-iocost: free struct ioc after a grace period
Date: Wed, 28 Oct 2026 10:41:05 -0600
Message-ID: <20261028164415.1262013-3-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

ioc_qos_prfill() and ioc_cost_model_prfill() take ioc->lock from
blkcg_print_blkgs(), which since commit 56cc24f59c14 runs under RCU only.
That covers the policy data, which is freed after a grace period, but
not the ioc it points to: ioc_rqos_exit() frees that right away, and a
concurrent read of io.cost.qos locks freed memory.

Free the ioc with kfree_rcu_mightsleep().

Fixes: 56cc24f59c14 ("blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-iocost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a81488c755ca..7b5d865d8c14 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2920,7 +2920,8 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 
 	timer_shutdown_sync(&ioc->timer);
 	free_percpu(ioc->pcpu_stat);
-	kfree(ioc);
+	/* blkcg_print_blkgs() gets here from a pd with only RCU held */
+	kfree_rcu_mightsleep(ioc);
 }
 
 static const struct rq_qos_ops ioc_rqos_ops = {
-- 
2.56.0

