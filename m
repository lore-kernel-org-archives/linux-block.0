Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC7221282
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150091; cv=none; b=pmrYwzy37WBzAApd4IpcDQ0TyMGh16Pu+LveKqI4cg53WpMd38ujv6XSNiyYLH8umniDd4RjFlC/StlU1v9gU+ozs8492o2WlUAYoaGMKQOTIy2ZZ0Zor+Rnzn+I3hx7vhoLThGVezx4P0jHMraMRu0kWuHGdznOFuzngrrYMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150091; c=relaxed/simple;
	bh=Adc/gGOQhKQ7iKHAIQg0d2G/OCsfV4g86heNR+UaMz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxqlJfUMPp8XppW715tcDH8DQffV/A5ZFAbzBjFETpFnjshw2TuTWWjWpIUpQtRHpNS3H0z0I63bZP1pvIpGr+Nw6hYTU4icMuYXEec0OKrXIHo8Z6WhS+/5kMHLDJkemWe199vFqYsefCzcmhuabOndxMrIMmiPThUUcX0yMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i82JLzSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i82JLzSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767150089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSEBKVXerWmpVQLRf+Hq5xLIOFc46hGGm9aUmXEaGuk=;
	b=i82JLzSWqom+WQ/EYXXDea9JnsagNFT5iSzzURSyUcomg+JYNClNB3rUS8Axg8puV/c08p
	m6QbNdBnnvj+acP10+diLu8RWcDpzoyBViDMUU2Cvt0h+ENdi01ZyKa7Q0skv2H1GWHYZx
	Ygh6pKxmDKd92i/0hP8Q4dvT4k78VEQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-qPkN10iZPmOTu4kKbsCcnQ-1; Tue,
 30 Dec 2025 22:01:24 -0500
X-MC-Unique: qPkN10iZPmOTu4kKbsCcnQ-1
X-Mimecast-MFC-AGG-ID: qPkN10iZPmOTu4kKbsCcnQ_1767150083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB4818002DE;
	Wed, 31 Dec 2025 03:01:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51ADE18004D8;
	Wed, 31 Dec 2025 03:01:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] io_uring: remove nr_segs recalculation in io_import_kbuf()
Date: Wed, 31 Dec 2025 11:00:57 +0800
Message-ID: <20251231030101.3093960-4-ming.lei@redhat.com>
In-Reply-To: <20251231030101.3093960-1-ming.lei@redhat.com>
References: <20251231030101.3093960-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

io_import_kbuf() recalculates iter->nr_segs to reflect only the bvecs
needed for the requested byte range. This was added to provide an
accurate segment count to bio_iov_bvec_set(), which copied nr_segs to
bio->bi_vcnt for use as a bio split hint.

The previous two patches eliminated this dependency:
 - bio_may_need_split() now uses bi_iter instead of bi_vcnt for split
   decisions
 - bio_iov_bvec_set() no longer copies nr_segs to bi_vcnt

Since nr_segs is no longer used for bio split decisions, the
recalculation loop is unnecessary. The iov_iter already has the correct
bi_size to cap iteration, so an oversized nr_segs is harmless.

Link: https://lkml.org/lkml/2025/4/16/351
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 41c89f5c616d..ee6283676ba7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1055,17 +1055,6 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
 
 	iov_iter_bvec(iter, ddir, imu->bvec, imu->nr_bvecs, count);
 	iov_iter_advance(iter, offset);
-
-	if (count < imu->len) {
-		const struct bio_vec *bvec = iter->bvec;
-
-		len += iter->iov_offset;
-		while (len > bvec->bv_len) {
-			len -= bvec->bv_len;
-			bvec++;
-		}
-		iter->nr_segs = 1 + bvec - iter->bvec;
-	}
 	return 0;
 }
 
-- 
2.47.0

