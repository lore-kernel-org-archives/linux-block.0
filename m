Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D398363C69
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189781; cv=none; b=d5uRVIP6I/D+9EB8RLrjFbBEPZtAXMsrSPan8XA4H1x/lyLTJER1STUL6dCH3i8+F26XGmAvXE3xoWNh8sGcXZA4xmwmsgi4Pl+CDYEez6J/X4xo8bGJJy18d7hlq7D6rDnwJ8FaCK9klS5fKg//QO/rh2yQ2zEgVClVRqEU5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189781; c=relaxed/simple;
	bh=DHiLsipr4skFAI+dJq2lPNkENskIRoxGBtjbvilllQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHfUy1pLAKDuxryi2Ag/hiCVGIfPtrU+v8cqJY0r60VC17TFiDxpdWHnqLuuDJKAjVadPe/DBEVjC+FXy5JnSOhGPF1IHc9aKCHj7bL+7Tcyt7QBHEYWahBy2NFzaFHwKwUDQ+hdA60dsio7D40lFOYKUxdlRai4BiBkFaFZ4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eJKoAS44; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eJKoAS44"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46808125d28so545984b6e.1
        for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774189778; x=1774794578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj7ZP+p/L2RJvrz7ry3hoB/fyFvBi0CD/xL/gfPc3sw=;
        b=eJKoAS44s/4R1MiBBfNxH7IW1vC5PV/uGmFgPJqqx6X6wX2aB0VogrrLKaUj5Usc8A
         BKHtDYO4HGN7+dEikHy/vrid/RMPCHz+0TMPRMBhAKwL941vSHKChWhqCclp9P+xvFMC
         YTI21LLuHjEewtKU3lSJjC1GGqi+re+r6oA1ePHKFzea3zGOSNfI/aFrXRRs/m91HqBU
         GanHBwuBsP+uS/K3wiU2RtZb7J6LEH2C01eSUNza/U+iQDB1ubJJCkiRCPL7lRNOwx4s
         uDrmhH/6QlVY1hrCQPphPwvDNtQGljM6w+hamrvHDxN/M/Ar7kBmjm3W8/7WkhuUdvzK
         3C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189778; x=1774794578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj7ZP+p/L2RJvrz7ry3hoB/fyFvBi0CD/xL/gfPc3sw=;
        b=BNlO7wKFRZNsP/hTX1DnciGJ7QqMyanSYwG0TwNXw8rxPL+4L+XEz36BUMIvq2JIsf
         qNlbje8goeGHnmg8D6v/y7Dalih/XZbFSQI3QgENlm9inwZkidxIP4fVO8nEfrzfpDFw
         hcjm3UNRWdXxu1KZRK6UvDbuWmGljqeTFRwadIUOfdpPIjQ+OTwoe4e8Zm6XtJJ0Zf72
         +2+sQIFb8t0v2dGNcKWssoQwRIEYgJDvQt5fw3Ugyp94+KTvFG0cCKLVctiw0N2ro7cD
         RAfrWD+lFKf9qtHrqF7M4eZEUyl2FkxkW1UoBluJRLONMMQMYauC8JE2sYPg7QrdVYXE
         l9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXOeEaV5sDitY6PffE4TvouZy7ZHmPYYTHzrlI/N5jnfleo+l9AvhD1qMHtHdIispAHIdQx7/v2uLcGWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZuNFvoOejbbwXEvwxaD9po/kL/8cNIW+iRcS6YTHtzF/PTnU
	TQKU9YH163leMnGyvJsatIAAhndTNnKx+dTKyS+HpR84lg72NecCY3gqDla2kTzq8lM=
X-Gm-Gg: ATEYQzw47Ru/jZxcunVRJ6a3C9LlkyjtOY2X1WjexYDwZn0ofuxR1XS+GpElB7xaxQZ
	I0ABikWlVEONI8V+voycaoKu3dJYtq+f5XJFJAw7G71xOD9GTpADnRZ9sUY1MmFXEb0er+GWehZ
	1Zkg7v5+HLOXNFfMnj8ZnP7U8N36o/VnpToMwnVLZzEdfc8xUBZDtpMPfmpq7qaGIHVWra8QCiR
	0Lnb409meuFVF+puAZVCkyH0v1CVDa6dx8NUH9/jafB6HwFH17iMkInxKj7QYwK31Z3C+yyvAnm
	850cxKz3fGOBDHaTwG8U6n+hmYg7FDvSNK/Yg6vJJ9HEmw/tDOnyfH8jsChnkyrRd+0P9GQLE5w
	ORWl5/9OkYudtJy/E6j81df3vikQDdb5QMF0nA15njdKv4Zg1B+vo+aN1oLUxAwdToAFtmiN2kK
	FLwRUelu8BRnQkdYrTEYW6sUlmBucjCUZJAjRCDeieaQHMVZge09ojN6+wsqyABI7PbBq8eFwll
	JFal7GalA==
X-Received: by 2002:a05:6808:22a8:b0:467:de0e:feb6 with SMTP id 5614622812f47-467e5d23aa7mr5512040b6e.11.1774189777965;
        Sun, 22 Mar 2026 07:29:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ecc226sm5318041b6e.11.2026.03.22.07.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 07:29:36 -0700 (PDT)
Message-ID: <19ffae4b-1a53-4d5b-b641-7b429ff0199f@kernel.dk>
Date: Sun, 22 Mar 2026 08:29:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcache: fix cached_dev.sb_bio use-after-free and crash
To: colyli@fnnas.com, axboe@kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 Mingzhe Zou <mingzhe.zou@easystack.cn>, stable@vger.kernel.org
References: <20260322134102.480107-1-colyli@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260322134102.480107-1-colyli@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/26 7:41 AM, colyli@fnnas.com wrote:
> Change log,
> v2, fix emiail address type to stable kerenl.

Thankfully no typos in v2...

-- 
Jens Axboe
