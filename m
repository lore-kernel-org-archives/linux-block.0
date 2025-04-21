Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECE801
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267218; cv=none; b=EBurfdwYj20haMoDtFu8nr3no/8WqrRAgqUcKk5cCquRdyelOVUdWOuDcK1GMXNM1S3Ovf1uaFnu8KrIAxh9lLMP23fOlCSBPSDaGwOLOiUmCdMrJslSbA4GAUD8GGS6WAjM4we6eMeAKJMkVqVAxC+CbG5oDoArUGEH4CuHqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267218; c=relaxed/simple;
	bh=0Il5DIxkHUlQAJ02+NZuaa0zOFehAsnBIIGXY+F0YoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c7V0Ol8cYzoIKXnCL+wWuJGpCRKR03DsdgP4GSyECnN7bheQc/Grb1Q3Yq+bb5hvxsCKsUWgC+mnpwW118Y2KaekvH5bPIQxVWPQgANFcVKAJ930H75KCNfXgcWzZOC7UleQcNF/WiL9AztOwx5QIYa4MxeWh7IvaI5UqlKcb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=prawIjD1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="prawIjD1"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85da5a3667bso102133939f.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745267216; x=1745872016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27BMHCOECTISQknfVB21+aP50fShNvTjKGAStee4Ri8=;
        b=prawIjD1QVwewF3haWXcCJzV1SNsDVPJgLXIJOmBmF6upuJ9LBSqTFJuMGvY7ngfkf
         +cpMFn7WCUzE0maX5kY9ty3gnowQgAhZG8LMi8//9YoDnBdaOM31m20QwzOItkrsxe/l
         OlwjFi1NR+uXI9k5NRWRZsqXSqyhZUyMsdLcThubgZvPT9dh7C8Uw6LED6fOQhw1FtfM
         j6joe5ZRRHUdTAa7l+BXeiQ+qPapIf52AB1I1njrpZ2CbpA15dcHk3y67gAIYiLbi27Q
         xOw6Lkw9bS4/eGGUZUGaDQQ0VonLtwuJw7IM5mCnAQ8Q5Sdp2aqWX2bybNwwh7PnsxLl
         UYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745267216; x=1745872016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27BMHCOECTISQknfVB21+aP50fShNvTjKGAStee4Ri8=;
        b=rWqB4mxY3LjDyI/U9WVO9G3nICQluM4E6OTTZ1SRtyiUQeB+tHoFXo5JzgMfWwc9YS
         mYoRVcFp8IbzsxS5VgVIpQL6YnPM+xg1IO5ohU8Ko/gZdGpVW4rkQ6ded9MSXLbQimil
         01zsH9wgznI5cRNJqOsPtHOJaevDYMbqaiK+gNbXR4FW0hLoDlJic1LFMN9CtjjpIL/F
         rK6SeFTh+SVKuOntzQ8DjfX1sr+YtUamS0q1+dBs62Z2r4zb+PUcAcUqvwH771rIEsl6
         MfhcPZusmT118UCg1XjjU9l0SBD4MIfY2nFmlPJlhDkIuyY6I8rBFFuBQPDEsQl6aTId
         9t0A==
X-Forwarded-Encrypted: i=1; AJvYcCXuCRbcs+HtjFwgrb1pmhr2VJpSTmMdBI42KcexXYVCLkqNpLxANSlEPF0SGG56cC8VJMbaloHqx199lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjQfimwu4skleLUY+nP3EGCqZgOL/vQ2PpN9ZrHisy9ajd4ur
	4d9+z9l/UvDhzYYWQHpzY2IAG4EH/gbkpeBaQ8JzIyHUEUnYHBBdyXnziASNmsGIyZCh0nQ9Dba
	t
X-Gm-Gg: ASbGncvswXRYFAuW3PFs4qCr9G96xSAaXQ1tkmj2dR7XHm2fJAnoIwkKcN4H492gSfA
	32lVV9R8G/1Ybv7PlrB6iV/Q07AMw6F5e1nUnGPtdj0blu6e5EXHxaNX7kDLap4nHj0axtjOCAk
	bRKB6/aKJ/NhLarNmwm0+qkY/aa2a31mTh/iapTwWD25TL++ldO5S6jpvjFG+FmNZuJeWsChjMs
	FTjGTiKebyTjrIe0TnUDQzUxpXUj8bcab0P7nDNLYMyodRn5iASSVZvG8GlOtrzldkx0XdWs65f
	CsQ9RgJMsryt1yng6FekftqlWUWz78B29lD7
X-Google-Smtp-Source: AGHT+IE7KKLn+SFyCY+1IEN5a7afRu8xJmsf5Z2+0F8SZS3ynBRzsQqJHYmOIZ2M/pTqQteS9q/67Q==
X-Received: by 2002:a6b:f106:0:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-861dbdfa62emr897863439f.5.1745267216383;
        Mon, 21 Apr 2025 13:26:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3933d67sm1928559173.86.2025.04.21.13.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:26:55 -0700 (PDT)
Message-ID: <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
Date: Mon, 21 Apr 2025 14:26:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
From: Jens Axboe <axboe@kernel.dk>
To: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org
Cc: hch@lst.de, shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Content-Language: en-US
In-Reply-To: <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 2:24 PM, Jens Axboe wrote:
> On 4/21/25 11:18 AM, Darrick J. Wong wrote:
>> Hi all,
>>
>> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
>> between set_blocksize and block device pagecache manipulation; the rest
>> removes XFS' usage of set_blocksize since it's unnecessary.
>>
>> If you're going to start using this code, I strongly recommend pulling
>> from my git trees, which are linked below.
>>
>> With a bit of luck, this should all go splendidly.
>> Comments and questions are, as always, welcome.
> 
> block changes look good to me - I'll tentatively queue those up.

Hmm looks like it's built on top of other changes in your branch,
doesn't apply cleanly.

-- 
Jens Axboe
