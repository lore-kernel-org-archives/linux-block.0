Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45C84A28
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027033; cv=none; b=uWs3qor8Hc7veifF6430hLekDX4k4fUlsHM3jCabvM5mgXeftiU5BYG91VHUMi49DCLGA7BOhY9UMvkYNZtCZTXLF4utVoSZQRip8zfAUHGjt9cOvImtJxQuVKVxquvuuIX6zfEhg4MdNRO0yqi5I1SAAHwKUVHIlZZV5Ok9AvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027033; c=relaxed/simple;
	bh=zD4+8tbohlFHEzb5tUKTT4uUf+A/sI7eu8ositg8s7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXA42tbwEHcNPKPeGiPizkPO64/bxkciResZQ200SEyrjcROKc7m89IfW8OLvjBX0JtdGEHCkz7VhkrrpT+VG9Eh1CSoUqc5tYkZDcCyF0BXEAC8Pu/YXc3i0IveQeLC55VbgwW147BjaPKagrsrMjtW3nLmNNx43mkkH/47ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKYcT80M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKYcT80M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711027031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rn8bNMSccEmumn94xJf1/fEqHPHw726f5zCZC/Xe6Hk=;
	b=NKYcT80MYHxuNheGXu+eD4vrKqXYO71bN2YKit+Xy5te0sJp1P4m/QcybB1bf8FVns6hWZ
	3uOzpviKV7WveTXA3LDERXApm/5jFKwLg/KMU96s5bTrCDFmV52nP0PSjybrnp2zRARhWJ
	CG+HymOLOAovu6l7ZSAMI4nuy4leui4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-6hZ5FRbMOwC7J4XXbTSc2A-1; Thu, 21 Mar 2024 09:17:06 -0400
X-MC-Unique: 6hZ5FRbMOwC7J4XXbTSc2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78FB6101A526;
	Thu, 21 Mar 2024 13:17:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82BF33C85;
	Thu, 21 Mar 2024 13:17:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Date: Thu, 21 Mar 2024 21:16:34 +0800
Message-ID: <20240321131634.1009972-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

For any bio with data, its start sector and size have to be aligned with
the queue's logical block size.

This rule is obvious, but there is still user which may send unaligned
bio to block layer, and it is observed that dm-integrity can do that,
and cause double free of driver's dma meta buffer.

So failfast unaligned bio from submit_bio_noacct() for avoiding more
troubles.

Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..b1a10187ef74 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -729,6 +729,20 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct(bio);
 }
 
+static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
+{
+	unsigned int bs = q->limits.logical_block_size;
+	unsigned int size = bio->bi_iter.bi_size;
+
+	if (size & (bs - 1))
+		return false;
+
+	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
+		return false;
+
+	return true;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -780,6 +794,9 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
+	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
+		goto end_io;
+
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		bio_clear_polled(bio);
 
-- 
2.41.0

