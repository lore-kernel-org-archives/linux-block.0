Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DF2749EA
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065717; cv=none; b=uDBOoNf3TuWZYgl8enGp/d+Rd4RgBEsdQM9wA9rGnlBLxkl/YGbTsx8x0zQZIARi/jYBslhSwOqwytteIMaBSJSDzAWABwiWraipGnO+HaIn0t/xApNHQoknpsfXipSdeBKJLwlvKK33Q9n/DTRszx17CDBEwodi4d5/RlJmFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065717; c=relaxed/simple;
	bh=73GO5c85lTfUZaiQYMWg9njyagrLtIelxkgxHQC+giQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1PnoIC9Ox8qroFN4fL4nG2zDPELqW/7BdtRTZG6Lj+HXH+ek6xHyuZZUTnM7aQPG0uEIorqIZXR6o1eC6SjtcZDAuQXXGiVk936WWtZk+wDVbdvYTgoLd4aD1PGkYARQ8tg/co02feAZj6TJ1X+ViMTE7FOiVBihs97KZOmQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lQL+NuTM; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lQL+NuTM"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso3416544fac.1
        for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768065713; x=1768670513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mj0HGiIJWqHwMGUgvR1NOoz4/3RlXc+8pVl9NgqjV30=;
        b=lQL+NuTMnAibHybg8OZeNCPkxW6EH/eEm08LjK1rIAMY6KRHQCgED2UoGg3HxWkxdF
         2WCXxaYEv3AGDUpQqQn3Jk3UKxnqvaeSHuI33FIhRCQHuX2A2FTQ2kkkalWSwB3X9N1W
         8yvGpvuLwOsju2754vopOin0jcCQFn60utqAwlDAUkoK8I9SAX39dVUVmU/Wmm66iTyj
         Mnilz/1l58vejVph40Wj3TcxJlQJOA8EjM44O+rNgzh61G58fkieLno9jiS3Ep1xBkCt
         5vPIDOyj5eCd8UC2dAI9K+AWQ7ZreejDE4xBa2HWmSR+/tWYv0EoUxr9uMdN05JMqkb0
         sd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768065713; x=1768670513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mj0HGiIJWqHwMGUgvR1NOoz4/3RlXc+8pVl9NgqjV30=;
        b=XwrlTctsKj4QqomgjtKnKyOomT08FuLXPqA0DTNF8VcHeNhB0iCpf303JxiQBUAEzV
         /sISpzMlber2p80zX4aZ4ACP7sPhkX1XQKTnvsl0uuyl5kmlyBZ0yKfIefrBPyYowKr2
         edOKns+sJ4+AU5JT7R0chk8mYQYWqcUhEafbe+E9HJTqLpZr0NpSUotJRxdtpWRe100l
         /T4yQa7kdRNgUShy5Z5K71IouxcicYEG28BN7w11mdhjgxOWYSL8vQon9yOHBs9QLpqR
         qC72oXnImheRAQQS7wSKiIqPJ5pIwev8OX7yZerlmofrLT0IWJoQZDFf1pSINNY4IXuB
         6M0g==
X-Gm-Message-State: AOJu0YzXFj5KR6e8Y659Bkxflj+1nwjrGitRRKJR8aMkxH2BOAfvp/JQ
	hIyMsF2M9aUAW+QlOK9zneN3ApCyjqYGwK2FMaCihuqNyqkO/pkSwt8lTpgYZxMyECfJj6wkodX
	oTlSF
X-Gm-Gg: AY/fxX6vyqKPeeQTxImdIaqeeC/WcG9ZHhv9JNEUDzg3GA5IFXqKM0Ojmg9PpcPgNAi
	VKfC01nRPRVywWJDLsdc5J+OvEcwbh5m5qy0ciiCcsHhOTYMTk63kemUbTmA4YJYQbut57ZTH2i
	t+JomDTVaS++0a4BDbTaE2+j3h4RPBIt+QwKsj+awpQdYdkRIGXAxg/9Z0mr32U0zCrXM51H7Sg
	Cd5rAXG7NEzLCo2kMrzoIX5F/9Dtg5VfkVM6ID5DNZ8L1l80+ll6z96qM+Vxt6wdDhy+4g8x4VG
	z6t3iEKrdVuJHC+WxOiRX9xNtNF2VyM8KFbtJSf73I6Lh8CNx7X3fYa/btECSnaxHqbyWrCsxXN
	NzUnhZUwCXwD5zvaOrHiufexKBB/nakM9qCdLA3npZ7tb3SHc2j4o96CtDrQTGep0qh0BUkA7HL
	xRGqD5e/XQ
X-Google-Smtp-Source: AGHT+IFXmDetbg+RQd2Mzy8Dm6xfWqbWCdAvpAj5OBO/2KdfI2poFdGeGzxH3XhukvuBZuWztLJRrw==
X-Received: by 2002:a05:6870:e98c:b0:3e7:e420:6229 with SMTP id 586e51a60fabf-3ffc095d801mr7144752fac.6.1768065713024;
        Sat, 10 Jan 2026 09:21:53 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3af4csm9101708fac.7.2026.01.10.09.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 09:21:52 -0800 (PST)
Message-ID: <cf37342e-c2dc-48c9-a63b-e62fe8e791e4@kernel.dk>
Date: Sat, 10 Jan 2026 10:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity
 buffer
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
References: <20260108172212.1402119-1-csander@purestorage.com>
 <176796707483.352942.3630670392140403614.b4-ty@kernel.dk>
 <CADUfDZoacSnJz5FOZQov50k4_nP0sxqxDHYOvDqp1_7KKD8z1A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoacSnJz5FOZQov50k4_nP0sxqxDHYOvDqp1_7KKD8z1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/9/26 9:29 AM, Caleb Sander Mateos wrote:
> On Fri, Jan 9, 2026 at 5:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>
>> On Thu, 08 Jan 2026 10:22:09 -0700, Caleb Sander Mateos wrote:
>>> For block devices capable of storing "opaque" metadata in addition to
>>> protection information, ensure the opaque bytes are initialized by the
>>> block layer's auto integrity generation. Otherwise, the contents of
>>> kernel memory can be leaked via the storage device.
>>> Two follow-on patches simplify the bio_integrity_prep() code a bit.
>>>
>>> v2:
>>> - Clarify commit message (Christoph)
>>> - Split gfp_t cleanup into separate patch (Christoph)
>>> - Add patch simplifying bi_offload_capable()
>>> - Add Reviewed-by tag
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/3] block: zero non-PI portion of auto integrity buffer
>>       commit: eaa33937d509197cd53bfbcd14247d46492297a3
> 
> Hi Jens,
> I see the patches were applied to for-7.0/block. But I would argue the
> first patch makes sense for 6.19, as being able to leak the contents
> of kernel heap memory is pretty concerning. Block devices that support
> metadata_size > pi_tuple_size aren't super widespread, but they do
> exist (looking at a Samsung NVMe device that supports 64-byte metadata
> right now).

Good point, let me see if I can reshuffle it a bit. In the future, would
be nice with these split, particularly if they don't have any real
dependencies. I'll shift 1/3 to block-6.19.

-- 
Jens Axboe

