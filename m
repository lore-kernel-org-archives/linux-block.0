Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB61B2EF2
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078440; cv=none; b=kI/WkaOBvUHQ1bzXG566uOSEuv1TNOAqHx73u+M5B+3WpPLkNItjck6QaKRHs4tP9hBii8SUHk4YzLTMLrZXoUwTa83vFcCh3tdrfTw+Kw31DQzI/VSg1P+loZwiDr8648eOr9ITsjkGREdsTSVDFdqfn6E0Oea2p2ExDEcoyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078440; c=relaxed/simple;
	bh=jlIiq8XF36Q5tjUAtZm/LyBhvHksPJzd7zM157cXZ6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suLz83L0UEsOYl3DrjTDaivFH6tNuvPHG4DIqNZeLK8ROky0ilqS0euuFEvrZ3Fgru4k7qd3kEdZdOFXonmxM5nGB1d8zR6WT3jnddekTt1CphqBnKie4qgr31r6YGCbDHkZh7cVZCi7zM7CPWmDsi5XukAznDUm8JH+HQ8EWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v6rkoDzP; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v6rkoDzP"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8521df70be6so357389639f.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738078436; x=1738683236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6an6bUbxEkbIyN7QVIDWH3rFKz7RNe6o1iTmjpRuPFk=;
        b=v6rkoDzPS8mKKQOImsBsw26YxTg/OxiWjxbga24O7y6mM2RNO68T9kI1KXy9DJ+2uB
         afrpvSaUY7jjlmx3lko4Qk8rVgrylrn4fxChdeM3dsWRLra0aFErgH8cS7eYzgXOl9UD
         G9XqQ1uWI5d0JwHVNzGWiSn7PoN/o713y/9a5W1khqDCWHdk2dJ1UBQ8cKsC5kzqCAs0
         0QbuhOkynv/JbKJbOlQwKlK1YUAZx+mtfRGdm+spd/mr61or92iW3U1KjzJV7OQGDO28
         3UJtImI/ellYH938rd1ri7INCc7KoQilG0VpDWPQvQ4WSkWIeMRKw7KV08/8DOxgxT4U
         F0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738078436; x=1738683236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6an6bUbxEkbIyN7QVIDWH3rFKz7RNe6o1iTmjpRuPFk=;
        b=TMXVpp8dvT4gCXT0P9412CsYGxfO023NJMK1s48ISnXo9cNVUjUHXAD54hnS67oSii
         hPf5WU4pYIvrWZxndUT6tuwW6fZIHb6NV2u41rF1fSNWAhvJ4XvEqWhkYbV/MVyQWpyn
         R5DFXvhPOf6wnZLS/7dM12RH7SSbowlFUn69wEelH7KWOgCQDmEceAbobd+yla8hLmsd
         IQjQXDjBzppZdzupEV0DefTgislQVcM08a4YsO2LGNAaRe5Uq8DjLTG1JOvshhP02nZZ
         jXjgqTUq+q9Y73eyzoikCopU8g9ynKr7pbFzeH8qerSj+edDKsQQESSqD1Vj1noJPbkp
         9apw==
X-Gm-Message-State: AOJu0YxKk54rhlnyeDyGY4eoT2im5RLmTYNBEzE1EI0WX2mxXEyxY7d2
	Y8QDPwvnZPoaR7oNcnbItFp5bQa3wYfZ0fYcXaa1eEjwnAlJ0Z5wk9Qz19ihfRGYAgh8R89diQE
	g
X-Gm-Gg: ASbGncuaO8q98LloLMtQJEH9RStYpS5u8/mOfmuJeGUQkHU/2qoa3iFIQo765BJsUo9
	mZGQ1UuhGgBKUJhk29TVHPJBL8+/o4bSjnayx0q4ZnWtRSGfJnTkfkWouIWMj7ekPRgGC7vUqqK
	3HftBDq473FGeGeyrduj8tCDnpsdMh09k+MRA2nhscbZ7HwT1A9I4rNKqwTMk9OkvEcLm0M4HFg
	NrALc1Z/1QS0JeM93hUVOrePF4vL7FObzxlhbKQjJo0ovv/SXXvKgMyI1EXFKEStnY0ob32rfyU
	7tM6W6ag3J0=
X-Google-Smtp-Source: AGHT+IE95pvUCCkoINhOtmHAQ0ZLhG1Z9CEatZ3MOkTDY6mhSqW46j/jW5fgO4MJF1ysUHzcGwKhxQ==
X-Received: by 2002:a05:6602:6c1a:b0:844:e06e:53c5 with SMTP id ca18e2360f4ac-851b61d5ea2mr3918405139f.8.1738078435999;
        Tue, 28 Jan 2025 07:33:55 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521e013fe9sm332604039f.35.2025.01.28.07.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 07:33:55 -0800 (PST)
Message-ID: <61f2f171-f688-404e-82bd-b064c579dbab@kernel.dk>
Date: Tue, 28 Jan 2025 08:33:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't revert iter for -EIOCBQUEUED
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <47af5107-96fb-426c-961e-25d464f3b26b@kernel.dk>
 <Z5hyKbWbEEcxV8fg@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z5hyKbWbEEcxV8fg@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 10:59 PM, Christoph Hellwig wrote:
> On Thu, Jan 23, 2025 at 06:18:01AM -0700, Jens Axboe wrote:
>> blkdev_read_iter() has a few odd checks, like gating the position and
>> count adjustment on whether or not the result is bigger-than-or-equal to
>> zero (where bigger than makes more sense), and not checking the return
>> value of blkdev_direct_IO() before doing an iov_iter_revert(). The
>> latter can lead to attempting to revert with a negative value, which
>> when passed to iov_iter_revert() as an unsigned value will lead to
>> throwing a WARN_ON() because unroll is bigger than MAX_RW_COUNT.
> 
> How did you reproduce that?  Can we add it to blktests?

Via one of the io_uring test cases, when used on a SCSI device. Not
easy to write a reliable reproducer for this, and honestly I'm kind
of puzzled I haven't hit it before recently.

-- 
Jens Axboe

