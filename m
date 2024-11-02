Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125604C66
	for <linux-block@vger.kernel.org>; Sat,  2 Nov 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511749; cv=none; b=uhqxrBFrz8IzFMVMg6bmL27ms1YYT541oM4CPLPbiOFAtNY8u6szKiAqvin6xg+RihQyxA9pJBVLdQkhWTLkptWl7o7L7lvMPy76IRd5bDVoOZ/+OhrGjoCIBQA4TA4KyapcflS/CUPQwO37cSUjTARJUYwcnIGtU4aBMDxgjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511749; c=relaxed/simple;
	bh=H3cAD0Nq97TSeNvnDXCm1EZEjANrh6SrZz5rOUUVVW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1aUzTuSljaR6kn8VA3v1fAkJU4x3QP1bujTLaM+H79sXpQEI42PceDtK3JenZWpZSeA+SWWpKKTqb7o0LGB2ep8fpuvF91iSvt0CB9WjYWXjtjWnSsrx4eYQp05bQaI/4U1cA8KIkhrZ/SBUKR49ZYWz86KC0UGDdCErCi+cNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUwRuB5k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUwRuB5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730511745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFNZY3dE2yh7jXFMNid4zOc75gX/aeO64Mu8f9zton4=;
	b=LUwRuB5kcNxDAPSVD4ByJJOgB3+fxJ621RbvXcDDVSAtSdGvbmJFdIWE3e4GVULtEvx+iB
	YOyxybxByoPaoJQ6vkYDofAyFcaY5kx7Ji4Kpsxt3lp8ATkkp/yz7YiiKcNWnEUwXjdu0/
	nlcjcStmNiVIsb7JUGAtkQ6lv2pQ1SU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-GWL25e0AMgKfYQF4bTLy3w-1; Fri,
 01 Nov 2024 21:42:24 -0400
X-MC-Unique: GWL25e0AMgKfYQF4bTLy3w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353D919560A5;
	Sat,  2 Nov 2024 01:42:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B44E31956052;
	Sat,  2 Nov 2024 01:42:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Subject: [PATCH] lib/iov_iter: fix bvec iterator setup
Date: Sat,  2 Nov 2024 09:42:11 +0800
Message-ID: <20241102014211.348731-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

.bi_size of bvec iterator should be initialized as real max size for
walking, and .bi_bvec_done just counts how many bytes need to be
skipped in the 1st bvec, so .bi_size isn't related with .bi_bvec_done.

This patch fixes bvec iterator initialization, and the inner `size`
check isn't needed any more, so revert Eric Dumazet's commit
7bc802acf193 ("iov-iter: do not return more bytes than requested in
iov_iter_extract_bvec_pages()").

Cc: Eric Dumazet <edumazet@google.com>
Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Tested-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Hi Jens,

If possible, please merge this one with Eric's commit.


 lib/iov_iter.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3026bdcb4738..4a54c7af62c0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1700,7 +1700,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 		skip = 0;
 	}
 	bi.bi_idx = 0;
-	bi.bi_size = maxsize + skip;
+	bi.bi_size = maxsize;
 	bi.bi_bvec_done = skip;
 
 	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
@@ -1724,10 +1724,6 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 		(*pages)[k++] = bv.bv_page;
 		size += bv.bv_len;
 
-		if (size >= maxsize) {
-			size = maxsize;
-			break;
-		}
 		if (k >= maxpages)
 			break;
 
-- 
2.46.0

