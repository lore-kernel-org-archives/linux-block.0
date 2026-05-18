Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4ED377558
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095485; cv=none; b=hdXm4ezkQDg8rUzvsVkBNtBe95jjyowQiTPNLHskDzZoxSbK6s25WTy2/Y3DrtQkmdx87Gx7iuiC/NU3ZUiy1moRAfb0fDtl8Dp3jjiY5v8z1+Q78aLYL9n41CdPbuutu+fipU12zikdjhYpHiu1qvM+hEjAgw9k8PFqQCrr7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095485; c=relaxed/simple;
	bh=j5e+A246+gurA03hzDlo2iGh6kM3EeFHUQqmWGHP3pM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LB8i3FgHvgkeuZOMIkfqehZjw10M9J4oSZjFSq5D/wFWdF29xFVWHqCzIjXg/ug0Xyvnp3Mhe8h0VMRI0kQu0fNRvTq/oEHOWc6zWxjlssHMyK2drXKK5G2jMJ5mt/2CCu3qYTGR6+4x6vLhSODB5HTZ3Z0vrgiCx1xpOU8gB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFnLsH8T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFnLsH8T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so22467535e9.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095482; x=1779700282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=BFnLsH8Tg26vGHAXWv6a24uzDk/Tpsulz41kzt+ZbHVOS9jEJvDyKHFb4y/hIrGdYH
         kes4rZjsp0TtpdR+RR7r3VA10Ae36DyUop1QmyudUUJ/fRvSIWPbwnpmM8EisvWxXy6C
         9EoP+nckTPN/CMfo90C8CypEw5VBq6rcoxJpav0NxCVybJpvSqGmeFZtDWKp5l1kSrWU
         CU88bdz6bdSdqOc+Gz8iJR1ImMiAmshF1ag3ov5OTx7Qa4a8cD0z1NILcLL6hE4nIE0H
         dufH0Ef8666pMpPh+N6cMsvAjvj67rlrEpGrftKwlBIY6eOiL6RoJvIoBmpWd9Zbn3A3
         EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095482; x=1779700282;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=iQFhmWVJyuqWahkYblHE9SE+2P4PFReA94xfefska4wPwEAKgq4TgtqPExkYNfYAb7
         AczXJBDDVtJaoSQCgQ4W6UqB2YL1Znvcd5OxzQvLcSLjx/hLzT9Brkg/hKeuo/2GklyU
         THlJSdNHDUNm9Bx6KTmg1+3mn7m3/KrCUntrItklBpH6y4xm+aaNdQxDIyutGnwVxmWS
         zY+a8HrLiaZ2cyp0yWQTvxhN+n/JiLr9EP5BiQxQLKnKcE31J58gRsdywCEjOKt47FT3
         ll4uR8nXTCxOvGuhUMysZIRqIg1hwbWJiFyjQtjFg7K7XrQ57VItiijobyaPFv4M54by
         ybLg==
X-Forwarded-Encrypted: i=1; AFNElJ8Mrk3YQJ2NzAb4B8k+hDHBrJ2ugDwFQxzKK1YqYTMYKRMO7piBvaR7mxUZj5uFAwirtV1oGljotu6lyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4w6g1R5o/5SS/gaBhrlQUM1MEMRJVXAWGA9MQuWCyPPBjo7ta
	qXZAaMc/7ioLC6by+jRKMcUnoNPCLeggY5r2ubJEjfRWsnrOncPOzd+p
X-Gm-Gg: Acq92OGOHCRJx7oLggzeYgo52cBjd4yNt4mgOB4z08ZEc6gJVEB6Tn2DWFZm7pdc0TD
	RxjHr/u2gPaAUHCCHAwfJeAqPJaSXEJqosjBkUdEj/7wqhxhXkwe7jUkpKm+rDCkRsyxYO8HPUm
	pqyboF5ArhM8daec8YtRwvk95nGrgUX/vkh97POu7Zra7Pgv/+8/KOXdpxCLIniLJ1syqYkimdB
	urJKUawJGVWxROVDX5lLVLP66+3cHd3dk4pa35w3GRhn3wDJaFf4F+SdqPtMZLR1HBKTCM/6HHn
	K/G9q8oXi6OS4+72/BT3kcrRgLGFZcuJ1bKfZunWVOO2/+n8Ty5oQvKH2lGrMIHCM1lFboxIb+l
	av6hN1JaqeJlLRoLae5OEe5ZgUdpqdGpo1awt79QPW7DtZVf+WJZUSPb0Ja3xiM63cxKniL9ojQ
	UjiStyNQ16ffmktksnT2JV92sO8SRjmvnt//O60NYWXCin3fe0iWp4Dy/7/63Jy2WyknKQxh7eP
	W26voVwboD2xMd8VvmNjecZc5YsquYQj3p8ENrDA9dGu3rg3W0dcDQuzQk=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fe60e7d79mr178172895e9.8.1779095482306;
        Mon, 18 May 2026 02:11:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm80272945e9.31.2026.05.18.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:11:21 -0700 (PDT)
Message-ID: <d262dbc0-48c1-4994-917a-1f975c60b2af@gmail.com>
Date: Mon, 18 May 2026 10:11:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
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
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513083937.GD6461@lst.de>
Content-Language: en-US
In-Reply-To: <20260513083937.GD6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:39, Christoph Hellwig wrote:
>> +	union {
>> +		struct bio_vec		*bi_io_vec;
>> +		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
>> +		struct io_dmabuf_map	*dmabuf_map;
>> +	};
> 
> ... and please add the bi_ prefix we're using for all (well except for
> one oddity) fields in struct bio.

Ok, going to add

-- 
Pavel Begunkov

