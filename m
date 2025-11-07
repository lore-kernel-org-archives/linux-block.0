Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6E2D1F61
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477966; cv=none; b=WLPRYUFvTEq37HKKO9i9KUf1a2Q8WNcfLfwamIxUxCA6J1ZGJX7Pd/ImTUGRCmcobTKlznxh0DN4+e8uUrP2kEBeE9/xIshoAH3PlRBk2bBKkZEeHYMZbmeqKWfqCMnySgFrJnlrnrgVgl2boH8JNTnjq8w/nzySnj8Ul+XiYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477966; c=relaxed/simple;
	bh=QeEVk6HxkhUHsrHxFF6Oeiz6ByCYycDLQ2xcM6OC+As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfaCxqj7T1SAh6ldSxrK6bUklbeyMr5g9+zsf8UMZZEcAYtJNmNvA11nAUHTyxra5P+oPXgwvPMH20gHBz1w5IwGIAOsr4IhxX++PzTzoIE80Szfk3By0noaDnAWdTkVDwa5TlLmbz+UfZR8UbB9RKiOi/OyIlwBv6inGwZdkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mqStijPv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mqStijPv"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88040cfadbfso1618106d6.0
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762477963; x=1763082763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbOfTv6aZMJwJYebFXUGpLKkO3C9MvIV+S6DwLivmkg=;
        b=mqStijPvnqDG49U7PrqqzFSNV7Jjk00m/MKntLJbLGFGWmgQ1aIwc9iV5colVEEsGd
         la/uCi4la2Y7J1IGWFaODwDmy06y6srU6IDM/0IAaIv8U23BnKeQhg3JbeyXugNmVtir
         YYYttNNwdvj4PRB9Ic7NAjBNSowDG8UrI5X3sSe0WbuEx8S6z9oSH6GMMq6OI8GpXmKp
         WtajcDfkmpzS0JRRAms2qwLAJBI+rQZxYnbU/tVHdym4N8hZTF9kX1cSFRrqcOkzD/rz
         Q2H3o+SOXh2LzZCXvPXOOfg+GS2fvY/ew4EWTSoNn2LNuV+ajAMCO79QrtrWGbW4LcTg
         JxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477963; x=1763082763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbOfTv6aZMJwJYebFXUGpLKkO3C9MvIV+S6DwLivmkg=;
        b=mmBy92g6tSqCwpyqxQXM2UrywOfCv8DMTjdmD0NRTVvvJcxwi7FranyyBwqPIZYNbV
         /SqJNkda43721WLK/i18ltvIWjfOVbzWaLcCc5+1rWwgELpzbwaxWN29f4wkS38ZFN7R
         w1x0rsrrH168rqYxeUt5wCEUXyiD3rbXZuNBS3H7J8z6/5vucWSm35RXWfPCOETqJ+Kt
         Gw3qf/vcdgMKcqOIVy4wRN8j94UZ6jRkRO/vZWl7NYet8aM0M7xHYukHR8PhPaE3352r
         mfgnHQnHWWm2vuert7MGAYMfWmZgIoBMYeaQiqzDBPhFpnftAjFnYiZGIuk5pPTzkn5M
         o2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWITsd+9fVxwu8TMPcmB9smrcZ8thAVTK/VlYmsLVRkrxHT1Wy3nYm1N6IvbHqEQuGKL3QM4gFfqt1KQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/Q0+hSO1Lhn0SySol9NINnauaoiqCpMWW7CxCyKTyYdU3Vk2
	1+lwKeRm0xZwktgxIjsRmuNNzzvLj4fqz6stDhocjqvV/TFCcbhFCBiJWR7bJ7sIlg8=
X-Gm-Gg: ASbGncsfNQQtw7ghKGKkdtVh01XbQ+h71ndpyv4kYpl/AJtp+82CId0hcsPxO2zS5xX
	+EANIL4GHXuVv1Bz6XGOhCFd9bfYuI3ZM1PeY79XrXMEwq8QxnuaBhSrh2cwm00OAG068hmn1LY
	hwYcTZ3ozXPFy+QBsjBGs9uVjH6n+UTNbAF1dHStb/PVdfN4zhp5EvgRqcRAaF18J3ai/LM/L/+
	ybzvW3l2UQloaxowO9VwnT4Lh/LTQjLIUWHrWOHO/fyNwfmEpTCy+7qa86wPBLhzkaZOTcLHNp5
	rjmWmNX9UGnxhLGEPwgtuNGE6AGAmGe0PmphyOTiBR4T39Yo2+DhJnhwa+HuF2S7KL6eqvvrAme
	brkvqTTxPB6/3fDVmAtzW/omYP058W29t5z6NkRZNnBnl6QAGWWxfLD2ZLCugDBpEQUPPe/OM
X-Google-Smtp-Source: AGHT+IG8/wvtChgl0Oj/AdYZuMbFxSekQdhXD7/Z4xI+xovxQES5Hc+/nbL8jisSWsqgNfQX7l33kQ==
X-Received: by 2002:a05:6214:2126:b0:880:4898:d74 with SMTP id 6a1803df08f44-880829088eamr60575676d6.20.1762477962806;
        Thu, 06 Nov 2025 17:12:42 -0800 (PST)
Received: from [10.0.0.167] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37b9esm29305616d6.52.2025.11.06.17.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 17:12:42 -0800 (PST)
Message-ID: <f12584c7-4f91-4d22-828e-cc64ee935110@kernel.dk>
Date: Thu, 6 Nov 2025 18:12:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20251014150456.2219261-1-kbusch@meta.com>
 <aQ1Fa7hPssIFOBLg@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aQ1Fa7hPssIFOBLg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 6:03 PM, Keith Busch wrote:
> On Tue, Oct 14, 2025 at 08:04:54AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The purpose is to allow optimization decisions to happen per IO, and
>> flexibility to utilize unaligned buffers for hardware that supports it.
> 
> Hi Jens,
> 
> Did you have a chance to consider this one? Thanks,

Looks like I missed this as it was during my last race^Wpto, now
queued up!

-- 
Jens Axboe

