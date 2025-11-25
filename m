Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF42D838C
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074112; cv=none; b=PcXRiZjsokdvfaIgBMz/jxexZ0JJtgFVAJhXAcJPeBwPud/pxhMkIDe462wK4EUe9vlD/QJn6pJzhGEIffeQ/thyS23Ucm0u5sovKNu2cSy423UN5vQJYTsMlOqwxfouX6xLtZNnBniXkDZ9gZbd4sXMdu1sUNgpQE/vAOapVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074112; c=relaxed/simple;
	bh=9KhMQtglvgwFLq0EERoB1DGsMk7bVLgsTiRTkQIulec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrmkjB4/yaR37trl74eBjzp8YSA44bcMnCQNUOdFnZaTnVFbJSJGiDxQib76T1fFuTX9OF3cnUF/dh/tgMWw/LtWQJlKqzkI9j/6IO+r2q9pl7Pcm/6CUbJPmA3J4Cx0gsxluuIIy22JuxJHp/FpdSipIIZKixpjWqTm6i9Ffx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9x+YP9E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9x+YP9E"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so35923795e9.0
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764074109; x=1764678909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=P9x+YP9EXEnC7MMe0F5kk8o8F2AB7xaZa3E5RBDar3rlAchOZ1QM38zsIjtdEMifEG
         +3hXpND37T/LymWCB8VBxtGVRlPmm1kjRs4JlZm7WwVdlyfNz34bjzaDAwU2hbzWk2r4
         +FC5ikpPr/GNlJ2R/6WgiDYkS28IpAopY4azIg/V1BXMSzBFaDQ2gJ0YRLLUbTaOUiuy
         8ulPp6kL5/nmLgahc60VtlvC/WdwEuyYxJwlYlvCnwAdC00hO6zjNlDm7HmKnnfRxJvA
         WJIhjwxihIeragaJP9AetoGmnIjR7ceg95L66JS6cZzekSQdp680VNlYWm1JHvdwoWIq
         1bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074109; x=1764678909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=xCCpYu5KAae3T6iftL8ZJYgxjJtVmjl2nR3ChsNkdV1IOzEHnBv615Mc1cm/VNDs60
         n28W1OxjYhXjfczrZkLh149dIJPmUanQI6Qv0g21/F0rw5ed8gO17CpxFp6IfRAe8HdE
         WxU0qHdE4OF7Pl27BXUF5TDtzXw7TPrIQKk1M01SDzff6sXXwfA0pojyz/SWFBykzusq
         HLjKhNcvD8/QXH0QdQ+WuW+IP8IeWgUsS04hEaaXepTTS5unjHtw69ZO1okjMAyLvrcD
         OgZYtbsYlRRZYsL2QzS17VrmiDl4nQcRwOSYUGx5SaQGS2oq/mp3Z1GFesddfXaRZUPR
         gLxQ==
X-Gm-Message-State: AOJu0YxZ+UQEkbV6Vy2/f/skHqqVq0KsDcnWZ6FrdtJbi3Anmjtztd00
	Zyri9ivlfaJpKBQmcFf+UGu4H/GIlL0fQAkplz68kaItSeq7U/W0wSeG4TNvWw==
X-Gm-Gg: ASbGnctf3kUtclRnx4rIuPdYhIEyXhSTr5i/Td/fghXFO9kGjd1wpuuaJ9RFhOEeAXI
	IklfoSwBOcFMBd9CILWb052p7iJHEFxMgR1cpvJERFGBT8mOKM1BiLAC3cFQpSOjGj161hgupEN
	ozts1oAW0DkJ+/X0iOJbhSFvfkn4PMg0NfyGmGIRzKDyeuVrzvY4+AAK4uQ0iGO1nb7aisDNxPD
	eGEiH9G/ezpKLXkuOWldmPRQOtV4QNGLbUWfH1xcmCR7g6Kmklmwn6vINCX+9JPL8XcbZ/KQ7cF
	sbUlm6UEGLay/gGuZhcxf6Cvil06zyKmbr1sQJGuOIe1WsGVWz1Ss1aM78wFqrKjUhQzp7PMAKo
	1SPyur4AbeXMakqrfNo0iaOxAB1EPGkdE7pG23hJdcW0TFgLvzy6DhNATvv8WWCJTe+43sRM6bP
	egsEnD1201FSsWdlqMwWIJqLYeX5hPDOH9sMEyzkRSJ6orKwFn6cAQkR1qPnhriw==
X-Google-Smtp-Source: AGHT+IGiAByXWX/VuXJ575rRIj6bTeEbAlnebab6FY0vB4jAmRqS6rohlKvvoUgeChvVCplBX1c2lg==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-477c1133e4bmr159739175e9.35.1764074109236;
        Tue, 25 Nov 2025 04:35:09 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm33941871f8f.34.2025.11.25.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 04:35:08 -0800 (PST)
Message-ID: <1f8b5e97-1f3c-46f8-8328-449c159b7d66@gmail.com>
Date: Tue, 25 Nov 2025 12:35:06 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 13:35, Anuj gupta wrote:
> This series significantly reduces the IOMMU/DMA overhead for I/O,
> particularly when the IOMMU is configured in STRICT or LAZY mode. I
> modified t/io_uring in fio to exercise this path and tested with an
> Intel Optane device. On my setup, I see the following improvement:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> The STRICT/LAZY numbers clearly show the benefit of avoiding per-I/O
> dma_map/dma_unmap and reusing the pre-mapped DMA addresses.

Thanks for giving it a run. Looks indeed promising, and I believe
that was the main use case Keith was pursuing. I'll fix up the
build problems for v3

-- 
Pavel Begunkov

