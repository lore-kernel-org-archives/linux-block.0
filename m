Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2A1E7C16
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268827; cv=none; b=tIf3/wDLMHnUzclzlin4GyVMP+RMMJF+KA2FhNyfU9GPst3IA4FoZSxQGKla0LPLKYUaRMPYas4OF7xpZEEBGo7MoGfrKheqMsJVSR74vTAPPxb9ncGRjnKl89u3AwM9SJrao5GJ6hcYThNUifWE54ZplfQ66fyBYG9u7EzcTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268827; c=relaxed/simple;
	bh=uLBwTqXQoexLBnNCz3Cg0anWoUKCBqdw1G0JK1RAZvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIAuvk8t3r2+0qk4JZstYcq9BRPpT3koGMyHAg+dcu6gdLXl6q+i/kCBsHIiQak5ERJPZ+1cyvrNo8Jw1nbMeugoGfBiIoEkn7OgTMH3w1iEPgQPJQSHHhqZnvAE1rdH9HlZHjqLT9y8OUm2WT2NEplwC8j7bw1jYK6KAc6wnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gb1Xxx4D; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gb1Xxx4D"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85e73562577so421057439f.0
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745268824; x=1745873624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGyMbdplm0VqgEXwZTM797av09Qdwt4xl1Ent3Qyi/Y=;
        b=gb1Xxx4D8q8NyHuFASShNuNqJCqeKAmrIB7Bvq6UzIwLzy/XDeJNgAPmybc4v7gkgH
         MpfTDiLRmHGH+ij9xc5znd4UNCihciQXk3qRcZXeMv3PhHWpFGMtsM3YlvUdRAZfAh1C
         VqSPN6s2ymV5jX/fRd31vv4MzIaSu8S+jHsYpw50QqdNGO7ygfBuqTikdzjXIBisjtKo
         5nVm5rElL5pFGdbfbKc6N1t6If155AUlHhhM3KzDuGvuFMkgOhV26P5xg7Rs6K10yZhS
         vublx3V7Vm0Yg3qXA3+pUaTKW2y9JBiniBmSKKLfqoRuIlHHpuD/Ysc98PZg79kQcEMA
         5uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745268824; x=1745873624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGyMbdplm0VqgEXwZTM797av09Qdwt4xl1Ent3Qyi/Y=;
        b=Wdjnnn1GQYI0i5IVeArxstPbir7ZgQT6dohYE6YRca/V0PJHvd/b+bOgdttBoDuqDh
         078BPN6CYqWrGljbOOaCryHrOSkKAxLrkNz+5T8RMbpcfNVEuoq+27r0XHw8eNMy3ynC
         8hOT7id35LUvCH37aHXfG56VRdaqIVS82P2Vb6n1pWWNZvM+VlE6SA6DhV39dlou71bz
         TgpeE/0n5lcFw2Y/nDpBY7dxJH9pW4fi0spwpHvNNwujCIej9DavtO11f/D67Yo+ymOs
         +84iM+GUud8KTNQo8cjq5/bz1OECXcc+L1B7Y+YeRfr10GodnYtpkOiiUUkL2IY+l2Xw
         dNoA==
X-Forwarded-Encrypted: i=1; AJvYcCWu06mXmPYawzsRLsqxXAu4/6MSRscNlEqpg8oCS5UNBNhURpU0Vv8kRyxGVbK/ivTnEewThk5ph+o+OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUHinYM5Lq7CiDEWD0GnrW25Qb7m1sYSE7puObwVlgYX9IJC9
	/6DFTYZsXdI6oyCxlTFTXkYf0V8xV2qY2bZJsppWRojfDMpQ6FH2QMd7R1qILnw=
X-Gm-Gg: ASbGncvgFco/772W40xR/Ym+wRy8P1ch/puD78jfOA2U323Ghsf4WDq6U4sSHEi8/+b
	LJRnraf1gT53ozNgCMKjtw4JQesNPpLbN+yvTVpIzVQfq2OKBut8bKhQavQO5XJdBEYwhe9AIt8
	d7c2yILKAya6XMOKgtl8/Z8Egjx/pI7Vn+aFvMMVPtJq/xsYXYNMkoHY58mzb2WsxNSI+WlBU+5
	r51rnWm7N5Gf/0qp8PaWne4mzTGRE1xnu6tMje/nyafgM5AWjitU5b62aP2NpFT80lFnn+36WEM
	f6lA68dRng/W2xpYMfoi10ApkuUD0no/s4GaPQ9TdfIfzxY=
X-Google-Smtp-Source: AGHT+IHvDgGfgDUOOapB200WZpV48HaZ8dVbhYH++As1bmXpZNufg6G1tVLq51Z1vXwqN7Cc8UQGrQ==
X-Received: by 2002:a05:6e02:3002:b0:3d8:20a3:5603 with SMTP id e9e14a558f8ab-3d88eda87bfmr139248725ab.2.1745268823944;
        Mon, 21 Apr 2025 13:53:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d1d700sm19572275ab.12.2025.04.21.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:53:43 -0700 (PDT)
Message-ID: <c6bcce15-647c-4de8-aa01-6cd3ec5bf904@kernel.dk>
Date: Mon, 21 Apr 2025 14:53:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, shinichiro.kawasaki@wdc.com,
 linux-mm@kvack.org, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org, hch@infradead.org,
 linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
 <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
 <20250421205116.GF25700@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250421205116.GF25700@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 2:51 PM, Darrick J. Wong wrote:
> On Mon, Apr 21, 2025 at 02:26:54PM -0600, Jens Axboe wrote:
>> On 4/21/25 2:24 PM, Jens Axboe wrote:
>>> On 4/21/25 11:18 AM, Darrick J. Wong wrote:
>>>> Hi all,
>>>>
>>>> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
>>>> between set_blocksize and block device pagecache manipulation; the rest
>>>> removes XFS' usage of set_blocksize since it's unnecessary.
>>>>
>>>> If you're going to start using this code, I strongly recommend pulling
>>>> from my git trees, which are linked below.
>>>>
>>>> With a bit of luck, this should all go splendidly.
>>>> Comments and questions are, as always, welcome.
>>>
>>> block changes look good to me - I'll tentatively queue those up.
>>
>> Hmm looks like it's built on top of other changes in your branch,
>> doesn't apply cleanly.
> 
> Yeah, I'm still waiting for hch (or anyone) to RVB patches 2 and 3.

Maybe I wasn't 100% clear, but what I mean is that patches 1 and 2 don't
apply to the upstream kernel, as they are sitting on top of other
patches that block block/bdev.c in your tree. So even if acked, they
can't go in as-is. Well they can, I'd just have to hand apply them.
Which isn't the end of the world, but the dependency wasn't clear (to
me, at least) in the sent out patches.

-- 
Jens Axboe
