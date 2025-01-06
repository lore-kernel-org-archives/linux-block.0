Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C082D98
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177912; cv=none; b=Z9IvnboYi6vZ9MQPC1wSCnqBfpYtpyz6PmTulVrK9FMwyIx8Byr/AzUTbLAVcgEy7ayNvW6axDWLRfUGqBWLIJZB5E1XrUZUvJTb7RK76SnKCPBRzheFOIO1YIamxvNx2zmLuPuN0fAsmj+7/Dzdndv9X5w1dSWAUJ4Vx0TpRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177912; c=relaxed/simple;
	bh=jW7G0+pjppME1ZYwSWo7lZTLVXmh94JMihX8bh+riA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMUQp4rYjdL5nApseOk49SHufUshSb0srC7CHpelBvSgtzUoFOKC6Jm8i49gx4sWrcVzvjvCR2myBWN6rZ1V/ffWYBwiqrs91xtVsWr6DcAz+a6u2zLLxEV7QVknVjyJiyBO+g6lqyIhJ9EBz0XOJwzJD9RPjVGLj5VasTibG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wvVpw1eU; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wvVpw1eU"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a817ee9936so56310065ab.2
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736177908; x=1736782708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wT9GFgKYnEsI7p/MDDWNGhd7M1QAwfOrz/PBlKvB/Xw=;
        b=wvVpw1eUQo/VRoGtRZ8lLgj0e2xIfNiUmIdpK9DZDcqNxjjV16fpamVJvKtCM2o/32
         w0dj2IgPS4qm5YQlVT4foWMu/f60nmACroGNbD2aXzv8pxnFND5u4lxgAIhoM5cwEK/n
         YGg6nWVmUgUFlpIQ9NsgrVduxDQizBGJyT2ES7tPBwN6sd/GyqBym6VEeggYwEBTHd5Q
         o/k67+9DoNN/irJtK5WBRFnt3p8XASXq24zWcx1arO49REXWF06ug9rGVKIodFW6Rinx
         wAp6dVn6IvC7976hQ3bRTxOsJvytA5l6Jr2GndQGEXbLfph9zjQHlT+OAOGXUt79Y8ZT
         4Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177908; x=1736782708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT9GFgKYnEsI7p/MDDWNGhd7M1QAwfOrz/PBlKvB/Xw=;
        b=N6ZJYY1MPifAxTLjI4wvkCLoXh+NMY4MJYX5zBRjZ3gSjQ/YQkws9Zo4vI+uREbI1Z
         4xNH1/NcT1lOcfSSIId4AA7vKZFyGowi1CI69+l9yZMLRE+pqwJTkdK4enP1PoypE18A
         kofjdmbkseslmS+hW8K9EYuaNpNoEHQDRz0Mo5ipVq6/DmxyDF+xwx1qfYXjnFptmMSL
         L3Zw2v+6Pc/kPmJ11g3qyI2bYyZD45JkJXJzA1hNtG28BMwF/Dd3SWjKuLKZI16u0zca
         IPz8u313jGHJ93Pzr/iGaKP+a9I/zEYd6UVEgyGEWXY7JnJn/LpZ85498sK72JySMsEf
         7VmA==
X-Forwarded-Encrypted: i=1; AJvYcCVDAvQ8fN9JLBITrAusluT8ca2Lo50lhbEhK2Im3bLPB/n0Sr4PLo/4/dJGPIzCPDUAvvK+TZAqeDzjRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLwfbw0mv21NRflqfiHpTDvCYNmwo6MMuRODPMow71IO8jLrw
	eC7d48yY39hGG7vuYavnnDWEpDk7OduYNzCKbXO/tJCdQUe2gB+r4issTq3ITL4=
X-Gm-Gg: ASbGnctXFbljHsl/F19sBr5BJ7+q0RAFcAkOyCGti+qk9jqWt8OPaVdCFn9vHF1tqxL
	1+CZU8LvmTVg/e3Ovz3P66Lueaa7RYDwk5unvqt7gXThX+ABYcZ8jxj0OB7ZSK4B66/GLK+MNkX
	fufIu6Z9Tu2ePQVtZSl7BcxWTnMKP2T8OtR71LRdJYw+gwLfonJW5fb1Meqjvl/bBWWky+hxFy0
	KNWWOqMZDgS3jyckUE4XB9fFod8pMdvz71qWh3+y4MDMGc7zcIz
X-Google-Smtp-Source: AGHT+IF+5/n8Bg/MTdify4prIUEMt/t0DBWxvF58Sg/2X+7Ng9GP89iS5GJ1+GzSsVNur8KhaKg5vw==
X-Received: by 2002:a05:6e02:1c87:b0:3a7:172f:1299 with SMTP id e9e14a558f8ab-3c2d2d50d0dmr506266855ab.12.1736177907911;
        Mon, 06 Jan 2025 07:38:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e47d6cdcsm97666775ab.71.2025.01.06.07.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:38:27 -0800 (PST)
Message-ID: <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
Date: Mon, 6 Jan 2025 08:38:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250106153252.GA27739@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 8:32 AM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 08:24:06AM -0700, Jens Axboe wrote:
>> A lot more code where?
> 
> Very good and relevant question.  Some random new repo that no one knows
> about?  Not very helpful.  xfstests itself?  Maybe, but that would just
> means other users have to fork it.

Why would they have to fork it? Just put it in xfstests itself. These
are very weak reasons, imho.

>> Not in the kernel. And now we're stuck with a new
>> driver for a relatively niche use case. Seems like a bad tradeoff to me.
> 
> Seriously, if you can't Damien and me to maintain a little driver
> using completely standard interfaces without any magic you'll have
> different problems keepign the block layer alive :)

Asking "why do we need this driver, when we can accomplish the same with
existing stuff" is a valid question, and I'm a bit puzzled why we can't
just have a reasonable discussion about this. If that simple question
can't be asked, and answered suitably, then something is really amiss.

-- 
Jens Axboe
