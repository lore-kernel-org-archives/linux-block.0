Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D21C3F3E
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946251; cv=none; b=IPRE4sQFwot/kW/jTUzlQEan71A+0NOh7q1z8V4SBr0lPot1mTwspcVhXskVPM7ZYKS/egqoG9idSvrnZ1MeBGVtM/14meO3FkPEwAm/K4u18vIWMPGXU+xpDLLC1smGMUQocFPcjYmtebQKqiNaIgJ5XMAL/RLuf+lNIUPh5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946251; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DwRSxsR7gUN7zkWyL/0oJLQbwborYz3pRoLyeMidnUQ8lRyf3b93gw9eMEXzpQcqR6fkyX2hojAwGD0ZMCQrnf9E0IYwbY1OGCWrdBl92z5uRAZb51e8RlW5vxVIeugagiDNPYBlO23rM3eXUJRAQG2h4n+zvZLYrc6jXiYEu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WCjyiWeQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WCjyiWeQ"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240806121041epoutp04baed8a446015a585ccf52728c2f54cca~pInp15Rqb1401914019epoutp048
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 12:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240806121041epoutp04baed8a446015a585ccf52728c2f54cca~pInp15Rqb1401914019epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722946241;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WCjyiWeQFfbUNRQi2q0x+IdGkJdIC9Dk0/J/xf9VXwUL3QaPB1zNkewWshqyQNFjw
	 wAtebk1RXGEwjZLc20UeIvjVEdcJu3a7mkuvlIwscnhD7BLuyallCH2rROIqJtMteo
	 +H5Nf5GNvKCRL28JCzPuXI3MQKw9U5od7Yn9Pibo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240806121041epcas5p1c6bcb37cb47a07a41990bfd2a7db0791~pInpoP4lh1814618146epcas5p1s;
	Tue,  6 Aug 2024 12:10:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WdXFX27cCz4x9Pw; Tue,  6 Aug
	2024 12:10:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.15.09642.0C212B66; Tue,  6 Aug 2024 21:10:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240806121039epcas5p33ccf7f13bf97d7f25d3e089a7045cf63~pInoHplzi0626406264epcas5p31;
	Tue,  6 Aug 2024 12:10:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240806121039epsmtrp125f0d848255806febb444ea880707c53~pInoG9Bev0145101451epsmtrp1T;
	Tue,  6 Aug 2024 12:10:39 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-a3-66b212c0b3da
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.BA.07567.FB212B66; Tue,  6 Aug 2024 21:10:39 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240806121038epsmtip248ba52b6ba7c681adf3bcbecc5bd9a73~pInm_bZPr0975109751epsmtip2L;
	Tue,  6 Aug 2024 12:10:38 +0000 (GMT)
