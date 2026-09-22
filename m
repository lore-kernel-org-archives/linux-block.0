Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8435476EF
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081426; cv=none; b=AClR05rsJfCR74dgNOa2dCrHaglHEkm1iszCOnCv5LRfqy6ATk+l5kYRzo6uBvPL/6v0YDiWfxGRaKh491mdqBmR9zJI5YLITssL5uT+rCLIhRkvdptyErHCtZS5O5hiTugtmhUsPG70pGXBtO2AeRPNWtkUzFerkvxHfYI54aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081426; c=relaxed/simple;
	bh=OVbvIeLOhqJ42EW9bnbliI0g3ZbEXa6dKvfmz4becr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZKpBnsiwTB4X70IurSVXggBrWvmar4ZZ2BXekXmS2W1kbbIXHheHNA3ZujRotW1MMStsuBgdUgot91M9MUyoi/nuBZYmqTM02+lFQYFLOQP0sNhApEWF02rrhOWq30C65/lDrUBQu3651GBk+yrHWdynldKedq9C/Oni/SkqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fNPXUBGf; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fNPXUBGf"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso3891674a91.3
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790081425; x=1790686225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMP+BFq9ZlWmX2QdHDpHEHKHpmhLYaMmTYZYw81jZH8=;
        b=fNPXUBGfzH0gPOUq37G6KTLE1YJMhY7UxJzDsEM53X+WHTVHZW68mBeC3+nQ0fj/7h
         dF1BcQzEB52Q9B4L1UuVPWENPx7XKVn3cGOQZmW4cH/1/RgSGQiSMZ4EEvaNMw6XuCFg
         F0e6OvgldDdUrVyrB5xZaBEmg3hrb/4yglK42uPr2GWUXndQvPJ5PCUqzZV8ByLKdb41
         dbdFvVJHN24ffHjmLpqOv33wLqHWoQWdbvUgCs1GfzfWaRGQ9XcJIhPQgydzOylvZTGk
         Zg+E1O97hjlZXwa8TwOQhKN3QT1Wf3GSVD8TXjPmEgZOUB+YM9JUWTmEuyIowOvMkrm7
         lm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081425; x=1790686225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QMP+BFq9ZlWmX2QdHDpHEHKHpmhLYaMmTYZYw81jZH8=;
        b=MUyxqSj+HhLHXLj5JhQlRlwX5xZlPwTJFNl+iDrzBHasDqEU9k+O2FAVHcYgeOrCci
         bmN/fXtCmvGjJceSQmBALBUntEy/yuLkVKG5fc64S6dZ1B0kdQU/cZagfCAmImlidpgf
         XGWuBScLGXH4QfTwWx5mcZ29tBPoz8ZC8yYxz312nZyZWbQgOXc3m88hNQDv7QnE8m6w
         AkB5oC68GWimuaeQPCUHokigECVLa4XIIurKmsnu7WJZM3ihZpUhyRb9XVO3+igXCar6
         k9nkQ/Q350sJyHt76JvrXJTM0yMuj+KqlBnhDjKMhWgViSgdttsXhjHBh9XvOPonDCYc
         noUg==
X-Gm-Message-State: AFuF++kr/wNgVqRT8O1rQs5XZwZwVWhW3fgS/mp91kSZp6spf5Ty9qvA
	mG1O8GpnT+Z0a84NGjsxptGwzD1B3BYTl9sloSRSHjUv11e6lKxrdAlaymzLw1ph24014iBhiar
	qshcWaZI=
X-Gm-Gg: AYBFou3XEzDctP0rp7KML2XlIZVfscVkxB8LWEYsoac3M/7MBHiieSCZF41cP3iv1DQ
	vMjV38wOS8JnRqBd/Y5X9K+v2kYzkbiKDy27LexqJQYb3VnuwHf2NEALO1R+0+RMQPgSygnO6yx
	X5T1a6KpXH4WiprH6/E9BA+Hwv2cmdX8JIM6gm10mxPqZbhtjfJMig4/eaBmrSRTPMUqG2c5zB3
	Qd3T2LQGmfFVGhljnB6HMFzOh5cqZzfvUEopkBkr7OOFAo1Lybbsj0iaK89wLWNMERsJUkxmIGG
	z+LVfz/2eLX56yh6KQSfxJXwhDMFWNCAhzJ/LA0ELOZSPmTujGhqilRkKpqPZIvIQXpEguw0VeH
	UvXhwzjA+6+t1Mo2taxGp6bU7aXW2vPNYOqGXpuL8bFcu+pukpxoOr3xBS0kkKPZI8dqYj2gxsG
	HZGh4aIMGehE+KwOu1FeL2krppRbOwGGEDIu4qSMP9gcLYjtWTzfcYp4XJeuZMmhtepSX1SPTdr
	w==
X-Received: by 2002:a17:90b:2e0e:b0:39e:6a7f:eef0 with SMTP id 98e67ed59e1d1-3a0731ef86fmr1186255a91.21.1790081424649;
        Tue, 22 Sep 2026 05:50:24 -0700 (PDT)
Received: from localhost ([106.38.226.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06702167esm4845702a91.1.2026.09.22.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:50:24 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v8 1/3] block: introduce bdev_flush_by_dev()
Date: Tue, 22 Sep 2026 20:50:13 +0800
Message-Id: <20260922125015.3435215-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260922125015.3435215-1-sunjunchao@bytedance.com>
References: <20260922125015.3435215-1-sunjunchao@bytedance.com>
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
 block/bdev.c           | 18 ++++++++++++++++++
 include/linux/blkdev.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..c7c192af6262 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,24 @@ int sync_blockdev_nowait(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
+/**
+ * bdev_flush_by_dev - attempt writeback of a block device's page cache
+ * @dev: target block device number
+ *
+ * May sleep while submitting writeback; does not wait for I/O completion.
+ */
+void bdev_flush_by_dev(dev_t dev)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_no_open(dev, false);
+	if (!bdev)
+		return;
+
+	sync_blockdev_nowait(bdev);
+	blkdev_put_no_open(bdev);
+}
+
 /*
  * Write out and wait upon all the dirty data associated with a block
  * device via its mapping.  Does not take the superblock lock.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..27afe3ff6fb5 100644
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
@@ -1726,6 +1727,9 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 {
 	return 0;
 }
+static inline void bdev_flush_by_dev(dev_t dev)
+{
+}
 static inline void sync_bdevs(bool wait)
 {
 }
-- 
2.39.5

