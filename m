Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113AA344051
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372628; cv=none; b=NmhMbtjNcY0askelojnvSage3mea6bEypoqWhwS1AICZ4apNfIZ681MJaKrtvfxov04pOkx0/f8vnVzNDMVux2yAht7LjfQoEzsGHTJvoRdLFc+dVl63Fyb6O+morZNzknoVJOm9KbwMcI52tqx/n9ODPBK7yVAUo9HRbfUp5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372628; c=relaxed/simple;
	bh=0U56PzRHQuKFX1jF0EDeL3RfYgwrc6/XAQEtc7BS4Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW6eFm0Ad+yJwXuvanRwNpJSST+vgA0VHShdJlzSMoFMARDXAWZX4SmwNK19YVy128uWKBGf8i/aJtVAkNOmqkcPz4hr/sguhDKddyloorcNjwKcPn1l2nYIUbkG/4Up/TPTC2ZL/qMt2lHr/HyDH4iZo2d07oO+gT9aml3Jmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ilfv55hx; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ilfv55hx"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-948284e6708so5635539f.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762372624; x=1762977424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxvKuPYsV6odl/YrIY/+DvXUGSb27CaTkPJEalKMGO4=;
        b=ilfv55hxQtwRDjfADXkhZ6pjkxVJJHVXimLyA6dqPkj03e3LcnWGJvAxr19211Enyu
         UqYEzAuBd6E3a9fWbYPThYjOS/FIkLl34GafujLylUsdDmqOqvNYD9UQDZAe9uLlhOwH
         t4Bl0oyfQhiYC/e8/PrS/I+nkEIMBry1DT64hZEBHkdxHLgnGMHr8D/n5uXdWOUSb0Cg
         PJ5us3O0hoUffSvcBbHakrVW8dg7qpa4khMxXDqcoBSQGd5Jc0Y5byem+3jBClarFJnu
         7vo2qXtemXiJRAFuczwrVpQZpWGKOoSqAgI4AJulDHgec3U5xD3f9F/jjEeIoOahLYNE
         G7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372624; x=1762977424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxvKuPYsV6odl/YrIY/+DvXUGSb27CaTkPJEalKMGO4=;
        b=SpxqoQxWChzjdTgBgLDYO1s1ZJbrwKmIv9nTNynHHMUE9rEAhmMtKZx/w8bgzgD7Zc
         ylkSDdDeX3zv52KzSASkvKpaKLvhLZ5X+W2brnGZ1mdzeFwTSSsgW+9KRRi6mA6dmjc2
         Uv8xxI3g6YUhmY3awnbYxbmEwlrXY/dOFLbfDrG6u2RAFf1lsKMj6garxFzZ/1wQSLF+
         8UgUkovXKGHwWsxWY7Os2N6dV222UKHEHfD3zvGiAccPGlvS3JLwbN3ssNSKmCp3MY2R
         wdYExTzwK3zLa6E3hbM0vuyA4nk6EYGxaRJeKAt88cYtnEY19AdlvfubrSJWt78knLi3
         eu9w==
X-Forwarded-Encrypted: i=1; AJvYcCUZg3/s5kopcbOgAD2of0xfMPB20xslEp2T3Leu0cPVJi8SQGUEiY1RFObL7bJkgZ7RmOXqaVQhvUGQrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9F8V8iJSiq8lAx1uVR01jyzRwtxpAtVr3Y/kK7duGu8d6lUkI
	+1IwDCY18LHHxdxc4DfMBUVJEeP7SDjWOtiqpnZbLL26CNCShP59SPj8U0rcbilgzgT8I6HHWhy
	bKKMx
X-Gm-Gg: ASbGnctDIMve48ky4ZOif1OHO/sK4urwVZsdaCd04avmyA9ssUSepvCE99EdnpMf+dd
	7+u1eO+VD0xr60Ibf3iPlpcRc68HwBCmfYU+ZCLsgwDW+qyNmnj9rYvtp/mU9Qc7mc7Tit/XG70
	eZEmhHrvwnWDxC+5zp3tl8S9g4r0qGDLEeoi2RpKPjNyLHoRc4bKCGMvaeEhnCZ9cc5ktQkKE+n
	Y0zFglg/vEeFJSOeyje/pl/xdgtrdkpj5Qte2EZiAVt24j7UtAm4vPDKwqOT2/AZZ7wLF6z69GT
	kbh4gY3B4ZBSXR348f5bqY/DmZwJYmNYuvgdzCz5Mi6nTUU5sUe6JHei3OTLjwgFSt2qEraC//p
	mVlC9B9x/CK2XDKf6Rc0JiwKlL5KiGbOpHmsyWAuOUg==
X-Google-Smtp-Source: AGHT+IF0ixEizkZRDJKZp6P7ZAgjBoVbviFgfl5fA93aCEGGUAMq3mEnKaX0mze/BdP8jEUYSWkovA==
X-Received: by 2002:a05:6602:6a8e:b0:945:a7ce:646c with SMTP id ca18e2360f4ac-94869e22669mr597881839f.10.1762372623983;
        Wed, 05 Nov 2025 11:57:03 -0800 (PST)
Received: from [172.19.0.90] ([99.196.133.153])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7467d5a37sm53462173.7.2025.11.05.11.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:57:03 -0800 (PST)
Message-ID: <72910b6c-6871-4f5a-b40b-0bd58329e264@kernel.dk>
Date: Wed, 5 Nov 2025 12:56:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251105193554.3169623-1-bvanassche@acm.org>
 <20251105194703.GC5780@lst.de>
 <f7bbb2a2-8342-4fd0-b906-7be5f5e59721@kernel.dk>
 <20251105195146.GA5998@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251105195146.GA5998@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 12:51 PM, Christoph Hellwig wrote:
> On Wed, Nov 05, 2025 at 12:50:30PM -0700, Jens Axboe wrote:
>> On 11/5/25 12:47 PM, Christoph Hellwig wrote:
>>> On Wed, Nov 05, 2025 at 11:35:53AM -0800, Bart Van Assche wrote:
>>>> Unexport blkdev_get_zone_info() because it has no callers outside the
>>>> block layer.
>>>
>>> The commit log for that clearly states we're going to add them,
>>> but it'll wait a merge window to avoid cross-tree dependencies.
>>>
>>> I actually have the xfs changes ready right now, I can push them out
>>> if you care about the glory details.
>>
>> That's fair, I'll just drop it then if there are planned additions.
>> Would've been better to add without the export, but then that'd be
>> a bit of a mess if multiple folks are going to start to use it and then
>> all need the export patch.
> 
> I had that some discussion with Damien.  If you want to merge the patch
> that's fine, let's just hope we don't have more than one file system
> wanting to use it next merge window (I think it would make sense for btrfs
> too)

Let's just defer if there are planned users for 6.19. Once we're in
the middle of that release and if no users have been added, then we
can kill it.

-- 
Jens Axboe

