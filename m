Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF43DFC6C
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448614; cv=none; b=skdVw0Uq/4jzz5x52+cQr9QldxVJpLNlSc7wm4pG+9xMDmo7UeQi4nmVT4cAR66oinVsqsXnhsCfWQphZD421WmYBubkOAc7s3buB0hN7nihywoih4f2UtA+sKQb5MkTdoLAfHnY4XJ5fFeJYgly0PD6mLnwPRqmiq5bRWFJXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448614; c=relaxed/simple;
	bh=6k/3DRfSULXerh+4WzXd+PR/y1S6YeoK6HC9RW8MWJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSV7227g4gSZJ1IlZPOx1BElO6ZF5ycaveif3iOIWqIBuXDbUVhhspUOrzyfUQp2tKXaeAkRl0wxIw6FOYIioFAetR1fajlqWphBaRniC5eLdrlfvPQS9nL+kzVLUcPt9/kziohBbeLjLsRhCDnvwHP5O4fIH7bC37Ma/UOnwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gFulcITP; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gFulcITP"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-41c4d660b19so1100344fac.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774448611; x=1775053411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4l8y9iNEk5A2ZRpO0P1tlpUCebqepZBhl1n1HuoxaE=;
        b=gFulcITPR6lRlf+TdVA/50cHNevE2SkpymVoDvPHSy7uwvN3z3XQPrV0xw74yGu/U+
         uFU/MXuYhjPNXS9MjRRACDSp29F0tX0+Qnhxzr7KFTfPx7CMnwHWxNQfTA+fVFb5Fi5L
         hu317HqwT5UW3YrDo2GBGuKQNbLLhJPmQwoJ8FEXZraryRYOmcWp0lSeCbWx7a7uL9eq
         ovyt1HRW1mUbZUOwwor9rISe8Gvq7FcQZsatZ8ohtBRr8OYhEnUk88uL24CO04EaTgqW
         az+HyRyq7Kgm1HC54q16zPCb5Wf5E4POG406q0Yt8IG69xOJTlgikIvoHpPlL1N91jF/
         i6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774448611; x=1775053411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4l8y9iNEk5A2ZRpO0P1tlpUCebqepZBhl1n1HuoxaE=;
        b=onvCCbrc0raMmUXv2tvOV0ar8S/MHcx+HGEjOmVjsqv8v6rKLn39ao3KEfnfwYLJ4e
         n9Ho/Z6BddyGz1HLArsCtWeIehkETaqDNN4PMTmHD7fEwzZVfF+J2KjHiDuKckUZuDRo
         WcTn/LMVD5sauMf0Y3Q1bPEbo6exN1PU9XrT/MDfAveOWCAV7CJudklMHc2Ir37CDZCr
         a4dRTsVVT6kr3gZXdzuWWfvrZ7VBhahgS7waAlNWuUj+sfgC0/TQ7iyyJsovU6PDR+3H
         vp4+up9u4u4Bldd93NFJhBxdQ8Xh8QV/yixAkTpHTx7oJZj28qFC5czucyKa04NZVpvV
         J34Q==
X-Gm-Message-State: AOJu0YzxJGGIQM/tYGpKOhzl32micbinK3xv0FCa+vuMlbVi0EtdHGKX
	jAsPF89Zc5c4/S2dGjcufM/+QEPhpgr3F7ojm3GXEZQjssmGOa/yQwd3dtIS4qtjTu0=
X-Gm-Gg: ATEYQzxvbvDCohwABT2VU5r1L4qrv4gAVveHYcyN7iSX3skBTWhifUKXy337Jcw8/Gp
	4VfmzIENI/gMpXvx9Ci/d7e9i7w4IEYyI4zLSarOXLQIoIYxtYXZBh6RP1UODGwADlSagGX4Geq
	bFCp3JnuovTfc6Sh62B3b6yDnLENo0Ak8q+IIknC/CkcgZsrHJJ06EeU226cCGy3IwsNPSlQTvi
	OlDMWbLCrSkdgkR/JSmbsnZdb2nMqGrFWlqLC2T6mOBmCibn8TL6BZReOKqPqBtVtPsT8jyOSRr
	eA4NWuUnRbyvWpsQWmv2iYAj2b7cc4wEz97m0qAFIP7oP0KJghTnDsEG04A4qKwgadA99Rtk+Yb
	6CAF41D7vydGiUrxWgq+JCTIPpuvWsuTtc6MWbiwvr6acPQo69Vn0v5Hxc4kJM4bngtZIBK5mI0
	S2zqPIIYzmlTXP04rR3rpB72Tx/wT865kJnidt1utuCx04rffyJpT2RU6uu/LIV0MeqAJfUMO4I
	hDd90VGi4IjUc0MResp
X-Received: by 2002:a05:6870:3261:b0:41c:305b:14e1 with SMTP id 586e51a60fabf-41ca6fe29f4mr2170091fac.28.1774448610748;
        Wed, 25 Mar 2026 07:23:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm16862796fac.15.2026.03.25.07.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:23:30 -0700 (PDT)
Message-ID: <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk>
Date: Wed, 25 Mar 2026 08:23:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
 <20260325142106.j2uiurbkgac6xw52@iaqt7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325142106.j2uiurbkgac6xw52@iaqt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 8:21 AM, Bin Liu wrote:
> On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
>> On 3/25/26 7:49 AM, Bin Liu wrote:
>>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
>>> index 1498840a4ea0..c254e6580afd 100644
>>> --- a/drivers/mmc/core/queue.h
>>> +++ b/drivers/mmc/core/queue.h
>>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>>>  	MMC_DRV_OP_GET_EXT_CSD,
>>>  };
>>>  
>>> +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
>>> +
>>>  struct mmc_queue_req {
>>>  	struct mmc_blk_request	brq;
>>>  	struct scatterlist	*sg;
>>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>>>  	void			*drv_op_data;
>>>  	unsigned int		ioc_count;
>>>  	int			retries;
>>> +	u32			flags;
>>>  };
>>>  
>>>  struct mmc_queue {
>>
>> I'm assuming retries is a pretty small number (didn't check), so if you
>> care about layout/space in mmc_queue_req, you could make this:
>>
>> 	u16 retries;
>> 	u16 flags;
> 
> I quickly went throught block.c, it appears retries would be only a
> single digit number. I will update the patch to use u16.

Note that this is just my suggestion, it's down to Ulf. But what I would
do is a prep patch that makes retries u16 and ensures that's sane, then
do your flags patch on top of that. I think that's better than making
that unrelated size change for retries in your patch that isn't related
to that at all. It just sets you up to not grow the struct after your
change.

-- 
Jens Axboe
