Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795C1991AD
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502889; cv=none; b=KFJNwHgRil1JjTWbWKO5nG/jZzsYev4ipoKGK7aR1966EBjnzXqNnUFulDDs+5m+ThKilRALmxIAEWxnEWI6Sa37azOyYaJ6y1wl5ioAV8IEy3XfO4sTQ7cW3RgcegbZ2hNLnCNs5+3+gk9/3gZf1bh+RcC3POEAoOSDtleMum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502889; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CNIfpnoCjns8CJndjCXO1IbGJl33RR/5P7c10WsokVPk4Smn55/3FhX1S0OM/y10SQgzvD02ZSmG0u4BzRG3s4Wjsl/v0USbt24nVNfuDpg1mAkj1EELwaMydeSBEx6YNtUUQFFPIoRjDt2EeeW/PrIwnab1ih0NddMphUVQ9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DxEXBo4A; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DxEXBo4A"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240627154123epoutp039492076c87386ce722c4cdc8edfb5a95~c5sMrg-H02961829618epoutp03Z
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240627154123epoutp039492076c87386ce722c4cdc8edfb5a95~c5sMrg-H02961829618epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719502883;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DxEXBo4AyCLnnpufsHmrwS0XqYM1WeRMxnw32GLlWYIx2NswbFgZD2Zdlr4wX65dq
	 IDDHOj2d3ImJycqtoEhRZwRBsvYxF9zEfYptinRyZnwrD4SjRrcpN+ST4J49wCR7+s
	 bIQbVYiCI5sl2hoj8zC+Ro9s/nuqQamwtsNk/5mk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240627154123epcas5p4ff017c52ddfd590a43373335f413755a~c5sMZTYuH0930709307epcas5p4q;
	Thu, 27 Jun 2024 15:41:23 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W92q61mmcz4x9Pq; Thu, 27 Jun
	2024 15:41:22 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.03.19174.2288D766; Fri, 28 Jun 2024 00:41:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240627154121epcas5p4cd7ff97ac10b8c6ea61ce2b4b50292a7~c5sLFC0uz2292422924epcas5p4w;
	Thu, 27 Jun 2024 15:41:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240627154121epsmtrp2e68a0c92b5ce4d8be3160c6a0de3800f~c5sLEdlJB1247112471epsmtrp2U;
	Thu, 27 Jun 2024 15:41:21 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-e6-667d8822e091
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.BC.19057.1288D766; Fri, 28 Jun 2024 00:41:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627154120epsmtip10451c9ff6f8f5622c85989398c177e2b~c5sJWhw7E0374403744epsmtip1B;
	Thu, 27 Jun 2024 15:41:19 +0000 (GMT)
Message-ID: <46265f4b-2425-7988-26f7-776c85814ed9@samsung.com>
Date: Thu, 27 Jun 2024 21:11:18 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 4/5] block: switch on bio operation in
 bio_integrity_prep
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240626045950.189758-5-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTS1epozbN4OQjbovVd/vZLFauPspk
	sfeWtsXy4/+YHFg8Lp8t9dh9s4HN4+PTWywenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkH
	xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAC1UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa3D6mBkbdLkZODgkB
	E4kHrbPZuhi5OIQE9jBKtPduYwNJCAl8YpS4OJsTIvGNUWLihGssMB2nWg6xQCT2MkrcXLuX
	FaLjLVDHYRsQm1fATuLi6tuMIDaLgKrEzT0QzbwCghInZz4Bs0UFkiV+dh0A2yYs4C/xp28/
	2BxmAXGJW0/mM4HYIgIOErM3LGWDiIdKfJgzE6iXg4NNQFPiwuRSkDCngKHEoX8tUCXyEtvf
	zmEGuU1C4CW7xLKz79ggjnaReLzvGCOELSzx6vgWdghbSuLzu71QNdkSDx49gHqyRmLH5j5W
	CNteouHPDVaQvcxAe9fv0ofYxSfR+/sJE0hYQoBXoqNNCKJaUeLepKdQneISD2csgbI9JG7t
	WcwMCbbVjBJfb9ximcCoMAspVGYh+X4WkndmIWxewMiyilEqtaA4Nz012bTAUDcvtRwe28n5
	uZsYwYlRK2AH4+oNf/UOMTJxMB5ilOBgVhLhDS2pShPiTUmsrEotyo8vKs1JLT7EaAqMn4nM
	UqLJ+cDUnFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA1Px0nK/
	tyFsPVGmj+Keq5bxHYhj1qjdGf/K5FT0hn0dJbsne8/+8a/cIHmKwuocwV/HyntzN9/lKFHb
	sanTtfMvb2TtIslfhj7SMo62eb9N7lh81anYErzyePAZa9U5N6cn7pmfeGzTe+l31+W5dmfX
	Pf6+e7Xww4zrhodjP7TFpvtE978SkI0P9omv/flI3SO8cWfhg/WGc16z/jgqFrjCc/ZM10Df
	yQ39sQucTp+9UNvuVvW3TXMSV8d52UNaT6Ufv7+nMtN+qZ+xsJfiHa4ohfRC0T+ZjG3tJ+5+
	sK2qfKnxt0q2PsV7XlFR8+G9b1793P3a1+ny6aeZgnpNmbdvBShpe//emDUrK1xnrRJLcUai
	oRZzUXEiAO2IKbYVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK5iR22awc6dJhar7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJ4rJJSc3JLEst0rdL4Mo4tWMpU4FR
	xbW5fUwNjLpdjJwcEgImEqdaDrF0MXJxCAnsZpSYf/kVG0RCXKL52g92CFtYYuW/5+wQRa8Z
	Jd4sWssEkuAVsJO4uPo2I4jNIqAqcXPPNRaIuKDEyZlPwGxRgWSJl38mgg0SFvCV+HqogRnE
	ZgZacOvJfLA5IgIOErM3LGWDiIdKnDz2gxVi2WpGiSUnPwA1cHCwCWhKXJhcClLDKWAocehf
	C1S9mUTX1i5GCFteYvvbOcwTGIVmITljFpJ1s5C0zELSsoCRZRWjZGpBcW56brFhgVFearle
	cWJucWleul5yfu4mRnAcaGntYNyz6oPeIUYmDsZDjBIczEoivKElVWlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MOlsmha990rvYZ1Htt9u8x25xbNj
	35FOw4U3eKrXzpVdY3bVTvQO3xNh5UQO7rjV+aKfsq7xXnomfcbvYdDrfafq7VqZLSbYS+aY
	71jiIP5rzpftb777nub8cGH+eqY7c6Kjt/8SVdQ9/2P+hi23eKILq26L6P45M+HfR7dZF5MT
	zyh/umstVdax+7xYm8hx96WfuvqfRvn8bAyZuGDqC4FtxWzH809tE5JMPudvF2718q38vvzz
	yg+sZrnf5P1WsGzrPZVAq9DZGTu4C/e0bon9uvmf56fPFjaMX6bxBT+ud9hW5jR1/bOigGN1
	8yfo3HwX9VrdSPFt56IW7VabGqPJ4ot01vvlr0uaybkn6v9vJZbijERDLeai4kQAsR3oW/IC
	AAA=
X-CMS-MailID: 20240627154121epcas5p4cd7ff97ac10b8c6ea61ce2b4b50292a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050034epcas5p1aa4ae0dca9a2885faef4338e6fae50cb
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050034epcas5p1aa4ae0dca9a2885faef4338e6fae50cb@epcas5p1.samsung.com>
	<20240626045950.189758-5-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
