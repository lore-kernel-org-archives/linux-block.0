Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0414A8B
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762226; cv=none; b=lFr4XUfH7bm1XFCHW2bMzkigMjT8OePMhdEnh56cxRovNHECXHfZ/pSLftnYYnVA0ekJcL+tWredeYTG4xLhyVvOe3l7QVj/HLC9kZ07dLD+1zGgNQZ+rClYCPrLv1w98W6YX6sULQ6zHBoutTyWlzXk9/XpnDvKriRmnCezFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762226; c=relaxed/simple;
	bh=kHXhIEHS2MYIhFl+2zOga/wN26CH5TeYr5rw+ZfWDvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cb2mMRXNBcZxIyU17QPZuyaIxDeHmiMRBSFkzAcKXHhLinXFbyxI6lXCD8WjBXnyVms0m0EfVC7y/ytmpYrO7Q/ukMEolNX9EijzjyazR1kNmgn6h7x4VSSHraS+x5xSEt18vmDXA2vfQdM6y55f+/C3VAVNmSiPD4NQMRGQwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7jNPKMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7jNPKMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739762222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T5KgT4qeqPGFTLCeMBc760o86C9YJv+nLSaCBJNcaCY=;
	b=C7jNPKMuQTACha0/Mbe2rmL8zDTIBS6zpfZOl9rnj4Vkm1COjhGFO7UQSetzkegurVH+Hx
	Lc2ZeAJoRG/CkapqwoRtcmSjvFbPLOBAct8X7T04o8EipRF8ymWdBjN5/mOv9OhFPz9lFg
	UmBYfng1Wq7uF9eaG1ZMlXwPyeNGAbA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-_nIf7E7WOGS0HBEmnsHDeg-1; Sun,
 16 Feb 2025 22:16:59 -0500
X-MC-Unique: _nIf7E7WOGS0HBEmnsHDeg-1
X-Mimecast-MFC-AGG-ID: _nIf7E7WOGS0HBEmnsHDeg_1739762218
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5AF619560B5;
	Mon, 17 Feb 2025 03:16:57 +0000 (UTC)
Received: from localhost (unknown [10.72.120.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EB62300018D;
	Mon, 17 Feb 2025 03:16:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Cheyenne Wills <cheyenne.wills@gmail.com>
Subject: [PATCH V2] block: fix NULL pointer dereferenced within __blk_rq_map_sg
Date: Mon, 17 Feb 2025 11:16:26 +0800
Message-ID: <20250217031626.461977-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The block layer internal flush request may not have bio attached, so the
request iterator has to be initialized from valid req->bio, otherwise NULL
pointer dereferenced is triggered.

Cc: Christoph Hellwig <hch@lst.de>
Reported-and-tested-by: Cheyenne Wills <cheyenne.wills@gmail.com>
Fixes: b7175e24d6ac ("block: add a dma mapping iterator")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix commit log and comment

 block/blk-merge.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b55c52a42303..143834087d55 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -556,11 +556,14 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 {
 	struct req_iterator iter = {
 		.bio	= rq->bio,
-		.iter	= rq->bio->bi_iter,
 	};
 	struct phys_vec vec;
 	int nsegs = 0;
 
+	/* the internal flush request may not have bio attached */
+	if (iter.bio)
+		iter.iter = iter.bio->bi_iter;
+
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-- 
2.47.1

