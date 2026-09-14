Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4526439340
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381887; cv=none; b=nOeOc8UnCOv7cjrP+ntYSTv8AG9jUrkSuzFZPpo/+MVRC6LXo2sNgx03U5ZWhgWQpjkNuQQQXWWUy/PKf8ituJoly5I6iBJGRq9BB69hgR719M1Umpy6a8Ths4kZUwIj7P7+FDdxxm4DYHwB+JV7riirmsJnxFS8Jz1wS0sBSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381887; c=relaxed/simple;
	bh=rdZAz7cRFj3PdwDON/U2rLzIrTQddJNCfUz4fMn1Cgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSbKb5Xmk0AF3EGh44uRKlrJVkmjegSfuXwFRaLDWNGgGVTLhz1GXze+CUZf1cW7Q25UQ0q7q0Ud+HKVF8ZjvMBNqtt84OnrzbBClfcIndP2Uut87oqqa/KkxrqSGSlj97VW/wTGyntq3TYN3syj3SxZoVVboxc6r+JUOW+gBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KViTsalb; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KViTsalb"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4b29fa803so1390673a12.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381883; x=1789986683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARAL3oS9Pm8E23aBV6jU2rxP85qSTEkId7/k0Cw8UTQ=;
        b=KViTsalbXH6bgmEF6t60cJrv7a+HuvUdDkqqXGRa6iyeOlUPPkZmyrJrPVmgzwsX/l
         XNpFTInsrTFjpWYHKCM5/wiW0h0ugjwtuJm2vkgmIKg4OmBcafSUNUPR1839kEoiqDDe
         BomAzM2WIfXRF0zivOoVWK2UeO7C7liDgJoKgYoCpOSqQoyNIp7MYY7e6xdAlSkRydlC
         eYdzuJXz41hL1Ec33L6ne+V+Dr2CZ+tT8nEq88em7Pbmth2FX7dS+A/E2Ubg3pKmMVk5
         pzk/omJS9Uu4aH4SugTdmjrq0+x/eVYYqCuVPiTEffaEZaretdcE4txKQoBbZlFlMJOK
         t9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381883; x=1789986683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARAL3oS9Pm8E23aBV6jU2rxP85qSTEkId7/k0Cw8UTQ=;
        b=PqQ2RsKE3uS+drXFz7fcgbCbB1Snb7pB+NZ3wYQ/N891AAbGZMMPEOshpz7Gzxwz6a
         +gUElxIwg35ZJiPpsPQdvbjuea269JhtN+tE4SpTUQva33QLM2tUKHfcqrLgx72vxwBN
         coo7vqHKxfL/HXl9RZzSuRtYn77tUMyhnYbpJ1BhRUz+bja4b2k32t28XVipu0CUusqh
         RPgArXpF9lAmjQOBCLJ4QvHFE1Zk7ip0oQ+9+CA/8kaHO0TgiN/TXO/0iG2NdUKigDmH
         OndelFQRXiW7LVTwv/s6ZG/thc5OZGg5mWjfE0ksY6JyLwvZjCXs21dExJoRhQSU20IW
         lyCw==
X-Gm-Message-State: AFuF++lfpRBEj8sP5aLe9uILpPIOpFkib21qEdVwyM9kjcSG2m8pr4Gw
	Fbe6gfOh5oacGlw+2UOWPWgdAiENf4tc8nZGOAVBMImZpM33DgKH2pOO1ZUna48s2NziHZtJgW5
	DRKZ9
X-Gm-Gg: AYBFou3zUW1W6mlVkYvpM6xzG6DOG/UwBzlECeiJW70pMtCoUp00FskxQ2rRsmhFDlX
	4zmordltVTmvMLdaP1QKWHSVtf0ovGxBn7JYy1mOPHwJdT8aEjlJrVLDEUp/Rw07pi+jyTAzxqX
	YmzwImawTGUMy10vo1rX5yudZKNlS3ownqIWWc9oH6k8Q/flNVdRHfjBqGiqnXOBiFQcutrKb24
	63toyXw0YplzP1BhUVLQ9LxwiwuRYtSvpHIZzfRRnk/QlQ9wfcvBhRror3sgvCZzY9/3sPSQ9aw
	FKERn8L+eAlNtIVV3DMpJ2T3J+nrMjzlEW+WUanotNloHVNLU6Yp4Gunan+1IxWHiNtoNAb4A0X
	29BG7tqldl3q1fCqFgfEdMu6CPXbfBDxyHA/CChNaUy6kchauc7hZiWmzZqxkb86yMHLmTAp1Az
	9UFrRrdYjoo05VJD8n5eewTvap0cIX/TXDguASDJ69uz9cRG7d0iLFL0VYNmhLiRXM+py/mVr+x
	g==
X-Received: by 2002:a17:90b:1c90:b0:39d:f660:fa9c with SMTP id 98e67ed59e1d1-39df660fademr1021701a91.10.1789381882933;
        Mon, 14 Sep 2026 03:31:22 -0700 (PDT)
Received: from localhost ([106.38.226.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9587c157sm20168973a91.16.2026.09.14.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:22 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	rostedt@goodmis.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Mon, 14 Sep 2026 18:31:16 +0800
Message-Id: <20260914103119.1708452-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bdev inodes are routinely shared by multiple memcgs. Recording their
owner wb as foreign can cause dirty throttling in one memcg to trigger
writeback of unrelated file data belonging to that wb.

On one production machine, bdev mapping snapshots showed as little
as about 10 MiB of dirty data. A queue snapshot of its owner wb showed
599 foreign-flush works, with an average requested writeback budget of
43 GiB per work.

In other words, a small amount of foreign dirtying in the bdev mapping
can trigger owner-wide writeback requests, whose budgets averaged
43 GiB in this queue snapshot.

Following Jan's suggestion, this series records foreign bdev targets
separately and flushes their mappings instead of their owner wbs. This
preserves a way for dirty throttling to initiate bdev writeback while
avoiding owner-wide writeback triggered by these records. The existing
foreign-wb mechanism remains unchanged for other inodes.

Tracking is best effort: each memcg keeps a bounded set of device
numbers without persistent device or inode references. Closed devices
and devices with a busy open_mutex are skipped. Device removal and
device-number reuse may race with lookup.

Flushes run asynchronously on a dedicated workqueue to isolate these
frequently triggered tasks from existing workqueue users. If workqueue
allocation fails, the existing foreign-wb mechanism remains in use.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  24 +++++++
 include/linux/blkdev.h           |   1 +
 include/linux/memcontrol.h       |  15 ++++
 include/trace/events/writeback.h |  22 +++---
 mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
 5 files changed, 157 insertions(+), 18 deletions(-)
