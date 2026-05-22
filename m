Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A237881A
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460037; cv=none; b=iM+eZrZPr6yORn2dr+c2FfK4kU5Q9K1LoedAwS0zE3o4zYEFulQJedlVEzYypZ9rhA4Pdh3JR/VEUUObjUgwQeewkS+Y/uYGxfEgZ88Oinr7BSAiFthX1uCc/7Q5OiIucvWzF2vu1gUg9TqnnDpSE2QxutsFf4N7s4D+0qxmbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460037; c=relaxed/simple;
	bh=+/KdWaTE6XJ5/5BpP8P+TgWyqyheMKCqLPgg79yBq/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heCz6RrUZqtIvdBkcZMdk9RVCytZkTpv3wHBQtohtL4i0LwuIeCILz8CXWwYrvkjZ8xx6UPYV8QQ7VEktAgIjU4gps8tZl7F2uJayzakiqjyImOQOq1w+EBrrJy3Ur2Gh0BNFAgeBxFqFN8++k9jOSYZH51x9fpSy07BxUsl2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=gM18PusL; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="gM18PusL"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43acf1694daso3827322fac.3
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779460033; x=1780064833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6z4yqfBCUmBzQDjTNiB0Bpg09jzE3nYmVjmXuGQEUzM=;
        b=gM18PusLFNpVK4v2TW4EdBAhLOw4Wrk1fUdWBI7AlOMGDp/S0nhHw6FR5iFS5dJLiv
         vofUvPK++h0B6gaMf4r7h8vLaz3xsGD6yqhXIZ6Tqn7G1xRip9HxvzGehLP2YyX4+UyV
         Ms7EP4ZQe/83fWHrhxwIw0fXPNCgIu8AL5RVPVCVMd/xbZ6vQK+LM75JRvLoKBhse1GO
         5MeTnaJplVNRGwTJRuJqGnvsDO7MhQvU5yC/FMIbleW3lrJe7iA5aLs+fJkAOMxTAHdO
         Io3PeljLn2zviGgO2KpK9B65VIBTCNazqNISfR6PKNW0SHSEEbcoPt2dxCxx3ifQs1/l
         jrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779460033; x=1780064833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z4yqfBCUmBzQDjTNiB0Bpg09jzE3nYmVjmXuGQEUzM=;
        b=dPYJC6EotYqqmvXNS5+S3yGBaVczcTb6CBZYIAAOU0QVSrigMlw/Z0RJvnkGkgbhi0
         pHUIFjawnAJGZzRxjojumtXTiKTMBG45Y/2UuEu3pwb8Se8lDO4q01Wm3gDqtFw8kV68
         pq5zIjyxKGzO11E38R4Fjrqw+50EIC/4YG7FaCO1dQbU394PTgVatjUpIbx2ebu9YGtN
         kZggsdWhBPQHVXIn13lyTArzRgvhfVZheT1h2Te2pyRGIBeKXfkV3orXw9NHJSZxkxse
         Oor3KzkjhMEtWSSwtvxyLIEMTsNRXkvjeOGYgTbLlze6/pwR7/i2p+bRHjLBhHoPerFV
         XEZw==
X-Forwarded-Encrypted: i=1; AFNElJ8rmfPgIvTek1cgBb+mDxAPH6UmDwaF8lLjtl0anUb/wLG20Rux2I6H2bI3Wf9uQM185woa3LiIyZXB9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6gr1fMPqHoBqrGlo6kVLoerakj+MgkUSXbTBelFF3PqEVAVg
	X7qQBQ5HZAToWScFTZmWpavNwoAgloZ7JD2Q4Ft4WxgOpJzTXAH6yG2Za5F1ZgePssU=
X-Gm-Gg: Acq92OFWQVVdi4FZojul5KqztPYLRw7mRG95nEJMlagVAiauSytPE25vaX9UY5BD0v8
	2gsc7JZLW98BeHxJM64H0fYsaKEu2EcsXv9GCQy8zybdjgtWPCJCknKvyioSuvojKzTzhJzTxvK
	vfQ5UxREgjvO6lj//aFiNxJoMoftiLeAYLkqPT7CW/dH3dMssFRrkwV2ccRz4XUNiSlXQ0GyDuL
	Pmnse6UDBUJDsJWI5SDHP+RA/c5QFQ4yRpwuaEGqtkEkVwZ1FJ1521s9EAGOVqVRgMTBUUg5KqJ
	2pHAalccYigoXuUxeBZsZ/lB1Kwl3qgcVAPOvsfm0PPvQ6xXrIm/366D+LyhtCQwceltir3n8Py
	fI3tF9wDR22VNHA08VNWL40K/jw0F4CLVIFQ5zxfpvzgFk5/shGjW8ybZD4XGC5Y3s67A0rv4Gl
	PeEIdVGqDIzMJUysnYdGbyasTqnFInFAm8GE4NA9m+9c2LfybiEn9vZwx3BbBy/V1A1vp7B7b0n
	YPbB1K8
X-Received: by 2002:a05:6870:ac07:b0:439:bd77:bc43 with SMTP id 586e51a60fabf-43b5af3d4c1mr2273053fac.33.1779460033272;
        Fri, 22 May 2026 07:27:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63a94725sm1734787fac.18.2026.05.22.07.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:27:12 -0700 (PDT)
Message-ID: <55588bd7-aca4-4890-bfb1-c77b6f091674@kernel.dk>
Date: Fri, 22 May 2026 08:27:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: propagate in_flight to whole disk on partition
 I/O
To: Keith Busch <kbusch@kernel.org>, Tang Yizhou <yizhou.tang@shopee.com>
Cc: hch@lst.de, yukuai@fnnas.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
References: <20260522141638.298530-1-yizhou.tang@shopee.com>
 <ahBnKR-IunwxVDzg@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ahBnKR-IunwxVDzg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 8:24 AM, Keith Busch wrote:
> On Fri, May 22, 2026 at 10:16:38PM +0800, Tang Yizhou wrote:
>> @@ -1073,7 +1073,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>>  	part_stat_inc(bdev, ios[sgrp]);
>>  	part_stat_add(bdev, sectors[sgrp], sectors);
>>  	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>> -	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>> +	bdev_inc_in_flight(bdev, op);
> 
> This one should be bdev_dec_in_flight().

Yes, and let's chill the repostings. Send 1 per day, we've up to v5 in a
very short amount of time. Take your time and get it right, and give
people a chance to comment and review before randomly throwing version
N+1 over the wall.

-- 
Jens Axboe

