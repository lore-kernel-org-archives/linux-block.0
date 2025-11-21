Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEC2D3EC7
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690430; cv=none; b=N+xJp8Qpmxubr5fGeZq8T5CpKsi//2euC4Ur8Ys5A1rnfpxyKtQahgeyRWJWQigXza189exVRerAGABMk+DjgJaR7SPfwKSCm20z5CawsW3lQTDdiX+qmkLzqKQtAvFUVd2wL5XqD4vZZJvFUZp0iqr496wenB4qRVmGcDWtGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690430; c=relaxed/simple;
	bh=KWNFHwP2V5eTnyugi3Vxb/nZ9rIjOOFKw2M2peA9OmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrK3QaiXHyeGdUt9wig/OkFYvA3MJ+AjyrqyoLXyYNfkAzR6WQmwFIc9wLT3nKLvspm2sge5G/O4RQTwGGDOl9gapHe1BLbt113BSLtfdn/iYgSgb/tG4/hYKSTkn1bY7PPDEcywaixf4dA+1hfuFcFHEym1aIcUcT50dxOBPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoFPuZyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoFPuZyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeY8RikIVqTL29w6QXtEpN3RtRWSb2qCvs8FH9UZtaY=;
	b=NoFPuZyFI8t07Nz0SdN17XNZZ8qYMwtIVwap/LWnKcvKTrbHv5Me+9saXvYIRLjPA0FmrJ
	FCFCyWxd1wNJPM28TNeUvro77Ss3yTatv0CnZ4HcbuwNqraiNVDMbwY8oHE+7qeoYX8+Zp
	f4kVH1/XP8+20EnXh1qQaLFo4mZ3M0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-kppmlYUFOHWeyrliy2BfaA-1; Thu,
 20 Nov 2025 21:00:22 -0500
X-MC-Unique: kppmlYUFOHWeyrliy2BfaA-1
X-Mimecast-MFC-AGG-ID: kppmlYUFOHWeyrliy2BfaA_1763690421
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4E019560B7;
	Fri, 21 Nov 2025 02:00:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28A861956045;
	Fri, 21 Nov 2025 02:00:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 19/27] selftests: ublk: fix user_data truncation for tgt_data >= 256
Date: Fri, 21 Nov 2025 09:58:41 +0800
Message-ID: <20251121015851.3672073-20-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
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
index fe42705c6d42..38d80e60e211 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -220,7 +220,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
 	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
-	return tag | (op << 16) | (tgt_data << 24) |
+	return tag | ((__u64)op << 16) | ((__u64)tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
 }
 
-- 
2.47.0

