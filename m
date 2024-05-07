Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369314273
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146672; cv=none; b=PgQO6lzScpbS06/yb9P27JFLyzs/QxC1fdYojC4vTU1hlBRVHktHPPPSNn4NU+A4QDys/qrrsp0mxxyH82WwwbUsdg0XvnnxyDp9/FJ/QHkBD7sGxfYMzzRmQ0qFtBMLTUGt+oz8DK7JfK0LHcYeeNXSwSx10Qt3vGgS9+PAIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146672; c=relaxed/simple;
	bh=0t+iazXb0oQed4nfQWFOESyncTUo+2gX42SIZ5iy7Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Fgz3UqMDh3zISDz+/gFeLGfC5OeJCmZgGNTqIxKPcWuG4dXJ7+rzjFQXZeyk0GJL6n1beEziE7F+oXyF4igZP/cKTuyRHP3tlDjOWf5BmSz4IDy15Hsv3TSrgGD/dwP9/SYxtRkYRWAX/6l0JbxuSDRotIx43MELlLrE0wnf0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nbwOkWCS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nbwOkWCS"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240508053747epoutp01ed5141cb9e043aa44b9a713dab932810~NbM6mItUU1979919799epoutp01j
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240508053747epoutp01ed5141cb9e043aa44b9a713dab932810~NbM6mItUU1979919799epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715146667;
	bh=IIbfaRdLQWOuaFq30MoGCp/C8CgWODxBmzHQcjZa1Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbwOkWCSwmsRHNNMh79vJIds4CXtgSxZFjOkuj0vWmmf9phIiYwU1yLPH2Ku7/BWE
	 PEs3+IQEta2/wWxyBQX86a7NOZCc2aGjPIPLejdxLfqVAWdsEbFoK55iWd1bM5jSe/
	 Rxarg6naNlqb0PhdeqaPwJdkn5X/U/Q6x1ONiKfY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240508053747epcas5p2f09887eb6e495680607a9a5c670846b5~NbM6MZo1D2079420794epcas5p2T;
	Wed,  8 May 2024 05:37:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VZ3nj4DY7z4x9Q9; Wed,  8 May
	2024 05:37:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.EE.09666.9AF0B366; Wed,  8 May 2024 14:37:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240507145326epcas5p1ce10f0e232cee06bae6a2115c2192eaa~NPIxtDWbV2534225342epcas5p16;
	Tue,  7 May 2024 14:53:26 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240507145326epsmtrp10d8da3ee67baa7d1d7956ac28d34b866~NPIxsPwTG0639106391epsmtrp1r;
	Tue,  7 May 2024 14:53:26 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-ac-663b0fa93757
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.4D.09238.6604A366; Tue,  7 May 2024 23:53:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507145325epsmtip162013f8d022d64dc2a84d64edb8d6fae~NPIv7p_b32912429124epsmtip1i;
	Tue,  7 May 2024 14:53:24 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH v3 3/3] block: unpin user pages belonging to a folio
