Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2F237704
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779701; cv=none; b=WLbhFTRaH0F26hejsFli8OD0yUftFDf+oijmMJ5/JpoKA2G/I6JDgx0lvMJmdYoezqsB79K+dKgaPqJEkBk7fD7SJH1BCQfWQEU3eTn4uNyhPaPNC/zVDNS1VUYzhNJuP55ZnCviMnAK10wfUsfu07HtIM4Sa1tSJZ10JWy6YXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779701; c=relaxed/simple;
	bh=OLv0dMQ3yvx5THtmH1CtQuwARl21jirU7kb32ddMCwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtoZ6ab3uVINL/Ak9FWk2SupAxYsDnh8hh5dSdYNYl6p7Ia4uVcMbc391DisQoLp/JAHdTZZvLNLOSUuNYSs/igtcY/Z0ehNd3+MViGN9TCO6gsxmdQaKbCttOg6+4h+a5llGwwDWgXauiKyiYU3ZXNtM+OXq1aGOsV1vUF6pcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaRF8ErN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaRF8ErN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741779699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BvCdqGY13SMLyCezPk/Hqlm+xSs9lNClL2/sPoBfy/o=;
	b=JaRF8ErNEtPFb8NIOP4nEhdZqXVD/92MLHKFiuHkggihkVJRvv57DTVJ6Xz4xonEFRCHP3
	bkey/B/uylmp5G6y3GFE0/87qJTulDxEOEJjLvsjvf14pBNu7McuUnhsxvIppSO+ZRMOn0
	KMWnzgQ/gtkg7DnA/U6Zv9MNaCattnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Q87BTOppOw21GRJqJLGAfA-1; Wed,
 12 Mar 2025 07:41:37 -0400
X-MC-Unique: Q87BTOppOw21GRJqJLGAfA-1
X-Mimecast-MFC-AGG-ID: Q87BTOppOw21GRJqJLGAfA_1741779696
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AC5919560BD;
	Wed, 12 Mar 2025 11:41:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA8D71956094;
	Wed, 12 Mar 2025 11:41:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH] block: fix adding folio to bio
Date: Wed, 12 Mar 2025 19:38:05 +0800
Message-ID: <20250312113805.2868986-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

>4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
is supported, then 'offset' of folio can't be held in 'unsigned int',
cause warning in bio_add_folio_nofail() and IO failure.

Fix it by adjusting 'page' & 'offset' so that 'offset' can be stored
in 'unsigned int'.

Fixes: ed9832bc08db ("block: introduce folio awareness and add a bigger size from folio")
Cc: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f0c416e5931d..dd61d783717f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1026,9 +1026,17 @@ EXPORT_SYMBOL(bio_add_page);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off)
 {
+	struct page *page = &folio->page;
+
 	WARN_ON_ONCE(len > UINT_MAX);
-	WARN_ON_ONCE(off > UINT_MAX);
-	__bio_add_page(bio, &folio->page, len, off);
+	if (unlikely(off > UINT_MAX)) {
+		unsigned long nr = off / PAGE_SIZE;
+
+		page = folio_page(folio, nr);
+		off -= nr * PAGE_SIZE;
+	}
+
+	__bio_add_page(bio, page, len, off);
 }
 EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 
-- 
2.47.1

