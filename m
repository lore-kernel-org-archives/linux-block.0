Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE00286405
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006653; cv=none; b=QtKshMp8qADBiPhT+FStYq3XQscX2NSyVzwvULxW+bBpv378RjGSFLhYUWX0mRZK4+97UjJSzcDAachGttIWzZWpG/qAtWvKE2DcAViPkVHG99DtnggMQlsnh6IrEFL1ScWERtPz1fHsH6+F/NYPP9TYcuLCSq8IW8Yzwynp/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006653; c=relaxed/simple;
	bh=ARF+q6SIWMK6ZZ1dmTS4flee4Z6z8+CUaODiRk3O3V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pr20e/93iABiOdOO3TDHCBwLoNtXv7RzNj6pvnFAcCQFzAV/DIINSdDhpghXd56fnB9VTWLRYq1nAkuMHkDqDJE/X1n+Kru1+vrWU5e6l4UzPYjjFAW1o9QS4zBRPTeAzh5QK0e3NWcTtJd7DbvxNIH4jooCObepEqj/4NSL75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jN2zkaO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN2zkaO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775006651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bfeRfat3NRCDDazrva4FZBgePBvdEDZX4p47oiw2jlQ=;
	b=jN2zkaO7dbILHL08xdACvK/cb6Ykdgn/2yfqKKBv6+eKyQfww5uCEAv9ZPwfbofCWHrrlf
	WhsQO/D4HntmylcR/Gfe4znCVq4FFbTtUuReGoxkFpmN6qBfKBSflyHGonO1AD7xqNYw5D
	m//geJA7TAnY5EupUKMiHsWF0WkFYJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-OcproSmHPMe2KmJQYlz-cw-1; Tue,
 31 Mar 2026 21:24:07 -0400
X-MC-Unique: OcproSmHPMe2KmJQYlz-cw-1
X-Mimecast-MFC-AGG-ID: OcproSmHPMe2KmJQYlz-cw_1775006646
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FA5A19560AA;
	Wed,  1 Apr 2026 01:24:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E7BF1953947;
	Wed,  1 Apr 2026 01:24:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk: use unchecked copy helpers for bio page data
Date: Wed,  1 Apr 2026 09:24:01 +0800
Message-ID: <20260401012401.3653194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Bio pages may originate from slab caches that lack a usercopy region
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
V2:
	- update commit log (Caleb Sander Mateos)

 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2e475bdc54dd..3e329906ae19 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
 
 	len = bv->bv_len - *offset;
 	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	/*
+	 * Bio pages may originate from slab caches without a usercopy region
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

