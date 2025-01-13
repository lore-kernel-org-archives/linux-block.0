Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72C233D90
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757710; cv=none; b=igiVUrIwB50QbnPwr8ncBxa7b60fNeZwk3SF3NqlwgnmbmJIfur0oLheavYMEea5t+jfRBmN8+VdmetDOkodXErfC/lf37JpKs6aAf183FuiGLLBKDj56SnCFrgtle72RgZjd8di5ArBeZIZtn3n/XQeU263cBSuH8s2GxG4uxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757710; c=relaxed/simple;
	bh=/cxzzrN7/GzaCbkjS70CNzuy4PcXFzOJwq1zTpZiqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSNm5ePVrF5LAi9493RbWva2CDslFfvqqs8PcASPHTRkdLBNG27cW1LJYWvISYlVVZNBkufAgfFu9yiUhghmPNwCzkAvZIzlcP/h1iBTnkQHZ1i2uUkDdVBq4EjTvd/PCpkPQs2mrkP/a+YPxFRty4kAgj6p5OhWgG8Tn4dGnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuD+jpoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuD+jpoa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736757707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gCSKRehdPVlRSB0gi9q64eOYrcUlvnOEgFN0OKryN3E=;
	b=UuD+jpoaD6r6aL292OmKJcawPz14KaojHYxsFcdclkue216eW/oOZEaaUo3vTyTkx9xIXt
	QdJYzNjk/IAimrulFl7jNY4bhV1rvKMM3Y4Wl76oy4Os5fX25itiN5jI8wMiWEOuhXK7XG
	UwHDKBnINZ4vda0kyW7FVprxtStiroE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-yMFvgeimOMeg9UV1yR8WpA-1; Mon,
 13 Jan 2025 03:41:44 -0500
X-MC-Unique: yMFvgeimOMeg9UV1yR8WpA-1
X-Mimecast-MFC-AGG-ID: yMFvgeimOMeg9UV1yR8WpA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D99A1195606B;
	Mon, 13 Jan 2025 08:41:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7241019560AD;
	Mon, 13 Jan 2025 08:41:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V2] block: mark GFP_NOIO around sysfs ->store()
Date: Mon, 13 Jan 2025 16:41:03 +0800
Message-ID: <20250113084103.762630-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

sysfs ->store is called with queue freezed, meantime we have several
->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
memory with GFP_KERNEL which may run into direct reclaim code path,
then potential deadlock can be caused.

Fix the issue by marking NOIO around sysfs ->store()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Closes: https://lore.kernel.org/linux-block/ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com/
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add Closes & Reviewed-by & Fixes tag

 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e828be777206..e09b455874bf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -681,6 +681,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
+	unsigned int noio_flag;
 	ssize_t res;
 
 	if (!entry->store_limit && !entry->store)
@@ -711,7 +712,9 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	mutex_lock(&q->sysfs_lock);
 	blk_mq_freeze_queue(q);
+	noio_flag = memalloc_noio_save();
 	res = entry->store(disk, page, length);
+	memalloc_noio_restore(noio_flag);
 	blk_mq_unfreeze_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
-- 
2.44.0

