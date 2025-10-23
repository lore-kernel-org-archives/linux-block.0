Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4130217F
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216719; cv=none; b=SnOlXWNOp6z5V3e7PtIOP5VYtktGZeveGFk/5XkRKDPyaBWPx0AZBpvfq1n2ze43R4FFzLJpXwvlb9UpX8nUCQwnVc1yLaj/Afyf3ucSv/ltUeUOcE5/wjzdC7grxMx7sVT/Yne6/RM3rvh7biHah2Zm8bsV5abZQSPpEkcRSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216719; c=relaxed/simple;
	bh=cSDe5QNztnw3Gowj4UXnjOpBWS0981/YgcLl6+R5PXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4yrU/mdmh76dm2gt6ivZSh4xTRff8bcgJNqjOOEfC9pN5+a2lm6sFKqXH5imZ0k93sRWwBPJIFX3bHIR8FAmmFqXMobMJVQWnnPybN8ZXH6vW+ZsaqhZ6mczenk+PZjwPHOcFrxcMfpDocyfMk9C1LwVm+dEH76PGHx9isteu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAh4PQNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAh4PQNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bg4ZshUG2oh/xywBKBOc6z3kwPQ8+NkpEOaC+a2sgHo=;
	b=JAh4PQNIiPWvJosCorCbwQFWu6r4JJ7OD3CRIagVAuKA20lOIcR//y279OwsUwBdG84UJO
	AWlLhyAnsKnFjc58cybWdoaw6LiCJjuvv4g3aiBBWlKeaZhJjir0T8c9YlxKAEH3gPFHZZ
	9dLScWUu6348PsJRjKxeObOIxPzCFf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-ZaglLJX-N5iyurRwywDFkA-1; Thu,
 23 Oct 2025 06:51:52 -0400
X-MC-Unique: ZaglLJX-N5iyurRwywDFkA-1
X-Mimecast-MFC-AGG-ID: ZaglLJX-N5iyurRwywDFkA_1761216711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 757F61956070;
	Thu, 23 Oct 2025 10:51:51 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68BB730002D7;
	Thu, 23 Oct 2025 10:51:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: fix user_data truncation for tgt_data >= 256
Date: Thu, 23 Oct 2025 18:51:41 +0800
Message-ID: <20251023105141.2515921-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index f79f93e2711e..97cf6ddbec5d 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -295,7 +295,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
 	ublk_assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
-	return tag | (op << 16) | (tgt_data << 24) |
+	return tag | ((__u64)op << 16) | ((__u64)tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
 }
 
-- 
2.47.1

