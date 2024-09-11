Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60904155386
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043900; cv=none; b=i7QOAGE0slOb0bjl20N6niYoqST3+whb6HVXXa3X8AsDzJGDaceBwF3QgVIzb5cmxztSpthao7viBrROZu2cgDG8KCV0dHp3rnjpb/yGD3JxSWcd/wwNVi+QAl+LARVpqtZjgsA4IMO72wzngn4qtj99R2uhUXwM3FaJZJx72zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043900; c=relaxed/simple;
	bh=dtlegLlU07witWvTzTwbtRmeFKQGBkFF+O7xn7lU2gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JzzN1CH+0g1QRQSH+5BkeT/e4k3JXl8HXUZM/Myoo2bm0dG5iA+Ssutb/ESyraFPJbQzZFWJee0k8sqdOE9rKIwhHfMsGkvqXlivaHD5QCuU2ebgYOauyIXUDp19mvsk3KrcqsPFKFmpyyw/ZH7M+xiyrkPJ+8YQ0H6hP+elgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AFnfIKGf; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AFnfIKGf"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240911083816epoutp04329e2d6aff16fa4f37a1b9e4b3f72c32~0I8dZ6zU81125711257epoutp04W
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240911083816epoutp04329e2d6aff16fa4f37a1b9e4b3f72c32~0I8dZ6zU81125711257epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726043896;
	bh=CSqhCksDJDKePWzl3I60/6bY4Ms7uxfAgICqp6nPHOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFnfIKGfGd42bucbT3cVIFgghMxCvn7MTmUNnYRZ+mg3lHNX98WWiRpU2DdbdE/qs
	 1YoCU21N6TYIrRvyIYfbSolzfaByW0gfE+5fdn5/OvQbrhXBR13y3AbseT18lPm4EK
	 M0XS7j7XpMBSBobeQX2lsjTBjPfS3rhqS/vFDmV4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240911083815epcas5p39d028b0b9ccc26ed236b7f776cd76244~0I8dGSqBn0410304103epcas5p3h;
	Wed, 11 Sep 2024 08:38:15 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X3Yqn4N9Fz4x9QR; Wed, 11 Sep
	2024 08:38:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.8C.19863.5F651E66; Wed, 11 Sep 2024 17:38:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911065722epcas5p29397d448658d52c5ef511138a6e7ed7d~0HkXMs0F00582105821epcas5p26;
	Wed, 11 Sep 2024 06:57:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911065722epsmtrp1e586ff15c8486ca2663032f3d1f2934d~0HkXL8RR51549315493epsmtrp1Z;
	Wed, 11 Sep 2024 06:57:22 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-a0-66e156f5850e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.8D.07567.25F31E66; Wed, 11 Sep 2024 15:57:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911065719epsmtip105fd36ad2e4cb91dd35a8eb459bbf2a1~0HkUxBIUF0661306613epsmtip1K;
	Wed, 11 Sep 2024 06:57:19 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v10 4/4] block: unpin user pages belonging to a folio at
 once
