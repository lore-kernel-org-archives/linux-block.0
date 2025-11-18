Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B2248F4E;
	Tue, 18 Nov 2025 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437695; cv=none; b=PIYZp48EcRQbOE6777t4f0kBF/+e0Vm7+FmU6h4kucbN//9aJvY/jOgaLqAwLjBCWwdnL3Dd1YhPfUyJx1eCUK8OuJ3zW4Mq7juF+BdsOZp4QoZX+xtOqNOvVcSxHauBe4dX21oOEbpF40VJ82EQIyj2LHv2hPztjAx0P1c9BSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437695; c=relaxed/simple;
	bh=9aRquP0k0CRuXMKjlC/JUHDjx6y/fzBBaTS0hUFw9zo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jkExL1X0iV0BK7vATpTadcwOVeXUslEQaMcG4cKxvOk+2vpZCLHVZce15tK7vWwgeLODkXZeKxZf5TBk29eyOb1FCaHpAK+Lz1KdZPURsp2nTZigxIzqml+jsxL+Qz9HxweWBGvxB/2go6dzeu7ZetwOF4Hs3wdBBqQ2pplZWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=A76Ho/Av; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="A76Ho/Av"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763437691;
	bh=9aRquP0k0CRuXMKjlC/JUHDjx6y/fzBBaTS0hUFw9zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A76Ho/AvuqUMurzKjrXb7KO6fp+MPTsHH9N0meWtZQaAothlKhh3iODPn0ydupTkk
	 qE11LFYKhBS5nHrxtT4O0hcs6aZeiXwMtRDbNm8jWqa8pBTY3vwINH2Ve8t9AJ4n6O
	 b88ZSb8bQeGDTu9W+/o3vMZ6ymHjRzcFX9vvt3kQ=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id C07A8C22; Tue, 18 Nov 2025 11:48:07 +0800
X-QQ-mid: xmsmtpt1763437687tw5mmd9sa
Message-ID: <tencent_3E9743D12F77CFF8B8EBDDB9529EDA975306@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4Ag7myerlRVic0qoCY5DlUrDcjqxj2ytor3y1jT975wl9ilILPS7d
	 mAAByoXzaYGiVr/mjqgPuKntmIzMBp5xrlFTKgCQVMb7s7RtU8MlS3QdVSzwaRqghmi2k0IqyKEx
	 EbObugFHd84YXzikQxBmsq7SeXUf2kg3iNSJEH4enrQEmDMDsGgqPZT3SyGFWFgxuiEDYkJHoJJt
	 2I9WW77thHAPls+llTWYu8ZOwES+hVjhdniMYITEcSqpVh3ePLcF58bN4vETagcaAmZQ4+mt3gYp
	 pdat+MjK5ORcsUFzhiRnoOXQ1vmLUXmUdkXQxrK2l6tgWq3SssV/PdFygne/25tK81vVmRG8WxT0
	 XTbRqDH7bhrUqFEoc5MN5Lk0I1YxbGzFy3gUXCeiijzgpSIQYfQYUi3puW3hzkvFKWXwUGVdxEbV
	 3KlIaNLz+laETZfO1JGJ/KZuWGaOYV8KAQgkLzuTZq/nKLbrNVj1V05zxgtTD4d1SQXhn1Ih8J3U
	 bIVB1hArlG0D1TSMWzkbLolS3sKVuH0JS6AdPkde5XCEjvpP6R9wuircNu385+8OHJ9BRrA7tBQH
	 Hi1JSIyI8gpgI2hY5iub4A8zjXj26LZnJAnZWGPZIoeR/9T5wl1IwU1XjrDkfHiE0Q0VhCFzXM4o
	 d6tjXuxe1WIZxZ1yj0UzL51kFt03sy8SPyZfqpgzwYB7rcyq8i2wzJc658JmtMy+6SULLChE09j1
	 PGCreKBUTQJ5RZbyS5ykAp8X+GRlUu44dSSyl057fMbgCGY906xb5gFA6nPY3Pb6t6hZdIB42bVo
	 2+oo0VxpfKCTJ8LBpgDMKuft0lSTAaebtJjzWL7KbNeEns0NJ/aGH3JIjZei6EE+c7+Hc3fpRuSN
	 NUMIwDVSCuwHVVv30Ew26G+lFYmVzdQyNSL6B/lb+HQEDALYFD7uar87GSE6Jqx7/ZGu5QjKYMVj
	 IMtJMhPykSCfgH9XeW01JYT/D/ySE1n/0NQYe+abhXV0pxyhdPsCDCFhe8ZAX5QpRHnjWIntbmXs
	 nIwvsd2Oc8ohRYAKhXzxpL3gE3/41+kmFAIx2XaTFe1HdY1yDutAXhQwIz+q9/8vnhKri/xjt74C
	 dd050/
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: bgeffon@google.com
Cc: akpm@linux-foundation.org,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	senozhatsky@chromium.org,
	ywen.chen@foxmail.com
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Date: Tue, 18 Nov 2025 11:48:07 +0800
X-OQ-MSGID: <20251118034807.2801578-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
References: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 10:19:22 -0500, Brian Geffon wrote:
> Out of curiosity, why are we doing 1 page per bio? Why are we not
> adding BIO_MAX_VECS before submitting? And then, why are we not
> chaining? Do the block layer maintainers have thoughts?

Mainly because the zram backend device is quite special. When
performing the writeback operation, the probability of continuous
writing is relatively low. If BIO_MAX_VECS is used, it will make
the logic extremely complex. Thank you very much!

