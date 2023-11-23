Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rs7EYFPt"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26839B9
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 10:12:40 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231123181236epoutp01284736536f754e450eb14de3c53ba9c2~aUxR4NJVj2273922739epoutp01P
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 18:12:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231123181236epoutp01284736536f754e450eb14de3c53ba9c2~aUxR4NJVj2273922739epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700763156;
	bh=/fSXR/2xA0xv4K617SxjeTVWRVNSSBhSTN0NXr2ayFs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Rs7EYFPt4iz0iyy1pnbOs46Ux7tymXXHP57gxY31QHvo9N6M9tYHXcRlsGS3carbB
	 zgr2j6tqlWGPGfWlxKmRPfxmT71B8s7OELG8FS3lf2zST2+ovWpvALOSM9sRVLso5f
	 P0AiV+dbvrNXRcWOnD+PSzcuY2cabgunR1nE1Mf0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231123181236epcas5p245ccd5c4071269fddf14ec0c28ccd196~aUxRY6Pcd1361113611epcas5p2w;
	Thu, 23 Nov 2023 18:12:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SbmRk3mmqz4x9Pq; Thu, 23 Nov
	2023 18:12:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.9E.09634.2169F556; Fri, 24 Nov 2023 03:12:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231123181233epcas5p3e371c51e0d0e9492c9d4a627758066fc~aUxPNvZ2F0837608376epcas5p3a;
	Thu, 23 Nov 2023 18:12:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231123181233epsmtrp128b0b068e7c6f2d41f4426e55b7cd800~aUxPNMsMk2268622686epsmtrp1X;
	Thu, 23 Nov 2023 18:12:33 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-e1-655f96127843
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.DC.08817.1169F556; Fri, 24 Nov 2023 03:12:33 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231123181232epsmtip2b5de0f5a355fecff272ee2ab9fdda576~aUxOByzTf2050920509epsmtip21;
	Thu, 23 Nov 2023 18:12:31 +0000 (GMT)
