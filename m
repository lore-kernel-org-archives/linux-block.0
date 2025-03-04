Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A8205E20;
	Tue,  4 Mar 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111603; cv=none; b=QmvpCzn0lloWio8IO18Ydk0ACI563HwwwrvBJn0/hiu7VClAchMihXK7uYo5ZNnreYoZuJ9h+GLQ29cSKsXXUFTZKl9qfqoIQ1uuKY/aFytQelcgK0cMTy21d9wDP5N+6msabE2U66zsRQLXxuMc4+vSwKMBaFK+uBPTd24aPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111603; c=relaxed/simple;
	bh=hXzXG6ZNf6YAuMm3Istj9wi4E+AFhRDdb61kKOYV0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceTlXaBwEbdrHFQ9XYRWHtxaj0c/LDAW+GrP/ErxW2XR7yz6083ya4c6FhgIbhlPNzXGKoeYIREIndVOPZJ0J+6MrxMAiGWS0tOAE5NVwArrbj7vEaU5rjS4PXVvC9V3Ko1NOQBd9WFjLVRqXBbRw2z14EKRSwuj4dFaRdZ5Z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lFoQptTx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFoQptTx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0oDWL9MqCLrBHhvluseel4yAvZkVftMTuSIpYrKtT5U=; b=lFoQptTxFgvn2eDMe9RbVEMjHy
	bVVWUfCw27Rz8+6Vz9Pfs5Qms1vQk2tYgDHqnjK26Wj+5L+vcRKbLEqg8Er6WzIBfh81P7jRO1I1C
	S5amhajrZ2oT5+vUYjI2Zt+UJB45R7DD0cGnhtNujyBXgLM2rJpYmxVfAv1BUnHwBVEd3NG014M9V
	+WEbi3C00dMo3EwKzxqFH3F6vYB64aX382NuxQeD/au7NsDFJm42CPTl1hGqdVMIn9sh7EXtjKOd9
	hqLXRwfcddIr7ZnpduODpJ00ZKAdNPJ8DGCmUjnyxYe1BfhQwdXTt+ACr3t2zHqx8bobuxqwbTB+j
	oc+BD3dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWeA-00000002cln-3T7m;
	Tue, 04 Mar 2025 18:05:43 +0000
Date: Tue, 4 Mar 2025 18:05:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8dA8l1NR-xmFWyq@casper.infradead.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8cv9VKka2KBnBKV@casper.infradead.org>

On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
> Right, that's what happened in the block layer.  We mark the bio with
> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
> period, we had BIO_PAGE_REFFED which indicated that the page refcount
> needed to be dropped.  Perhaps there's something similar that network
> could be doing.

Until that time ... how does this look as a quick hack to avoid
reverting the slab change?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d6fed25243c3..ca08a923ac6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
 
 static inline void get_page(struct page *page)
 {
-	folio_get(page_folio(page));
+	struct folio *folio = page_folio(page);
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return;
+	folio_get(folio);
 }
 
 static inline __must_check bool try_get_page(struct page *page)
@@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (folio_test_slab(folio))
+		return;
 	folio_put(folio);
 }
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..8c7fdb7d8c8f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (!n)
 			return -ENOMEM;
 		p = *pages;
-		for (int k = 0; k < n; k++)
-			get_page(p[k] = page + k);
+		for (int k = 0; k < n; k++) {
+			struct folio *folio = page_folio(page);
+			p[k] = page + k;
+			if (!folio_test_slab(folio))
+				folio_get(folio);
+		}
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 		i->count -= maxsize;
 		i->iov_offset += maxsize;
