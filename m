Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0D1BC5C
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852818; cv=none; b=HlfObRk3CpGQVQgkd8l/9UTRKWWd87YPwB6qBItTZCoyJBFPR+O6oi/4RcuGN2+RkvfS1HRMuNBKfplj73S2sY9oeby0IcwRZ83zKS13w4hzebLUIH7KVDQL9UQfuID7Y2fLcGkY5TnlCbmNrTlcldWI2UjLkz34xn8B0H08ZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852818; c=relaxed/simple;
	bh=ifmPhiYZd3G3X77dawvDR+TjUVXmHhCRoy3o1ykkH9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STyDY59zvSyPZkbheWmaUa3hkxtkU615Ox3dcQLa8uTIBN/2SkutdmtcADkYY9h/KiGF09E5cUvOIqWkiWK9uCK3TWll4/z22GAW7oatAL8C/Bgt4bE1KyBxZQdX3myn9YY4vnZnNMXsLBOUkT6Sk4u9THsyoJp95q/OydlPM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbbrlJlv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbbrlJlv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718852815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hvH01bT0cMA2mKMGKnh10BbPYy2Z2/WXu0SqZM0ypJ0=;
	b=JbbrlJlveSKXA+xbe/GPTYWqtsLpmJb+beLjCCIo6usCTOKfXniYasKNHXjlTXkbjo0Oqh
	nmX5ayaWw9Mzowquj6KcfmmlNucquyUCoZfgxWRu9FZvLWLYHoKngCzZZNWWbYxfnb6WBm
	DUxqRxewwj5G7v5OWdtkBysZr6zmEe8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-F1KEVklwNkWNmxY4CHZEBg-1; Wed,
 19 Jun 2024 23:06:44 -0400
X-MC-Unique: F1KEVklwNkWNmxY4CHZEBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0331956094;
	Thu, 20 Jun 2024 03:06:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24BFA1956048;
	Thu, 20 Jun 2024 03:06:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ye Bin <yebin10@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 1/1] block: check bio alignment in blk_mq_submit_bio
Date: Thu, 20 Jun 2024 11:06:31 +0800
Message-ID: <20240620030631.3114026-1-ming.lei@redhat.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- cover any zero sized bio which .bi_sector needs to be initialized too

 block/blk-mq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..d161682ecd20 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2914,6 +2914,17 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	INIT_LIST_HEAD(&rq->queuelist);
 }
 
+static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
+{
+	unsigned int bs_mask = queue_logical_block_size(q) - 1;
+
+	/* .bi_sector of any zero sized bio need to be initialized */
+	if ((bio->bi_iter.bi_size & bs_mask) ||
+	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask))
+		return true;
+	return false;
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2966,6 +2977,15 @@ void blk_mq_submit_bio(struct bio *bio)
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

