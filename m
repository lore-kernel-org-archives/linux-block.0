Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DCBF9CD
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788406; cv=none; b=nZKzOEbziUOhoB7BJujcUj02SJ5wiqtzUVQ9l00oWYSANK7VsUAsG7ZBM/wS520VHK93a0HLPx2tglMY3Pv2olEoaKyV0TKMSaCcUaUolh5N9OvSKP3T/iiBgYzYPGPhpmshWa1t09ZyENfrH/tQ1b1h6H3dkPT6E+ueJY+KuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788406; c=relaxed/simple;
	bh=FsPCYJpx+/0JByzyaBl44QTayzjxymhRSgOXKmpSm9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TIUWxqWdDxssLPhcDEA8R8UPTtIQYBz/npxfB910EyvYaRoDAz8T8htkUITOtcXTAxH5zXAc4TStr5Cmbg5q54iCAU7GQjxkZNZT4Ubo8Q0kyeUuB0MB3gFqAoKTuxJloMUYkOPvchrDpjq4nV4qRe9Fjp/PhSRSBFoXAfkRQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TpSb70rX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TpSb70rX"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240527053957epoutp02db9d9832689bb3596b306543daa712ce~TQfOPQcjC1558315583epoutp023
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240527053957epoutp02db9d9832689bb3596b306543daa712ce~TQfOPQcjC1558315583epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716788397;
	bh=DGe9fcIIJpu6aAz3EoSdqqLdqgEjM3Xfp08zVvJCmiU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TpSb70rXA6zzBLMAjkNsgtn/4HVtXOIYeGjBVOtX+TXw+Ls/igrN+vJ8gqcy8ep7R
	 oK6wWOWDUHFXWhlRJ4K8kPxMXDlHloGQL3c7ktHYQYIVuVdkYlvxY0bnH02vmD63VC
	 frS5qp976aJROg1w18FfdcOsQbFMhDUGw5q5iU1s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240527053956epcas5p1cd6287c3ab861b19a01bb8bf74b0cc50~TQfN5Nfhd3216232162epcas5p1F;
	Mon, 27 May 2024 05:39:56 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VnkxR1bVQz4x9Q7; Mon, 27 May
	2024 05:39:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.EA.19174.BAC14566; Mon, 27 May 2024 14:39:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240527053954epcas5p444a987b296a0af58b72aa14d551a12ac~TQfLjcLsW1620816208epcas5p4g;
	Mon, 27 May 2024 05:39:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240527053954epsmtrp1e1146df0656981dd937fe0006bade2be~TQfLiwxAx0873908739epsmtrp1E;
	Mon, 27 May 2024 05:39:54 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-1a-66541cab5b4a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	07.B0.08336.AAC14566; Mon, 27 May 2024 14:39:54 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240527053953epsmtip19b1b070d198e673393807956279e048c~TQfKkcsuL0978109781epsmtip1E;
	Mon, 27 May 2024 05:39:53 +0000 (GMT)
