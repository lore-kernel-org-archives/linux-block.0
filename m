Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB679E1
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824418; cv=none; b=uYrDrbGyPGnSw/76P2i05/jtRnHjd4IDOAaNDDATfSf6kKqrqqyY6fQcgYOml5ikrE9gc5uIARhSeVZNMp5uiF81jfRnbXHe1Ml9foRljrg/AT/1+gsuOnrv+zavU92x2t5vRDJs0+2y0cLYdhMDPsc0tFhBFkwC0hRBAxmgCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824418; c=relaxed/simple;
	bh=4yKJZGIADXEL6IMCwFp1IXjxf7YVdLWjyGJQu6FHsJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PTtsAsIqNJjKsWzhT/T/OHwEg7b2a6Wd0xlAXvtRhoFgBN3QDtOaFdWVgfdnly16b5+PR3UiJnV9DGDJ+W5cVWns204+s2Dbyf0coVtHhcbQMr1ORA/owrpVkVWQ5T6SkKWG6lxkCpsjuUuUa+q9vfq5Kegin3606xzAnsCBuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsHpfafJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsHpfafJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1H9GxV1pJcvxFjM13xgSobQ66nYiI8s6MaV3OMmDrjk=;
	b=KsHpfafJ2hKfdRvO4giIBiYjC5uDxyg7BJM5hWik067LL4aW7EFHcIbzniMFgU+z7KOiA1
	91fVjMV3Ov45sPtRUQzd9iYVBWDUHxBt2JfdIm1Hxuu6q8catGdhQyCvbx8y/pX24fBJSb
	MBBvaAH5OMHXMfWN5xtde1FfWdIwyhI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-rYImaBXFOdq56BZbCHZY2g-1; Mon,
 27 May 2024 11:40:11 -0400
X-MC-Unique: rYImaBXFOdq56BZbCHZY2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E07BB380670C;
	Mon, 27 May 2024 15:40:10 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D53563C27;
	Mon, 27 May 2024 15:40:10 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id CE91130C1C33; Mon, 27 May 2024 15:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CDA033C542;
	Mon, 27 May 2024 17:40:10 +0200 (CEST)
Date: Mon, 27 May 2024 17:40:10 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 1/2 v4] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Message-ID: <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

If we allocate a bio that is larger than NVMe maximum request size,
attach integrity metadata to it and send it to the NVMe subsystem, the
integrity metadata will be corrupted.

Splitting the bio works correctly. The function bio_split will clone the
bio, trim the iterator of the first bio and advance the iterator of the
second bio.

However, the function rq_integrity_vec has a bug - it returns the first
vector of the bio's metadata and completely disregards the metadata
iterator that was advanced when the bio was split. Thus, the second bio
uses the same metadata as the first bio and this leads to metadata
corruption.

This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
instead of returning the first vector. mp_bvec_iter_bvec reads the
iterator and uses it to build a bvec for the current position in the
iterator.

The "queue_max_integrity_segments(rq->q) > 1" check was removed, because
the updated rq_integrity_vec function works correctly with multiple
segments.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/pci.c       |    6 +++---
 include/linux/blk-integrity.h |   14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/nvme/host/pci.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/pci.c
+++ linux-2.6/drivers/nvme/host/pci.c
@@ -825,9 +825,9 @@ static blk_status_t nvme_map_metadata(st
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -966,7 +966,7 @@ static __always_inline void nvme_pci_unm
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
Index: linux-2.6/include/linux/blk-integrity.h
===================================================================
--- linux-2.6.orig/include/linux/blk-integrity.h
+++ linux-2.6/include/linux/blk-integrity.h
@@ -106,14 +106,13 @@ static inline bool blk_integrity_rq(stru
 }
 
 /*
- * Return the first bvec that contains integrity data.  Only drivers that are
- * limited to a single integrity segment should use this helper.
+ * Return the current bvec that contains the integrity data. bip_iter may be
+ * advanced to iterate over the integrity data.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -179,7 +178,8 @@ static inline int blk_integrity_rq(struc
 
 static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 {
-	return NULL;
+	/* the optimizer will remove all calls to this function */
+	return (struct bio_vec){ };
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */

