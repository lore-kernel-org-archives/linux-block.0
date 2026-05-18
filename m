Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE53E3DAA
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095591; cv=none; b=Qd8kAA7KWYMx2bKoW3874jOZJy0y1nVyp7TZMLryzn8Qs9TpSZlj7o1QRtLupre4bT6IkukmVs6eEDWlFESsLb8s9GNy3z44Re/B1+sOtLGcYbOG5A20OjPxODBNLcLDkz5bFSaN8+GL2wcBu5cpS/0+ixh857ajMYv9rfHqDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095591; c=relaxed/simple;
	bh=/W8E/uJT+njUZo+KbiayviEW8GF8DDjlc2Y8J9q3llA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD/G3OIr7IOKt30vml9zyKhMt1ncGbAyYkFxtBCevaWjRaKkYXpuT6IbmaSK0BZrFEx2cQztKTNNifeV9/vORz66t5YJPfkzS3ud833JBo4vEP8NeIIZUzYqbCxrNvFDUQjis2MXUev5SuvDTs9n2g6NmGUAsjqUsA2+9oWeJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ3LMwfL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ3LMwfL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0046078so17753265e9.1
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095589; x=1779700389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
        b=kJ3LMwfLwL6XVhhLsb1SGnpdIPkgtdx7c5aCOor9MszrVAOgWkZm3xdjWk+SpwPfO5
         M/f7UB8N7uLp1FYlYsum4j7R/boSI6kOkz0g547XeuJZEqnLF2xmz+oQKkBskRA11eoT
         0i7v6bXvmtOlabA2zcuSEFMODHUEvUQs0r/uENdTaKIeidz04Ye5OAkkPdPUaTdgNW4e
         9+JbALJQwZ4woVn+OsXerhiZ8NxPOChI2tTDcQt7KzLAV4Hd6Gj7NYdS+Ey6XU0bR5rQ
         0aXZ+PR/hgj/TxCFJKgGKhd0HjllXlzojeNw/N3haemcGtEo8vQNQmyp/Dc6DFv7rDqv
         4Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095589; x=1779700389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
        b=Le+AXXgYeMxoHfuJCOY1YECKIckw9pnm/BWqQdQFJSePXJD9aGIoxmvzX6sqzVcBpz
         KjZ8Ss1dSEW6nsBwwSXBfhLxkFC1i5g0bAvtIkGOnJIaR3Q2+vCvZYCMfr2hzwXkRN7x
         tLaFxRdO+/QVXJ/sXDR1m8DHBrjNlSAHOexm+slkslJyJwTmrpQjCTPjfpiBcymT8L+m
         4R//oOrcYYnnH83jtEjdLRs/ilpiCxchJmsbMtlOsHk4SvPS8c63Ns5PVZHu2JojmKGP
         +qAwdM7WPrtg1fsUtwVpnBAEM+8icGkB7B2IbRdl30YfgikieuEbtxv+kizthiNzJALy
         JL9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+WWMxp8nmO5OAtPU+7CgF4lswGEvEVycJXTUyyMeGHmaEnUI1+Dlu8SE/XntwQa6hgxsOe81JfWdY6Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4At3YONunc58Pwrr/W86QZvGwx8HUSUdoxCSpUXhmud52+xk
	nc+axgm2DE0gXzt5Bdc779GYwWwz15yLmB4Zl6NU43kl1Vj08Lx5sL/L
X-Gm-Gg: Acq92OEYvUybbLauo2GTWgneKRc3LdsbwYVlMnmxcHeYqmZRnbTZP+sseMROfNk5qYM
	hymyAiqxleCQ1klzZAAQq/oZjUKwW7B/S5x5JvEb5luf68Kv8rN+yZv/JenkJRACRR2zXJ7YkBr
	Gnpg3EDveJg92+l+4qhSRSmHH/qj9YTjhxppoc7XyXBh9ubtC5mlD4T7RvN9hU4tfoXwEw4GBkZ
	DpmVN3sE/D89MPIahhoSf2w9+dMkmGmzABlnQYKGsaiMKFdgHO3lv3WqEIWsfBWjbVBOPY39uBa
	a2YvxwFzxvnABaMGoCAWIofQ8gCgKsO/6noxW857lRAsF/erZF+IGjqIqE/UoZW70FcekiAnXB7
	O4ogxjjwg5DbUl5DiHODTEKHtmpIFldL/9WA6ViWuhlUsr+R+6aU5Ml/lXHg5ikbcyU+ymIfskG
	R/8Vb3srhYGXY99z6W8pWBWGCIf8Y2mJMwjkcs/h+MQ2t8r2rAJ1KmIN+7d6dqQFoKYr0j/okwU
	jOdEBAYXcJ49F4ek//VVV2d9Ss+xA99SkKLAc4HulvPTJ3SDVnYFW+lRtc=
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48fe5fcdf50mr205316035e9.1.1779095588623;
        Mon, 18 May 2026 02:13:08 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm36837416f8f.29.2026.05.18.02.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:13:07 -0700 (PDT)
Message-ID: <88576019-44fc-4614-9e89-a17478dbf340@gmail.com>
Date: Mon, 18 May 2026 10:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
 <20260513082553.GB6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082553.GB6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:25, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:52PM +0100, Pavel Begunkov wrote:
>> Add a trivial implementation of the create_dmabuf_token call for
>> block devices that forwards the call to a new blk-mq callback if it's
>> available.
> 
> This should go into block_device_operations as there is nothing blk-mq
> specific about this.  I.e. even if this patchset doesn't handle stacking
> drivers yet, it should be easy enough to add them in the future.

Ok

-- 
Pavel Begunkov

