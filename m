Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC12D46DD;
	Thu,  9 Oct 2025 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996403; cv=none; b=n7gAgcQiB+0bbxIGyiBI/DLxcdjLcaQg7N+KeNwJeMDi4gQ/GsphGquSp8IkjnK8D33aU0fcZZOzZF0RYx6c6mt7YYQLyhfhqBXL89IFPgVgvKuXKftykKe99uEdMQyojKoC3cQEf8DT4gQXLlTm/ZaHWEtlxd6FGBTfkjqdL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996403; c=relaxed/simple;
	bh=DWJV6xc4X74tdFQ7VC3xAlPi68hmaXItok1qFJhL6Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAHoS50VZxnnNbZHcaFFwf1o735Yv8y8bwep/m30sCzTe52kZqDGLw2E1IKhAeXwq3rhHOREwPYoc3iKeEW0rgK6Yi3qYcHSSUTbBcPeiB7OtKbQn9Wf4JHh4VpKkdUqoSv/mUpLSHJzowvnzS5JCEURcn0yAo4V7OiHonTEFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Cz61m2zKHMh1;
	Thu,  9 Oct 2025 15:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61CBE1A15C8;
	Thu,  9 Oct 2025 15:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHqaedo7Fo7CQ--.38248S11;
	Thu, 09 Oct 2025 15:53:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	jmoyer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [patch v2 7/7] blk-mq: add documentation for new queue attribute async_dpeth
Date: Thu,  9 Oct 2025 15:46:34 +0800
Message-Id: <20251009074634.527661-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251009074634.527661-1-yukuai1@huaweicloud.com>
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHqaedo7Fo7CQ--.38248S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7Xr4rAF1kJw4kXF1DZFb_yoW8ur1Up3
	yrtr47Ka4rXF17uryfAr1S9r4ft395Xr17Grsxt3WUXr98uwnrGFZaqr45XFn7ZryfJw4j
	9rWDuF98Ga42yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Explain the attribute and the default value in different case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ed10aeff86b..aa1e94169666 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,40 @@ Description:
 		enabled, and whether tags are shared.
 
 
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] Controls how many asynchronous requests may be allocated in the
+		block layer. The value is always capped at nr_requests.
+
+		When no elevator is active (none):
+		- async_depth is always equal to nr_requests.
+
+		For bfq scheduler:
+		- By default, async_depth is set to 75% of nr_requests.
+		  Internal limits are then derived from this value:
+		  * Sync writes: limited to async_depth (≈75% of nr_requests).
+		  * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).
+
+		  If a bfq_queue is weight-raised:
+		  * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
+		  * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).
+
+		- If the user writes a custom value to async_depth, BFQ will recompute
+		  these limits proportionally based on the new value.
+
+		For Kyber:
+		- By default async_depth is set to 75% of nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+		For mq-deadline:
+		- By default async_depth is set to nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-- 
2.39.2

