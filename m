Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD431391
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769224704; cv=none; b=ij//2d9c1D6CsPKzeZCsmIAEHSXaEV7zWx17ebf0pl0XZg5iuciOQdne6hL8jiRedbra17ParZQgMwhsDXPs85aD2p0uzli5le4iIpKrny9Dsvni2Tepm922+AvYWYwi+xGDVVPy4Uv6sasty5u+VSjCi4hwEbfVFIF7Q27W9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769224704; c=relaxed/simple;
	bh=+GJB8NNVBb6Sl4vZePTJXnpZ/R+w+3igXNxHSl5DlOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnxp7eqNXWMfCVIgggrE+Bek01BrzLswHeJ/JVoGVd7Oi/vEqYkGucZw2zAfNj7XfbiFAGF0HddTX8msEQ3sLVIfBRTlGrBxswTpyo8vxBNGb11U5D6ZYZfCSW0FI3GM/igHEoFLVrQPv+o0jAy8NxN4SBFxEsJJ9MqMvALxPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jPCtiy4I; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jPCtiy4I"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so2725625a34.2
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 19:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769224700; x=1769829500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XR9ta43HFFmgcub0+kt63K/UThwfN3h3137lNsrcxY=;
        b=jPCtiy4IR14/rRl9cLeseKktKw8UyKa7uGRQe/c4wBccZSLEYNTPHRAi9+iSjTvnxY
         4PirPNGRTtjsHr4VT/cMdZe8TzTEl6bESJ6KK5bxOhIIIShTP+e/LGGn2ZRxFfeI4H2m
         9EM4lM0XaVWoIVXRYPOtWENsg++tSgtmk2KIDdpYvws5ZtRCd3TM/jE4l0tiDFiWqy7U
         nw7WZKp+wuK0iUjSxjoMKlaIP5Z8CNkKHd4GCPseL74LXVo/Wy6lUyntht9XvqlA656f
         yn1fb225M+IBSTZBRoiQwc26XRbHVd2Gv7DeSP6UMuL3g2NrW88YQ9wXtizkEeF72Vby
         2ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769224700; x=1769829500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XR9ta43HFFmgcub0+kt63K/UThwfN3h3137lNsrcxY=;
        b=owCliZQdLJItGLIYUIQhAtjtr2v5IhuWSrJSIEWrq+Jra+p0to2/TaHiBRq91xD+iV
         HoaA9KsUlCXH/4UozSRXu2uVjuiOga7cTNFhjEyIGbplBsDuSgvj3GV9AvukiKEwHcAm
         47+fX6IiQYxVO80+vICfGwgrlgySIszyyrY76hCkpbl4RtRkhOXLZYo3B5hukF932KGP
         32XD/7q/VT/i87kNgJf2FIl/37ICbUO/qEm/H3AldEwqinzl1S7A7IeC5j/785KFwZLH
         lrCnqK7aAyRsLMyPjTF489r/+Pj2jgJETtk/949Saa1YU5aW6fcWfLvv/fXw5g6Rnt9+
         ZuUw==
X-Gm-Message-State: AOJu0YzQGSk1aN/IaYT4SlxZjEZNrXqcLNlLgihO/e/tXr+awNhZC0JH
	sL/RlG6RSulhCItqCg2n0YfaneX8lTjk3KVdKFxFEE6fXEUdbeqP4CzeteEw2ofFYws=
X-Gm-Gg: AZuq6aLK1QSmCwZENaW40nS3goYyt+zW+V9t4rByS61G75rbb8N84I7QO7hwyXsGjUJ
	ewZBLG8B2V1cHPkMjPRsoVvlion6Zt9HD/sZrpYRYxAyTT2S/u5t0tlWKer8gi66NT+q/UiYvZk
	PiNm7Oea9IgvxaJMMUfArGAyOS/bk1gEGOQXb1vzCuRm9yGr62YvKj3FgJpMRJrvXwIVgDvIFAV
	aJ/v0rgDpXhbsE3jQqeRRQ3glYH3ANGWcvvCKtutjbAYA3xJEjDX/DGpMTayypQJjtHrdL7cpmf
	aM9ZEiJu3hwf5f86IwknrxqBaXCLeo4tUawnH3oYcCkV8kTca+s3UYM3Iem1fcrzhb1OtRF0M6u
	IPs8qRF3zW0O5D0YCr2m5SquSIPGkhDkpA7dDWfACIRP8fPW3fG9S9mzDz98XJYn7Q9hXbdGINw
	I9fPGkOi7GBVj5Do2GJYtU5oNmjKprBIwneWgvhtU/k7i5yPS+wf1r0r5MJwZwQ9FxkpEdOw==
X-Received: by 2002:a05:6820:1897:b0:662:c6a0:b3a2 with SMTP id 006d021491bc7-662caae7b58mr2586768eaf.6.1769224700157;
        Fri, 23 Jan 2026 19:18:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4f29e1sm1984091eaf.7.2026.01.23.19.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 19:18:19 -0800 (PST)
Message-ID: <b65754e9-0974-476b-bd09-9b63de90666e@kernel.dk>
Date: Fri, 23 Jan 2026 20:18:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: auto buffer helpers rename & document io
 reference
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
 <176919561293.731063.8947763808975933270.b4-ty@kernel.dk>
 <aXQadDz91PAYliwI@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aXQadDz91PAYliwI@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 6:03 PM, Ming Lei wrote:
> On Fri, Jan 23, 2026 at 12:13:32PM -0700, Jens Axboe wrote:
>>
>> On Fri, 23 Jan 2026 21:51:57 +0800, Ming Lei wrote:
>>> The 1st patch improves auto buffer helpers naming, and improve
>>> documentation.
>>>
>>> The 2nd patch documents ublk io reference counting design, given it isn't
>>> very straightforward.
>>>
>>> Thanks,
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] ublk: rename auto buffer registration helpers
>>       commit: f50af896932f5edb1ff7b407753ecfa285c30b7a
>> [2/2] ublk: document IO reference counting design
>>       commit: 420bcbf67b4575d6455a4fa0de06695d98d340b1
> 
> Hi Jens,
> 
> I'd address Caleb's comment on the 2nd patch, so can you drop it?

Dropped

-- 
Jens Axboe

