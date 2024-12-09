Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483D2206A5;
	Mon,  9 Dec 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745517; cv=none; b=eM+ujrenuf9CZfkymLZWD6IsCh+a2IB1VEOzQkobb//Ob8BFlRU6WLpBflhAV3S35EMgeLHNNrUmvUP2uPpOUxndDx1SiHQuVqr3c8hDWt+LkCqOSMgwAhLDZ9jJjEj2bG/SQDMBHCL19k8DQks4gfX2ee+k8k3ZXtktCfigDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745517; c=relaxed/simple;
	bh=nEhtg5q1cwzEyyWc0/SJjINGkUljcKmGB9BjRlmICos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n//vy1bDs9EyLqd34GjZbY1jeDtmU7gO54oT8LY5V8YG6F1qILbdR4mb1BULV94pEbsKgzEwHh/rMNz9PPOl3dY+IC3e3NPhoDixzS+lC9GpprLdwjF/PmpOtnNS1oLIRPlxegcHP3ffwWTKA0CyhlHzSGJNWjnFR4ATKCo2Ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6L3Y1nxJz4f3kJx;
	Mon,  9 Dec 2024 19:58:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6B8181A018D;
	Mon,  9 Dec 2024 19:58:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dk21Zn1extEA--.18505S6;
	Mon, 09 Dec 2024 19:58:31 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	yang.yang@vivo.com,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 2/3] lib/sbitmap: don't export sbitmap_get_shallow()
Date: Mon,  9 Dec 2024 19:55:21 +0800
Message-Id: <20241209115522.3741093-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4dk21Zn1extEA--.18505S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fGr1kJw1kXFyUCryrCrg_yoW5Gw1rpF
	4xKF17GryFyryUur1DXrWDZFy5Jw4DJrnxGF1S9F1FkrWUJanaqrn5CFW3t343uFWFyFW3
	CFWF9ry8Kr1UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v2
	6r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Because it's only used inside sbitmap.c.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/kyber-iosched.c   |  2 +-
 include/linux/sbitmap.h | 17 -----------------
 lib/sbitmap.c           |  3 +--
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4155594aefc6..2cb579b288e1 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -159,7 +159,7 @@ struct kyber_queue_data {
 
 	/*
 	 * Async request percentage, converted to per-word depth for
-	 * sbitmap_get_shallow().
+	 * sbitmap_queue_get_shallow().
 	 */
 	unsigned int async_depth;
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 189140bf11fc..e1730f5fdf9c 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -209,23 +209,6 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
  */
 int sbitmap_get(struct sbitmap *sb);
 
-/**
- * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
- * limiting the depth used from each word.
- * @sb: Bitmap to allocate from.
- * @shallow_depth: The maximum number of bits to allocate from a single word.
- *
- * This rather specific operation allows for having multiple users with
- * different allocation limits. E.g., there can be a high-priority class that
- * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
- * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
- * class can only allocate half of the total bits in the bitmap, preventing it
- * from starving out the high-priority class.
- *
- * Return: Non-negative allocated bit number if successful, -1 otherwise.
- */
-int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth);
-
 /**
  * sbitmap_any_bit_set() - Check for a set bit in a &struct sbitmap.
  * @sb: Bitmap to check.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d3412984170c..9d4213ce7916 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -287,7 +287,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
 }
 
-int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
+static int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
 {
 	int nr;
 	unsigned int hint, depth;
@@ -302,7 +302,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
 
 	return nr;
 }
-EXPORT_SYMBOL_GPL(sbitmap_get_shallow);
 
 bool sbitmap_any_bit_set(const struct sbitmap *sb)
 {
-- 
2.39.2

