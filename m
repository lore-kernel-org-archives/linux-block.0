Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592593;
	b=XeR7OnflJIbZbIn/Svzv3mXZoCLLmnJvRIreh3hRnZ0ZHtjk+rtuefUp29T+QWo1RZ/3
	 9Jo4+kdAJtb2pMyJGcFyBijQIvAXUTraTT8rLfEu8femv6mXTxssem4JsN6PL8Kr8CIAv
	 gWwlpBHF1MUMKw+l6ws/o1rrc0WC7RTu2l/Rc/am81UQmtFAd8RuyoyiRHSsEd1tyfvz3
	 xhnVYjbSKL2pNn0d+VD1o5eOtkSJGs8OxusRHV5BdZjCeBjXTvbfUohHxU3+wvisgRc9p
	 SKwHqUJ2cB/bA0Z2dkrN0h4WdaKh38J+kDAmg0tmVq5o3/odIIs7AoL6MCC2Skh2TaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=;
	b=xb8bw7Gcgq0B8XS//UhqkEnrAQNzPvl9DyhymFAG098G6ssU1e6GaleJ3cXzbcIsycQ5
	 bU+ULwY7kxVvRZhlXl16cwUHLFuDyo65JBAnZSHzlhWzOxqX4jR4oa6CK8y+gbff1CBYv
	 neJDO0tzv0dWTxVwW9c68sHYbvePn8bvqjAx2cmLm0/eyisBSyPqLx1+ZMdGAllJ0iJ5z
	 +LKyQFbvIcmESEsSjzPdm6xd116KIQmLOvyNWyH3W1IYiQjTkwVIJOB2tV/2QIoaSfHLS
	 hEarXWS6SEVy7t8oiD9rkchV3hcFjG7i1cHz2Jq1aY5yCyrHi509SYVyR++gnxRjfyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UmrN72zC;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C27606A330
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 14:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C27606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UmrN72zC
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1ddc7c9beso4428135e9.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592591; x=1793197391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=;
        b=UmrN72zCxsSETrtXgFu1j3IULAxtC3xJczMlP7lP2PcHwldVuoMlyDYQqycuGBWZA1
         y6UNV0K35EQgUtcF+BbxS5YF6SLD/pH96aKKzbMUmTuJKhHoU9HfAS2dodFs1gHILpoh
         f8W1T2XIkQH0ojDxb/mjKnDxHKEPnJE4xfd1+wnet4R0hmM75lrK0LADdQBs6RuhltzS
         /10fFDKI8nnhI3p8iUg++UjM603kachz10zn2bNWObtPgrRiGauJmGKlfsv3d88O51Dz
         1w36jFtVIb4Lr6Cen6OILMPUgkZMyOhWKWwiuTyhntW8olf6CGUULgy4KQZuNVJT5D8O
         F0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592591; x=1793197391;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=;
        b=hf9LvNQqGFBfwJM8M/eAXErgqnQcaaiQWaIPX0ThSdQ5WeeV8+28Y5rmidglMfOhwS
         Fbwxc8kSsqXSKs653f8S08gOUW1YQpWPl9RE69B9ZrAfmJfOVNhMTctkBLEeR2UomoCb
         O+uutu5l/WpBaSudkISjrg9CE0rViYQ6wxD3bP57JNprxyRoZ5dUAPAjeZ/k3K9Dz0yR
         Rxj9eIe+Wbq7vLpLeRR2mzPci2+LvIt4WHvKpIlNOJTw1htIVTRz49oYiJV36TT8GA5v
         ldmozgyeAUtrl776VTPqkPGvg31bXNXyCmTsdpyrgcwU/xqv180MXjIAMRo7rBhXVc9s
         5PXg==
X-Forwarded-Encrypted: i=1; AKwUvBxCC2hvnPGIF45dzBdZlpzwnT12NNeTdnSl0n0HgUcZbPaGfg2/J2H7GsrjK+4DZTZnd2EaqmFWX0CnvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdM4JcSj1W0Kpn/Bx6/zKs0GI7OuBA0rvT6fbpfuhYDe/350Q/
	NpnoykS76l1yZMCzzbS0emHpBf2nXTC9xO1BykOYJ7ktBri5uarxyT2Lne8Aaw==
