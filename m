Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC60139579;
	Wed, 12 Mar 2025 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795406; cv=none; b=mE07EM7WhGMn0QgGLbTwaE2bD+Ouw2WU2Faw/Oot9BrKIhc/Vx1Hi9A4R3i3r34qxnSsKhFqYs5+PhzqwKObD8z8vRJz8UbUQa+MsyeHW44ziRrom1qM/XytTE8fsfZR8jjM8N+eh3ktvqC+3bLrDRhjHgUmGKDBjbq7cGIT2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795406; c=relaxed/simple;
	bh=c8myPlYxHfs9yha2DjOF6ku+hDz/GJou7sbTuiMnR1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+6volUGqcLTTFZfO6R8HRefB7snufXw0EqWM5NqXBKfIGpWnCJjwoIrocOyy+HsYivWAwgzN06RROKEeMGJfnq9HqRbPAJHPxOpT4A1bWQyQWneCR0NufiOLzdVQmdQOxpQEUgZcSFV6DF+8wZa52HmwrYKDyNjtJ9PGtCK95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CsjIoS/a; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CsjIoS/a"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZCb5P2DVYzlgrtc;
	Wed, 12 Mar 2025 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1741795399; x=1744387400; bh=8INkWn/pksZ3ktdECkxdDSvv
	UZ2/x973jg9Jpro9NxQ=; b=CsjIoS/aaxbrfykT2+5DN7NdVA74K7YLMo92eMuk
	QpweIBme0qx9s+WqSeG/aIuEtJJzi7rfipAjD/kHCDKiRmny4pi/of6LGSQQbwTx
	73C8Y1GZdt3pIepmT5uCzNQQCFONTw+8dRUOzfZaAw3GWCrvXpQ0wiL3g/E3Rt21
	rrRJs0XlhsOeJea+4wxO35stc8h+GcU7toB1KuJ8+zm5EmQ8vzIUUK6dxIgwDxmS
	01un0bF9JxFzWIOAmLJypLhN5XMk+FAjwD/hLME7Z/wRFpMpD+sIOLKP5PlZsoiW
	+CGqF6uimjp/rbRogNSzlICVWvhGLuR+4cubXnFDN6G49Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MKwWVlfE6MBl; Wed, 12 Mar 2025 16:03:19 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZCb593RJrzlgrtb;
	Wed, 12 Mar 2025 16:03:08 +0000 (UTC)
Message-ID: <14a3ea66-9f11-49fd-a7ee-c04be1d428f5@acm.org>
Date: Wed, 12 Mar 2025 09:03:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
To: Christoph Hellwig <hch@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, spssyr@gmail.com,
 axboe@kernel.dk, linux-block@vger.kernel.org, dhavale@google.com
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com>
 <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org>
 <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org>
 <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
 <Z9Gty3Ax-2RslqDX@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z9Gty3Ax-2RslqDX@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 8:52 AM, Christoph Hellwig wrote:
> I'd still like to understand what the use case is.  Who does CMA
> allocation at a time where heavy direct I/O is in progress?

An additional question: why is contiguous memory allocated? Is this
perhaps because the allocated memory will be used for DMA? If so,
can the SMMU be used to make it appear contiguous to DMA clients?

Thanks,

Bart.


