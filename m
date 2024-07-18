Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6D42078
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284027; cv=none; b=SNe76mkQoR/TONL67qy0ZgwG0k3Nl8mQFzQn9N9IBd/Z1oZLY1Km3d7uBPYJR1M5b8S/CaaB/fjMszohWBEhdXCmJjxiL1w5HoOBw4yQye3jJnUjqnLqjxkBATlMuRB8YE0lpm2U3uPXCTkvIJ/Sq79soQ9HI8NdNGuSiIlKtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284027; c=relaxed/simple;
	bh=pX7Vwe2eg8rZ9cz5H5KFkPaUqSdSDHtpfaKivV0z84Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=IlCAq1eWuRzbfzMnofMOOsd5qtWj8KDPvyouZOSKBc4Jrq5vL0UcSx/nau37X0lrzP/hKcZe6tDkUvixRdWvFNXoQeGtER71NCI+zGTeBb/N6x40uKGgyxX+l1Gzx6CI0lf1uJO8KJLOWQqUrMA9ka4gn+ErUOJtXCYUqrL+hWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Qo0At2Xj; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Qo0At2Xj"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240718062655epoutp04372bf6d6d42f256366844c3c56f4fa7e~jOrFIW7I83118431184epoutp04O
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 06:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240718062655epoutp04372bf6d6d42f256366844c3c56f4fa7e~jOrFIW7I83118431184epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721284015;
	bh=7ZcAMht8xlSnYrGuBrsSxLXkl1tAH13BP9erpjQ9yO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qo0At2XjEQlCuzayGb6ash+YjF1Y4TSQ76ceflFnl1+uiN+zrZrZFNKRmOnSxCnWP
	 1qUM7rD7SndxAEcwTCzRjZoK+3gMmFI+I/X+g9LsNFx8+qlk3Mirzwn+pzz+pHDLy7
	 Lc5IGNTCqCEt/UKEkwah0wcRyBk8SC8lX+RYrruo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240718062655epcas5p3476411759b66d5c9f71d7cd145760dc4~jOrEou4091855718557epcas5p3u;
	Thu, 18 Jul 2024 06:26:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WPjWd29XTz4x9Py; Thu, 18 Jul
	2024 06:26:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.76.06857.BA5B8966; Thu, 18 Jul 2024 15:26:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240718062458epcas5p3361131a4a69af7a5e4f0624384c9596a~jOpYB8vu70110401104epcas5p3x;
	Thu, 18 Jul 2024 06:24:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240718062458epsmtrp2e09f94052ffc644733af0f0bdefd0391~jOpYA8q751501015010epsmtrp2k;
	Thu, 18 Jul 2024 06:24:58 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-2d-6698b5ab805a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	17.91.19057.A35B8966; Thu, 18 Jul 2024 15:24:58 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240718062456epsmtip238bfc452c086df634acfff3d6b7834b9~jOpWWpCAA3269532695epsmtip2E;
	Thu, 18 Jul 2024 06:24:56 +0000 (GMT)
Date: Thu, 18 Jul 2024 11:47:32 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 5/5] block: unpin user pages belonging to a folio at
 once
