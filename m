Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF514D6EE
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043903; cv=none; b=QKP+uyYYMH9GTu25IstdtzUZ3d4aYAybI+mbINJrMllNkoH/ov7n5F2rkzYNrwxUJ0JDefipf5tgQRN8Zi8gsR6ht7IMcEWhCKJBiWXfeMI+N0R2+edC+WY49HSvb0cu8EEddAySpz2Hbuf9r3CNuNQUNJcaRpRHwWWCSsfUef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043903; c=relaxed/simple;
	bh=AOOXX/PpXpHShWSxYqscfUQ6a5aimIvfQ/8rvqPY/ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mWJRHo8oHjQWbjmortfZ3QAIBs4zZ5xToccuuruimfL+ftBWLLfXSb8q3d/OrJfkkGkG3Bd1if66Oa1luFg/wzZi4M9py1jiOlbXFV9N6aDqN/SrQSmHrBWEGpGUjkSatSV1JfD/Gji1BQKuey5lOLO89MYepY/SJQpcNLxrgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Rbl9SEIW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rbl9SEIW"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240911083814epoutp0221387b6bce43597c24b08ee66700e41d~0I8bYdb0H3006130061epoutp02d
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240911083814epoutp0221387b6bce43597c24b08ee66700e41d~0I8bYdb0H3006130061epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726043894;
	bh=uOnA/n2n1TxoIKZ93GC+m5sD2RuswlYMcSPB6a+VORU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rbl9SEIWOafwG+Cm2DB9ZBDeLWE4zaOaRhK2SQwTx+zuL0LnjCU95Bl4HUmK4rPBN
	 MFc/prSN5OxGSoYSFN7O9ZGkbOJq8jS0RiUQ7L3vknwX0mXIiiX4TNF5qi5E8G8QMQ
	 SBVUuTv9GhRA+PFt5Yt4xoeaNBbb3LZYpNOExUlc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240911083813epcas5p4c130ed6eb77c979d16c01e1a9a90bec6~0I8a21VOV2676726767epcas5p4h;
	Wed, 11 Sep 2024 08:38:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X3Yql1Z13z4x9Py; Wed, 11 Sep
	2024 08:38:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.1C.09743.2F651E66; Wed, 11 Sep 2024 17:38:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911065719epcas5p2c9312abec1eada7df3d08c883f1557bb~0HkUocEqy0581905819epcas5p2x;
	Wed, 11 Sep 2024 06:57:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911065719epsmtrp277700653aa42902d09727b95c5099461~0HkUnoNmc0673206732epsmtrp2l;
	Wed, 11 Sep 2024 06:57:19 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-96-66e156f295f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.D1.19367.F4F31E66; Wed, 11 Sep 2024 15:57:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911065717epsmtip16623d3a9a4808b44c00f3a979fb525f6~0HkSnPV3l0661206612epsmtip1Z;
	Wed, 11 Sep 2024 06:57:17 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v10 3/4] mm: release number of pages of a folio
