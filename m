Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C434E4C38
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772567; cv=none; b=Z9htvnzFl2nTq2/k5IXtzn0h/44SLxUrjV9xlUUKqJgQx9PlkEh/HirvlBikaqejOHy0CiQpxv1P4vMbvaUwIAJHyGGjMUs8QeGqkqDHo+M0i3X95DmNk4oPwtF5CRlXHAqFZaQvgSNzZsGWL7OUZ2QAJ9ohJgHAcU1S5mQBu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772567; c=relaxed/simple;
	bh=TdyzSTHL7WYOVSGbZvbctK9FEuEdU7OX2Rp7WBlcsZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gn0soShgO6JGlnHnjRygwQQE5UQpcT1eAcQI4qsbVgKY2YsXRnLBBoZ5A18q5p66d2Hyj5r/RDYG0j9D5NPXDeYIYY7S3V1LlctptXNu8wnVKrUX9og918iFdd9GfN1K3skVTUZDHfFw4m0BzRuTKrTTXzHng8oBvjvuT0UYsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2krLUjP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2krLUjP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so22696665e9.3
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790772554; x=1791377354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
        b=E2krLUjPpvrjrc3xDD1ruwYeGrnztUDpB0EbXuqQ64ya+ghgwLzJB+1E5NNBi3dNmk
         ewgRuZ2yH28PCIEOpx8O5+lO4q6b7LiYehDLuET1lwy0FEs/jtsNRqUavw+Sm9UpWepO
         HFH3PDxavM68qWrzFfHptgwr0V/ux8XT8/IEzXHe/L1fwZSIFaTgSkv3seMwvR6eYmMh
         o4xgSUAIq1BWV8z5HbTekS6MAGp3aFxVP+7DLov7ntg9RGoIb/IwiFYaTTDU3biKzWZq
         yDB9TY9Rj4BnIA7cY177iiWNXZCg0b7gsuuRyq+8qlvtW9lcwTN748kT+6OZNQI2TXkU
         CduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790772554; x=1791377354;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
        b=v8Eu7aSxyKM7YMEUghMw/Jh3BMnH17U58KwjcTF5XZjMU14+Nq1S57i6wnpF4L1YIt
         ohDpx8uCxBf8fn3n2QC6s49xrEuoISagM5RnCYoQBK+VqqKR6UnEA/YGhbNLVK8i3Xcf
         1bq64VeGAuExc91ZA/3iSClwkcLr4fCtsnyJciBMoGEnrIgePgXFW6hCmXCvpvr4Y6DE
         AZ4zWmqIcIi/SSCVtlwxHvNGo6HZsg6tvf+eTZ4RIF0H4/YSjA6rlVMwh4bEe1C6Z4wE
         YR0oP7Nmu5SBrJN6ARH3EQXYGU5VKSjZgClC6ABg0ww/2Jhjzg46cS6YHTSJtxXTzpza
         kGRA==
X-Gm-Message-State: AFuF++mmXVXFmYXYA1OZ2K+deoaLZtQzR2WGtPp4aMmgUqh6C6/jSxI9
	hoqzEjE5nWZATuOA+3M5XUIcM9FWTnjCogZKZkN5UrFZqUJT+QTivKuf
