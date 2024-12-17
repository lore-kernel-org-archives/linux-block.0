Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED539142E77;
	Tue, 17 Dec 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403476; cv=none; b=YepBDKYdodxMGnffQFVp+GT5gtuQSN244bpiNkE9S1ebbRhCqRLBumd1vRwoezs8AFdf9jiCw7VKtQHD4ipheoDsfjcDARLFA6rQx9q7x6KC4yx/Ysq/f8aiGUFQ7f3Ndov3vZ/KgL8m166U7NaAWTSHZCvg8LTpnYxBkl15JEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403476; c=relaxed/simple;
	bh=KGUzL3di9Ia5YRhTXvPCVyRFD/NrCSniOiQsSTfYg1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QppYJ5TJynp9jDOPeRYKC4mAwvTuYyN1HiGSasG1tXFg1zgW/ouwFXCi6MyeIGzODTALGrvqMZN0i9UkSvMLddH1qxzHFXvasST44vqZl89QXiNt7/uY/bQ2udK77+nt5iRL6Ma6Oewk5c6RElnvL1HnnqPeQy9wG0guBdDxJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YC1NP12b5z4f3jrl;
	Tue, 17 Dec 2024 10:44:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95D411A058E;
	Tue, 17 Dec 2024 10:44:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWE5WBndhZJEw--.48443S7;
	Tue, 17 Dec 2024 10:44:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 3/4] block/elevator: choose none elevator for high IO concurrency ability disk
Date: Tue, 17 Dec 2024 10:40:46 +0800
Message-Id: <20241217024047.1091893-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYWE5WBndhZJEw--.48443S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DJw45AFWDCrWkXrWDArb_yoW8Gw47pF
	4rKwsIkw4ktFnFk3ykAw1fX3W5ta9Ygr17Wr42y345GFn7XrW7C3W5CF4rXFWxCF4fGanF
	vr4DJFWkGa4jqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The maximal default nr_requests is 256, and if disk can handle more than
256 requests concurrently, use elevator in this case is useless, on the
one hand it limits the number of requests to 256, on the other hand,
it can't merge or sort IO because requests are dispatched to disk
immediately and the elevator is just empty.

For example, for nvme megaraid with 512 queue_depth by default, we have
to change default elevator to none, otherwise deadline will lose a lot of
performance.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/elevator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 7c3ba80e5ff4..4cce1e7c47d5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -568,6 +568,17 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
+	/*
+	 * If nr_queues will be less than disk ability, requests will be
+	 * dispatched to disk immediately, it's useless to use elevator. User
+	 * should set a bigger nr_requests or limit disk ability manually if
+	 * they really want to use elevator.
+	 */
+	if (q->queue_depth && q->queue_depth >= BLKDEV_DEFAULT_RQ * 2)
+		return NULL;
+	if (!q->queue_depth && q->tag_set->queue_depth >= BLKDEV_DEFAULT_RQ * 2)
+		return NULL;
+
 	return elevator_find_get("mq-deadline");
 }
 
-- 
2.39.2

