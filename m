Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7613B293;
	Tue,  7 Jul 2026 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393413; cv=none; b=dX+VOch4O/9GGDoIf5hxL3ecX49MWaA2gMvqpmwsHN1cUG7+mwzsHJTWPk0wMkIAvhZWKvMiDcQ1o6GdK38hi/QywxRAzY+sq/NUFbEf2R3MIWTeyXbGCuqE9+nREoIn0YpD2vzfttmygjYRGAwkPM7SIrW0IdHhX8D0SkzRfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393413; c=relaxed/simple;
	bh=HOEMJIa67Pz8bwDtqdhP0kTjI+xPWpHSpebimqEBXLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQP0gsY5FoNb3uoVPkg+7O10jH8joNtYA0rR95zrifufGyYkdEO1kjE6WFH0Al0mS0BukCi9mbcf57ODwWnKrwrdcgu9FtoMUXMtSk6yhO1pb3URPJaK++JzlQQUnnSrTJuWi/71bDbdqB8HJJnapJcXS62g27rSNNB1vEK2jPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvQyz5RbczYQtjM;
	Tue,  7 Jul 2026 11:03:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 64F8040561;
	Tue,  7 Jul 2026 11:03:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHR8bExq6ahUAQ--.61638S9;
	Tue, 07 Jul 2026 11:03:26 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	linux-block@vger.kernel.org,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V2 5/6] null_blk: don't locklessly overwrite dev state after apply_fn
Date: Tue,  7 Jul 2026 10:55:41 +0800
Message-ID: <20260707025542.1299859-6-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHR8bExq6ahUAQ--.61638S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4ruw1xKw4DAF47GF47XFb_yoW8urW5pF
	WrKay5Kry8AF4a9w4Dtw4UXF95AF18XrWY9rW8G3W0934UArnxZr9rGFyYqr1UJ39xAw4S
	vF47WFWrJFWUWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The NULLB_DEVICE_ATTR macro unconditionally writes dev->NAME = new_value
after apply_fn() returns. For attributes with an apply_fn (submit_queues,
poll_queues), apply_fn already sets dev->NAME under &nullb_list_lock.

configfs serializes writes via a per-open-file mutex (buffer->mutex), so
two threads writing to the same attribute through separate open file
descriptions run the store callback concurrently. The macro's write is
redundant and lockless, so a concurrent store's losing thread can overwrite
the winner's value after apply_fn set it, making dev->submit_queues
mismatch the hardware state. null_map_queues() then hits a WARN_ON_ONCE and
falls back to a single queue.

Restructure the macro so that apply_fn attributes return directly after
apply_fn, and only non-apply_fn attributes write dev->NAME -- those are
only changeable while not CONFIGURED and have no live hardware state to
mismatch.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index cab51301560e..e7555c47b671 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -360,13 +360,15 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
 	if (ret < 0)							\
 		return ret;						\
-	if (apply_fn)							\
+	if (apply_fn) {							\
 		ret = apply_fn(dev, new_value);				\
-	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
-		ret = -EBUSY;						\
-	if (ret < 0)							\
-		return ret;						\
-	dev->NAME = new_value;						\
+		if (ret < 0)						\
+			return ret;					\
+	} else {							\
+		if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))	\
+			return -EBUSY;					\
+		dev->NAME = new_value;					\
+	}								\
 	return count;							\
 }									\
 CONFIGFS_ATTR(nullb_device_, NAME);
-- 
2.52.0

