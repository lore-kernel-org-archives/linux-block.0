Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBD2D7DF3
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631500; cv=none; b=AHbbpAB3oenWxLT1fcx5ZQ/fmcSAgtye46Ps1yLK5mje+PMtcYIqsU7cT5guNfm9H1RrlROh8o0HpMPt5M5uPFVkPLM2XkJPfvn/1VPWbOeU0wrTK0nQlZ2dTFCyVKqpwKpNSdzRVbWn5Iig2JsrF6G/DlmJLPmUc+k4ju2/h8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631500; c=relaxed/simple;
	bh=cFiRXRE0SoHVqgNVMPo+ew/Ov1wphdgz+R6dS43ENoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=iMmqukg0LcCdf+Xe7jdLvICksmtyq3+YK63mk97rii7c+wHZm079JmdQoWTpaU1JD8KKow4VG0P5WhS9+ctpQ34qyQhRUuOusRYzxhh24u/UMYy+a9M1+grjnm2nT+QHT9bU16f3YSJhv8P2SuV+a9HskCLUO/PBFk46/hZUNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M0PU4SJA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M0PU4SJA"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260209100451epoutp0395e4a824fa84d1a5ab5234524cca4c63~Si-XTOcWm0980509805epoutp03P
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 10:04:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260209100451epoutp0395e4a824fa84d1a5ab5234524cca4c63~Si-XTOcWm0980509805epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770631491;
	bh=wt+xzp1ENYsfh++JT8pJEqjJy6IREEFFHEG8QaQpp2M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=M0PU4SJAclY0eXdEEkxL7W3l4RdvfkAlxlzdKax8lupZZA9Cl/jrx3j6ZOZP25yX+
	 aEpRs8klxsOfPDog79GlTXng/MXN3vmtQU1Iyp+6hldb0cK5uuJbrbTaNyAdn1TzPn
	 R54qbHwrhOful2d1/CJ51zzsOdS1N40jgdgoaZGY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260209100451epcas5p10e8d99b66259e22b08fab2a6a4df98a8~Si-W6nlVY0968409684epcas5p1Q;
	Mon,  9 Feb 2026 10:04:51 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4f8gKY6xgMz6B9mB; Mon,  9 Feb
	2026 10:04:49 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260209100448epcas5p11e31b66680677cd4399fd0efca35e6fe~Si-UuYSWS0968909689epcas5p1N;
	Mon,  9 Feb 2026 10:04:48 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260209100444epsmtip2e68e1b03792622abf5a5c487565e1186~Si-Q3OchA2836828368epsmtip2M;
	Mon,  9 Feb 2026 10:04:44 +0000 (GMT)
Message-ID: <0ddc5a14-26c3-4912-96a0-d619ca0fb36c@samsung.com>
Date: Mon, 9 Feb 2026 15:34:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: io-uring <io-uring@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>, Anuj Gupta
	<anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260209100448epcas5p11e31b66680677cd4399fd0efca35e6fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260203143112epcas5p4eea9225d9378dad9151e1b843c0522ce
References: <CGME20260203143112epcas5p4eea9225d9378dad9151e1b843c0522ce@epcas5p4.samsung.com>
	<4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>

On 2/3/2026 7:59 PM, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.

Guilty as charged, I'm interested in the topic. Thanks for posting.
We've had several attempts to move the DMA mapping cost out of the fast 
path; hopefully, this will be the final one.


