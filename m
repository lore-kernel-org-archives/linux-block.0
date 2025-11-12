Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F192FFFA2
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940394; cv=none; b=Qm9+YrLOKBT3pWr1SyAfofnaxG4dENm1Q7YYTtTDQUG9bX/C20HhYQCmTTjX2Eiw1cuZZyTnu4WE9/reRvPhzJNkWDs8vil7YDjiHjR1ah4THhRHEa8rwMfH6Rku/r31c8JA6nTJPmRMgnc3gS5XVKf37LJeE7i5qzrkwCDHxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940394; c=relaxed/simple;
	bh=KWNFHwP2V5eTnyugi3Vxb/nZ9rIjOOFKw2M2peA9OmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRNzmV3Gz0bBI8BIs82YGqF4BrhmRrQFUqzNpmNub5DcstTMY/1UwIOgv8bxYusSFjOvetNWfGSsB03qWyocdmDHe65Zuq82AR2QMe31I5Utm8ORaFegfXzLP3rMSd7iivW0avKKmPhTjIHvx+78weG9M7+EDvAKx18rn7AcNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3wuX06b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3wuX06b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeY8RikIVqTL29w6QXtEpN3RtRWSb2qCvs8FH9UZtaY=;
	b=J3wuX06b48q19R2zL7PLJHWuBK/tD7qBf18lGHRTUwWxzxfLr98GIjDLvfk/NzX4ZBpAZQ
	jC2iQpJVYOFvnx34/B6mysU6o66QvEPDA5viwE6Xoln/0wnRGna0bZnvF9GfzY9pA7XVzr
	bov+IViFDVWXjfO5/mihZ7uNWpfjZCk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164--cmOm6FcMCO1mKwIzgUjUQ-1; Wed,
 12 Nov 2025 04:39:51 -0500
X-MC-Unique: -cmOm6FcMCO1mKwIzgUjUQ-1
X-Mimecast-MFC-AGG-ID: -cmOm6FcMCO1mKwIzgUjUQ_1762940390
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4E2519560AD;
	Wed, 12 Nov 2025 09:39:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 801621955F1A;
	Wed, 12 Nov 2025 09:39:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 19/27] selftests: ublk: fix user_data truncation for tgt_data >= 256
Date: Wed, 12 Nov 2025 17:37:57 +0800
Message-ID: <20251112093808.2134129-20-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

