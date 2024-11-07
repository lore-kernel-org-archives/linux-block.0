Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F518FDAF
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983687; cv=none; b=BGcBVnZg26vi6I5Z77lC1c9ExJctVQrt9DVuhHRopmdh2VrHWX1irtZZCuhy0n+lh4W1zbRORiUrWcgdhg8dRDPVRvgQYfol6DVa2ppsASUnDbSXO6v6Wc3PZtXuJ2kcLbGTRw9HOiTgicxl6MrcZJGy6NqMpfZ6euFED5UyfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983687; c=relaxed/simple;
	bh=8S9Wp0rXgfqU5JLV+zvmEO4WY2V20JAjTvxoLMwcExc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8qMgSQB6rdRrhHJN4TCVU1YnmzauH1IVAAZUr2dF9VLQ9N65INUCHEDy3qWHWQJXGYZCIE/TUAPCFuxALXOsplHf6ZYhvmDAtYQnIwSvGZz1id62NkptO2WKi9eC4yXe8PSePzf5bd824jfiU8s3nBqgeXgm+GQXOPH0sVl+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FYZ+LGK+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FYZ+LGK+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20e576dbc42so10265595ad.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730983684; x=1731588484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIv42M26B+iX5ioGoXpDz+2DZqGog9g0S9f69Z7niOQ=;
        b=FYZ+LGK+8t6Z+2VDfJHZ77KJ9ivklibFO9L424fYfGEguBe4VKUiPK03zvxoYvgj05
         ziLonsiL9TX15PZlYBs8iwZk4fjjM66cYYp6hxlcuRI817vLJ8XrTN5+qouq/tBJugbK
         ffT/Cr9mKqPcJF1vupcG7BHkOFQbSh5Br3zowgMMVOO+7WZ297+cz5k17puxp7A/qenR
         ynk8Qyn8AAkEmLffCSYfQDhJFENuZQeADZqB/ccIZZbVNcnDuhSkal26rI2X3zwBAlX9
         15WkGibjSTVqgriDsG+hUsbw4BtcDc3cDOZ0Frp/zlpsz0RvKNK4pL9Z7YF/DSlcB9ou
         n57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983684; x=1731588484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIv42M26B+iX5ioGoXpDz+2DZqGog9g0S9f69Z7niOQ=;
        b=JDfEyRYG7uMsVXdMoYLKCycOJSWTyO5HBchQ2iPGdg0Z0rVKXvcv6rkqMmWKtHpDvc
         l79zlp9RVz7MEkRVj8C9cBtF/Sr4SxP0gBt+2yrNAfwy4n5T2p3w2U6FNmKgWpkVQ0tA
         D/2fmFYo6vyX0Ml9BKlC8CZvvVZavv0eawjgaI4S3zgGRTnEAiRQMTbzZe0LGWPIGZZ7
         AzZeuEJomVtzWqU1ZIDGpDokRv68skZQa0/3CYC0vxbkt+R/7nMJ3OW2JYWFAzTrW7r2
         myVDrBZyMpXlK3vVZDJM/SSUO9m4nCTNXUhQpwz4GyPpb5DS7b1m+LhDWDJYOLUOoyM0
         pVaw==
X-Forwarded-Encrypted: i=1; AJvYcCUit0FDqA9JfO0extIYSb0YKIefMwJOkP5BX8BOJSYcejcZ9/AzOh8gWx7dpPwweh60g8CUTR7l/UkvJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OUk++BmxQFYj3om9cvdELUHSyUMINsHMNvdTCCJXLsyyLM8h
	3XZGltf1CsiXD8xCU/Tk5Nmb0c+czwhWs5KeK7xY4kgPdfqUFpBUaQNCv0q+NhwkHZMeZvSZXn+
	aXk8=
X-Google-Smtp-Source: AGHT+IGlD+pTDzxoAnBiGDswUUWkRF874aGZbcz0m34zr4KhDG2O2oHfvWuIKzhKWs+kpKqjuyIoeQ==
X-Received: by 2002:a17:903:22c3:b0:20b:707c:d688 with SMTP id d9443c01a7336-2117d230791mr10505775ad.18.1730983683683;
        Thu, 07 Nov 2024 04:48:03 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde241sm11260255ad.81.2024.11.07.04.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:48:03 -0800 (PST)
Message-ID: <32d2e110-5d2a-47bd-b912-385c13599548@kernel.dk>
Date: Thu, 7 Nov 2024 05:48:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: pre-calculate max_zone_append_sectors
To: Christoph Hellwig <hch@lst.de>, Klara Modin <klarasmodin@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org
References: <20241104073955.112324-1-hch@lst.de>
 <20241104073955.112324-3-hch@lst.de> <Zyu4XuKxAoVEHKp1@kbusch-mbp>
 <16adf8b3-e7b2-40ca-881f-ecb5056c3342@gmail.com>
 <20241107053104.GB1947@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241107053104.GB1947@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 10:31 PM, Christoph Hellwig wrote:
> On Wed, Nov 06, 2024 at 10:50:01PM +0100, Klara Modin wrote:
>>> I think you need to continue clearing max_zone_append_sectors here. The
>>> initial stack limits sets max_zone_append_sectors to UINT_MAX, and
>>> blk_validate_zoned_limits() wants it to be zero.
>>>
>>
>> This appears to be the case. I hit this on a 32-bit x86 machine. Clearing 
>> max_zone_append_sectors here as well resolves the issue for me.
> 
> Yes, indeed.
> 
> Jens, can you revert this patch (only the second one), please?
> 
> Sorry for the mess.

Reverted.

-- 
Jens Axboe

