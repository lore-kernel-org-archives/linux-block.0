Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98499179B8
	for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lYqIOvq+"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231222103020epoutp04c488cca257bce6a4b88d156d4d349ae2~jIK8aZeUT1376713767epoutp04B
	for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 10:30:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231222103020epoutp04c488cca257bce6a4b88d156d4d349ae2~jIK8aZeUT1376713767epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703241020;
	bh=pEQGgOPTcqETZolXEfFV9/7ezY8OG9aH3Hn4l5epnJ4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lYqIOvq+haKFwBGmiRKQ6bgwtOooPLE2h4qeP89K5zLhPNQy1aMMhtq3aLbTdf+4Q
	 cFxkb84taaOfK059KqP9uRXiSP/RMy55Nu1Y2aQshMMHEV9y7N0ABr1E30Fq4waDGh
	 MEP98EBEuzFYwPljAuMDPXTEBjET9POL/D9iJjJI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231222103019epcas5p13144cb9ad2d5a419bd7a841048f1551e~jIK74FqqV2248622486epcas5p1k;
	Fri, 22 Dec 2023 10:30:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SxNpr2GSjz4x9Pv; Fri, 22 Dec
	2023 10:30:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.A0.09634.33565856; Fri, 22 Dec 2023 19:30:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231222102344epcas5p43711f96bd85104cfcb3e3a1fab5eeaee~jIFLX8uZI2865628656epcas5p4I;
	Fri, 22 Dec 2023 10:23:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222102344epsmtrp2082f09b99daf78f3ca8ae9f7eecd7f46~jIFLXUMnc2382423824epsmtrp27;
	Fri, 22 Dec 2023 10:23:44 +0000 (GMT)
X-AuditID: b6c32a49-75a53a80000025a2-4d-658565331a48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.0B.07368.0B365856; Fri, 22 Dec 2023 19:23:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231222102343epsmtip1e2565b14e3c37c534b47b0ae9957e192~jIFKSOnfB1535315353epsmtip1b;
	Fri, 22 Dec 2023 10:23:42 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, Kundan Kumar <kundan.kumar@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2] block: skip start/end time stamping for passthrough IO
