Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECED12A15A
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415854; cv=none; b=MPDp3lvhh+FvyDXDJu83AkHcF1l6xJQlD64bdUMyVfiHtStE94p19vT8r75LJCd+vP7Xqtnz74oc/AHAuj3SAvOeOrTz73hLqqTXiTDqhMY4EXYG6GLGzPxxkGT4GJO2Dna3BblqfjCQPrJsEFpNX96I2IOKegIpSZt6GxtITJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415854; c=relaxed/simple;
	bh=WuMCAu3ccAHVxlE2ZcyZl0wixWpE0QNpYLZhyz2FPCI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gthyrBu4pLKTJv5ztUrOUy5MpsHvdNQI2bvD5dQ45MqUAzfkMswPN+WbUmnQknBCht07QfxfTLswI44MiDwxwpEYUXSIOQtlNKAmsCLQZJdIcrNtD6nPaYHuVVOzW1MZt7ADxCDoNs1h1aM18dZEW5VfsZCio3AbdfZ31u53PEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbH5Bidn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbH5Bidn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714415851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=C3W2voRCHkB5L93OtIlCl1N0fcm9fIHhM/J1w5AVK9o=;
	b=JbH5BidnsIiKiLcRRJHbIn4cpV+UJbzIKLTvfYOIsR+Rjiu3YytVkL9N3qkBb+25LUjrcK
	qVQz0Wvdk4qAhu4aN8JJADgG9/i0COr+urC3jDmlgLGJdCSb7zXNHtyWgPzYcRCMn9Nvxi
	u6hkv/Ib3UYC/1uV4Id8KWLXnQ3aV0c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-Fa19gatRPxuVdHAkV8eR_g-1; Mon,
 29 Apr 2024 14:37:27 -0400
X-MC-Unique: Fa19gatRPxuVdHAkV8eR_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20CE71E441D4;
	Mon, 29 Apr 2024 18:37:27 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 178BA2166B31;
	Mon, 29 Apr 2024 18:37:26 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id C2E3730C2BF6; Mon, 29 Apr 2024 18:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id C128D3FB54;
	Mon, 29 Apr 2024 20:37:26 +0200 (CEST)
Date: Mon, 29 Apr 2024 20:37:26 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Mike Snitzer <snitzer@kernel.org>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH] block: change rq_integrity_vec to respect the iterator
Message-ID: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi

I am changing dm-crypt, so that it can store the autenticated encryption 
tag directly into the NVMe metadata (without using dm-integrity). This 
will improve performance significantly, because we can avoid journaling 
done by dm-integrity. I've got it working, but I've found this bug, so I'm 
sending a patch for it.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>

If we allocate a bio that is larger than NVMe maximum request size, attach
integrity metadata to it and send it to the NVMe subsystem, the integrity
metadata will be corrupted.

Splitting the bio works correctly. The function bio_split will clone the 
bio, trim the size of the first bio and advance the iterator of the second 
bio.

However, the function rq_integrity_vec has a bug - it returns the first
vector of the bio's metadata and completely disregards the metadata
iterator that was advanced when the bio was split. Thus, the second bio
uses the same metadata as the first bio and this leads to metadata
corruption.

This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
instead of returning the first vector. mp_bvec_iter_bvec reads the
iterator and advances the vector by the iterator.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/pci.c       |    6 +++---
 include/linux/blk-integrity.h |   12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

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
@@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
  * Return the first bvec that contains integrity data.  Only drivers that are
  * limited to a single integrity segment should use this helper.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
 	return 0;
 }
 
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	return NULL;
+	BUG();
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */

