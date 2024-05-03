Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAA6FB8
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748361; cv=none; b=iQPXMfT2+mvrhKetsycQTLwQuKTPPO7lFxjJ02+woV3Y94Mb/r59WHVrKSEOQVbr4fOIpOa1+Smwah++YoOWVoQzIaCyrFcqWhAoM/6DeW+TmLdW10XGEWpGuFlq3LwsJB8jM2LSb+i4TpBueoSqRNiRQAAm7Fcuduf9ft45ELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748361; c=relaxed/simple;
	bh=506C0rZsgh+UJUsVM/ClUzQlypxlvYtwRJBpMBC58vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqMoBNKFzOxW+jg9IUs2A0CUqtQwpn/UhXTsOwwkrGRm2eV5MjGeqovleDydESC0EUGPBvIoNVR8WyaQyg5vMjIg8CkDOc/Mshb24v/q3ETpxo1ICYJwOL/tYVY1spz6gpKzNKf2dQbM7xXpULCDcmhLXaEo3dxReOwYLbHDyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HtJXsjUV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HtJXsjUV"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7dec82cc833so23128339f.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714748358; x=1715353158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzqB3oxw7SVo+sxNzL4BsC4FnIdrrwz3k/V7BeYCxB8=;
        b=HtJXsjUVhgDS7TIRVxl1caBorTxNDr2LFIi0cVSiZvcYfElmCTlO6Gd5WiZsQC/wJU
         9uURLg5UZvWbudqvSYDEpmdCkUrJJuV95itSzihrfokzeXPEEh/nnuZh52FPeTOQkvVv
         wtkn0iKhSX1FBm0hx44gkyUOfUmcd1P/Y2ZDVxqIbi0djW3vB2B6birdBRvK8/ktX+NW
         MrY+9zNiKHC/dz3NTIw5m6D5RWiTDRKcZj1/+cQ4Y0G9EnVCLasOZrng/lehYnuNFAJM
         t+1ZYEQebvLAddcKcQ/cfwAYuBon23BsmCtgTrsY4pnjweB1iDZxw7yh+vwhcOhGQPkj
         ccYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748358; x=1715353158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzqB3oxw7SVo+sxNzL4BsC4FnIdrrwz3k/V7BeYCxB8=;
        b=Pv2FtbE7TKhcpOpznpnq/lV6murexmmi4gobuQ2PxJpaWnrfiWmPEPvI9GoQvs2f7w
         00khktPtddoH+dBn3txvFe80yRRQ98WYCChlDuzNSZCOjAFJ5LbxKf5wdNKiDwAykdd6
         OICBvySaP49QAdM7DGtqe801L6pZyYqLWBqw0lHf5phu/HFROZv5kVpzsFKoDiW5kTdV
         juRvPYy4FBYVDhrzQ5K3cxo08XLXWFfu9Vdyg1bhFd3rSWwBsgWpkIHaVIs5GQ0W1fOy
         l+GmR2t1GFIBaf677UpTaOz/U4C8Wi8zhmk/827YUIqiZIAS0rlxepJnc4prK+8FSsW6
         bbvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKFB3Wh0CGC+koAspiz/A8782KgyBdJ5wQl9jL1/XS3HvlWM4ANTq2vqUIu2/bBHzxshcpaRQYWdIaCnFPbdQwu9VtGxW8+jKI7ug=
X-Gm-Message-State: AOJu0YwxsLCCqhcLlS9VPp05CvS/bpjcN/j0mxAbHhlJ4KgHdbOCv/Xp
	FQQERywhW/fWK6YSdfgiJwzhp+gQMeQB3nj3olzGYNLtA29tOMZ/V1NjF3TgVBg=
X-Google-Smtp-Source: AGHT+IG2qcsTi00u63kGhxLvVvFQDSaWJ9rKfeN2G9vzZ3kLWSyRwloDGFaXRzvsGI2NRS9fdgfQtg==
X-Received: by 2002:a05:6602:17ca:b0:7de:d808:4b29 with SMTP id z10-20020a05660217ca00b007ded8084b29mr3061846iox.0.1714748358100;
        Fri, 03 May 2024 07:59:18 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay32-20020a056638412000b004828f584db0sm829353jab.80.2024.05.03.07.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 07:59:17 -0700 (PDT)
Message-ID: <181e2cd7-4433-4598-8d3b-208fe021f6c4@kernel.dk>
Date: Fri, 3 May 2024 08:59:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org
References: <20240502130033.1958492-1-hch@lst.de>
 <20240502130033.1958492-3-hch@lst.de>
 <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
 <20240503081612.GA24407@lst.de> <ZjSqddKI4cDIgiPd@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZjSqddKI4cDIgiPd@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 3:12 AM, Keith Busch wrote:
> On Fri, May 03, 2024 at 10:16:12AM +0200, Christoph Hellwig wrote:
>> On Thu, May 02, 2024 at 11:05:54AM -0600, Jens Axboe wrote:
>>> On 5/2/24 7:00 AM, Christoph Hellwig wrote:
>>>> This attribute reports if partition scanning is enabled for a given disk.
>>>
>>> This should, at least, have a reference to Lennart's posting, and
>>> honestly a much better commit message as well. There's no reasoning
>>> given here at all.
>>
>> I'm not sure I can come up with something much better, feel free to
>> throw in what you prefer.
> 
> I think just explaining the "why" would be usesful for the git history.
> How about this:
> 
>   Userspace had been unknowingly relying on a non-stable interface of
>   kernel internals to determine if partition scanning is enabled for a
>   given disk. Provide a stable interface for this purpose instead.
> 
>   Link: https://lore.kernel.org/linux-block/ZhQJf8mzq_wipkBH@gardel-login/

Yep this looks good, I can grab that.

>>> Maybe even a fixes tag and stable notation?
>>
>> This is definitively not a Fixes as nothing it doesn't actually fix
>> any code.  It provides a proper interfaces for what was an abuse
>> of leaking internal bits out.
> 
> I kind of agree it's not a "Fixes:" in the traditional sense, but at a
> "Cc: <stable>" sounds appropriate given the fallout.

It's definitely not a traditional kind of fixes, even a made-up tag
might be fine for this.

But probably just a Cc: stable@vger.kernel.org # version

and the added link would be good enough.

-- 
Jens Axboe

