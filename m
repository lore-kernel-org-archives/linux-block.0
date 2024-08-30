Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AB16C440
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007939; cv=none; b=E5Ny8/fcvcP3alTNYzMq8muU96IyfuxxDCwoA4v6lUE9BuCc+mxHiswrZJU5W16KKWtrovA74DZ/mUCr2yS0Xh7IHMUzmH+t8tm4lyfVS+nJiIUf7CoKZrA0TJcig12w3s3n72GsviZxaJ0gvZnTe9XdAMWvMUBcDdWyYs7ijdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007939; c=relaxed/simple;
	bh=aeBS7gdL/3xjmQbSjOYfKzO1dajt3Jh0zH2ttufKAz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JIK1UmCZlKEGErpnfjIyfw+e1viRil12FJ+l+9UTCQ+HH+36BMjT36b23Hm1lRLU7GFF3UNz9VRr6Yoqcc2EKTdKshhP7Ir8TCA5VoxD6K5wO2q+1LmUhzZsdFlHOcgShYUmHzL70lKgcV79jmzcozAGJhw57D6Qm5PZnfylarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nA9eQO0z; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nA9eQO0z"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240830085215epoutp0323130bf6b319bf40bf9ca6de48f7ddfb~wdZPWSOzt3166031660epoutp03K
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:52:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240830085215epoutp0323130bf6b319bf40bf9ca6de48f7ddfb~wdZPWSOzt3166031660epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725007935;
	bh=A3CIaU/ZqoxuRMztzhjVWSU/nQ9Qy22m5o8A1GcGoK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nA9eQO0zadkjnScz8SffLaCCFQgiDGhJy+QWU/YILef5eXjHJgeZdQykXs5iAgbaG
	 eXaK/z/QG5R1zApM6s7OaEhYjKrmF20igmFr72odNWRFbBLAjw5XN8JK4FW4IdOHFO
	 M+6hkxWW/VCLMMPyJGGggGXL5gHcCSL++GXo3xrM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240830085214epcas5p2bbcdf7ff77c415b62c6726a4efce5923~wdZOu9Ncc1050210502epcas5p2M;
	Fri, 30 Aug 2024 08:52:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WwBjS4SKXz4x9Ps; Fri, 30 Aug
	2024 08:52:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.2C.09640.C3881D66; Fri, 30 Aug 2024 17:52:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080048epcas5p24013512a19c099ed51930f4ab0736ff0~wcsUZLKG81057810578epcas5p2W;
	Fri, 30 Aug 2024 08:00:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240830080048epsmtrp2f95aa7702866d175a9479a4ae576770e~wcsUYPT5b0971409714epsmtrp2R;
	Fri, 30 Aug 2024 08:00:48 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-de-66d1883c8d96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.58.07567.F2C71D66; Fri, 30 Aug 2024 17:00:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080045epsmtip26b477c40f9f2a41430fcd2ebdc743b28~wcsRzP2KI2504325043epsmtip2k;
	Fri, 30 Aug 2024 08:00:45 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v9 1/4] block: Added folio-ized version of bio_add_hw_page()
