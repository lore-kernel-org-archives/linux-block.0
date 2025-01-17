Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604B1A83E4
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737144753; cv=none; b=AbkkW5HTOune6dCvZ6eU64nNNqFo/FKU6eXZpe13p/3zSM1jS8k58f38KRHhXK4/lvBN0UbJnytSEZYb+Cxd/gSQN0qvxWhv1m8HiiNW/zssUgST62FY6n+LBnqXcoq/8R3tY2NonfEOYbl7r0xO4+aVxhaof6NfZ0LuJymGZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737144753; c=relaxed/simple;
	bh=PeeGUPJl2smRX6KHteAej2YYpAbICq/sJBn/TI61EJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQvRixfUX5qp9kGwqvE3x6KQpVlUwUDH282y5jqNxFvyea4/gSKYIRAdy2t/S4sY/lzo6iPP0Xi7ZXb931kuO+kmiPvg03vypzlZv9LFb9/3IzumyUp9ppW9Duda2B+6jM1ptpEycoPwcZPRnxJnpBxCjeU2Yvb/LA0jlMIkQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FLjWr3Uw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FLjWr3Uw"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-84a1ce51187so80445139f.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 12:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737144750; x=1737749550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMbCrPJzL8yTFIs1neOfn76l0nRWVY5b3AebkpdHLgM=;
        b=FLjWr3UwOtkhiWuA2pNj14uVGnGHBTRh4+cBx77NzOVeInM5qc2GUhf3q8O5Rvhjyt
         ZmOtYsi6P8jRGtO8WJ7W/kAOYK8OINX5c94bmaJiVa+ooUb3sm+HM4OnDcMCyu9Z49dj
         /TMpqhW51b+kCknwVZq3ecn1P7uuEcCbv4hAogT1f1vDQVbPH48LfbQCm5fVCu5LpolI
         rLCroJDfR85mvEys4CWosmXn6HkqchCIl86V4Z13lVi+JFZfGrrrQ++TmOZEz3EKrWcc
         gCQmKJDIeEnwkFfU2e6VOCfD/hNReCL7M2ufpx2I/FkvVmfUBzfTcSxuWIt29ZG4hp8z
         3quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737144750; x=1737749550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMbCrPJzL8yTFIs1neOfn76l0nRWVY5b3AebkpdHLgM=;
        b=UjnAv1A05tGjJqt8i14qlWovQoxWrZ3Hd1R4qSs/gmfX2uAjjqFBhYGFZ3UjM27pFr
         GFbxpB9cZLM5mJqdU9j2WVq5VVe7LTtI0B0XW4S3CGuEZMTd7kciVCVPNPzT9unWQv32
         aevd748H0NoyCoyVhKCfFQbN7/0CR3hznrnhYQNjRV3uJyo07Qbsxexm1gggvT1rEWnB
         sULSeEYcPtsCtYfN2eXWaR+aGl0VCmCvWx0iWgi5CqJy+F7Q/oEDyPhkBwo8hIN2D/+I
         5cKl8BSMV7cZwtBeN198GWxUcv2ftkJNUrY4tepMzKzBrgjir64ngnEwU6I4zhp6ZtQT
         2XOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzfBvEJ+UOr5QIIvCsZFimeKokuOiDeQDzv/6nHExMn5ptuQzDQ6zSN6QZ6dsoeikrTXryyHxxuhTQ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZFxRDiY8RtrhMklUmrBqZ/8JNXDW4wzkpN1nZ3tzj+mjl2IQ
	LMr8ioVJvGZZ8e7lwXGUFnaxGSdJR8YeECAAoeaDLajmCUF2CTDL7xrIYEX0q+A=
X-Gm-Gg: ASbGncuBKsDswGYHBA/RZ6HWE5v0iBQjz6XDpOKZ2dMynJwhvJOZ2JDhSsFCxrS6U7F
	503TX54WTdvvk72IDRFXGohjTyEqaTMZ4VuciL25YLsRebhx12zPj83vMkAo8vbBM97rnYVvGYT
	mD1UNBPqktCQOZourhyG3GTon4ksMfM9tfH7OjIx8nYXq2OmLPMaPbdH9Jo04kZ23UT8nKdynX0
	oyrervoUY2IROBd68bSwa6pkD7y7M8Idh5C9S8eMBoDWqHMMlbCZQ==
X-Google-Smtp-Source: AGHT+IH0zo8wsg4X+Ob1gtuGKlznRlHPjHWRlLXjUWO5neR5ZhhSCiPRfv9A+0zKwVoXupgXoXN8hw==
X-Received: by 2002:a05:6602:6402:b0:841:a678:de3f with SMTP id ca18e2360f4ac-851b602f359mr303626939f.0.1737144750350;
        Fri, 17 Jan 2025 12:12:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea754964basm810406173.59.2025.01.17.12.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 12:12:29 -0800 (PST)
Message-ID: <fe80050f-a887-452b-b8f1-86f2ea816228@kernel.dk>
Date: Fri, 17 Jan 2025 13:12:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/8] device mapper atomic write support
To: Mike Snitzer <snitzer@kernel.org>, John Garry <john.g.garry@oracle.com>,
 mpatocka@redhat.com
Cc: agk@redhat.com, hch@lst.de, song@kernel.org, yukuai3@huawei.com,
 kbusch@kernel.org, sagi@grimberg.me, James.Bottomley@hansenpartnership.com,
 martin.petersen@oracle.com, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20250116170301.474130-1-john.g.garry@oracle.com>
 <Z4q45sjEih8vIC-V@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4q45sjEih8vIC-V@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 1:09 PM, Mike Snitzer wrote:
> On Thu, Jan 16, 2025 at 05:02:53PM +0000, John Garry wrote:
>> This series introduces initial device mapper atomic write support.
>>
>> Since we already support stacking atomic writes limits, it's quite
>> straightforward to support.
>>
>> Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
>> more personalities could be supported in future.
>>
>> This is still an RFC as I would like to test further.
>>
>> Based on 3d9a9e9a77c5 (block/for-6.14/block) block: limit disk max
>> sectors to (LLONG_MAX >> 9)
>>
>> Changes to v1:
>> - Generic block layer atomic writes enable flag and dm-table rework
>> - Add dm-stripe and dm-raid1 support
>> - Add bio_trim() patch
> 
> This all looks good.
> 
> Mikulas, we need Jens to pick up patches 1 and 2.  I wouldn't be
> opposed to him taking the entire set but I did notice the DM core
> (ioctl) version and the 3 DM targets that have had atomic support
> added need their version numbers bumped.  Given that, likely best for
> you (Mikulas) to pick up patches 3-8 after rebasing on Jens' latest
> for-6.14/block branch (once Jens picks up patches 1 and 2).
> 
> Jens, you cool with picking up patches 1+2 for 6.14?  Or too late and
> we circle back to this for 6.15?

I can do 1+2 for 6.14, they are pretty trivial.

-- 
Jens Axboe
