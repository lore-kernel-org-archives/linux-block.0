Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F47156880
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699700; cv=none; b=sEaNxkGs14KcFM7E4aK6/4KZrAzSEqAQhjfG2ATrO+usBPVy8t805Jw7fukEIlw017CdeE8oV/5zDh8z3S7wT82Y8+cMi17TiPN4aDAPu/TAmjDytLxMTS2x3ne62IKX7qJYvoz9WilIHsaO9k1kEahiy9d8dP3/3GfvFNbKreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699700; c=relaxed/simple;
	bh=8by/GpPmqkVACM2ONGL1pBGZdfM4i23E95LC6lf9vOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFxs045TejmqVskpXm3X45jWVxbsyCKd8CVts5BOGK3UwZ9WQzE8paa6shEwjBsjOkCZ6PVUwu2xvc9Mam33bjkPqiVmYSlsgPk/3PlnHu/e4kw1c/cmZUWBPqd15nPx1e2DJo46d8EYdIxKf4rEKviOrX3yPEFlXGTjwz8Ev0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MpKbnLeS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MpKbnLeS"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85ae131983eso384782339f.0
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741699695; x=1742304495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXEFQQJ7zeYMoU7AeoXlfPbZ3jDP+PoYlgP38jKDBC0=;
        b=MpKbnLeSlyGkXAIN6tpQSIPZ37FJLRmVwmx+81uNp8K6jUK4FAKlUuBHyPlzVE/1Bm
         bJj3taAngxOqJf5MXLoNu0HL+1bw/QvbAONh4jyra7hWnFhu0b2YrrACh7sCTcMP/1z3
         7+4fMrE1kf5rYLTjiXj6Z4za27eOO86tE0lvqkPg8TzRG0l/YExW9jS5uj/NptpDIvkN
         uyAAQusoEVqNu//p7lCz5n4fWM+SRAnLV0dCk7KI3rnWbnEw27/UcitjnQMPFP8Mbkn/
         tfp3aQLdJJ5NXT7VhoTFwpvkPhu9TD3BzBnpRzaoWbt0pAdV/iSc21STMu2tH1NkvFYs
         TUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699695; x=1742304495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXEFQQJ7zeYMoU7AeoXlfPbZ3jDP+PoYlgP38jKDBC0=;
        b=oWhSEom9teif661KFvY8ykcBA7RWOpV1Jt4o6yAdi2H00t6epn8FOh2aibFKyn6/Bq
         T0attU7UE3+IjRGBXx72nseNA4z4phawO/puiF1V+giP+PAoqs8p93kK0X/fgvmDcc5T
         I3p++2xOPef/tu3qf6U83LyrjMH88C2AqV48FblVYwXa/29q+vk5tjdJvBlMQbLyCgZ7
         GWc/3TmuUJwSCpNT1u9qBH6wE6/odzI2iDbr5GEp4kRUw+D+ut3fZx1+eZq8ShFhwQjL
         /VOgUg1dOc+lo1Ssb4zjsUiaAy8FbOlFdDyXeiX8zz9ghIfqglXNhE99ABhq92mxJs9f
         siEA==
X-Gm-Message-State: AOJu0YwM31jp8eYpZRKNUax0HqX5dryjV0SFdIb5mf7RDJ0ej0jfR1Zz
	KgKtMz/KXjQ7jdhWg3AIwKHRS+zCvO8M2oueK5JQ71allJoF1JF4rbCyVfOSFyoNJ3PvxCd122o
	N
X-Gm-Gg: ASbGncvHzVSbwx/XDdQ/cyiAiyS7hP7bV0cfpLRTmw2vbt3Y14PZiF+adtlOZIJnwr6
	E7eOeXflGxCJb5Tf5+tb0hFbTqPPshf+AyQ8iXjQQch5HKDAxy1FF+IDmna6FNC3olK/HjVKmsa
	EqKj6j6S8EE0tq21sXVQfdKhMSlskFvrGc+u+kiPdxjuKTkvW5NaJjZIHHhQHYlk3UtEdwxJVR+
	Kz4FvbuwpRl2m5Gjq+g5cu6zGFCuRa8ShDM0PztHVGaXHnDUykWGd0jFHzCL5N0DKXhvDirVK9b
	LSuUq4S7DpO9/z/Z4VJW13+6SgXiePWgUNmssLHK
X-Google-Smtp-Source: AGHT+IH8g/MWtsEGvdQDmf4GC0P079fOIy5/X4ZdSrnNoGSmHl1UNalVJ/0gbpRy/D8YS0vTKtYEgg==
X-Received: by 2002:a05:6602:80b:b0:85d:9a7a:8169 with SMTP id ca18e2360f4ac-85d9a7a81b6mr260189939f.0.1741699695196;
        Tue, 11 Mar 2025 06:28:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b41cf5695sm106369139f.6.2025.03.11.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:28:14 -0700 (PDT)
Message-ID: <8f4d1ea4-51b9-4ccf-8159-2e31732c7f81@kernel.dk>
Date: Tue, 11 Mar 2025 07:28:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
 <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk> <Z8-9jmZ4jiA7C9gI@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z8-9jmZ4jiA7C9gI@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 10:35 PM, Ming Lei wrote:
> On Mon, Mar 10, 2025 at 09:17:56AM -0600, Jens Axboe wrote:
>> On 3/10/25 9:09 AM, Ming Lei wrote:
>>> On Mon, Mar 3, 2025 at 8:43?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> Hello Jens and guys,
>>>>
>>>> This patchset fixes several issues(1, 2, 4) and consolidate & improve
>>>> the tests in the following ways:
>>>>
>>>> - support shellcheck and fixes all warning
>>>>
>>>> - misc cleanup
>>>>
>>>> - improve cleanup code path(module load/unload, cleanup temp files)
>>>>
>>>> - help to reuse the same test source code and scripts for other
>>>>   projects(liburing[1], blktest, ...)
>>>>
>>>> - add two stress tests for covering IO workloads vs. removing device &
>>>> killing ublk server, given buffer lifetime is one big thing for ublk-zc
>>>>
>>>>
>>>> [1] https://github.com/ming1/liburing/commits/ublk-zc
>>>>
>>>> - just need one line change for overriding skip_code, libring uses 77 and
>>>>   kselftests takes 4
>>>
>>> Hi Jens,
>>>
>>> Can you merge this patchset if you are fine?
>>
>> Yep sorry, was pondering how best to get it staged. Should go into
>> block, but depends on the other bits that I staged for io_uring. So I'll
>> just put it there, not a big deal.
> 
> Thanks for pulling it in!
> 
> BTW, the test behavior depends on block too, otherwise it may fail
> because ublk zc actually depends on the fix of "ublk: complete command
> synchronously on error".
> 
> So if anyone wants to try the test, please do it against next tree.

Indeed - not a huge deal, as they will go into the main tree at roughly
the same time anyway. But good to note.

-- 
Jens Axboe