Date: Fri, 30 Aug 2024 13:22:54 +0530
Message-Id: <20240830075257.186834-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830075257.186834-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhq5Nx8U0g7ZN8hZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni/Kw57Ba/
	f8xhc+D12LxCy+Py2VKPTas62Tx232xg8+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0
	WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
	Chn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGZM6X7AVfOKv+H4kpYHxLk8X
	IyeHhICJxJFFN1m7GLk4hAR2M0qsvbGcHSQhJPCJUeLemhiIxDdGifWv3zLBdByd1M4EkdjL
	KPG4cSZU+2dGiYf3TjF2MXJwsAnoSvxoCgVpEBFwl5j68hEjSA2zwFNGiStffrKCJIQFfCQm
	7rvLDGKzCKhKbDwzjRHE5hWwk7i1byc7xDZ5iZmXvoPZnAL2Elvm97BC1AhKnJz5hAXEZgaq
	ad46mxmifiqHxIVHWhC2i8SpD7eg5ghLvDq+BcqWkvj8bi8bhJ0tcahxA9RnJRI7jzRA1dhL
	tJ7qZwb5hVlAU2L9Ln2IsKzE1FPrmCDW8kn0/n4C1corsWMejK0mMefdVBYIW0Zi4aUZUHEP
	iWetb6EBN4lRYnb7EqYJjAqzkLwzC8k7sxBWL2BkXsUomVpQnJueWmxaYJiXWg6P4+T83E2M
	4ISr5bmD8e6DD3qHGJk4GA8xSnAwK4nwnjh+Nk2INyWxsiq1KD++qDQntfgQoykwvCcyS4km
	5wNTfl5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUz5SjIFdzmO
	5s4QYTnpuafpc1dUY9HML5elp3BO1Zkzc8ZjqTTGf988l389+0Sqvs84wDxursayX2zdS/5u
	u7/4nkVXy815oj18DsrhH9jyfr1umpuzZfctHrGSJPG7uV+85At7P9yJqY99oS/8Krs+rz55
	S/cr47/vFvzy0WsuK3pjLtjNNKHQ7pv0fAeHh9cLzPzCX23bn3aV2/h1mejeg66dl7k6uxqe
	nw3+0f3z4gSTPGXW2gl7hBQiJknpLeU1UFVQ1plywv43+ySfbPn73QcL5jFoa7Ve8Zu+m82J
	3/GG0bRVJ98XZ11+I/Es8qf4DN7sTx6mjasW73m7bGm/4lLZkltOH8PtXPl2bVNiKc5INNRi
	LipOBAAL22UfQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK5BzcU0g3UxFk0T/jJbrL7bz2bx
	fXsfi8XNAzuZLFauPspkcfT/WzaLSYeuMVps/fKV1WLvLW2LGxOeMlps+z2f2eL8rDnsFr9/
	zGFz4PXYvELL4/LZUo9NqzrZPHbfbGDz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroxJnS/Y
	Cj7xV3w/ktLAeJeni5GTQ0LAROLopHamLkYuDiGB3YwS3Z/uskIkZCR2390JZQtLrPz3nB2i
	6COjxMu159m6GDk42AR0JX40hYLUiAj4SizY8JwRxGYWeM8ocXuJNIgtLOAjMXHfXWYQm0VA
	VWLjmWlgNbwCdhK39u1kh5gvLzHz0ncwm1PAXmLL/B6wvUJANS1XFzFB1AtKnJz5hAVivrxE
	89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4IrQ0djDe
	m/9P7xAjEwfjIUYJDmYlEd4Tx8+mCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEk
	NTs1tSC1CCbLxMEp1cBkuJ7z2E+Djfe4TjDbr6w4FZ6xRivgr/iGB0v5/RiflERIiFx0NuUU
	XGOYob/z3jVT5rYLuR8cVdWed9+qvMVT9VTlMn84V7P9A7/j9gp5oukmirlbzVMWrN1XpFxa
	8zK4id9nz936H0WKE+/se+SzbVt5gGN1sz7/PHNO07lTuazv3DA/lDBjrteubToqZrnWc7c7
	n4/Vu/loquD9uWeVt002Kyoxj5hRubl1ouqMSOmzghGMIedl12r+4Re3/vlig83XoMy1Gps6
	BZ9riS9rXuG14mqdjMuehaeEDLjMBT9sfTlJKrl379+my6rpf6PXMp1+ZiqrIBu/7ekSRi2/
	XgVLHuW32x7v6K7+8liJpTgj0VCLuag4EQCLrsE09wIAAA==
X-CMS-MailID: 20240830080048epcas5p24013512a19c099ed51930f4ab0736ff0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080048epcas5p24013512a19c099ed51930f4ab0736ff0
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080048epcas5p24013512a19c099ed51930f4ab0736ff0@epcas5p2.samsung.com>

Added new bio_add_hw_folio() function as a wrapper around
bio_add_hw_page(). This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
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
index e180863f918b..6afee998e80c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -540,6 +540,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
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

