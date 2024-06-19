Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528876F2E2
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779238; cv=none; b=dyD3zWYOQQwpgGQuLhmw3iigbRzlyrODZvZ0JPqNO5SH7C2lIsJXjVKJApmubr+9tmFEvbG1mD+7tSEKaBxJO2mfqw+uakavUBIOI61HI45rYNtI7JJzLwFx8jrSa1CvX/sBip+Vi4GFP0dXX7v36KcYL6ciLBT4bxLYttAu7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779238; c=relaxed/simple;
	bh=STW330cWe99Pche2sdfTP7cbUeC0jxLPrB02JUX1kCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IEYLoSKFJQIcluRucMCQbr5syGOpzRhgoWK5RA65M25rHIrM+wZXyOBWE1o98dBXi5jrqRUS/0xZDqG6Wcq6AKuiyzHXjkSLzXW+4k0nSphKSo4/K5/JONbx8IgKWJuLj+vEpdvUs4skuuSiUcSrC1NknbORC/8MEJfdjEpfdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cLYq8ZZa; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cLYq8ZZa"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240619064034epoutp01c6601523a41dc816e7e14e6f1652d15f~aVJtsEzXY0949709497epoutp01L
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 06:40:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240619064034epoutp01c6601523a41dc816e7e14e6f1652d15f~aVJtsEzXY0949709497epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718779234;
	bh=Wxu+W8g/EmXfv0ETPHjj9NJMUXWZg033DcwmRKYmwGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLYq8ZZa18XWKmw2INKMxW67YflQ/vSrbETavFCyMrJHv7QAqZvl7DRaKYbSctLxW
	 U2+1aeIqVfSFLDlM7oRANLLTueMcUDh2+/YPCLl1vhKyHZJdID1r0FABE5yDdUDYgm
	 JYas2dFhinC5lK/1A4km9dHKx8pyVfVL1o8PqZJk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240619064034epcas5p44be878f430423954023f921f7310a575~aVJtdSLjC0248402484epcas5p4Y;
	Wed, 19 Jun 2024 06:40:34 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W3vBl0jKNz4x9Q1; Wed, 19 Jun
	2024 06:40:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.B0.10047.E5D72766; Wed, 19 Jun 2024 15:40:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240619063854epcas5p2d20a854d5e73a5f68f899dad45900cc0~aVIQiw8nc1860218602epcas5p2C;
	Wed, 19 Jun 2024 06:38:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240619063854epsmtrp22949e38c1c7697d118ce69eece13fde0~aVIQiEFKd0989509895epsmtrp2u;
	Wed, 19 Jun 2024 06:38:54 +0000 (GMT)
X-AuditID: b6c32a49-1d5fa7000000273f-30-66727d5e6876
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	25.84.18846.EFC72766; Wed, 19 Jun 2024 15:38:54 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240619063853epsmtip1e5e76735e46653f78953f3af3adea342~aVIPvWxc10048100481epsmtip1a;
	Wed, 19 Jun 2024 06:38:53 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: hch@infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] block: Avoid polling configuration errors
