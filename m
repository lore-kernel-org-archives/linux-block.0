Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330923371B
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911624; cv=none; b=lPecPVdhtm6UcdDxjmLwH5VB05F2vTSdcuVXnGH8jCadi+7YhaUkxSii23qyHfW0VFHnp75d7cwSAkBXxslL7xN8N+BMZ5MxA0YgAHMRpgAj9yNBnCHbvrmhsg4+t/P0xoyYKvlYfhG8RaYU3RoIQeKIp+kI4AwtgPL7XtOuuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911624; c=relaxed/simple;
	bh=rAPqGo9CNXePe0bhRllVH+gMwzYp8of56tRMQwsTvnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz9NIHYuDcw281WvRiSzfgM2Pl8XVAu7RWBSixDeWvmCpa3BEcFtJj3FqH0viPE/oMrzqCME1QuvmB9VFQ+bKNkdLPdB9+68vF8TmvmNUZ48qcm9cx2en1MF9FbCoalGUyDlNN0urrGutq4MIAYyBS3yeA1wgBFn0l7oH0Yt5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oyyTjUrH; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oyyTjUrH"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8616987c261so308593539f.3
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747911621; x=1748516421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTux6vKf1w7s2fr4IBk89RSygQ8BGWDQ/HTjg78NcC0=;
        b=oyyTjUrHC8nLOpECVPmbnx0PN972jRcFTAiENTrgEd+b8l427W5F63GapNmOmEo9bt
         Fx6U6CS3H/o0eYlRideI0QKLdWLm5MSm3NHUkzNtnBPw1JRs0/t7nRJlbpijwt3KejIl
         Gq8EXDEmn/xf3kyFBQfzBEJioTt/73fzRZ5p1U2N7eyWIY+g/pzBmasqvrSKZR00Jrvg
         gvE3+Mo7KCwOVXi6Y7bP66GQQspHKEcMaPpONAL4iOLmOvCsZJb4pghKA/X3yjUinh5v
         ceAfSgUBDgtIIOesOrWObsPUtpidTlfcjglhShk1pJ5o+hmUzcP6ITwm5lcAkcVJxU5n
         MzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747911621; x=1748516421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTux6vKf1w7s2fr4IBk89RSygQ8BGWDQ/HTjg78NcC0=;
        b=BCAmR4sMYKzLv9XXmx8/d7NWb+D07VunsxJ/Cy70GBX3xcA2KsEC8xC1IISlATrlQf
         m87KZUOT/VzLq1Arx9eakURRB+ZUk6CRwiyfKO0+vIEADokbafJY9lBerRwFEMp5BwYo
         QxfqjwrO+KWSyzP79x6DC1D9gHJ3cuPOu5JD58FNTHgVHOB+uuDJBWpw4fdqzdRhur07
         mPb+ccxszdcOREC/rR66Tl9T1BvgRrpzQR6JW77mjtNfq/dhn+Ou9flSschSlp5YSlM5
         z9w+WhBTIVVlmw+Wy8PbqwS7ohwd+k1JHRR7/46NWAIGQncoouIQyjrwSiWuQPI2iCUK
         1zAg==
X-Forwarded-Encrypted: i=1; AJvYcCW1yj8BtKJ3KJ6TH43IstNgeJd9Y38mMz6u4ZEtoz2ikIFNmqM6nyugYb9AAsr5HoG4orMZwUpVEbvmKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwstgNvkExM8dhN/3/hEzipCfVtMXOyIt2mDXtcn+EGGVw2/1sO
	+J1Q5gapC6NnRwKM8PHLogLlfL73XhS4MrJFPymA6w4BJXHeaPD5GWt3obGJ5awYXGw=
X-Gm-Gg: ASbGncsuIh91rENJ4mm4o6Qe9jodJNUvV7s7aE5SpQykQriIm1s1QzyxSzBw4pxnVBg
	1Ob+3hycFvNqWPYxmQ56zn17rkPr+QBJ33ZD5AxVyTeD9B3QOCs1LhFUVh01wYy17o4wZz2ANyu
	3/Gl1A7hGfjRaMomgWJ/AIzMsElvuNpZqrkErQMtkLu33vxdatzBIgCW4HxLr2zat+fr2omRhsa
	llnMDq+n6EStVq+4axDegl10YCQEtV4Jtnln/ZW+i5HY+xzJAI6Pl2LKSkkIu8nltvO3Kf+BOHK
	A9cbP/WuuJIKtcGieO35UTs3wVXN1L6q4KZBZaibnrrG0Ki21L+XVvcJC0o=
X-Google-Smtp-Source: AGHT+IFK/JTjWASlDRezRqHwK5tUFcjJfpJqUjhSrywCKjDiQhfBJjbpzvzBZqHb5Tw+rLNHEOZpug==
X-Received: by 2002:a05:6602:4881:b0:862:fe54:df4e with SMTP id ca18e2360f4ac-86a231d87e5mr3358711039f.7.1747911620628;
        Thu, 22 May 2025 04:00:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbd0c0c2cdsm2937084173.94.2025.05.22.04.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 04:00:20 -0700 (PDT)
Message-ID: <d82071dc-c9ab-4687-97a8-06f00339c689@kernel.dk>
Date: Thu, 22 May 2025 05:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] traceevent/block: Add REQ_ATOMIC flag to block trace events
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linux-block@vger.kernel.org
Cc: djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>
References: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com>
 <cad0a39d-32d2-4e66-b12b-2969026ece37@oracle.com> <87tt752jgd.fsf@gmail.com>
 <87msb52pld.fsf@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87msb52pld.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 11:15 PM, Ritesh Harjani (IBM) wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
>> John Garry <john.g.garry@oracle.com> writes:
>>
>>> On 03/04/2025 06:28, Ritesh Harjani (IBM) wrote:
>>>> Filesystems like XFS can implement atomic write I/O using either REQ_ATOMIC
>>>> flag set in the bio or via CoW operation. It will be useful if we have a
>>>> flag in trace events to distinguish between the two. 
>>>
>>> I suppose that this could be useful. So far I test with block driver 
>>> traces, i.e. NVMe or SCSI internal traces, just to ensure that we see 
>>> the requests sent as expected
>>>
>>
>> Right.
>>
>>> This patch adds
>>>> char 'a' to rwbs field of the trace events if REQ_ATOMIC flag is set in
>>>> the bio.
>>>
>>> All others use uppercase characters, so I suggest that you continue to 
>>> use that.
>>
>> It will be good to know on whether only uppercase characters are allowed
>> or we are good with smallcase characters too? 
>>
>>> Since 'A' is already used, how about 'U' for untorn? Or 'T' 
>>> for aTOMic :)
>>>
>>
>> If 'a' is not allowed, then we can change it to 'T' maybe.
>>
> 
> Gentle ping on this.. Any comments/feedback?
> 
> It will be good to have these trace events with an identifier to
> differentiate between reqs/bios submitted with REQ_ATOMIC flag.

Just send a v2 with the modified changed. I think 'U' is the most
appropriate one.

-- 
Jens Axboe

