Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B89199AD;
	Tue, 13 Feb 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809727; cv=none; b=hsysnU56Z4oQEv85IZGRIoU+KywxyLxaRZ/4Xgsw9ePVm0sF5qhmKBiBQUYnO24evUag8qaviqzrc++LlVv7zEFeBPRfvI4QPLLJwcdW+bbDnWGw8gV50d8G8cviDfEzHZtPKAVvIelnHVcz/lHea+XGCLVA0BkEtITWZSdCb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809727; c=relaxed/simple;
	bh=DqJ3yVhotqdem3USWpogfOXHwacQDgTajoI9rbiMBP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8VQrVo7fmoiyVKbqsFBzWJ6J9DzvZt7BfJ/JXvoZGqHVsC6jV+zQKn2leo9+4OlnsEbx1TtHHP0uxnaZQfcygtu86tCEdCTK/2M6dZkYQrZcLRqkxnjfPmJD2tVxGZqoHWXR7tQKQadx54OSpZfEf+s7V7IEsyhpLgp1CyM/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y5E/r/Fv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y5E/r/Fv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2ar7uAc1G22jWGawzjqLyxqJbQTxTABlLoYNg1HeWes=; b=Y5E/r/Fvl1Ku9RgtKhxY07NPQJ
	GML1ySNm1u3Ti3kv1fi33BrDRgfTRleu6ybyDBDr/Gq7Jpgdntxc+48SarbdyuFxlVjSgUxkVVxrw
	a2v+9cZ1HQLv0TrH1ZfenXpQT5/JKqrDCfWasJd7ATB61EjaY6UwCqf3rJE+7YzkM1zoXxrqfIBMl
	MYmgPm7DdnMK9nN3bu7Kf3L+4mmXtl0bEvuciTgmMZRPNkL3w7kqZ8AdyxfFNm+rq3Kwk0RaknEs0
	sRGVaX4nZc7BHchNDhBNiGxTq9bsSRBYmdXcyPHLSV0lR5PfunHV3qsnHWAZAA402j9ElzD0SxUso
	1eVPHXtw==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnK1-00000008GSj-44Df;
	Tue, 13 Feb 2024 07:35:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/15] block: use queue_limits_commit_update in queue_discard_max_store
Date: Tue, 13 Feb 2024 08:34:17 +0100
Message-Id: <20240213073425.1621680-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Convert queue_discard_max_store to use queue_limits_commit_update to
check and update the max_discard_sectors limit and freeze the queue
before doing so to ensure we don't have requests in flight while
changing the limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a1ec27f0ba4150..8c8f69d8ba48ee 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -175,7 +175,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 				       const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
+	struct queue_limits lim;
 	ssize_t ret;
+	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
@@ -187,9 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	q->limits.max_discard_sectors = min(q->limits.max_hw_discard_sectors,
-					    q->limits.max_user_discard_sectors);
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+
+	if (err)
+		return err;
 	return ret;
 }
 
-- 
2.39.2

