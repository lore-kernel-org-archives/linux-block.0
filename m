Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708718FDAD
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580854; cv=none; b=Ox+mKEG6lopT9xfR9MIqV4hSl/v6PsLTWn4ulinG0P1uT0DbQIgqxwkJAuqh2RBe5zzM6a2ePWfxf4uVfr7EnFvdXpFxFTdj3kaMEfQGbjy0OhsvjzQYt4YpJGd8XktQw/3HHG8+XOYveD59inavZSryVqyk1YtDXSThU7m+92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580854; c=relaxed/simple;
	bh=twWVhE0qODsH13l8jNlnYU6LMTSQAMjcBl9X8fIvn10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VpRDrPBZNfkWfH6Kx/ViSbAXiguyXAD0PrSY5XaAuIBgtzacaN7WxSSEC3hVF/rU7yqY56Y1sPyfMo3lYT7XRy1qO8qs7R9DkAerRHzdMPQb2P0dEZ0ERrONycG9odVuwG1H5MUFUJ1GP4KEgYt3F59PGljTsEVwPy7Wre8RvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AoiKFC96; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AoiKFC96"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240605094730epoutp03ca7ac9488d436ddee03440bf29df098a~WEq7-McvU1454214542epoutp030
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240605094730epoutp03ca7ac9488d436ddee03440bf29df098a~WEq7-McvU1454214542epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717580850;
	bh=vEiOcRtnbcv+SVB6C6T2s2ws1aVXj9VFiwsT7ZEL6UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoiKFC96jgTnImtRVM8PQA9OddAAdvNtlNKlnhJoLZp8hI90c4pcIep/7fWsE2/oD
	 rMxOKMe5TrTG6+3s6Z7G9cHaMxPEijV3Hvqqj6QK0xjN9rEiI05qwG2OE6C78ynwmS
	 dGLbwJUt7m07T8s9joH3TpasBjt72cYSlqrxMDa4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240605094730epcas5p1fa8ffcb50c36f69bdab51e7e6d383b1a~WEq7oqPOm0305703057epcas5p1E;
	Wed,  5 Jun 2024 09:47:30 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VvN0w3bw2z4x9Q2; Wed,  5 Jun
	2024 09:47:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.25.08853.03430666; Wed,  5 Jun 2024 18:47:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9~WEd49sY1W0833508335epcas5p1w;
	Wed,  5 Jun 2024 09:32:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240605093234epsmtrp2d559341e5b8690ae545f91b7432b48ec~WEd48gCJH0105501055epsmtrp25;
	Wed,  5 Jun 2024 09:32:34 +0000 (GMT)
X-AuditID: b6c32a44-d67ff70000002295-32-66603430f1bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.23.08336.1B030666; Wed,  5 Jun 2024 18:32:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240605093232epsmtip2258d7d272d666f567578917b46da1492~WEd3ODD-G3189331893epsmtip2s;
	Wed,  5 Jun 2024 09:32:32 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v4 2/2] block: unpin user pages belonging to a folio
