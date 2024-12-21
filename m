Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A471EE008;
	Sat, 21 Dec 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774068; cv=none; b=PS54UI3rf5kpl0pRiv2QNJhc+vL1DSIHhPjJeMlFbG/Zjxx7UVVHzIC5SdNMwCwRyg+b6zgNciWrNZnjYo+IXdwf9zW8SC74cZjBu87+EdVtRfPvQokiI1IHUfLm94dJOsw+78hYvhd80fb+PKFrn/3OTzuaFwqkUDolXqneIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774068; c=relaxed/simple;
	bh=D+VyYqBrXOYoTwJ6gUVziHg8UG1aSpT42BEgo63CbxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mtt2Zb2MkQRdQWmg8lDSZgG3LMxvuJB0lY8TZPt/fs+S5vRzXUke1lSzALLi8VOsd7QW5T17Lk9SV2+zckTGc9920jm5KX69x/yldaNn6BJf2NyP7Z8mg7ccSBVSswHIyoMPsTDZ1TovFxHaujybARyf/yh+iSCHtzyVG5yuSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFfRN323sz4f3jqs;
	Sat, 21 Dec 2024 17:40:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECB561A0194;
	Sat, 21 Dec 2024 17:41:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S9;
	Sat, 21 Dec 2024 17:41:02 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 5/7] block: add new queue sysfs api async_depth
Date: Sat, 21 Dec 2024 17:37:08 +0800
Message-Id: <20241221093710.926309-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S9
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4UKFyfZw1xGF4UKFWUtwb_yoW5XFy7pF
	s8JFW3Aw18tF47WryfJwn8Aw4Sg3yFgr4fJrWIvwnIyr1Iqws7Xw18JFyUWr97ZrZ5Gw47
	Wr4DJFZ8uayxXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to refator async_depth for mq-deadline and kyber.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c      | 35 +++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  6 ++++++
 2 files changed, 41 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 64f70c713d2f..3ee2fb8a5077 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -76,6 +76,39 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
+{
+	if (disk->queue->async_depth)
+		return queue_var_show(disk->queue->async_depth, page);
+
+	return queue_requests_show(disk, page);
+}
+
+static ssize_t
+queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
+{
+	struct request_queue *q = disk->queue;
+	struct elevator_queue *e = q->elevator;
+	unsigned long nr;
+	int ret, err;
+
+	if (!e || !e->type->ops.async_depth_updated)
+		return -EINVAL;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr < 0 || nr >= q->nr_requests)
+		nr = 0;
+
+	err = e->type->ops.async_depth_updated(q, nr);
+	if (err)
+		return err;
+
+	return ret;
+}
+
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
@@ -440,6 +473,7 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 }
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
@@ -621,6 +655,7 @@ static struct attribute *queue_attrs[] = {
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
 	&queue_requests_entry.attr,
+	&queue_async_depth_entry.attr,
 	&elv_iosched_entry.attr,
 	&queue_rq_affinity_entry.attr,
 	&queue_io_timeout_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8656ac4c3069..2fcc1ba39a28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -524,6 +524,12 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned int		nr_requests;	/* Max # of requests */
+	/*
+	 * Max number of async requests, used by elevator.
+	 * Value range: [0, nr_requests)
+	 * 0 is the default value, means unlimited.
+	 */
+	unsigned int		async_depth;
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.39.2

