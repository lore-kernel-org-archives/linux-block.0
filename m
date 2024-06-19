Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF651CA89
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768100; cv=none; b=STFeUP1wEWotRT45ExgRqsXeuaXuRdFq7wqn5wNc2qysoCgenWrDV9H98384ZDfyDHcp0xrVU0CwZq5W8T2iCi7mD/xhXFaZi25jdUQy0K3lA/UpycP4B7rS+B0zKl+m13CszMSwvhKMBElfispgKEgxz8zvZ/e6CT09oyaVaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768100; c=relaxed/simple;
	bh=uUXc0LJNKs/vFo3L/r/u2J1QJ3gHT37bVcCa13HtFD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCDE66mekmaP8njzzCJ05NKHkP3oQK+YRX3EtV2f9z/YuVsS2bDOcAX9DoZD/n/3EHE8Prm6QXLxD2DpsZBx1HkEytSW3a2tM0AXCrSp0gZK/te1BLt1Lcjg9A9ClGPFNvZHHVQ+psiwatNi5Lvfa2jgvOAzuzEghEKoHz3hsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkqvrA5n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkqvrA5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718768097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q7yFKsN0T5sglge4djOlJzENEPOGUu/F3+tbN8T1RGA=;
	b=YkqvrA5niVZZskf+OZfWkPI5s2MPD9lwh6dvLNpYltveNHFkZHvA8yAePGZUkU5VhcL6Cn
	WqVKaa0KA2IoHoFuf7GzNJunB+Q6Dqv48x1Znq12XcVM5xueLRIugGVfWah6aJxWMY467u
	c6gTuVTOoASo+P6VPB8oqbfG3wOVXc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-7hsdMjM-M1ag1Wcc8YTjjg-1; Tue,
 18 Jun 2024 23:34:54 -0400
X-MC-Unique: 7hsdMjM-M1ag1Wcc8YTjjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22BFF195608C;
	Wed, 19 Jun 2024 03:34:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A07481956053;
	Wed, 19 Jun 2024 03:34:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ye Bin <yebin10@huawei.com>
Subject: [PATCH] block: check bio alignment in blk_mq_submit_bio
Date: Wed, 19 Jun 2024 11:34:43 +0800
Message-ID: <20240619033443.3017568-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

IO logical block size is one fundamental queue limit, and every IO has
to be aligned with logical block size because our bio split can't deal
with unaligned bio.

The check has to be done with queue usage counter grabbed because device
reconfiguration may change logical block size, and we can prevent the
reconfiguration from happening by holding queue usage counter.

logical_block_size stays in the 1st cache line of queue_limits, and this
cache line is always fetched in fast path via bio_may_exceed_limits(),
so IO perf won't be affected by this check.

Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ye Bin <yebin10@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..7bb50b6b9567 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2914,6 +2914,21 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	INIT_LIST_HEAD(&rq->queuelist);
 }
 
+static bool bio_unaligned(const struct bio *bio,
+		const struct request_queue *q)
+{
+	unsigned int bs = queue_logical_block_size(q);
+
+	if (bio->bi_iter.bi_size & (bs - 1))
+		return true;
+
+	if (bio->bi_iter.bi_size &&
+	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
+		return true;
+
+	return false;
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2966,6 +2981,15 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
+	/*
+	 * Device reconfiguration may change logical block size, so alignment
+	 * check has to be done with queue usage counter held
+	 */
+	if (unlikely(bio_unaligned(bio, q))) {
+		bio_io_error(bio);
+		goto queue_exit;
+	}
+
 	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 		if (!bio)
-- 
2.44.0

