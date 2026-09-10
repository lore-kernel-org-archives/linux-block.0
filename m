Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA854390987
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073499; cv=none; b=iPcmk9L6lXVfqPkplIxSMq8KprNz+kIeqyFs0YTrLaCuOMOHYOvvq/GxJMyOMuxi2BL0RjRtmydkHR/zPQvc7D2fLlSBo214ZBqT4HLLoUM3DvJLGWyqdftFhGbgpi+1aA01XHUSv/Shdhii4WcgE7zHv1CAF4w50PI3HfvZ39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073499; c=relaxed/simple;
	bh=lQ1tC8QyyXsDWotGX0Dze7Qq9KJn6duOUqMRQ51l/t0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kFzk02VPNNb8lgURTh2rMSqy702h+McXczJr0kKCqbS4xwCXYgcxFqTqERAlDAxLyaL4+stilCkfemQajFB+m38PtsV/xvprNUE+rT7WHN2stHYYsjqMaW5E/j1Vra+TdED8zJTsYUIhl8oO3vt5PFYUJkkBw1RVwXaQR3zQad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=qyAe0Gp+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="qyAe0Gp+"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b3a61bdf22so199717b6e.3
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073494; x=1789678294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXMKHM4ByjQtPNS9X+R9gCOHk8uolkvlV5huzt/Ejg0=;
        b=qyAe0Gp+5MJD41P0biXsS+Tm0HKWVFusfBdr9lw1bFjum0QXINGToLWe3CtCYKJLzP
         mBCuIRz/76OmagJleXEv3Bv34AwPLVWb8g2XWC8qslvJ3tiUei3HkNC/2ZLl4qBipMdH
         qSjuY5eFLiqF1axrzdsuju/LUT05moIPnXAayc4h0Y+oGbqayjp10hSlr/iRIwyLWAWN
         Nl9nxWeW8LX7syvxrhW0/jOCeRrnsZA/x4bTf/mR8NJlgFsTKlF+5vKeEdBt1o46RLZI
         jk0llL/4HRqbWf0SK1oeMwc5YFrwyRUFB07A8lRQDQvmvP4V5CpDHShEiq0t27SDF4em
         MWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073494; x=1789678294;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXMKHM4ByjQtPNS9X+R9gCOHk8uolkvlV5huzt/Ejg0=;
        b=HZ3RcQ83zhrFY1pDG14TGBrQ41t2k/TWJh69a2wgxNb/dWahOjKfWOIo1L+Wzdc0S0
         xZiCBC1jugzyMqydrKUIbj6EZYfEkT15tMapArOBfq9xYUWBY7fzOLldBD5xlUA3y4Tg
         BZcIzKx+cmjVsyero3XLr1w70cszM2JVyueBQmG0u7CmReXz0DQw/dbC/mX3W7s5vjAG
         3D3crase5t7NjSH0L0B6ut1cse7nIasDcw0tY6KTxZFuclj0Otg3xlDze7MYd0ziCYXX
         K3Cjyk7QoAXaleBeeTP2MVqhhvtzs5TqJTdp3eJeWfc9OhI811xfU+CmcdO/R0oDYkpy
         81/A==
X-Forwarded-Encrypted: i=1; AKwUvBwK6+m3YAZyf1E5qfvSd0kJTPNH1jz0DGca9eGLnk26uoO4zSzT8uvCcMB0cKF+bsNH5/uX8ysWMi+5lw==@vger.kernel.org
X-Gm-Message-State: AFuF++l1kwrMe08TWsQBRiW6w9HCsqW9EJLncWBL6I/wCxKEdPbqHBp8
	bIV5LZUwKoyXrDVIrkSGP52MrP4WLPJJSorCTQxVIHhVN+TV4637eToM9OR4SGAWT58=
X-Gm-Gg: AYBFou0jkmh9mWb3/fG+fzedEd8gdHw19mpPjUvMKnCpR5GRAf4gVIkGcOgxgpL41Uu
	jw+8OQ0w+gdEF9WLpuoOtYIWXNY385QJyzauPGxMGde0Gw/Cpf9GzHoJH4n60ffSJ+yn8Mbfd6X
	KJ1B22bXSZ7xpT66IzJZCjNBYYFvXtWsixCuJFZQdv9mBmoyPI5VBaEYAEaeYlQQbhhfmsP8vw8
	7ZcLNZpL/ENAe7RI25GrU5Zo4oC4zwO62s073FNAkUGjgOgFPcCuPEdEtyBXTLrgoSLu6TrQ5XF
	jGHwx5GWsUVK6t9zDKWmU26/0y1GdzTNg147wdgY2SB2ua8YW74gne/g7eS1WSRVTZXYevi35mT
	vNy8gkCzdWl3RxaEVZPxQcAB/Vx6Q9qpRYbPvM6PhEIffw8iyyvTKVKJJ/ePEwWHELfrIX6O3LZ
	UVAG5W6GIAAxvDrkgvvLJiXwHr74ScZBPQcLrqGxg4lg9RKSRXEeneSRzgc5D9NHRz6Xe4+p2oY
	OobSth1D5nuEDWqZAuEVPYymfx4GJSpDAZVgcr0V76CTdFGzxhVmcFl
X-Received: by 2002:a05:6808:1a09:b0:4b9:a88b:8895 with SMTP id 5614622812f47-4c31cf44127mr554822b6e.43.1789073494540;
        Thu, 10 Sep 2026 13:51:34 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa69asm282875b6e.5.2026.09.10.13.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:51:33 -0700 (PDT)
Message-ID: <cff350b3-836f-4953-97f3-d664164746b4@kernel.dk>
Date: Thu, 10 Sep 2026 14:51:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lazy bounce buffering for checksummed reads v3
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260909060924.1102037-1-hch@lst.de>
 <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
Content-Language: en-US
In-Reply-To: <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 2:50 PM, Jens Axboe wrote:
> On 9/9/26 12:08 AM, Christoph Hellwig wrote:
>> NOTE/QUESTION TO SUBSYSTEM MAINTAINERS: The patches in this series are
>> split over 3 subsystems, and I'd love to hear from the maintainers
>> about their preferences for merging this.
> 
> It's a little hard to split as you have eg block patches both at the
> start and beginning... In the spirit of getting this some runtime, I'm
> going to queue it up in a separate branch,
> for-7.4/lazy-bounce-buffering for now.

On 2nd thought since this already relies on stuff in the XFS tree
apparently, you can just add my

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the block patches. Would probably make everybody's life easier.

-- 
Jens Axboe

