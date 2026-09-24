Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com [74.125.225.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A6481255
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256052; cv=none; b=QqNy6GZf3zcbQ7xDwItXy9oa/JjmF2rv5Hp7XnUis6bWtyXdkig69K7v+ORBXX0ZAYC6IjMSaKNcM3Dg4NeT7TnbUw3dO8Cv4awdSRKlG5tgNsTdljUwKuCivPdvAprz5qRddYKrGscFYBeuJXP0yvSmQ9c0ZGMBiKohKWq3oT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256052; c=relaxed/simple;
	bh=EnvthftjhvU8ihf6MuZ2HVlJqWyKvLQbdgWDQpD+FZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiyP0a5GCjMIcwaMBRrn4NyzaKR5WsTlhMtKAqcuk94VmwhZ0rCyc0vxcSCXAq1tmb+QLHLVRVuRAgH/HMkyRFeYRW0c7fTDZE4hZzzxNKcFRKS0Emu6yY9tgn6PEoSG+Ghm2xTeoXKcsWUhPhCoH9spmOwQCLiSptpVoK8/f9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=0SaMmP3B; arc=none smtp.client-ip=74.125.225.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="0SaMmP3B"
Received: by mail-wr2-f39.google.com with SMTP id ffacd0b85a97d-482f633ece3so1635516f8f.3
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790256046; x=1790860846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3ndpV76gcHySuhNV3ES4GgzpJyufvPVRLRBa1QmBk4=;
        b=0SaMmP3BywW+Q5Jb2EekN3/OhS1Vh/eQz2epGY/udxmNw/hbTBnMJUPMUfbCkajwUJ
         i6itq5AHC8A2EnY2f3nWvSLV9DSRn/yx6IB+2sbDSYXG+20GT/VJUjnYC7SaeKgs4ulY
         Jem25oiH3W1uSYxxspE7tX/ZC73tvMyLB2Gn0d63EnSLeKk6BWnHDAV0LbTXyrFExHSJ
         m2TQFAoHQtQJVSy+8oGvvisXLmwAoadL6JS5L0425DEdI6G8upiXJNetZBrOcqkK6TOH
         rjb7QJB4FbqRa0y4odrvgHdUFIcoWROgZLjpMgRwcn1hotCgzde7CjUbQnLIm78/0WSx
         ZmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256046; x=1790860846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3ndpV76gcHySuhNV3ES4GgzpJyufvPVRLRBa1QmBk4=;
        b=FC4Nx+6VXNYekWnK3xgxFY7Tqk8ulZo2bXn4gQN+mEKsHi8lZp/FfCVHXA+QB2YEVH
         qb65FMPy1VJniP//QHzQO9crkMPAsgE7LZFgCqsD4vAVEO/DqbxcYspP7V8F16CP8uMo
         v7lxnXrBLlYzDsw4b5jxXk5CYYmlsnti/fSQ8BOg0rSlJ0B4RFq6O/YG0D2/5sbg2TEa
         kwos9/qNU1kEdUGWHigIOIphJEbpud70TFiyS6RGmnI2vQrAYoAha4A82Ow7Gy7MgICZ
         fdpmwglrxctOfM48Or1hP1z6HIDY70v7ezdwjSNQwD1YqyUV5br88HE+XSo7rXBQg53W
         5mqA==
X-Forwarded-Encrypted: i=1; AKwUvBysq4HHiayqo1qLJXfUrkcHwBHrLAhXD6CED4uUYQ5RN4mPznodBtx6O7CxIdZZSMT+NQgWQSdtNBWXuA==@vger.kernel.org
X-Gm-Message-State: AFuF++nZfo5tsEzr7/NOOAFmLOckIeXXmpuAwMf9jEdHtuBvIUTph8ma
	z8n7Pv52c1tV7pm4MRsaqgFjH4rS3dyMSoCHcMRq2g4gpqr0zPFwQvCfhFv2GkvW/Q8=
X-Gm-Gg: AYBFou1MGor2nMxoOzHvk4vCVKDn668AK4hMJia+emSkKDo8XQIVWxE5lMTWh/5RMFQ
	r/vWvikrGp97WvQ2DBytQHm471Gotpvh52ojVvInI5ugxFi692NS6B461ihxwyGEwLK1fe69NfI
	EXvMqXQ5dXxYSJhc/d5OWP/An6U+jh+4YMQJL4cc7IvQCeo8B1rWuwdibkVieCmYm63a2Pg6TfC
	BW46SC9qIoGmzNDtXxZfWaC7/Un7MmdBqpK29XLE6l6Vi42L9rba8mS7jDNS7MXd2LJQzrT9iXw
	hfLIgS9nuAmVsu1ZbWMQkXdJkTA83d0nh6Olv2iyus7y/OJMxv4WrAmssGzN7bMprZBdBosnILt
	6mWbCaDRN1yTnSoa8+JXgf1OdEgcpm1dnHb/LYEXJgKLAfPjGHAPsZfShr4Nvy4Q2hXBXZqoo0Z
	FGEvXHwfK0pk2EsPZuok+o3PnPX+FvUaa/02D7S6mNFpaviGAUqGnrjluxnJR/VOPb27dyTkVC7
	Jjvs6knfkrSbqoQvZpjzuuOvuXqZPAP8cAyrcX9Qb7VYERMCbGlk3Tf
X-Received: by 2002:a05:6000:2083:b0:488:5c28:94d0 with SMTP id ffacd0b85a97d-4887172596fmr3965034f8f.19.1790256046354;
        Thu, 24 Sep 2026 06:20:46 -0700 (PDT)
Received: from [10.190.130.145] (046125162068.public.t-mobile.at. [46.125.162.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2d5sm14280483f8f.27.2026.09.24.06.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:20:45 -0700 (PDT)
Message-ID: <d6dc53d4-e2b2-4012-9ef9-6c7c15b51c15@linbit.com>
Date: Thu, 24 Sep 2026 15:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linux.dev
References: <20260519203057.1340528-1-arnd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260519203057.1340528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 22:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the rework, two files have a copy of drbd_nl_mcgrps[], but one
> of them has no references:
> 
> drivers/block/drbd/drbd_nl_gen.c:641:42: error: 'drbd_nl_mcgrps' defined but not used [-Werror=unused-const-variable=]
>    641 | static const struct genl_multicast_group drbd_nl_mcgrps[] = {
>        |                                          ^~~~~~~~~~~~~~
> 
> At the default warning level, -Wunused-const-variables is turned off,
> so this has gone unnoticed.
> 
> Remove the extra variable.
> 
> Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/block/drbd/drbd_nl_gen.c | 4 ----
>   1 file changed, 4 deletions(-)
@Jens ping, seems like this was never applied? I think it should also 
apply to the current tree.

Thanks,
Christoph
