Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CE242D67;
	Tue, 14 Jul 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003179; cv=none; b=btftlMl5ynD389zfNV7CqHc4GjR4DKxgXZ0akfZ+dAFpv3q3UYDuIcm1PpGj9T/yBcjedYINxL4ZqlehtSamWLZPkN0wL9zXR2pYmBN4sM216H2ikP+9dhzExmawmdVTBJ4hiCsiwFF86OmR5mNKwy2cLeKrc4XkIXhkUU4/iAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003179; c=relaxed/simple;
	bh=Xri67HxFXKm5d9etgZfUnq6y7/OgoWlvqJl/JC3Y8GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA442HM4P0eLqfKz/OoAQ43BOyXzfJWswKLO8uRSNdvKCBvaeQ9AmPHGP//kj5w6tld7cT4rALlfd/PpIlf+yMtkfffdXSPbaY1geVCaX2IdZ/mKhlonYvCNyMqD4ZJFpagajh/kifxzRBwY7Aokj5q/GHbNxoT0ayplLgSlBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzmSm1hV5zKHMMw;
	Tue, 14 Jul 2026 12:25:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 60CDD40590;
	Tue, 14 Jul 2026 12:26:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHWHRkulVq2zKnBA--.54416S13;
	Tue, 14 Jul 2026 12:26:14 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V5 9/9] null_blk: serialize configfs attribute shows with the file-scope lock
Date: Tue, 14 Jul 2026 12:18:05 +0800
Message-ID: <20260714041805.1088702-10-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHWHRkulVq2zKnBA--.54416S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45Ww4rWw4rCFWDCw4DArb_yoW5Ww43pF
	Z8Ka45Wry8Kw17uF4293ykZa45Ww4IyFWUGry5J3WS9w1UGr9IvrZxKFy5Xa4UJ3srtrsI
	vFsxur93Ca4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The _show callback in the NULLB_DEVICE_ATTR macro reads dev->NAME and the
_store path writes it. configfs does not serialize accesses across separate
open file descriptions (buffer->mutex is per-fd), and _show takes no lock,
so a concurrent read and write on the same attribute is a data race. The
_show readers also race against writes to these fields that run after the
configfs item becomes visible, e.g. in nullb_update_nr_hw_queues().

All of those writers now run under the file-scope lock: _store takes it
unconditionally, and the setup-side writers run under power_store() which
holds the same lock. The only remaining unsynchronized accesses are the
plain reads in _show. Rather than annotating every field with
READ_ONCE()/WRITE_ONCE() across files, simply take the file-scope lock in
_show (and in power_show) as well. This closes the remaining _show-vs-write
data races with a single lock and keeps the writers as plain assignments.

configfs attribute access is not on the I/O hot path, so taking the mutex
in _show is acceptable from a performance standpoint. The dev fields
written in null_alloc_dev() and dev->power in nullb_group_drop_item() need
no locking: the former runs from .make_group before the item is published,
and the latter is serialized by configfs frag_sem/frag_dead against
attribute show/store.

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 67cd32d28887..c8487a630e1a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -345,8 +345,14 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 static ssize_t								\
 nullb_device_##NAME##_show(struct config_item *item, char *page)	\
 {									\
-	return nullb_device_##TYPE##_attr_show(				\
+	ssize_t ret;							\
+									\
+	mutex_lock(&lock);						\
+	ret = nullb_device_##TYPE##_attr_show(				\
 				to_nullb_device(item)->NAME, page);	\
+	mutex_unlock(&lock);						\
+									\
+	return ret;							\
 }									\
 static ssize_t								\
 nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
@@ -479,7 +485,13 @@ NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
-	return nullb_device_bool_attr_show(to_nullb_device(item)->power, page);
+	ssize_t ret;
+
+	mutex_lock(&lock);
+	ret = nullb_device_bool_attr_show(to_nullb_device(item)->power, page);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 static ssize_t nullb_device_power_store(struct config_item *item,
-- 
2.52.0

