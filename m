Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0C13D899
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372583; cv=none; b=FNd2wytixcbHCDRPe6ScH48+pMIvVqo4bdSSSkd3zF38svuucpRZaUW1ZnqIeSnWifYx1PdrYILBMaRCr8OTasISYwTFcyMJXYozuJuooTzmNU8gfYoJjSKrUlywOeQU6LjGWoi0n4hE6ax23J5O9EejJj2mpW5LKJThfiFrTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372583; c=relaxed/simple;
	bh=VbHQZLboaHCfoTv8ofZAUKteakuifWVqOY8ftpx6lU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZkcMaLipoNCbvPlwNm5Ha2zyFbTy07DUXyzkJKjjLw5yC73GgPHg3LBW7Aj+aTMMPjTQtvq/tAeLlzP3ZB5IKvTS+PUtu7seBm8aResgvX19xOgMk7c55Of8VF42ZR5hWz6WxI4LanEOvnGF4BLerV0ANzDtpE1D15XD3fWa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsTqehLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsTqehLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730372579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XbFrZV+rMBDJOxbDXR05Qno/7mEb1nJrwpe1gtW0nLw=;
	b=NsTqehLk52LRDs/q+UJ1aMk4XF91mK+w/4Er+bfiTCe6fJ7RgwjaK00aLX7EU3ClwX3mJV
	j1GbpNiKbgcoaHlChbINPxNEkPuWTgCR/4mc9B9F6GJwdJ/ZsF1s+8cF2Czv/7vcyIA0iK
	l4AqLP5ReTJp53rThg/jbI6p4Vh3Ons=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-LNnlKJUOPCyud33gxZSjoA-1; Thu,
 31 Oct 2024 07:02:56 -0400
X-MC-Unique: LNnlKJUOPCyud33gxZSjoA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 531CF1944ABF;
	Thu, 31 Oct 2024 11:02:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E27BA300018D;
	Thu, 31 Oct 2024 11:02:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] lib/iov_iter.c: initialize bi.bi_idx before iterating over bvec
Date: Thu, 31 Oct 2024 19:02:24 +0800
Message-ID: <20241031110224.293343-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Initialize bi.bi_idx as 0 before iterating over bvec, otherwise
garbage data can be used as ->bi_idx.

Cc: Christoph Hellwig <hch@lst.de>
Reported-and-tested-by: Klara Modin <klarasmodin@gmail.com>
Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9fc06f5fb748..c761f6db3cb4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 		i->bvec++;
 		skip = 0;
 	}
+	bi.bi_idx = 0;
 	bi.bi_size = maxsize + skip;
 	bi.bi_bvec_done = skip;
 
-- 
2.44.0

