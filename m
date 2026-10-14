Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78594387596
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983224; cv=none; b=U8RYZb+UvFbcISizZ4F9HAE+JA8hSzCYjnEJFoB/8Ob4iaWoQalqeUoqtbSnP3utHU26aOrfLE1ZU22K6edyanHxvJIMPdu5rbxymwh/iSPgLZFzIpKECW4UuZFP3SbuLKanECwKUyfBlVR3DiOW2atNAYw+lDfQ3DkOQU15w6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983224; c=relaxed/simple;
	bh=OySODPiskWWvzQQMx1Yq/HwVMV7iyUkBWw0BjUbVY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf6HwEg8TNyAi7Hc7egPff6d35w0PenDrEE2886PY5gl4OA2Tz/txaVb01NlderWb0KBy/9Xh+3WD2CaGb/IKJvSxHBDgH2Q3vizYcSLHPLSdUYtp3YaffLmgG/2/CT4rxzkOCukeP81lF8MzRvCBHfwqTECirQMGqPW+hHQDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LttP+57Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LttP+57Q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso38400915e9.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983222; x=1792588022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=LttP+57QkPAzmVVgUvRW/Pp91UXzLM8OE6jaXUaXULC9NYjzeL97NCoVyX/bypkvRk
         peQUYRfnh5Y7MVpWP9KRooCb+/mVQrAcK3pfdPbFtHqN7CieKU5nDRqxKJs4KaykY5Mp
         47FHCnhxBfn95ZlIQUM5t5uirtgnxgVmEnAsTSU8pPnjLE6qTS4hZ3q7rZwFqBphpimm
         LGq0XY1fMplM7a0KAexltkifQNpAVK1FaCAC4DdwrUBEjs104BAMvmB6DmZ+xRfXWIk2
         z3vVscEpYOosS5Z8V4hkMt6vyU+dMBCChD6MxSCniSCY6yv2aP/zXSFRlHwh6OdTiP4w
         tZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983222; x=1792588022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=dBcoFutdlHOqkAN3VLFhU48Bs5zUV2JR1MQXPsy9n4tXTvTBVEuMj2fMo0Tg/dDnyG
         W14lG7kyAms9MKUzn5nKRJWKCMAt6GFNs8nh+P50mUOQsdHYBkoEE9JsRTuHnvJc6qb1
         218yyoiPFSH2NWHHuJoKIPqP0MvFqnWeIgsxAjsl281XXFsoB4gMJ2QEg5sUs2W6igMf
         EHzdTYtFcw3a2rA9eS01eJoxPzAwGZFRjRKyaqNNBQsefGubsXCJCY2ixx1QJQg3iT4l
         ZDtxZGXtyWVuCNyDKIjNinyDCfAakQzFNTKxq0veJBg2wd+q35Z3n3kjPOFi8hexnV/H
         fZJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7m7okhtAPcKmnC6qOwhzVxvwA4IImXzGPOuAsI2oEZIOKAWl36NygNOlX7igAIedOX8/xETG5me5Akg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIWSMqQPyHtX0bZk8vv0qdUvcHGHRoo5UGfFMOyQ394uCN+Y0fw
	sMvYQXUdDipUpzH+IqvLTg0UjXTNWkkndDYbPVxYk3S2nmSsLmXF80RN
X-Gm-Gg: AYBFou1elUrw8z1X0l8BKg166434Ow3Q8ODf4iA2DFUGMksQMRyLJ2mNPv5No51dSVV
	TDc0VAdJ0LsgJH5ejkvoAyB7LEB/fwi1PIieMapE/DCK29G3TbMbAFCZmovvApRgiG59Ku3UqED
	hIXLULboMQtJFsyrcQUC0fPUbtbjj/OAQrBhtq4XV62EVfzkRl/iYMP2OUDUO6HUYUX/UV4H9kv
	E6PxNIeQM0cmZ04JcZZQjCCJpu5pPQWsuroMNFHVt5j8wY+zQKwIgeUJOXyE6fE4v+SVshluB9z
	QUbvPcVt/YK2SN2kekbxN51UGMPip268jAvhI9Y6BWOHAUFPRBSKBSFBPGYu8zuKSJ6Dv9mbdg8
	3iHexK7ynZxOcB8u692BNO84RCS70y7vG3fC9eVYIHRl7JmnrblNP4nLX7iR+9/8LpGMBpQ0FJB
	JBvivQzHzoAYZMmdgF1PCeZ/Uyn8zCz5rnwihA1/MctwpKkfnnL0zFFYgPL1K6+5umUZFrqw2V9
	xax3k9Ac9DxNe0b8re4UaXFXGzr68VCxyfNq7yuC7bzlCX84dFCunfzaCYJVeSy3fyyLCbL5Db0
	gEymysZAo6AdSdTfY8l/KFrME00/QNfbnfvmH+uf4ZvGxqMUQg==
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-4a18e446f3bmr313643615e9.2.1791983221508;
        Wed, 14 Oct 2026 06:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b3602990sm52779585e9.0.2026.10.14.06.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:07:00 -0700 (PDT)
Message-ID: <8d0e7d1e-086b-413a-87de-20e21f519daa@gmail.com>
Date: Wed, 14 Oct 2026 14:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
 <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 13:30, Christian König wrote:
> On 10/14/26 13:01, Pavel Begunkov wrote:
...>> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf_io_map *map;
>> +
>> +	dma_resv_assert_held(ctx->dmabuf->resv);
>> +
>> +	map = rcu_dereference_protected(ctx->map,
>> +				dma_resv_held(ctx->dmabuf->resv));
>> +	if (!map)
>> +		return;
>> +
>> +	rcu_assign_pointer(ctx->map, NULL);
>> +	percpu_ref_kill(&map->refs);
>> +	/* make sure the map is not visible via ctx->map */
>> +	synchronize_rcu_expedited();
>> +	wait_for_completion(&map->drained);
>> +	dma_buf_io_map_release(map);
>> +}
>> +
>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>> +			struct sg_table *sgt)
> 
> You somehow forgotten the kerneldoc I asked for here.

Ah yes, missed that function. I'll add it but perhaps in a separate
patch, if you don't mind, depending whether we queue it for 7.4.

> Apart from that still looks good, but I had only time to skim over it.
-- 
Pavel Begunkov

