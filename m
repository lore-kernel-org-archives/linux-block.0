Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36D330B04
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573227; cv=none; b=k77zTGQ1u507y6cjmVwRRBKy+ElU8PdSeCuESTCK9A5lGmSAxC24eGQsvFL3WNHiS5Zi3pRH7xvGZdh+p6UvpvLd/JsAAwEp+eKhHDswQmJyEScFRYi9Mds0VDD1l23KS//J6JhI1zKufMigBya/0cWtqg8kwrjhVkbHdaPiSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573227; c=relaxed/simple;
	bh=QVcbaKE/6yW9+Xm7aiAuDij1DUxwYSl3DZHU+9AcPMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHXM6G0GhXURBFv16ls8FqkyvmTuj6h3BeYB/TMQ4EYeiebPjBIhuRNYyzvfNdW5R9nVjRwiQ0cNsSIcQMJO91B7c6cYZMorIbL/9BqkosxuSjf927A0nD/nGr7zGo/6ZoPwojSCm2+YlUE+kQnXjFFUy1mCKrqYO91ogLVStpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWT9kaac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWT9kaac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFO2Iynpy9M7sWu1qEYZd1BP9qSZjAA0n8U4L6xJeXM=;
	b=cWT9kaacSAyDPhkVI0QmY9AeJUlRZyv9DJDEW9e+og9z0AmOywupwpMxDdWTnRWxbF3doR
	2WE6qF8HCtmepSe70l7mKYyGTnydvltK/7h/gzWt//mecjHE2OOSYkxSlJdvY3B4c5Lubr
	BJm9fz/A6khd88+fKhuiVUBzs6Cyg6U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-DHZn-oGxMyObfkEhzQVmIg-1; Fri,
 16 Jan 2026 09:20:21 -0500
X-MC-Unique: DHZn-oGxMyObfkEhzQVmIg-1
X-Mimecast-MFC-AGG-ID: DHZn-oGxMyObfkEhzQVmIg_1768573220
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ED1D1956059;
	Fri, 16 Jan 2026 14:20:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D8EB1955F67;
	Fri, 16 Jan 2026 14:20:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 15/24] selftests: ublk: fix user_data truncation for tgt_data >= 256
Date: Fri, 16 Jan 2026 22:18:48 +0800
Message-ID: <20260116141859.719929-16-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The build_user_data() function packs multiple fields into a __u64
value using bit shifts. Without explicit __u64 casts before shifting,
the shift operations are performed on 32-bit unsigned integers before
being promoted to 64-bit, causing data loss.

Specifically, when tgt_data >= 256, the expression (tgt_data << 24)
shifts on a 32-bit value, truncating the upper 8 bits before promotion
to __u64. Since tgt_data can be up to 16 bits (assertion allows up to
65535), values >= 256 would have their high byte lost.

Add explicit __u64 casts to both op and tgt_data before shifting to
ensure the shift operations happen in 64-bit space, preserving all
bits of the input values.

user_data_to_tgt_data() is only used by stripe.c, in which the max
supported member disks are 4, so won't trigger this issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index cb757fd9bf9d..69fd5794f300 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -262,7 +262,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
 	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
-	return tag | (op << 16) | (tgt_data << 24) |
+	return tag | ((__u64)op << 16) | ((__u64)tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
 }
 
-- 
2.47.0

