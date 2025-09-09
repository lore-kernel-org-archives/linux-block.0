Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B3F9C1
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421205; cv=none; b=M+q+WZkPiSlxDiZi/VUPgdko+sazErg8pqwuVG+ThabBNU+sFOMq9e749UHgQXA5m0f5H0pksNrkqc5zloK4albjV9vFBmeNt23r9iBBvEsTTYL0CYyqi4Yk16cVPekV1RadGzbPQ1wV4OWCiJ2+8v+bdOra4dCn1AlyGJOHUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421205; c=relaxed/simple;
	bh=PDahZEsV2G4I/N2voHyvew6La8uMC6s78fxKcPkMBTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGrepl3k+xHvgjMAO3SQZ7wd0ZDIQmBsHr+uen4aFKD621ZvF7C6BLV1NkrtF+miYUYkDlND1YxRJ2kbsv5FOAWFv8O7CzYgkBYGKwdy0bxJfcScN1jOpjQ6hNi65WHdThppMTucyUG/0yepwdMPX4/uzmsj2C/KwZ3tKOjjxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T04vY4fD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T04vY4fD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757421201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0oUnj1HtBQcrTE3KtoBqTlc8mFx8UFNOpXuseI8rvM=;
	b=T04vY4fDCXWQetajEdAob6qS9n4ZSGku2Ldh3kSVNMGEWjva6eU+4nYnWtiqdvIXwXSHQn
	+JEwcqkcbUx0TXPryfOX6rtsAKPgKn9fNTtmA2XDgRHV8VwMceiA6apEeRgYQmDgsjr/N5
	R28AWT6D8sq7QabS5ira7aiqsqFSa/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-LclwH8NEPuqJWS88MQFmYg-1; Tue,
 09 Sep 2025 08:33:18 -0400
X-MC-Unique: LclwH8NEPuqJWS88MQFmYg-1
X-Mimecast-MFC-AGG-ID: LclwH8NEPuqJWS88MQFmYg_1757421197
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A13A119541BE;
	Tue,  9 Sep 2025 12:33:16 +0000 (UTC)
Received: from localhost (unknown [10.72.120.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF852180035E;
	Tue,  9 Sep 2025 12:33:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] blk-mq: Document tags_srcu member in blk_mq_tag_set structure
Date: Tue,  9 Sep 2025 20:33:10 +0800
Message-ID: <20250909123310.142688-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add missing documentation for the tags_srcu member that was introduced
to defer freeing of tags page_list to prevent use-after-free when
iterating tags.

Fixes htmldocs warning:
WARNING: include/linux/blk-mq.h:536 struct member 'tags_srcu' not described in 'blk_mq_tag_set'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1325ceeb743a..b25d12545f46 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -507,6 +507,8 @@ enum hctx_type {
  *		   request_queue.tag_set_list.
  * @srcu:	   Use as lock when type of the request queue is blocking
  *		   (BLK_MQ_F_BLOCKING).
+ * @tags_srcu:	   SRCU used to defer freeing of tags page_list to prevent
+ *		   use-after-free when iterating tags.
  * @update_nr_hwq_lock:
  * 		   Synchronize updating nr_hw_queues with add/del disk &
  * 		   switching elevator.
-- 
2.47.1

