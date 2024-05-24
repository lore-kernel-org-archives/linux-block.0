Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5885927
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546541; cv=none; b=uDrspoIZZx9Ig15XCfn7JYOXUW0RG6KYMIwWaKHqEAYwHc21p9QsyjRRyiuRxISXmlG2lUMnX297hqe3RIVpCcs//rHhUqtGrnLV7uvYPUAgJV4U6fhxcCGvKXLBP4p3QK3cMvyOKQlgnmfED1vavqmQWTam3cImA05+6P4wdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546541; c=relaxed/simple;
	bh=lIeKJZ2OVOsBGIQYP6aYbaCAR81wXWkARY37Wi4Bksc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RHre/wYg1C1Dsq0E9htavd7BJYoZD9Ni7WFU2ra9YNEbfwM5aWe3SknChNvA92uGpEnYNCMYsfIu3Lt+AoOcPEASYZ4a0kYmDAPWZmemYt44O6YmFpFTqBWMJ1dEjnmfCv1/433xVOxYz+LlBOBwMbZI9C72ywEpJOfZqXvpMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O+qaMYFC; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O+qaMYFC"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240524102849epoutp04c9188f3958d88e714d87ed5c72cf48bf~SZflV8BGU2501025010epoutp04O
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 10:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240524102849epoutp04c9188f3958d88e714d87ed5c72cf48bf~SZflV8BGU2501025010epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716546529;
	bh=lIeKJZ2OVOsBGIQYP6aYbaCAR81wXWkARY37Wi4Bksc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=O+qaMYFCKYADvcGllsW+IMFM90n5VXKykQyZpegZIyv2QMf1zwUNGe+dsovQpyBtv
	 Sy9orpJTAK6tlZBsZbcC+u1m2P5pqXzEhXcT846MsZ1/4ekZjpR19InK3xO5pZ/yRg
	 qiCRPfWIqWZ3XnxY7t8yNMPbwINmEl8E8gZ7PPPc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240524102849epcas5p1ded2aee0b3b9963d7acd03f12893b6d9~SZfk6j21U1211212112epcas5p11;
	Fri, 24 May 2024 10:28:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vm1V739TBz4x9Pv; Fri, 24 May
	2024 10:28:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.B1.09666.FDB60566; Fri, 24 May 2024 19:28:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240524102847epcas5p4a664bc84623cb5eee95b0d0786d2b621~SZfjCfTAJ2616826168epcas5p40;
	Fri, 24 May 2024 10:28:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240524102847epsmtrp12d75a0db2cb0766488ec26be96b2c3fc~SZfjBo2y50470904709epsmtrp1k;
	Fri, 24 May 2024 10:28:47 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-76-66506bdf76f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.07.19234.EDB60566; Fri, 24 May 2024 19:28:46 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240524102845epsmtip2f4f6a5763e5cbeb0db31814f1c49f911~SZfiA7zt70273102731epsmtip2C;
	Fri, 24 May 2024 10:28:45 +0000 (GMT)
