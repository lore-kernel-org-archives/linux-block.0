Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878F439327
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381890; cv=none; b=CrznEtEwNPHDeCLEYHwQNJu772vHCalX0fElak9GTGWvm6ufH2fvokW1PZ61eVD3tY/diOpMNiOoqgDKWuaVW0jBeVWE/+fK6eCQKZQJpS6Fum/p9lHp7W9QouTjGvdKHEBafb8H1QiektOw7xOma0V5Kgz67J5GQikROv39DRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381890; c=relaxed/simple;
	bh=mavxj8Ed+X9L0RNO9bApjFiE/TIWG8+FWgXsB+xZV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiRTVGtwh4cmhlfHDDwdt3vVezYKBvKDz/eIuGYSvtNO8o4K9fMe55y+fbIVlhWM79rq78lxHuOFCKJ9z8Bkc4Sgqff3JC2Bfz+PZiq8hbAmarsnQvDpmZvks1iXsKit4sbwbENOUPyGttSADHrZHWwHouYHAx4Ii2rlpkAFFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ph/9MVSI; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ph/9MVSI"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1774756a91.3
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381886; x=1789986686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=Ph/9MVSIxqGhy8uuyRpgn4VyEtjFe9N0N0PWlSTsnL/qWviCC/pR/9ueFTZ0xcwiX5
         +zQ2Ye+mRcoNBEItrzbD7yKFhaNaPsRn9QTJvzjuJbDtRTpBQzlO0+utIN3YSHtW3kMH
         fe1S4916k5U4SsGxkstbCrCElXfMNE5HDlOrLh4SCmm0lxs0F4BTms3veqGcxS3E4Hgy
         TUHda9lhF/WJGc5/8b4k86W6Qx9fszgNN76PFUmvzsxeyQDXd2P3uI/aBViCrEfL01sJ
         jhTO8wk0ZxO/73n/8gg9Cf5VDcxB/IXUJI1siPDJ1yhiGsjM/YstDWHqN/WtkIhYIXM8
         TY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381886; x=1789986686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=ZWdcWPoc1U2+s0eUolgShJFQCihwG6G1YtlsB/QvoIjYQCL1k+adhyKx3M60yjXE8z
         0IshP5OszKuNQ2sGOoCCSjlrG4Rb2QqTvsDt9dbC1byrbNiTJX/mEU6zqZfj044fiX1i
         joFBz/TZvTM6jPVZEff9MjQU67kf8y6Th7bXLxNrSJl0aBRYGsy/O++1qY0+/mk/2dXC
         8F8mDb4Z+PIL7Ke58c2hu6tU6kO/M17mAi6wQsj/FXOvGaXPbJ13KfkwOGFQkav0GJxf
         6uLX2HQDO98y/QE/Sp5qOiPJIl5DhsgS3cHcG84DmU8Bg4Rc0Pt50arbuvzImwdYlQha
         fQgw==
X-Gm-Message-State: AFuF++lzhkQfk2GkPOVoE39gMakfgCTafi7p053wrTDSUQJ566cEdOYc
	x2WnZQHGazgDZfstP+JpSwMS7Q5OITnsoKzHm5cHM7jXaXYjfpTmivenPwjYoKR5DYi+fXcu2ZG
	iH3ip954=
X-Gm-Gg: AYBFou17gLjzrbhrUReBfBFtWfqvlb7pXWNpqgGcKs3DQVU1E3DINerWB4l3sX70Xcf
	TJwN5vqqSeRyLTP404ERtf10ZxMWhTFq7GOaNJC72OwUPSJ85DNm+gSC38yZxBkVgMUqm11BWwk
	tearHMP16CZ3a2XNRyE+ZMdrbvjjLyBRYr1d6XRuUkxQsf3Qz0lR6bACfmZfm1DzCOgvnUUeQZG
	CD/7eUeTOk3Z12XT1mHhT5rYfKX8crqlbpeeJ/RkpRfoFQPGuIXMtY5Xu1QjqjMBnf+ozFwhsyL
	sexfBcCczVyM4WN5JHqBb4aBYkQkPAZ2yYgwKvxJl7fQLeJDtBFnmVBieJy4CSJH+TwqQ93Z3hI
	ehtxqqxhixxoTM5S8CC/Sq98o34wOJ4KG0FQz9+DBFPsO/1H6guKmo1E1Htl40jQJpIOza7JWOB
	eVZjFZKTRjXmVpGMxAEGKPJ9PX7rGen30qwnUNstrWm4EpjSY++8wBUIwYX+qbmY7x9ust6jMlS
	w==
X-Received: by 2002:a17:90b:3ec8:b0:39d:e43c:5a0f with SMTP id 98e67ed59e1d1-39dec059046mr4051213a91.14.1789381886134;
        Mon, 14 Sep 2026 03:31:26 -0700 (PDT)
Received: from localhost ([106.38.226.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd6f8ebbdfsm5362385ad.38.2026.09.14.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:25 -0700 (PDT)
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
Subject: [PATCH v4 1/3] block: introduce bdev_flush_by_dev()
Date: Mon, 14 Sep 2026 18:31:17 +0800
Message-Id: <20260914103119.1708452-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260914103119.1708452-1-sunjunchao@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bdev_flush_by_dev() to submit page-cache writeback for a device
identified by dev_t without requiring callers to hold a persistent
device reference.

A subsequent patch will use this helper to flush foreign bdev mappings.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..da1fc56926fd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,30 @@ int sync_blockdev_nowait(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
+/**
+ * bdev_flush_by_dev - attempt writeback of a block device's page cache
+ * @dev: target block device number
+ *
+ * Skip closed devices or devices whose open_mutex is busy.
+ * May sleep while submitting writeback; does not wait for all I/O to complete.
+ */
+void bdev_flush_by_dev(dev_t dev)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_no_open(dev, false);
+	if (!bdev)
+		return;
+
+	/* Prevent the device from closing between the check and writeback. */
+	if (mutex_trylock(&bdev->bd_disk->open_mutex)) {
+		if (atomic_read(&bdev->bd_openers))
+			sync_blockdev_nowait(bdev);
+		mutex_unlock(&bdev->bd_disk->open_mutex);
+	}
+	blkdev_put_no_open(bdev);
+}
+
 /*
  * Write out and wait upon all the dirty data associated with a block
  * device via its mapping.  Does not take the superblock lock.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..7a5f3e2f17d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1710,6 +1710,7 @@ void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
+void bdev_flush_by_dev(dev_t dev);
 void sync_bdevs(bool wait);
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
-- 
2.39.5

