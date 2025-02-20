Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D51F193D
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050268; cv=none; b=KJxw2Xc5GI7HvxWMEI9d8GROodMmYJ4E7SHKC0vBTP65336+4x7zYhp6n7V1pxJGAMkrfr03LoHFBXOmrPaTRVk/AxUDU8uGdxdOcyoX8iB1g+vxTJpY2Iw8Yy7XD0BC8UM1QTij15zx3WQzKXys4jP1VYzOMsS7LHIcYBXCfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050268; c=relaxed/simple;
	bh=m6niHDQmUFwrlh3Zebww1QpEFG0EM8UVMLBBn7X6DYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmSE03N00cJ81etkJZpvJNG1hcr3iOhM2xouAoy2NGjhrwEAtlT6tdfDoKFPagUF5851J1+L6/QgXJRBLxidvEQJG78y4G/r5uAoGBb7UJ+llN+pYtgc61WlPVKsl5CtsqwFodMtLrQ3kqiYZAGCkbM/0p5XKx8ljykFjMwirF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDamMH+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDamMH+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740050266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ijLbiFxXFFjJnCKN1ejljcUt3gz4rJZ1erGMt0P1j10=;
	b=RDamMH+QwAHyYgynJzUmbwUiOGC0pNNhF/rw9Gl37IRPhGeQQEFMJ98U696YUWdB/qcoFb
	SmSyZU0jBscqUwMtyhXWqJmMjVB2MNWYPGZ1Av7L99GYb+438Z7+XBiqqYs/toHgzyTyvd
	0GBxY37LWwHYMDqOPEFemTceaSQfF4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-XxFi03sfPjaoieytLV5rbQ-1; Thu,
 20 Feb 2025 06:17:44 -0500
X-MC-Unique: XxFi03sfPjaoieytLV5rbQ-1
X-Mimecast-MFC-AGG-ID: XxFi03sfPjaoieytLV5rbQ_1740050263
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2693019560BC;
	Thu, 20 Feb 2025 11:17:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9026519412A3;
	Thu, 20 Feb 2025 11:17:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] block: throttle: don't add one extra jiffy mistakenly for bps limit
Date: Thu, 20 Feb 2025 19:17:35 +0800
Message-ID: <20250220111735.1187999-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When the current bio needs to be throttled because of bps limit, the wait
time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
adds one extra 1 jiffy.

However, when taking roundup time into account, the extra 1 jiffy
may become not necessary, then bps limit becomes not accurate. This way
causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.

Fix it by not adding the 1 jiffy in case that the roundup time can
cover it.

Cc: Tejun Heo <tj@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..8348972c517b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
 	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
 
-	if (!jiffy_wait)
-		jiffy_wait = 1;
-
 	/*
 	 * This wait time is without taking into consideration the rounding
 	 * up we did. Add that time also.
 	 */
 	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
+	if (!jiffy_wait)
+		jiffy_wait = 1;
+
 	return jiffy_wait;
 }
 
-- 
2.47.0

