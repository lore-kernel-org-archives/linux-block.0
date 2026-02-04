Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F4325727
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205093; cv=none; b=BCm87gpmsi5MAKjlJm0SI6hcuW2cG4fKa7gJ7d4C8hoK+9kNBk5m9xCzUccvsJAHSWAbt/6GQCdX1cM5N6gFe/geWtnrGnRDarSa+UrS4GNYGpiTPOdp3dF7mT9KgQduVtr/WR1n9CfGNZc/FImleZkAhuImxgu+ltSwBjQVZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205093; c=relaxed/simple;
	bh=MF+F0MxmCmAJTtDcC23vc4GxbH150s8obld4ZtpfEJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWzPso3OAOkU5/p6jIOZ5FQLdX1ylOBed2SFyp49iujr3syZD2FhgFf26p8QW7OGljEBgz4sI3X3ndv1SHOhK/7a6BvyEj6OmfgN2NKXSaYE8PuDqy1JlConJN86qKj79yp8kV1qY4pP458fCr9nMk0rvVc/s0h9FuXDp/VTXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noKMSJ3U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noKMSJ3U"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso56860415e9.0
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770205091; x=1770809891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHhoGSxKy9vmjCLMZ5KoEcOBQkVZjkB8fx4BIL0Kk8U=;
        b=noKMSJ3U4dU2fl/he3lDjKMtnV7u0OX94T6am+/8gPpWThXEY5yAHoGQdd+EwUZtzQ
         HjaH4kz/Ju9SRqZPwRAG3o+yHg7alWpU3flr4KgHAbvFinumYEmXvgVbBzhT9rYQSWJl
         BrPwNjepVWMf8RBW6pPZk1l0WZnaR/PplPh/GlANKvCB1XHrkLCAQSiYFPw6RZ0CfX5l
         jQxynIC+bIKCRPInetCdd0FvHJwgMj+Mx+JlZa/nxq9JPDO3mxHq+wfKu3k/r4brlvPh
         fsWjO7cUPZ+Rbl9+26AWjdIK42T34QL1IABlXC+qDSRL/KKFmCjTaIo54S8ZT/olrnQJ
         7Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205091; x=1770809891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHhoGSxKy9vmjCLMZ5KoEcOBQkVZjkB8fx4BIL0Kk8U=;
        b=CZAywfdqQ2aPadTIlHupBckDAptlbLe2X5Hb0diVnz/s2wHSL2CPkAz8WNJHQ3gG1S
         UNdeDILdOFjTKGAdLV7cWtGKFA/j47Z7ipKosjvYbkeVVuFM4YVQ9XCjATTzpLwq4a1E
         778Oz/CVmokO0vyRkX59spoDP/OTqkTN1ZtdOQBqtDYOPuiXq/UgdMOwiNL2k7oNRwGi
         YupM43a3gG4/bh2rCyM2vQ7QaT5nFLCzTDa1FmjuVufENnvQqXarSUlk4doht3hEQpbX
         WgzN4leds6Q0urWYAb91oxKSZuGUdPRZ87d41WkjgFDX+/9f9nFSRwb+0bC+pwVQz9oe
         XvAQ==
X-Gm-Message-State: AOJu0Yx/9b6108VkgEcFGegVzu82fYbSc2cbNbqVWufXKHGSK4OpWM7v
	wdMJBJKA7NteHep9jRwsXIF6/G533LjsposNlptmTyhkSUimftcUWiZp
X-Gm-Gg: AZuq6aKhEkmWwLMzHDgYrV4yaKVZKRrSmLYxhFbzZCwJXREsASKKtSjY+A2DeWIRUVA
	CuoJ8z2WLhrE0LeRix3cnkiyTzuegCEtxoXggj4W4Oh594Uk3GTK0F3gvuVb9lPDtcIdzVz4YIp
	HeNQd44NT8Cu1A379e6nlUl0mt+PF1L2qFvE6anMckFL0ODwhIr0LigJq1t3EuZPojQCPW0KJOi
	8Eu8OMinXEqoykBNIek8qThIsxXJXBh+gZUD13FC+XZ1RWmEQYx5kSSW8gNBfP256cM5fat0ggY
	AIY9K2rL82DGSLL4oeB2UmLAIb6e6xU43ZD1XyFN/3nCWKbdt8LUFSl3YTEQbvVRMVZlheNGguJ
	i++6ahipY3bQoaeYDeMeF9lRZ+NnFDOvO8jq/+bHKvGKSjG6BjE2ihp5tqmPb0S3OURbxVDYtT/
	LBHaKE08hi4Kp2iVjmWhBIjfCHWS0os9pZikFt6r4F2fgukosRoIFqrWIe2MHMTSwfpfu96/13w
	eMp9ixRUcAwpyMtLnY0tAiVtj6wifF8zmbEx3HaRvz9sWQ=
X-Received: by 2002:a05:600c:34d1:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4830e92a768mr33410685e9.1.1770205091057;
        Wed, 04 Feb 2026 03:38:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:d656])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831089d547sm52311635e9.14.2026.02.04.03.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 03:38:10 -0800 (PST)
Message-ID: <82f0e957-94ef-45d6-971b-951540bce136@gmail.com>
Date: Wed, 4 Feb 2026 11:38:09 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aYI5S1puAZ-rPvlC@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 18:07, Keith Busch wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>> Good day everyone,
>>
...
>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
>> previously reported encouraging results for system memory backed
>> dma-buf for optimising IOMMU overhead, quoting Anuj:
>>
>> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
>> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
>> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> Thanks for submitting the topic. The performance wins look great, but
> I'm a little surpised passthrough didn't show any difference. We're
> still skipping a bit of transformations with the dmabuf compared to not
> having it, so maybe it's just a matter of crafting the right benchmark
> to show the benefit.

My first thought was that hardware couldn't push more and would
be great to have idle numbers, but Anuj already demystified it.

> Anyway, I look forward to the next version of this feature. I promise to
> have more cycles to review and test the v3.

Thanks! And in general, IMHO at this point waiting for next
version would be more time efficient for reviewers.

-- 
Pavel Begunkov