Message-ID: <5f81e9c7-6274-57f4-34c3-c5a0527c5801@samsung.com>
Date: Tue, 6 Aug 2024 17:40:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] block: Don't check REQ_ATOMIC for reads
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240805113315.1048591-3-john.g.garry@oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXfeA0KY0g3dP+SxW3+1ns9jYz2Fx
	4dcORou9t7QtLu+aw2bRfX0Hm8Xy4/+YHNg9pk06xeZx+Wypx8ent1g8Pm+SC2CJyrbJSE1M
	SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqvpFCWmFMKFApI
	LC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+HP2NGuB
	ScW1uX1MDYy6XYycHBICJhKr5vazdjFycQgJ7GaU2PHiOhuE84lRYsPNNVCZb4wSz/6+YoZp
	+dG+BMwWEtjLKDH7ZTJE0VtGib1n/jGCJHgF7CSeXPrI0sXIwcEioCKx/4AaRFhQ4uTMJywg
	tqhAssTPrgNsILawgIPE12Wr2UFsZgFxiVtP5jOB2CICdRInVncxQsSjJZ5tWMwEMpJNQFPi
	wuRSkDCngL3E/QWfWCFK5CW2v53DDHKOhEAjh8SKe3dZIG52kXjw9yiULSzx6vgWdghbSuJl
	fxuUnS3x4NEDqJoaiR2b+1ghbHuJhj83WEH2MgPtXb9LH2IXn0Tv7ydg50gI8Ep0tAlBVCtK
	3Jv0FKpTXOLhjCVQtofEjknfocF5nFFiRedn9gmMCrOQQmUWku9nIXlnFsLmBYwsqxglUwuK
	c9NTi00LjPNSy+GRnZyfu4kRnDK1vHcwPnrwQe8QIxMH4yFGCQ5mJRHertINaUK8KYmVValF
	+fFFpTmpxYcYTYGxM5FZSjQ5H5i080riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0t
	SC2C6WPi4JRqYOpysXLidzi0wCRPjMnZheFsnfsZP9E0K3HtEweP903S3v7No+LK5GknF+iu
	XihmZ3LY+pSfOg/7824729TL+1o7HLfI/Nwu/b743Mn9sRmXmnbp1yk3VT27tv35k7bGveub
	3Ji+pe6srb1ssNtsgjKXNBdbAM/fXyqye0NOd6doqLFr/Xj9c9VGnROWUnUZH9XeeFzubPEI
	K9u8O/DKfcecDu6fcgkFqwVPSKaYbDrlKihR0xK9R+rdwzmet1K900rOh3/K3lceYVptUMea
	9E45Z0Pci0edIi3tol9EXWzmvuY4XrlXXoyjZlfEHfeM4xnLFzPvnnRKNjxCMTyye/HX5JKt
	i3csO7RmQ2mVEktxRqKhFnNRcSIAc+jmMCIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO5+oU1pBnPXG1qsvtvPZrGxn8Pi
	wq8djBZ7b2lbXN41h82i+/oONovlx/8xObB7TJt0is3j8tlSj49Pb7F4fN4kF8ASxWWTkpqT
	WZZapG+XwJXx5+xp1gKTimtz+5gaGHW7GDk5JARMJH60L2HuYuTiEBLYzSix6+E3ZoiEuETz
	tR/sELawxMp/z9khil4zSvw49oYNJMErYCfx5NJHli5GDg4WARWJ/QfUIMKCEidnPmEBsUUF
	kiVe/pkINkdYwEHi67LVYDYz0PxbT+YzgdgiAnUSfycsZQYZwywQLfFpQzzEquOMEm8eHQIb
	zyagKXFhcilIOaeAvcT9BZ9YIcaYSXRt7WKEsOUltr+dwzyBUWgWkitmIdk2C0nLLCQtCxhZ
	VjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBMeHlsYOxnvz/+kdYmTiYDzEKMHBrCTC
	21W6IU2INyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGpud5
	gvd/R4WzJh2yfGx+f3vev0l61gu1wtmdktcH34qff/GJmmdqv4+KY7BCyNIdR275tn36Vfxp
	Y9rmVx18px4tOeUVubD/3aXP769rRHkZF6Zu2KVQ6ph7/Oj6Bdfec1eFJ539tbG2wG+L4vHH
	QjFslof+Ch6Wn6C1U05pxxuRVQU3wq7snJX00Px893XOZ4d1RK7ddmZzOFhQqN3DG9PyeinT
	/6dffn7isllm037157y6uQG+M/N3Lo7c4eCQmGmi4amuaGq1ws3D87Cj8Cujiynfb2Wunav4
	O++/e/uVI+e87Pau/LQrb4+j4OEl7Zv3TjA2Y2TNWJIdnXrF+OJ+3uhJl8S1zk+UWb77qKYS
	S3FGoqEWc1FxIgA28LcQ/gIAAA==
X-CMS-MailID: 20240806121039epcas5p33ccf7f13bf97d7f25d3e089a7045cf63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240805113422epcas5p4321643cc304390f4a3d4be869d4aaed4
References: <20240805113315.1048591-1-john.g.garry@oracle.com>
	<CGME20240805113422epcas5p4321643cc304390f4a3d4be869d4aaed4@epcas5p4.samsung.com>
	<20240805113315.1048591-3-john.g.garry@oracle.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

