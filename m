Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDD42B746
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387326; cv=none; b=rsNCP5XqBmsulxN3FTSbLptHRIcexTzfquVc8sws3ufeXHx1ruchoMRCFvCTHbDZc09UZgsLs86nvZGnS14+HbV25t49RVNFhjkPVHDec7PPx8kfl10FB3QN0WRUgY/Q/pBT/xz9RhXxjja3tGHY1Iue84AnxcXL0kd0SFEZfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387326; c=relaxed/simple;
	bh=2V0vjuyXy6kypG+oH5jFBocr0VPTC18fKm+B9G1R/N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULP72fuOHEpKEN96OTCfEDJZY3NFO9fkyge8/aUXU8lX0yqr9EsMthNwgnEYljZHi6/3OLKhzDrGqRGdw4OkezbHPBwLrziZ/iuIBJKlkTAE5B7UVMI5RzWvjraMlbQcEMiFf79D2+8mM6+x5OibVvnz7Re6mbK2lO9s4D2CffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nNpHN7By; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nNpHN7By"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404254ffe8aso8336920fac.0
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777387316; x=1777992116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crdUSZaMOcLRVl8zoeEkk4g0iNo7njp/hRFe4REvY7o=;
        b=nNpHN7ByVkqbD9hDMOQ8bifILBGqFTDMA0VESPvyBqcY1k2CAtycZjuNtPUBTeIJGi
         hS/yVEDbHSl5mUlRfxvh8XbQCrNvnEUxNYBbHHU9GMmBbBnTHI67PwPDEbmPtB5AafIh
         PHFbjIBqdagli2KdnuFVz0yacXJOcXpQ9VCivcLqOLry0bzydTES0piFdvUj//xSjfch
         2qid6YyzLYVA3MIn6mBwCvtPaEqz+HNJugNFrmOISGcrlbjKGMU2PqP9Xh518/YM0oP4
         +tmhijqGX3N4V6111JbB7R5oPbi7EBhkAwC5Vfvawl2XC65io9kuBC9DeXs2HeDK1BZN
         svPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387316; x=1777992116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crdUSZaMOcLRVl8zoeEkk4g0iNo7njp/hRFe4REvY7o=;
        b=WY5MJ+fmIHvVUHQmzLA9eYIqBRxhRUlndlD8UVhXXwp5oC/BniWZc6eP/ozSQQyuOL
         lbMmrZpPn5+ZSFhjFDJhBN0OViMQt0jXBKHD2OQzYlyMFekp3ITmRVoNkDN7596CKhym
         tlvlj4b228Njwy5KtJHXjgYyIsy1GQI0Y/zX+9bN1AeR/sOTmgpTKNGdcpS5KboFJ/u2
         mCwALUMdFuP91n80PRzq+zEnNOEiu91IhjGbyXdKs93FVAgv5nB4wfnbEZ95PpsMszbB
         HQz/4bqM9GuL0Mk1IvA9fbAes7+otE3HXvdn6Om3652ZtOGRW0tjYLednNKFdO38zvfD
         BFuQ==
X-Gm-Message-State: AOJu0Yybi9oy7yz0UbbuDNRlkER2DtkJkZijcv8/ynTsS8BhX5B+fSQp
	S/t8Tfl9z6P47FqHlP8deA5w0WfTrcuHv10EYqc1E2pOb/mkC99FqcPfKVqBp9HD2rQ=
X-Gm-Gg: AeBDieuJUeWkq/nUfAvRqBvy3vB3x+75xWNiq4qskQ6eAGUWQdcwJlw4ABb+A/izKtn
	q3S+5yT4WtJ/Fk8y5B0J/pWw6WZXS9P059IZZyFwE3ItNl7xbKRFRa1UJNaQtuKkdKe4/LnDoC/
	br712EpKwoiMAjj0yL91ypciyM5iUNPiM9DOvt906QQtFvnAQVu1JtmQe9Q/yEtEnnJ10OJiB+t
	dwwxnoJJY1g6ClhFjTkE4AweH0p2yRhhU5W33k2XDb85EQbAiGXGezI9JCKppjO4CuZs6zfrqs6
	JCSTYZM0xeaHDXgAqvSDtMcRVjhPd48qPy1SgvQ0fpagjdo7F44FV45dzCJwbXNoIj/paVY1AAy
	ysl76MmpPMtNbxGZOKEYjIWBE63iyMzt+sg5z+Kqefy9beJeU5HxLMxO6Nhn8NB8eh7T47Fh8hM
	iPK45IeYyhK12oWDlZOLHnj0TqZbGMOuzdXo/mvDDyFLM5tylQW6jZU+GfEiYpXiiMfWf5Y786v
	DAzp0642T0pzRXT0yxfFDw6K9cemg==
X-Received: by 2002:a05:6871:781b:b0:404:2e44:18b6 with SMTP id 586e51a60fabf-433f1f393e9mr1575881fac.16.1777387315738;
        Tue, 28 Apr 2026 07:41:55 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efbf1d8dsm2015750fac.6.2026.04.28.07.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 07:41:55 -0700 (PDT)
Message-ID: <982f5bcc-8caf-465d-99c7-3b457cab20c7@kernel.dk>
Date: Tue, 28 Apr 2026 08:41:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.1-20260428
To: Yu Kuai <yukuai@fnnas.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 Song Liu <song@kernel.org>, Li Nan <linan122@huawei.com>,
 Xiao Ni <xiao@kernel.org>, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Junrui Luo <moonafterrain@outlook.com>, Keith Busch <kbusch@kernel.org>
References: <20260428143340.1088943-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260428143340.1088943-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/26 8:33 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your block-7.1
> branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - Fix a raid5 UAF on IO across the reshape position.
> - Avoid failing RAID1/RAID10 devices for invalid IO errors.
> - Fix RAID10 divide-by-zero when far_copies is zero.
> - Restore bitmap grow through sysfs.
> 
> Cleanups:
> - Use mddev_is_dm() instead of open-coding gendisk checks.
> - Use ATTRIBUTE_GROUPS() for md default sysfs attributes.
> - Replace open-coded wait loops with wait_event helpers.
> 
> Others:
> - Add Xiao Ni as md/raid reviewer.

Two notes:

1) Why are you rebasing the tree right before sending it? There
   should be zero need to do that, please don't.

2) Please switch to https://patch.msgid.link/ for you Link tags,
   if they are just links to the patch submission. That makes it
   clear this is the case, just the patch. You can use lore for
   actual bug reports etc.

Pulled, but please change the above two things going forward.

-- 
Jens Axboe

