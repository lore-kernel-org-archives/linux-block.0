Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7741B35B
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971175; cv=none; b=jFo290NkUJ1+wJNivrWDGPjCMqEv1Lq0LNTdF5XJbtbQyA2EDZztloq3mobh3U8BPEMaHREcKH5xnWEvNNNLoLxtO3Qs/+d595ZXvTxXrqX1Q8PZuoWckUj5SemhB6Y4vwSKzV1DwwW7UlSGkoy++N1SGSyjOCpL2QulncWH0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971175; c=relaxed/simple;
	bh=6ACLcLE28fJ49Ve6CULmcnQDiALUrF32mVwEqpsqDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTSuIPY2Tb7D2zGn3Oc5LySlDUFeSS6U+AMU4XNh0N/yGLehvFgO7Mw9et2AIvFI6NpfbHBr7wdX7RCJArjmD8MYxfwEHGbfv+EClWuarOuyuzGtxp5+0pXVWC5bF1AxUCsO5PBC19ESZ67QI2OdPCbnB7pnoRdhQX5qLD5/aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RARCg3Uk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RARCg3Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcpO2tW1p8Xu0HEcruHH4U7wtKrjopmLG7X44KBIGL0=;
	b=RARCg3UkqlpnWVIpLR+PVF7iyA5xHe/86DuPu4X69A31U5PUc6ixORU9bIhkvyW6MV8SO+
	2k4S8Bw1MRhAo6FhPxW8Or+CyK8lM0k2m4Jq1pbOWiRr8T4KD8TOQ6vJT3aKCrp/BppcKT
	EHG21FMeul3LQtoZxuMpoS78giSJGrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-hivuNywoN3e5Cr_Eh_Whkw-1; Tue,
 31 Mar 2026 11:32:35 -0400
X-MC-Unique: hivuNywoN3e5Cr_Eh_Whkw-1
X-Mimecast-MFC-AGG-ID: hivuNywoN3e5Cr_Eh_Whkw_1774971151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09AA519560AE;
	Tue, 31 Mar 2026 15:32:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 009C2180035F;
	Tue, 31 Mar 2026 15:32:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 04/10] ublk: eliminate permanent pages[] array from struct ublk_buf
