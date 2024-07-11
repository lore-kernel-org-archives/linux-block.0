Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE557C9A
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675214; cv=none; b=p9kne4jUa2cMhHJpmZ/HFJUCS40FfgLowGCyehZyF2tGImEfYGLJJ7Tb5sd5VkknT2bNqlmkK44PzaIUfLVD1dCNZVzRfZRSujz+qiVzopfVE5KCCrxVubE5fh8ldnEJl/HJ0WaD+BbSUK43cLbHTZwBoD9H0yBKm0xhiIEqupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675214; c=relaxed/simple;
	bh=rSKYGNVjFYQH02tNPX+U7xM3SxzXt/NKEpLblMc1exY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TNbqWTw4EIKkE/TTodj7bytW2UnCZhM3s98ys1xy6Dk1jhfRd/ZOPmKAP3MdOJEEQAnbZ2q4VdXcQ0eLMGQU0ilOiqybE9OREeZOv7lWxzzdHH3U7vUzmvb9JPfFsc7wQVKuZvSjOj5xJctsG4R81mCZcQ9Qrbb1rEHPgWjHtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aoytN8pJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aoytN8pJ"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240711052011epoutp02322b0d6b1372819b82de9b533f15ad29~hEPzlnZ3w2369923699epoutp02H
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240711052011epoutp02322b0d6b1372819b82de9b533f15ad29~hEPzlnZ3w2369923699epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675211;
	bh=yHVjrWtU8SuENtWXOsNgz4Dsm3fiKVmVwCBSAJkmvHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoytN8pJxPq/TbUL8o7O8vmYZV7iq3Hr1yO9mYpPrWmnFD675bQJGvJEJYJAaFm3q
	 hvVpUkxpOiKj2xAQl5sERuen5G0a/h6R9quVYd+vk45NTgHNfXazDiu4qvRXSjZp7R
	 Itqqs/UE8EvHszUuDiAjJII/rJahFUgWWMs560ho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240711052010epcas5p4e8f042da2d3120aa0bea8fa9ecd470a4~hEPzMGKKU1595615956epcas5p4x;
	Thu, 11 Jul 2024 05:20:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WKNMr4t8pz4x9QL; Thu, 11 Jul
	2024 05:20:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.AB.09989.88B6F866; Thu, 11 Jul 2024 14:20:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240711051539epcas5p2842f564375dc2f1c3de1a869c938436b~hEL28b6982906029060epcas5p2E;
	Thu, 11 Jul 2024 05:15:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711051539epsmtrp22634bc89d99894ebd9917ecc2d9d1288~hEL27nuUX1688716887epsmtrp2G;
	Thu, 11 Jul 2024 05:15:39 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-f1-668f6b889ecd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.C5.07412.B7A6F866; Thu, 11 Jul 2024 14:15:39 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051537epsmtip1e11024a9e8cbedd25132a557d3f93cef~hEL1QeGWe0258502585epsmtip13;
	Thu, 11 Jul 2024 05:15:37 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 4/5] mm: release number of pages of a folio
