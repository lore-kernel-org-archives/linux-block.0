Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144622A4D1
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614546; cv=none; b=U+g/BHu/ls3BTok6UZVeqi8tRgus1XDm11p7yvO3wAK9A+BypJKOfv4d6Z319GTFQPgrw1lrnM+B1Q6GnGrpGeJW+fZmw8X7bMRmNWbZWqfHQOVSAqWfa6d80nkFMqWLDyBJ3tOPjZyLmRmO5Moqp/MB70QhcO14UkVtlsC/72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614546; c=relaxed/simple;
	bh=SH6Ml41CGvVHd6Hj1y7A64I2rkfThdM7zNXrtCkiPis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVXz7ODp9V4Wo8S5DqMuyZ1QNx57wjxLBNBLjk5wvOzifgsoxOWmNhYoHhxNdGbP4zcnU1zoLrJmRVk+zyqLVN9xKIa8eB18N2MV/mifBrZqULiANaw/PsVm66dgifYG3YnzyXbBBm7FS2ttTUGBuFHmCKaIpmc1e9Zy3LfXOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZsxcxYC4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZsxcxYC4"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so14543095ab.2
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614543; x=1742219343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tdeea6hAzyniFmdrRVRjZg1yRnlPM6BK9776nxY1UsU=;
        b=ZsxcxYC4XjqZqqjmd9SYwfbDhvlncFuLTBQXRWMaW2CydOGMRgUWmMzFxbzJ8wNOmX
         ITJaV7dHg4aVmMiqht90cis5P1Bn7plUq571ud1ucYC0EDPQGvGhUoFNOTiPu0V1exJk
         +tBsMjDwGHzLQMpr7b5/xlb2nyn/inIwNHlFHaTybtXl/Wcoj1CSNbRbtV5UAOD1bmzK
         /OgUKLjCwH1cxPxlxCKQKTQE8QmemSeMlPbxH3FFOUnoEhbGJuI5GXrSI+fwJ0oJm6/n
         +2aFfDG+Dft3EDE/guQOVXqdT8bgmCHG9X1A5a8SvtWWqokwigNWkfTYW78Xxfn0kD0n
         twMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614543; x=1742219343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdeea6hAzyniFmdrRVRjZg1yRnlPM6BK9776nxY1UsU=;
        b=NW3rR4nzznwvArnUfnnEr7CyZQrDa/kuUDAZt6yG6INx5/G2zv3jCl6oKue7vECO6/
         NHAr2HO8uTZqON7QNQoF59zCTnKJ1qdgqx6E0jsAZnoqEhFiSBVgFfV+CIpHkmHfTGeA
         cZRfWoIJKIMkHCOWloJtg+lqMBPE4GcgeMjMD3iaN43uD3FkIa4AyifXT95G7DEnLOq+
         Ekv/tOOucwglN+OUjOhjPxwLHOKdHMBSGplyRdY0+jZpa+bmbB4At5rXv2o+gWNImQoD
         mzZmkwgkT6gckP0bU3go3eWOutoYrBF4yfWVvk8rXv1hC2mPG9aJUGjWA0IPlLDTZYhQ
         1rZw==
X-Gm-Message-State: AOJu0YwYtiGJ5+GsWGzWg7o1kl1IcQAUD25/eE8XCWM/BmKaRX19SbWm
	iCSrc7CUXnsxQOlHgSfPSQWyfPRd7sLXoHygPiFnBlsrNAl7ga8x4r0K9uqRB6A=
X-Gm-Gg: ASbGncvKmLQ3u1ykzkREGMzrKtA7tD7+ri2KhI5/DSwkiUuWt5BCtuUlPI1MWGucC8s
	ztJFoLXnBXgm+sE1aptZsYI0211ELyot4m2pjSPP/U0juE57yCMxGHDGroDESQssMwSrqr2Hn4d
	GZVRKHEONz50kW5oVjed+YFjVG/vtFxl1cOxWOTKM5QbUrNIGbwrVXu4IrRWdcimvzfsF/bryDV
	O8xsKayCDD+d0cfQVsWeXHCTEe9u3x4JofsEsLjVE/kMzIqVJFXdvknvUuov4Ld93sG2lomKqzl
	GRBx+CMB8js9RJZqbd+vWrSfTq8WBcUvuA11n/L9
X-Google-Smtp-Source: AGHT+IHD+PPPsiCu5zmlf4BXvZiknDU7ki7ic3iIHJldT8fSOQChy6aP9BgznrJDW+GYucwMXnhBig==
X-Received: by 2002:a92:cd8e:0:b0:3d0:4e2b:9bbb with SMTP id e9e14a558f8ab-3d441a1e474mr197479855ab.21.1741614543435;
        Mon, 10 Mar 2025 06:49:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43fd73234sm19636665ab.0.2025.03.10.06.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:49:02 -0700 (PDT)
Message-ID: <a254a3b0-1913-45e3-aaf0-97486d4c4cbf@kernel.dk>
Date: Mon, 10 Mar 2025 07:49:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether
 a u64 variable < 0
To: Coly Li <i@coly.li>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250309160556.42854-1-colyli@kernel.org>
 <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
 <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
 <DB1BA32F-C77C-4606-A886-B519ADC3FCB5@coly.li>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <DB1BA32F-C77C-4606-A886-B519ADC3FCB5@coly.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 7:44 AM, Coly Li wrote:
> 
> 
>> 2025?3?10? 21:42?Jens Axboe <axboe@kernel.dk> ???
>>
>> On 3/9/25 10:12 AM, Coly Li wrote:
>>> Hi Jens,
>>>
>>> Could you please take a look at it and pick this patch into the for-6.15/block branch? The patch is generated based on the for-6.15/block branch.
>>
>> Just a heads-up - you don't need to send these emails outside of
>> just sending the patch, I do get the patches. If I didn't, then that'd
>> be a problem. If you feel patches need extra context, then just do a
>> cover letter for them.
> 
> So if you are the receiver of the patch email, then I don?t need to
> worry that you will treat it as a normal patch for review. Can I take
> this as a rule?

Yes of course - I don't think I've ever seen anyone else send out a
patch with a followup a few minutes later to apply it. Just send out the
patch, and it should get applied. If it doesn't after a week or
whatever, then feel free to send a reminder. But a reminder to apply it
a few min after the original patch is a bit unusual and odd.

-- 
Jens Axboe