Message-ID: <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com>
Date: Thu, 23 Nov 2023 23:42:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough
 io
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, "kundan.kumar"
	<kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231123153007.GA3853@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTXVdoWnyqwbatshar7/azWaxcfZTJ
	YtKha4wWW798ZbXYe0vbgdXj8tlSj02rOtk8dt9sYPPo27KK0ePzJrkA1qhsm4zUxJTUIoXU
	vOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg1UoKZYk5pUChgMTiYiV9
	O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwbT++zFVznrHj5
	WqeBcRVHFyMnh4SAicS+693MILaQwG5GiUdz1boYuYDsT4wSGzbOZ4RwvjFKXPvewwrT8WHz
	dKjEXkaJLa9aWCCct4wS1x9eYgOp4hWwk/jZeZGpi5GDg0VAVeLR3VKIsKDEyZlPWEBsUYEk
	iV9X5zCC2MICgRJrz3wGs5kFxCVuPZnPBGKLCPhLrFrdyQIRd5a4svY6M8hINgFNiQuTwUZy
	CmhL3Ft4jR2iRF5i+9s5zCDnSAh8ZZdo6J3NBHG0i8TsT0fYIWxhiVfHt0DZUhIv+9ug7GSJ
	SzPPQdWXSDzecxDKtpdoPdUPtpcZaO/6XfoQu/gken8/AftQQoBXoqNNCKJaUeLepKfQoBKX
	eDhjCZTtIbFm9zJosG1klJgwu5NlAqPCLKRQmYXk+1lI3pmFsHkBI8sqRsnUguLc9NRi0wLD
	vNRyeGwn5+duYgQnSy3PHYx3H3zQO8TIxMF4iFGCg1lJhHcLe0yqEG9KYmVValF+fFFpTmrx
	IUZTYOxMZJYSTc4Hpuu8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4
	pRqYFHdbye96dHud8pQWBymJ8oB/rzUm/+ZkztP817tpS4vhdvGJm0tshJZxqUslbvKZILbK
	aLdUuEnAvoATXF9ntHyXPramTKBT9W/OgqSIT8s1n/6pTZPQiot8nFFjWF6UfO+OqnqVuG1E
	rtAj3eLezEOydtPOyPyd5F1Z9nfNAze2o6oa6g0rOau3vpzdWftqdq9ESH38H92ydcwxt1l4
	BDx1g85Hpn3b/CZLoHmvBeO1Y9rn2XYoVx4Mu9T69BlP08tWz6J1JZOyvSUXfbWZwBthFXIo
	o53VafGGna8C8l4cOvzu0ane53sKK69U/Vuw/0//rovSL5L2bSzQWR9+aIbf/uX90syHI/yU
	PH2UWIozEg21mIuKEwH5yFVGHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK7gtPhUgwv9uhar7/azWaxcfZTJ
	YtKha4wWW798ZbXYe0vbgdXj8tlSj02rOtk8dt9sYPPo27KK0ePzJrkA1igum5TUnMyy1CJ9
	uwSujBtP77MVXOesePlap4FxFUcXIyeHhICJxIfN0xm7GLk4hAR2M0p8uLaXFSIhLtF87Qc7
	hC0ssfLfc3aIoteMEo+XNLKBJHgF7CR+dl5k6mLk4GARUJV4dLcUIiwocXLmExYQW1QgSWLP
	/UYmEFtYIFBi7ZnPjCA2M9D8W0/mg8VFBHwltj5qYoaIO0tcWXudGWLXRkaJy9MWg81nE9CU
	uDAZbD6ngLbEvYXX2CHqzSS6tnZBzZSX2P52DvMERqFZSM6YhWTdLCQts5C0LGBkWcUomVpQ
	nJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwbWlo7GPes+qB3iJGJg/EQowQHs5II7xb2mFQh
	3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamNLLWfiqVx9X
	ZU+xSFTRZHw/4c1XyYT/Ae5fxUQyX9RP5f66SqhBarrbfGcZmzfJrmnb99XEbjrUvGHj8p9J
	Abeu3hUVja3ve7uKmTtF8G8RV29gYfFNY+csK7tM5RUNq7umx7muqlv1R0nsk3Ag/8VN/2ar
	OSwSX9nzjYGxO7YxuEHYIuWxSeIcwYU3Dh1/mpy+8t+pU6e1VsmxSH5YdeiBrV7iMiuXh89d
	njsE3p+qmaU9TWY/U3bp9YNBVy8/Uv2Svs3C9n3EjoZ/86L5P1u9++/iIHWbd9utj+fn+L+X
	UGh/Z9gZ+27rqql/5iw6LO1R5iwsL5by9hn31PKZk/kPRl1T+eyy22j9VqMHqUosxRmJhlrM
	RcWJAJoxJOP8AgAA
X-CMS-MailID: 20231123181233epcas5p3e371c51e0d0e9492c9d4a627758066fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
	<20231123102431.6804-1-kundan.kumar@samsung.com>
	<20231123153007.GA3853@lst.de>

On 11/23/2023 9:00 PM, Christoph Hellwig wrote:
> The rest looks good, but that stats overhead seems pretty horrible..

On my setup
Before[1]: 7.06M
After[2]: 8.29M

[1]
# taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
-u1 -r4 /dev/ng0n1 /dev/ng1n1
submitter=0, tid=2076, file=/dev/ng0n1, node=-1
submitter=1, tid=2077, file=/dev/ng1n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
Engine=io_uring, sq_ring=256, cq_ring=256
polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
Engine=io_uring, sq_ring=256, cq_ring=256
IOPS=6.95M, BW=3.39GiB/s, IOS/call=32/31
IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/32
IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/31
Exiting on timeout
Maximum IOPS=7.06M

[2]
  # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
-u1 -r4 /dev/ng0n1 /dev/ng1n1
submitter=0, tid=2123, file=/dev/ng0n1, node=-1
submitter=1, tid=2124, file=/dev/ng1n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
Engine=io_uring, sq_ring=256, cq_ring=256
IOPS=8.27M, BW=4.04GiB/s, IOS/call=32/31
IOPS=8.29M, BW=4.05GiB/s, IOS/call=32/31
IOPS=8.29M, BW=4.05GiB/s, IOS/call=31/31
Exiting on timeout
Maximum IOPS=8.29M
