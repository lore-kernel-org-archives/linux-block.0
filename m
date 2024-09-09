Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E1BAEDE
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893508; cv=none; b=VuxkLSb2S7TDLnxNXjZ4bb1g44MPVbZeh29monhr8YgKnkW55y3QcqvI7GfrBK+CB5OkQEvNX281GRlBa1Y/V1N2ewGOsfE3UVuQaUKAGMLE/z/kOA+hSiHsaChJ6jeKEEc+W8rC929Ayj6YhW+G1aVSHAaiq5LpUzIupRRyb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893508; c=relaxed/simple;
	bh=+cJBG1upvR+F3tYffdvhWbT1y7mKiym6WyRY+g0v8zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZijK85GZs30Ae1qZZ698T6/LXwY5iaivRkmKI2MhFyJ6k6mSmenB1iboQ+zWoFh9PM0cdnYYh98L8XhFIghUj2MzoXg8rSLc0+8agFQfLfMgqlFUUJw2sj11nQ3cZFocHiceK+QIEveQ+DXTlGCJ+BjzceDcgI4k/3qYV6yySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cnudllxz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cnudllxz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2840932a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725893505; x=1726498305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9rWAsIGzZ6u/QYJf5tnAdUimUu+PCvUeW7OogHaSuI=;
        b=cnudllxzOE8KL2lqOQmdQyS6HH8YpiuIX1rNf24tMN4nWHPT3h7UbwZNz1W+YbKdE7
         0YGmn5r4pRfhz/B3Z/KrvZiNBNoI+VutLAZmg45zOcjO3hMlQ2sAYHGdp0ETItoxUD5E
         HQAAu2XNTseXSGizMdTJygudXccn67OvyrSFaW3aon6yfHOfluU+vJDmpsUV1O8J96Ry
         wWULQYbY1u3Oezm8SeoB7Bfltk4kEkyz3WoK4j/3p3JXqI62eZFr6YSg4rI7RXdmuZnb
         5SZWZxcFVyxAA+mVy7kHw9lK+gJr/Dltfpr81AR5uzR0LK5wB8oaKuf+swArwDTR7r8P
         gWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893505; x=1726498305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9rWAsIGzZ6u/QYJf5tnAdUimUu+PCvUeW7OogHaSuI=;
        b=MqXCrcW1NUnMvFGNqGXmFnjcwWu+cP2EfpJBg7s6JiztllUHGUfEE0f1yImKOmZtau
         2JtrOsRQnndTKyDpRUJ13xiPijKptMmOm0EdX5xOb/Lg3pMFpaKhMn4rPfvKJnYeJb7y
         LCDK7QB+GZJFAL8AmLfwXM1XMfozKC53e2zJUc0SUd/Qyp6IRozh7Pz+SoCsQh0pu9pS
         D394Xema28iOqCJu+XdHdBQG0UzF8RUawhs0zSjFwIPFN0IKQBcZzDNb9o41B9qZYRcT
         tX21gdkRIIt8sFpPiK6fRteVMzMFPJf/UoihcQmTdA7cq9HYSKcTEq40D3jRMzIlhqeZ
         anAA==
X-Forwarded-Encrypted: i=1; AJvYcCVleDSxrgmpfDBsUq/2jkGhpTYTf+pmcbf+HOqb3WRpzDyqNuOnnLNE0fLbZnzjGbyRe8+FMCbl6zHuTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gaDcw3ls807dx0DkvGvJu0Jg7jvVjLkoXdUVlZb8HCZxoDgB
	4VPmpFDfZGSBY6ushzPI9Gzh/UOI6Yi4AzKHi7YdriXSokVVsVr+ltBGBJcmGyw=
X-Google-Smtp-Source: AGHT+IGXmoYoNnbLnmlnvdjNnKtCotyC6KrIkej+yws/iMo0+HjJYgBJ0A65h3AE+feie3K02nBLtw==
X-Received: by 2002:a05:6a20:891e:b0:1cf:2939:a0de with SMTP id adf61e73a8af0-1cf2939a1e8mr5746386637.14.1725893505231;
        Mon, 09 Sep 2024 07:51:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f31235sm34960025ad.253.2024.09.09.07.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 07:51:44 -0700 (PDT)
Message-ID: <29245c2e-d536-4a98-88ed-d1757795b3cd@kernel.dk>
Date: Mon, 9 Sep 2024 08:51:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] implement async block discards and other ops via
 io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
References: <cover.1725621577.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1725621577.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 4:57 PM, Pavel Begunkov wrote:
> There is an interest in having asynchronous block operations like
> discard and write zeroes. The series implements that as io_uring commands,
> which is an io_uring request type allowing to implement custom file
> specific operations.
> 
> First 4 are preparation patches. Patch 5 introduces the main chunk of
> cmd infrastructure and discard commands. Patches 6-8 implement
> write zeroes variants.

Sitting in for-6.12/io_uring-discard for now, as there's a hidden
dependency with the end/len patch in for-6.12/block.

Ran a quick test - have 64 4k discards inflight. Here's the current
performance, with 64 threads with sync discard:

qd64 sync discard: 21K IOPS, lat avg 3 msec (max 21 msec)

and using io_uring with async discard, otherwise same test case:

qd64 async discard: 76K IOPS, lat avg 845 usec (max 2.2 msec)

If we switch to doing 1M discards, then we get:

qd64 sync discard: 14K IOPS, lat avg 5 msec (max 25 msec)

and using io_uring with async discard, otherwise same test case:

qd64 async discard: 56K IOPS, lat avg 1153 usec (max 3.6 msec)

This is on a:

Samsung Electronics Co Ltd NVMe SSD Controller PM174X

nvme device. It doesn't have the fastest discard, but still nicely shows
the improvement over a purely sync discard.

-- 
Jens Axboe

