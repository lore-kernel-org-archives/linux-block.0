Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5286818592A
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049799; cv=none; b=LPioFvl3W/pJNd4YnihWJ2R4AxGJVUIT3wEm18wbCoYMC0roor08JydcHBKvWVWHdZOBJgbwpYDJSy9c+frLGZevH+eTVxZxng/T6omIxVgr9tGle+9SsgjCY0BvICYcAOzuZfrM2/6ApHBhlwxDNsFsrhkzSsjZ3FIualtoQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049799; c=relaxed/simple;
	bh=WAkOVAwwamnujEFGE2a4OD68FfuJjjANRzbwtc08quc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WGY4bMnN6X8JW2ah85cexi+blmPB7QpAARq1WkUPG9920BDkrPD8XDpcF4K508L4PgqMd6tvA9wFWy7d0LIwrqFCIAaeiveUWfzxdH93PxrJwBSgx5jKKXiexBY2R8+2G/dK07GX65J1h5pbtsWCV/TGpQyl5Ukyv9lfW8znBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vhen8FnJ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vhen8FnJ"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240911101634epoutp04c4fbbc9afab5574e5ae1ab19f4793763~0KSST5PFn0832608326epoutp04j
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 10:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240911101634epoutp04c4fbbc9afab5574e5ae1ab19f4793763~0KSST5PFn0832608326epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726049794;
	bh=UzIhHAg39DcSb8cXxMjMCgJSfhKXz707G0JqpnSnnJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vhen8FnJogT1WXGWqQi2LgUkaF0T/32Kw96ooZKHI/LFPknJ9uZJRwCQbDsSmljO9
	 jQKt+qruHLGde18Puaod7+6famoOivaSJA3WEqboerKhZ9UEvrnd+q8Q9jwhXnqSQF
	 qRMTR7ZP4Z9kuHQQO4ZpDydtu/f1cC5FpIQCjsD4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240911101633epcas5p117ca4a0706cf0f47bab4bfaca138a9e6~0KSRskIaY0582305823epcas5p1g;
	Wed, 11 Sep 2024 10:16:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X3c1B6M10z4x9Q0; Wed, 11 Sep
	2024 10:16:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.ED.09743.EFD61E66; Wed, 11 Sep 2024 19:16:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240911065714epcas5p485cedd2626301a5920924e93595ba338~0HkQSOnCg0337403374epcas5p4n;
	Wed, 11 Sep 2024 06:57:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911065714epsmtrp132bf90c11d944d13708beb625760f8cb~0HkQRObvh1549315493epsmtrp1E;
	Wed, 11 Sep 2024 06:57:14 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-92-66e16dfe8165
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.CA.08456.A4F31E66; Wed, 11 Sep 2024 15:57:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911065712epsmtip18b08288745893c3a52ffb3743d4175fa~0HkOK07o00656206562epsmtip10;
	Wed, 11 Sep 2024 06:57:12 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v10 1/4] block: Added folio-ized version of
 bio_add_hw_page()
