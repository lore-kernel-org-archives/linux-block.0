Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11E375F83
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318694; cv=none; b=BXsuO4kjVK/+GWr+ybvPX31FE5xNTn3dYq4UvcE/Q9KQjX/SFWgT8BoCKv+cR4AtzNlmWjzWilAZhUfZBiJJ8iL3+U9OV5cRYCzXtfMOa2VaDSDhEifF8EXIZSR1bt1aIEOeGyURfe3Pg0d5gLjzCtOUpA482oMuQsNjoJY7twg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318694; c=relaxed/simple;
	bh=Z8emA6B01W8D0WrC1qFHBBKaSeXCTXQYsVv4X56BHHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQdEBKGM8K0GvVclET4D/KRT3RInheNPeIDjjMrPhp37myfMqfo0nDeLRSUpCu75YVhAPyZgem+gExoKlA0XnwU/P5vbJ1UiVwRVwT7SLONz26tpPRx2JifEe8YnNqd5Tg6Cq4gZlVQ1+SXTSq71gSDcShlXIEGqfX7d4yh4Kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lkEYyepy; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lkEYyepy"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0af40d240so321936a91.3
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790318691; x=1790923491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9E4G3HrBDA8sokqzu1SybUYi7yZEI+oyuX+vXgEAK1M=;
        b=lkEYyepyeNmT4cr0O1G5vFFHDc5fMXSKQkc3+5JP/oZaAiEV4Sc69a8vknbVEGPXJR
         bxeGb9iyBKlQm3ujS28HFMR5Fwrk/OMBNATAHI0D5ugtCkoIsj+Vp4fzyi3It+31yShW
         aHg5HkvV+zrRjhdh4v81su/+AZxhz1uX0QPPMgRGcu+lteFWyhOhaJtjA6haZcMbYKWl
         RtZwO3I0nnV1jPfb7DN+MUKcoPh9y3MoW0SaAWOFLK7SQ2t1IcaDICDGzhmQmR4c9Lzc
         imgQBAtRA5r70TnDWrQIQEyaNSXJRnXH4IaPKnNktrDgQK9/hApwOxviIaRIXMtzZKA6
         RkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318691; x=1790923491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9E4G3HrBDA8sokqzu1SybUYi7yZEI+oyuX+vXgEAK1M=;
        b=ckGUt2LhGKJhehb3fCqx6vlyQiY9ikNVUw97/7Z07KFZsn6WwJNpnoT9sifIFy9f7R
         EsVTE6Xmzo9pOwuaPRejJMOsXdlUKlqAuHHiV0ev6thHPVQ7gdTum5SbUlacVjf6h/9v
         pDCTKesOM0WUWiCKOINEKla0KXnhijCwFERSFS+zbgNZNqm3WHyoGGvGPHXLyEHxYyig
         R+/dBpT8r7LT80XeW0XxXdHhBxXkc5gaLJ/RrWEyxSysbc221kp5+KSUWDKv3azb06th
         2SXGoGdI1wrHtG5F4WsOP+6lA2GBgSmMHL8xxY8HejZV6giHmtKe3zRMo0Xa/8hZVAHr
         5IMQ==
X-Gm-Message-State: AFuF++m05xy9XQDnh/K9kWjiqjCbW4r/01/O7GCBo19miWL8leKA50xd
	/gXAY5TqFy4LrKcwhRw2qnLjsvCk2y1oMd4d39Po2unOBBE1d/8tMSRMP3aWi2d8WigmTTLCCBo
	GLJBl5hY=
X-Gm-Gg: AYBFou0mzVztpyLAN9Xsd037dz4vP1tXh15LXibIRgDofMIRUVO3dbD1upsORUrl8HH
	szr6m687mBBYDFddDCO73NEb2lPQHuhQuDdFA3A2/p3ASC0T4toE/S9+4HxNnMriGgvaHTKuAzK
	TxUBJgq4cJtd7TlIFE3kZ84mE1KTyFywOkCHWf4s/AdEuI24hyrWNysBWmOtlwXe8ppjSWtErXk
	cb9NMKrwNgB1Hbwsdp4TWm6VUcb2GP2MzwfUxddmwHvL/BavztqztttnuvA1PYOSe70zBCDy1Dj
	F1z9jXrcewsXYZNmAN7jG4x+NoNRYWYP79ghnnHE0qm2RF5u9EInRqajq98VvpLYujVKt3HbEp6
	ptOTYjWHyc3olCfh/IlXzgRvCt7fCGJ+vhydeGdZRzVRuC5tOE9oMVq392Il5uVbfNzf+k7hCa5
	L8s58ZeSnGsdmHGiYg+Ok0bi8elG72KnDGmo/Z1xb/991LwZpjPW4uL4yl+gV7V4TwufZdV2X/A
	ok=
X-Received: by 2002:a17:90b:48d0:b0:3a0:bbbc:6857 with SMTP id 98e67ed59e1d1-3a0bbbc6ddfmr1068552a91.13.1790318691065;
        Thu, 24 Sep 2026 23:44:51 -0700 (PDT)
Received: from localhost ([106.38.226.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm2594150a91.7.2026.09.24.23.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:44:50 -0700 (PDT)
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
Subject: [PATCH v9 1/3] block: introduce bdev_flush_by_dev()
Date: Fri, 25 Sep 2026 14:44:42 +0800
Message-Id: <20260925064444.3944820-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260925064444.3944820-1-sunjunchao@bytedance.com>
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
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

Use write_inode_now() with WB_SYNC_NONE to skip inodes already under
writeback, avoiding competing writeback passes from multiple callers.

A subsequent patch will use this helper to flush foreign bdev mappings.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..8925f81f16ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,25 @@ int sync_blockdev_nowait(struct block_device *bdev)
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
+	/* Use the I_SYNC check to avoid concurrent writeback. */
+	write_inode_now(BD_INODE(bdev), 0);
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

