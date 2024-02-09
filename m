Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299716410
	for <linux-block@vger.kernel.org>; Fri,  9 Feb 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512768; cv=none; b=XG0oI5kMgfv6nA+wlh7mh1HMALnSsiA4sTp6GXOjkZPKj0GqOJKYnPOT67rRoFvQX5OBC/hPe0AmBGXagGRdSDI8S0hqT+6P6YHRtK/MTVwF3/4jffbpMnHGXpBq51m/AEK9kdejDROvnp4x+DahBVoO2FGDBg8VOiN4hNuezyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512768; c=relaxed/simple;
	bh=UO1A3Fct17+/hJd8or2MUtzr0RTkRI4EFJgLeSzlNSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVVlZVx2U6N+0IG0NvgK8S8om2EqKNq19lnP/+Zsau+n2NuK+PpB66L8/caR470asynvel17hw5au5vPRVIHfvnR8wf1XlW8wm1h15JT1Q3xpq4+tWZ+f8hMv+w25tCnLDRsM5yJ4aW6le1Mm1goIxdURPGjAp8iv98zExfmqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G59mhzld; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G59mhzld"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so13698539f.0
        for <linux-block@vger.kernel.org>; Fri, 09 Feb 2024 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707512765; x=1708117565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TX8kZJ4jfhuvDuckYH8MKVN4C0WBzbq4xbrMJJT/w90=;
        b=G59mhzldhT80ykhotACpYyYb+Y8E2GiYInZvA60j84FDmrs7AJHxQO2O0xv2STrdJT
         itL5cQzybxEIzfVASXU1ivYuMGuYJDkm5NOpQk6FI3Os0Agpy8/cDG4iKbwEWoR5nsXT
         KR2ikz5DWEfZvXQ3l/Otl0ZNlwXkF31Q+xjQG6IOxCb5OV3WUk6kvz992VVMOGjNpBTR
         O36kkxvMHbnjTROqQNHNr4SxwIYg/k0ecmgDHy5D0HBjcr6i4+sRTVB58onLHgis3EfF
         7u5jKp682BF79733gMvSeiZ/MsVvnUSMw2+iQWhMBZWtK5YLQnL0Y+sLWBTMFEA4OH8N
         uYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512765; x=1708117565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TX8kZJ4jfhuvDuckYH8MKVN4C0WBzbq4xbrMJJT/w90=;
        b=dI52seVBxDLRhExXz4R7aiNKnudGh547kPAXj04smjws7NgRbSpUwXwBOYSFVBIUlT
         Ijickxbbj8ARzIoDMZJYs/F1S3ibkhf4Zn5uITqjQhoR7zAbZkkr1x6QZVb1tQFj8eB+
         uK6DegZpR24gk+vV3iIPp9Fi+vaqDSoFozdXAetYMfCzywX8n2gLkQuh6o0+xvdmUKzM
         8UPovNXuIJBB947Ej6A7fV5CJ4ftf5RHwkiG5aqbCVW+4bGmrg5DID9rDhLrEX8lviz8
         7om34oULcWZaH2t4MfxOjJ+f1PJWyMud1CrbA91xgtUwjcsL+f0OsCuU2aoynHJ/oUE5
         mwGg==
X-Forwarded-Encrypted: i=1; AJvYcCUaLb1P5bfX5F15k1P1EJcowydwziImYXK1BIP5K403IMJkhQfwuZVhWZ8+KeNnKtSGvtWjoPqBdfbH6+5bAksyBtXqv8MyY/OS+7k=
X-Gm-Message-State: AOJu0Yz09zGagFne7sZQ6eMUAMV6lH0PDrDJoZUfnFd2B6wjXld0lquG
	acFG+9zGfpvrAU7nvawKcEatL5zFZvcLgn2s3FXoWoF+KGnpa9hxNXCJMZw+Mp4=
X-Google-Smtp-Source: AGHT+IG95+JDEa+gHhRbNQy0UP1KGGwCed76qGySgxKJ2T/oR18AoeRQqXBNBZUT4wqRzIG9cGuscA==
X-Received: by 2002:a6b:3f08:0:b0:7c4:655:6e05 with SMTP id m8-20020a6b3f08000000b007c406556e05mr514508ioa.2.1707512765133;
        Fri, 09 Feb 2024 13:06:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW07vEn8HZ60Z4H7r5mCWcnVCXKNpcE4FhapsNAyty8vDlL29suKKWuje2252Pawcm034h3sOQ4+Tj7plSU2eol0G+VMUvqLgMSuJtL89jsB3LjjXv7kfgFSjufmRFudTbgNgkiAIKKWWmqhzxJJzXco18yKIUFwR9cfrMP9M0rSOPp1mHDdsU3J1vdpvucWbdzRidA5/V3DaCIpvSBZqaTeObWpGytGSRNcVYpqAIcD6EatbetMt6LKYQKIZAmvFXc78Ou9dT/tJtMfQG4417ma38ogHxJ/WMxLl8xWJwPJeMSQas5CabR+fitrHREYBuUdpeJdnezXwHP
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n8-20020a02a908000000b0047153f09f83sm62054jam.13.2024.02.09.13.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:06:04 -0800 (PST)
Message-ID: <35989f82-3c6b-4c91-ae9b-db8791895b19@kernel.dk>
Date: Fri, 9 Feb 2024 14:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [block/mq] 574e7779cf: fio.write_iops -72.9%
 regression
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-block@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com
References: <202401312320.a335db14-oliver.sang@intel.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202401312320.a335db14-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 8:42 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -72.9% regression of fio.write_iops on:
> 
> 
> commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: fio-basic
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	runtime: 300s
> 	disk: 1HDD
> 	fs: xfs
> 	nr_task: 100%
> 	test_size: 128G
> 	rw: write
> 	bs: 4k
> 	ioengine: io_uring
> 	direct: direct
> 	cpufreq_governor: performance

I looked into this, and I think I see what is happening. We do still do
insertion merges, but it's now postponed to dispatch time. This means
that for this crazy case, where you have 64 threads doing sequential
writes, we run out of tags (which is 64 by default) and hence dispatch
sooner than we would've before. Before, we would've queued one request,
then allocated a new one, and queued that. When that queue event
happened, we would merge with the previous - either upfront, or when the
request is inserted. In any case, we now have 1 bigger request, rather
than two smaller ones that still need merging.

This leaves more requests free.

I think we can solve this by doing smarter merging at insertion time.
I've dropped the series from my for-next branch for now, will need
revisiting and then I'll post it again.

-- 
Jens Axboe