Date: Wed, 19 Jun 2024 14:38:47 +0800
Message-Id: <20240619063847.588031-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <693af28d-5e25-432b-ab1b-37eb9026c7cd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTXTeutijNYNoqK4vVd/vZLE5PWMRk
	8av7LqPF3lvaFpd3zWGzODvhA6sDm8fmFVoel8+WevRtWcXo8XmTXABLVLZNRmpiSmqRQmpe
	cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBmJYWyxJxSoFBAYnGxkr6d
	TVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xp+LjxgL+ngqHvxs
	Zm1gfMjZxcjJISFgIvF+23nGLkYuDiGB3YwSexZNZQFJCAl8YpSY99ACzr58NQem4camZ2wQ
	DTsZJZrWtDFDOD8YJb5M2soGUsUmoCSxf8sHRhBbREBYYn9HK9hUZoEgifau9WA1wgJOEi/m
	HGcCsVkEVCWmPuxjBbF5Bawkrm48zA6xTV7iZtd+oAUcHJwCthJ/jhVClAhKnJz5BGqkvETz
	1tnMEOXn2CWWH3KHsF0kem8uZ4GwhSVeHd8CNVJK4vO7vWwQdr7E5O/rGSHsGol1m99B1VtL
	/LuyhwVkLbOApsT6XfoQYVmJqafWMUGs5ZPo/f2ECSLOK7FjHoytJLHkyAqokRISvycsYoWw
	PSSevX0HDegJjBLn99xnm8CoMAvJO7OQvDMLYfUCRuZVjJKpBcW56anFpgWGeanl8ChOzs/d
	xAhOilqeOxjvPvigd4iRiYPxEKMEB7OSCK/TtLw0Id6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwl
	mpwPTMt5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwpdz7Nn9W
	1p3nWsyzqgO7X6XUXJD83xOUmqm5f+pOjvWFXDJHJmfUajU85u/LlNfzlRYsO3jse+8MyUT7
	wvzYo/sFC24839XO9G/VnJg4a3f5C1nbj3Iv8bKNbTnhfPpfm6v+teYnT7csc5ToEwrPffcw
	45FF4P6lceIMrJmvo5may04+zP7yPmL3xRQ5N4adX+T5FJfzrA58yDzp9PM1TdsnyK1TWd98
	+9gemV2CyzM2flwRobNjivLyIzrrXFeLz2ve/lPG8K/O4fM1Cz2Yv4V9upvSp9E94QtPwEPl
	B2cPucX/d1iqr/nh9A6+f+b8c5znyUQdM1gW9HTu9SP+WfE272OcT4hPnX9IeQ+TvhJLcUai
	oRZzUXEiAIoxMssTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO6/mqI0g/5GbovVd/vZLE5PWMRk
	8av7LqPF3lvaFpd3zWGzODvhA6sDm8fmFVoel8+WevRtWcXo8XmTXABLFJdNSmpOZllqkb5d
	AlfGn4uPGAv6eCoe/GxmbWB8yNnFyMkhIWAicWPTM7YuRi4OIYHtjBKL/01ihkhISOx49IcV
	whaWWPnvOTtE0TdGiY19c8CK2ASUJPZv+cAIYosAFe3vaGUBsZkFQiQmn33OBGILCzhJvJhz
	HMxmEVCVmPqwD2wor4CVxNWNh9khFshL3OzaDzSTg4NTwFbiz7FCkLCQgI3EnOapzBDlghIn
	Zz6BGi8v0bx1NvMERoFZSFKzkKQWMDKtYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAgOWa2g
	HYzL1v/VO8TIxMF4iFGCg1lJhNdpWl6aEG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0
	xJLU7NTUgtQimCwTB6dUA9Ne3n3nHaODzm6Om7b+H8OLEydeG+1g0j4+/fq5B8cCd6yWn3bO
	TNXFsuB794tD1cJme4L5qmYwRk8RlJ7zW4PN3rzBQttoYcbH+PdNaUfCHhyZf9pxz8pzmn+X
	ximeL+0secJ/Iurhmb8bLaQrvgvvq4luWB371aQ35WkoU/ebj8cOv/zg6BC0o2SdppHRde9s
	PfuJ+43rGJd2tnkcOby1yFvhmHnIrWX2dQ4ff51S8fvIt6X451ruKo3ozP5nJf9d65vvfCtf
	+txG4cfpXjmh6H3JIfsmbCtpn/itodbvWfLqT0pn/hlkLzt0bK3C0UOXFWMsBfy+XM2a0NHc
	IFw6u0Ig0cEk7nnnxCkHbM2VWIozEg21mIuKEwHn3ZK7yAIAAA==
X-CMS-MailID: 20240619063854epcas5p2d20a854d5e73a5f68f899dad45900cc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619063854epcas5p2d20a854d5e73a5f68f899dad45900cc0
References: <693af28d-5e25-432b-ab1b-37eb9026c7cd@kernel.dk>
	<CGME20240619063854epcas5p2d20a854d5e73a5f68f899dad45900cc0@epcas5p2.samsung.com>

On 6/16/24 2:39 AM,, Jens Axboe wrote:
>On 6/13/24 2:07 AM, Christoph Hellwig wrote:
>>> We happily allow polled IO for async polled IO, even if the destination
>>> queue isn't polled (or it doesn't exist). This is different than the old
>>> sync polled support.
>> 
>> Yes, and for that to work we can't start returning -EOPNOTSUPP as in
>> this patch, as BLK_QC_T_NONE an be cleared for all kinds of reasons.
>> 
>> So if we want some kind of error handling that people don't even
>> bother to poll for devices where it is not supported we need that
>> check much earlier (probably in io_uring).
>
>There's just no way we can do that, who knows if you'll run into a
>polled queue or not further down the stack.
>
>IMHO there's nothing wrong with the current code. If you do stupid
>things (do polled IO without having polled queues), then you get to
>collect stupid prizes (potentially excessive CPU usage).

I think the problem is that when the user makes this incorrect configuration,
but doesn't have any error feedback, user is unware and easy to get some wrong
performance information. So I hope to add some feedback for the user to help
them more easily modify the configuration.

I got your point, therefore, I'm considering whether it would be more
resonable to not return -EOPNOTSUPP directly to stop the operation.
Instead, we could detect this information and provide a prompt (like 
warining?), allowing user to be aware without disrupting the original
flow. Do you think this approach is more reasonable?
