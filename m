Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA534963B
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580849; cv=none; b=SijugeGezkd0AkKeRnWYsAEi3TQwdHqpO2JXBNz4LuauF31EA3JoVr7XH0u/ck4Tc9mDHHNyW/+u3VLk4mspssiKJPcpaSya02hmDJIyKDCAAwMoYsAWE8nwSD+uxi4Esx1ms4+DFNilCTmow01Ha2NjoEL+FM33VDYBJMxeSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580849; c=relaxed/simple;
	bh=z9bv2Ist6mwPl7hHSCtjwyEw0bOmwOXU2jRMieukxYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bUqnptphF1+IYxelOJyh4Zx7e6KgGMaP/9wQIEnC0C/eVaxWfejcOvIpm6C20cjQH+mtNH8rWgegvPpzMSdfgkh8kI0XhcslgJUr7IgsxH38jq4CSrNrPcTW2kvHM/Wzp7czG3fo4dBcc8zEQ1no9TKWvTakQPcRFrRz0AoaqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JTuqvpPB; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JTuqvpPB"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240605094725epoutp04526668b32919273b3715048b5917c1bf~WEq283Rgv0987809878epoutp04g
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240605094725epoutp04526668b32919273b3715048b5917c1bf~WEq283Rgv0987809878epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717580845;
	bh=+/FY4qp65VT+KCyw1+tjmOORXZF0ADAnQINAlnR9E8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTuqvpPBSZ/Ayd3KBxv3j3isJtZ1dZ1loQy5bsdmNmS08w6TcAVjkAr+W6sb85J5N
	 g6JRpmD6CoTrNfuxb206IoJ6Xrga3nHhGwMg09vTL6/qVgiqxdqLVeuLH4TghU/BCl
	 ULm4Mpy3dZOlbsZAMrgpNfdVjqR+5FzOmlqmTRzg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240605094724epcas5p3bbe87c1aa8618c22f65ba5d229fa624f~WEq2gSsIb0300203002epcas5p37;
	Wed,  5 Jun 2024 09:47:24 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VvN0q1PVxz4x9Q5; Wed,  5 Jun
	2024 09:47:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.15.08853.B2430666; Wed,  5 Jun 2024 18:47:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a~WEdw8ZGy70617006170epcas5p3u;
	Wed,  5 Jun 2024 09:32:25 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240605093225epsmtrp1f382af9fc9a3f78596ddb3bc9ddc840d~WEdw7gyQ_2905729057epsmtrp1V;
	Wed,  5 Jun 2024 09:32:25 +0000 (GMT)
X-AuditID: b6c32a44-fc3fa70000002295-25-6660342bd4f8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.F1.18846.9A030666; Wed,  5 Jun 2024 18:32:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240605093223epsmtip23e3a23965b97bc361abd85b192d77956~WEdvLezuB2783227832epsmtip2b;
	Wed,  5 Jun 2024 09:32:23 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Date: Wed,  5 Jun 2024 14:54:54 +0530
