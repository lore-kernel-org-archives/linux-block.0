Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B324E4AC
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350472; cv=none; b=J45YL/v1clSoh+Yz5DE2s3BDwWRkSWVU+cmuq6yP5973wOqcRo/WXC2jp3vHDiRTYCfRgoef1+yBNizIKaOoQb2V2ve6bcmqYvGGTXAmonS9QR2UTs+tv97q4M+CrY1gX+vizPgruIkf0avbRK/ji6YFDXzX4h3IF6TtDvqn12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350472; c=relaxed/simple;
	bh=+5Xhfs9rZEQGqW1TT/AiycBskDwBVmm7pGGoeyigWpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=majcxzIKTievvcVjsd5ascNyGrp64DIOipDOuUi82luTWQJH9udjY3kjg8jL3FNU763h/k2mo77as2AgZp4nRMul3zgLLMa+/xFlrR6Aqf8101QS/Fy7AsHZNyR6iXX46DOpxUQ5JheISciHjWkQfxFRo+wUoacEVt039RWfw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWuL4U8U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWuL4U8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742350468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=drA09f/Lc9lvDjcplUj+rDTu/zwojtJfINVq4Zirxp0=;
	b=BWuL4U8U39mOxxDVTdqhhaxCYErgxWRcDXMpJvJl6VXH/A5fIwOeXy0c44r/dgeXV8h38i
	IFZOgItnDj1iwLP1oRShuHaURaf8uuPw8yLV3SkcZyqP2BL+cgkFLU9WXO+CmfxA8sL0HI
	fx8Ka6j1/CjwwiZMR21yMHE+bLciWxg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-u7769SsSNCytGBV7Xnonlw-1; Tue,
 18 Mar 2025 22:13:55 -0400
X-MC-Unique: u7769SsSNCytGBV7Xnonlw-1
X-Mimecast-MFC-AGG-ID: u7769SsSNCytGBV7Xnonlw_1742350431
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F5819560B3;
	Wed, 19 Mar 2025 02:13:51 +0000 (UTC)
Received: from localhost (unknown [10.72.120.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5839C3001D0E;
	Wed, 19 Mar 2025 02:13:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: don't define __blk_mq_end_request() as inline
Date: Wed, 19 Mar 2025 10:13:42 +0800
Message-ID: <20250319021343.3976476-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It doesn't make sense to define one global symbol as inline, also this
way cause __blk_mq_end_request become not traceable.

Fix it by removing the 'inline' annotation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..1301965dae71 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1123,7 +1123,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 	blk_account_io_done(rq, now);
 }
 
-inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_mq_need_time_stamp(rq))
 		__blk_mq_end_request_acct(rq, blk_time_get_ns());
-- 
2.47.1

