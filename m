Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F935FB80
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021570; cv=none; b=q2UoJBotf76BdIWAWqrA6B+G95PP1S2m70x4CO2Aoj97GhtP2pnqqp7FPXR7WarUpfu+xaxIfduH3hyr2jdYO4LEEX63h1Xpv3s4iZ1CY4haqu/lRZ4edkEgCBSXlxGB1LoTTrkSDhQlgbkxMacT/f9xU6t8uB1jDsOA6AeckfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021570; c=relaxed/simple;
	bh=fp5qVImIHD5JOUC96vXUNPNMqfnCEowtN4bGB5OOrAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugPJC6scmCjIYAxaciH2ic6xC+IuvPfmY8VD9r8DlpHo6ycbH/Jo7JwN0cz/cQlcFh3lEpeuVHrmOlzIUUxmEoLmmTvZaX6DWCgRUkvlRnwFoOOprO9Rjt/LpPhXl/Fb+xhXQpUSsWO4pBeh9vqpr6NoAvtJmrb51qhf8bFoej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NZvT6eXC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NZvT6eXC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74058f6aaso2428505ad.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706021565; x=1706626365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+szsqze1pwnYJJhGr7v6osKsbHd7aAceJw3+plX/00=;
        b=NZvT6eXCfByg58ae36FVvbIf0J/jsgHUSlOre6PM0vnJLSxn7x3S+/SdyNV+cHRESw
         /H9qQGXqJyr4KEHeqwBPQyw/33iwuO+WGXbAGWohaS3b+B5JYS27pdGqjK3pRFn0V/3T
         gWdsS0xb49lRZbNuWjs+bey9lDOBcD7acmzY+mmSBGLwSQMZCFjK3oFvjJu923RB7dGf
         V9m+OjPgA/zV2ePKV4+cBXItuzubHyZcwuKY4jIF7ep4EOLUcotWPjxKYok/pC18i6ed
         yeIx1WzpULFe/DEzflvhtp01CluGOeEdhPFtO8WpZldGWWDgLtls1aWb5nc9sm4SiHLr
         AFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706021565; x=1706626365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+szsqze1pwnYJJhGr7v6osKsbHd7aAceJw3+plX/00=;
        b=qkh6dD2EAr5MvaalOz+H6r75SxWveqR+NBx62Sg7zDy8+vcIeL8TIlDDdChpNx82AZ
         ls3Dei5DjdzCQ6zP8R/smtsIUC9V/nBIRnR3utpTu2fF4FukmDXZci5qqh1b/85RgadU
         REzhat9HSwKI3VcQu7WUew/CqW8F4fVVR649of2hwZEAPXIofjgdDVKOaaPNWmVb1/8N
         Tvwf0zxhx+qdn3VO2BHiJ9EUZLS9mPOfA9YzeY6tD9tiKKUxzCkzXxi4eG7zqmtDmhz6
         FT3k5FGx/GDg8DsHxfJ9YomgRk0bStlDerGfId6mukk6hXJhe75ryFMS1i8EN1s1uwHK
         Ip5w==
X-Gm-Message-State: AOJu0Yx14iZ7QkaNsEQTmCSBu5LUM49rtS1MgawnpvvGqDU79kZEV9ov
	75DK6uv6lIIdc5PEPN+4+hE8+nXSBSx1EdWlQfafxy1yNjTi8ph1mlwDbqq4gmE=
X-Google-Smtp-Source: AGHT+IELZJFZFQPBch4qxcJzwANaTWxrpfG58bcAWv3AchdT2vCZeq1TB06GEY6KaprSFvV6qsU6SQ==
X-Received: by 2002:a17:902:7b95:b0:1d7:6b51:ca76 with SMTP id w21-20020a1709027b9500b001d76b51ca76mr2470296pll.6.1706021565232;
        Tue, 23 Jan 2024 06:52:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b001d7233f1a92sm6884401plb.221.2024.01.23.06.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:52:44 -0800 (PST)
Message-ID: <4aff34f4-2c1b-4e7a-973a-4f99ae21c7aa@kernel.dk>
Date: Tue, 23 Jan 2024 07:52:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Optimize request insertion
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20240122235332.2299150-1-bvanassche@acm.org>
 <1f140e5c-c7b3-424b-9231-fe51ddb6fbf7@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1f140e5c-c7b3-424b-9231-fe51ddb6fbf7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 7:30 PM, Damien Le Moal wrote:
> On 1/23/24 08:53, Bart Van Assche wrote:
>> Reduce lock contention on dd->lock by calling dd_insert_request() from
>> inside the dispatch callback instead of from the insert callback. This
>> patch is inspired by a patch from Jens.
> 
> I supposed this is a followup of the performance discussion with Jens. If so,
> can you add performance numbers here and so justifying the change ?
> Otherwise, it is hard to figure out the effect of the patch and so why you are
> making this change.

Numbers are in here [1], I will fold them into the commit message. It's worth,
as is mentioned in my commit message, that this also relies on the previous
patches to get there. It just leaves the insertion side contention as the
dominant one until this patch is applied.

Before:

Device		IOPS	sys	contention	diff
====================================================
null_blk	879K	89%	93.6%
nvme0n1		901K	86%	94.5%

and after this and the previous two patches:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2867K	11.1%	~6.0%		+226%
nvme0n1		3162K	 9.9%	~5.0%		+250%

[1] https://git.kernel.dk/cgit/linux/commit/?h=block-deadline&id=678abafc92bae49e6f4a92cea05dcd5f39928054

-- 
Jens Axboe

