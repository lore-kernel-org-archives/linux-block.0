Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65562FF178
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050335; cv=none; b=IPepQtuB0WcXRsKMKjfu0F6muRUfVVwmvVHlXZi0xk2wKmOwhdCGiu5t/osJUaLs9F79SvDxYzVjMUAExHcHfMzuZW0hafR2iTevt1YCq4EHHEDc9a4oYePmczIlwlGN8OXD6Ls47zHRj5L2Gd86nYqIuUXMcZy8ShZZMgIJKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050335; c=relaxed/simple;
	bh=sruw6xoif0VQxOVp8eam9Hmxj4iQNhnfXz1gpJWWFms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOkLdZjg7uWwgMW0Kyv1BBKAKKVlb/OT8sXCs8jsCnPqUMY7SHqIL5H6hDo1eq+ezDIlCl0Nl1doxr0JZJSzUM/v8oQKNWme22lJzntR8B5o/BNb1zbnFPQd3raCVIhHNOe0wZuJiS88OTtMvXaSXrrRb8w+gm7iPZtcsRa6/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HU4wWAOO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU4wWAOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766050332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sT7wOiPoOfi6pA6I7C0Avi3kGrrTxCs/0Na5WhsnGDI=;
	b=HU4wWAOOlP7N89/SZ+VNz0Ma6o6d+/zAjJMyaI+dMCEfMuCRFGxFCmXBFxMnIRL74qMVot
	yPa2Bx0qNcRRIf1Hl7GZHjVaSPw+pEx4JPo1cGmLNvFmtj695+KmpdUuXPhRJ3pveksGN5
	V+xMgXngAMWEAjY8zohFtxEpNdRSW6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-P3Ltx9PVOO6YV9xSdmjl1w-1; Thu,
 18 Dec 2025 04:32:10 -0500
X-MC-Unique: P3Ltx9PVOO6YV9xSdmjl1w-1
X-Mimecast-MFC-AGG-ID: P3Ltx9PVOO6YV9xSdmjl1w_1766050329
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 916231955F54;
	Thu, 18 Dec 2025 09:32:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99F5E1955F2D;
	Thu, 18 Dec 2025 09:32:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	huang-jl <huang-jl@deepseek.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: don't initialize bi_vcnt for cloned bio in bio_iov_bvec_set()
Date: Thu, 18 Dec 2025 17:31:43 +0800
Message-ID: <20251218093146.1218279-3-ming.lei@redhat.com>
In-Reply-To: <20251218093146.1218279-1-ming.lei@redhat.com>
References: <20251218093146.1218279-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

For a cloned bio, bi_vcnt should not be initialized since the bio_vec
array is shared and owned by the original bio. Instead, initialize
bi_iter.bi_idx to 0 to properly start iteration from the beginning
of the shared bio_vec array.

This also avoids to touch iov_iter.nr_segs, which belongs to iov_iter
implementation detail.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index e726c0e280a8..79d1fef8ad0f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1162,8 +1162,8 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
-	bio->bi_vcnt = iter->nr_segs;
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
+	bio->bi_iter.bi_idx = 0;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
 	bio->bi_iter.bi_size = iov_iter_count(iter);
 	bio_set_flag(bio, BIO_CLONED);
-- 
2.47.0