Date: Wed, 11 Sep 2024 12:19:32 +0530
Message-Id: <20240911064935.5630-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911064935.5630-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmhu6/3IdpBpta9CyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM57+7WIvuC9Q0XC3k6WBcT9v
	FyMnh4SAiUTD5wfsXYxcHEICuxklLh7vZoFwPjFKrNn0mA3C+cYo8ezWZnaYlu4fExghEnsZ
	JW5MucoK4XxmlDi68TJQCwcHm4CuxI+mUJAGEQF3iakvH4E1MAs8ZZS48uUnK0iNsIC/xKGt
	VSA1LAKqEpd3/GcBsXkFbCRuz13LBrFMXmLmpe9gizkFbCUO/3jMBFEjKHFy5hOwemagmuat
	s5lB5ksITOWQmPjgDzNEs4vElL+bWSBsYYlXx7dAfSAl8bK/DcrOljjUuIEJwi6R2HmkASpu
	L9F6qp8Z5E5mAU2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2msScd1Oh1spILLw0gwlk
	jISAh8T9jVKQoJrAKNG2cDXLBEaFWUjemYXknVkImxcwMq9ilEwtKM5NTy02LTDKSy2HR3Jy
	fu4mRnDK1fLawfjwwQe9Q4xMHIyHGCU4mJVEePvt7qUJ8aYkVlalFuXHF5XmpBYfYjQFhvdE
	ZinR5Hxg0s8riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoHJKFBJ
	K9zsv+FxpekHome07Njv1CzTzu397shW/ia5+SUvir+If8qf1Gw7d9FEfmaPnYx8TDaGfE9i
	mvW2vq1KWzQ/M9Fpu7Z7mMFUidv9PkEH/T97ODArP9hb5djz8ZHR1eMLZ2YcTSvir1XUl2Fg
	OTf/k/OFs8uZq3aZf3C1bRTacd3l0BSRxUxrP69jO6JgH7s6rC2LVzVDSGqa3cO4+H25jZdu
	X9Z5qKRzg0Us8/r9R3Y2z58qnTnodDNL9/Ib1kBx97CyHvMHvTH8FclyHvzzog79nyNXUnx1
	z/GzvoYHnrux+RmU/Pp6I0Xdcfr6+/cnX2iRlAjsWnK35X3q55QzuwPr/n7Qvvqc464SS3FG
	oqEWc1FxIgA1fnTRQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK6X/cM0gwX/tS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZT/92
	sRfcF6houNvJ0sC4n7eLkZNDQsBEovvHBEYQW0hgN6PEl+1QcRmJ3Xd3skLYwhIr/z1n72Lk
	Aqr5yChx+uMdoAYODjYBXYkfTaEgNSICvhILNjwHm8Ms8J5R4vYSaRBbGCi+ckYrM4jNIqAq
	cXnHfxYQm1fARuL23LVsEPPlJWZe+s4OYnMK2Eoc/vGYCeIeG4k/G1pZIeoFJU7OfMICMV9e
	onnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHBNaWjsY
	96z6oHeIkYmD8RCjBAezkghvv929NCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeW
	pGanphakFsFkmTg4pRqYtujKL7q9nodv/5InkZkP5Q58dSzYwyF3pFT0X8wy7o78A6dm1Bzb
	fXHZHN4StXWLY+4u47u8/6fxGdnnp7OZJkTxzs5czhXd46X1xPrAXa+clRGdIvcWP9vWNL9V
	tKT2w80l0tIdNq8kM7d/WlrZvt+N1+HZ1SenPgZoG0Z6ZbV18lre6EqKn3S84KWRp3DF+6js
	7W+XHuM8y2Bz38OgJCzGJYBVau4J8xPPyiz+zfmVvfvWbrYi11AHlSv2enNKbvb3Od2oC/q8
	hPm0uQOfwJpNkTEH3jZcT/ln2HuYM/Kq29TO3a+Pi7/U/LhH3eZ8TMQWu13vzrV+nhLvXvj6
	sNjbvwlX3PXuXOsqFeGTUWIpzkg01GIuKk4EAKrgBGb4AgAA
X-CMS-MailID: 20240911065714epcas5p485cedd2626301a5920924e93595ba338
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911065714epcas5p485cedd2626301a5920924e93595ba338
References: <20240911064935.5630-1-kundan.kumar@samsung.com>
	<CGME20240911065714epcas5p485cedd2626301a5920924e93595ba338@epcas5p4.samsung.com>

Added new bio_add_hw_folio() function as a wrapper around
bio_add_hw_page(). This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 23 +++++++++++++++++++++++
 block/blk.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c4053d49679a..f9d759315f4d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1016,6 +1016,29 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
+/**
+ * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @folio: folio to add
+ * @len: vec entry length
+ * @offset: vec entry offset in the folio
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same folio
+ *
+ * Add a folio to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
+ */
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
+		unsigned int max_sectors, bool *same_page)
+{
+	if (len > UINT_MAX || offset > UINT_MAX)
+		return 0;
+	return bio_add_hw_page(q, bio, folio_page(folio, 0), len, offset,
+			       max_sectors, same_page);
+}
+
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
  * @q: the target queue
diff --git a/block/blk.h b/block/blk.h
index 1a1a18d118f7..c718e4291db0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -574,6 +574,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
+		unsigned int max_sectors, bool *same_page);
+
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
-- 
2.25.1

