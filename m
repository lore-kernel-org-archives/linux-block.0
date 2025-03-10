Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019222DF9C
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619880; cv=none; b=RfNC1pntVsfeICojl7BUe7MgMWBvBcWQtb2mSlu19LwUMFjifBTX7tpiT9y/SwhEhcO1/5k8kIez9G35yG7LoFpplftlOA5jOBPvNOX3hLee3wb2QbJTndp+8m3QY/5pKGrQABhnm8QYarsbvlW18GlcE6HzP0zvALlt6vn/GM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619880; c=relaxed/simple;
	bh=x7cI/8nUBvDIXlw67CxmYU0KDbq1pXrHOJpQbPVzGZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfNCUxbihFU0BW9I6H2Ny3PWvOwk6OcJti4bZ6rceSPEmCdFh0eRRc8phRmlRCRA66DOhI+XojcXnufoe6DzLjdhkVrtyXw7xWdU4ynwXT67V8oJcbVpIHifI9FVlG6qD88SRn5c2Kw9xBw+nnkAGZ2cAS4PdsRa7MOHZ+tCr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w8lH1Kbv; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w8lH1Kbv"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8553e7d9459so123700839f.2
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741619877; x=1742224677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFI5CNZ7ypkf6nzIklavj71fRclQxpBXGT5mnCzliiA=;
        b=w8lH1Kbve4aFuEHGM6lz195sAuOqeeug608K0UiT5mpHLJgNqZfM4v5Fl9Ihwi8azA
         oR1kRAJLZ5o9pd3JlrEW/TJ7pbq9vIG64zhLQ+1RYsQQJUzfaESiKTpOaCn3e3azlQF/
         PAPAeRWX8l0Ez1MeztNBKvciLVOzdmovGo0ASLHQ0BXmWNhmbZ3KcZI0E0a4P+YZ4wDb
         2QyW+rFwbGZCG8MZFFQQLWbedx03QKqnPh9cV4yvu3G0L3matrFhPfyxm9t/FDF2KJZW
         c2RpwMhFU5BLg/P3+i0GZ6M2X32qWFHBvDLw+MHqfZys/ZgK92xXnyAUXbKgpZyDZ9UO
         XvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619877; x=1742224677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFI5CNZ7ypkf6nzIklavj71fRclQxpBXGT5mnCzliiA=;
        b=Nb8rAUhWd7kH9G8o9x0Pyg6eRFfJyieB5vc6dCpJ/glSibHzgK2zrin7SRctkzG4/w
         PPuRMCzha98WCi67L/3Z1zPEXWfxZmC9UbmccrrDSdvSW6Z8DzarET6MTjYkB9agmFDR
         yH/IFEoXdxycEix2cZLpyQb+3EUlO+Gxj/Hi+MVQRsEFWO5exbaMg0A+dNX0deKcOxxe
         giRK2epZPkLER7uuEboxRIZFTUgV/JU6dFDYU4a2626aYfX8JRPynucBy/2488vVBQ+A
         HA4Jy0+TcY8mU3Y1RTmUJ/JV2KlZntdx8LFhgKavSM+sQABhSZ5f8Qld7kHzSXmhEASb
         JazA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVmkwPpbGGeEe//tPLNQ9uJ3UhO9Hyk0XMFtzeJh4B3AAuH4B1UU5AHrvR6S1ze5nuYMgJDh5qR+nRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2d0kFrn9Vn/Nru3uEi2U4ITvm0BXdw7qgj3M8nafQk9AgGtn8
	5ZI1Vc0k/HumGM2k7PC4Fh1DsKcM/mrNP97Z8HcEJb7l+2S+eYP8SU0CZtRxawhPOAe4m/OEkAQ
	B
X-Gm-Gg: ASbGnct7ww+SSPld6JX0b+VwqT+SLHUoKHzXRI0MOR1Z7pjTn5gnmB99ikie3hlyVP9
	jvvbU4WpHy++r13qE8lAxaVS9pWciIuG5fE7q+XYMzWcYUvbMmW6FrcOZLCAREKeN60rJWGwmym
	cI2ZJeR9ymY6uFq5jt6fwld4fcB7VRR1trSWwub/u6fE7TdtquYM3aXG4mrBzKJE9TC4vOluOk2
	6ove4Pa6XX9XV6/0aDOnH41YRod0o+JSsE1fClgTWO3kAE2MKxVb215XVFi3J5TdZ/ON90BLz5P
	ceFoOHoO/k0fdWWlOk3VMGWjLgAqYwglOgoe90Ihiw+vYkxH158=
X-Google-Smtp-Source: AGHT+IG8WEiNmKZXmzNssBoH4GEX3aThQEM0prs5cfp8Q/hzNRnZCn6/+Ek9xAgb+mAsNHaVEYgWVQ==
X-Received: by 2002:a05:6e02:3f89:b0:3d3:e284:afbb with SMTP id e9e14a558f8ab-3d441992552mr154286055ab.11.1741619877221;
        Mon, 10 Mar 2025 08:17:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22e050697sm1041501173.78.2025.03.10.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:17:56 -0700 (PDT)
Message-ID: <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk>
Date: Mon, 10 Mar 2025 09:17:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 9:09 AM, Ming Lei wrote:
> On Mon, Mar 3, 2025 at 8:43?PM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> Hello Jens and guys,
>>
>> This patchset fixes several issues(1, 2, 4) and consolidate & improve
>> the tests in the following ways:
>>
>> - support shellcheck and fixes all warning
>>
>> - misc cleanup
>>
>> - improve cleanup code path(module load/unload, cleanup temp files)
>>
>> - help to reuse the same test source code and scripts for other
>>   projects(liburing[1], blktest, ...)
>>
>> - add two stress tests for covering IO workloads vs. removing device &
>> killing ublk server, given buffer lifetime is one big thing for ublk-zc
>>
>>
>> [1] https://github.com/ming1/liburing/commits/ublk-zc
>>
>> - just need one line change for overriding skip_code, libring uses 77 and
>>   kselftests takes 4
> 
> Hi Jens,
> 
> Can you merge this patchset if you are fine?

Yep sorry, was pondering how best to get it staged. Should go into
block, but depends on the other bits that I staged for io_uring. So I'll
just put it there, not a big deal.

-- 
Jens Axboe
