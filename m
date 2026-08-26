Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749683B8BB6
	for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777271; cv=none; b=hhYGK2P5K+K4b8ZUQTp4Uu3p9HnBuAETrxgWQWt7ReLD1g5NJdI58V/7ODm82RGxR9c20KjrwqwfnVIrB3Rg2iJFIP9oEF6QqrIjS43zX4izQqK7evMJ8JlbHGJb8O9f3kQi3iZY+KzobSCqoWLnXNoq0u/2+ZDrSDGx9aRAXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777271; c=relaxed/simple;
	bh=XBdVrMHjTyolReC0N1fxKCCDSR8DwSAH1sCPMJHVaL8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bzg9D8R8B3epDODQX7SWiJrPJxv5B+uQUXQqowrCzYr8lZS+o2T4XjVKV3MjYmt4vD2CplycNdPSE2q0lrzN0VwlAZyswDpgKH2eO5XfTmGq5tfHx6/cDY9yhvj1uKW8706ZB1TajLlBvObFS/3URhDC9P1P2wKnkbU0KmtupN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz3yTAHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz3yTAHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787777268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jP0UKtPxmEhy6HDyIj1plfhDhBBfaCkZLlo/sEgyzw=;
	b=bz3yTAHzF1PVnJUd02TmMAImh9ZNZjq6O0001BRp4JUSr9VOWh5W+19scUSKTQXYk1g5yD
	l7x7gV6cT3Rca+mYh5T5i75tFqZeAwPjSYXFZGvH2JC4ezXa/HfL1VF4s4lBU3SKqrsSpG
	3HIOBuyKWrJWcVzij6qekgb4yqmiWVs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-xNS7lx1SPmKIlckEKETYBg-1; Wed,
 26 Aug 2026 16:46:38 -0400
X-MC-Unique: xNS7lx1SPmKIlckEKETYBg-1
X-Mimecast-MFC-AGG-ID: xNS7lx1SPmKIlckEKETYBg_1787777196
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 696B41955BDD;
	Wed, 26 Aug 2026 20:46:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC8681955F0B;
	Wed, 26 Aug 2026 20:46:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1819786.1787768317@warthog.procyon.org.uk>
References: <1819786.1787768317@warthog.procyon.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: dhowells@redhat.com, Keith Busch <kbusch@kernel.org>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1895549.1787777192.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:46:32 +0100
Message-ID: <1895550.1787777192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 14b007e17881 added an address check using iter_iov_addr() and a
length check using iter_iov_len() to iov_iter_extract_bvecs(), but these
cannot be used so and are unsafe in this circumstance as the functions hav=
e
hardwired assumptions about the iterator type.  They should only be used
with ITER_UBUF or ITER_IOVEC-type iterators and work with ITER_KVEC; they
should not be used with ITER_BVEC, ITER_FOLIOQ, ITER_XARRAY or ITER_DISCAR=
D
iterators.

This change proved to be a problem for cachefiles as an iterator of type
ITER_FOLIOQ is passed and iter_iov_addr() and iter_iov_len() both
malfunction because iter->__iov in iter_iov() is not pointing to an iovec
array.

Fix this by using iov_iter_alignment() instead for anything other than
ITER_UBUF, ITER_IOVEC or ITER_KVEC.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction=
")
Suggested-by: Keith Busch <kbusch@kernel.org>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Hannes Reinecke <hare@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6665372ecf71..c489569a5815 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1921,15 +1921,22 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *it=
er, struct bio_vec *bv,
 		unsigned short max_vecs, unsigned mem_align_mask,
 		iov_iter_extraction_t extraction_flags)
 {
-	unsigned long start =3D (unsigned long)iter_iov_addr(iter);
 	unsigned short entries_left =3D max_vecs - *nr_vecs;
 	unsigned short nr_pages, i =3D 0;
 	size_t left, offset, len;
 	struct page **pages;
 	ssize_t size;
 =

-	if ((start | iter_iov_len(iter)) & mem_align_mask)
+	if (likely(iter_is_ubuf(iter) ||
+		   iter_is_iovec(iter) ||
+		   iov_iter_is_kvec(iter))) {
+		unsigned long start =3D (unsigned long)iter_iov_addr(iter);
+
+		if ((start | iter_iov_len(iter)) & mem_align_mask)
+			return -EINVAL;
+	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;
+	}
 =

 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as

