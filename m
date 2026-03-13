Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133873DDDD9
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425466; cv=pass; b=TTZB/OpKBZtlfObcRj8LqvQoz31CcvTw3KcCyaGtJ39T9895dU47hV4CH9fgYFIsqO6qAyRM5xtiHFIEB6fOFZMPMOp1Lpa91qUl90RQVT8tkn8ORRj1Lo0KkPVOZM/mU2qjUIIUSayZsxtFqNOWvxwi3iLc0YiXHfi3q+orE7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425466; c=relaxed/simple;
	bh=Kc/3AKIpwTzSkyARNIxZFhYv6buQLTsMNPDjGT35jOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwtOzj2zMhOC850HefezQTJmm+p9AdrietOh72qXVJ3BVMoeEifEYKn0ic8atSHw20f3n5aQGxtcX0uRzLDzatoM4o0J8mBRcQLJcJ1haIi+RxNcUuaIZWQSmbWLNARkSMQyhDJr3m/YXhYK9901OEqj8YJmyTKA7Ah29CO80sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=cIhwmImR; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="cIhwmImR"
ARC-Seal: i=1; a=rsa-sha256; t=1773425443; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Hq1Fo1wrzq5Swt9L6WunKco2N00mB/Kvk4MoEXX98C3Rz1PraaclfDfOIEo1iSFyDvBVXQEC7pjTyGlKC23DpuBO0yy+/0XGc1dxzwcW1GJ72CbrB9kilwDiZEZIVL0uQ9Nqx+DZrIZBICyeEgzK/9fxe4ZVr5o51TJLXDY72Ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425443; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qjNsFUrMiANXtVwfgqUllgON46nJBxUf5dbGwwSm1RY=; 
	b=g8uXpGNsOUrn8Xkv1iruNjEcuOlyrBRT119kaVCsJFTBAguN4f2n7iOlJqOh2oLCFnCAm3e92W5EMdrZXsoxP1/TJcUGeib6LY2ZFw6OTLN9dC8S/HAEj4kAVcK8vmUnGFpS/nu0Ps3cjYDVmrtUaNPbx7fViLTMnklqj3fW1Oc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425443;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=qjNsFUrMiANXtVwfgqUllgON46nJBxUf5dbGwwSm1RY=;
	b=cIhwmImRf0tlhHMw708SognLTq9rSV0U6PDnJ+qvYHpp7XjCP/wGbMNjobdCaxRY
	dpPrB9VIKdBzGs+lZS7vsLMvB7MaWYhsP2DCZDSbvAazZuvjJp/sfmgrODrOP3GyGnn
	1RTtRZHzuBh2aBi40u+lsqxARce5WrT7AGIEhuHo=
Received: by mx.zoho.eu with SMTPS id 1773425441062377.8134339982736;
	Fri, 13 Mar 2026 19:10:41 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 1/7] lib/iov_iter: fix missing allocation failure check in iov_iter_extract_bvec_pages()
Date: Fri, 13 Mar 2026 18:10:32 +0000
Message-Id: <20260313181038.30018-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313181038.30018-1-objecting@objecting.org>
References: <20260313181038.30018-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When iterating bvec pages for direct I/O submission on a block device
under heavy memory pressure, want_pages_array() can return 0 if the
internal kvmalloc_objs() call fails.  Every other call site in the file
(iter_folioq_get_pages, iter_xarray_get_pages, iov_iter_extract_kvec_pages,
iov_iter_extract_user_pages, __iov_iter_get_pages_alloc) checks for this
and returns -ENOMEM, but iov_iter_extract_bvec_pages() does not.

When the allocation fails, *pages is left NULL and maxpages is set to 0,
but the while loop still enters because bi.bi_size is nonzero.  The
subsequent (*pages)[k++] = bv.bv_page dereferences the NULL pointer,
causing a kernel oops.

This was found through code review comparing the error handling patterns
across all want_pages_array() call sites in the file and noticing the
one that was inconsistent.

Add the same !maxpages check present at every other call site.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a63c7fba313..852f9ed40e5c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1628,6 +1628,8 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 	bi.bi_bvec_done = skip;
 
 	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
 
 	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
 		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
-- 
2.34.1

