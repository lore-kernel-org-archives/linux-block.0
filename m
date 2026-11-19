Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077562;
	b=T/kyj9qhJFjb5yPoQH7R6zneHZFEoKx2knrqRvVxHXOf6tpzIchg2pFEH9CvzvBpXLY9
	 /XMfFazk87XCCg/pGUy7oUMNRi1RlpvMK5sOzniSkzZykS3AIRHkWnu7DHrqJjKljyhtf
	 Qd8Dc+ydX+sEF/GUoEgEdPi7vbbBNTO0nz4Qk2p1bdjXEERmjDeMABMZver2zFTWdPfPG
	 drFuaXFwoCaSDNtaiccVM3rLpI7DF8Er+yXfS1ZcyVf1PQH3CIuLZFQ9i0T97YEmr4nbb
	 K3nfoe/sg3NGO0E+kSyrqqoMiCIvNS8Lp9WqXMm9RQLQH0ae7x5lbcvUO4Eb2OCTDeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=BlFun8ikHsjA/CrfeIy+rlOJFd4IDwciC2pzEEJ0CNJvj8CfEQy7VqDC4RJL7FVGBmEZ
	 cU495XuuC7SSjEimpDcA5NHTQX4otbTm1C/COVSgau1mHNIWj5QKpAg/+P7hgME0umHKn
	 Ylz0BYv3JkzGSzQRi9nKP+sFb+5yeOaNEU3zADQ9ETIa1ZKanm3I0Cs+n5pp9OmQlbiiJ
	 zWS2pAX5IRDVEgVF3SwQJ/voHC1dYSqhStN2vIFHoc0dcHCwaNhqFngOMcIcx+W1YnoDC
	 waQ92IbkE2SE9JG2zC0B2CKS+6o6HqqwMV7W/LfxRleHmzPCN4oSAwF8oC60FwUrdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8Awipru;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E70606A33A
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 08:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E70606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8Awipru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795077560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=d8Awipru3rY2G6WINkeqRoExHy3mZzwTPYR5Dg3Sruv6qEoLNuYRfanXs8wjUREew1KsDS
	SpHU6D8qN9sJBaGrLlMqcwicWRRP5DqYRbFUeiUFvFUVTkfSAVtQWgQfhzWlfsDc2nunTc
	jlZ3E68yH7HccULPeJphGRU5/PO40JI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-J86VbOqoNfq-SFhEQJNgdA-1; Thu,
 19 Nov 2026 03:39:15 -0500
X-MC-Unique: J86VbOqoNfq-SFhEQJNgdA-1
X-Mimecast-MFC-AGG-ID: J86VbOqoNfq-SFhEQJNgdA_1795077553
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD92518004FE;
	Thu, 19 Nov 2026 08:39:11 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E23171956088;
	Thu, 19 Nov 2026 08:39:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH v19 02/17] block: Add a function to kmap one page of a multipage bio_vec
Date: Thu, 19 Nov 2026 08:38:33 +0000
Message-ID: <20261119083851.3306418-3-dhowells@redhat.com>
In-Reply-To: <20261119083851.3306418-1-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a function to kmap one page of a multipage bio_vec by offset (which is
added to the offset in the bio_vec internally).  The caller is responsible
for calculating how much of the page is then available.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index b63914ff56e3..7ea62643cfb7 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -344,4 +344,22 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * bvec_kmap_partial - Map part of a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ * @offset: Offset into bvec
+ *
+ * Map the page containing the byte at @offset into the kernel virtual address
+ * space.  The caller is responsible for making sure this doesn't overrun.
+ *
+ * Call kunmap_local on the returned address to unmap.
+ */
+static inline void *bvec_kmap_partial(const struct bio_vec *bvec, size_t offset)
+{
+	offset += bvec->bv_offset;
+
+	return kmap_local_page(bvec->bv_page + (offset >> PAGE_SHIFT)) +
+		(offset & ~PAGE_MASK);
+}
+
 #endif /* __LINUX_BVEC_H */

