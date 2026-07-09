Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38737403B1B;
	Thu,  9 Jul 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591970; cv=none; b=usZ4Q6rRF6wmgryLBnPNDyCDsc2mdbYLgVRfNulh6TAj0uyti6aXE2+IhVgVtefxdEp/Fc/DxLoKK4hIsMZaz1pIdeDgzecVQivTYe/pmkQbQN4GFtc8wem/HSNz4g/cqJVF7i89An9mMo0HJgvn4vl79zUv8R4JJMop1YYlxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591970; c=relaxed/simple;
	bh=3cmfbgEhlb0Wr2zehjIyaNNdgtIfBvCWH+RNz2v+mM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI0+I80S25WSr5mB+yaa8Qv+NsGlA8k0f/IOJN5mzyhoniUuHmHcU1qbSkyQQTCjyXAeg2obdqHekm+hQB5XDS4ctRNDArv22AobNrxzK4RTfccsby7v9h5uTrynd1GWm8bpP2alL1JXJ+MTe8ik++VC125/TsryikCEaMm70nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwrP20wm7zKHMcX;
	Thu,  9 Jul 2026 18:12:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 89FD14056D;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S13;
	Thu, 09 Jul 2026 18:12:44 +0800 (CST)
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
Subject: [PATCH V4 9/9] null_blk: serialize configfs attribute shows with the file-scope lock
Date: Thu,  9 Jul 2026 18:04:51 +0800
Message-ID: <20260709100452.3520482-10-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45Ww4rWw4rCFWDCw4DArb_yoW5Cw1fpF
	Z8Ka45Wrn7Kr17uF429w4ku345uw4IyFWUGrW5J3WSkw45Wr9Iv3sxKFW5Xa4DJ39rJwsI
	vFsrZr97CFWUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1aLvJUUUUU==
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
---
 drivers/block/null_blk/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index a411db6a8c40..e829b502981b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -343,12 +343,18 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 /* The following macro should only be used with TYPE = {uint, ulong, bool}. */
 #define NULLB_DEVICE_ATTR(NAME, TYPE, APPLY)				\
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
 			    size_t count)				\
 {									\
@@ -477,11 +483,17 @@ NULLB_DEVICE_ATTR(rotational, bool, NULL);
 NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
 NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
 
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
 				     const char *page, size_t count)
 {
-- 
2.52.0

