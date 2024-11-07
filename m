Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653231F4286
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977359; cv=none; b=M0AsHdXiWPFeP3tFGXe/9VQHMn/7eB9H6VCKoZgl/Rt8gq+i5AOyr8CR+pjltOG6If3Djgo/kdGut1P11r3g87OwqCL89jGXDL3W96fJMyy0SrcSUOYO8W29fIs38RCCEIOabzZwGRkf1kquf0QoRkQji+rLHwd8GVF0g8q6jjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977359; c=relaxed/simple;
	bh=NQ+bwr1JB4p3kwCzYVnZV2mYuii1jbMOo79wlSQxK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+Itvkz7mIqMegkpmp5tseYpnP4NIOmT23/UiYolJ5UPKfGlk8vKHI9JMJAtgooH6FCSoSCm14aL8Z6RfgBgIN3t08veBPi5rqAOpAXE1aLC6t2yHJAOfI/bhKxCKYvCtoNP0Q9uyaEMmwXPRz0H/Q/yHh1g8h1ZxFHHi572Jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsICLdFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsICLdFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730977356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0VSqFzf1J9PU1pJLz6JPLAs1jAHK7dRkghElujlsZ8=;
	b=PsICLdFQR/eDMpvufmhBDBGCj/NTz6gMoCdJEuMuULtRAtuirMZC5dadzDyEuvdOpmSToo
	MTy4UoFZQX/pWlcpAynkwasXUEmc7rwuwuS9LFTo7Ygcjrqpl4sDO6mL6e1kDr6Gd5Xpie
	sI/Ll9sD0VjU59Ah7mZIuEut8VGV4tM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-3mZzLQx5Op2Hni-UDMWQGQ-1; Thu,
 07 Nov 2024 06:02:31 -0500
X-MC-Unique: 3mZzLQx5Op2Hni-UDMWQGQ-1
X-Mimecast-MFC-AGG-ID: 3mZzLQx5Op2Hni-UDMWQGQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4F3D1956095;
	Thu,  7 Nov 2024 11:02:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D0AE196BC05;
	Thu,  7 Nov 2024 11:02:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V10 07/12] io_uring: shrink io_mapped_buf
Date: Thu,  7 Nov 2024 19:01:40 +0800
Message-ID: <20241107110149.890530-8-ming.lei@redhat.com>
In-Reply-To: <20241107110149.890530-1-ming.lei@redhat.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

`struct io_mapped_buf` will be extended to cover kernel buffer which
may be in fast IO path, and `struct io_mapped_buf` needs to be per-IO.

So shrink sizeof(struct io_mapped_buf) by the following ways:

- folio_shift is < 64, so 6bits are enough to hold it, the remained bits
  can be used for the coming kernel buffer

- define `acct_pages` as 'unsigned int', which is big enough for
  accounting pages in the buffer

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.c | 2 ++
 io_uring/rsrc.h | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f57c4d295f09..99ff2797e6ec 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -685,6 +685,8 @@ static bool io_try_coalesce_buffer(struct page ***pages, int *nr_pages,
 		return false;
 
 	data->folio_shift = folio_shift(folio);
+	WARN_ON_ONCE(data->folio_shift >= 64);
+
 	/*
 	 * Check if pages are contiguous inside a folio, and all folios have
 	 * the same page count except for the head and tail.
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index c8a4db4721ca..bf0824b4beb6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -32,9 +32,9 @@ struct io_mapped_buf {
 	u64		addr;
 	unsigned int	len;
 	unsigned int	nr_bvecs;
-	unsigned int    folio_shift;
 	refcount_t	refs;
-	unsigned long	acct_pages;
+	unsigned int	acct_pages;
+	unsigned int	folio_shift:6;
 	struct bio_vec	bvec[] __counted_by(nr_bvecs);
 };
 
@@ -43,7 +43,7 @@ struct io_imu_folio_data {
 	unsigned int	nr_pages_head;
 	/* For non-head/tail folios, has to be fully included */
 	unsigned int	nr_pages_mid;
-	unsigned int	folio_shift;
+	unsigned char	folio_shift;
 };
 
 struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx, int type);
-- 
2.47.0

