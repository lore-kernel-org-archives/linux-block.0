Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024131925B7
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378230; cv=none; b=MLXnA6Wtn2F09PfEwpxVQ0HzE+0mBqrCwRB59UqyAIH/KMVOYuK5s0P4f0lmJQQ6fysAeDaQfl8EgbgyYLl6vD4pyJsXhDTH4oFBTsC1c3HmcGfBdg5s/wJixsCq01xFW7rUtPSL8WLuBZZeMs637/Xm2FlErgf+R/q3t7zzIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378230; c=relaxed/simple;
	bh=GWtLMRsLZGe4E3r+R/+P8YYa7gW3X+2YsqwO7F/RACA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JOi2aeUH9AWmoSmspnbsImLZolWnJiCpdadMwxjhoMqF9r/e/ap1umJdyNdj+tPh/88tI27dt1ksekydmODRDZ7oEwWFOEYxyrw52QwIq0lJYPVhv0kk8URCQTY7JZQUZtReIXwf0bKaxtwu39K1Oi67EBldeiZhZaE1agMfSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J9T4q1FM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J9T4q1FM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb7139d9dso30088515ad.1
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729378228; x=1729983028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=J9T4q1FMkkeUOuyS4kqh3Zv2OOSboClfGFSpC6jAIixz2f9KNR6kl723zJvhjkydQZ
         /Vt3pk8rIoSF3SuWdjR4UjYoKop0DZInd5jHJuuY+Jc4ykJOqJDW5bdzyBxKAE/1XkNf
         CafyFSCH7K/7qoSXE0Pmm5r4E8Qb3Jq305TiRaZEmQv+xnp1TWmihq06CfFT7W8o64AJ
         q69TmcSb4QoTzdqMF3S/nkRnViCJf8GOKqyOmef019Y39RnDBaiMaG37hPmiPKIHas0n
         VoujHkQ5HxToaoAMLEaqcVgkCkCQBkFO0L+S/JT9t5o5040DGf2pll2nsScOTIKIgfJl
         jmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729378228; x=1729983028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=M2xKgZXmn+Qwj8bI/nMuetDE7gXb/42ykvJ5LBIXTtGyab3GcIYzMKJ2PYRxG0OTYz
         gvPYw/fn9N8gK6fc47UwA4djr1RxxWgx63laumR+DKWEwEsHKeHKRh9gj/cUX6OZLyXJ
         IxeWacxRQPD38f2AbfqLfopu4YxvwJE9fo9lEuaoIwbU1s3p4JQdm6v/vFAfatGZoTUf
         A4F2gNMCJK83C/rtXwc1C5Qp42jrhEN53PK+bPuU/q5rzd0tBounJ/xcXRpA7NXdC4vG
         edu4OtasEj/+An4d6l28A3Sj+7WgjzLyKS4WE5aQU2ZE7XZ7usIhRqZIUTeYU6FlMXe6
         f+gQ==
X-Gm-Message-State: AOJu0Ywiuxs7ImPnL7bRo25CafDDyAfi9xt5c+S9/8H+m9EhKfGKJN+S
	KGldy5TtuadZcfmxDGJxC4Z2qoi2BVufM+gVk5oF9bPkwkOgQyDbfNmuCom0Q+o=
X-Google-Smtp-Source: AGHT+IG/SdolPDBlJgQXRSOz40RufwW0B9RRmCWWNyO7f6sAWOxABQs5hjD2LfcfSRzPBkj3obJ9KQ==
X-Received: by 2002:a17:903:2301:b0:20c:9eb3:c1ff with SMTP id d9443c01a7336-20e5a94b609mr89438595ad.59.1729378228212;
        Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd4bbsm2095375ad.155.2024.10.19.15.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 15:50:27 -0700 (PDT)
Message-ID: <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
Date: Sat, 19 Oct 2024 16:50:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
From: Jens Axboe <axboe@kernel.dk>
To: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
 martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 4:49 PM, Jens Axboe wrote:
> 
> On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
>> This series expands atomic write support to filesystems, specifically
>> XFS.
>>
>> Initially we will only support writing exactly 1x FS block atomically.
>>
>> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
>> atomically 4K+ blocks on x86.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
>       commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
> [2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>       commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
> [3/8] block: Add bdev atomic write limits helpers
>       commit: 1eadb157947163ca72ba8963b915fdc099ce6cca

These are now sitting in:

git://git.kernel.dk/linux for-6.13/block-atomic

and can be pulled in by the fs/xfs people.

-- 
Jens Axboe

