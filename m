Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE879DF
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898278; cv=none; b=SYB2yXeSoyCHTDZHLikJnVpxyCG8xbFLC+NNVluyjpZV9i8CdoTAuf0m1mdXCsVwckcl8jLfHeDmbQLjH0v4fKXqfO69e8VvhjlhLF4VVmmy21vfV++ZlQ2sEIdaREB9J2oRAkHnEa0oqyZna/H5cE72rMiY5a1TcBXz5CgFzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898278; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qVAtyxi1NYyKaXUc79D7aoO371JppKwgrAQSdMqRqvUcU05btRL/NbQhlmSCNGw5Xe2cP+fj31++nLmJ9e44TiIpcvhSNWhFrgZNypMJFYp2+c9TtTnUqERdPzRTsEUNHpYLh4McMHwW/Y2YrlgxnKQoXnMO+mtKuRPICWHvkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=D0SQdCdE; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D0SQdCdE"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240702053113epoutp012a9d556308aa2a36ec9eb1288d3949f1~eTl4G_wGe1891118911epoutp01x
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240702053113epoutp012a9d556308aa2a36ec9eb1288d3949f1~eTl4G_wGe1891118911epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719898273;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=D0SQdCdERY6AovQJPlYDH5bRwRXIy+WnXwaCD9hXXXp6IjP8OTuuymggw6dWlsH5C
	 WO89HTVijpqBuRSkd5whiESLcRZFYEw22F96pb89CKVokMXc/kZDRY91H4l1B1i+vf
	 GcxWXsaRSdYGMvl4KHa2Y/47H7cigSeCMJ0Eke3o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240702053113epcas5p43fa0c2841a9155e4b3e6c2ef0451352b~eTl34HDIb0574905749epcas5p4L;
	Tue,  2 Jul 2024 05:31:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WCs2l4PFjz4x9QG; Tue,  2 Jul
	2024 05:31:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.D5.06857.D9093866; Tue,  2 Jul 2024 14:31:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702053109epcas5p1fb15553a105a5eff0fc3cf0efe30d981~eTl0QIyV11176211762epcas5p1r;
	Tue,  2 Jul 2024 05:31:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702053109epsmtrp1b3a412508497e9adcbf1419528e31fc4~eTl0PY0LT0850708507epsmtrp1H;
	Tue,  2 Jul 2024 05:31:09 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-74-6683909df300
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.8E.18846.D9093866; Tue,  2 Jul 2024 14:31:09 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240702053108epsmtip28eec64da5a72ea5530e7c83cbab0934c~eTlzZlEzI1994019940epsmtip23;
	Tue,  2 Jul 2024 05:31:08 +0000 (GMT)
