Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562023B62A;
	Tue,  5 Aug 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379907; cv=none; b=ADaZZfL/oDHELyE/uPQ7VGM+pjQc0Sn0o/adDfMrXmNmR0VnSZ5s5iq/5LPYn7D+8Uz75JC3Ow2ZN3MHbKAzywGP/PiKSieyMmpEVHVqKx3wJIvKutQ9MB3NHRijbKgqZNXpzIjgo+G47DbJJwdYj/vEonnHsXLACMwBcIJ4Ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379907; c=relaxed/simple;
	bh=q/5sjeAFNBbfNvxOMO2lvl/dfRK+rGzV77wHr3w1nYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkngPnatvz2txeVJna1+UeIrT3h9zJKXytF39mFmzN3UwV5sLnngiHo5IK4oiNOOxPAdsPAqIv2BpaY7RKfSCM0ZpuWAsZDQxlMzd9mUTu9zNZPWYYwtoGjns0JJTKu2igSgkxLrKAnFwPlyqddbTjn6DqnedTE7gwBnc8mMiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bx5744NT7zYQv8n;
	Tue,  5 Aug 2025 15:45:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 44A2B1A0E25;
	Tue,  5 Aug 2025 15:45:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhN8tpFoEsmICg--.25448S6;
	Tue, 05 Aug 2025 15:45:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	dlemoal@kernel.org,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 2/2] lib/sbitmap: make sbitmap_get_shallow() internal
Date: Tue,  5 Aug 2025 15:37:48 +0800
Message-Id: <20250805073748.606294-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250805073748.606294-1-yukuai1@huaweicloud.com>
References: <20250805073748.606294-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhN8tpFoEsmICg--.25448S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17AF45Xw18XF4xZryrZwb_yoW5CF1DpF
	4xKa48Gr9Yqry29rnrWFWDZF98Ww4kJFnxGFsagF1Fkrs8t3Zavrn5CFW5t343CFW8AF45
	GFyY9ryxCr1UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Because it's only used in sbitmap.c

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/sbitmap.h | 17 -----------------
 lib/sbitmap.c           | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 4adf4b364fcd..ffb9907c7070 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -209,23 +209,6 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
  */
 int sbitmap_get(struct sbitmap *sb);
 
-/**
- * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
- * limiting the depth used from each word.
- * @sb: Bitmap to allocate from.
- * @shallow_depth: The maximum number of bits to allocate from the bitmap.
- *
- * This rather specific operation allows for having multiple users with
- * different allocation limits. E.g., there can be a high-priority class that
- * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
- * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
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
index 89be98859d5a..4d91028153bc 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -306,7 +306,22 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
 }
 
-int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
+/**
+ * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
+ * limiting the depth used from each word.
+ * @sb: Bitmap to allocate from.
+ * @shallow_depth: The maximum number of bits to allocate from the bitmap.
+ *
+ * This rather specific operation allows for having multiple users with
+ * different allocation limits. E.g., there can be a high-priority class that
+ * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
+ * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
+ * class can only allocate half of the total bits in the bitmap, preventing it
+ * from starving out the high-priority class.
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+static int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
 {
 	int nr;
 	unsigned int hint, depth;
@@ -321,7 +336,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
 
 	return nr;
 }
-EXPORT_SYMBOL_GPL(sbitmap_get_shallow);
 
 bool sbitmap_any_bit_set(const struct sbitmap *sb)
 {
-- 
2.39.2

