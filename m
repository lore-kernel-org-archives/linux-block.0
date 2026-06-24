Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01491DF736
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304426; cv=none; b=cJRuify2ZGUt0tcy8ocdLahq41J2Y2+Ak165wzsYd5Ql383FPcI0KTk1WpNIUKN6O4oRbt3VsH5xPzN3easrShKegBI75MxqOmklDrUs8TbAHUc0bi6ReCSafT7d3T0Tp6JhCmSf6kKpYn82PAknHoXQSfyl4aHyP8GYyA7BKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304426; c=relaxed/simple;
	bh=sLtMKNNBxNPRoTT7i52CS+cA3UpL8EVU7zz6HmezOgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQvh0ijpPM0B+0OZLm4FeZAYJ7qehmbkdLlCotVlR+osSzR4702GUvgfHyXT3xEztBHDHmKovYl2ANCVfeTYILX8a4/AfV3Bg/3v7QERnDsDkPmHk3mLa9Jel7MkS/Z3/X3Rc+nATu3DdJM/83DUcEesop5fWNo4ZdrzzBdJrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vCTIeBQ8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vCTIeBQ8"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e7dfcea4dso1183314eaf.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782304423; x=1782909223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgCaZQUlPbeknSjtTTO3LBzo17VyVdrEEzXLcaDWWkM=;
        b=vCTIeBQ8VMHyy4Qr7rcvl+Y50X9SjiMg9riC03uhQfjsrmznHRFssgTDo5LOVHP5eG
         h65OlqG3++iGyJ7CWHM1qYcO/HXXDQmLUI8XXsH9XqPnvHtAFYbyscL76aRow1rvB0Qd
         ogQEKLUwsYOoahGZi6PYz09j5E3ZqeVmeASmzp9Nu0FmxETz+TZ3ZoLGLTVtr+LRr4l4
         0XERG2mx5q2TKIIOFWhxer7vtnutdyzgYCTBHn1EYEHaNxtjZwdiE5qpbyTKr+MYpAeE
         nomlmKMFHhCf44J9DSsI/8bKQyce/l4O+AImsfxTfBU4NjHLD0dk1QXoNEe5ab67Tumv
         45Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304423; x=1782909223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgCaZQUlPbeknSjtTTO3LBzo17VyVdrEEzXLcaDWWkM=;
        b=iJRy0rRau7BmW+40ay/F8KUmnb1BuvrzkSah9DZuwP16+Dw0TBErmjx4+aGeA7w/w8
         WM6Ve62mJDc6MhuzL7765gi2BK4gnJ+xyfb9/5xGm4RNgsfwXv/pPHXA7Vyfmk4qbjS6
         6ARCegibYX6k95b8Jxhap9GjEezcVAoc8aTb12TAalsuFoYnYXyxj4GSbxW1N6MiOBQD
         xeIRrsM3feasfsAsBCBKy+Beht5Rlom1uJrjRkozzKSdSTEuPrtc6zHsooX6INNoHcro
         0mUX1WCkaEwZCaNKOpCxTTgqa4kBl7ObuGOscL0jRYhks/uZqugbBr+fw0vn69sKCcDh
         L/jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pRoZotjfGiz7CF7NT9VhGJu11yHrjZRcFGEs5L4mffwW+z02WgUGfzctHkVjbkJknGOMQ0VrH6HH9Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIoblIH8b4MXtkwwHyOmXez2NmmRNLBYLjNWkt2ZFvCXRe8Tt
	LPomWb4OMBX8b9cJSy1NIsGaFnmdqbUsPnayXb/UgBGmt0WC9uEZrG3180dgn9gX9ZM=
X-Gm-Gg: AfdE7cnh/Zv6On/DIdNxDx76yEhOawreKirNDYVXz88u1ecuSp5FVYR90QX1VZlNjZU
	fY1HW3o5T9/SrUu1cEP4Px9evhapESpPBriLsJG6KyGZ7rLYu7e09fcMrM6JVapLB5Hfb1Uquvo
	RPi1cQhuEzkBIfjRZ1OTOSY4Yr+k/SnCtDk8h59Ouc/3CfUv1j449ELIn8lY7o4UT1hl3VqnJ/S
	LOBGyn+/0PsrLTVFyYuD7M9kjBDd5A7dSTGoNM5mgP3J/ZCZLyEfRfBW4EANSUil1eezgHInDhz
	fko/3oHAEr0OAAQxOEjFSnkZhv4AO1Y1VoVOJvp9IzF0vfcBz41f/VMcR7QeWdX46gD/17SS9Hc
	S5CHwoGo4uZgwGg7sFXadriB2Rw+dePm2k+ftIOqFuuQFCQSrPNs5dNvg0sSXKNHNzPsZSw1Q4x
	rJp3RvefaezA71BE+pw9eyNS3EGDUKwWC/lyh9MzhYHCXdNVmCe5WMvOxO5GzwYsPv/vKWXqw=
X-Received: by 2002:a05:6820:1c94:b0:69d:ecb9:4a2 with SMTP id 006d021491bc7-6a12d788b4dmr115278eaf.4.1782304423346;
        Wed, 24 Jun 2026 05:33:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f698ccsm8680170eaf.4.2026.06.24.05.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:33:42 -0700 (PDT)
Message-ID: <354f8038-e402-42d3-a706-6c1fac284e0d@kernel.dk>
Date: Wed, 24 Jun 2026 06:33:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.2-20260623
To: Yu Kuai <yukuai@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
 Chen Cheng <chencheng@fnnas.com>
References: <20260623090327.1097428-1-yukuai@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260623090327.1097428-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 3:03 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your block-7.2
> branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - Fix raid1 writes_pending and barrier reference leaks on write failures.
>   (Abd-Alrhman Masalkhi)
> - Fix raid10 writes_pending leak on write request failures.
>   (Abd-Alrhman Masalkhi)
> - Fix raid10 writes_pending and barrier reference leaks on discard failures.
>   (Abd-Alrhman Masalkhi)
> - Fix raid1 REQ_NOWAIT handling while waiting for behind writes.
>   (Abd-Alrhman Masalkhi)
> - Fix raid1 r1_bio leak when a REQ_NOWAIT retry would block.
>   (Abd-Alrhman Masalkhi)
> - Fix raid1 read-balance head_position data race. (Chen Cheng)
> - Fix raid5 stripe batch bm_seq wraparound comparison. (Chen Cheng)
> - Fix raid5 stripe batch state snapshot KCSAN noise. (Chen Cheng)
> - Fix raid5 R5_Overlap races while breaking stripe batches. (Chen Cheng)
> 
> Improvements:
> - Add raid5 discard IO accounting. (Yu Kuai)
> - Always convert raid5 llbitmap bits for discard. (Yu Kuai)
> 
> Cleanups:
> - Simplify raid1_write_request() error handling. (Abd-Alrhman Masalkhi)

Pulled, thanks.

-- 
Jens Axboe

