Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39E3DDDC3
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447961; cv=none; b=JFJTnjwWter/5gqJCLSSnov3fHbM9x+qgBPpLO9KxeThI96TW4OaLK1Q21PTYgvhpfEL3chA38l00y9oTADAKgLpnVobYjvu3H4BzODS4Tzkt825gtFOR/ECL6DWUU2RXQ2PscaFF1LIM4/WKtga26eWolBpNlSV8Wg3j1mQi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447961; c=relaxed/simple;
	bh=j428JPEuNQ0DbBAT8nnbgg+VpQNQcs45j9c+Wu9g6qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2eoTJdfB3om/0U7Ysau7QXtLp1I8ZWTFULU4YTM6/sdyuGpv0kl1dBrV5NEOO98yn4mPZ26eJHZAkD7sQq+vty8XCWLa6pFz7u/YPsKDqVfymEI+uD8hIbITula4yHe0uxyFdlN7da7Sj90sE122KS3XZ1rlIQhiJPnW83yl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iIDbxY1K; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iIDbxY1K"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4138136f02eso1513521fac.2
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774447958; x=1775052758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVMuoXvhb06TrpVrdMSJEIDZ7aotmkyvpEU/LhNBFyE=;
        b=iIDbxY1Kl7IA6oN/ExH6AnIoPjOMutKvP586nwM+MT5ZRFx1JqmObSBrM1Fk1kGCJF
         Wlo2J70JQapzxipUotSuEnYd/TBRwQ8dSsP0zGgeVCvBqbw2cxJK03JjKc+T8iL46uBD
         UlWOWgJNSI3vf3DiCf3/xUHymwnvsIU7CxXZVg/KgVcy1z/xXgdHHivSjs+wQae3J/Ww
         KpxzdRoIVeJk7Qtaipx/epveOpy02LdukeGhzlbCmKz06ur8wCMIs7DxOUyaTU503YXk
         RMUrZ37JgBSmAgGXhKn0vH+Zu5Dk/vr6JjJP9GEabe6/fcYm3lB61XzLWt/PWyMvzgNS
         OLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774447958; x=1775052758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVMuoXvhb06TrpVrdMSJEIDZ7aotmkyvpEU/LhNBFyE=;
        b=MlvmpC+nftWZVvhQCXRv7xOtbS+QS5wLMRjKuzoicD/le8inVJxa2i1ATPxXBzlPKp
         PYH82A/01ln9tSLQKa+0Rtbk1wnyZ5c/PE0jNeCOS3avb1CijXgWE+vjMb1hC+w8XxEt
         wnuO9J4/GHPofG096p2+TbrB1Cnq76hno9MdhmWABiU5HWNpkDzHFljxuZw3v1Jf4ovf
         1YS/seguhnQI0HvZZLIRHnT1zRyphpn+XVcxqLTQkIrBG1j+vOLaLycYhfLA8i49DJyr
         J04Ua7IaEJy/AOS9ctMp3kBGPi21/xfyElxCK7TH70zNnK1baZMGt01EBxvhBsMw3OI7
         zCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCULDZK7kSyi7XmWRCqDThyBf3SgHszJf/PJGvEFkvVQMk3yTsRbRu2HyTZe2+qDYsZnWZclNOUFkoyStg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wc4RSPrr9dLYJaamYH5lRAjJ2/RbTUKyymZ1gz9KLtVOdclw
	AkPAKPmDWshY5vrMiqeOkauQ96FSFeHIqFJ90MeFdo+KQDekAABESusm2TgKpBDU58lzkY2GAVM
	B1euP
X-Gm-Gg: ATEYQzzs8fNJAs+Cvs/+SNEmiIUUsImPj25t6lDWYbht8dv+We11poFKcqshf+rbXry
	i/8RZLbH7lP4x8KB9xBWTTfco3SbdwrNN2cbx3ki19AXL2kJw3jqjjiZWOB+5z4SFW/ptLHf4UR
	dhIZmdtrAP77Tp2VveS4Zb4Fd1hHnoVbttdjqC8GQhwg6UusTD150QELVNp1uggUDVX8BLelEnQ
	XVnU1QB81w7HVyS0bJwR1XeiE3K1lttD7Tv914gEto+V8xaffSdGA0l1uFVm3EwAgIM985CsNsR
	E1PFALpNchJ0RydCsbT5ZoBJ1/mxfKaP7sL8F0/drN5gwfZ3Si0mVkksSA/ELemDf878aURIwdk
	fW/yBx7EgbebIZw643jUyox+c4Ii9BFwtBFp0TrCFtf1cN7XjtJzZXaoLdBmuPuOGvEoKwiR6MB
	GeHc7L00X9I9kb8tLJJULc0GFOvrkg3g0G/kawSfu3ntw0gay2Ir2o1ZME/IzGoCn1TJ8fXNzZL
	8NxY9yueA==
X-Received: by 2002:a05:6871:73aa:b0:409:4a88:aa53 with SMTP id 586e51a60fabf-41ca6db3bc8mr1970151fac.13.1774447958480;
        Wed, 25 Mar 2026 07:12:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c4833257esm10473296fac.4.2026.03.25.07.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:12:37 -0700 (PDT)
Message-ID: <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
Date: Wed, 25 Mar 2026 08:12:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325134947.2799552-1-b-liu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 7:49 AM, Bin Liu wrote:
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1498840a4ea0..c254e6580afd 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>  	MMC_DRV_OP_GET_EXT_CSD,
>  };
>  
> +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
> +
>  struct mmc_queue_req {
>  	struct mmc_blk_request	brq;
>  	struct scatterlist	*sg;
> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>  	void			*drv_op_data;
>  	unsigned int		ioc_count;
>  	int			retries;
> +	u32			flags;
>  };
>  
>  struct mmc_queue {

I'm assuming retries is a pretty small number (didn't check), so if you
care about layout/space in mmc_queue_req, you could make this:

	u16 retries;
	u16 flags;

and not grow the size of it by 8 bytes with that addition.

Not a huge deal, obviously, but always good to consider things like that
to avoid wasting memory for nothing.

-- 
Jens Axboe