Message-ID: <107bb908-18b6-4c59-ad29-12330be6cf1f@samsung.com>
Date: Tue, 2 Jul 2024 11:01:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/5] block: split integrity support out of bio.h
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240701050918.1244264-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTQ3fuhOY0gzMv9CyaJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rl/zp5mLTCpuDa3
	j6mBUbeLkZNDQsBE4vHaHuYuRi4OIYHdjBKPzrSzQTifGCV+LHrOCufMnXWWEabl55pmqJad
	jBL/+xYyQThvGSVmv7vODlLFK2AnsevcBmYQm0VARaJhwiRGiLigxMmZT1hAbFGBZImfXQfY
	QGxhAReJXXvvgMWZBcQlbj2ZzwRiiwg4SMzesJQNIl4hMfXeMyCbg4NNQFPiwuRSkDCngJHE
	8m+/GCFK5CW2v50DdpyEwFt2iUOv10Bd7SLx9VEjG4QtLPHq+BZ2CFtK4mV/G5SdLfHg0QMW
	CLtGYsfmPlYI216i4c8NVpC9zEB71+/Sh9jFJ9H7+wkTSFhCgFeio00IolpR4t6kp1Cd4hIP
	ZyyBsj0k/v08yg4JqrWMEuubV7NOYFSYhRQqs5B8PwvJO7MQNi9gZFnFKJlaUJybnlpsWmCc
	l1oOj+7k/NxNjOB0qeW9g/HRgw96hxiZOBgPMUpwMCuJ8Ab+qk8T4k1JrKxKLcqPLyrNSS0+
	xGgKjJ6JzFKiyfnAhJ1XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwen
	VAMT+0cPkZo7hi9NPoY9lOnmt12T2l3yha8iuCt245eSaU8/3uBfP8e33d7h6kafOU9yjJpT
	nE0iBD1EH/3dEGjc9Me45bdQm4Cj4rWXeS47fWwaLm75GModoXFyq8+EQjNrHYcP3Pv0XY7/
	umHq7VKbv+xPw4Lab++PuLMf2hE2/V+r/U8Pi1yHVYfaY26pn3b6auzy3VmJVX7L1El3l9Ur
	/UjQZaz20zj35+CGt2t0GHNiZ4udy97SOKt/xkXZb/L7m/mOT+IPu1y0mdem6gST9Rb1iY0N
	4SuTfP1rF9TO1+qyF5O9GiNiufIOh65h4DeX3GUfpqzNZFEMF9Ja6VvwM6uHZ8W3Y1lBrC+X
	iyixFGckGmoxFxUnAgD77UYMIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO7cCc1pBuuO8Fk0TfjLbLH6bj+b
	xcrVR5ks9t7Stlh+/B+TA6vH5bOlHrtvNrB5fHx6i8Wjb8sqRo/Pm+QCWKO4bFJSczLLUov0
	7RK4Mv6cPc1aYFJxbW4fUwOjbhcjJ4eEgInEzzXNzCC2kMB2RombG1wg4uISzdd+sEPYwhIr
	/z0HsrmAal4zSvzecwKsgVfATmLXuQ1gNouAikTDhEmMEHFBiZMzn7CA2KICyRIv/0wEGyQs
	4CKxa+8dsDgz0IJbT+YzgdgiAg4SszcsZeti5ACKV0jcWVkIsWsto8TMM7uYQeJsApoSFyaX
	gpRzChhJLP/2ixFijJlE19YuKFteYvvbOcwTGIVmIbliFpJts5C0zELSsoCRZRWjaGpBcW56
	bnKBoV5xYm5xaV66XnJ+7iZGcDxoBe1gXLb+r94hRiYOxkOMEhzMSiK8gb/q04R4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYQoLT1nuHvX+V+dPpdHZ0
	jddjTp2CCJblx27P/RXRE7MpJvz7b6E3W699X3M3JFRZ8/Ey3ZVWqy6yqolNSewXOio7bfL7
	3ZMmNvxRkkpS/iW3+O8OfzlTte0ZXTfn9NXUHn0p+TLrsq0On/mzeacTHttM6ytKS73y7eGb
	hs17knnvaJ3b9nZDks6Wx9lJEf5R6pMWxE+IDzeX3sVbr+686qfjh9sZZ3/fP2TufnCyl+nF
	uVL/e5ocEsqUY1lEiu+GP67cef26s4FauPJE4w+ZNgGqba/NvGudcspPsrt7+7queV0kP9um
	2XqKhubne7fb/m35XnLf3fzsHWaRm5HLFKfLcp/TP76GVf3frTvXlFiKMxINtZiLihMB7RHq
	zfYCAAA=
X-CMS-MailID: 20240702053109epcas5p1fb15553a105a5eff0fc3cf0efe30d981
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701050930epcas5p22a9554f29db41d8e693babdc2e7aba51
References: <20240701050918.1244264-1-hch@lst.de>
	<CGME20240701050930epcas5p22a9554f29db41d8e693babdc2e7aba51@epcas5p2.samsung.com>
	<20240701050918.1244264-2-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

