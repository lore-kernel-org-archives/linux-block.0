Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83B246788
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690355; cv=none; b=f29vzytkmU4cUqzcMs+caLX3rdn0V7THAys/Iy95p5d203dCmKo7CBDOAf8cdJhpn8GMra/hcIx/rA0wgKWgurCSZGH8KLp5UHCddsO4ai7UHT1bEPEyYVTTX8HCQCF04EoZBOerXGkSIYcOu+sRwZWnS7M/yi6Le6JKfg51ScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690355; c=relaxed/simple;
	bh=A+Ci1L9h0yO7Ol7an2BcEr6Bgg9KUfw1d0OxivMPq6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD4QNjwtX5Y+DQp5n0xn4Mr+IgleV85uoeifGDEBox4lRy4SzXKC2m9wZjaW72DOr9+RZY5VCfGflSyPlkuo6JpDS19qDU1vH6M2gxXlbIOhir1TuDTIa85NRVBDeprhKggedR+3dxO46jAna2gT15qnA9KixMdYJa+G4nAL2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmmuUc2T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmmuUc2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKVrOLGglcyGcmX+exd2HinbN0ONxMUnNRMW45Q/QCE=;
	b=gmmuUc2TuRBeVe5KHLLZdQz319zFAqt1FTB3RnrbcI3GnEa/zNTt9apvWIGz7u1MHPCvrO
	J2HCqd0lbYTZp+waSeEdDWJgX0OV+fV03zPzYWoELwACZvXlIiToR+tCwBYovvWNftTjDY
	1v2B+ZXaxotFudvFjq0oKIVur7NlBGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-fFOdtJ4-MXOTTUWc3lEypQ-1; Thu,
 20 Nov 2025 20:59:10 -0500
X-MC-Unique: fFOdtJ4-MXOTTUWc3lEypQ-1
X-Mimecast-MFC-AGG-ID: fFOdtJ4-MXOTTUWc3lEypQ_1763690348
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A22961800473;
	Fri, 21 Nov 2025 01:59:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8516E30044DB;
	Fri, 21 Nov 2025 01:59:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
Date: Fri, 21 Nov 2025 09:58:23 +0800
Message-ID: <20251121015851.3672073-2-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
and define kfifo_alloc_node() macro to support NUMA-aware memory
allocation.

The new __kfifo_alloc_node() function accepts a NUMA node parameter
and uses kmalloc_array_node() instead of kmalloc_array() for
node-specific allocation. The existing __kfifo_alloc() now calls
__kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
compatibility.

This enables users to allocate kfifo buffers on specific NUMA nodes,
which is important for performance in NUMA systems where the kfifo
will be primarily accessed by threads running on specific nodes.

Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/kfifo.h | 34 ++++++++++++++++++++++++++++++++--
 lib/kfifo.c           |  8 ++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index fd743d4c4b4b..8b81ac74829c 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA node
+ * @fifo: pointer to the fifo
+ * @size: the number of elements in the fifo, this must be a power of 2
+ * @gfp_mask: get_free_pages mask, passed to kmalloc()
+ * @node: NUMA node to allocate memory on
+ *
+ * This macro dynamically allocates a new fifo buffer with NUMA node awareness.
+ *
+ * The number of elements will be rounded-up to a power of 2.
+ * The fifo will be release with kfifo_free().
+ * Return 0 if no error, otherwise an error code.
+ */
+#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
+__kfifo_int_must_check_helper( \
+({ \
+	typeof((fifo) + 1) __tmp = (fifo); \
+	struct __kfifo *__kfifo = &__tmp->kfifo; \
+	__is_kfifo_ptr(__tmp) ? \
+	__kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
+	-EINVAL; \
+}) \
+)
+
 /**
  * kfifo_free - frees the fifo
  * @fifo: the fifo to be freed
@@ -899,8 +923,14 @@ __kfifo_uint_must_check_helper( \
 )
 
 
-extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
-	size_t esize, gfp_t gfp_mask);
+extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
+	size_t esize, gfp_t gfp_mask, int node);
+
+static inline int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
+				size_t esize, gfp_t gfp_mask)
+{
+	return __kfifo_alloc_node(fifo, size, esize, gfp_mask, NUMA_NO_NODE);
+}
 
 extern void __kfifo_free(struct __kfifo *fifo);
 
diff --git a/lib/kfifo.c b/lib/kfifo.c
index a8b2eed90599..525e66f8294c 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -22,8 +22,8 @@ static inline unsigned int kfifo_unused(struct __kfifo *fifo)
 	return (fifo->mask + 1) - (fifo->in - fifo->out);
 }
 
-int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
-		size_t esize, gfp_t gfp_mask)
+int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
+		size_t esize, gfp_t gfp_mask, int node)
 {
 	/*
 	 * round up to the next power of 2, since our 'let the indices
@@ -41,7 +41,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 		return -EINVAL;
 	}
 
-	fifo->data = kmalloc_array(esize, size, gfp_mask);
+	fifo->data = kmalloc_array_node(esize, size, gfp_mask, node);
 
 	if (!fifo->data) {
 		fifo->mask = 0;
@@ -51,7 +51,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 
 	return 0;
 }
-EXPORT_SYMBOL(__kfifo_alloc);
+EXPORT_SYMBOL(__kfifo_alloc_node);
 
 void __kfifo_free(struct __kfifo *fifo)
 {
-- 
2.47.0

