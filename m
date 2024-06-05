Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9774963B
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580846; cv=none; b=gEMqynfHGjLZIapL9dFKvG6ch+vyHastmkTCGFs8pMveW/VDTv+KfZe6eJYPLJb19VSIESHJriEIXJs1uIrO/FdtD7GgqFLySdWSB+E+uARZpN2HfJsR45RMiG+i2pocNWlfcXBpYYB+Jp5pG5REH6R9MXZUdDCuL3E61zoigvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580846; c=relaxed/simple;
	bh=jphH6dwz1cNPfoL0yTl66O88ntqJUjdtffNc/I3p/rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=p2YslxPJRBdMAbfha1mSgjD/tiz9NI3ZZzZKqPxzVzNWNkruMuy7Cb1QkEmurjq2Oc5GOTZXzH2utJOdLtVWYoL62cRSOrevS3y/C9Z8oH3fkEEvgE2C6SNp1Eqb/ovpbuITZMZmgfVk3IBipG5sHreRcPrljg2H5Sr8YnWahx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fzGizY3h; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fzGizY3h"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240605094721epoutp03d36be791310b667c5c333918b206f9bc~WEqzTMQLh1503815038epoutp03Y
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:47:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240605094721epoutp03d36be791310b667c5c333918b206f9bc~WEqzTMQLh1503815038epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717580841;
	bh=74u9IHD4jU2yLvZgFueYmVwx6n9tO2kSu7pq0WcDg1Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fzGizY3hhcUxdK5p8Elyvbws4PruBA35fr6OM3f9uL8zkI0HPY+yqzwPipWuuYhT1
	 4ThdM92TvPNBTMp4woetAqnXJ0fZKsMQXWPRACAjX412XTgAkfqfRTCmFOvJ5u4tVA
	 0cM+SurXn5wrYgs4euxQ1JiXXtd/b8upuH7nBHaw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240605094720epcas5p1f8cbeea3f41258661d136eeafb4acc70~WEqyBsLt_1854718547epcas5p1C;
	Wed,  5 Jun 2024 09:47:20 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VvN0k2gpyz4x9Px; Wed,  5 Jun
	2024 09:47:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.61.19174.62430666; Wed,  5 Jun 2024 18:47:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240605093220epcas5p18c9f9d8fe89f53f91f7c1c2464b07a65~WEdsa59Tm0833108331epcas5p1b;
	Wed,  5 Jun 2024 09:32:20 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240605093220epsmtrp1b04afe6fce8d9de3f8231c80296aa4c4~WEdsZeekL2905729057epsmtrp1T;
	Wed,  5 Jun 2024 09:32:20 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-69-666034263dbc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.4E.07412.4A030666; Wed,  5 Jun 2024 18:32:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240605093218epsmtip2e7c4e532148132f3711da229deaaaf33~WEdqntE3X3189331893epsmtip2i;
	Wed,  5 Jun 2024 09:32:18 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v4 0/2] block: add larger order folio instead of pages
