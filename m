Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E933DEC2
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911276; cv=none; b=E8x1pca+lkvQAtnqss0+xBiHASIqtWyc8wDdlH0pJRP+u2rjtUBKfbDDx1sFhdAtvT1ObHJ/TRg4BsJrzNLR/hkWVzVGEGkOOePvC9EzaRISpDs5ns/PIRfOYoyoU56GlXDLdwO88Ku1hzgQZD2aL6hqCPNTU+SQexCsp9+40dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911276; c=relaxed/simple;
	bh=sgobtNriWBbmI/CVsjcrD4JB/7wGTyd5GRUeiuepSxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQJjM6blnLFsxIcNPxU5K44HL62RPfyX9jLrzizoPnxys77OwBdYOlUxuwSJ4aDZDyQYcJCLt3EBjjVzDMfal+79hA7IlM+t+JvqLFgMxWwzq803xS1o4C5VZ1+jntNHnOeA9fRsCw1l+tEu+2OqP35r0tFdT5Yrp7nc7fHRNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3JzWrjOx; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3JzWrjOx"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-450b5338459so3037987b6e.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 10:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765911272; x=1766516072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iw2xY6JQzASC1R9Bed6V09JeLA5frTrl4y7H8Kco4E=;
        b=3JzWrjOxOCjdWv5S1cXJWIN62vL4T7R1ftcGLavj6xtDZDxZMhYHbc/ipJhlDFIBlN
         +5YRge6LmzJsiMUVKwHkxL+JKQsW+RjnKM46xdFWiavycKQUr0IK9f/PdGhN9vDVNBnZ
         EFmccmQvmxDDEPM6ZSDu4SI9jBE2bzlSpJ3wYFZDsMaPVQM6IZ6RK2A8x7Zm3Sa45o0Y
         6HDlNKs66J29Hvoj82pp/hMjMRaWzuyPKGLdUfK5phAg2PZ7DLXIUWrLXWcuU9g+tWN4
         Qk+K4Diu/ySocBpPKA1Fzk5DTMQRvwZCCt2n5bMissilTHEkRtwX9gMNpLBemAK4BtuH
         iTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765911272; x=1766516072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iw2xY6JQzASC1R9Bed6V09JeLA5frTrl4y7H8Kco4E=;
        b=HQheq2SYtYL05ZeGOCzh7VLqCCJ/DVzM4sHqmmKOZN69MZmeDkpy6q0KCW6Wxo65sA
         zHFlg6/uDvHNhSuhylxzigbwH4t61pa1cHbKxecDw4BHVnnbEJwknQnHw9k+7+JtIBUX
         aGI3p8FEFOhDmOs7BbXUcTBL1E1Kz8xAwoS3duFbCTfrO3xyH08wg0Y5dqicl6JY+iNT
         uFqQKMV2pfA6sCqesgLmeC8OIDIGXn7AX7ksSp6KZUyROQcSZpMHysR5zqNfzBxzo+rp
         gzp150ZOPrAnWpIDiyGqwbvbaZGf1N0Z/tt2lwBV5uvdN24Vitna++01MHdIFfPTWA4c
         R/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+RIB6XwzAbb820UeiZkdJnyvbtlWC32STYW48s0m9iRo92yUJ1pTzg16+iauSZtmhN3xYgxsAJDA+5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7zsdj9BTv8Hx5NhAecaz/9cDNMZ9WzGGm9sfxF/7CtZfy47e
	X6b7YtrJjwbkJcDhxV0jrnjdRbvr7uNtcWgDsZfCn3340o/uX3m4RWiZK/mIST+31tQxj+Yle4U
	fW1G9H8HcSA==
X-Gm-Gg: AY/fxX7XBqEaFePE7892ouUlA0zQhaKT2PQJgdbsK4ouLrHNbwcqfcQwmLoAZl4xlqu
	Fn5O+kEj8eeINcYOdNYUgSRuutkMIDJUn7RWXEdMFvYsmglHElKOuQtx6l+UBclP3SYPxxY8vUa
	e4TQk0VToOa5Q1dQuMWb7bpt+G6cGCuUsTsdlCtD7lQAvMonnuqkTiSuMmHQFdIbuzoFsIxCadI
	lroC5WhFMGnOer6wRIuOPgb5F6QS1JwFPX1BWkbnjBET/janT1jwZN5cLVDvJIFP21dq/ZtjHq5
	CKbhA9t0lvsTywQIab0tP2oqHPI8OrCLVNhUSEbi8j9P9qT5/k2KAadP7LMtCiCCCJUmHBZbvXk
	M1m+qAXEHNff9SeE61vwFL0cfBB7tY8CjcEh1ByqZzqsVNz1oGzHKJbH4aqeOmXaBFO6uguEKCr
	xCOagyLgw=
X-Google-Smtp-Source: AGHT+IFPg0Br16etay3tCJOJnOVZ6iuOsWjdFdhNTD9nNZ31cHvdTDMftoR+8m4fheCbHLZ9JtH9FA==
X-Received: by 2002:a05:6808:c1e9:b0:450:ae23:54f8 with SMTP id 5614622812f47-455ac8721f9mr6756020b6e.19.1765911272568;
        Tue, 16 Dec 2025 10:54:32 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598b46bf4sm1832321b6e.5.2025.12.16.10.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 10:54:31 -0800 (PST)
Message-ID: <4929c371-b264-4049-8618-095f748ef5c9@kernel.dk>
Date: Tue, 16 Dec 2025 11:54:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
To: Johannes Weiner <hannes@cmpxchg.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org> <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org> <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251216185201.GH905277@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 11:52 AM, Johannes Weiner wrote:
> On Mon, Dec 15, 2025 at 11:41:07PM -0800, Christoph Hellwig wrote:
>> On Mon, Dec 15, 2025 at 03:08:38PM -0500, Johannes Weiner wrote:
>>> Debated whether to add some sort of deprecation sysctl handler, but at
>>> least systemd-sysctl just prints a warning and still applies other
>>> settings from the same config file.
>>
>> In general dropping sysctl will break things.  So I think we'll need
>> a stub, at which point it might as well warn for a while.
> 
> Fair enough, I added that.
> 
> Jens, that change seemed small enough that I carried your Ack, but
> please let me know if you feel otherwise ;)

That's fine, fwiw I fully agree with that change.

-- 
Jens Axboe

