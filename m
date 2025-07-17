Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40496136358
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753591; cv=none; b=iubqnnt1m9THDSp94mtjPPjWkDeTwcnnI33XqxFnBstg6aimhTlY7sdA32h+i2ePAjxB3/5MH55j7/Mz9SGDK8kR/DYjdV7FvME1ClmutjqfrKxo3N/FDgyhOgPQuDH35v0IXKdjC3zM8dKfIycNALGSARB236YmDB1L0HCqdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753591; c=relaxed/simple;
	bh=Nw7F+ct6VmUl0x1x7i1qmpkQtPUFSpzTbdQy9bPN0RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fttQ4jBWF8ZrCPWNgXYMtq9LIFR0uzZSx3y/OmvmFRqV8ty9U07t5jkIkonndjvQXa8jgCgc63goCFGIxR5nkYb6aeAxdE9f5Z+gfP9hMs1Tzt59eIGU0JhL19ofIjQ3gsXIQSTS5aEHIROZITUIqrmvBnEHLlQatwRU5Edu59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VIWbHXLJ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VIWbHXLJ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e281f82060so8468575ab.2
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752753586; x=1753358386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRDhOPTJcT4Z/nkAWxhX0sqDgjg+qtu1GO/I4bxt9MM=;
        b=VIWbHXLJfcK0oTDEqCV7ReE/T0QnMLzTdygcJlyX6Kj2E+i05W7CPC5tkzhpje4MJu
         8UVILFihl7OR/ir3httptH99CGkGrdlOjTLWKeVJ8f4gaHomevO1d4KX7EzMUoLdGGuL
         F6GroxH0qtWbdcLmdVPOn6JJOY1n05NO+H3APmPGYb1LCSb/L+PPlwN99Mstxs2lB9VJ
         +d/p2A0IIeObQmLUSMiWT4mDIann2wucCCFXxFiIhv7JPrprvt0UGFYp81sJWBXLJyGt
         FP+gC/78vzgaqPeQtgCv2/3LorEMzRO8CBtsTjvLGAASLim/JPbII+3S/qcE4UlZQYC6
         EtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753586; x=1753358386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRDhOPTJcT4Z/nkAWxhX0sqDgjg+qtu1GO/I4bxt9MM=;
        b=C8TsBeoSgPud0vkg2cB/WNzY39jYK29Vqc2G5dC5cECArmiqxyBHnljy+FxLhwl8Ii
         itkCtLxYvSJxQO9gP1Q4xR+GQWkj9dTUFcaucqNfp0E3s33dsRVMeiXrwK11wpF8YckI
         fkQ9Kv/RQRlw/P4nMvt02USVkPa22ILhoVK/fLCUp7J+W5XzlVGOlCMh1Is58lQ56OX2
         CBm+65Up+evF4d1/283gjrj2/H0HKe1x2jfkCblyVVSB1GrYPpoehTidutFJNf6OsAJo
         bDdiW/IAHOAiHoYxQnjJ5dE/iULw99Ic+7SVWnCTk9JH8yb15lZgLCxSkzY9UbDOdPeL
         dImw==
X-Gm-Message-State: AOJu0YzHFt49+JrknGeto+ttnEw5fyqs1pWSfuYf3SIQ1uuft0MFxGAn
	+UdTsbQ3CZsifApQqBCi2zQsRDhC0dwG2+QrcCofhXsTyRLRq4Vf5VkATQEqD3DffKDigfOPrGp
	wNQrD
X-Gm-Gg: ASbGncvxmTC+ph5+fsZe7lEpFkUavl08s1sFl1zpJXnsL/YTghJPGchRB6qZBlEGZjY
	sCNceS4VwfXrB4DTwu1wwWZSGB0RCHiz//9DDlIVoxfbAOogPhzxEMiheVusbYHvvNrnSPPTB1s
	sqtMWU3uLLcZz911bCcfls8fPo3dTmfEB/ToDlFjUC1Bn8r2XenhjELR1ymegwlnG2zOVUtkGdH
	LvO5UCRutwEzWdmNG+ufZU3DNAQGXLWnV4LkS2kAtl6nmCdHAug6RqPsl6rsrGMsqmafqODkgQI
	Vcz3tih4lkKsWr6CzUhxoDPa6eBf4GP0/GNp+NwaiO0BFj+FZEI/QWN8zHhpTLWuuW6dSU6oX/S
	UI/tHiqSpEXhBzH0GBHM=
X-Google-Smtp-Source: AGHT+IF0aIFjZk0/SWFFLxGkKw8ydUTb+TGIScYtv8p0Ovs5rLUmiuvF34/q8UiLuJa1W5/ASv+UgQ==
X-Received: by 2002:a05:6e02:19c7:b0:3dd:d321:79ab with SMTP id e9e14a558f8ab-3e282485737mr78029765ab.18.1752753586120;
        Thu, 17 Jul 2025 04:59:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc669sm3357918173.100.2025.07.17.04.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:59:44 -0700 (PDT)
Message-ID: <892197f4-452f-4c76-9621-5ef860c48a25@kernel.dk>
Date: Thu, 17 Jul 2025 05:59:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aHjgWKyuasbJrqg6@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aHjgWKyuasbJrqg6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 5:36 AM, Christoph Hellwig wrote:
> The following changes since commit 3051247e4faa32a3d90c762a243c2c62dde310db:
> 
>   block: fix kobject leak in blk_unregister_queue (2025-07-11 20:39:23 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-17
> 
> for you to fetch changes up to 0523c6cc87e558c50ff4489c87c54c55068b1169:
> 
>   nvmet-tcp: fix callback lock for TLS handshake (2025-07-15 09:49:13 +0200)
> 
> ----------------------------------------------------------------
> nvme-fix for Linux 6.16
> 
>  - revert the cross-controller atomic write size validation that caused
>    regressions (Christoph Hellwig)
>  - fix endianness of command word prints in nvme_log_err_passthru()
>    (John Garry)
>  - fix callback lock for TLS handshake (Maurizio Lombardi)
>  - fix misaccounting of nvme-mpath inflight I/O (Yu Kuai)
>  - fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()
>    (Zheng Qixing)

Pulled, thanks.

-- 
Jens Axboe

