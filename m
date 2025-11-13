Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866E2D5C76
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053966; cv=none; b=AgKBzkd5IBETsrYMifl5MsLsAti0JvJk0BqOdmSujQaMolvTMLgWUUS3/biSZkxIq1AikZHaAKgkokG29MDkStHd/wIMiLmp6wc2wSt4qLkIsf+7mG3MHIaBYNUVwl78VQYbg7uzkZ841RxgLZPtMO4gAFWQJQfIcjmIywFnxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053966; c=relaxed/simple;
	bh=0VC4dmzU+Ey9Ygdim/pTVXAzfR7taHPmdRqGAxfsOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FzCI921m3CWepDDFrAUEM7tuPYrg1KZ1EnqxwKiv39vMjROfk85L+w2IfEVaMcO8gtpDFnJosjhp13+LVWCYmseo+zlrjHZLfr3a3IvSgRw8tc9smDqG423IpFUEF5m2s165a7wMDrTBOLJm1n8BG9Wf0CgMDZeVWX/FuO8Emf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GVJnbLJ6; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GVJnbLJ6"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-948a50b8ea6so78088839f.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763053963; x=1763658763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=GVJnbLJ6PusS7eiRbhdFJxeW8ITF+vZSHocHDPBZsKi6NHIRKUZ1sbq40oSD5yU4ws
         41mUMR+oTGxEHTujntURJV7tWR5XYIisjokecLjtKomCIryOXF/yWU3+ux1dgFNpSch1
         DIg40kg1NPQcje5pYZNWcMwlGFT797NsHbUwLO2P7Ui1JOhl7s5MmjxkWqunIs+mqvUH
         +J0+pTGeNua0GD0C+tZ82oQkd7/RdR2vVxXtbI/M12HCXz17J3+Lg6KUwpURIeEyhKr+
         PUpczdMiqK5IKPwNuQ7O7R/cVT9MdmDB5KPVQYw2gqjRaDFtvQsnX2s6hrp5FFaOnjkw
         akIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053963; x=1763658763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=I9+T/8PpSt7Bu/80PNv+FFUwnX6UO+/hgwYJ5UsN2+VD6jkejgnzLUiZxLxHS7OOSk
         2FXnWIxcINsjSxblj1hoS+o1P++2XCd/5K0KjJp2OclgjBfsyzgnPnuHpXhZIZyhau4l
         LeLw0kZBH9q57ajGqhQUsT2SS7YDaoIunATRfmwBw+e0AgRJim+/sPKS5HKeU1ZrnU2w
         /WZHEW3VhdZLAEtpSt5ileiAhHWQ0Ziex/hoettQxzhcGssXlzjg7kk6IT8a8jQYpGtd
         yTk3g76IaNCsRjT9hXG1vjczsikAdShtvMcLAcVoY4i34LSXMmOj3ck9Q+h8MX+MkthZ
         OOSw==
X-Gm-Message-State: AOJu0Yz5ngLdDRngjGdRubi+pBbmDYp+YoGz/aKI3WAlgT0EINTybIJy
	cVl6VKvVHa6pIQmrhEuSW1SB1gCtn+cca8ZEdlkJ7b3WXoorR/bSndH98rkJDqVgzQU=
X-Gm-Gg: ASbGnctvwdI/wQLJc1lcQfuPeT5FZqIIC6oCpaov1xRVGomuVmejOeYHMeCQJtbortb
	t/e510lWXyVajbvh+T4K+GLcD28kMN14IS9KisjhuN9Vg5stazheHq81rwvliWTZquCxlF1WK8g
	KJ9CJn4k46Ibjz8+cOCUiYJxt5qqpYp2YRTFeFH0UKgOcJ9A3KWaeWgRIudxsQ8fJB1PTr0HYUC
	F4cknaoZZhzHWql9JN7T4xeynC00g64dYWSRFg07d0pxcoAk03UWvyWQBEXL0++TsAuxO6xRB2W
	r3YryHykW1deiGgx//FRBIhkvx39CX7vr5ExrpmQHxT1wZaA5Uc5wwIBEe2O5OTT10XaTJj3wGZ
	7K6tMFGw6jByztZPuR6tfVh6JlPpz9OwYtueoG5Ie8gkS4VNy/3kWxv6sdFG+NSdxagzbjnM+
X-Google-Smtp-Source: AGHT+IESfdDpCl3TykV3jnebGBOgzapv9FYkIKAhNH+gAKGVBuzPG8lrd5CjZsSJSCN84KOJrH4GFQ==
X-Received: by 2002:a05:6602:2c06:b0:948:cbd2:3b84 with SMTP id ca18e2360f4ac-948e0d87a37mr14748539f.11.1763053963524;
        Thu, 13 Nov 2025 09:12:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2ba690bsm82035439f.8.2025.11.13.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:12:42 -0800 (PST)
Message-ID: <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Date: Thu, 13 Nov 2025 10:12:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 9:39 AM, Jens Axboe wrote:
> 
> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>> Changelog:
>> v4:
>>  * Changed double "if" to be "else if".
>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>  * Removed REQ_P2PDMA flag from block layer.
>>  * Simplified map_phys conversion patch.
>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>  * Squashed patches
>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>  * Reordered patches.
>>  * Dropped patch which tried to unify unmap flow.
>>  * Set MMIO flag separately for data and integrity payloads.
>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
> [2/2] block-dma: properly take MMIO path
>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

And now dropped again - this doesn't boot on neither my big test box
with 33 nvme drives, nor even on my local test vm. Two different archs,
and very different setups. Which begs the question, how on earth was
this tested, if it doesn't boot on anything I have here?!

-- 
Jens Axboe