Date: Fri, 22 Dec 2023 15:47:07 +0530
Message-Id: <20231222101707.6921-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmlq5xamuqwfNPFhar7/azWaxcfZTJ
	4uj/t2wWkw5dY7TY+uUrq8XeW9oObB6Xz5Z6bFrVyeax+2YDm0ffllWMHp83yQWwRmXbZKQm
	pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
	JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6xbLF9w
	iLOiffMHpgbGr+xdjJwcEgImEu92bWXpYuTiEBLYzSixvGsbM0hCSOATo8SW/0UQiW+MEtuv
	v2PqYuQA69j3wAYivpdRYtuXa8wQzmdGidvX7jKDFLEJ6Er8aAoFGSQiYCSx8+9rNhCbWSBf
	4tHT6WC2sICXxOZtK5hAbBYBVYmNHfMZQWxeARuJ6SuOsUFcJy8x89J3doi4oMTJmU9YIObI
	SzRvnQ22V0LgGLvEtPk9rBANLhJfHh6HahaWeHV8C9SbUhKf3+2FimdLHGrcwARhl0jsPNIA
	VWMv0XqqH+x+ZgFNifW79CHCshJTT61jgtjLJ9H7+wlUK6/EjnkwtprEnHdTWSBsGYmFl2ZA
	xT0kVh39xgQJ0FiJy5+fME5glJ+F5J1ZSN6ZhbB5ASPzKkbJ1ILi3PTUYtMCw7zUcnisJufn
	bmIEp0Etzx2Mdx980DvEyMTBeIhRgoNZSYQ3X6clVYg3JbGyKrUoP76oNCe1+BCjKTCMJzJL
	iSbnAxNxXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTLaz/9X4
	6Kt+5b0bo//gsqXg5+jTheulcroi7s1/+CRgy/RTPNr/535dvv9bTEvNqszE7cvvrdQomp6u
	vclAY9VCNpv4km/sz97v5X91e3O/7pJE6Qt7kt5nCM650Pzm51vmW43lc5Q+t175e7I8ybf/
	4q2ZZ3oDHcVXNL58O+ec0Cu76VkLD6/Ve8byTTbW5Uk663lFkRszN+1VDL3hXHL+eLe20ISb
	znlSszry6991vLq2KM1zZW304Q0rFqzyn2C2ZaLkNJ+0Cc25vp+Fqv7ufvBM5dRPj5aTn2a/
	90v+bNahM8nl6/1t2+Jv39y18FDLXdG+U9u/fv1c82basVVvNrxbPasvTmJl+68pK+L4qpRY
	ijMSDbWYi4oTAdxyq0IMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnO6G5NZUg52PuSxW3+1ns1i5+iiT
	xdH/b9ksJh26xmix9ctXVou9t7Qd2Dwuny312LSqk81j980GNo++LasYPT5vkgtgjeKySUnN
	ySxLLdK3S+DKWLdYvuAQZ0X75g9MDYxf2bsYOTgkBEwk9j2w6WLk4hAS2M0ocefIbqYuRk6g
	uIzE7rs7WSFsYYmV/56zQxR9ZJSYuOEZC0gzm4CuxI+mUJAaEQEzif3nNjKDhJkFCiX+bBIF
	CQsLeEls3rYCbCSLgKrExo75jCA2r4CNxPQVx9ggxstLzLz0nR0iLihxcuYTFhCbGSjevHU2
	8wRGvllIUrOQpBYwMq1ilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAgOSC2NHYz35v/T
	O8TIxMF4iFGCg1lJhDdfpyVViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2amp
	BalFMFkmDk6pBqYuzSMzDt6OUmJs759To3PN5eeKG52V6k6iz+yPHuCVX/R1R/iv/XLGGTN2
	6BzXtGoTsPAWddvZv6TnrUT7m5MCy89cS1LJ4G+OKRcI/Nm9dclTWaYXGZeatnr9TSrQcj2S
	dPvV/vzFt1+G7N97wCfgyqfLvid/XVjm+bM16+Hkj6lbv0T0vOBiiFr2Qqls+9sfJeVz/54v
	2WSgw7WXZYZM08rq2fW/z3s7ulx5qx8ScubtE6Wie8VhH3altkeq8J/YebQ9r51h/mHvmrXn
	13/96COyYk/WrmfvjOXmsIfdXnbIe1W5mZWm8trOap72ZX8apNqalFcVuHCphUzZsSu/7Glt
	97VQ1YXlp75w/zFSYinOSDTUYi4qTgQAVNwgK7cCAAA=
X-CMS-MailID: 20231222102344epcas5p43711f96bd85104cfcb3e3a1fab5eeaee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222102344epcas5p43711f96bd85104cfcb3e3a1fab5eeaee
References: <CGME20231222102344epcas5p43711f96bd85104cfcb3e3a1fab5eeaee@epcas5p4.samsung.com>

commit 41fa722239b4 ("blk-mq: do not include passthrough requests in I/O
accounting")' disables I/O accounting for passthrough requests. Since tools
like 'iostat' do not show anything useful for passthrough I/O, it's
wasteful to do start/end time-stamping. So do away with that.

Avoiding the time-stamping improves the I/O performance by ~7%

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes compared to v1:
- Modified commit description.
- Made code cleaner with bit of separation.

 include/linux/blk-mq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..a676e116085f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -830,6 +830,12 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
+	/*
+	 * passthrough io doesn't use iostat accounting, cgroup stats
+	 * and io scheduler functionalities.
+	 */
+	if (blk_rq_is_passthrough(rq))
+		return false;
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
 }
 
-- 
2.25.1