Message-ID: <20240718061732.2wjd6lkdwm5yd5fh@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240711050750.17792-6-kundan.kumar@samsung.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmpu7qrTPSDJqeqlo0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsWNCU8ZLbb9ns9s8fvHHDYHbo/NK7Q8
	Lp8t9di0qpPNY/fNBjaPvi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
	1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
	U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x//h3xoLnAhXnj2k0MP7i7WLk5JAQMJGYsv4E
	SxcjF4eQwG5GiVdXvzJCOJ8YJc6s38IK4XxjlNj54Dc7TMv7TyegEnsZJd7+fwPV8oxR4sTV
	OUxdjBwcLAKqEt0HjUBMNgFdiR9NoSC9IgLuElNfPgIrZxZYwijRvew0K0hCWCBIYtKGTWAL
	eAXMJKbffcEKYQtKnJz5hAXE5hSwkzjw5iRYjaiAjMSMpV+ZQQZJCMzkkNh56TkbxHUuEqe6
	V0DZwhKvjm+BulpK4vO7vVDxbIlDjRuYIOwSiZ1HGqBq7CVaT/Uzg9jMAhkSd/8+YYSIy0pM
	PbWOCSLOJ9H7+wlUL6/EjnkwtprEnHdTWSBsGYmFl2ZAxT0kTh7ZwAYJoKOMEku3/WGcwCg/
	C8lzs5Dsg7CtJDo/NLHOAgYes4C0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY56WWwyM8
	OT93EyM47Wp572B89OCD3iFGJg7GQ4wSHMxKIrwTGKelCfGmJFZWpRblxxeV5qQWH2I0BcbV
	RGYp0eR8YOLPK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBiWO6
	6+WXidaWjSJTcj2zHuxVLRXwu3H052qWhu3vfr9z+DDni4JGcgqfq8jnI27cvm37nmpYxF85
	ZHku6PWGee83zqi4YrOr9oXxgexLa3h/bbyodmWry7ReTvv9zwT2uFpP/DW5Ki71iXLEf9YD
	s+50TN/MJf1CM2ZJVLDjsXlZHt9WhMUpljmfif4668u9yRtM/AufXH/wJiy0XfvBttnzrV4/
	4f7BMFXxyBP5n3F50v33ZzVVlkf3KZbs9F+pGM7GfEHwa6LwxytXpGfVCHSmZCy2Kd65foJm
	Pyv/qWdte9dxauZdt0n5dLx2epvyJYZXomemrarNPWO5TjymhpFzQsmRf08Ejv1K2hr0YbkS
	S3FGoqEWc1FxIgCmgmSXRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK7V1hlpBl+XSlo0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsWNCU8ZLbb9ns9s8fvHHDYHbo/NK7Q8
	Lp8t9di0qpPNY/fNBjaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyrh7aANjwUy+iocnvrI0
	MB7j7mLk5JAQMJF4/+kEaxcjF4eQwG5GiRl/trJDJGQkdt/dyQphC0us/PecHaLoCaPErMYF
	QAkODhYBVYnug0YgJpuArsSPplCQchEBd4mpLx8xgpQzCyxhlOhedhpsjrBAkMSkDZvA5vMK
	mElMv/sCavFRRonfPx8yQyQEJU7OfMICYjMDFc3bDBLnALKlJZb/4wAJcwrYSRx4cxJsjijQ
	nTOWfmWewCg4C0n3LCTdsxC6FzAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4X
	La0djHtWfdA7xMjEwXiIUYKDWUmEdwLjtDQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YI
	CaQnlqRmp6YWpBbBZJk4OKUamOYrlWzSW+nde/nrKY7vrFfFVnVab/tZaGCy7dmTGybKcrv5
	SnULPhv8XKVb38sVzHrcZOPv/vsrI+vfn17wMOhhQBqXb1N6y7MHmm59ZQfYbs7d1jpTbvu+
	jomLOt+6PLC377wZI3fBPtKMm2uK9rq9/7fYCQc1KCxxVnJMPHHuMwf7Yf36QxL/lC/3/Z3F
	dyjGQ9La7rNnzKvkq/nTWK/MaI/332G2Qar+kFj2r0CWiPU370V3enM6ufIkB5XJp+99fT/6
	e1jZ/qn8cU/YVdN12yz2Rj10sl+W05OUHHuZsbH++pX7E+bdUY/u6nOa/Z51soxkyvEskxbz
	qV6r4idfnbGC986W1nDbQ1c1lFiKMxINtZiLihMB6wSG5gYDAAA=
X-CMS-MailID: 20240718062458epcas5p3361131a4a69af7a5e4f0624384c9596a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----YdvOALZa7xp5qf7MXFUWGWphRDZkQHqOUVBuFxEP30Uth0fc=_1ee4a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5@epcas5p3.samsung.com>
	<20240711050750.17792-6-kundan.kumar@samsung.com>

------YdvOALZa7xp5qf7MXFUWGWphRDZkQHqOUVBuFxEP30Uth0fc=_1ee4a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 11/07/24 10:37AM, Kundan Kumar wrote:
>Add a new wrapper bio_release_folio() and use it to put refs by npages
>count.
>
>Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>---
> block/bio.c | 6 +-----
> block/blk.h | 6 ++++++
> 2 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/block/bio.c b/block/bio.c
>index b4df3af3e303..ca249f2c99a7 100644
>--- a/block/bio.c
>+++ b/block/bio.c
>@@ -1207,7 +1207,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
> 	struct folio_iter fi;
>
> 	bio_for_each_folio_all(fi, bio) {
>-		struct page *page;
> 		size_t nr_pages;
>
> 		if (mark_dirty) {
>@@ -1215,12 +1214,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
> 			folio_mark_dirty(fi.folio);
> 			folio_unlock(fi.folio);
> 		}
>-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> 		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> 			   fi.offset / PAGE_SIZE + 1;
>-		do {
>-			bio_release_page(bio, page++);
>-		} while (--nr_pages != 0);
>+		bio_release_folio(bio, fi.folio, nr_pages);
> 	}
> }
> EXPORT_SYMBOL_GPL(__bio_release_pages);
>diff --git a/block/blk.h b/block/blk.h
>index 777e1486f0de..8e266f0ace2b 100644
>--- a/block/blk.h
>+++ b/block/blk.h
>@@ -558,6 +558,12 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
> 		unpin_user_page(page);
> }
>
>+static inline void bio_release_folio(struct bio *bio, struct folio *folio,
>+				     unsigned long npages)
>+{
>+	unpin_user_folio(folio, npages);
>+}
>+
> struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
>
> int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);

Hi Christoph, Willy a gentle ping here. Any comments on the v8 patchset?

Thanks,
Kundan

>-- 
>2.25.1
>
>

------YdvOALZa7xp5qf7MXFUWGWphRDZkQHqOUVBuFxEP30Uth0fc=_1ee4a_
Content-Type: text/plain; charset="utf-8"


------YdvOALZa7xp5qf7MXFUWGWphRDZkQHqOUVBuFxEP30Uth0fc=_1ee4a_--