Message-ID: <87067eac-db91-c144-b3da-86d16f0a060a@samsung.com>
Date: Fri, 24 May 2024 15:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, anuj20.g@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240506060509.GA5362@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu797IA0gzMzRCyaJvxltlh9t5/N
	YuXqo0wWkw5dY7TYe0vbYvnxf0wObB6Xz5Z6bFrVyeax+2YDm8fHp7dYPPq2rGL0+LxJLoAt
	KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
	xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2
	xv+7C9gK/jFWXH29l6mB8TJjFyMnh4SAicSc7+tZuhi5OIQEdjNK/J7zjxHC+cQo0XflNRuc
	c/HIVWaYlu3PJ0C17GSUuL/yPJTzllGiZcEFFpAqXgE7iV3//7KC2CwCqhJ72/6yQ8QFJU7O
	fAJWIyqQLPGz6wAbiC0s4CSx7uA1sDizgLjErSfzmUBsEQEliaevzjJCxMsl9h7+ClTDwcEm
	oClxYXIpSJhTQFvizZv/UCXyEtvfzmEGuUdCoJVD4tq1aUwQV7tIzHv4gx3CFpZ4dXwLlC0l
	8bK/DcpOlrg08xxUfYnE4z0HoWx7idZT/cwge5mB9q7fpQ+xi0+i9/cTJpCwhACvREebEES1
	osS9SU9ZIWxxiYczlkDZHhKNTxawQ4JqFaPE8a9/GCcwKsxCCpVZSL6fheSdWQibFzCyrGKU
	TC0ozk1PLTYtMMxLLYdHeHJ+7iZGcBrV8tzBePfBB71DjEwcjIcYJTiYlUR4o1f6pgnxpiRW
	VqUW5ccXleakFh9iNAVGz0RmKdHkfGAizyuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1
	OzW1ILUIpo+Jg1OqgUnkYmOXxJflaiXTfzcq1iwqFqqpLiqIUlwtd0jkrfzVLTsvJAmYhZYx
	6XS2se1+HrOHuX5pLmPB2RnOCYc7hM4ZsV281yJ6Uqw5ltXmWxeD3e5/U49pbH/IKrftlbP7
	H+20wsbfLzSFwi/NyapbEVB3MkQs9C/TkSOL/dxvVHe9XyjFcKT95fJNjS2+26s06zdN3S+4
	1kIl38Hm7buknwy3Dth1etukHJkauy97zt6vp0+fWHty2vKtevvCr0n2CCvm94WKbn2e21L5
	/9fLdb+CAw0VVt3Z/kenbv/WJPYU/w+rgj6eOLW58LzbpYV7ts1SuGBh4qxwZeejnVNv12qo
	m4RWxK5tU+nzexq+4bUSS3FGoqEWc1FxIgAHYdc0LAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO697IA0g39XLS2aJvxltlh9t5/N
	YuXqo0wWkw5dY7TYe0vbYvnxf0wObB6Xz5Z6bFrVyeax+2YDm8fHp7dYPPq2rGL0+LxJLoAt
	issmJTUnsyy1SN8ugSvj/90FbAX/GCuuvt7L1MB4mbGLkZNDQsBEYvvzCSxdjFwcQgLbGSUm
	X9zPBJEQl2i+9oMdwhaWWPnvOTtE0WtGiaObXjODJHgF7CR2/f/LCmKzCKhK7G37yw4RF5Q4
	OfMJC4gtKpAs8fLPRLC4sICTxLqD18DizEALbj2ZD7ZMREBJ4umrs4wQ8XKJ9S+WsoHYQgKr
	GCW+bIzpYuTgYBPQlLgwuRQkzCmgLfHmzX+ocjOJrq1dULa8xPa3c5gnMArNQnLFLCTbZiFp
	mYWkZQEjyypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4EjRCtrBuGz9X71DjEwcjIcYJTiY
	lUR4o1f6pgnxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUw
	dZ68+mrF7b7u78smLXbLr3l5J2LC4tPxFemm5rc+nbd+ePE3Q976nieaUznM1nK+VH8fUG0n
	1P3+YAzj7QVXb+8s/rct5EHfTxspd42tgluefe6fsXjjruQD8ac/rLm5gL3qW/P2Zy/Cjc0Z
	8uTfb8rSdcsKmctxUmjL3CTPaY/+8a0yCHoqlD/5dmnCuz89RoHpl8UOMvPfefhS/SZvtlH8
	0rtZH95Okg6vnhWQudVP/crRpLMGZqb+56+cmFGTynVyn7HgGa2Zv06fvyRyTDb5c+MMR0uW
	+s6gjdl3/9isLdHriLyUJPY5dMrLZ3eEKvzMOmxCupon2nidaZ+5d0cVZ3RS/WybunPnmLY+
	F1JiKc5INNRiLipOBADvyEQoAwMAAA==
X-CMS-MailID: 20240524102847epcas5p4a664bc84623cb5eee95b0d0786d2b621
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com>
	<20240506051047.4291-1-joshi.k@samsung.com> <20240506060509.GA5362@lst.de>

On 5/6/2024 11:35 AM, Christoph Hellwig wrote:
> Can we take a step back first?

Now that back step has been taken[*], can this patch be looked at.
This still applies cleanly.

[*] https://lore.kernel.org/linux-block/20240520154943.GA1327@lst.de/