Date: Tue,  7 May 2024 20:15:09 +0530
Message-Id: <20240507144509.37477-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507144509.37477-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmpu5Kfus0g5XP5C2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsajpstsBYu5K9ZsncjYwPifo4uRk0NC
	wETiQu8Lti5GLg4hgd2MEtNn/2WGcD4xSjQc3MsKUiUk8I1R4s0NZpiO24+fQBXtZZTovrSV
	EcL5zChxvfs+excjBwebgK7Ej6ZQkAYRoIaXK2+D1TALfGCU2DRpDSNIQljARWLfv+tgNouA
	qsSnGZdYQGxeAVuJG8fXMEFsk5eYeek7O4jNKWAn0bfmASNEjaDEyZlPwOqZgWqat84Gu0hC
	YCqHxOyVh6CaXSSuHD3OCmELS7w6voUdwpaSeNnfBmVnSxxq3ABVXyKx80gDVNxeovVUPzPI
	M8wCmhLrd+lDhGUlpp5axwSxl0+i9/cTqFZeiR3zYGw1iTnvprJA2DISCy/NgIp7SCy41s4E
	CayJjBJXP85nmsCoMAvJP7OQ/DMLYfUCRuZVjJKpBcW56anFpgWGeanl8FhOzs/dxAhOtVqe
	OxjvPvigd4iRiYPxEKMEB7OSCO/RdvM0Id6UxMqq1KL8+KLSnNTiQ4ymwACfyCwlmpwPTPZ5
	JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUw6WmZ/v3CWqUgKCnE
	bHRXi+V/gG0Oz9cM2+YGmTy+YiWeFHXj+tZVpWZ7zXN/c1c+3iF9mfsK5622F7Ncpn72NqpZ
	52xSJrOKSedgW1S77WT3pbKVrrcqPs6Valu/75teyv8vfqWR1WtbWN3Mv2Sx2ZUma5iK25Vu
	E7iwV7w1dXP6Oht77iWtOn5SH1RCbht3Gvy7wmNR41uV2qxvxpXWF+lpESB4/Pfsx5L/+fgX
	rK+1aa9gtdJeP8twdm+gbaxC6YJQ7Q23gwqfWsfssLfYoaJ+fb9YarudnInbt9sXJZo91mzW
	8S6yO2t9+EGH4DxF16NPz6pFr15XVLrTuMMqbe7ZPQoqG6vXyi1WYinOSDTUYi4qTgQA84Cz
	0z4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnG6ag1WawYx5hhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8ajpMlvBYu6K
	NVsnMjYw/ufoYuTkkBAwkbj9+AlzFyMXh5DAbkaJI5PnMUIkZCR2393JCmELS6z895wdougj
	o8THZY+AOjg42AR0JX40hYLUiAhYSDxvXs4EUsMs8ItRYsejFcwgCWEBF4l9/66DDWURUJX4
	NOMSC4jNK2ArceP4GiaIBfISMy99ZwexOQXsJPrWPACrFwKquf11LRtEvaDEyZlPwHqZgeqb
	t85mnsAoMAtJahaS1AJGplWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMHRoKWxg/He
	/H96hxiZOBgPMUpwMCuJ8B5tN08T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6Yklq
	dmpqQWoRTJaJg1OqgWnD3rObn3Da6Wj+3P5zZarJFMWQR+dMX0kmFX1Z4RUpc/1UOu/tmAl/
	44K2f/Zddu1x3I77Xptuz2k+etXrk9tz4e1Kjp47pLdbsdSefxg296/J+waFs30XO5I1rjNn
	MSrf63F5VWS49Si7xo0natNybDrfLVqXnS7R6rN7wxO1N0cXPFP+Ftj66cjPe53as5dlrGD5
	cTj0Upmn/t4XniHqeYczDr/+2jHvIuP/myeeMlqX7GLI4uzUyA2X8Nq+w3bPyuMNzsa8PoVi
	3Q91jR5Zddqwbs827fG8wdv4srl4+hPrCb9k3tnumKn+4uh172Q170uOejNcdh7iameNeih8
	8I2SleXS14v7DgjsdqpRYinOSDTUYi4qTgQAvZXSy/UCAAA=
X-CMS-MailID: 20240507145326epcas5p1ce10f0e232cee06bae6a2115c2192eaa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240507145326epcas5p1ce10f0e232cee06bae6a2115c2192eaa
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
	<CGME20240507145326epcas5p1ce10f0e232cee06bae6a2115c2192eaa@epcas5p1.samsung.com>

Unpin pages which belong to same folio. This enables us to release folios
on I/O completion rather than looping through pages.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e2c31f1b0aa8..510327b8852e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1154,20 +1154,12 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
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
@@ -1307,6 +1299,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		} else
 			bio_iov_add_folio(bio, folio, len, folio_offset);
 
+		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
+			unpin_user_pages(pages + i, num_pages - 1);
+
 		/* Skip the pages which got added */
 		i = i + (num_pages - 1);
 
-- 
2.25.1

