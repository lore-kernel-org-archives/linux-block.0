Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853C1E25EB
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537398; cv=none; b=Ez1yrHSBYRwCmNpmGzBDQkfd0CT65/+8kcH2mTL1FNA9ne/nvmuVe2ATlMfbixGuz7+k6kYErerqyGxeRx4SD8ZySFFBss06HgBUTAWw+kJfrWJ4uXckLeygugrUsY5r704j+jGuOdvQjhOI3SFn7c3Ax2TAbdm0rQYHhJJl7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537398; c=relaxed/simple;
	bh=qkDGfq7jdsgJINmY9BZhP6dw/5oTmTuI+Lk0jzj1S6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrIIcDO2Ly3OqKI3YkY8b8nXLP6BimTZepjHotxaPqbW9h4a0KWxnYFOEvLQRpMtqzqqsfhFj8aMEZrPVUfnAJ9JMWmjJPW5hdS6RHqOWgLEvvYq9QRBfmGVI3N/x6ZwyM9UuxcyCb4/WTAf+JP2iTA6wQ8BMGdSdFvQmrYFTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iIYZlews; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iIYZlews"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-435de820cd3so2791651b6e.3
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755537395; x=1756142195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTEPPjSJiDYgb1V8ZDsF67gC7A2X7xA8Pa8PVLaTeUU=;
        b=iIYZlews9mp+uVPGEQU8PL3ZFivx6/7N4+w5FgI8dYpjpunANKobvbB3mU5kXe1rBh
         SrntjIxnBTer6Q+bFoIXwy1M7cX/tUrwf4JBMUyvd+F3LGTLNTVv1h6OvUbs5e7sDLWd
         EypRMVjcN5GSUQxl202g5unSx2GtsqnklLdcMNgXaL0P/8t0I0vSeJeEHEMsXafbA/GW
         dOCROGbaIYed2KfR62yC+n+i3lT+284/YeGDAZI58FBvqrPnuIteftmyrRaT7HyFFWv2
         l/6yf1TxXRpGbOMFVJ2ADT1cJGTTAtkst+Ctl0g2+BxuP/KueS4s9/MqmuUtsNml3nWd
         3Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537395; x=1756142195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTEPPjSJiDYgb1V8ZDsF67gC7A2X7xA8Pa8PVLaTeUU=;
        b=rfwYT/HRuq0HMgeiB35bldfEP5YItyt1iYTfy6UOHLw4gGfNqUYT/nWb23yOt3U8uP
         2d1EdbQd+eE7ucerGExy1sq4OXoDXWjyUh5YSzzVnQ0HmHgIVey/PrF+yrDVgHxCWNPM
         Lh5Yx2D6OozrKuF1HdvviVWM4mbBMWFCfQ4bghLkUbX+eZi2ZHQpkvhCADIQeWPPRLmQ
         VST7ZxJMgcoCdsE5oRhRU6XVMxTJpTrazFuzkok1sq8g1alzHf48Q/G1XWLCJ5TLw1Ga
         RdO0sPBYGy0TbcqoQ2ZHKBZNGmui9BteCIf90j4eXFBCQY8SkoY05JWjTVaIyws2kvCD
         2Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCVchJWHN4OvOovdrtRpRxXDdQiVvfUbTo4bD+uYJTosKcUInq5w/q7fpY5/8ldkxmm4gY0Cln84gkzyfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4lY3bHaBWWfF3vkHV/eibztnXqZktHdqQrJJjeQS21NlMlrV
	fBMQF8/mPTaYFdAjzIPlZFxkaNDut3qvSrpfRuq/5zY0iLFhZ4h0Tl7zb+7Xje380pA=
X-Gm-Gg: ASbGncvgk7rh8RemCbHQfqHwKqr+mvEjN1JU95pHPYaVjdfMkQfpdeaeajA0DVqx+VR
	f8BAgHO/MFou099kG5LceG+ZB2xCPZX60QK2aW1SLk0WAPyTVd9hLkE81te9DDbwfE8EMYXg6w7
	u7VfpMaomk8Vz1UWMUfE7QdtOX079aNICuq8KafRxWm3YkCHEdtx0jlvRFBEpTYJHeHvcHAgMbm
	+LFmiCaYtxEGEya7CzCZ8wB33MlGTM/VwjkZkRIyYvD82jYR1B07cqTP4n8bPV/OzdGS980TEBt
	vJYLtSBLL5L6cE8/QExOH4Xt3PQ81mRpA1nG7gJrJUaiPddtw6ghUXBGh28Y7UEJ+y5lUvT4xXj
	qLX4+hBQvieH6O2j+GUHQn/wLsFLH5g==
X-Google-Smtp-Source: AGHT+IE22AJa3HuVSZU2NVyNVToB2+MSlDWaHepKvhSLirhlyStJVYKAgXlwwcs2TGh4HgmhDcWuLg==
X-Received: by 2002:a05:6808:4fe0:b0:42e:4134:da53 with SMTP id 5614622812f47-435ec414de1mr5834577b6e.12.1755537394658;
        Mon, 18 Aug 2025 10:16:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f7a37sm2704221173.78.2025.08.18.10.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:16:33 -0700 (PDT)
Message-ID: <5ab645fd-8314-4c1d-a18c-20444ade2576@kernel.dk>
Date: Mon, 18 Aug 2025 11:16:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250819
To: Yu Kuai <yukuai@kernel.org>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, zhengqixing@huawei.com
References: <20250818165959.232541-1-yukuai@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250818165959.232541-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:59 AM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your block-6.17 branch,
> this pull request contains:
> 
> - add a legacy_async_del_gendisk mode, to prevent user tools regression,
>   new user tools release will not use such mode, the old release with new
>   kernel now will have warning about deprecate behavior, and we prepare to
>   remove this legacy mode after about a year later;
> - the rename in kernel causing user tools build failure, revert the rename
>   in mdp_superblock_s;
> - fix a regression that interrupted resync can be shown as recover from
>   mdstat or sysfs;

Pulled, thanks.

-- 
Jens Axboe

