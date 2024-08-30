Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE11662EF
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007172; cv=none; b=dis+lTZLB7LwVWsNUlLkys0eIv8yPYHpdXym5jfJCSXG2uKzb6GHx04TFRY+kcISjxIqOFni1yYr0UOsvP3o2S7A4ireF845HwSAihfoMrhQdAnaAXngCaWxUan4a364/19ICKy9WFfZoz6G3CYjn1aNwVHTcJrO7A43SfpU11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007172; c=relaxed/simple;
	bh=n2HUi6PFCGAkq0mstaYuRZAybzk7iMZWOVRW7SRVuMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kcwaR7eZpqWaPJ6CjSgbD838/ak5KKZaCsUUxJCTmY9gsJsMvknN2jqDSoZOwYA9UF6agtTQCegRBxehmk5Ik+XhGQD5VglZs4niw+hzMjtub2jvinHEEdqv9rZDKZErRxYRpyJ6uyG79z8k6faeNvvRLaNiR7+UUssrLrdfO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tB70YN9e; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tB70YN9e"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240830083928epoutp01c3aaa84cfa0189039260329dbaa84bbf~wdOFDoQL53095930959epoutp01x
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240830083928epoutp01c3aaa84cfa0189039260329dbaa84bbf~wdOFDoQL53095930959epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725007168;
	bh=0QdpAren0i/GWvhy3FyOVRnoFaWVPDnsAUuF7B3DNWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tB70YN9e3hTSF1+m2molvdWz2TNR8mdexPYUsyzzosedS9pkF5Y1MHnrEnvt+yYsr
	 Kn+mdFBdp9FJAyIprJ7Hj2rXJ+QrC66vhTKXskl7DfwOPsGskDOEj3Ak/f7/M4Vyih
	 rfnun4xF1AWn72Gp6BoMgyefgltW0MFF2eDtnmo4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240830083927epcas5p2a1401afc46cdc94e447c8b4d80b7b18e~wdOEd2hCN2102921029epcas5p2h;
	Fri, 30 Aug 2024 08:39:27 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WwBQj1SkYz4x9QC; Fri, 30 Aug
	2024 08:39:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.73.08855.B3581D66; Fri, 30 Aug 2024 17:39:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240830080056epcas5p40dc8e28fb3b0cc8314b2194d953191ef~wcsbyn8Bt0244102441epcas5p4a;
	Fri, 30 Aug 2024 08:00:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240830080056epsmtrp2e663df72d3c40afec3da1e9243f2cb99~wcsbw-VsT0971409714epsmtrp2c;
	Fri, 30 Aug 2024 08:00:56 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-f6-66d1853b7f5c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.58.07567.73C71D66; Fri, 30 Aug 2024 17:00:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080053epsmtip29b90d05c3a3b3a92b44843ad1d4c544e~wcsZTV4Yp2259122591epsmtip2N;
	Fri, 30 Aug 2024 08:00:53 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v9 3/4] mm: release number of pages of a folio
Date: Fri, 30 Aug 2024 13:22:56 +0530
Message-Id: <20240830075257.186834-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830075257.186834-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmhq5168U0g2tvmS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMzp7F7IVXOataHvZwdbAOJ+7
	i5GTQ0LARGLVtlMsILaQwG5GiWkXQroYuYDsT4wSj/dOZYJwvjFK/Jn5nAmm4+C+B4wQib2M
	EqefrGKGcD4zSrw4Nw+oioODTUBX4kdTKEiDiIC7xNSXj8AamAWeMkpc+fKTFSQhLGAnsejF
	EbCpLAKqEmc3/AOL8wLFF5zbwgKxTV5i5qXv7CA2p4C9xJb5PVA1ghInZz4Bq2EGqmneOhvs
	CAmBmRwSK7qvs0I0u0jc+3cFyhaWeHV8CzuELSXx+d1eNgg7W+JQ4wao10okdh5pgKqxl2g9
	1c8M8gyzgKbE+l36EGFZiamn1jFB7OWT6P39BKqVV2LHPBhbTWLOu6lQ98tILLw0AyruITHh
	+Ut2SGBNYpTYcngb4wRGhVlI/pmF5J9ZCKsXMDKvYpRMLSjOTU9NNi0wzEsth8dycn7uJkZw
	0tVy2cF4Y/4/vUOMTByMhxglOJiVRHhPHD+bJsSbklhZlVqUH19UmpNafIjRFBjgE5mlRJPz
	gWk/ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJgf73cXHlnvN
	LDmuYn7wfb9Defm8tOsNcXUCHDtr5Nl4OxfLXHzRUakv5Xs3hsNzcvG0q5EzL797eOuIDc+F
	300fV/QGh92d78wadPiiy0zFWcry3fUdi9efXCzNsY3xUEzFlaz7nMqu61gXpLJ2nhLru/hb
	/k9IhfPUuS/eGk17mXQtwuP8i5PCG9VKbwfnLX3iKfSO7fuvJT6fUr8smzNV5UQ928eHMi4L
	DebXKnl27Graovpidts2p302llvurHo8qz7wVUCGdezD03zXFjBz7xQ9lxT4Lv6KmO8X0++s
	WuYTm++W3y6e+o7jmUuqz2+GOacSlncd59x2ardcgbH19NofXFNOX88z9H1QoqPEUpyRaKjF
	XFScCABL9ui5QwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK55zcU0g75JZhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni/Kw57Ba/
	f8xhc+D12LxCy+Py2VKPTas62Tx232xg8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mzt6F
	bAWXeSvaXnawNTDO5+5i5OSQEDCROLjvAWMXIxeHkMBuRon711rYIBIyErvv7mSFsIUlVv57
	zg5R9JFRouPKWuYuRg4ONgFdiR9NoSA1IgK+Egs2PGcEsZkF3jNK3F4iDWILC9hJLHpxhAnE
	ZhFQlTi74R/YTF6g+IJzW1gg5stLzLz0nR3E5hSwl9gyvwesRgiopuXqIiaIekGJkzOfsEDM
	l5do3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHhZbG
	DsZ78//pHWJk4mA8xCjBwawkwnvi+Nk0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmk
	J5akZqemFqQWwWSZODilGpiSDbm3HGpev+Knz6L+dbGTZn/kP1Xdt2N+5Y7A5bO04xnfNXuc
	f3FbbVqMvXhUgVBnwikGgZAAhc6pCffEdt+ZUyFWmPTu3wbmP49nGX4Pkv+XOrto/cEVt5gr
	ltx5IF8vHs//7JBFyZv0omkBSzZHCOX/Pnas7S/z1DUda3Q2WsR/2GZTFfvvb+VBVuMW2f3T
	lpq/ErpfENaqpfng1xzhJbPNhC5bO00o6fd+e4lBbpblEr70yxauHTPEI+0WNnws5xBYe1h2
	ns7xLvUv2k4rH4t8UNFxscyPdzR8Hcudks55ds4Mqy3su4ztyh2/CjZo8UpO3qDUcTk3Mqsh
	4cMZr/mfHhdnt7+dkTV1xgklluKMREMt5qLiRACfJmNN+QIAAA==
X-CMS-MailID: 20240830080056epcas5p40dc8e28fb3b0cc8314b2194d953191ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080056epcas5p40dc8e28fb3b0cc8314b2194d953191ef
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080056epcas5p40dc8e28fb3b0cc8314b2194d953191ef@epcas5p4.samsung.com>

Add a new function unpin_user_folio() to put the refs of a folio by
npages count.

The check for BIO_PAGE_PINNED flag is removed as it is already checked
in bio_release_pages().

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
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

