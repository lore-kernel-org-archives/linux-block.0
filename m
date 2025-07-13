Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5F8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417324; cv=none; b=MRKhqL3rlp1IsSeQGwMBV46oZz3ibz5ZJLLQu0V3MWETN9kdS/XMVdKLsLgbX8aXxgk0iLAu6ab0cLzyL1M4NQ92uC+TIfpV//oDieSM6A1q+vMkn5KukQuidDcUSbopUbDe+26RWh8SwEvlocztQ1oOIIw85AK9S8DdMQyRSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417324; c=relaxed/simple;
	bh=24pbadaRsHLiOL0QC9YCl8kQ/CWcCSd9fRPgJESXqBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYbq2gORndGlj+HcLlBht7lBEMrsOrUJg9AE0Mgqiv3H8+Ul5xYRQOiiOUe3hcFI4t+3n6bMC0/oHMha3NKVlaBZbVygowJp9yU/5h1niS7gT4hxfD1ghdOdFKfxrC8E6db6SCJpyzmGnW0hZwwoXG9r86CUjN3xDo4PUpiP+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=il5Laatq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il5Laatq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1qPGbwbs4uyBLqjZmVljWcg8Bi+gvpSM0e0AK2xLSc=;
	b=il5LaatqisaAAqrD+eELi/zgh7Zhi8awKe4jamBVXZSRLtXGdovtXDTMNAmP3i/ZCWx2Q5
	DrSI7quGseHidE+6A/1TaU9cwI2cd/M2aQ7aFuplNp+rK3/SF3eaDkdtHGo+EOwLjaHidt
	+WutQy8qeLfy1oqMmZrgy61Qw9UF0EM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-f25dtomEOJGVVVBjCRjyrQ-1; Sun,
 13 Jul 2025 10:35:19 -0400
X-MC-Unique: f25dtomEOJGVVVBjCRjyrQ-1
X-Mimecast-MFC-AGG-ID: f25dtomEOJGVVVBjCRjyrQ_1752417318
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B691956087;
	Sun, 13 Jul 2025 14:35:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 476861977000;
	Sun, 13 Jul 2025 14:35:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 10/17] ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
Date: Sun, 13 Jul 2025 22:34:05 +0800
Message-ID: <20250713143415.2857561-11-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Pass 'const struct ublk_io *' to ublk_[un]map_io() since just io->addr
and io->res are read in the two helpers.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 252cae345b3a..d8b378ad6872 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -996,7 +996,7 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
-		struct ublk_io *io)
+		       const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
@@ -1020,7 +1020,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 
 static int ublk_unmap_io(const struct ublk_queue *ubq,
 		const struct request *req,
-		struct ublk_io *io)
+		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-- 
2.47.0

