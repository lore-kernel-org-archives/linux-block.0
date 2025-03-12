Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F82033A
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791113; cv=none; b=GknKjDcETNGkRhS8uKdTUZr3v1iqZzyAuD3dmqLYwJH7oD3Jdxypi32HuZw/GDWRFyQ1wpZbGH+NPRJndLZrop7bTSVxx0W9mwcUq+1XNlU382890DLbnPISCBfNCGs7MVTF1/ti+vjqB4+vnKBBERsjaMV8R2QlKJXdiCfY6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791113; c=relaxed/simple;
	bh=NDnLTuLhOFzy1eHOPqYKtCMG2xhRjI5pQ+kKeELws+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YY5B5wFAz0V/JV/uLo6yG7QBdRK6MO+O8c4o8o02PA6CK39WlxuJXP/bowcItUaaQxHXVN803fJUjxMnBwGbu3HJULbO0wouJ+ftuFCcOjRLg4g9+Ivsy3C3VRxPadIpnUgQhdLF71bmJeUV7/u/9LeY9g6jowqJsO78de9cbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilUDgNTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilUDgNTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741791110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+5ekf4RNz/WiY7b8vyFjJlYDOxBqKzeFiRMoudgmqD0=;
	b=ilUDgNTkgPaErnywg/HNC4686YRDM7OhwlZ/Rf42lZq8kAgQwHkmEAzauDMHi1MUQcCS3A
	hrr+PyUtZh8NUND4vzcTCx82LQyXJc9UEttoZmqvuQr9JL1mCB/I0VUT6gHk6BW1l+lPbq
	+O1w3Kv4m3O0zWMR0q6pSMDuJ7voIeA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-JZENE8AjNOOKSAg-dqb6DQ-1; Wed,
 12 Mar 2025 10:51:47 -0400
X-MC-Unique: JZENE8AjNOOKSAg-dqb6DQ-1
X-Mimecast-MFC-AGG-ID: JZENE8AjNOOKSAg-dqb6DQ_1741791106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA71E1800263;
	Wed, 12 Mar 2025 14:51:45 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C68E1955BCB;
	Wed, 12 Mar 2025 14:51:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH V2] block: fix adding folio to bio
Date: Wed, 12 Mar 2025 22:51:36 +0800
Message-ID: <20250312145136.2891229-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

>4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
is supported, then 'offset' of folio can't be held in 'unsigned int',
cause warning in bio_add_folio_nofail() and IO failure.

Fix it by adjusting 'page' & trimming 'offset' so that `->bi_offset` won't
be overflow, and folio can be added to bio successfully.

Fixes: ed9832bc08db ("block: introduce folio awareness and add a bigger size from folio")
Cc: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- trim `offset` unconditionally(Matthew)
	- cover bio_add_folio() too (Matthew)
	

 block/bio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f0c416e5931d..42392dd989ec 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1026,9 +1026,10 @@ EXPORT_SYMBOL(bio_add_page);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off)
 {
+	unsigned long nr = off / PAGE_SIZE;
+
 	WARN_ON_ONCE(len > UINT_MAX);
-	WARN_ON_ONCE(off > UINT_MAX);
-	__bio_add_page(bio, &folio->page, len, off);
+	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 
@@ -1049,9 +1050,11 @@ EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		   size_t off)
 {
-	if (len > UINT_MAX || off > UINT_MAX)
+	unsigned long nr = off / PAGE_SIZE;
+
+	if (len > UINT_MAX)
 		return false;
-	return bio_add_page(bio, &folio->page, len, off) > 0;
+	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
 }
 EXPORT_SYMBOL(bio_add_folio);
 
-- 
2.47.1

