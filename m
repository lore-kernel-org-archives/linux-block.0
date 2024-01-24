Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDC1353E4
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133650; cv=none; b=dXYcac7mQhxJWZgGLl+mzRkZDDYMlfBnZcvy9QEXhq7QzMABSZh2m1kZIRoHzphYOSbvtqC6zs81Ye7Cpaix3WFOf3xuVkJ7D4l7afl19FOgrIyEuqutO6psW7lMS0dMSYk56QS2LunTKPHiq5ECVmhKyWOpzH6UCc7rTFxozcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133650; c=relaxed/simple;
	bh=qNrVI44cqHlmMoRPSJCmB/d7x52dUUYxilemha5DrOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8HVfc48N1TMlWPGlwEaMLvswiEDtMLbXbWScbbdYb3lBc9ydph3i6bL0666KmP9H0dAEfvYSMUhj2W2h1f6Klx0mwAvOWpKm0wGb0mDctOZoC0hSKEQqCr8nDAA0EZEJtCsbNkpiVIoZMMKoYUA/XlFQMT7YxwICB3vwP9xBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ppnX/jIK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ppnX/jIK"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dd7e6995c5so334940b3a.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706133645; x=1706738445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L8aUOda7vWJtSg6j2f64C0buQLEZpfZheaILVkJ1x8=;
        b=ppnX/jIKS5A4Uy5/ANbhcKmRtK1iIDpjdC7ht4mtd0sIXle7cNQAw7iMFk8h+qPz5N
         0xX5yaSBs72ofxbTRCyuAoZXMVhS94/SngdkJDqrSbs7ofVsp99nUFXX4IWaBzQTftRp
         +9xBmmhdCcLtv3hp3bd5tsbUKIkNo5nKFAEe0ISXpiiGh6Mqfu7EC9vmZmDo3Yg1/mmr
         OrfHEy2BsH/3ExHvDuDGhl+Gnt6Ta3mqvM6W8X/1UAyCwRQFUC/h2ZghTqHiMvgFLonI
         xUNyeUsIa60qdub8mErZ4kr4cHBqh4pmSMBjlGOysn//SS476wc0NUpjsJjBxqXy6usz
         gwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133645; x=1706738445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L8aUOda7vWJtSg6j2f64C0buQLEZpfZheaILVkJ1x8=;
        b=PBsyhW0Uui2lg74CkrXyq/yxf9j7Ly5TcDQI6VmQ8QIR4/Y36RjM9p0QDBsC2iNDcs
         MiNd5HtTVztqsbvJlqSmAIdFJiCUnZpuggq9m7vGdQaegSTN5pQxH/dZmUufnXCBB9Pv
         CEhzxRalIsf6BeBEiNos6z+xbBle0EdhD9GT6Gs5nDBuN87HOKMncCrLVbRQex9iFe3U
         xnvdzI5iJ/w/L152kDbLKNq6iny/KBGzc4PYKQLyltOgq6x10odsQVdmAhD8AXHDj/CZ
         fVn1wUxm5PjIsdE/eyrYHY4MZ5Z31hx+QYqi5zOpAzRD5GorcEm81O90JqjuBIlEhXXb
         M5DQ==
X-Gm-Message-State: AOJu0YzBz+f93Lq5h0Ro9V3nAfcUp+35O84urvFI9KS1GoDjXbQxhW6r
	7nbZ7ED2VU1G2FlgGn5RjsePaNzwnTHBbsjcmY665bGOI8hOR7AfhUkvZSTXfXg=
X-Google-Smtp-Source: AGHT+IG0C6QXMoScKRyrwwd6wQhHMxmVVM3tOKltsNWZ2O1VVOoyVjjAsBFOjoku85xJvDaYeTrjkA==
X-Received: by 2002:a05:6a21:3994:b0:199:d591:9a5a with SMTP id ad20-20020a056a21399400b00199d5919a5amr222890pzc.4.1706133645559;
        Wed, 24 Jan 2024 14:00:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id hq15-20020a056a00680f00b006dbd2231184sm8506002pfb.70.2024.01.24.14.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 14:00:43 -0800 (PST)
Message-ID: <5d7bbb8a-8542-41c3-b48e-e64b3f5f9170@kernel.dk>
Date: Wed, 24 Jan 2024 15:00:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can we drop the bio based path in null_blk
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, p.raghav@samsung.com
References: <20240123084942.GA29949@lst.de>
 <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 1:31 PM, Pankaj Raghav (Samsung) wrote:
> On Tue, Jan 23, 2024 at 09:49:42AM +0100, Christoph Hellwig wrote:
>> As we found out recently null_blk never splits bios in bio mode, thus
>> ignoring a lot of it's paramters and having buggy zoned device
>> handling.
>>
>> Is there any good reason to keep this mode around given that all relevant
>> hardware drivers use blk-mq, and the non-so-relevant ones not using
>> blk-mq probably should?
> 
> The subject says removing the bio mode in null_blk but here you are
> asking an open question about the non-so-relevant ones should move to
> blk-mq. My input is for the latter part, FWIW.
> 
> I tried to convert brd from bio to using blk-mq last year. One of the
> conclusion we reached was that we will see a performance hit when we use
> blk-mq for RAM backed devices because having tag management, etc was
> adding overhead to these drivers[1](You were also part of this
> discussion, so you probably remember it!).
> 
> Unless there is a mode in blk-mq that can provide a real fast path for
> these drivers, moving to blk-mq might not be possible?

Yeah, by default, blk-mq will do a bunch of things that you don't need,
like the tag generation. We may be able to have a fops->submit_bio()
hook that just puts a request on the stack with the bio stuffed in
there, and have per-cpu hardware queues to avoid any issues there. I
feel like if we did that, then it should be the same performance. That
won't necessarily solve things like queue quisce etc, however... But
it'd be a start, maybe.

-- 
Jens Axboe

