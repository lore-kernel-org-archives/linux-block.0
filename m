Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0396145FE0
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502192; cv=none; b=KcfbM7CzpUaRZwYc3WZFIMFr37U7ycgL9MFoxsGHXiSBWY6CkenCFaxF27r1YQQlnank6lfzcD/qu6tNIYrMNuluftqeM2dXv82jux8umCAOzMkXjnti6MH7b5wPs4C6N9Bkj5brxjD9KYQivbyLr1vsrWCGpce9J7o8wLOCPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502192; c=relaxed/simple;
	bh=4qtnzY7yt4Fw0Nj9Wrfa/Bgnn3/2B7SDHiRFkEOSKM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aTVIN/njQ4TN3uEcTypt2u68RwIl3VpWIGvWqNbWtpkOvm3zRdjXF0Y/5u3H3Tf1SFny/pt52e5tw0nKDrPeMxW9k2ubFLcyx0bB10TAbgYpaeSutKG13CtzNmFz2fZpeVK+zZeDVOX7O3nuypVd0cFU4xi2qhWva+Ti1SHaVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UjK/tP1M; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UjK/tP1M"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46f0fa0e398so1797266b6e.1
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775502189; x=1776106989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsklDZIYYXRBb0csXpkqv7Ub2Ip/XJSylYFg6FvL3/I=;
        b=UjK/tP1MZziWRPYVWE3g9Ib/GWhq1tPJYIL6SIyrhKww9i6yKfohTLYL9WTsNIOLPC
         kTEafcswiHZQ8IZpC3VxTP8WqlPAYaXXa/SWMf5OGFWcrP/i9zc0UGsJwdTl9M+IGlC4
         iwKXdH1HuSNr87zLxXvwObjPwwQhnhNtGbdm9xtKj07+QZA5cDjXjP7IH3VJh0xoR4/X
         nN7g+0SJz2u84szhJReENk5EIFcPgeqiM1ScexlRjGcrw+vmcGRwy8Yptz5jbTdcvLwD
         ybsUSP/+KDxEYygDbf3+Thmjcvrcox9aY+FetPUWSFMoKAKTm8pvea00OEYUJIgQenF1
         8x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775502189; x=1776106989;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsklDZIYYXRBb0csXpkqv7Ub2Ip/XJSylYFg6FvL3/I=;
        b=MUAtsr5un/y4yq0Hjc9VTjFtdDCi7Zf+6Nc1kaMFgJKSCddsGXC6hbLXAAMs6ey+rD
         pCJOMCq/0oyJe4eLf9TaoumJWYA3VyZQmsfA6dPbv8bkzgP+VjCpLG+c42IpD25ny9P7
         QksWFeARb2taX0gV3RNEqQ3EHVAqK2mHCoswrLl9JAUimwmKf2ZQpcr9CHuRblrl+FT5
         /lhneEnllfCu6sOxc1hp/f5Fgwx+kRGrA/7knqdU7VM3BvPf+kh+L0WokPqKHg6yr26a
         yDRFTIolAHY+sMZ96k5Zvn+kZmHzNKHdW97l2gGLJPpq47L/IRPXOzA19KwquRu2HBz/
         6laA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2aelcLEc0dgXs1YaP0dlNlN5AFumgVTGpToiXfHjsxpzlHx/oumMlLTO/8hAMRkKS72iV6ZQiCinSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YKWRT08Xa+RZbLKZ2kwnE1hMC7bfact/Ev7YsOk6Q73N0Bhe
	8BWPfDoCYE1wadg0Ye/qbzfptT3iI6NrZbZJg6ZSMA9Fc1AdSrfRyJ5iwMPAWTxRyzk=
X-Gm-Gg: AeBDievtuF4DvSl5HQ8K1JePN0WdbxhKnl3rL3jX+cGrOpCZUvaeOt/rfxJFWZErdty
	/p1u+ZFL2sEXaCD1f8HG/M+i5TyRvKJL/GkEXVtlu9KrFma/aOvHsZ3oFbmW5p5izOsK1BJabGz
	4fXTJ9nC4lwcVZLNNsqYvMnPeKZwXWNBoCzGxKIAj/g8ZpORg5UQ8AQcjKErQY5hF9jm1MyYHcq
	oxK34cXtmqdGRheyunsCIUomyZLd7WiOVwQSeC2c/YXiyRCBG1ZTZnd3EV4Gbk+bcOiKsZtGmiL
	PZHwUqFRTXvoj6GyJQ/BVGWqw7L9b1lv2bvYb4z8BIL9XNFjIha0yaKjLf34CAFZq/ryFNU29UD
	KQ/NOJ1KQuvSL2alrbRgslHSTGJopuoiZGasR0aurjfmzApkJ+BsL0ylRk6VQHXAHrJHc9kZ+Og
	xxW3cAdrcBqc2VUXveWGfNYh8XjMVWTZvjpSeGC2rswzpGehN77qgh1Y7gs8bMXqSvSoXtmfPUD
	N8=
X-Received: by 2002:a05:6808:c238:b0:46a:7c00:5cd8 with SMTP id 5614622812f47-46ef65f1abbmr7294874b6e.22.1775502189566;
        Mon, 06 Apr 2026 12:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25acbesm14181086fac.11.2026.04.06.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:03:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Yu Kuai <yukuai@fnnas.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
In-Reply-To: <20260316070358.65225-2-ytohnuki@amazon.com>
References: <20260316070358.65225-2-ytohnuki@amazon.com>
Subject: Re: [PATCH v2] blk-wbt: remove WARN_ON_ONCE from
 wbt_init_enable_default()
Message-Id: <177550218778.118434.343351238020066783.b4-ty@b4>
Date: Mon, 06 Apr 2026 13:03:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Mon, 16 Mar 2026 07:03:59 +0000, Yuto Ohnuki wrote:
> wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
> wbt_alloc() and wbt_init(). However, both are expected failure paths:
> 
> - wbt_alloc() can return NULL under memory pressure (-ENOMEM)
> - wbt_init() can fail with -EBUSY if wbt is already registered
> 
> syzbot triggers this by injecting memory allocation failures during MTD
> partition creation via ioctl(BLKPG), causing a spurious warning.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
      commit: e9b004ff83067cdf96774b45aea4b239ace99a2f

Best regards,
-- 
Jens Axboe



