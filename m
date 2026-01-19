Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7F309F1D
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836133; cv=none; b=SAcF4mrJ45rKmA/iXQXy4PkP8/HoPF8WRXWQGYlz2uIQ/50rMygZEEyeR/Xv++KeXw59Ye9pBZxD9aUN48IFSdkwtPdNEdVi9PWxjyEpTsKnU4d1uaUVAQ1cdl94AXkI+wzQaG26hnUl56NiX4Za89noEpEyb6Vq6BwYJuu2bBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836133; c=relaxed/simple;
	bh=GxOZEYGA76bJHdvdmNh9m9B9ugmbf0yOGkt+P4vLre4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NonYFjC4wTxSbBm3x9wVlbKWoNxcgdbCgg0iCCjb1Ib8sxaDF8fYYBs6omjvWkSGnp/NWkVBMBeJF0v1XwmwBGC1VBm/xmavmKROfQgGnFmhoIkyqExSY/F7Cxw3PMLyzI9j2StYivFhXZxfFCRyxr2Enj0xAoBPMQ9vQbfS1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zDO36wkM; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zDO36wkM"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7cfd57f0bf7so2707393a34.3
        for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768836130; x=1769440930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUFD55+Kt87AlwhomERgXdEYs+eGxfqziPcFxLUpDFA=;
        b=zDO36wkMLe1rUzO3vYySmO5amNIFYvy4VDP2gLXkBaynR0cZaLPBuzC0QV3vMY1KMU
         C+khSJAVBZXuw1IFAAQ/GS9cpUAo6MbeyFxHv7EZBRftDQeT1bpotCiw56OFVtpPGSdR
         Vwi49riCPkPyJsQDoG+18OKQQH5ImW/UMz4g5hkflMwEL7/du96dMh0Bwu/LIbSS3zQB
         M78gO5vJgr+10SxgW/G5DW1wIyPFK8AEFN1VAFLcIdngYVlUH0M9JVoovnqEOL5TqBQp
         Fc4fvg1lH08ThWv3ySwn5fTyTPPUx4Gk55+bcwOUHIZoxcMEQdvlEWM1uygFLZA0Si7u
         ZLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768836130; x=1769440930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUFD55+Kt87AlwhomERgXdEYs+eGxfqziPcFxLUpDFA=;
        b=FpCgc/GVrziD8Txhn2qENBBNk12q288oO9jPre/2omfsbcNFH5Dptl0pq4R0XzRw+9
         s9Y3pX7DG8WEXwgF7WTpI20uOJkjhd6rtaGPYQCppvkU5BpnFJjwAAs7nrDdYCn/bDh9
         XGJr7XzT20vPI8nx2m/MiOHVpTL88ev+uIq+rSa5YuhCOK8hhh41UDTy2Oi8ZmKOA56D
         rBwIh8Anst5pkH++aMlsf0tho86rDl6nB2xg/bPwNHIz8EipdmiEbkYcgz7u+WB+y9gw
         /YrRKLvmkYMc8zwLWzr0NV/vTG7BkmVAbS/D+ITzCLSzJG1eIhB0DaDlqCHSv26UmGrc
         mimg==
X-Gm-Message-State: AOJu0Yw4PMXs3vGmJ9LvkIAN0hMP6MqMWuMDniNAV04rbz/k05t1rjtQ
	k2xnrdPLOT/3RYrniiiRiIrd0I8JyoG7nIc2wFpobjA3f1utkx9xJU9/+IBDcxeTW1I=
X-Gm-Gg: AY/fxX6BmW6vfisFZP+k3zKnEqKqgRJevTfSI8q1LkmNRlFxxYQGVAh/mNncePKkSiT
	gAUM9+u5XS4cZIUzVDpDUXRRHTvVtmUUsupCcCS784TFUIrJ4gTnf0puYPq/xOW9W34+B5OKyr0
	FyjFeZkcmdBtgc7V1MTvjT6PMzsXsdS3cGaZ/7DX/YsXU3RfmRyytMKpFhahoit4OW2mpfE3iRC
	dqe1DtuBHuFRNTaYibzMyMZlOdPWoGp+V8VNbWJxB8z0+uHTl2INL8vgsgv1v+VXhltcD/6floV
	K4iQPrmEsYNCRctitiDBkffwFc00CaqZZSvUGm+TjJPHbg6jtEQOD07SFUi8Is0NBNTGM3paeVq
	pJcleV2su2gs/kECWK8mY2ZYUPBedT7WekX8vFj+s83VOrybHBAFR8wt7N3+95Ta+nKNPXePRI3
	Km/hbqrbhTmD1qCEhetBtUyCQphk/fWy8UTDPDXyxGflSZ1bTgZpl91mrYHIWHfpGeERB3tg==
X-Received: by 2002:a05:6830:6d23:b0:7c7:2e9d:aee1 with SMTP id 46e09a7af769-7cfdee13230mr7336893a34.19.1768836130500;
        Mon, 19 Jan 2026 07:22:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf000b80sm6856840a34.0.2026.01.19.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:22:09 -0800 (PST)
Message-ID: <6f703719-ee33-4fd9-bcbf-afb15967a494@kernel.dk>
Date: Mon, 19 Jan 2026 08:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
 <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Content-Language: en-US
In-Reply-To: <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 8:19 AM, Jens Axboe wrote:
> On 1/16/26 12:46 AM, Ming Lei wrote:
>> Hello,
>>
>> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
>>
>> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
>> context, and improves IOPS by ~10%.
>>
>>
>> V2:
>> 	- pass `struct io_comp_batch *` to ->end_io() directly via
>> 	  blk_mq_end_request_batch().
> 
> This is a much better approach indeed. Looks good to me.

Forgot to mention, Keith can you let me know if this looks good to you
too?

-- 
Jens Axboe
