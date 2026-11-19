Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071971;
	b=4eIhQS9lmySiA3JmmTMVlRqFUNj0AU+HxU2MuwZ07l4Ar3lR5iorelvqg2vGph8kxarQ
	 9/KVN0STOUix+iSGUKvLYR4mvOc8FmS9EOIVzw3VJ58vMPHj84FEcjAue8qplf9se0uCw
	 kFXYuKL/Sv74mkmAW5LUsJ/sUrIdGgPcusBuVnd3+inn7mMVv8JbUQUhjberR4eIQvt1U
	 M6tOPJoAcCDW3JV5M6tlkeExt5DXmOiUzZaigHqu4gbRti0zfqORY2qvdhkinCt703BLd
	 8uUTS0sHFX2B0tFoJ2VrPgR3LGrtXCuWy2NIobdXVeYuqd+BRi5QGLji6CFPIY/elmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071971;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g1EQXPSUQrbKOxPgXcmHUhivhs6SmclDOQPAmJrFSXg=;
	b=noGZ39rqizzdvspkTuH5/ELpudZczNzQxQEGvSPVNDNFrdBHXjQC3Kez3ACK2zBsyBDW
	 qGjmFO9sVd4Z2aF6g+LfnloBehJht0FJ7NxEq1XtXVtac78iXgrYE/TOFRSu22kAk3MCB
	 XdjugIKQR+fbjGjVc0Yd9e7RVmzTcgaHHW3D0vNdm+zbcnIePgqVBiutzAqcYtwTWajr4
	 AknTBB17oBIdEs4p+79mXhJ2wAWifXCzX5/O6Ke0Csm5YHY6V/KFpQRnXr9bSyv7hzmIE
	 /zy6GLr92kFwnAPrm9lmvbTxl2ukQ8qCk19kL15bFa8Z+2H6FCThUduDf6bGNVWhz0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S9pZXLM+;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C22606A32F
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C22606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S9pZXLM+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071961; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g1EQXPSUQrbKOxPgXcmHUhivhs6SmclDOQPAmJrFSXg=;
	b=S9pZXLM+lPkRrhhrTKLWtVXfb5NDho7PzAP1qATPgeizSZ5FSMKyjuQ4HTd8MyJOCza0X4Oxky73e55RGkkWKGvi6QI0StIBMfWAFDCJt6AOuZMlCuQI8eQVah5wP2GZN22OofriXGTNFiWQ1qAkIuRtIwshDMf83wOzR2yEBZ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2ih-x_1795071961;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2ih-x_1795071961 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:06:01 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/7] blk-cgroup: don't attach a qos policy to a dead disk
Date: Thu, 19 Nov 2026 15:05:47 +0800
Message-ID: <20261119070548.3125491-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119070548.3125491-1-kanie@linux.alibaba.com>
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
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

blkg_conf_open_bdev() validates disk_live() once under rq_qos_mutex.
ioc_qos_write() and ioc_cost_model_write() then release that mutex,
freeze the queue and re-acquire it, so __del_gendisk() can run
rq_qos_exit() to completion in the window and detach the existing
policy. After the re-acquire, q_to_ioc() returning NULL now also means
"the policy was torn down", not just "never enabled", and the writer
calls blk_iocost_init() to attach a fresh ioc to the dead disk.

Nothing tears that ioc down again: rq_qos_exit() already ran, and for
disks on a shared queue, e.g. sd/sr, blk_mq_destroy_queue() does not
call it either. The ioc with its timer and per-cpu stats is leaked, and
QUEUE_FLAG_QOS_ENABLED is resurrected on the dead queue. The same
lazy-init pattern in blk_throtl_init() and blk_iolatency_init() is
reachable the same way once their respective config writers get the
release-freeze-reacquire treatment.

Reject a dead disk in all three init helpers.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Fixes: a13696b83da4 ("blk-iolatency: Make initialization lazy")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-iocost.c    | 3 +++
 block/blk-iolatency.c | 3 +++
 block/blk-throttle.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b251ecc66d8a..f71d997f232c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3009,6 +3009,9 @@ static int blk_iocost_init(struct gendisk *disk)
 	struct ioc *ioc;
 	int i, cpu, ret;
 
+	if (test_bit(GD_DEAD, &disk->state))
+		return -ENODEV;
+
 	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
 	ioc = kzalloc_obj(*ioc, GFP_NOIO);
 	if (!ioc)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index a3bd153c67be..553f2091730f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -761,6 +761,9 @@ static int blk_iolatency_init(struct gendisk *disk)
 	struct blk_iolatency *blkiolat;
 	int ret;
 
+	if (test_bit(GD_DEAD, &disk->state))
+		return -ENODEV;
+
 	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
 	blkiolat = kzalloc_obj(*blkiolat, GFP_NOIO);
 	if (!blkiolat)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c5e26551956a..374ac75832ea 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1322,6 +1322,9 @@ static int blk_throtl_init(struct gendisk *disk)
 	unsigned int memflags;
 	int ret;
 
+	if (test_bit(GD_DEAD, &disk->state))
+		return -ENODEV;
+
 	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
 	td = kzalloc_node(sizeof(*td), GFP_NOIO, q->node);
 	if (!td)
-- 
2.43.7

