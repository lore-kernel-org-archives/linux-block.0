Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2808212D2D
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018919; cv=none; b=pux6gk/mi1vVqj4c02x399R1RSFlzpmz90uznhU6pPHxcYUH2IC8cWWC1mF4WSRPDKsDVjxoTrYQHHUP0IIdez8ODqvExn8B6xThLtd8WVKAh0uP6yWvlfwgeFbyIRxlt7aqnQKg2pJuWgk4hHg5lTIc46eZnNwJTk6LASHmhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018919; c=relaxed/simple;
	bh=N58G+7PoMtdGK55O+huUvX9TsumHn5fE2Vu64Zfuhew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5ZusW1MN9J+NwKsEuTwVgMvRZ1ooDKsuwSqp1yd3d4GOBY9QOHR3rjX331Br6HFdmr6u8KNb9br/YxKGh4VYnlvQanBCw0yomyGN2MPQYRm7M+zeDl+1rHXcvVE/UAd0TG2Iv55eAqt977KzrgXR97LNGJw/oQHLdSuZygCcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jxGRWxAO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jxGRWxAO"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7180e07185bso740265a34.3
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018916; x=1731623716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bm7ibeqstmEcA5eOTi0gF/ZvnGd+OvKq5Op4/quU6Xc=;
        b=jxGRWxAOZysvjCVIytXYSnLXc0EQDsWpTSjdCfhSM9Ob9m6UM5r+wr652UjHSJB2BT
         OEj/z4RGOedhv9y6v5Gu6vx68YqQCFe+D7QecGVutRQnpnMypOVFsVeClzQ4n+CtSbGa
         eilG9qbgGG5CDwZdD4HmLGzfuPd/6UXmKJo/PRkSufaoqLM4ykp56MEEhBLRTHAFycYR
         xveBSEslNTAq2crXE9r+jHm9zuGr/nnwbZDO0nfKspzF+wKLi52RiS9ZDkt/Uvr4McBO
         ibeOfWQAuWeJNCQmHA1xzqgSZ96MRFfNs0bPtIoDWVBeREfoENYTi3o1hC3mxJ7go709
         dgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018916; x=1731623716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bm7ibeqstmEcA5eOTi0gF/ZvnGd+OvKq5Op4/quU6Xc=;
        b=SIJ8j7taZLivq4lXW9lWTDmZASUZrgkvOwPvBMhGZ2DD7GYXSJmb47RLBasTAK/hg9
         dShvf/b48wQSstfJWNXVkucXgzbKvEM0wFKng0ayV7p9kmUXpUf0bZ0387b/6ln2RTzX
         AUoh5P//duuHNbGi9Gn5tuJjQ8eGD6ZI9eSV1TQn5a7hYvY3ye1kG0VU7DPgA06P1PPX
         IfMRO1iUnHqOohPLvBzJktzN6UR8F6Xcyj1MF5bgnr0dr1bFQgfu/i2kcB5UNLl+2pV7
         uQJ0ikG0inw0280QTfpLFDKldZdTTNNqtvs+6+FtQKQF9dI2BhRpmsjvm4N6kT0tjjz7
         HofQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzS62ufASD00g1/fR4Mq8YRdJO7sTBH7YN834J7u7hKMMFPBjf2RqsIwrIWscjte698dkLX8iseECnww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIBZK3YCzwHjclY1kmIJrF+K7aSPYhgWTmsoOhCGlrGOZA+Xj
	qzipTOsOzIYFE9XAoEFWSUFJ1BLlpIYXVQwIKnTb2yAgdsMcMY0MBtFfiCwiaRo=
X-Google-Smtp-Source: AGHT+IGgriZZOL2MwwQHyXNmxP+/rXldRyNEbZu1L+A9ytDXvav22m77BTbEFTSlZj5iIAblyvh/ZQ==
X-Received: by 2002:a05:6830:2a8f:b0:719:cc74:dfd9 with SMTP id 46e09a7af769-71a1c1cfed3mr946578a34.3.1731018915967;
        Thu, 07 Nov 2024 14:35:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1083630bsm488503a34.34.2024.11.07.14.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 14:35:15 -0800 (PST)
Message-ID: <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
Date: Thu, 7 Nov 2024 15:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: max_hw_zone_append_sectos fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20241105154817.459638-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 8:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a fix and a cleanup for the max_hw_zone_append_sectors
> change.
> 
> Diffstat:
>  block/blk-settings.c          |    2 +-
>  drivers/nvme/host/multipath.c |    2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Given the recent revert, will you respin the parts that makes sense?

-- 
Jens Axboe