Date: Wed, 11 Sep 2024 12:19:34 +0530
Message-Id: <20240911064935.5630-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911064935.5630-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhu7nsIdpBusbmCyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMx4/bWUs6OermPrzBVsD41Xu
	LkZODgkBE4mG/6eZQWwhgd2MEhfn1HYxcgHZnxgl/q6Yxgbn3OiaxAzT8XQRSAdIYiejxJ6P
	81kgnM+MEg17zwO1cHCwCehK/GgKBWkQEXCXmPryESNIDbPAU0aJK19+soLUCAvYS1ybYAJS
	wyKgKnHvxiGwMK+AjcTHP/UQu+QlZl76zg5icwrYShz+8ZgJxOYVEJQ4OfMJC4jNDFTTvHU2
	2D0SAhM5JNZtv80G0ewi8WzCQnYIW1ji1fEtULaUxOd3e6FqsiUONW5ggrBLJHYeaYCqsZdo
	PdXPDHIPs4CmxPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW01izrupLBC2jMTCSzOg4h4S
	r2cvY4eE9ARGiV93QiYwKsxC8s4sJO/MQti8gJF5FaNkakFxbnpqsWmBUV5qOTyKk/NzNzGC
	062W1w7Ghw8+6B1iZOJgPMQowcGsJMLbb3cvTYg3JbGyKrUoP76oNCe1+BCjKTC4JzJLiSbn
	AxN+Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTMJhN+SMZ216
	fiKZUf127v3MkCTj4896S7eqLw6+fdfD+Hv/vu333p+2rrITOvly/lEBlw1PV30JSHY42yYX
	YXvuoI5Gep2a9bMGI70f50oSdr+yCspiYZ3Pssoi1O3CCbVHteUeLgLCPEu/+q/93X5DY6/s
	7ut6SV98N//XW7Lqg2XuTP3/rPynHq/hNmOXWpP8OdJK8ei7++mPj08Pvvqjy5ZDs88114/D
	hLO7cMvPJ7dm/b92+s0Z6Uoj27Czhhp3PS5s+Vyie2VBoo1+PZtxTMvOn8YnnvhxcdeWNNxM
	YenPVvmx794be4957MqfNwnbzru5LuVvzRrj9gPiGVnaxQ7XLgm+SFj29Uc6nxJLcUaioRZz
	UXEiAHAYkC9ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK6//cM0gzdzZS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZj5+2
	Mhb081VM/fmCrYHxKncXIyeHhICJxNNFp5lBbCGB7YwSX1f6QsRlJHbf3ckKYQtLrPz3nL2L
	kQuo5iOjxPeF31m6GDk42AR0JX40hYLUiAj4SizY8JwRxGYWeM8ocXuJNEiJsIC9xLUJJiBh
	FgFViXs3DrGChHkFbCQ+/qmHmC4vMfPSd3YQm1PAVuLwj8dMENfYSPzZ0Ap2Aa+AoMTJmU9Y
	IKbLSzRvnc08gVFgFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGC40AraAfj
	svV/9Q4xMnEwHmKU4GBWEuHtt7uXJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEk
	NTs1tSC1CCbLxMEp1cCUbZSVym9o79gvuu/oXt0dF1asbckwznEqW7i5Uj7gKNP0nFcl/1Kr
	T6snavz9Y7c1aOaXzz37ErOtNT9fUW9X+dZ76Y/R2TD+Z8WlLNla9SmaZyzOzRb8LPplbsnv
	ax1thzX4gjdFHctYlqa3+oDBxUfJLQIPXFo4FPK9uY76/TfdsTnLNyfRcX6Kfa/7q5Zqrc7H
	PG7lLdJWyc8vT7P6k3q/dV2q1ZkjrVH6nQU3PhoHbM+Z9GPWIm9ftrlnF8gveFTN4Db977aj
	h6rVhNbs/f4/L7+N+xh7kSqr+7qVigfOW15zL+i0ferQUcGs8qFl4WH/rgNHZ3pJ5fI+N8uf
	dsn8bnePFcMCpkrPNCWW4oxEQy3mouJEAKoZomDyAgAA
X-CMS-MailID: 20240911065719epcas5p2c9312abec1eada7df3d08c883f1557bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911065719epcas5p2c9312abec1eada7df3d08c883f1557bb
References: <20240911064935.5630-1-kundan.kumar@samsung.com>
	<CGME20240911065719epcas5p2c9312abec1eada7df3d08c883f1557bb@epcas5p2.samsung.com>

Add a new function unpin_user_folio() to put the refs of a folio by
npages count.

The check for BIO_PAGE_PINNED flag is removed as it is already checked
in bio_release_pages().

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979b28..3de55d295cb9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1597,6 +1597,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
+void unpin_user_folio(struct folio *folio, unsigned long npages);
 void unpin_folios(struct folio **folios, unsigned long nfolios);
 
 static inline bool is_cow_mapping(vm_flags_t flags)
diff --git a/mm/gup.c b/mm/gup.c
index 54d0dc3831fb..02c46ae33028 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -415,6 +415,19 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
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
 /**
  * unpin_folios() - release an array of gup-pinned folios.
  * @folios:  array of folios to be marked dirty and released.
-- 
2.25.1

