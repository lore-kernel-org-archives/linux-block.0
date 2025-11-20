Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4B298CC9
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650941; cv=none; b=DlPPXEGcseQ5lhnNoibf0wEOoovGDT9Kmn2YuKJe6mEzCd+84cVGDACqAYFN4fWk1MFo4tgFpvHEGZRRpXalsVnqw/iHmZPKyk1ZckWBwrlFKxZeG1SorUBC+I5HX0Zyjf9HJCl4F7EBwEUqDTpXTaP1ED1yhQj3XhH6tv/l9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650941; c=relaxed/simple;
	bh=iaK9Wtntb61lk43dPSutSBf3T3Dn+A/zUb2Q3owpPTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkAO+5fZbzsIzWhdru+ZmjflhF8s4sycTDIKr/tb1wvYzg6GBgSd7oP7aly5pm24RpGCJHgs0Y7JYYWWubnPAnIGZpY6Tb1eUfhiQSOO3L/ljGkBy1Kw4cn6xU/lTuK5VUweUNb0XFXlJle+jPuN3K5afoqkhzKE4XQ2z3d2Bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OAOn4za9; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OAOn4za9"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-94905c3e2a4so89396739f.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650939; x=1764255739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KRVdbYUR3Sr8l/3ieBScqB14kfYXzSc52kiU/QVVdQ=;
        b=OAOn4za9tx7+Ol3hM49aw7M6Ktowy67H4pgeKr5lrHpui0qFIfcSUQyerwZsLR5bGA
         ugIeDMpo09S6kmlwSvlFTdHgP8XBMV3RwH8NutBpO4bqpXkzP5WgO/yTgiPiYhcPNgel
         U+PQGQMAlQF73zCUoBLMEF/3swUmL+DmSZOMKe2u9p+44ir9Grsob/bos9BD3Q5KDSTt
         qf78Tl9bdVfcFFDW0lMmE++oZtiQiXkJL3/oBdoabKZcXkTJy5YjMbE1CVinI8ZGZtVm
         o1I2+6t5ElFLU94nibfYyZR4aJs/Fq3YKNuI93MEaBMM034cW9HT6/RAvdxghZrIhhIp
         qm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650939; x=1764255739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KRVdbYUR3Sr8l/3ieBScqB14kfYXzSc52kiU/QVVdQ=;
        b=qNKSlvZZ/0x1uZVdDD7UKWyGs6hz0B1/IzI9MrYpUrQVYVMbmEl/uNiwA/1ypjnwMB
         aCvIFdaRk3/GA18dgS3QmHizfMna/bAnnYGlaAhvaR0P6DarIo4l8OYsP/JUBzJ+PfsV
         HPJ5Kye3CV6r9LI77TCrqTkOeOwo5YxyPywvi7RF+bZxBgckr3ejFajBEHB0TTTV6ICH
         o/ysSoV7ohcyYnmIf11E1zXqCFBylMfD4JK2LJ3LBufivE8avBwSx9gBYcnhjg4z8q9/
         PrJv4pLTcIaJP73xa1y8gbDq4t5W7QEOy+C9OZJA2FWDx7qyrg6Fb9PEuLik+Wi1CkGn
         cRUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/2fJjRNNTjM+cPv9ynhcdx4hgDDmFG5zUysSgR15MyM+VIF6EAsMsNGjUY0xOlgdyjYqlj+RZSuy4pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKMQun8eXm1cdqUlRLcpLgnwGyJlG+k354eAZ8JpABVP+sapW
	QlOiVjwQtsteNgOz/WA7lxWf5+m5B5L/GtQKSJUENSlAyfLvlfd6IX/BRnj6mSVzUuE=
X-Gm-Gg: ASbGnctG9h8IL7P2Fu+HAeNHMefVqZEr1fiOVdNY8PwDfOGCWWRv4CTDyQNWXpDw6a9
	M73oraiDRc9qXfNAyXmri7HRi8c4ZDnhyletvLnhumUa4j445/c3OKzQHOtPhRd/20+bnpMcNwT
	cX924v3h83QWy+6eRX/O5Nmy7UswF/JFuWusYnxSBqIV6fy69s5Mec73GtYNbPyuWmNI2gDfv7R
	soUrUlUOMHpPJ/i5Jvo9WFCegTImOqq22oyp/fBVWyVN3Kb8BYgGSsmXoO5mjAtaO2mE7CsMlcX
	rGRuuEwHIJumGSVPIdq6egN5PPeepI011juEcMqDPy5pIocBYe0reOpA1dlECLzN92o30yquo1C
	dy6593lv0HUypAW1mDM2ACW8Lcgvk1jNnLKhZoVpSclIaXNGXzE2IUTwYsiX6zQ28/ifhPjpGrc
	0NOBaBaQ==
X-Google-Smtp-Source: AGHT+IGccW7ctRF5PCm5difEkpZysoI3jJqDA5sLTPeQcWJodi/1rFNLQ5iPMbGK6SBAFm4MBXC0sg==
X-Received: by 2002:a05:6638:a687:b0:5b7:d710:660f with SMTP id 8926c6da1cb9f-5b956903b7amr2140494173.10.1763650937997;
        Thu, 20 Nov 2025 07:02:17 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b212basm1008103173.36.2025.11.20.07.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:02:16 -0800 (PST)
Message-ID: <1285e43b-63c1-471c-b56b-e286ab865911@kernel.dk>
Date: Thu, 20 Nov 2025 08:02:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] blk-mq: use array manage hctx map instead of xarray
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de, yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
References: <20251120031626.92425-1-fengnanchang@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251120031626.92425-1-fengnanchang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 8:16 PM, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@bytedance.com>
> 
> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
> an xarray instead of array to store hctx, but in poll mode, each time
> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> introduce some costs. In my test, xa_load may cost 3.8% cpu.
> 
> After revert previous change, eliminates the overhead of xa_load and can
> result in a 3% performance improvement.
> 
> use-after-free on q->queue_hw_ctx can be fixed by use rcu to avoid, same
> as Yu Kuai did in [1],
> 
> [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

Thanks for looking into this, it is indeed not ideal currently after
that change. I've noticed the same. Just a few minor notes on the
patches, please send a v2.

-- 
Jens Axboe
