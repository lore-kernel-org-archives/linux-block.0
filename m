Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F43128B8
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705441; cv=none; b=lDmyZM4BxcBAiMjgbbKvVcCsnIJABwxvOczh1WRmikObAuyaPPdUCdrLoAyhgNUR0KzMI9uLPPNg7OofrM2LTPKiWigaBdYXDio3SRF244QAQmrC0p+SxWNQNXXjzZMrU/lApWIP/eXw/2WAcDn9fkUVen2eFZz2YYN6lE0onnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705441; c=relaxed/simple;
	bh=dBS1jEN74cSP5BUBbT0mGe6DurOTRJxaG5PFnVWgcJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A47ou1W/ETv7pIUxs6l3YEP1sy8vg6NiAb9hiGwk3QUH47FUwxnV2KoKplVd1BcZZtS3L5IoqOPnSPhkproMsNYKZpsZnuj5MvDYQv8wZB8PDQYXYxxCKuKRkIfdJQQl1sUSqZUV9vqveCZE6cOx5TcwR4Yih2PXJMqhxV5jImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wuq9Obt+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuq9Obt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2eDtEhTnwnXNShIqXDKgUgJ4rYT93O28MiI6MbYUIBQ=;
	b=Wuq9Obt+nbzTwpEhN+waiqVUJ8SzZQO1nMfCabxu+0lC/zLJp2cZp/pdrBAnnxDURKQUTx
	y7EOWdejcIJz+wdffohPBgLBELBOE/7lRYaDRva3Ueek2G9zUJHWhXRZWFAkmEdbkwJaM/
	oycw9+ow9/QdofX7EA9e9CFXAPpsuEE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-K9mHE9RYMea_6pZGL0P5Rw-1; Sat,
 28 Mar 2026 09:43:55 -0400
X-MC-Unique: K9mHE9RYMea_6pZGL0P5Rw-1
X-Mimecast-MFC-AGG-ID: K9mHE9RYMea_6pZGL0P5Rw_1774705434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62BB419560AA;
	Sat, 28 Mar 2026 13:43:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45DC71955D84;
	Sat, 28 Mar 2026 13:43:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: use unchecked copy helpers for bio page data
Date: Sat, 28 Mar 2026 21:42:58 +0800
Message-ID: <20260328134258.3206825-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Bio pages may originate from slab caches that lack SLAB_USERCOPY
(e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
check_copy_size() which rejects these slab pages, triggering a
kernel BUG in usercopy_abort().

This is a false positive: the data is ordinary block I/O content —
the same data the loop/nbd driver writes to its backing file via
vfs_iter_write().  The bvec length is always trusted, so the size
check in check_copy_size() is not needed either.

Switch to _copy_to_iter()/_copy_from_iter() which skip the
check_copy_size() wrapper while the underlying copy_to_user()
remains unchanged.

Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 06ba8b441e5f..5f4a53216619 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
 
 	len = bv->bv_len - *offset;
 	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	/*
+	 * Bio pages may originate from slab caches without SLAB_USERCOPY
+	 * (e.g. jbd2 frozen metadata buffers).  This is the same data that
+	 * the loop driver writes to its backing file — no exposure risk.
+	 * The bvec length is always trusted, so the size check in
+	 * check_copy_size() is not needed either.  Use the unchecked
+	 * helpers to avoid false positives on slab pages.
+	 */
 	if (dir == ITER_DEST)
-		copied = copy_to_iter(bv_buf, len, uiter);
+		copied = _copy_to_iter(bv_buf, len, uiter);
 	else
-		copied = copy_from_iter(bv_buf, len, uiter);
+		copied = _copy_from_iter(bv_buf, len, uiter);
 
 	kunmap_local(bv_buf);
 
-- 
2.53.0

