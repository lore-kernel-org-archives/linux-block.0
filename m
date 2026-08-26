Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B23A75AC;
	Wed, 26 Aug 2026 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773642; cv=none; b=cfnKjClrkxf0pmUD8CQUJD7ZEOQUNk59z1PrhWIQjyWds5FsXYch0wSmCJUAZWwmlIUVRzPkJZD7nMwwYPeifLcwHklqrTKP+nX3/fwgvqQMIiHhZVzRv5e8KoXY6GUoJCTGfioTi8nl7MXuqILHnp4iOXftwBh9xFQr0bRVMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773642; c=relaxed/simple;
	bh=IzFgQyJY4HgCZ9vnoz9qEnaQVHUiL5HkDid+7J9Apro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r155pzcnZkWz4Jcb3XpYXnnwnyxxnmNj0Vl7uIDO3YuXhY4Xg56uhA7OkrNStKKMggiUDrRgjnTRzMuC+CWfJ161R4UGJd+hZljR4YuvmvFsp8AEg3kcDziDNrt+UPAVtPRBQKyJVngYNxiGG2Z8r+8TRVT0+nJkhMHGVTB+4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIEtnlHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIEtnlHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA421F000E9;
	Wed, 26 Aug 2026 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773631;
	bh=kDDrZBBYCSHNwEIFe3K0cEIZsJ+9L+zBycRNm1zYxjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hIEtnlHEd+471wJikUImRH1iNHo+x/2hKXiXjJAVTgZrAuWHaS2sZZEhM2EWafYUR
	 9N6DdxNun5t4SkFKG9oZH8Rq4R8XE8ls9H6paeJmXw8Esev3ifJc4bkbY0WxtLSO0O
	 jgqank7LzW2ejAut4IBv2LjcwkvqVq7NZOkPGUp8ama8eAJZMfJ7f31UXH59uiVQIi
	 Y0MwsOuuK7rBaiXcYPJbE9qdleRcbusDWAI9YslMU2Q3JFdDdA/Et8bO9OG3jcT4ZA
	 PfFA/pR8ODiqPlW9mLgQsPgPsBgN6Xbcf63j3VP9mhVygMcFV0tYJLVAwZkz6mtLOJ
	 udWtqLM4hazIg==
Date: Wed, 26 Aug 2026 13:47:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <ao9CvZDRChrrxyCj@kbusch-mbp>
References: <ao8xqMXoCfj4AWUw@kbusch-mbp>
 <1819786.1787768317@warthog.procyon.org.uk>
 <1853652.1787772245@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1853652.1787772245@warthog.procyon.org.uk>

On Wed, Aug 26, 2026 at 08:24:05PM +0100, David Howells wrote:
> Keith Busch <kbusch@kernel.org> wrote:
> 
> > iov_iter_alignment loops over all the vectors when we only need to
> > examine the current one here.
> 
> Can the check be done earlier, then?

It used to be earlier, but the point was to reduce repeated iter
looping. It adds up, so I trying to co-locate validity checks with
places that have to iterate.

Would it be okay to special case the ubuf, iovec, and kvec types for the
simple check?

---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 81e5c5e5121f7..b6b1e75352b0b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1920,15 +1920,22 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		unsigned short max_vecs, unsigned mem_align_mask,
 		iov_iter_extraction_t extraction_flags)
 {
-	unsigned long start = (unsigned long)iter_iov_addr(iter);
 	unsigned short entries_left = max_vecs - *nr_vecs;
 	unsigned short nr_pages, i = 0;
 	size_t left, offset, len;
 	struct page **pages;
 	ssize_t size;
 
-	if ((start | iter_iov_len(iter)) & mem_align_mask)
+	if (likely(iter_is_ubuf(iter) ||
+		   iter_is_iovec(iter) ||
+		   iov_iter_is_kvec(iter))) {
+		unsigned long start = (unsigned long)iter_iov_addr(iter);
+
+		if ((start | iter_iov_len(iter)) & mem_align_mask)
+			return -EINVAL;
+	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;
+	}
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
--
