Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF9136E2C
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882104; cv=none; b=JKmouixzedFC4+HgBoLI9MS8nNVU64vRVdy2TZ+A6Am/oblyUXoIbiIGCTBmIRvMzORSWj42o/zwGjpCQZwYPy6ILOgdgpfRzbCu9vw7g1/PlSolgbmtoBzcGTGZziFPUhERqqkmrfCvw/emO/YhlMthYU+pUw3h5Vt6JhidcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882104; c=relaxed/simple;
	bh=9jc2wlB8Ty1q1eIdLrxU3p4Vqn70+aUVShggyt0lGCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tEsvNZhmc28uyen6UXDiC+vYNMYJENXo7eu4ftu3qwQAhQ1TLRs+Y50K7mOVpwaaxanxx/UgBd0noIbm62EZegYAzuFkgGpcwbUdrPP+ez8YgOE2mA1db+MVOiYSFCy7n396LgferVLJiCBEGBrZzagDIPMFiPwkSNP3qm4gaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VG/Xx6AW; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VG/Xx6AW"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d9a64f140dso53190939f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713882100; x=1714486900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkEm3gK8I1ltgZwxgOuOHJ3qrqHieOTRPEzhZT2FAIM=;
        b=VG/Xx6AWqQniuyQoF2BMHGVyLZ33EI4kF2nc28fquU7HWoTUqSCgmnZoaXbuxxiVRx
         wPRM4ZX9wXN+F0j7VPmK1pTzQptsrUPUSJJR7gX6FaREM2CrjzMfFfajPWfVuiL/fivE
         yD0gcuxGChe0lQp412T3EXKCI4mm4h+dui+YCpWAulvVzJ+eCgzoFycyW9VY9ld+z5b9
         fbq6jygOWTP/zqB8r0xUuPu0LqrSPefQUT5FF4BWJIknV6yZi5u6IRJ2MWd4dJ4eFZxu
         enOP6ukGfKVI3hZU3gQwJyM2Y5V6G29qGizbLtLDa2gmSHnvWsKpI1g3WBRefNNaeAen
         e/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882100; x=1714486900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkEm3gK8I1ltgZwxgOuOHJ3qrqHieOTRPEzhZT2FAIM=;
        b=rUkKya9HGze34G/P+rM3tS6lmxXCOVnlOgmD58o0dM6Yy0KSkQIgoH37zoe/bbgc+m
         hvx9A/9ZuBRNHrDEK3mheAc5yrAdcApPl4jNYSfxqbhyB4RRpdMwi9ToGjrQuU1Ai5ao
         iLMdRqRHSqVbbD48XB5D56NKfFOtT8o38rMDAbzJOnwqqskjkCmDy3JDlvGiFKq199NY
         MqMjC3bqOWNgPN/Wgf6xwe2mGtyEF9Tvvzd04TPAulpdIF1AAZkZHUvsIqzG7HVQ03sR
         bOYOmnwbRUeqRKS0u+uBXCJn3SLYimypQvgnFCsD3cKG1kR4ZN2M7+gjkPU2/u1wSu6W
         Z30A==
X-Forwarded-Encrypted: i=1; AJvYcCW6TJlo9R7KRxSELbkN96y4vrqYmpJrqG1KdCFlSja9Vudadov1DehciJLUUXhOxPYxD7EBAVCf8KNVwEMZh9x4MJBg5MbR46lmiRs=
X-Gm-Message-State: AOJu0YyhKv8U2Avrm8zt7JAxV4yT1/338BD+K4DEsqUO0BTbaqZPp5YG
	NZQTdoLqysj5uhU+J8IEk4iRt7LJDhV14sDHnaPo3qjooCAy7xNDYWAXoYUTxmqRJqGuf/ZJDe9
	x
X-Google-Smtp-Source: AGHT+IFPzMzFKqLRbNpeLKmZbMw6Dzfp+ElklLUQGjcU6l0FQafN1eM9aBnrMeb1eS1IojrZmBcxZA==
X-Received: by 2002:a05:6602:2572:b0:7dd:88df:b673 with SMTP id dj18-20020a056602257200b007dd88dfb673mr4349056iob.0.1713882099555;
        Tue, 23 Apr 2024 07:21:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05660214cf00b007d6c052809bsm3009533iow.11.2024.04.23.07.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 07:21:39 -0700 (PDT)
Message-ID: <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
Date: Tue, 23 Apr 2024 08:21:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240420075811.1276893-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 1:58 AM, Damien Le Moal wrote:
> The submission of plugged BIOs is done using a work struct executing the
> function blk_zone_wplug_bio_work(). This function gets and submits a
> plugged zone write BIO and is guaranteed to operate on a valid zone
> write plug (with a reference count higher than 0) on entry as plugged
> BIOs hold a reference on their zone write plugs. However, once a BIO is
> submitted with submit_bio_noacct_nocheck(), the BIO may complete before
> blk_zone_wplug_bio_work(), with the BIO completion trigering a release
> and freeing of the zone write plug if the BIO is the last write to a
> zone (making the zone FULL). This potentially can result in the zone
> write plug being freed while the work is still active.
> 
> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-zoned.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 3befebe6b319..685f0b9159fd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>  	struct blk_zone_wplug *zwplug =
>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
>  
> +	flush_work(&zwplug->bio_work);
> +
>  	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
>  }

This is totally backwards. First of all, if you actually had work that
needed flushing at this point, the kernel would bomb spectacularly.
Secondly, what's the point of using RCU to protect this, if you're now
needing to flush work from the RCU callback? That's a clear sign that
something is very wrong here with your references / RCU usage.. The work
item should hold a reference to it, trying to paper around it like this
is not going to work at all.

Why is the work item racing with RCU freeing?!

-- 
Jens Axboe

