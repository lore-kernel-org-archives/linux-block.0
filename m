Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197214EC40
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502962; cv=none; b=EG9l8mhMAFFAVyib9gr9DafLISbRbTZUyH8ZCe+hsi3oupI5Xpjv2vnutwga/lC+cycEwXG+xdJyiMsvvkZomT2l4LbImBJRksExrmfhhqcwABPZHp+vjUdYSG2sHxgHxVKYUec9/Y/LCLwkOm/o/7GPx2asrTRAECn3cNt3O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502962; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=k94AMfBIB9dhw4co+uU6SYH/lI9Sb7iNb5aI+cWYWAflIUVWfU5zwYXlHAZqaIU6WdeHGH6yg9iodx4PDtsZ3/umTrIA0AFVLZ3BdR//DApKnbXnrjUh2/Udg+QcuYmMjWRQJXVRr4V7NWcBq9nwlM5DdaWje8oxQVVZlFqmppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sLwBXnqR; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLwBXnqR"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240627154237epoutp01502668e6c1b355ae2b5e0bc8b4a293a1~c5tRcTQYK0403504035epoutp01T
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240627154237epoutp01502668e6c1b355ae2b5e0bc8b4a293a1~c5tRcTQYK0403504035epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719502957;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sLwBXnqRKwc6bYhE6YGf8F35N0KKBHzrmECUfS7AwDzu00EA3Z7ysT7GM/WVxwd8q
	 uh+oh1LNxtnLwgqgiac0fqXiaMdsatrmL/XVCs8V6wv6iQu4sWS7634KGh3rh40d6D
	 UY8VsTUSOuDeIL7l2OS9BftxwGKAiWYG/2mlVp/8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240627154237epcas5p10c42c6bd9e732ee1419193d8432a02cc~c5tRHRmvt1089110891epcas5p1P;
	Thu, 27 Jun 2024 15:42:37 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W92rX03kVz4x9Pp; Thu, 27 Jun
	2024 15:42:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.03.19174.B688D766; Fri, 28 Jun 2024 00:42:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240627154235epcas5p3f66271e56cc6bd820c6bd1e69178f779~c5tPv2guY2917429174epcas5p3l;
	Thu, 27 Jun 2024 15:42:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627154235epsmtrp180b259372b421e2f6e4f8c8b3ceacdb1~c5tPvQ13t1029210292epsmtrp1d;
	Thu, 27 Jun 2024 15:42:35 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-40-667d886b71b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.CC.19057.B688D766; Fri, 28 Jun 2024 00:42:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627154234epsmtip13d1ab956acc3385d1a2a683438c0a744~c5tO0utL11272112721epsmtip1S;
	Thu, 27 Jun 2024 15:42:34 +0000 (GMT)
Message-ID: <48c5b316-e789-d373-03b6-4b7ceada3b24@samsung.com>
Date: Thu, 27 Jun 2024 21:12:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/5] block: simplify adding the payload in
 bio_integrity_prep
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240626045950.189758-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTQze7ozbNYM9zK4vVd/vZLFauPspk
	sfeWtsXy4/+YHFg8Lp8t9dh9s4HN4+PTWywenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkH
	xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAC1UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa3D6mBkbdLkZODgkB
	E4mLUzoZQWwhgT2MEg8eMnUxcgHZnxglPv6ZxgzhfGOUWDWrhwmm4/bHU+wQib2MErt+vYdq
	ecsocXl+GwtIFa+AncSbb5fYQGwWAVWJF49uM0LEBSVOznwCViMqkCzxs+sAWI2wQLDEyjmP
	weLMAuISt57MB9smIuAgMXvDUjaIeKjEhzkzgWo4ONgENCUuTC4FCXMKGEpcudDNCFEiL7H9
	7RywqyUEHrFLbFhznQ3iaheJI3taWCFsYYlXx7ewQ9hSEi/726DsbIkHjx6wQNg1Ejs290HV
	20s0/LnBCrKXGWjv+l36ELv4JHp/P2ECCUsI8Ep0tAlBVCtK3Jv0FKpTXOLhjCVQtofEizUz
	oOG2mlHiVs8K1gmMCrOQQmUWku9nIXlnFsLmBYwsqxilUguKc9NTk00LDHXzUsvh0Z2cn7uJ
	EZwatQJ2MK7e8FfvECMTB+MhRgkOZiUR3tCSqjQh3pTEyqrUovz4otKc1OJDjKbA+JnILCWa
	nA9Mznkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTBJFfcHKP67
	Z5foFMuV/46NZ3JQqP2bN0eMs3KFXgp/td6V7jWxz0P30qt73eslhdss7QTjnpycuXud0Xce
	a5OUrwJ8AhFrujx61Z2PFheXi/OdqXm/48dbvuBquxVRxzbsMuE6WymlljBHP6OFu4e3SthV
	Nu9u1zMWE+1JF5T23THR2Pd9QuN9J8cg/l+Zu3hj9COFtF7GzTro9H0ZD/Nio8abCxUP75gY
	VfRx172Q9TWhjoz8Gs9efu98JL/CJTzGfyf32vhAm5Z735YwK7uk+xxRTlLsYl+2+VAb48Wm
	xB377B+ePzon3stynY301f7/h71tpn0terBix+r87RIqp5Yf7Xj0QsTv5XG1D0osxRmJhlrM
	RcWJAGZKJDAWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnG52R22awZcbKhar7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJ4rJJSc3JLEst0rdL4Mo4tWMpU4FR
	xbW5fUwNjLpdjJwcEgImErc/nmLvYuTiEBLYzSix8vMBVoiEuETztR/sELawxMp/z6GKXjNK
	HPi5igUkwStgJ/Hm2yU2EJtFQFXixaPbjBBxQYmTM5+A1YgKJEu8/DMRbJCwQLDEyjmPweLM
	QAtuPZnPBGKLCDhIzN6wlA0iHipx8tgPVohlqxklZl5cBdTMwcEmoClxYXIpSA2ngKHElQvd
	jBD1ZhJdW7ugbHmJ7W/nME9gFJqF5IxZSNbNQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrF
	ibnFpXnpesn5uZsYwXGgpbWDcc+qD3qHGJk4GA8xSnAwK4nwhpZUpQnxpiRWVqUW5ccXleak
	Fh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXAtGX3rnkTlxhqveJbGbRkV6dqLsu+
	4HuqHkZ33hd0dnqdfRFSYnOopIa1yYPLcbqs6Szlyod2PTm3qs8/zPl/86XY71faj43UHmvW
	/W9l6xGUOPqH5em8+f2zXNeUKTr135+U2j89Yel142cLw97onErY9NnoptOTi2JLhJflJevp
	f9k5LZLdrzUpWCuds/7Bdp+iyZoHrdqPJ1bMVzm4pXqZZa6CylTmTU4X9YJt3xgocSxOsGBg
	+9Z8YZLkjHh3ztjLb6ZO8dHpPhZwI5GlQ5mfWyTE9Pea/cvslZfPdV+ucUd4wry5nov6pJOu
	uccZ36+eprXOpaqtmGXPlH7vbVXBYa5JQV8nhB9U6/6rxFKckWioxVxUnAgAOHaGpvICAAA=
X-CMS-MailID: 20240627154235epcas5p3f66271e56cc6bd820c6bd1e69178f779
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050009epcas5p1cd8e433edd944af2ebcf130280eab2ee
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050009epcas5p1cd8e433edd944af2ebcf130280eab2ee@epcas5p1.samsung.com>
	<20240626045950.189758-3-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