Date: Wed,  5 Jun 2024 14:54:55 +0530
Message-Id: <20240605092455.20435-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605092455.20435-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhq6BSUKawZ014hZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2NL42KWgsXcFZdOPGNqYPzP0cXIySEh
	YCIx+0Q3G4gtJLCbUaLpT3EXIxeQ/YlRonPyMVYI5xujxOZjH5m7GDnAOqbeqoFo2Mso0ftX
	AaLmM6PEjNvLWUBq2AR0JX40hYLUiAi4S0x9+YgRpIZZ4CyjxImpj1hAEsICLhI/f/xlArFZ
	BFQl7mw+xQhi8wrYSix8cJEF4jp5iZmXvrOD2JwCdhLfW3tYIWoEJU7OfAJWwwxU07x1NjPI
	AgmBqRwSTTOeMEE0u0gc2NDCDmELS7w6vgXKlpL4/G4vG4SdLXGocQNUfYnEziMNUDX2Eq2n
	+sEeZhbQlFi/Sx8iLCsx9dQ6Joi9fBK9v2FW8UrsmAdjq0nMeTcV6n4ZiYWXZkDFPSTOfDwO
	DdCJjBIvPq9inMCoMAvJP7OQ/DMLYfUCRuZVjJKpBcW56anJpgWGeanl8DhOzs/dxAhOs1ou
	OxhvzP+nd4iRiYPxEKMEB7OSCK9fcXyaEG9KYmVValF+fFFpTmrxIUZTYIBPZJYSTc4HJvq8
	knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY6sQdJT4YJ1f9epYy
	9+L5hISfAdV19VL1gjPYNoTrNgiL/PwZkX/xwKv68szp97j3vL28WHHZwtDFqzPn3i+pCeq9
	9rp03iS+O91Lft+beP9Z3ln7m9u2Gk+YWLRz0kKOPxaf5JYfbWcw47ly17nEmI0vdnrnEcE5
	HTNUlyyxPtoaHrK4vCKIxalHKm/F8v/ft7c6MyZ+tZpVa/h7+5wfd01ilnz8rDm1Y3ls8Ksz
	qeekF5wPPNTx6vCS90ePnIlde1PlqhnndvFwLQfBtNxr4R8EIngFJsks1bsRsPWI8eRPPWtS
	j8z89cz8+Kxg9a69N35fvDMl8+va5mCbpX4z3e5Nz/l2Rvp6ufWP/mXPT+5TYinOSDTUYi4q
	TgQASGWUmzwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO4mg4Q0gyvOFk0T/jJbrL7bz2bx
	fXsfi8XNAzuZLFauPspkcfT/WzaLSYeuMVps/fKV1WLvLW2LGxOeMlps+z2f2eL3jzlsDjwe
	m1doeVw+W+qxaVUnm8fumw1sHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWxpXExS8Fi7opL
	J54xNTD+5+hi5OCQEDCRmHqrpouRi0NIYDejxN2XnaxdjJxAcRmJ3Xd3QtnCEiv/PWeHKPrI
	KHHu4DZmkGY2AV2JH02hIDUiAr4SCzY8ZwSpYRa4zihxY/pWZpCEsICLxM8ff5lAbBYBVYk7
	m08xgti8ArYSCx9cZIFYIC8x89J3dhCbU8BO4ntrD9hiIaCaXTu2skDUC0qcnPkEzGYGqm/e
	Opt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeCluYOxu2r
	PugdYmTiYDzEKMHBrCTC61ccnybEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2
	ampBahFMlomDU6qBKTf2ys15+4vUdD9PuZddNfPQ9S37ExgCq7vTmCUqZTmXT963ascVowK7
	5jSHhzZa5s/4rp3Zfvbb0RXn716dyNnQ9b6ssM6kevn1dyuyohZ0+xye0Jpkf5VPT8LpcQmz
	yxyNLBerXA7nirUru23uHpl/qOCKVe8yC9s9y3tuvDXNv8wvcviKw6bsb3yXd6RtYp4irPu8
	u7zUyvbIu7lMnpv6s3+fzLwbc9SvV/Ki9aQ390KyzHKEIgtu/s3nu1AkOn3xBu7leWcjdViK
	/t+dqPP3kcC1nje7ZywyPDLTqD1hysSrN2bd1Xv/QPdhvE2Sy13jK6mRdgqh85YkaD688HbL
	pqaYpHv7v4qXnZy6sFCJpTgj0VCLuag4EQBap/ns8wIAAA==
X-CMS-MailID: 20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
	<CGME20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9@epcas5p1.samsung.com>

Unpin pages which belong to same folio. This enables us to release folios
on I/O completion rather than looping through pages.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7857b9ca5957..28418170a14a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1166,20 +1166,12 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
-		size_t nr_pages;
-
 		if (mark_dirty) {
 			folio_lock(fi.folio);
 			folio_mark_dirty(fi.folio);
 			folio_unlock(fi.folio);
 		}
-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
-		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
-			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		bio_release_page(bio, &fi.folio->page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1342,6 +1334,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		} else
 			bio_iov_add_folio(bio, folio, len, folio_offset);
 
+		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
+			unpin_user_pages(pages + i, num_pages - 1);
+
 		/* Skip the pages which got added */
 		i = i + (num_pages - 1);
 
-- 
2.25.1

