Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923762EB841
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318369; cv=none; b=TtE7BJh05sm2csUyp9eBU8qCJkxPGVAkylwYa66ZQLoXE0ZMBde57uA+k/koBaCY3FAOOSs4yf3ogCQoMYXTdVzfAE4JOB1LrM0CMrnmDIZ5ao6CWBiEs49D5yHFR/ql8rR7je9Kd403BeXNXJMRaE1fFKkAwld06dY+1djEu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318369; c=relaxed/simple;
	bh=6xkmyF5XZKw+4x6EVGIygZudWYp36C+Bq+hpfGTgz8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gReF/X3/2h5zugv4pvdx550m/DSujo2GzfZ4IGRkun4lBcVgaDFfl3zCkdaTQ1yNQsy3KGYSGE8zoDUTaZW6POLnf9J6Qw9tSRJ/tQ+7lVD4VFpr4Q9l0wMiOOsVQOw6HMmmeevV7PILRofj6v2UbSHbM/lQ9DfMDy2SKxjhbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOWbPOkD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOWbPOkD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4807068eacbso12219065e9.2
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318368; x=1770923168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idtwUK6BtIsEhpc3TaDCHUqHeRjM5Kpq3rLxxa+LHTI=;
        b=jOWbPOkDLf7n2x0zC4BPgs8f2DMziJiWJGoyo68VukLSYaANqW0KOZUk4bcJZqcWQc
         zyA1AagpKSPjetJjuhM9FnkT2u4epsAxd//I74ngUgrUWErA/I5o/TW+ADnN3bxl24Re
         a8NhJEFowiwFgz0Z6MpfL4fpeDEsetPYwVxLC5J4scNuNkpVAFFZP0skp6j2HWjXboty
         dra+ApdUMevRFxXUYBqarfT/8CM1rPpztmg37GLlRLsuK+0Z8FoHdnD3D6HgKycStHOh
         LJINur0yGhL9f3JN8v7dPMXZjjHVB4ohWtbZNnFnJ7pCtULfYZtRiBOl0gYvuX4u9sVV
         G+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318368; x=1770923168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idtwUK6BtIsEhpc3TaDCHUqHeRjM5Kpq3rLxxa+LHTI=;
        b=TBmYW4Jo+VXufNTZ75PF7WvmKknvWxOgw4AORHkjdhkJerR1xtFQYwWtEqkiURFZSt
         WzYI+BqiF8BiqvyKF8UZ5B+GPtWgINts4d2yKpMNeVyIHtmraBhCz4XDhP2rUeYgoJ+g
         bdZr6r9rEWAT/XOzYTNxFnrEVZSP7WRvUPv/fyeAo4Tl014TAwZCf6C9QCEOGEYcKquX
         jVsZHJgwVaDVMzEF6X4GFHp3fPvYC/mXhl73Jd4ROF+RCNLgMvfN1rZaBt+rTxJrk1/5
         SX/SJhqaQTom7TfV3Bx0KN6yQ/FljsF7yAd4a1ZlI3GPOoLLKcOkbyVFlt6iuuZMPnc6
         Q4Dg==
X-Gm-Message-State: AOJu0Yy8/fncXnbKOwyENW/YlnyNvwTrORjb7WF3a6BNwmSeLP+kK8Ej
	yNFcs2j4FL31maKVI5thuRG6GXWrC/crx8RzteAYXMAI6FznjU7rqk6+
X-Gm-Gg: AZuq6aLGn4UcBj/tXA5QaxSThmrBiuobRsAXR98rLaxPTYYua/Lp5VQY2FN2CTwaMHk
	w2Rrnk8s/Y2J3d6cY6NHC5R0M1qrNXxfsc+ChNAx7+9tgpY8Yq5QvImPJQ5FbYe4RsQ9xVZ5Qtz
	KLvzgeJitCLYPM+HuM0y/5bfmesQZtsBErGizn7ZbUlKxb7SBv/9eWZUoAsFBqKbgl7m0UIGR48
	Yi4UOeolZz6v0y0OUgq1JGfBGWET5TsfxKp+/vNCYEcZe0PddN3sSEkStTFJvkSCDwB9eiombsG
	7TUxNbp2fL5pe39hFFqZRiqFgzuQ2Wr283Z81JHc2NESYo6zltPMyqa/nBppRbEbt1ZRypwSxAj
	ZULDcrM84o7RTwt3NIjOd5yH8M+skA46ZfTy09PAJ1//L6tDQWomdjY8CyKxjw3LqaXWoAFOUXy
	zqIvhiBlPFmRIqP7Ha3gdkIWsLgpO0o2xtm/L8ggMFvro0SAek5Va6b/FhkaZPBK48Nm2U+Nd9k
	W2kflJjIUFdPonEhf2TrDXF5CrEzYR43PR5bCchRQZuTQDO+C5wKUZZUYxmG+TwnQ==
X-Received: by 2002:a05:600c:5253:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483201eead3mr7164205e9.16.1770318367919;
        Thu, 05 Feb 2026 11:06:07 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203d5ef7sm2743825e9.1.2026.02.05.11.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 11:06:07 -0800 (PST)
Message-ID: <dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
Date: Thu, 5 Feb 2026 19:06:03 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <20260205174135.GA444713@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260205174135.GA444713@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 17:41, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> 
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping.
> 
> What is this about and why would you need something like this?
> 
> The rest makes more sense - pass a DMABUF (or even memfd) to iouring
> and pre-setup the DMA mapping to get dma_addr_t, then directly use
> dma_addr_t through the entire block stack right into the eventual
> driver.

That's more or less what I tried to do in v1, but 1) people didn't like
the idea of passing raw dma addresses directly, and having it wrapped
into a black box gives more flexibility like potentially supporting
multi-device filesystems. And 2) dma-buf folks want dynamic attachments,
and it makes it quite a bit more complicated when you might be asked to
shoot down DMA mappings at any moment, so I'm isolating all that
into something that can be reused.

>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM.
> 
> We can already avoid the bouncing, it seems the main improvements here
> are avoiding the DMA map per-io and allowing the use of P2P without
> also creating struct page. Meanginful wins for sure.

Yes, and it should probably be nicer for frameworks that already
expose dma-bufs.

-- 
Pavel Begunkov

