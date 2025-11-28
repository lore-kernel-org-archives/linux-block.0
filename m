Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226B285406
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346155; cv=none; b=Mf1oqG9LTMkUrV+NIvOxCkuNIzaaIIcXpZP4OLYjuwQhLAgWffR+CosS/LiTbogqmLHoM/ousR0FZmFMounTQE796iv6eIqgRBhMj4UQ/Fnq+5i59F24uDCe52xbK2UTGiI4e0UxpIyXVckZPeEqqUB0//qq/iYc0fnl2keWGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346155; c=relaxed/simple;
	bh=WQrR9/gwW4QFzD3yMg4kNlmk2B7XQlqE92zyyHYEG6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moSVod7PVr+go0EUwbmappLRs73MAVkO6zfyHWN0R9DW/kiuzc9FgYeGE0MDodb0LEDekXc8UWAsaE7pCTQu/FRqIHo8OdKF5r/oCH0tlImfujbDO9C6nVgj5Zu9LYBgwQQp1MUxV8NnqP6lspiMY2nFOSfA2PJEYdDUd/88wSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ybMAS6hy; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ybMAS6hy"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9486251090eso84342339f.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346148; x=1764950948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C91oIzCuZEw7m6kN3AejYK78lRx8S+i0yLMhTyUZXGg=;
        b=ybMAS6hyfvKRfm2+/WVtQLWLQMHtwxrPOeL1O53NcAg6zTKrMf3zLP/dGxshBf9yv/
         /V89NCOZmRlE0tAyaeYFj0yo1vwqEPRjbJyEMAk8YcZlYxrtOdO+o0Bgbh/5cKwfpEFS
         9RKiCSDbJSZ0VMcdGpKSGR+gibIpN4EavJl0lYNDagMRRtNREy00vLmJ5qq0omngp+FY
         5C7403mWBzSm//N2oZJpXAls33wHbUyDKu7ar83V1RnWw8/MvpoIr2Vl8lO26UF7ANwW
         TH2vMcrB19OmA0LTck3jHF4KKWc92CwItgFmOlydbw+XTSnIWIKHdRg7gsIC/qDEOtl/
         Pe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346148; x=1764950948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C91oIzCuZEw7m6kN3AejYK78lRx8S+i0yLMhTyUZXGg=;
        b=vtsLcfV9lDbaZ2wJMXepIM3f3jP3lyzutIQ17B0FJmFrLDYi1It/jjSLsHPdlFG1Ec
         ORZltWoXZoxJ2x+jir2OOvN3d/9Xuqj0fLfieMutpNKr+P0H2AHD/Z/LTMHW1ai+uGxM
         RRdSkKinUF3vIHO7qAzkMszVmpIgA23LKTFKirhw9c6j4Qs1pZAFbtTYL+3cIgO1O1cW
         OmH8HhYnY8dS/Y48q3P83fp9h4jqWtIP/tKEHYufhehO26TGV7xa4DOoagD0CuJrB3HC
         FYKtv1XP8ca5Cwm5huD9YTTrMkVjUJvgI24O23q5C7Lt+jcEfQRAWIjFzpMKQgvv+SOx
         uUZQ==
X-Gm-Message-State: AOJu0Yyr+6q9hE3D4G/QwY1Gk/JbTpgva8FfUqIL3disxoRcz6S7BYvt
	iD2a+axSMVQADclPwsd6ATc2Lz+QYC+FppYwhBEn4RuDGG4IzRNg+cm7QCvz/Q7FOM0=
X-Gm-Gg: ASbGnct+34n5ZclKx8PGJk6nn4k5UPw1/EpPZ9bDfyYxxigLBb2Wckzq3mYRamcgily
	Olbg3ymiSJsSnTZhs2LgMJsnlG1WA/z45UqjWaQsIPiS+bKZT2hK2f/vuThfMtp5HESYPMwNyK8
	V3/gSJPyzIwSfojcjKqDr9l8ntOyt0FQnT47JvFy/YdTqyiydvvyIke40PqjZz4JzwOK0UUOAki
	fLT9bi+vs/7xNVAraIMNy24kq7aPfpPrTdN+SBKQjVlYNCtvbLKbB8ShFWE7qW/4pRrglRTiEK9
	eGNBaUdVHv9AaoqgOJ1EGuSgel+CrZJac/YIrC5jQrBdi9x+N9X+iICGt/eZp4J9xyPhuaqXozj
	Of+rj6HBBHgko47NEsL0Im4fXARcIcNuTSU/0mocjvs7lClIekKfTdPQlgMdXIkiMwMH5Wh9Mk7
	JO4OfI+GVx
X-Google-Smtp-Source: AGHT+IEqrWYtrrD5L+d4DxbWzCQJ96lWpHSP9GGa5Cv7FYPQt2MIpKtEGFMfiuxkxh298k7VtPJRRw==
X-Received: by 2002:a05:6602:29c7:b0:948:8757:9b92 with SMTP id ca18e2360f4ac-94947450b1emr2308930139f.8.1764346147843;
        Fri, 28 Nov 2025 08:09:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9498ffef691sm225894239f.15.2025.11.28.08.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 08:09:07 -0800 (PST)
Message-ID: <f9d12bad-5d4a-415c-bd04-8669260ccf6f@kernel.dk>
Date: Fri, 28 Nov 2025 09:09:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] blk-mq: use array manage hctx map instead of
 xarray
To: fengnan chang <fengnanchang@gmail.com>, yukuai@fnnas.com
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de,
 hch@lst.de, Fengnan Chang <changfengnan@bytedance.com>
References: <20251128085314.8991-1-changfengnan@bytedance.com>
 <7dd622b2-b064-4209-a74f-9084ab835cac@fnnas.com>
 <CALWNXx86ctj-360U4-a7DAKcNh2j3s9Rg-25i6bBH6RgUT-Dyg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CALWNXx86ctj-360U4-a7DAKcNh2j3s9Rg-25i6bBH6RgUT-Dyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/25 3:00 AM, fengnan chang wrote:
> On Fri, Nov 28, 2025 at 5:55 PM Yu Kuai <yukuai@fnnas.com> wrote:
>>
>> Hi,
>>
>> 在 2025/11/28 16:53, Fengnan Chang 写道:
>>> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
>>> an xarray instead of array to store hctx, but in poll mode, each time
>>> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
>>> introduce some costs. In my test, xa_load may cost 3.8% cpu.
>>>
>>> After revert previous change, eliminates the overhead of xa_load and can
>>> result in a 3% performance improvement.
>>>
>>> potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
>>> avoid, same as Yu Kuai did in [1].
>>
>> Hope I'm not too late for the party. I'm not against for this set, just
>> wonder have we considered changing to store hctx directly in bio for
>> blk-mq devices, are we strongly against to increase bio size?
> 
> I've thought about that put the hctx in the bio, it's a better way, but
> increasing the size of the bio, which is now exactly 128 bytes.

Don't think it's worth it for polled IO.

-- 
Jens Axboe

