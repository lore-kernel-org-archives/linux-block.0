Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488B3DEAF9
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425468; cv=pass; b=jXJO6//pQDQIJ2NNe5O143CMTwGFSRM74+NIA+8rtVrLYwvLFuruWKidf4Nta2Zz1ggwAiVy45YekaQfkCXOSzbTzNGhzNSIBxBRGj9hIbMNT5e9Sr+tSmmqv+aHY57YMVutiaiixlF9tCHVIxRcrrLKiyooQAubVK1i4+ir7p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425468; c=relaxed/simple;
	bh=1U4L4TfcbRab7SatP+1BuE2zH2ZJnR8M+vOCHxFgBl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyDc7fZhl+eakie7RB+5Pb+NYQUkweH9rSQBv29HAFTk0XW20Bc9ifopBTnDOmcKTnc6Av+JYEpzztV3s/a0kW+BEeIBaBHeX6T/X9icAvvnjCdf7Ht6p0P2JlUZY7rASDH6xfG/YHlN/zQcxFXe/q350VE0Z3YQjqKvem4+w5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=QJip/cJE; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="QJip/cJE"
ARC-Seal: i=1; a=rsa-sha256; t=1773425446; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EhYE5MtklV+Z9S4xhoGwpoGE72BHmhcYBMD29hMZaGD2u40j6oJwch0LDsm2QzbPMDrTLNonGHgCIMHtU+RdTu80VMrE/1068XdXiXDVbemfGJmqdfrseZzOQEVmbycHmeMkFpkTUH0S4Qiw4N7m+XEzDDSDghH2+5zEthkqlLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425446; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SBmsvc6Cb9SLMhMKC+imSsbrYFq42BLCcQ1QkHJf4LQ=; 
	b=lNXUhXjFLOYY/BYiNIBiab8VPSlwFVkXXhrkDIjg9OWAnk1xEn/3+oEJ1ROmTpUK6n5tiTcDKK12A3ED2nZ9xm3km7FdJu3N7e8lJdjjasJ/vVs+fEUWy6HWLXgl57f17c38yBVKbS+Euv7dS15wxj22S5EccjQG9YgZfTHD/c8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425446;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=SBmsvc6Cb9SLMhMKC+imSsbrYFq42BLCcQ1QkHJf4LQ=;
	b=QJip/cJEbDWZF9myzyGca45qWWTxQcQ2MQQtKcjxVAD6KCr1Gwj0wetfIel4Xzyu
	vvThw5DnSpBlEy4k9bJFlXlfJuQ8makWG5imwhLecBrVMWPFHkynj/aCqjDtKGXt6Ao
	7tBUVe9AlcaoYKEtYgThJ5jK6bEiZCXKqMwKm9gI=
Received: by mx.zoho.eu with SMTPS id 1773425442879181.11812605213493;
	Fri, 13 Mar 2026 19:10:42 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 4/7] lib/iov_iter: account for iov_offset in iov_iter_single_seg_count() folioq path
Date: Fri, 13 Mar 2026 18:10:35 +0000
Message-Id: <20260313181038.30018-5-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313181038.30018-1-objecting@objecting.org>
References: <20260313181038.30018-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When the block layer calls iov_iter_single_seg_count() to size a
segment for a folioq-backed iterator — as happens during large
buffered writes through cachefiles or fscache — the function returns
the full folio size without subtracting iov_offset.  After a partial
transfer has advanced iov_offset into the middle of a folio, this
over-reports the remaining data in the current segment.

The iovec and bvec paths both subtract iov_offset (e.g.
iter_iov(i)->iov_len - i->iov_offset), but the folioq path omits it.

Found by reviewing the function for consistency across iterator types
and comparing each branch's treatment of iov_offset.

Subtract iov_offset from the folio size to match the behavior of the
other iterator types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6a7959bfc849..375512beefc5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -682,7 +682,8 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 	}
 	if (unlikely(iov_iter_is_folioq(i)))
 		return !i->count ? 0 :
-			umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
+			umin(folioq_folio_size(i->folioq, i->folioq_slot) - i->iov_offset,
+			     i->count);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
-- 
2.34.1