Date: Thu, 11 Jul 2024 10:37:49 +0530
Message-Id: <20240711050750.17792-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmum5Hdn+awctvChZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+NW1w+mgqU8FRMfhzQwtnJ1MXJwSAiY
	SCxZH9/FyMUhJLCbUeLfn81MEM4nRokrl/pZuhg5gZxvjBKn/umD2CANLb9ms0MU7QWJT2OD
	cD4zSlxdMJEVZCybgK7Ej6ZQkAYRAXeJqS8fMYLUMAucZZQ4MfUR2FRhATuJ76cegNksAqoS
	H3Z3MILYvAK2Etdnb2KF2CYvMfPSd3YQmxOofuOfdywQNYISJ2c+AbOZgWqat85mBlkgIdDL
	IdH56xATRLOLxO6mBmYIW1ji1fEt7BC2lMTnd3vZIOxsiUONG6DqSyR2HmmAqrGXaD3Vzwzy
	DLOApsT6XVDfy0pMPbWOCWIvn0Tv7ydQrbwSO+bB2GoSc95NZYGwZSQWXpoBFfeQaPr7ABq8
	Exkl3m6YwDqBUWEWkn9mIflnFsLqBYzMqxglUwuKc9NTi00LjPJSy+FxnJyfu4kRnGa1vHYw
	PnzwQe8QIxMH4yFGCQ5mJRHe+Te604R4UxIrq1KL8uOLSnNSiw8xmgIDfCKzlGhyPjDR55XE
	G5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwJSf+eG3pCxP/fICudj3
	tvuOJrwXuXenVOx2yRL7l9kLF5448UM9OS/+dNDfWX2OW1cEGV93+itcyBjLxx5UvXb/hD99
	Imya2SfF3IvlYh4ZMfeo7ThkKl/c+dLH565YtU2F2+qdW5gnSe7T/VL0LVG+ovXK/2fLtvW1
	Lwqetvyas/XjxdfeTd+2T0Dq4F+XT81nWWbJn7wd82/KmvvsQfvOB68XT19+1S5HrGgDE6PP
	5B/bi61X73VY8Cb+xrasjdHZs90vJvKlVcvt+bT4YlGqudrEc3ZRH7ZvPrigjqvcagV3opt4
	aPCzv0JB1842uFe+PLXN0WbrnMwIn7iiGwqWhqybQzb43DaMKL4n6KrEUpyRaKjFXFScCACP
	nFu5PAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG51Vn+awaHfahZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcavrB1PBUp6K
	iY9DGhhbuboYOTkkBEwkWn7NZu9i5OIQEtjNKNFx+DQrREJGYvfdnVC2sMTKf8+hij4ySpxr
	ucTcxcjBwSagK/GjKRSkRkTAV2LBhueMIDXMAtcZJW5M38oMkhAWsJP4fuoBC4jNIqAq8WF3
	ByOIzStgK3F99iaoBfISMy99ZwexOYHqN/55B1YvBFTzf9sVdoh6QYmTM5+AxZmB6pu3zmae
	wCgwC0lqFpLUAkamVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwbGgpbGD8d78f3qH
	GJk4GA8xSnAwK4nwzr/RnSbEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC
	1CKYLBMHp1QDEz+b4YL1lWHBlWIsHSz33iZOkY9ySJT8dDJm3m8tObOVsX3l835Wn4rwaGi4
	nnWQd/v3sttzZ7rnhy10nfpPno2nyfqQd3R02IabO4VrpSb/mrBaMKI2b3vuvAy982eqpk3/
	1KX7wWDtLV2vKY02VltaUz+tddPcNbN6/sTC1aolU7fMUTRoz3SaE/Xvs/NvW7V95lZSSot/
	/DjVZfb8UJzYvJP6m3Y3sE87c9WGawtrq833iYfCw+TtF6vKL3+RzbyjamPAxPPJiZfuMxpP
	uF20vmBFXO6VmWVaubcvmu99mchsdlTXyMZ+xqEoldUss9tmd/HbbVWcns4y+bF8SPy+K+Z3
	ok09Pvd6+9YyK7EUZyQaajEXFScCALUoE+/0AgAA
X-CMS-MailID: 20240711051539epcas5p2842f564375dc2f1c3de1a869c938436b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051539epcas5p2842f564375dc2f1c3de1a869c938436b
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051539epcas5p2842f564375dc2f1c3de1a869c938436b@epcas5p2.samsung.com>

Add a new function unpin_user_folio() to put the refs of a folio by
npages count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..fcf9b6263326 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1623,6 +1623,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
+void unpin_user_folio(struct folio *folio, unsigned long npages);
 
 static inline bool is_cow_mapping(vm_flags_t flags)
 {
diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..bc96efa43d1b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -488,6 +488,19 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 }
 EXPORT_SYMBOL(unpin_user_pages);
 
+/**
+ * unpin_user_folio() - release pages of a folio
+ * @folio:  pointer to folio to be released
+ * @npages: number of pages of same folio
+ *
+ * Release npages of the folio
+ */
+void unpin_user_folio(struct folio *folio, unsigned long npages)
+{
+	gup_put_folio(folio, npages, FOLL_PIN);
+}
+EXPORT_SYMBOL(unpin_user_folio);
+
 /*
  * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
-- 
2.25.1

