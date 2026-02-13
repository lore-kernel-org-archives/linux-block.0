Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EB2C11E5
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022739; cv=none; b=BPIVS0SL2SCoOST7s41c8W/6TZemQsDcrvMMCRUAGK/EPrO/TtNnORSq1q1vLq22sLVNNof+7TZwyXdZnfDx0qQt9Ht0PwCNxzikJ/8YaO0A25X0rhAIpxb46Ti2hWvQOHh8Jk/GGn80+c5NC5Sz8PBGxOgvV5nfdL1kqlVwvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022739; c=relaxed/simple;
	bh=woHZc9BPo5DngwCKRvAMPblGmAjcXMiVMXj/kHArH+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJxGbwIVbtqgwol01+ySh/6JFO1wllGpK0Q15S3yL04GejPLyzpZGXSmiYt4VIDM7SnBl6l5hQyOFfWieEteGZ3zNVFbyKNj10Nl4zX3D9dDIPrlMrpBa+bzHPdE6yqfjV4BEdBIVRyeSZdY4MIC238NL1WTRx8Zpb0Y4f0Zi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=deBjHvqr; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="deBjHvqr"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b86671f87eso2716249eec.0
        for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 14:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771022736; x=1771627536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seymYYEGAxfqY34qujfE2eQZoACCFYqRmAJDQBRrN+Q=;
        b=deBjHvqr/OwI1vNsA+3tMcO4o+eIS3uZoaN870TdXiXd5iUpj7jYZczAHDDztsrfiK
         vUPn5f+xNJepS5Jad6U8rSg9VM/GyrfHDisnIlS5UYAAKPROYOELdGmRynY/qcTcCsFj
         +su+TEjKBGE9jAgpTh4G4Wd8F+tgPyf9A3DY42jmRjnLM17VUL8CGacjH6gxs25o2LB2
         DKKMeZnD1c9PZZx14CuyTamKw9puc2BiaRpBxHdl0KwIF66bpQ5c4/zAAW9WXssjLknD
         qDokiEMNRRCtFt9MWAv0Pa4rOz47goXYwkCk3pZelirKEicNbeUkHPGJUYsTyC9pNePc
         8Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771022736; x=1771627536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seymYYEGAxfqY34qujfE2eQZoACCFYqRmAJDQBRrN+Q=;
        b=ZO0aw03wZLOrFXavElZtXPpZhNbpZSppSrok276COFPD6OfTrrHeaKd1prUWZNsW82
         x/HTKO1NSZxdxKti9GoLGTHHbUAqcR/HL8/GNLyyS9tWBYHIxtkkijUMoSz/vvNBzHzf
         YOV21OA+9pVWyaCl00dyKYiVHj+U7oLwavdZNxydXWhdVjWk4WaPG/nXDuydRXjk7xBP
         cjuM7OMVffpFwxbmBU9BmvMd3D4bxONJ9xAq51f3K5jYX223bsGZS1SgYj8oCQ+55DL1
         u3eiw9ivwBL/YqQlF/QzsD1gv/Kaolu9Qs1UMK+8Wf41Yf1XPAMrzmvzZV25buAx+Ymk
         dUuA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrF1f8RHl2HIDVHeUrokw/zhRJn55egBKmIEyLrpP136kvjPfHK+Xw8TZBZCS6DovS4guiQivxvXPNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61ZuJCtwS4g4smdWhvWEzAw3WORPYU/iilyItkRppykdzhR+7
	zrqPA3ZYIOk+eOHo66c8/OguPPM4wMGfSE+LL8RF/YlrRLudLXscLBWX00jQFz2z7cE=
X-Gm-Gg: AZuq6aLIFMNKpOOueq+cRwBBBFztyrKLje+WdOMPkNwrAtHcZbLv39HHQ2DhgFtRfCE
	dEDmgnL1gQNiK/aOyG8ZK4rYzgFpkq8/TzZ9cI3DFuFhd/bymZY4HqIdcsLo4Uq46I/Oo5csxde
	LNlSzYU2TXn6TsN93FgDvsWkG2ApAOBmSKwmHhVOdP5FwnNVhCxnQ9Wmol+7skeMCTzoGQzleEW
	p6HXpSZY68tAxSo3DOiQr/MoX4MSt6e0Su/MA77rYor/AbbL9Uc9rIXtC0/l2d/wXPHPLfnYtnQ
	MBd+MW0sZ7Xq6eOofJCWYNLv2Y/ep0frDJdq1ua7P/KHgQwXsOe1t0HUDFhdbBphqjLaOUHOgvp
	/9Rxc6dXSgY4JdeEDdEuFsX1Kp4PGVbC0tYZ5Suhkhz5xsoxJUvpUQ6GZi1Ty//c3nUWWup5omL
	1lgvW1EbZU+i03aTg1iJuyVigu7VFDlt4ZFMesN4uEB+gb9A==
X-Received: by 2002:a05:7301:4005:b0:2ba:9a2a:e3cc with SMTP id 5a478bee46e88-2babc44eda3mr1285604eec.20.1771022735938;
        Fri, 13 Feb 2026 14:45:35 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2bacb543d80sm262764eec.1.2026.02.13.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:45:35 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai@fnnas.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] blk-mq-debugfs: Fix warning about possible deadlock
Date: Fri, 13 Feb 2026 14:45:04 -0800
Message-ID: <20260213224504.3990506-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
added WARN_ONCE_ON() to debugfs_create_files() to prevent potential
deadlock if the queue is frozen. We hit this warning with the stacktrace
below

WARNING: block/blk-mq-debugfs.c:620 at debugfs_create_files+0x9c/0x1d0
Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
RIP: 0010:debugfs_create_files+0x9c/0x1d0
Call Trace:
 <TASK>
 blk_mq_debugfs_register_hctx+0x186/0x320
 blk_mq_debugfs_register_hctxs+0x80/0xa0
 blk_mq_update_nr_hw_queues+0xc8f/0xd50
 nvme_tcp_setup_ctrl+0xcfa/0xda0 [nvme_tcp]
 nvme_tcp_reconnect_ctrl_work+0x51/0x180 [nvme_tcp]
 process_scheduled_works+0x840/0xd80
 worker_thread+0x36d/0x4a0
 kthread+0x366/0x380
 ret_from_fork+0x7b/0x670
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Here __blk_mq_update_nr_hw_queues() did set PF_MEMALLOC_NOIO flag before
calling blk_mq_debugfs_register_hctxs() and this should guarantee the
described deadlock will not happen. Warn only if the queue is frozen and
NOIO flag is not set.

Fixes: 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index faeaa1fc86a7..ec6670dc0a3d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -612,12 +612,14 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 				 void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	unsigned int pflags = READ_ONCE(current->flags);
+
 	lockdep_assert_held(&q->debugfs_mutex);
 	/*
 	 * Creating new debugfs entries with queue freezed has the risk of
 	 * deadlock.
 	 */
-	WARN_ON_ONCE(q->mq_freeze_depth != 0);
+	WARN_ON_ONCE((q->mq_freeze_depth != 0) && !(pflags & PF_MEMALLOC_NOIO));
 	/*
 	 * debugfs_mutex should not be nested under other locks that can be
 	 * grabbed while queue is frozen.

base-commit: cd7a5651db263b5384aef1950898e5e889425134
-- 
2.52.0

