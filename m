Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74444127B4E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267515; cv=none; b=F81NZNLUpGUFwDDRaq+zyr8tW9/i6N+Byqk/q9ladTpS4jQjz410BjhDdCa1QtUL20vfXomWZOW5ZI+jvr8Bekqj/ElXmDMlO4kUUhX39VcJg9d9I2qzb8qoe9f7a5/xb7jYZqwc+yS9DhWwggvVzXZ3EopJ4zoUmwAgGedrY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267515; c=relaxed/simple;
	bh=d1cHhT4MqLwcl8/3OjzJKfzV42TLRHHwjYlNqUuXhM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhPPLyrPxR2khTPy8hZoY9zQWRcJACftqGOlv6raHhQAYtvKA8joAkej8CVSDf67gvMNcQFs/42oDewItq92BClTRJ03FCpLagEe5hE1uKd6oOZ8HhOZxncprl87goW8ECoJKCnPe8PYxBEeAfeyArTZakE5p5Trv+fy2UaaoQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tesV91ol; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tesV91ol"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a532498cc5so1494307a91.0
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713267511; x=1713872311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfeeCDSzGaxrBgmtLBVbqqBykwfK7KOOw694YoCHf24=;
        b=tesV91olnnrwAJoZCcOmcJ1mKIxPTSgfPI+67VGz+PhZXhb7q9LxgKjS75GJsURggU
         duNm5xJLtghC1x1E3l3YjMqF3+vQhy86P4WQdF4z/avbxUEEr2oAFk07j/+konGBRcKd
         2UgN1haA1ph5nNoCOxWYtvHKRoSDJ1BCOQKXacrnoBmCLr4gwG0yTB6k3l69CSRR9YOn
         ModFRFK5SgNDlj0fzFe5jCPfTouZo72Aer0Q+McnTF98rKNP+tWcqbZ7EJPerxr3f1Aw
         tKHvcg63yVVWPD8rAckdrGRLT3RTEIJXbcJhLALJvvrjSxMI5n8FagEtH9NerdGSeMCz
         xlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267511; x=1713872311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfeeCDSzGaxrBgmtLBVbqqBykwfK7KOOw694YoCHf24=;
        b=gqwphlsbJLQBAIPldS6LFlZDcwm8z5YkZ/kP0cgQ4NVTLQ2cwR+PTm8j9NEMDmb+IU
         fTK9JbrAU4lIJEr2lg+LaOkU4nZ0MJ46JP+QpSBZbGik7iHSUVqGk2YHTZJVhs5dHUmZ
         tSNdBhKVMJSalARthSJkP5CGY+ss6C1QrluYjuFDWNu/tn9PXR0L17BADbrD/WWRbH9A
         lOgaUjWUcVID/LILbEGq0lX967/5dbCxYx1gydgToP/u0vHuntrkpKj6ot3YhfIMUeM1
         zEmSp9axvt/0LpAyQJIbMb7zCvkns/FwvS6ycZMXUCRHkx+TfAP++N3IGAIlzJavFFjI
         K4Yg==
X-Gm-Message-State: AOJu0YypgM8XnXY2FE2eGeQ3WMBDSRDqPykTr2LB7YByX8LUIDeipwCx
	63msFC/GZod6Bf6EfDRCv5cLpied39WE7WheMd56kPN+jbHY5dAxD8uCoIhCuEH0MbNW/C2WutR
	+
X-Google-Smtp-Source: AGHT+IF0NM7aU21s/kXosWbASCqbH5ePBu52YmxkdGdcRTVTUfx/8c8wbkaBhW76KyVpP+FNC/qWXA==
X-Received: by 2002:a17:90b:4b47:b0:2a6:d7ac:24dd with SMTP id mi7-20020a17090b4b4700b002a6d7ac24ddmr11437271pjb.1.1713267511151;
        Tue, 16 Apr 2024 04:38:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l129-20020a632587000000b005dc8702f0a9sm7614492pgl.1.2024.04.16.04.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:38:30 -0700 (PDT)
Message-ID: <28cc0bbb-fa85-48f1-9c8a-38d7ecf6c67e@kernel.dk>
Date: Tue, 16 Apr 2024 05:38:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835
 io_ring_exit_work+0x2b6/0x2e0
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk> <Zh3TjqD1763LzXUj@fedora>
 <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
 <Zh5MSQVk54tN7Xx4@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zh5MSQVk54tN7Xx4@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 4:00 AM, Ming Lei wrote:
> On Tue, Apr 16, 2024 at 10:26:16AM +0800, Changhui Zhong wrote:
>>>>
>>>> I can't reproduce this here, fwiw. Ming, something you've seen?
>>>
>>> I just test against the latest for-next/block(-rc4 based), and still can't
>>> reproduce it. There was such RH internal report before, and maybe not
>>> ublk related.
>>>
>>> Changhui, if the issue can be reproduced in your machine, care to share
>>> your machine for me to investigate a bit?
>>>
>>> Thanks,
>>> Ming
>>>
>>
>> I still can reproduce this issue on my machine?
>> and I shared machine to Ming?he can do more investigation for this issue?
>>
>> [ 1244.207092] running generic/006
>> [ 1246.456896] blk_print_req_error: 77 callbacks suppressed
>> [ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
>> flags 0x8800 phys_seg 1 prio class 0
> 
> The failure is actually triggered in recovering qcow2 target in generic/005,
> since ublkb0 isn't removed successfully in generic/005.
> 
> git-bisect shows that the 1st bad commit is cca6571381a0 ("io_uring/rw:
> cleanup retry path").
> 
> And not see any issue in uring command side, so the trouble seems
> in normal io_uring rw side over XFS file, and not related with block
> device.

Indeed, I can reproduce it on XFS as well. I'll take a look.

-- 
Jens Axboe