Date: Wed, 11 Sep 2024 12:19:35 +0530
Message-Id: <20240911064935.5630-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911064935.5630-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmuu7XsIdpBj+my1s0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfXLV1aLvbe0LW5MeMpose33fGaL87PmsFv8
	/jGHzYHXY/MKLY/LZ0s9Nq3qZPPYfbOBzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZzTP6WYtaOWvWHdvNVMD43Se
	LkZODgkBE4kzC9uZuhi5OIQE9jBKNBzexwLhfGKUODV7MzuE841R4vGO7UBlHGAtr74nQcT3
	MkqcebsKquMzo8SrM88ZQYrYBHQlfjSFgqwQEXCXmPryESNIDbPAU0aJK19+soIkhAX8JY69
	O8oCYrMIqEq8uHiUGcTmFbCRmPRhLRvEffISMy99ZwexOQVsJQ7/eMwEUSMocXLmE7BeZqCa
	5q2zmUEWSAjM5JCYOesPO0Szi8TzCXtYIGxhiVfHt0DFpSRe9rdB2dkShxo3MEHYJRI7jzRA
	xe0lWk/1M4M8wyygKbF+lz5EWFZi6ql1TBB7+SR6fz+BauWV2DEPxlaTmPNuKtRaGYmFl2ZA
	xT0kps9fxQYJrAmMEtue/WWdwKgwC8k/s5D8Mwth9QJG5lWMUqkFxbnpqcmmBYa6eanl8GhO
	zs/dxAhOu1oBOxhXb/ird4iRiYPxEKMEB7OSCG+/3b00Id6UxMqq1KL8+KLSnNTiQ4ymwBCf
	yCwlmpwPTPx5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwrbFe
	ImjVZnlUx8GA0eRRdoRdc2P/1Gt1d24bfawpPjS9seU34/HNS7fvaZnL/GHmg9fH50ccDWtd
	va5pyi/VVU9aXS/eC9/rpdz4PW6/RbOejPSijNncO5Yk1jNoPXkqsFouvfWy6uXlc95seSk0
	L9raWS+t6V7Z+hXPi+4pX1P8Wrzv7lT+6cL7/S/oe9Z0/XNPS9/U26lapb133q3PB/0NA85I
	rW6/5LJOb53HmVKxW4fUf/4wMGZf9Gzvhg/aC+ut/3yZoJeYf6FCsH+qGpPSu2NnvCbEPmXZ
	8pvl+5kZrDo+9Vs8jCfueCiw/Jv92v/OH0rS8iYoVCw/xHtLbNfvXVqeNhsfrpvNtOMC5wUl
	luKMREMt5qLiRAAJCrmURAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG6Q/cM0g2Xb+CyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZzXO6
	WQta+SvW3VvN1MA4naeLkYNDQsBE4tX3pC5GLg4hgd2MEgd6JzF1MXICxWUkdt/dyQphC0us
	/PecHaLoI6PEurvP2UCa2QR0JX40hYLUiAj4SizY8JwRxGYWeM8ocXuJNIgtDBT/NH0D2EwW
	AVWJFxePMoPYvAI2EpM+rGWDmC8vMfPSd3YQm1PAVuLwj8dg9UJANX82tLJC1AtKnJz5hAVi
	vrxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4JrQ0
	djDem/9P7xAjEwfjIUYJDmYlEd5+u3tpQrwpiZVVqUX58UWlOanFhxilOViUxHkNZ8xOERJI
	TyxJzU5NLUgtgskycXBKNTApRppcTVkb+v7do3MmLc/fXT1+snnnf6Z/7GFr3l3y3PTvRM6B
	bVPLSnXWbrxlP/V5Ss6B2kusR9TPCh+QKy4K+tAquXXJzcauTK1K13c5L1OdZdprwj853T19
	idFk+unLDbdm6Jv+vvUh7Oha2UL3OaFFFn22lfyRBrxuJh8f7d7vdjtgKW+xwaRz75Uia45Y
	thZcvvb5EJuGS5XJG9ePa9Z67PhoWsh0Zc1hk9XukjxabgFcNfkWjI9KDsusnDo1YH/u3Ihl
	LRo5HjVb3qQ5fpjQyr7m1J5FjPNPachN4j/+5N3EX9NadS0sgte2Jeg9ZQvb8DnTNUbgxZdz
	T+5c5nizTO4Ua9pmofjVetcuKrEUZyQaajEXFScCAKrd/qL4AgAA
X-CMS-MailID: 20240911065722epcas5p29397d448658d52c5ef511138a6e7ed7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911065722epcas5p29397d448658d52c5ef511138a6e7ed7d
References: <20240911064935.5630-1-kundan.kumar@samsung.com>
	<CGME20240911065722epcas5p29397d448658d52c5ef511138a6e7ed7d@epcas5p2.samsung.com>

Use newly added mm function unpin_user_folio() to put refs by npages
count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d8b52bc54549..ac4d77c88932 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1190,7 +1190,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
 		size_t nr_pages;
 
 		if (mark_dirty) {
@@ -1198,12 +1197,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_mark_dirty(fi.folio);
 			folio_unlock(fi.folio);
 		}
-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
 		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
 			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		unpin_user_folio(fi.folio, nr_pages);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1241,8 +1237,8 @@ static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
 				folio_page(folio, 0), len, offset,
 				&same_page)) {
 		bio->bi_iter.bi_size += len;
-		if (same_page)
-			bio_release_page(bio, folio_page(folio, 0));
+		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
+			unpin_user_folio(folio, 1);
 		return 0;
 	}
 	bio_add_folio_nofail(bio, folio, len, offset);
@@ -1258,8 +1254,8 @@ static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
 	if (bio_add_hw_folio(q, bio, folio, len, offset,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
-	if (same_page)
-		bio_release_page(bio, folio_page(folio, 0));
+	if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_folio(folio, 1);
 	return 0;
 }
 
-- 
2.25.1