Date: Tue, 31 Mar 2026 23:31:55 +0800
Message-ID: <20260331153207.3635125-5-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The pages[] array (kvmalloc'd, 8 bytes per page = 2MB for a 1GB buffer)
was stored permanently in struct ublk_buf but only needed during
pin_user_pages_fast() and maple tree construction. Since the maple tree
already stores PFN ranges via ublk_buf_range, struct page pointers can
be recovered via pfn_to_page() during unregistration.

Make pages[] a temporary allocation in ublk_ctrl_reg_buf(), freed
immediately after the maple tree is built. Rewrite __ublk_ctrl_unreg_buf()
to iterate the maple tree for matching buf_index entries, recovering
struct page pointers via pfn_to_page() and unpinning in batches of 32.
Simplify ublk_buf_erase_ranges() to iterate the maple tree by buf_index
instead of walking the now-removed pages[] array.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 87 +++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c2b9992503a4..2e475bdc54dd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -296,7 +296,6 @@ struct ublk_queue {
 
 /* Per-registered shared memory buffer */
 struct ublk_buf {
-	struct page **pages;
 	unsigned int nr_pages;
 };
 
@@ -5261,27 +5260,25 @@ static void ublk_unquiesce_and_resume(struct gendisk *disk)
  * coalescing consecutive PFNs into single range entries.
  * Returns 0 on success, negative error with partial insertions unwound.
  */
-/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages) */
-static void ublk_buf_erase_ranges(struct ublk_device *ub,
-				  struct ublk_buf *ubuf,
-				  unsigned long nr_pages)
+/* Erase coalesced PFN ranges from the maple tree matching buf_index */
+static void ublk_buf_erase_ranges(struct ublk_device *ub, int buf_index)
 {
-	unsigned long i;
-
-	for (i = 0; i < nr_pages; ) {
-		unsigned long pfn = page_to_pfn(ubuf->pages[i]);
-		unsigned long start = i;
+	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
+	struct ublk_buf_range *range;
 
-		while (i + 1 < nr_pages &&
-		       page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
-			i++;
-		i++;
-		kfree(mtree_erase(&ub->buf_tree, pfn));
+	mas_lock(&mas);
+	mas_for_each(&mas, range, ULONG_MAX) {
+		if (range->buf_index == buf_index) {
+			mas_erase(&mas);
+			kfree(range);
+		}
 	}
+	mas_unlock(&mas);
 }
 
 static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
-			       struct ublk_buf *ubuf, int index,
+			       struct ublk_buf *ubuf,
+			       struct page **pages, int index,
 			       unsigned short flags)
 {
 	unsigned long nr_pages = ubuf->nr_pages;
@@ -5289,13 +5286,13 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 	int ret;
 
 	for (i = 0; i < nr_pages; ) {
-		unsigned long pfn = page_to_pfn(ubuf->pages[i]);
+		unsigned long pfn = page_to_pfn(pages[i]);
 		unsigned long start = i;
 		struct ublk_buf_range *range;
 
 		/* Find run of consecutive PFNs */
 		while (i + 1 < nr_pages &&
-		       page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
+		       page_to_pfn(pages[i + 1]) == pfn + (i - start) + 1)
 			i++;
 		i++;	/* past the last page in this run */
 
@@ -5320,7 +5317,7 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 	return 0;
 
 unwind:
-	ublk_buf_erase_ranges(ub, ubuf, i);
+	ublk_buf_erase_ranges(ub, index);
 	return ret;
 }
 
@@ -5335,6 +5332,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_shmem_buf_reg buf_reg;
 	unsigned long addr, size, nr_pages;
+	struct page **pages = NULL;
 	unsigned int gup_flags;
 	struct gendisk *disk;
 	struct ublk_buf *ubuf;
@@ -5371,9 +5369,8 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 		goto put_disk;
 	}
 
-	ubuf->pages = kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
-				     GFP_KERNEL);
-	if (!ubuf->pages) {
+	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
 		ret = -ENOMEM;
 		goto err_free;
 	}
@@ -5382,7 +5379,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
 		gup_flags |= FOLL_WRITE;
 
-	pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, ubuf->pages);
+	pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, pages);
 	if (pinned < 0) {
 		ret = pinned;
 		goto err_free_pages;
@@ -5406,7 +5403,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	if (ret)
 		goto err_unlock;
 
-	ret = __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
+	ret = __ublk_ctrl_reg_buf(ub, ubuf, pages, index, buf_reg.flags);
 	if (ret) {
 		xa_erase(&ub->bufs_xa, index);
 		goto err_unlock;
@@ -5414,6 +5411,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 
 	mutex_unlock(&ub->mutex);
 
+	kvfree(pages);
 	ublk_unquiesce_and_resume(disk);
 	ublk_put_disk(disk);
 	return index;
@@ -5422,9 +5420,9 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 	ublk_unquiesce_and_resume(disk);
 err_unpin:
-	unpin_user_pages(ubuf->pages, pinned);
+	unpin_user_pages(pages, pinned);
 err_free_pages:
-	kvfree(ubuf->pages);
+	kvfree(pages);
 err_free:
 	kfree(ubuf);
 put_disk:
@@ -5433,11 +5431,36 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 }
 
 static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
-				  struct ublk_buf *ubuf)
+				  struct ublk_buf *ubuf, int buf_index)
 {
-	ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
-	unpin_user_pages(ubuf->pages, ubuf->nr_pages);
-	kvfree(ubuf->pages);
+	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
+	struct ublk_buf_range *range;
+	struct page *pages[32];
+
+	mas_lock(&mas);
+	mas_for_each(&mas, range, ULONG_MAX) {
+		unsigned long base, nr, off;
+
+		if (range->buf_index != buf_index)
+			continue;
+
+		base = range->base_pfn;
+		nr = mas.last - mas.index + 1;
+		mas_erase(&mas);
+
+		for (off = 0; off < nr; ) {
+			unsigned int batch = min_t(unsigned long,
+						   nr - off, 32);
+			unsigned int j;
+
+			for (j = 0; j < batch; j++)
+				pages[j] = pfn_to_page(base + off + j);
+			unpin_user_pages(pages, batch);
+			off += batch;
+		}
+		kfree(range);
+	}
+	mas_unlock(&mas);
 	kfree(ubuf);
 }
 
@@ -5468,7 +5491,7 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 		return -ENOENT;
 	}
 
-	__ublk_ctrl_unreg_buf(ub, ubuf);
+	__ublk_ctrl_unreg_buf(ub, ubuf, index);
 
 	mutex_unlock(&ub->mutex);
 
@@ -5483,7 +5506,7 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
 	unsigned long index;
 
 	xa_for_each(&ub->bufs_xa, index, ubuf)
-		__ublk_ctrl_unreg_buf(ub, ubuf);
+		__ublk_ctrl_unreg_buf(ub, ubuf, index);
 	xa_destroy(&ub->bufs_xa);
 	mtree_destroy(&ub->buf_tree);
 }
-- 
2.53.0

