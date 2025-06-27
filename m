Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2A29B232
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036197; cv=none; b=Xt9J8ZB4mOvJ8sPnLYNHP4RgfL83+UeLjNb2nlGSvAxKVyVeQr48vhzPFRoZazd+JiO8lGeupgNVyM6px9eXhx3G14TlNDQHHxsLW0sYi7EC1gDCuPo73QoAX2hslR2fZqWy1evuLE3G449owI8QSFCLIB+LjDukwjmKHfIGO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036197; c=relaxed/simple;
	bh=avzu/cRfB+U0zfnxwviee8buyXHorrc9Dgv/kzca4Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cncc42dWNDUu7EpyUuLoOQDeb+ZvDcFbYU6uF/golFun8gKDBYsL9arcx+Czck83zAjGFQfeZVLQyXaGKXIGefLlSn3l3nD/G6OrEpW0DvVzLIqVMlV/2V5Ic8kqxP9fy6UH8qypw5dd1zy5e7TKEW92vm031wpBBVCQCoTt94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nvuA0B3u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nvuA0B3u"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748ece799bdso1694746b3a.1
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751036195; x=1751640995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ClQUO/3whpnhDQ2xXD+ZbYMmVy5dR5s+G/B6dkc9Qc=;
        b=nvuA0B3uOfVqIpnGuuPf+gXhcqTXGOwD/NizHUxNE8CfV7ELt0JXObdfvhmm/1QSjC
         exvhTIzMhOBZiYRuWYhqLoGUcLX8pHm+NIVaGJTbfMhv11Ynz2LAjy9ddZ/1ZO/ofrKz
         KaXuerT+PjI4YkwM0QPlcseRLmH5pDXSUVqY5DBCyRh7OforImuP09ko/1xW0A5IEJY8
         rApvcj9YK4gjYl3Tw2HNIiuaTIAmH5AdX6sYzC7tOa3juDc9jk11GNTbvNup4xjMQiV7
         OUAyvzM0L8RBOUqcK2bU/wkukNqz9MBUBdsw053nYE5sBeaJGKgNmmBIeE7qiAqS6z4X
         cp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036195; x=1751640995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ClQUO/3whpnhDQ2xXD+ZbYMmVy5dR5s+G/B6dkc9Qc=;
        b=uQj+Xq/kj6Q+NWEG19PQlP+hlFJM49jPRd6eLiTyRPSmGbOUR/YUAieCDsyXQ/D8dr
         u0cSTcCqhiBdtwTfPcerH6y61H+0Rp5ItV0ZDliPNciRGRv5vM4hjq1HbsQEd2h6wv7E
         zaC4bxL544WEKLQISB+pB7ASDdDpBqqWxIwiPRNrJ6Eu1oza5aA4sAYmRmI9xRNPqIEo
         xNNPD6HP1Ukpp7vvhqMux8KvkjP2/qfmQ29dVgXvLbjyuspdL+g/RvMY63bWB/Yqdz8N
         RKZsvZ/jPXlOIpAGPYVAj/4QNMcWv8aygCEcT4+jhowGIkf9OV04zVE1At8+WlgQn6p9
         jBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+7NygSjj/MaaM7RbIVzY3uuvS6JVDQtwMzGmQa7euWKzyckZdwKmkj6qbLDEOqzsr1BU5zIQgEhY8YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQRLA/acR36AQPeEdW3BjixoOkquIol80+hKbg2dsI2dxp8mt
	dE+FlTcqx4jZJtFoxIckVZx7Vaj+HXtGDB3HmQB9Jga4uwRkXNwNnjKVXzkDWfnXimw=
X-Gm-Gg: ASbGncvjgJQqSJaXfGvFvWtbMeHe8fKcKx61inDPERcmm4v1VFEF5rRCIMgbVDE/Irb
	wcBa90i2YgoygN8TiRROpb0iDWQTESQZ3VZ7/uYKVuKV52pjbf2/M7ufkYPbSyjjIKo2Xo5CqKu
	+e+Yf/jJyq7mZJuID+QJUMqDpamG3bGqfrHPjl9My5INjYaLzoWbQN2VAKqG/El79ZHpNxiLQB6
	4ENUcWt0SnARvSrrhZ6EMBbdz7RC4XAzyfLvEQBzLfWtAu3+uXAMyXwH+3b5w2zT+I9veHxnM7X
	3mzQv6cCpqMhG+CXwMA5WLJ/m+qjl432MPgBuU2uY/ZZNxQz16nfrQOJQw==
X-Google-Smtp-Source: AGHT+IENYqjOMvnWJfrPfV9o3wXHwLOcA7uYdHN41zZNj32DgqZLSIlL3LVi2mMEJdiUibUomTRfbg==
X-Received: by 2002:a17:902:ce8d:b0:235:e1d6:f98b with SMTP id d9443c01a7336-23ac40f5e37mr65803145ad.22.1751036194749;
        Fri, 27 Jun 2025 07:56:34 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b9f2sm19417835ad.99.2025.06.27.07.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:56:34 -0700 (PDT)
Message-ID: <42d8df98-65c7-4a4f-b931-ea32fe357fbf@kernel.dk>
Date: Fri, 27 Jun 2025 08:56:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new DMA API conversion for nvme-pci v3
To: Daniel Gomez <da.gomez@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250625113531.522027-1-hch@lst.de>
 <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
 <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 1:37 AM, Daniel Gomez wrote:
> On 25/06/2025 18.38, Jens Axboe wrote:
>>
>> On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
>>> this series converts the nvme-pci driver to the new IOVA-based DMA API
>>> for the data path.
>>>
>>> Chances since v2:
>>>  - fix handling of sgl_threshold=0
>>>
>>> Chances since v1:
>>>  - minor cleanups to the block dma mapping helpers
>>>  - fix the metadata SGL supported check for bisectability
>>>  - fix SGL threshold check
>>>  - fix/simplify metadata SGL force checks
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/8] block: don't merge different kinds of P2P transfers in a single bio
>>       commit: 226d6099402d8de166af60b2794fc198360d98fb
>> [2/8] block: add scatterlist-less DMA mapping helpers
>>       commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
>> [3/8] nvme-pci: refactor nvme_pci_use_sgls
>>       commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
>> [4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
>>       commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
>> [5/8] nvme-pci: remove superfluous arguments
>>       commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
>> [6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
>>       commit: 235118de382d6545d3822ead0571a05e017ed8f1
>> [7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
>>       commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
>> [8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
>>       commit: 0c34198a16a88878aba455bebe157037c9ab52c5
>>
>> Best regards,
> 
> Do you still accept new tags/trailers?

Even if they don't always end up in the git tree, please do provide
them. This thread is linked from there anyway, so it still provides
value.

-- 
Jens Axboe