X-Gm-Gg: AYBFou1djOD0S5T0XC7D6tRA1/ltklJB/lG460hj8JQUOPCNWtZwSrCZJd4qO1xojAY
	cRxE72JTmr6VyympKdtiiI/AbSDzD61y4pHwtaqJWP+9SagM29y0MGC8P9c8QHeRTfHg94zryvv
	ZzL+FAnioQxCv8V0aHzLR0UL2fvp8rcgBSEBRniDivZG3r56UhQhWeQDaGLlrv9qlsFxVFMHJEQ
	HnsfB94voxBYV7lVJ1Bd4MQmmjU5AUHIk46hTcUvcvf0TbaNURjNMJScV1nCywcKyg0BjV+Wvxr
	sZynxJRU8YXMhOdn/xBU9hkDlTQVC8oTx0WD3hUIv3BOj0CSirmLAMjmLSF/ZVIIIQgOrhJiUuW
	TcafbMUCawv2MAhcfbh8Jygt6Z5iGfu8kY10I9ra8tLubo3eChCoc/YOqnU9qJ3YxMeAlJ9oIt0
	P4sWY/j/3/QR91YUOfH2hpI7TjTSjVa0aP1iV3G+lj+gQosixwMVJ9Zfz8EzyV5L1msBoR2HjCb
	t3JUHcNBFChRu2ZgHdb+23CPgcxrW8Ie+pPtQs2QOQKor6B07MswdloQ2v0AYQtADNNPDVIdy5X
	QVwGAMjHwpJAWzzQHEa05F3YAheRZnO3RGss
X-Received: by 2002:a05:600d:864b:10b0:4a0:2dd:7573 with SMTP id 5b1f17b1804b1-4a01b12b666mr16604625e9.33.1790772554145;
        Wed, 30 Sep 2026 05:49:14 -0700 (PDT)
Received: from [10.54.182.141] (82-132-212-25.dab.02.net. [82.132.212.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01cb8abc1sm3766935e9.0.2026.09.30.05.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:48:57 -0700 (PDT)
Message-ID: <c07404e0-33f6-4e5f-a80a-e1901b42dc39@gmail.com>
Date: Wed, 30 Sep 2026 13:48:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
From: Pavel Begunkov <asml.silence@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
 <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Language: en-US
In-Reply-To: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/26 11:08, Pavel Begunkov wrote:
> On 9/30/26 04:00, Matthew Brost wrote:
>> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
> ...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>>> +{
>>> +    struct dma_buf *dmabuf = ctx->dmabuf;
>>> +    struct dma_buf_io_map *map;
>>> +    long ret;
>>> +
>>> +    guard(mutex)(&ctx->map_create_mutex);
>>> +
>>> +    scoped_guard(mutex, &ctx->map_mutex) {
>>> +        if (ctx->maps_killed)
>>> +            return ERR_PTR(-ENOENT);
>>> +        /* recheck under the lock in case it has already been re-created */
>>> +        map = __dma_buf_io_get_map(ctx);
>>> +        if (map)
>>> +            return map;
>>> +    }
>>> +
>>> +    dma_buf_io_wait_active_maps(ctx);
>>> +
>>> +    ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>>> +    if (ret)
>>> +        return ERR_PTR(ret);
>>> +
>>> +    ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>>> +                    true, MAX_SCHEDULE_TIMEOUT);
>>> +    if (ret <= 0) {
>>> +        if (!ret)
>>> +            ret = -EAGAIN;
>>> +        dma_resv_unlock(dmabuf->resv);
>>> +        return ERR_PTR(ret);
>>> +    }
>>> +
>>> +    map = ctx->dev_ops->map(ctx);
>>
>> I'm playing around this code now.
>>
>> I think you need the dma_resv_wait_timeout after the 'map'?
>>
>> If a device doesn't support p2p ->map() will typically trigger an async
>> migrate to system memory and data will be moving but the map is valid -
>> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
>> async behavior.
> 
> There is a wait right before because I read somewhere in dma-buf
> comments that I need to do that, sounds a bit odd if I need to
> wait on fences before and after. I can add it, just curious how
> come that other dma_buf_map_attachment() callers don't need to do
> that. Or maybe they wait somewhere else?

I can't find it, so maybe it was the comment below and I mixed
sth up back then. I'll move it after ->map().


* Note that for non-dynamic exporters the driver must guarantee that
* that the memory is available for use and cleared of any old data by
* the time this function returns.  Drivers which pipeline their buffer
* moves internally must wait for all moves and clears to complete.
* Dynamic exporters do not need to follow this rule: For non-dynamic
* importers the buffer is already pinned through @pin, which has the
* same requirements. Dynamic importers otoh are required to obey the
* dma_resv fences.
*

-- 
Pavel Begunkov

