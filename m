Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9013B590;
	Thu,  9 May 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258849; cv=none; b=S/CZQnjzxWs8j8A7HrkRPVwZbf1JSZFvt1ECMY+cXUMteFH36MW9ntdfRY0Y37+hlmdZ2HY6tgMCL+dL7qGmBU+uYbOxi/pHbSdxklBXQ5tbWsmuavIoEcliRQNT1frdh/GHLfiQwXthjXz9m+2Hfz+HRHXJnXJ7dmBDVjNVclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258849; c=relaxed/simple;
	bh=QmoRf8a9H8PmUWcazZoySbqM+LXaOXoiDKKrodtkMs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXeYqB+ogR984z/0N/fS8pqh2HcbvWRzkX/CbCX3VF6qi3+WpNCRbgYJETzzVzSJwwsEXsHpZdABq/VuCn0T9yduFWGXN5jRxUtXNeOB+CxXY3SZGLZcKCqqhaFBRVRhmiY3xk8UMLzR/C1mqtmgNQ7SFCz6raPgFOnSd5P93tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZsGp4sB2z4f3mJ3;
	Thu,  9 May 2024 20:47:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 91FE41A101A;
	Thu,  9 May 2024 20:47:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7ZxTxm7wHDMA--.34199S6;
	Thu, 09 May 2024 20:47:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	hch@infradead.org,
	mpatocka@redhat.com,
	snitzer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.10/block 2/2] block: fix that util can be greater than 100%
Date: Thu,  9 May 2024 20:37:17 +0800
Message-Id: <20240509123717.3223892-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509123717.3223892-1-yukuai1@huaweicloud.com>
References: <20240509123717.3223892-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7ZxTxm7wHDMA--.34199S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxGrW7ArW3tF47tr18Krg_yoW8uF13pF
	43GasxArWqgwn5ZF4Dtw1xuFyYgws5G34xXr13C3yavF4jqr1Sv3s7trWFqryIqr93AF9r
	uwn8uFyDWFy8C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOJPEUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

util means the percentage that disk has IO, and theoretically it should
not be greater than 100%. However, there is a gap for rq-based disk:

io_ticks will be updated when rq is allocated, however, before such rq
dispatch to driver, it will not be account as inflight from
blk_mq_start_request() hence diskstats_show()/part_stat_show() will not
update io_ticks. For example:

1) at t0, issue a new IO, rq is allocated, and blk_account_io_start()
update io_ticks;

2) something is wrong with drivers, and the rq can't be dispatched;

3) at t0 + 10s, drivers recovers and rq is dispatched and done, io_ticks
is updated;

Then if user is using "iostat 1" to monitor "util", between t0 - t0+9s,
util will be zero, and between t0+9s - t0+10s, util will be 1000%.

Fix this problem by updating io_ticks from diskstats_show() and
part_stat_show() if there are rq allocated.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8f1163d2d171..7f39fbe60753 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -951,15 +951,10 @@ ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, bdev);
-	else
-		inflight = part_in_flight(bdev);
-
+	inflight = part_in_flight(bdev);
 	if (inflight) {
 		part_stat_lock();
 		update_io_ticks(bdev, jiffies, true);
@@ -1256,11 +1251,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
-		if (queue_is_mq(gp->queue))
-			inflight = blk_mq_in_flight(gp->queue, hd);
-		else
-			inflight = part_in_flight(hd);
 
+		inflight = part_in_flight(hd);
 		if (inflight) {
 			part_stat_lock();
 			update_io_ticks(hd, jiffies, true);
-- 
2.39.2

