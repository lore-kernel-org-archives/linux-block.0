Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE115B10A
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263267; cv=none; b=OWwGeVvlE8sFDhqK8e5HmGbOiykRluEEgzmqogYc1INzfvfOrEjgUoVnBo7osFJs10fnGJTDD52Sewj0ndr+gsanlyfPjBI4lnEC+h4AWZZGAuD6ciiwWRW3WaWOOoUWeljuYFJVgrT8oyZv9hI9ZPSLvNtJEi1lkIRkReTGcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263267; c=relaxed/simple;
	bh=vJyd4tZjdF3D2ZrohojCjbDLETIh4TZF4vHzSFgmHB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+t1nobzQh95l5p56Xudu9RvInN6PQvKet01QjcA57Ljs1QF1hEE6HZyMgVbIVCNttsQtQh/ExL9opt1eHcahbgKwkQdyQLr9zf3pzTqstX0g13/vwrDkOl+/HbikRLKCnrnynu+TUoxhilx41JgTHhCn+1bX2TNv3lDTHPqxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ao6iTfb2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ao6iTfb2"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36c2cf463e3so792195ab.3
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715263261; x=1715868061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMu/YVgiEUlqbf9dByBBbXYvCkFNqwHO8YQxlovUoDU=;
        b=ao6iTfb2zJwoM8UGLmyNRXPh3ddnjwf3yNuqRmDYB9Kx0l+yRKR+jpCKVMlIic9gl+
         kGASKvSab2m6ZG1XPRFT4LWVa1Lk/sOjlP3fpeIQ17mi8FQ8wvjExVBu0LRngapr2euH
         tNu6okqqhAZaotHlEmpLHI/V7LZYUThazubeyq5nh0knN5fB4eCDYalSYP3RnIsQq5nj
         YIRr9kXP8GzLRKzYJwZffsqQFnGlJ8kIE+u3B0ekGuR0OknBt6Nqf66GhCV22ZPYVOgn
         jpfPzgYTJQWhHrYgIUGJVMjubnD3SNiQxArBA8XfVHZ9Rzz0aF/G1bneulqzmPCynvXs
         pHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263261; x=1715868061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMu/YVgiEUlqbf9dByBBbXYvCkFNqwHO8YQxlovUoDU=;
        b=knqQjRW1l25T8rWgRKEiK9ZNjdh1OPTAVtQKC4gEzIt8xj/f4WGXDVHDbBTVBnhKsf
         1tE2HjsEj/uuplsMKxCo8HcBFEDMWkJCSUajQymv+b2UUmJyiGe2bY/+QoELUImbpeCu
         O9pf7vZzkcnch8122Sg3sf3mx1YVFufvZ4NA/hioQEsD+Sj1R4GultCJsv+KCUkHcG75
         Zk5H3fjI8wVF8OHla5bifs+J6MEGDpb5+RQpvBQA34snet/c6dUSjdx4LhAluQx2b7ga
         oPml8G9AbEmeOwST7wGOrpujHz78hPdlBWxPEg+qP19SnStyEUAhmZYuoOHoIMaAdqVR
         5esw==
X-Gm-Message-State: AOJu0Ywo2q/aFnRSri9SiBvZt/V1QJ0mmDPHtqdIgmPY3X1NZzfN3bWd
	UuPAxRNfRmXIJoLyyKrycEagY72VTJvYWH1g4vHHVA5dT+73zqAI97YsCcUEywrdUETyMH/DAyb
	F
X-Google-Smtp-Source: AGHT+IEVlLRufILZ3sfZWMAjKB8CgJrl3rQR+dc5JncUv5VJU/OCE2wNyiwHr5/mz2f/HcA8M+McKg==
X-Received: by 2002:a5e:8341:0:b0:7de:e495:42bf with SMTP id ca18e2360f4ac-7e18fd8586bmr521945839f.1.1715263260934;
        Thu, 09 May 2024 07:01:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1a881da7csm30151439f.22.2024.05.09.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 07:01:00 -0700 (PDT)
Message-ID: <e2181429-3f0b-4999-87b7-8fbc8aea3765@kernel.dk>
Date: Thu, 9 May 2024 08:00:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
 <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
 <20240509125856.GB12191@lst.de>
 <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 7:50 AM, John Garry wrote:
> On 09/05/2024 13:58, Christoph Hellwig wrote:
>>> A reminder on this one.
>>>
>>> I can send a patch if you like.
>> Yes, please.
> 
> ok, fine.
> 
> But, uggh, now I see more C=1 warnings on Jens' 6.9 branch. It's quite
> late to be sending fixes for those (for 6.9)...
> 
> I'll send then anyway.

Send it for 6.10.

-- 
Jens Axboe