Message-ID: <ff59fb89-c186-af41-0990-54de8ef91ef5@samsung.com>
Date: Mon, 27 May 2024 11:09:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] block: delete redundant function declarations
Content-Language: en-US
To: hexue <xue01.he@samsung.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	peiwei.li@samsung.com, ruyi.zhang@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240527022926.1331950-1-xue01.he@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTQ3e1TEiaweT3nBar7/azWey9pW1x
	edccNotnezktvhz+zm7RdeEUmwObx+WzpR59W1YxenzeJBfAHJVtk5GamJJapJCal5yfkpmX
	bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0VEmhLDGnFCgUkFhcrKRvZ1OUX1qS
	qpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnTFv8UPWglbmiisTNrI1MG5n
	6mLk5JAQMJHY2ruAuYuRi0NIYA+jxNc5TSwgCSGBT4wSO26YQiS+MUo8efOVDabjxtm9bBCJ
	vYwSV1bdhXLeMkpcW7YUaC4HB6+AncSlHZwgDSwCqhJ/muezg9i8AoISJ2c+AdsgKpAs8bPr
	ANhQYQEniXOnm1hBbGYBcYlbT+aDnSciYCjx8sEZNpCRzAJ5Emu/sYOYbAKaEhcml4KYnAI2
	Ej/XhUA0yktsfzsH7BcJgY/sEt1NLewQJ7tItH2axQhhC0u8Or4FKi4l8bK/DcpOlrg08xw0
	UEokHu85CGXbS7Se6meGuEBTYv0ufYhdfBK9v5+A/SohwCvR0SYEUa0ocW/SU1YIW1zi4Ywl
	rBAlHhJfvzlDgqmfUWLC5B7GCYwKs5CCZBaS12ch+WYWwuIFjCyrGKVSC4pz01OTTQsMdfNS
	y+GRnZyfu4kRnB61AnYwrt7wV+8QIxMH4yFGCQ5mJRFekXmBaUK8KYmVValF+fFFpTmpxYcY
	TYGRM5FZSjQ5H5ig80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRq
	YLL5Outj1T2vRemvP2bpbTZTuFsnG/75TeicD5f2dnAb/vuZ0vG4hTm61WlVopa3E2+iSl5W
	Tbbgul9Z077Vr2zps3UXns9ermYyb6Fi1/pjM7nm1B/6ecV7+ZwaSynbn06XzNlTuBmun5uk
	sVLq7eXo589yd+149ra/7eUdrzlZZo1dEyROXvrLO9dvz4o3v/I/Ldwc4XE1Uz5V3srijU2X
	9Pc4M8W/di0WO7Qv3/vlGmsQ3WJ9yjtiyptzy1hYQtx6DjaviZq7aHUgsyxbp+CVu+UahawH
	jWd/KT2xi6nJd/sXrc3qpfnGYZNlt6czlOuf3Tr/60SzxwXp6x9H/F/bcsrP5t6VBOYlPzoE
	vJRYijMSDbWYi4oTASRvnrkYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO4qmZA0g/cTRS1W3+1ns9h7S9vi
	8q45bBbP9nJafDn8nd2i68IpNgc2j8tnSz36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoErY97i
	h6wFrcwVVyZsZGtg3M7UxcjJISFgInHj7F62LkYuDiGB3YwS3688YYNIiEs0X/vBDmELS6z8
	95wdoug1o0TTsaVARRwcvAJ2Epd2cILUsAioSvxpng9WzysgKHFy5hMWEFtUIFni5Z+JYHFh
	ASeJc6ebWEFsZqD5t57MBztCRMBQ4uWDM2wQ8TyJPwd+sULs6meUeDX1NCPILjYBTYkLk0tB
	TE4BG4mf60Igys0kurZ2MULY8hLb385hnsAoNAvJFbOQbJuFpGUWkpYFjCyrGCVTC4pz03OL
	DQsM81LL9YoTc4tL89L1kvNzNzGC40FLcwfj9lUf9A4xMnEwHmKU4GBWEuEVmReYJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoEpsH6CSpt22f0b965U
	hHzaoBB8usr9ie71D0LLeeQ5I16Ut/T+7rmx41jjtn/MgtOXtj9LDUxZusvmytb8+S/Svb+v
	bthqtlzTslJ11Z6qVim7xjONUU1N/Pfe5M7857BOJFRl4wfOlbXmmm3u/8QT737cJPWX7euc
	VyLct/nWb2HS54oKr1Vo5tL4pxdt6rV4wtWPnKdeLY+f8bFU5RtXwK2rM6+vev37Rtqvw69i
	/G70fHb/ylHcX2EZxNwte3lZxqmMF70OoozlndcsX64+GHyz4WPdV7fzf3Z2nVdbdffOdrNJ
	3JOzJ/4/ce7yexv73pMK2fz3zoj9NinM8jipuvlCoEnyNFbJA9W/txsJK7EUZyQaajEXFScC
	ABpGmv32AgAA
X-CMS-MailID: 20240527053954epcas5p444a987b296a0af58b72aa14d551a12ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2
References: <CGME20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2@epcas5p1.samsung.com>
	<20240527022926.1331950-1-xue01.he@samsung.com>

On 5/27/2024 7:59 AM, hexue wrote:
> From: Xue He <xue01.he@samsung.com>
> 
> It is used in block hybrid poll, the related function

It -> blk_stats_alloc_enable

Also, you might want to mention the patch that removed it.
54bdd67d0f88 blk-mq: remove hybrid polling


> definitions have been removed, but the function
> declaration has not been delelted.
delelted -> deleted.
