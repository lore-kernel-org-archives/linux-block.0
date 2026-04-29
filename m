Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4237B415
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476611; cv=none; b=jqXmKM7qJV/EnWo38I+BWHToW/pn5olkwJ9+QdfkHHDORlCq+b6cvevlVF31LYH0X/lPXMuWKbVX/UoxuA89jsmmk7ZcFKyRa+CuZF/rwaB583sB6NWSfxxnAYPhT+WhnDxKdgwU/lv94ivmDsbVdm0csSG+/7UAE1st/JcAC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476611; c=relaxed/simple;
	bh=rzuxUcixg/aGo1wsLI7mfQXDoDsrq+gCA/2UqCKDcbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUXinA0Jbdsd1q4r/80L47YX5aNhHox7ilm6/B8JNJ8Iyrlze5LvDMyhaO92pxenhhxXSXEobhh3NZQbwNRbpBf3H2nhWWMAXW+jPTni6WFvBmasD+MyLfDOk459KzFuG82RLdeUqxslewfe6dGlaECVOtCMArwuk66FiRxk9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMkRCmAG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMkRCmAG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so9976302f8f.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476608; x=1778081408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=qMkRCmAGPF/CQdcPyMvL7/b3NrrRRQjb9rPJFbEO+e47eRTPnAFflJ7b7/PXCP3za1
         3ecR+Hipy0pr2biy0kmthF9f41ammpPrxLG4BQqO5tHigxmxrKm3zPWOFdhUVbOwpl+G
         dDvxE4hDeh7HYZdShxmepG+bcgdeMrvNTKjgP4hW4567eU776FPkTErKOZTp2J/+JrFG
         jVTk2AjOa4qDaPOr34pI7R7g2xRo/jz7rj0pmtPYD8ZGilkaOFPgMqghJJlgE09MsMLy
         gmb8sXsShLrMJEFyD2OUoNV8ga1ftTKs0EPkyc4QBg7KjbnrHqqABWouhVnp7eKEkqjx
         QwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476608; x=1778081408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=S5Gk8E028qSPhAXXoCEeiSNyU8siU8eGudMUbAiDqZLxYLQD8FE3o4M4jh2I7O7jPv
         udPzCab4UYI9EGrSmyiJuiLBGPC70TSP/vnh8CtDl5jsoL9SnOqPYCVI5mylG+z75lpg
         6pOBHPk3FJU9WxEwqoVcdKgAJikxepn/OUsPtO4NHJEf5UJYU2LO7snJ1kXAU5jahK2R
         eXUjVIECVKxZ4liaio5ixlnrQgTA/xHt1DtFQl7iUJlFgkoO3uzRgcnG4yTq/4Zmiv4G
         CqYDkq6P6dfPiGBNvCt3Axkg9ZyiKSmcxBwVpEXZyJ3ozGReM/M1wa823KRBd+1F0YK/
         ZcUw==
X-Forwarded-Encrypted: i=1; AFNElJ/NSfqbgiBlX9r0HT10Yvisy8INgy6jsjoz2I6i4EDtinK5jAVJazmq5I+2+COqiW//0i4r6PHEhla+aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgS7vXcQucEZlNlZVNs0I/lN4n4U+xh3H/hSMgalojO6NzCjhd
	Mz5ZBqcaG5NhKgKsz7xYnqXDhmMl2TL+zwFE0YZc6MfJqHrOzXENrdE5
X-Gm-Gg: AeBDievYZD2fNZOeoSKaDcopa7rqYcq384lX90A8nCExJDXPGL/HR2xv+Wdc7YX4kn/
	Y81MdWI9ToRSz6lZCKGT5iL4gjiOlgC/B96WgR333MoEITQv2m9088PmLOHJfNmEPkSlUhIAwye
	18T6SFbZIZAKYukuVoUtaTbtrCfkJ6W4wMQbtUubkXVth6Z2X6v0N9LJ+1w1o57VJCpvk85a8uq
	zXaKEcpqLNv8rLAy1HGXeaUJNaTT/uDKI+W41FSCncckudfU0fO00HPlqZPKXNZ4uEcHtB6mJvA
	zdVaAwVnvmk+W1+U8GP5pn4+Oi2CtwwAD4lFI7wRtdRjevhfuoxgFQiXX4Rv23LhnhXZzOnMxQW
	Ci6VFavMCkjAlFboGSW9yaXqSZw3VCPwm55hMVImtseDagE+AeYTyYoVAk0p9vbOJ7VCD2Ibyof
	62EuzGai7aCoevDY014D58V6367HBbB2gx3gpySzDTVwectwUPYQ+OzjXVHm4J19I4Max9/oIVY
	erud2zigaRKpY1uy5nO/032ffoiK2GhicY2EKzsKA==
X-Received: by 2002:a05:6000:4313:b0:43d:d037:d59c with SMTP id ffacd0b85a97d-4478eb81cf7mr7566713f8f.16.1777476607642;
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Received: from [10.228.209.141] ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm6740381f8f.8.2026.04.29.08.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Message-ID: <46bf2c04-72ab-48a2-a8e1-9f4423eb17a6@gmail.com>
Date: Wed, 29 Apr 2026 16:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 16:25, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.

I left nvme request / map setup as it was in Keith's work for the most
part (apart from rebases, adapting it, etc.). It appears I have some
use for prp lists, and I know Kanchan, Nitesh and Anuj already have some
patches adding sgl support and some other optimisations. Hopefully, I
addressed most all feedback from v2.

-- 
Pavel Begunkov

