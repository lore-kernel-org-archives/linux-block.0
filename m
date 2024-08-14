Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D41C231A
	for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666948; cv=none; b=fj2Yjpm2FXX5pGy4WaQposYKGHEtYGDmM7tJGAUGGEexif0R5aTaCBUrn2b1hnp9pqxuZG7zU4w5zOUhRVsVxCCfZYhce/LL318KPSkDZPfU35b8L9gxqzrLAdWku8Kwht7pKeqummjbCztMWe+MjROI2FCSXRv7Q7AsXPuyj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666948; c=relaxed/simple;
	bh=5SRnXsvGe0ks1PPk2d6iR2E36xrdoQ/xKFVPBkEc0G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqE5ib/QhIoGii5ipG3uG7ZvWy/hBgqw1AdBFPahhHxkTnO4KAaxLPoiq7Iyj7UBx3WGY3hU98vFxT2MijY4NKxKG1YbVRdWjdPcC4a5nr6g40UMWIOOfy87IYF99wnrRugHuuYl6ILUhtrFTf0t2f2m142shzLmcY1iFdF1UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fwhs2YKg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fwhs2YKg"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so42070a12.1
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723666943; x=1724271743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qrLHDtIlgRrYjlbN2SIttaAtVkHKsw4QroqjhY2qOA=;
        b=fwhs2YKgxuOfojl6WgZszKAS5tEhCkLnpAN5NGBczmLdI4grvofulZLsuyIvozQ+7a
         +hgwttuGNTh7q9OFX3jm9yiwzEZN5Sl5bncFYFN544jc5rdKlMoVM/b2hYdPsvSffLRJ
         rThwPfX88UdOZkg6DANdhzUMNgmt2K04xi6WIXhne4UUFqHUKnblPXgys5uXcUqUwcs1
         lGFj50xjyjNBfuiRs9l5AAGudUi24qB35H3j7fNaYNLGBEGQAwLUz6U6J8GOISTOcKlE
         JXb9kByScn+BgyoNPy/T1ala5Abcs89KhPB/Uaxy1FhLxN456pm7moWEAO77HtddLah+
         ZtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666943; x=1724271743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qrLHDtIlgRrYjlbN2SIttaAtVkHKsw4QroqjhY2qOA=;
        b=BCZC4MzWZfpF/99mw50JmizD6nYyl6Ul+AY59bsjnqyxC/bzER2kLwIIv0pfPqsoor
         Hrfn6mNs0RrLuJGmYMIm20GYbbg6c7ksBB+Lu9YLXukowHKrog7zRQNONjOaKXXTkKpt
         EhoVpg4ec/nJRdklEUmNqWzRGncYoXDiFnu4T0YgDex0UDwpaKbhyqrSiVABQ0gewP9r
         cOSd+ZBjkJEPcUf34bx8sEwwPokW+gNXIHMLP6iIoa4tjdGYO8riruV9mctYuz8lwdA1
         dfKL04Qn+7x5lJxLLVv3GNkSQ2U7HehfDPf6no8mQRrXc756+MlAAag7Kejorq1cCBK5
         YUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQxaA07E9iomCZHa9t4NRjvC7V3juWlVHkxMIv2zORDXUTNLu4ehNKSoz816rAaz9UJ9LXdQCfdD4MYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuRk0ZeafP2LF27BDWSaEcBLDvjOl8PeL/ryAA5piH+WY1ExC
	pjy9Z3LHe+746EHdn2HMAwv1V/KhZJ2HrpZKMs5NuBqfsZ3vhrFeJBnvhJu5oyc=
X-Google-Smtp-Source: AGHT+IHvS4UxsLTCsRRg68/apHusWWi9hP1XGhri9rFG6yGlwDroEV/2XrWn3KKUdwV+vsDuC1Zbjg==
X-Received: by 2002:a05:6a00:9446:b0:70a:efec:6b88 with SMTP id d2e1a72fcca58-7127831d8e9mr331374b3a.3.1723666942573;
        Wed, 14 Aug 2024 13:22:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac4184sm7717850b3a.215.2024.08.14.13.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 13:22:22 -0700 (PDT)
Message-ID: <6e729890-7374-4335-ab7d-ead00775057e@kernel.dk>
Date: Wed, 14 Aug 2024 14:22:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix potential deadlock warning in
 blk_mq_mark_tag_wait
To: Bart Van Assche <bvanassche@acm.org>,
 Li Lingfeng <lilingfeng@huaweicloud.com>, hch@lst.de, jack@suse.cz,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
 <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 1:52 PM, Bart Van Assche wrote:
> On 8/14/24 4:35 AM, Li Lingfeng wrote:
>> When interrupt is turned on while a lock holding by spin_lock_irq it
>> throws a warning because of potential deadlock.
> 
> Which tool reported the warning? Please mention this in the patch
> description.
>>
>> blk_mq_mark_tag_wait
>>   spin_lock_irq(&wq->lock)
>>        --> turn off interrupt and get lockA
>>   blk_mq_get_driver_tag
>>    __blk_mq_tag_busy
>>     spin_lock_irq(&tags->lock)
>>     spin_unlock_irq(&tags->lock)
>>        --> release lockB and turn on interrupt accidentally
> 
> The above call chain does not match the code in Linus' master tree.
> Please fix this.
> 
>> Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
>> Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Please leave a blank line between the patch description and the section
> with tags.

Please just include the actual lockdep trace rather than a doctored up
one, it's a lot more descriptive. And use the real lock names rather
than turn it into hypotheticals.

-- 
Jens Axboe

