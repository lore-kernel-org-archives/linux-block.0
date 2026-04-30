Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1F47B436
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574038; cv=none; b=Z33Q1VWx7W1k0Tmsdb0jBtk0p/7Hqg2tUhuU7A5ZmLBQwIOxBdO8f79/xYBQ3S8ZIuHfkXPnrbR2n85Ojqf2QapBMGwMuPmLNswnFquMl289dBVCK0FRpMzOshwIfZ4LDPpaoH4jaDQG7mx9819g+YIX5a1+THFJDhInRX0bzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574038; c=relaxed/simple;
	bh=/jhj+TskCXODG9hKampnDGfknOGVmEGixC/boL6nPuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW8Dip1bPHFThC6u+/vEB2pOAHxyaHB5Nkv3HFPb61R/fVj62iusIZfiwefNLC76X69HdOfWYGmkUUdgRs5uk3AIOrBOtiC7DW8JNF6tFDVO1EYruD65Q9GmfxvJ/Bb4Ymjdn2RstOA1w2pKHES9LMjcae6L1RDu6Aih8/SJrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYNxebG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYNxebG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso821000f8f.2
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777574035; x=1778178835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=IKYNxebG99rJmgJdnK+STw62yP2P2cdaJBZG/cigckDb5MYyuKKqqi+dTFU2d9cFZy
         qhJhEBM2t2gYyYxeD5XqrpJttoMPpfwDkqQGaWge8r5FKsdQAdayH4cS/hC2kxIHEYq6
         tGmHwVFWfDn2FZp49tR0EcsXlAigU9Sqe8yADo0AbxH22Zw75c684dLC6hfRE0EgxQSm
         HB1ngLvlfAIWqWDd9zNtUSfCDyoND4JMJTyGyjU3XxM4J+M97HrqUqLRf+QYygwaj1mC
         Ogr8gZjOmeYK1nNMGlcIaHaGVz3S2JshItziqGxqT+GC883q+Byb/VWR9AJNIaDrVgN5
         mk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574035; x=1778178835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=NfC9zHiZ7PR8o7si37qrXs3dmeTamY/O5HyiUsh8A9y4NCQyUavtqtkLSltkqCKdbQ
         Og2e5hX4mXVBDdenQRV0xoRXD2eYQy4OZONDNrSDq9XfKp9XmYBAshfW9ynwJScuuNRA
         mUS/Nj0LkTtutswjMBzWtvssD/otLjCXBPaQW8Hl6JTSzKFs1myJiefyq+266Cwtlyes
         g7ed81sV7St8gvQqxEADiIdeGyeV0i5RHZlSe6v0X0xhBpV26zDoTvOMi91wi96Cd9Vf
         RogJeI4CTDPRrMu8M0kA4+ijIPsXeXSBVb1JFfq7RkWgT0mCCg2whxD506GYJDkPGW+f
         JXiw==
X-Forwarded-Encrypted: i=1; AFNElJ/3L4gOACU6FZD5Ykf78NlLdjDGu44PvNKno5PTvukmJZP/ehpmaCi8l33DFz6/27Trz3aeFq6+1iUJ4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIFJryj0dOzfRYipVC50qtQr/Ka7yHYXxHoVMf5Oxhhat8cCd
	hwCRwezWh1tpUQbSUAz6o8v2HgjF4GE0LitdRJACBENOgxbb44V1tSSt
X-Gm-Gg: AeBDietMQsNgJGZYo6DTyHFfnAbzpOvp9WUTo2Ai8LCrKsuMCUj6hpBohOVJpSkD4S7
	x8aRBzOa7ra+SSrM00QSlgxai/j79gQzSJ2Qk2COdtX7liJE4pknoOIPdgtmX+VdRvCd4X6M2eO
	mWtrn/ix5AHH5mGzYVdu9XLGyPzqWqziBDqb940Gv7VvIuuF1ERHlZR3E8bAGze43CCUyZ7na/H
	5DVxEXdqH9DK0lAXRtdKvC26lc/2VPvAKWC/Bmwz2DtvjYrNdwuYcALu1vHm60yrDOX9jxxmMvM
	7O0S5QwZKenZIVuSM/KW3OWbmyKbaVjd6GK52b/gbWTbz6Aw7OljU4gm+JylYWU2aun+iaEGHkw
	60ULKbJa7csVLik47TmjBuxE6CyX4CyiU/UnuPYLupaNDAPWSoQDwxFagujf/f4N7OvRL2wym9J
	fQXRrle7NzoSqt2e2Ikms9Ig8Vn2kcli+Dsc0APjCRppQFOkmQXqbDLu1GzWfi2hwPb4FzuO0sz
	8KVLMDL5prFgRwmoUKszr0QZMBGNkAUKXyq/maD8UE7htJla9lX7fAK7aqUKdpjJOCMLfJto3Hf
	ow==
X-Received: by 2002:a05:6000:1a8a:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4493fa01beamr7079438f8f.32.1777574035154;
        Thu, 30 Apr 2026 11:33:55 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it. [2.37.141.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216eecsm13579672f8f.9.2026.04.30.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 11:33:54 -0700 (PDT)
Message-ID: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
Date: Thu, 30 Apr 2026 19:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term dmabuf
 maps
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
 <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/26 07:03, Christian König wrote:
> On 4/29/26 17:25, Pavel Begunkov wrote:
>> Introduce a new file callback that allows creating long-term dma
>> mapping. All necessary information together with a dmabuf will be passed
>> in the second argument of type struct io_dmabuf_token, which will be
>> defined in following patches.
> 
> Well first of all the naming is probably not the best. Maybe rather call that dma-buf attachment or context or mappping.

"Mapping" or "attachment" would be confusing as maps are created lazily
together with struct io_dmabuf_map. I can name it create_dmabuf_ctx(),
but I decided to use "token" not to collide with dmabuf terminology.
e.g. I wouldn't be surprised to see some dmabuf ctx in the dmabuf
implementation code. Maybe "*io_ctx" would be better.

> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.

I strongly prefer splitting patches so that they touch one tree at
a time whenever possible. tbh, I don't see much of a problem it being
not defined as it's just forwarded in first patches, but I can shuffle
it around in the series so that definitions come first.

-- 
Pavel Begunkov

