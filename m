Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B73321B4
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372253; cv=none; b=VI5eVpbO3dm0t36CWnXfuzj+MYAJnuL/RCZV6AlyXzkEX18ZuAat3fpWK9PSAzqwsQNrgx1Q5Xkqzgrs8Re1p++v1QDDJWTdtPzg/l3GOtxrccCnjYGIU/7UWPjHEvVzAjoFYnpmeIuBsk4u6iRNVOn7M5epzxUfz59lg5LXiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372253; c=relaxed/simple;
	bh=8NPSeihTdAeNMV1RQc5vcXMZK2lndqa+6FKPWz9StxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIMvJZwMJNKVeenuOKYwi31QXO3Gx595YlXz3JBFUPcBOPE7lXkBklby2oHpmHX0otesmS5SXZ2kyuvcAugT8w8bE6KdCfeHbhi1npKO9PMd0cDO5+ja3dXRhXZ1/y+S0KfdHCq7/jJ91aqW/Y48+KiR/jSk5fQI8MhtGe4gR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WU5bGwMi; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WU5bGwMi"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-9486251090eso10814039f.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762372250; x=1762977050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYCzwmfJwy2BgVqqWQOlnjHX+IZXD6gB5V2wvtnJN1Y=;
        b=WU5bGwMiVMhc+FdZDf6TV2GLEskNaEJ/OD2hZHvuR0/kVRPZ60YCQfGJpATNkCQm5u
         HctQVPwnStS9bmyZoNBFl1y29gP1CeMHbUY6pYRkbJdTzklFWV1HPxP/K28CeaNFs0qf
         k4mXdYyx0LfX5msaRsGh2XJU2bJ8ezGhkiFX/fGjUn1PBHMXQn3V5SuxmuyutvGhWUWx
         KWLtyTnv1KwAC3VRG4SKEnAzPMLl8IYqkvErmTa2/nEnFe5pR22BlIM75InKTS1yy5oK
         xNsiBILaRpgtjIyG279V/gU8gLbwuZ1663aMy5GzE221aqKBa5ldtwO0XrRa813Yq0R3
         4tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372250; x=1762977050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYCzwmfJwy2BgVqqWQOlnjHX+IZXD6gB5V2wvtnJN1Y=;
        b=pkJvyUn/RkBYiWGbzJwOTJEmaWNrDFKTElOjD2G5VgR8i26FaB3K2rmECansa7h/at
         6ad4WHNHlAlaUAjfFyqoD2svXbZb2+XmZT/m7+qHGwZwKSmGH/YqjU5AtOwV4Q62kJiH
         grVKz7zXC2pOrCzTsonCp+3stzdTy2otGrBQYIQcfnWKqhZ39cPN65phZrO+ypzCMKvI
         rdSQ4/X7UIuYINZOm+ZNJWXq9ww8H2BTHmhB4QA73sC9eOovvFXhei5XTimnbd9ia5KH
         w0srNMmo47ZOdZnMWTThUCRe19dLwuR7HnbpY01m28/+9ARaMSjwRk84JQ9xtAevK42M
         7XfA==
X-Gm-Message-State: AOJu0Yy4Aik9n150NAuPeC7rlfLXkk4MFfDNDVMebZGwyGlwlOAEcRxX
	eE6EO0b37q/d863pFLufUwxBUX1C+T4VTex8bfnN7lRuN04dJ+usX4r7W7Ho9s5Q4vRSUx7Xi5M
	IDn6Y
X-Gm-Gg: ASbGncss4/D9mKnj00bvG7Xw0QVAfQY/kVyqS/A5KVSdl6NOMRW2Kg0bBr9OkXLYcta
	f37KkgQKrZM2hCDezRfdJSyj5TMlqmD7hqtnD5/NJIGxHh88mtMgz3fD/fN+D2ZgDJGE6fp7HKe
	4Zb265/JYbYyMaE0PM7s+fZYeeF7wzJfVG0PMBI/dNLYpcY021sGzdotCkWOT1unS3BkLQewSn8
	fzFi2U1RDZ7uYtpCZzUhrXLyrCaMHuAB9OwSJoRxtXGmmuuZofboycYWY102/7IY8oidJvOU+fw
	hh96vpqkbFARvBOXfexD64sYy1/P3iO2R7GnsXE4mMhuHDZ8H23/+kp9dvL9nI21IPo6zWRjMkq
	WZTyrsVx3SL0nDdvt+7tWskU0lVH9e+lhOpN8of4Q8Q==
X-Google-Smtp-Source: AGHT+IEXxlXeEEznlFSBkCTTb6rLTPK4H7kXdxNiqucfV5Ii/jv5VGgpY3Yxxj0SpOYx3Rcurmwdtg==
X-Received: by 2002:a05:6e02:b4e:b0:433:2ba9:b3c3 with SMTP id e9e14a558f8ab-43340753685mr75566725ab.3.1762372250144;
        Wed, 05 Nov 2025 11:50:50 -0800 (PST)
Received: from [172.19.0.90] ([99.196.133.153])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f42cad7sm1166895ab.4.2025.11.05.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:50:49 -0800 (PST)
Message-ID: <f7bbb2a2-8342-4fd0-b906-7be5f5e59721@kernel.dk>
Date: Wed, 5 Nov 2025 12:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251105193554.3169623-1-bvanassche@acm.org>
 <20251105194703.GC5780@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251105194703.GC5780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 12:47 PM, Christoph Hellwig wrote:
> On Wed, Nov 05, 2025 at 11:35:53AM -0800, Bart Van Assche wrote:
>> Unexport blkdev_get_zone_info() because it has no callers outside the
>> block layer.
> 
> The commit log for that clearly states we're going to add them,
> but it'll wait a merge window to avoid cross-tree dependencies.
> 
> I actually have the xfs changes ready right now, I can push them out
> if you care about the glory details.

That's fair, I'll just drop it then if there are planned additions.
Would've been better to add without the export, but then that'd be
a bit of a mess if multiple folks are going to start to use it and then
all need the export patch.

-- 
Jens Axboe