Date: Wed,  5 Jun 2024 14:54:53 +0530
Message-Id: <20240605092455.20435-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhq6aSUKawfIrQhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PVRr2ClcIV73c3sjYwruTvYuTkkBAw
	kdhz4B5TFyMXh5DAHkaJm6desEM4nxgl/rc9ZoRwvjFK/N5xGyjDAdby600WRHwvo8Spee+h
	Oj4zSrROO8QKUsQmoCvxoykUZIWIgLvE1JePwAYxC5xllDgx9RELSEJYwE2ie+dRNhCbRUBV
	4u3Ek+wgNq+ArcTU1b+ZIe6Tl5h56TtUXFDi5MwnYL3MQPHmrbOZQYZKCPxkl7h0/zILRIOL
	xJQJj5kgbGGJV8e3sEPYUhIv+9ug7GyJQ40boGpKJHYeaYCK20u0nupnBnmAWUBTYv0ufYiw
	rMTUU+uYIPbySfT+fgLVyiuxYx6MrSYx591UqBNkJBZemgEV95BY2n4Y7BchgViJX7dnsE9g
	lJ+F5J1ZSN6ZhbB5ASPzKkap1ILi3PTUZNMCQ9281HJ4xCbn525iBCdUrYAdjKs3/NU7xMjE
	wXiIUYKDWUmE1684Pk2INyWxsiq1KD++qDQntfgQoykwkCcyS4km5wNTel5JvKGJpYGJmZmZ
	iaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUwLJr/JPZPNc4mzfOncumdM9Tw5b9gv
	hE17IJ1z+k+w+bPCGA0Dx5nB9n4n4gyuVi17a+dldidvRSmnw65kFum2OVNDpbLKTZ/tFmWe
	G3i5g832h5IVn11vBmf5q787jm+r+NRX0ndPouWgF4cqy9Jek/IaV5P+S4mbLXPfCW2JSbH7
	J/oxL60sfGXSho3CJ+da7/r3hk+5WKlEyYZhZ2XtussJ33NUHVZym6zqcK1YqMgiUyOafE5W
	QD7h9eXg039cV3G+dAn4E1Nwr/aRvavy9i63l6bbxYu0Q3Jut5hXf1cK7Ta525Qbzfz55PnG
	mn+sG57NNkx6/8zeyPXf58v9JfHJjQ7vZDSD5l5SYinOSDTUYi4qTgQA5YONJzEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvO4Sg4Q0g7NvFSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr49VGvYKVwhXv
	dzeyNjCu5O9i5OCQEDCR+PUmq4uRi0NIYDejxI8Fh9i6GDmB4jISu+/uZIWwhSVW/nvODmIL
	CXxklLg+jxekl01AV+JHUyhIWETAV2LBhueMIHOYBa4zStyYvpUZJCEs4CbRvfMo2EwWAVWJ
	txNPgs3hFbCVmLr6NzPEfHmJmZe+Q8UFJU7OfMICYjMDxZu3zmaewMg3C0lqFpLUAkamVYyS
	qQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwWGtpbGD8d78f3qHGJk4GA8xSnAwK4nw+hXH
	pwnxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAxGmiUXhd
	573r1ftGc3Ye5TpvHDjd8NxZh7UnctZ13uyd2XazI0PT73CUamdVMXtP5/3Xtgmi0hcai47F
	e+vtXdqY/L0lfsf/3Eaeqc7iDT3erf3x1sdWJJf8EjP47XMllsv1YvHVCAabU9Mq9qvpTM04
	G+S761+U7mvW9ZW+ia1qm0sX2k6eN/f+uuQXp3gbeQ5PzTopVxCT8T+61vPCHZk5Z8NtAr0D
	uict2yO44+je0IfyDWaLz/nvPH478Ni+utqjR9O/3rodrnTpwgHeCO0LM7/NucSQpTAjPX/N
	nYaEFe73PDfavOYuEX/76H+LfaSHmW+H7KagG9NWNy4yrn1ddKjjXva2mxMtL1ocUGIpzkg0
	1GIuKk4EAEc7mcbaAgAA
X-CMS-MailID: 20240605093220epcas5p18c9f9d8fe89f53f91f7c1c2464b07a65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605093220epcas5p18c9f9d8fe89f53f91f7c1c2464b07a65
References: <CGME20240605093220epcas5p18c9f9d8fe89f53f91f7c1c2464b07a65@epcas5p1.samsung.com>

User space memory is mapped in kernel in form of pages array. These pages
are iterated and added to BIO. In process, pages are also checked for
contiguity and merged.

When mTHP is enabled the pages generally belong to larger order folio. This
patch series enables adding large folio to bio. It fetches folio for
page in the page array. The page might start from an offset in the folio
which could be multiples of PAGE_SIZE. Subsequent pages in page array
might belong to same folio. Using the length of folio, folio_offset and
remaining size, determine length in folio which can be added to the bio.
Check if pages are contiguous and belong to same folio. If yes then skip
further processing for the contiguous pages.

This complete scheme reduces the overhead of iterating through pages.

perf diff before and after this change:

Perf diff for write I/O with 128K block size:
     1.32%     -0.33%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
     1.78%             [kernel.kallsyms]  [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
     3.99%     -1.61%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
     5.21%             [kernel.kallsyms]  [k] bvec_try_merge_page

Patch 1: Adds changes to add larger order folio to BIO.
Patch 2: If a large folio gets added, the subsequent pages of the folio are
released. This helps to avoid calculations at I/O completion.

Changes since v3:
- Added change to see if pages are contiguous and belong to same folio.
  If not then avoid skipping of pages.(Suggested by Matthew Wilcox)

Changes since v2:
- Made separate patches
- Corrected code as per kernel coding style
- Removed size_folio variable

Changes since v1:
- Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page()
  to accept a folio
- Removed branch and calculate folio_offset and len in same fashion for
  both 0 order and larger folios
- Added change in NVMe driver to use nvme_setup_prp_simple() by
  ignoring multiples of PAGE_SIZE in offset
- Added a change to unpin_user_pages which were added as folios. Also
  stopped the unpin of pages one by one from __bio_release_pages()
  (Suggested by Keith)

Kundan Kumar (2):
  block: add folio awareness instead of looping through pages
  block: unpin user pages belonging to a folio

 block/bio.c | 75 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.25.1

