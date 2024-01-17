Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59728DA0
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532726; cv=none; b=brafeGnC0JEB9TUjeXdnbtn7Lz86jK0nW2y54UcYmBjklNx887GIcGbZX157SZyoj+7FVZReRzpBBqm+eijeRmK0bchkzA2zOAes7ZWAQrf2Ade/+b2p/xorPEs8cDTXrQq5S3lx/3/CvhjNDGFV8pju2nP1I0LEs7tt4sgf8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532726; c=relaxed/simple;
	bh=kvRMcs2AJiiR5G0vH3bSAe9+o9cJGPIsxUiD+6tp9po=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=MH5u3EdTFtSOartcZy21ZcmxfJPAwrwqaDUFjlCSX/Sjx/QYBtFf2CAgxGh/fmTks0gbpFD6XexnCy3R5m38SSSTB/YTIgYdVb4ZrdTLDD7IFf0B6oue4a+R/3MT6pvih/zh2e1rQiXFwo43ilMzk3t18c88UEJrPVaaz0RBZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=inIwrTMr; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="inIwrTMr"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so111261539f.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705532724; x=1706137524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZimxNNYUhQiGc9CSi8XOIRdijUq2WzHdtfDAUowK1o=;
        b=inIwrTMrllL8TPNROGPZwgFajAwytZTfbx8BOWkcTeocaum8CuBzu62uaVYU3xfMbj
         vNtyxVF2cPMB0e1bPD5IBhX2skJttV629bOG61ik9eOsqriHdegtSd1pKNloPo2Yv8Ge
         /e2lyR0vLwmMovy/S9H4SpeCiG5zCewR5A23EtPaXIDmCuoK9ihItdlw9xleK9NV2Qoe
         RSkTPpMCEdbmYjsYRcqJAGGT3Z9mBQ41PmfXhbua97KOxbRJXrEsi0OG3YJsUB6pe20D
         qajkMAxB+Nw8w4PbhdVYdVyXbpFuhWKABzsh8dW8YbU06uRrie3+eaZttThWAK4QaYJ4
         p0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532724; x=1706137524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZimxNNYUhQiGc9CSi8XOIRdijUq2WzHdtfDAUowK1o=;
        b=StLzXQ2hyB8aw0aqC8jDyUAzJvTjIVrhsyTOyXjzFkO5dABAlbnLKl+wxoDL6kjfUn
         nxAH7Rx/uL2T/FGapEz5JexKIv0gqQ30No42dU+LlC2HfEBXCHtw+RbPxG5ntCV0ONdA
         mv4hNbKkrNIJOwWp9Axgd3spFzzTHqavmFkNF+7kgKBTBxdfgDvlxW55OgASMiQMTOWF
         lnS0PbSQRZV5oOgbCnkveAfrRTgTtx7SoU6ivwajiWvvSoQUx2vjQ6qhnx5sw2/7aUw4
         +j3e7OF475CpKHjNyYMSLXXRxjHED0ID/CaoDTyeduN9hw/TXa81gwhA3S0iziqWobWv
         8e0g==
X-Gm-Message-State: AOJu0YzVm2OnJkFMzvBz2YhBe7zcJE0srRPa3n1EYTtO6lbMy4sLKmJw
	EuM/L0IjmFz9051IhNfvAYBNhKSusDR4D8xTqan0WSQ6JDsVINmnAgtIYGJlr9w=
X-Google-Smtp-Source: AGHT+IFfcanp4yy9KLRbZV8wShUBiBUjvwVbwxbFFZ0iAIyyuRY5gaT5NA4w3qGsCB10QXT+7StGhA==
X-Received: by 2002:a5d:97d7:0:b0:7bf:356b:7a96 with SMTP id k23-20020a5d97d7000000b007bf356b7a96mr77714ios.2.1705532723830;
        Wed, 17 Jan 2024 15:05:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a056638258b00b0046dda6b83c1sm670895jat.25.2024.01.17.15.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:05:23 -0800 (PST)
Message-ID: <9677a5bc-b867-4350-9848-6a726dc9d573@kernel.dk>
Date: Wed, 17 Jan 2024 16:05:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
 <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
 <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 6:46 AM, Yu Kuai wrote:
> Hi,
> 
> ? 2024/01/16 21:23, Yu Kuai ??:
>> Hi, Christoph
>>
>> ? 2024/01/16 18:47, Christoph Hellwig ??:
>>> Hi Allison,
>>>
>>> please try this minimal fix.  I need to double check if we historically
>>> returned ENXIO or EINVAL for adding / resizing partitions, which would
>>> make things more complicated.  Or maybe you already have data for that
>>> at hand?
>>>
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index 9c73a763ef8838..f2028e39767821 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>>       sector_t start, length;
>>>       if (disk->flags & GENHD_FL_NO_PART)
>>> -        return -EINVAL;
>>> +        return -ENXIO;
>>
>> I think this might not be a proper fix, the reason if that before this
>> condition is added, -ENXIO is returned from bdev_del_partition(). And
>> there are also some other error number like -EACCES,-EFAULT following,
>> so this change will still make changes for user in other cases.
> 
> Please ignore the patch from last email. Sorry for the noise...
> bdev_resize_partition() will also return -ENXIO if partition does't
> exist. So the right patch should be following:

Can you send this out as a proper patch?

-- 
Jens Axboe

