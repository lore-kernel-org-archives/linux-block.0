Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE42FCBE5
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153512; cv=none; b=LzIkH+L9P0OD0DcWffSpK29V4I0ELhW8M3pSQ9ShgBdWA04sLWHWXL+Msr/npqc/GrdRIb15+5muETrIDdX3c0I7eUA5mBiai2abyhZd8P7Kla1rZaZNVnYJU28YLd9T9KdoP6UcudQiH7yv63bTbJLPRBOmTtR25LzJSwdfBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153512; c=relaxed/simple;
	bh=QHanXXg+OyeerrpmISPQdni+CiKbUE36s486c89hzlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9hKOUXmcMR2QO6GsF+gFIh/J2p8xsuepEbaVOWL64Qja6UptLpAEc0E/qI3NDkrUbiUcvlnYuIbXNlk1IIYqg+9tRbgp7i4s45bC9AkzN+Or+HHLtxNCE6ibiFJL7cqfugkVymU9DVQsveunYnhBXLZLnZ9X7JXJ1P17J5aFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ixD2vmHs; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ixD2vmHs"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-948a50b8ea6so164701539f.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763153508; x=1763758308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5fX1MysWhFmcB+WwiW0z8iIPBJH7K9A9qIpnyNOJTI=;
        b=ixD2vmHsXg35O4bIBmbhneRW/CKwiInwhj3TAw85SNWfYBCLS+GSJKE4FnIEqxaQZw
         ztLuSEqeJB7KV2RQxROAiGVebCfkYBUYecYBhczavZekmWsmhJVvx5cVJju5jwMhjNs4
         lTCCt23pt967NU27UpABTrtyVqO7LZCNSwXKDTt0/3IPdszFAqiV19MLjMK/vHDDPTlr
         INFVrYe/uBWMFKVPdd5S6xym0PgwHTeiwkYax+mVXGdHs9VwuNrBaWWwuU8WY5e/cmQb
         ZjOAU9/DHA8xjzRIw76HY/lWL/WClwMnJ59JCRmxUmZ5mhhfiGI3f/62b95Ns7ElDUDT
         2v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153508; x=1763758308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5fX1MysWhFmcB+WwiW0z8iIPBJH7K9A9qIpnyNOJTI=;
        b=Ub1ibFuaI+fQPtwYVJcedQNW5H6gvOHwhLM16Y8ivMgYxCyY/bDlBIF8XnK5Iuqwt7
         mxci+8qkdDtJOrDgYGUJ0AfuTq4UDv0Ztkwqod52KReQ70mlxakHA3RhCluKFupo2rk6
         WAr2KIURr6ZgvOgZj1d2wGFFz68C86XVbYuEYKrESFL5fbO4j325jsHhMQQi2m8/O+q2
         wv+VXGGmE6w9cqXw21mueWSmVkyaH1lt7rtAHRXncuB+hmptXP6VpDo/yR3kCTAn7OhK
         qoTFbeGXc/y77ePQQE0LSHnqAND6xbBfD5X+6dhu05hY2L5okjcfyHSzEJuSOoiVw+lX
         GK1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/tJMpe3RHnSuNvJFw9Gcm8wOmIJdy6E9dpXaJ3vkbJe/NDsee20wqEjGuoNa6+9UrpjuSxX9/qIUGGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRE02E6vgfiSCZHImdFTzpSt/SrFmwvVxsZ3yrspS0aTvV++gW
	MRLNuNQoQ8rrAfu3OEPTNbQwOSWVJjSwXSu8tZY71fLvXn7U3sR3PZNpR+bjXMQFFMY=
X-Gm-Gg: ASbGnctUL7R6GLTQ9DnnqxiwFkCzZa/OKFzi7TM6RIR2pNoLKEqHOhIH5Oic+yqqZUy
	Uoh3g8OZM29MKoyb2e1+rWSJiQ6gxdW25+ifLZ5IX3PNhBbBUmnDxYx0ohe5JLiMMQqfz2SQQwz
	VKI859RR4DUiO+gSpIlt6fNtr81jmT6sRNBFrId07I0rZZo2/ZbGNnY1PlsCjB/E84ioDpIR/19
	fc7lia86qHh+sNQhbimGOB5vzj++31RfBogCLK4Iysh2gXMDFZOTORiy6Kafoz2RXqSB+/sylMm
	pxfBmrIQvdZ54AfWNlUEhc1exyYVcfrxI6AXTbO6h9EVThcVVKcKDkYufLZP66gBJPh1Iq+psAI
	X8UEd7ZE26KIDguCObH671ZCXAknpd76hLSSiOF8u1JGD5fp++lFdrWdgiHIADo+Yyk+mwu5twA
	==
X-Google-Smtp-Source: AGHT+IG159UiYhWVCcgUydPpcwCRAFvTjZEVsHbRkwXu7EKFm7a9S1w4iE/kFuWeNmbtfLLSP6dEbw==
X-Received: by 2002:a05:6602:6d03:b0:948:75e2:dccd with SMTP id ca18e2360f4ac-948e0dcae10mr730655839f.15.1763153508234;
        Fri, 14 Nov 2025 12:51:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2f8e339sm351975439f.19.2025.11.14.12.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:51:47 -0800 (PST)
Message-ID: <b9efd5cb-d3cc-48df-8dda-2b3d85e2190b@kernel.dk>
Date: Fri, 14 Nov 2025 13:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Khazhy Kumykov <khazhy@chromium.org>, Tejun Heo <tj@kernel.org>
Cc: yukuai@kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730164832.1468375-1-linux@roeck-us.net>
 <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
 <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
 <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 1:26 PM, Khazhy Kumykov wrote:
> On Wed, Jul 30, 2025 at 4:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/30/25 11:30, Yu Kuai wrote:
>> I had combined it because it is another left-over from bf20ab538c81 and
>> I don't know if enabling statistics has other side effects. But, sure,
>> I can split it out if that is preferred. Let's wait for feedback from
>> Jens and/or Tejun; I'll follow their guidance.
>>
>> Thanks,
>> Guenter
>>
> noticed this one in our carry queue... any further guidance here? If
> my opinion counts, since this is a fixup for a "remove feature X"
> commit... I would have done it in one commit as well :)

I agree with Yu that a split of patch 1 would be appropriate.

-- 
Jens Axboe

