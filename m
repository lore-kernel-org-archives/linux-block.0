Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8F1ADC83
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956039; cv=none; b=FAoRT3NcEDDng/SiLM6KXwZFdLzyJwPXmbcVS0xQzHjlP+xAqGlaF+7apXJDvAwgcwUKZ1I7ZMEsIKqVsR402+zgSDeKCFb0rJXvIcBGlYA6PF+CTykavza9gbF7pEQjc7hag+4CYwVOXfD8Z4BUPsFom8Ex0HI+034Iw4iWmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956039; c=relaxed/simple;
	bh=WM/yqXIneSYB6y10Ptk9a3kSgmCsWnqo3wNTzYJK7GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwlwcL8Ani5MbUsgiXRHHajn0lE0fDSedClECaqDwdUR3w7a+5GP5iM5mvB1zArHnQ1wIblIhJKmQcp03B7zd/r8F8YihnufaA0eshRNEh+CwbNNfPdZ96nu5SeTpC7Tvz86xjR3enUiJUhDtJuJsOBP4xeJGzMIQAs77zfUFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H0hVafSd; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H0hVafSd"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-434717509afso4224025ab.2
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762956034; x=1763560834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+mMfQC8uU5hH6IjadSuFEXz2DHCeAdeqj+orJRu214=;
        b=H0hVafSdXpgWKFNDYaPjaf41CNDYuS1Z4e39f3wvElTJOAfRFWeHuaE+A7THtkXSd+
         2a8Oe3SoK+8m8T/wosV//PKYiNr39s+QDOj2rKGnCNpZ0ir8TQBdMIx4Ano3YcpqeurB
         Thy2fJ6v5a8kDxewdrwxKcY179r0DhqjnBahg3Vo7TqD3IcDDfTntZrGA8CjlxpTuDtr
         kAdPUcymo8K6ucTHqG8cSDvxhL+l8AOhh0WfWCVGVmTgrGhXsG9Br5KUl9ImglqmPeKb
         uUmTRRAQW3u0R3CZ1zM1wAmWeP8ku8jSlZfBAXDMVUo6CiC3uGItncJdp+ZS8gPQFFr0
         SmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956034; x=1763560834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+mMfQC8uU5hH6IjadSuFEXz2DHCeAdeqj+orJRu214=;
        b=uQJJTZFVPrSkHL4k0gdF7ZWbEc85UEUkx2uOwA94Q102+upFY/yjvfrI78yRbQv3Nh
         FUwK3AZWw+KZtrRJfCb/HMn7aRs/BUkuT6PkzHgvU6fSIzSIm0oC588fYcUDgpPKxr+7
         WJXgjA2ULu210aMRYsdaIIzF9tgoXo6YFgY3fZKpiFguAIDpAHEZwvqXSrHGLFy/dG1r
         TS4T5ow+vpbNmq974A7o5jSNpaADQNJ9ZWhd/bMVU0tQVtPtWx6R3UFMtQS3EN7r5all
         5DLbljekW80kipXZlgBMjoN+WrzWH4PJ8WVbgj0sY5l/Zrak76qeULfoRa9STkjQ5zki
         slDQ==
X-Gm-Message-State: AOJu0Yyl8UtLCXVs5HiGqF1ErcLBVozyF6TcKG6BNYxgAv3KnUoH9UKz
	ynXDwvhw7Y9kKjBwif/fBhUMShP8YnCR4tx5dtkrCDyQurhn9oUCwyEuGtFLGBRicQY=
X-Gm-Gg: ASbGnctLudmbaXFXpPUyfpw1DDxV82JmbtSR905/oV/E9PIXtBhKA2Q5HuXyfnaUH6J
	V+ln+d+JT8XUhAt3PlENM+Ae9u62CQM8oZrrH2wLfAdcoCAdzAbUD7qouXKjW9YXnn12QCwXAtA
	dG8tvehnRneJo3jx1F6RwJv2ef+g9diVp1AgDCQac55LIdgHAvBrDmCRclHC+GT0eG74thb+FP6
	sz7KEtFRIx1tT38VblTLsXUfe4sECSH4dRPcXsmiCru+aEnobtoxHdUqJJUYXM7Uu5JRw115lVj
	VjWH4IOBTAXthQfbuhrRwWb+yieXjcFpbR8KJ1OiiRmybie20RMz2FSMR9KU7Do2TjrUY426C5b
	aGMhk0Cfur9KnMuUvp2radWYyPPTiZeL08YalLaIVAcbgHJ5VcitilxqP/WGXPSNVwVsjdehKsA
	==
X-Google-Smtp-Source: AGHT+IFxKNLgoCGLxWoTf1NRvsAdvMHFCIcKIIyw0/9zGWosV8UYX2oDx90WG9vAiLNC6kplOUyIzQ==
X-Received: by 2002:a05:6e02:1561:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-43473d19f09mr33489125ab.8.1762956033691;
        Wed, 12 Nov 2025 06:00:33 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434767dc5c7sm5669155ab.33.2025.11.12.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:00:32 -0800 (PST)
Message-ID: <499e05be-69c6-472c-a9e1-3061a583d71e@kernel.dk>
Date: Wed, 12 Nov 2025 07:00:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, kch@nvidia.com,
 dlemoal@kernel.org
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aRP6KdADdbnhwwrj@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRP6KdADdbnhwwrj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 8:08 PM, Keith Busch wrote:
> On Tue, Nov 11, 2025 at 03:22:52PM -0800, Chaitanya Kulkarni wrote:
>> This patch also provides a clear API to avoid any potential misuse of
>> blk_nr_phys_segments() for calculating the bvecs since, one bvec can
>> have more than one segments and use of blk_nr_phys_segments() can
>> lead to extra memory allocation :-
> 
> Perhaps blk_nr_phys_segments is misnamed as it represents device
> segments, not physical host memory segments. Instead of rewalking to
> calculate physical segments, maybe just introduce a new field into the
> request so that we can save both the physical and device segments to
> avoid having to repeatedly rewalk the same list. There is an ongoing
> effort to avoid such repeated work.

Is it used in the fast path? From the initial patch, I only see
loop/zloop using it, and that's certainly not enough to warrant
further bloating struct request. Just have them iterate the
darn thing, it's not a huge deal.

-- 
Jens Axboe

