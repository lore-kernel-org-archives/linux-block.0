Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6B275401
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522812; cv=none; b=vAFEjTH5EAt0FtKVGE36Im7Y1hPeyjc6YF7SkMP1NkB1Qkh1m8ADZ0+rUOVNRoQzC82MblBuZAYbFGQzTyK+6FEaaiEmGPOOFq3vpRMLrFX1PRJZnHMvYkR3aZSn7W/7B0WK+0nD16zi/tPaTX9OxBpVJhQzu6pMiLj6qRI4z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522812; c=relaxed/simple;
	bh=cul8uGoebAhv4llPe8OiAirez0PMywwJjebk2Ye/8LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrP/P1/Xjc0WfAMhk/H33bvRxaELeiaTByR9VN4+/MiZWqhTFOrQHWsDIICOv5f4YaIQavoHE1LnlYY2NWhdM4vwAfdzDU3bz+85tOCyR5U60dPduwlmRx0fr63RxvxJrM2fuSWWoDzGMDb+yDirUWAoUEBrL9mA5cP4pHAukmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crsu1iQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crsu1iQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739522809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NcOkpr6OtHBgkpzKBn8XAuRkQoUirWDczIFKuA4/Bl8=;
	b=Crsu1iQvgJvw6nzeDzXKxz7SGDIfSyUSOgJOdkZESEtu/XFVUYUbXvcp2iYsN0v/a7PxO5
	QUmCb/8ckf1Y5mjB+kTLN5CNSbHCQ9/GEYSFiRca+DmBJgtXmO1Vw/NZdY7NRq2kzmnZm/
	S/LyVWDmwp1CTggjDf4TnkcblyEsIBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-7dLn9ze0O3OhvSLQXpyZng-1; Fri,
 14 Feb 2025 03:46:48 -0500
X-MC-Unique: 7dLn9ze0O3OhvSLQXpyZng-1
X-Mimecast-MFC-AGG-ID: 7dLn9ze0O3OhvSLQXpyZng
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 552EA180087A;
	Fri, 14 Feb 2025 08:46:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F59319373C4;
	Fri, 14 Feb 2025 08:46:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Cheyenne Wills <cheyenne.wills@gmail.com>
Subject: [PATCH] block: fix NULL pointer dereferenced within __blk_rq_map_sg
Date: Fri, 14 Feb 2025 16:46:38 +0800
Message-ID: <20250214084638.58437-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Discard request may use special payload only and doesn't have bio
attached, so the request iterator has to be initialized from valid
req->bio, otherwise NULL pointer dereferenced is triggered.

Cc: Christoph Hellwig <hch@lst.de>
Reported-and-tested-by: Cheyenne Wills <cheyenne.wills@gmail.com>
Fixes: b7175e24d6ac ("block: add a dma mapping iterator")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b55c52a42303..48a96aed15b6 100644
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
 
+	/* discard request may not have bio attached */
+	if (iter.bio)
+		iter.iter = iter.bio->bi_iter;
+
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-- 
2.47.1