Message-Id: <20240605092455.20435-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605092455.20435-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmuq62SUKawe0rLBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6N1+wXWgkXKFV/f9jI1MB6Q7mLk4JAQ
	MJE4NSu9i5GLQ0hgN6PE7/U/2CGcT4wS3x9PYoFz/h9/zdzFyAnWcfdRLytEYiejxLbTH6Cc
	z4wSP3v3MoHMZRPQlfjRFArSICLgLjH15SNGkBpmgbOMEiemPmIBSQgLhEpMnPSHFcRmEVCV
	mPNjGxuIzStgK7Gq/RATxDZ5iZmXvrOD2JwCdhLfW3tYIWoEJU7OfAI2hxmopnnrbGaQBRIC
	vRwSu/ueQ53qIrFjyw82CFtY4tXxLewQtpTEy/42KDtb4lDjBqhlJRI7jzRAxe0lWk/1M4M8
	wyygKbF+lz5EWFZi6ql1TBB7+SR6fz+BauWV2DEPxlaTmPNuKguELSOx8NIMJkhYe0j0XOCE
	hNVERomr+7tZJzAqzELyziwk78xC2LyAkXkVo2RqQXFuemqyaYFhXmo5PJKT83M3MYITrZbL
	DsYb8//pHWJk4mA8xCjBwawkwutXHJ8mxJuSWFmVWpQfX1Sak1p8iNEUGN4TmaVEk/OBqT6v
	JN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQam/iBNDecen7n/0q/t
	Z+z6KOw0e8qTDZFH/+/4v3PT/U956le5eJWOf9COzmhODzhxd5WFenr/knMBlR9EHghlzqix
	O5tSrvPKan6/1hbVK0lHLR47FUzd/XwyQ/HiB8e6Jr3g/vRxqvQq+do5kw/urpy+1+muvk31
	CZuTNx4cWvCx0vSWwqFj5X+0NGbued+4cKH97Oof3m89Vy2tcjQ+fuPruo02Tie4J3scPd25
	ZAXrv5BjPW3zoqUbfz3bGpd9uzd65sebEzP++d7vTPd09Q6NP1EvHH/tvok+x6lb9cwx85af
	YOn526TUFp3DruV3KPK7e4V8yfmwD/Y5pd+FhM6es9dUav7ikDUpKvzRQSWW4oxEQy3mouJE
	AFPxxtc9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvO5Kg4Q0g2vnxCyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEro3X7BdaCRcoV
	X9/2MjUwHpDuYuTkkBAwkbj7qJe1i5GLQ0hgO6PE/LVXGSESMhK77+5khbCFJVb+e84OYgsJ
	fGSU+P8jvouRg4NNQFfiR1MoSFhEwFdiwYbnjCBzmAWuM0rcmL6VGSQhLBAs8WtTNxOIzSKg
	KjHnxzY2EJtXwFZiVfshJoj58hIzL30Hm88pYCfxvbWHFWKXrcSuHVtZIOoFJU7OfAJmMwPV
	N2+dzTyBUWAWktQsJKkFjEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYJjQCtoB+Oy9X/1
	DjEycTAeYpTgYFYS4fUrjk8T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpa
	kFoEk2Xi4JRqYHLOclXyfObptuFEGdPNYrMqKf1Z3UK885lueb31WRj3aMmsz3Jmlu4/M4xr
	55x3tfxq+Otu+PQf8w4Erqn/ZftZM0pgSlvL7KzL147uVcg1aCiya1GKvjVHW6s1+PrEtQp1
	nCc1V/s7fu+KuvNj7q6G3ba6r88bPH4aoPl8s910s885t3UehDzlUVBSELXoVS9Wl/1nMDFX
	ymqTsZpVyn8DlSVrNy4QCdUR9t9+JW7m4ygxb489J1/EnlDfUf36XHCz4qGf1Vy99kEnJi9w
	SRUr7Fll/1Nby+bCgrQMhZoX8/8nO53jTQ5doHNYcnVvzy3hF1nfty6ZUuKzcs7M0ocVvs4L
	RPlW5XocYX22TYmlOCPRUIu5qDgRAG5j387wAgAA
X-CMS-MailID: 20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
	<CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com>

Add a bigger size from folio to bio and skip merge processing for pages.

Fetch the offset of page within a folio. Depending on the size of folio
and folio_offset, fetch a larger length. This length may consist of
multiple contiguous pages if folio is multiorder.

Using the length calculate number of pages which will be added to bio and
increment the loop counter to skip those pages.

There is also a check to see if pages are contiguous and belong to same
folio, this is done as a COW may happen and change contiguous mapping of
pages of folio.

This technique helps to avoid overhead of merging pages which belong to
same large order folio.

Also folio-lize the functions bio_iov_add_page() and
bio_iov_add_zone_append_page()

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..7857b9ca5957 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,7 +1204,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
 		unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
@@ -1214,27 +1214,27 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				&folio->page, len, offset, &same_page)) {
 		bio->bi_iter.bi_size += len;
 		if (same_page)
-			bio_release_page(bio, page);
+			bio_release_page(bio, &folio->page);
 		return 0;
 	}
-	__bio_add_page(bio, page, len, offset);
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return 0;
 }
 
-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
 		unsigned int len, unsigned int offset)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool same_page = false;
 
-	if (bio_add_hw_page(q, bio, page, len, offset,
+	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		bio_release_page(bio, page);
+		bio_release_page(bio, &folio->page);
 	return 0;
 }
 
@@ -1258,9 +1258,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
-	unsigned len, i = 0;
-	size_t offset;
-	int ret = 0;
+	unsigned int len, i = 0, j;
+	size_t offset, folio_offset;
+	int ret = 0, num_pages;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1301,15 +1301,49 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
+
+		/* Calculate the offset of page in folio */
+		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+				offset;
+
+		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
+
+		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+
+		if (num_pages > 1) {
+			ssize_t bytes = left;
+			size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset,
+						 bytes);
+
+			/*
+			 * Check if pages are contiguous and belong to the
+			 * same folio.
+			 */
+			for (j = i + 1; j < i + num_pages; j++) {
+				size_t next = min_t(size_t, PAGE_SIZE, bytes);
+
+				if (page_folio(pages[j]) != folio ||
+				    pages[j] != pages[j - 1] + 1) {
+					break;
+				}
+				contig_sz += next;
+				bytes -= next;
+			}
+			num_pages = j - i;
+			len = contig_sz;
+		}
 
-		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			ret = bio_iov_add_zone_append_page(bio, page, len,
-					offset);
+			ret = bio_iov_add_zone_append_folio(bio, folio, len,
+					folio_offset);
 			if (ret)
 				break;
 		} else
-			bio_iov_add_page(bio, page, len, offset);
+			bio_iov_add_folio(bio, folio, len, folio_offset);
+
+		/* Skip the pages which got added */
+		i = i + (num_pages - 1);
 
 		offset = 0;
 	}
-- 
2.25.1

