Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCF37F8BA
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642898; cv=none; b=b290DUXcukaupUHW4LeBY4usNhkB/mQR/3HeNGaYOQYpwO3pZbMLdUT14hjtG29xmr946jCrxhaBiRVgUMGUhzogHwCV08ImIeIL4TAvHiv9Vc3O0s/m8RPeQblUcSyOmf4KyEKBdJwDtRhBhAxiChMOojVxTnkRuJ+phsP/Ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642898; c=relaxed/simple;
	bh=Sw5kaEYR+kOXbMOw6h0GSGzuO0FP6TMElZAcRsybMMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1sc/V29FrmSuuqP1mCddl3VxsAglUC/rc4KB0grhb5tiSBR8E0B9l4W6Akb+WVzPzVUvYPUEFx/23KZpR+bp2LZEFXug66u+90+0zwZBPm3YShskM/NSUKLVObB+2JOiIcRl2lT7OYQ6Kdy26uxTr+if2K3+Cxz3VKPOW6edkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sZNhXX9+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sZNhXX9+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-486b93fc7c8so2051173b6e.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642895; x=1782247695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHjBmEtaY4MZyV1ZaXFC26z+hDeMIBdFKC6hpsQyryE=;
        b=sZNhXX9+cpbkSuQrhd/qkVQ9KMH3MK5AEqY2ezI3n3tT1VZzI+G7CTD7+R8ZgLGmaH
         hWaORWu6giR94C52lhyZfjX7iTve0DPwv6YIYH1jVlQ5hAZ0vj6cLwaFHwjFRIAetijA
         9w2sNQewsF/ifGCOHm+Wvg5+cmLpbkU8eurUQyGiJlz/R3ilAKxEyunoMSjeaZGqQnby
         oIvGV5C67Kl7t01rdI64ijkrzxsltfL88+wBVdLcjMrPO1b2V0xqg+SvnLQ7ncXp0uQ2
         uTaq7SHsZNLiYSAOOy7V6E+tzOFxF3wzNECrwH91h3AW9p0697UZNO8bcDXFsgt9DEUy
         y4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642895; x=1782247695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHjBmEtaY4MZyV1ZaXFC26z+hDeMIBdFKC6hpsQyryE=;
        b=qSTn3T0qEbhKcYkzfL6pTEjk1LV0hMC1OIexxeAsw9/zRgVmy8gvMdza/VIQafR+IR
         j42kLVF2+INwGihUeWoStwReekwHhyzwOVzNwMwBeKMBBdLIT11tXNagOv1xTe/SHo7/
         XnpTqwSSC2Sbk4FnCnBWVn/T13557MsDo9n3php+FVwWs4waT+kbkP8Rh0TCtHt3CzbD
         8zKZr/toxScmOni37PK4IViTA47QRYb+p8gb/N72bZAILJ+/C7nkZkHBjNBBN3Qx1XCi
         G1e7l3MpFtOp94ebb3up0wmH+Yw71mGsWuMuWlG3D/atvwH7/Pgr2fglg6eyPNGw9Xgv
         7P5g==
X-Forwarded-Encrypted: i=1; AFNElJ8DFux7r+h9BqmvttHhtt7OzfbYaFlX4WRmrO9gb0HIjsS5pJkDDbIoPM4MOPldCJX0aXHStD9eoG1jfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yAosbOCINN4MfsITyR1Vr3K81xUcLDKgF/lgCe32sWDZzFOH
	r9oe+VUJUnm6t3EwcwL87ih5gQyaBmc5vPxikux2w9cFgsyxpQYLsAyY/426/QwXjg4=
X-Gm-Gg: Acq92OEBPhsQeE0e2G50M7z8qCDM2uJsCaYGWxvA+GpYR6KmsIrEOqv6xBzhRbTqBVj
	soBOrUpAxB+7SYnlYl33hYKCxLKdLTmNmI9MwRBerSRxai+WrAbWWGu/04scuMJNTrHjPH2XO0F
	Sy+4ms8mqVe9EicpBlh8c7zef9G4/KBW1dM1NJ1mJljif/mCLTTJ+TnY8MEXlMh4R9UJbkvhWCS
	Drpu7QOKes9e904vKEYJM+5OeF/6azWrV7BdCxb+LXdLn0t86IKYfkAojyrhThXnXjDaHNI5gCK
	WwtlCKVXdAYxQg7XDvFV01UXfg+coOAgMBs+ixvtCxE5PHbzvAmkTvXoBhtFvTBalJ73Jc2luk/
	bjKiFj7IOd+pk6LkrDCOOY2k2Ajsy5PVWOzTVswszHqGo+0gcdTsBEFJHVBKxP8VWg6UF3hMTNy
	TwxatSaqORq25Aln/p8Li6sHzVWtAAw8vcIMYI74ML8Q/uH8OTjDyYXWGtB7XNmPKDXIXfOczkO
	gdNH0OT2w==
X-Received: by 2002:a05:6808:f89:b0:479:dc74:3696 with SMTP id 5614622812f47-4894285f7a5mr987811b6e.7.1781642895670;
        Tue, 16 Jun 2026 13:48:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfe4a89sm5237391b6e.18.2026.06.16.13.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:48:14 -0700 (PDT)
Message-ID: <e94bfdb4-6932-4cae-9693-6f0d6f51aa17@kernel.dk>
Date: Tue, 16 Jun 2026 14:48:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] btrfs: use IOMAP_DIO_BOUNCE flag instead of
 falling back to buffered IO
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <cover.1781597506.git.wqu@suse.com>
 <ajFFYT10i1dvAy89@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ajFFYT10i1dvAy89@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 6:45 AM, Christoph Hellwig wrote:
> Note: You'll need to include Jens for the block bits to get either an
> ACK or a merge through the block tree.

I can queue 1-2, then Qu can push the btrfs change in once that lands.

-- 
Jens Axboe