X-Gm-Gg: AYBFou2Ftkl4L2UKI6OptTbFVg9vLLGbNMxjzMkklhUBUbR+hpowZ478IcjCtFqUmSL
	84ypPwjT25AvZA1JK92oE7nY2V/R7JXv5tYU/hGVY7ajf45+upuQ0yPdpF40LXCH7HC/9Mvmue1
	7ClozX8jhcZJ4MNQxdKK1Sv7wG5m09qIfco7R2S36ssQPKIZoC9mECXtcPlUSWFnV5gBovFgE2R
	W8ucW0ypm7qrXWuEujcZKMR82tBQF9qCmwQgCxElVL0IPtSHuo9uHpsij9kaasMUcxIz2jn2CX7
	DIBfsP3mcAQESWvy37lwnUpImHOPwMY+Yc11vkuXuIzQ9MRF/vPv6EwEiIYwuz2Q49eWIP+Aa2X
	wikN0ICz1FfYosjvY2ydUsK7Dr4t4WiHkEcU6LVCg20zM2xqL/q+akoyXeOlnuVbZ45e/OU9yUW
	dpHIhGjHRnXVl5qkcIvzAi+wUPQqhb2vHhMeTWfCBS3IuuMAXy7IZznW9wWKMk/OvEsWRgkkbmQ
	l5P97vL7nHIH6i/hTpqOd+AlccZaqfmNmns1ziFd3pGNlBvrYDZfkHvLdMjskWP1ELS4hdwy3ej
	/XH0H5CkaupYbz+UvSh/DxuHD+g2STKx7PWZamYUxOiyVMXSyUxxx3Im/V3BMAIcse0Jl/sgHNj
	o2jqYkvs=
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr32967835e9.21.1792592589343;
        Wed, 21 Oct 2026 07:23:09 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-19.dab.02.net. [82.132.213.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb80ef02sm83229375e9.5.2026.10.21.07.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:23:07 -0700 (PDT)
Message-ID: <d0c8cc97-6a21-4c64-b55d-16af783fdb59@gmail.com>
Date: Wed, 21 Oct 2026 15:23:09 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
 <79627452-98d3-4e8d-9c37-ceda0796d59c@gmail.com>
 <vx4ugjq6wol6elipmwkuhtpk3qnanpwou6g73dxrjona3nepd4@pvetkgijfsx5>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <vx4ugjq6wol6elipmwkuhtpk3qnanpwou6g73dxrjona3nepd4@pvetkgijfsx5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anuj,

On 10/19/26 14:40, Anuj Gupta wrote:
> On Sun, Oct 18, 2026 at 11:06:16PM +0100, Pavel Begunkov wrote:
>> On 10/16/26 11:34, Anuj Gupta wrote:
>>> From: Anuj Gupta <anuj20.g@samsung.com>
>>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>>> index 3aa5d2f2dfbb..6343da1f6c05 100644
>>> --- a/drivers/nvme/host/ioctl.c
>>> +++ b/drivers/nvme/host/ioctl.c
>>> @@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>>>    			status = blk_status_to_errno(err);
>>>    	}
>>>    	io_uring_cmd_set_res32(ioucmd, status, result);
>>> +	io_uring_cmd_detach_dmabuf(ioucmd);
>>
>> It's not great spilling the responsibility for [de,a]ttaching
>> between nvme and uring_cmd code. Is there a way to stash it
>> all under io_uring?
> 
> The natural place would be __io_uring_cmd_done(), but that runs from
> task_work, while the ref has to be dropped at hardware completion, like
> io_complete_rw() does.

It may queue a task work but is called from whenever. It would work
if we drop there and in __io_uring_cmd_do_in_task(), but I agree
with you that it might be confusing to the user.

> Hooking io_uring_cmd_do_in_task_lazy() would avoid changing the NVMe
> call site, but would add a non-obvious side effect to a generic
> task_work helper. How about a separate helper that drivers call from
> end_io instead? This keeps the dma-buf handling in io_uring while NVMe
> only reports that it has finished accessing the data.

Sounds the same, but I don't have a better answer, so either is
fine with me. At least with your versions we can add a warning
for misbehaving users.

-- 
Pavel Begunkov

