Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BB40759B
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120097; cv=none; b=HmK8woUxF8qLZK4hkutgWuZNJlzjlPlL+n2EgapPJ5KU1qAkjU2AbbL6iMEYQyU6vOIEZOwd9qDx8etIRQyK2hNQJrqL5IyS77M5iS8WSyEBlhHB7/6J31o38JCb8TUGic4+Kow3Ccxvtwqa04pLrG6Or0zplgcxJW6MQfHU8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120097; c=relaxed/simple;
	bh=CmpQfeKQ3c23DF9WG94eNbscEnNFeMzCrpIf+OFP+KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gA6I2ArRxloqPf000KU/3PlUbwMrBQmp/19IBMCcnb8Mg0wMhmJeHDqdWmezKZ3m0L/Pxtb/op9xUOFp3i0AcTTEwqx9Xmgokd5WnCI1L3SwlsX+33FgXpgUo/G6vOh2faIC+8queaS81vhUP1QzmziOXNt1U5CkjQ7e3T+oBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2etqNwCc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2etqNwCc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be94eeacso561372a34.2
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772120093; x=1772724893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ec1fsZICs235UQOOmgcq4jhVhXuOfPidqNqU/OF7JpA=;
        b=2etqNwCcV2WasnhW7Fy9LUKEAyIIyLX/+/7GVZZGhrnelgT3rbO60uYyuShn0ffIYX
         9JBkNsnASqcDfgWRrQbdSv2Vk8/xp3pzSVRsNIjHjxcHTWoAMkGICmQpf6sih0n5Z0Ks
         juocUEwJbdo1eCvXDs6OjYPiMrxij4yDlEf1/vRN7of9tyHU5tE82+LRwW13eruWQv3f
         p1g9kuEiKH4cfF/OoH1Fx6QDXoXDp574TgGzT8OwdWtYS1UwpKIQx3+3wPPAzCCAmd5G
         AUCxNEQu++IlKQzwIUeumVFZovVMqVhkWpdAUQo+9wXm8+4+liLQ0LFtIr3l3VhTdD50
         DYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120093; x=1772724893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec1fsZICs235UQOOmgcq4jhVhXuOfPidqNqU/OF7JpA=;
        b=FsghZI9uE5MOkV9NAO8lr6h77ztiMKJBZddB4gbmKjZZNGXAWD+6/kDVB9qa5Cm0hv
         /csDpHllDXEnvkncRukLRlbmrzNKmQqv/yR9TnbY9zGaYWdZ8UGK9+MuuQO1DhQi40Jg
         MUlNHHLOB4fTTbXSwHb5mtjLFRh1b8BwZ2MhU1xc/tKsPaDYCfetXCjySHR8MSo+oyHU
         bjxEGG3fL58O8ttrxpwkbKaCYEOhp/J6NeUOokqQQ6eg8+AaetnbE8FG+RnZ17UdBs4z
         xf6PK6kn7CW044qyeKTypl5anqMDsPAVK+ahiSD+EkwLxv+RsuAWgDTUK7MEuo5MeW9L
         Rx4g==
X-Forwarded-Encrypted: i=1; AJvYcCVUrNugNGOFW6jfowmbFUf9NQ76flLl6DgevHMZBuyqY2ST6BZ2DvhaUvo4xO5ctmVEMW3Wnb/CBlxHYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdhuKcYxoi8hdTl+Gags/YrCehiY6hPRsW62l6v7D2Yt6r2ap
	hSBc7eC//voJfdyM27seiuW2jSxQuHfmbrCxIKnIVxnmQXtinefA3V+pw7tNY0O/mFk=
X-Gm-Gg: ATEYQzx+EVW6l1NWxj0POe9PTWqbBm2uKiIwjKaLiJLWRltHVxX+ov/VmAs6PtAPu1U
	Akkl4mQKrlGtMLE9Iv6X0E0OfJn9YI4dZBe4dmpokuvb1mY/xGwvxPLtCVf1ueeRaPLDMAA9PPd
	SLRVAmr5VAJDtuiHPrjV27YDSmLbll8bXaTmFMPbl59JjJxegvaTMAicJUgebJEzWZrblumcQpH
	qmyQKt6ESJ7Zo1QrIu0g6FnIkXfUuStxL1CAAzYRXxNs/XJ3wtfdOD63vcqdBkyRI2w01Cm8hi8
	2LzZvEBxh77ca0Exjutzu6KVuemkwmDDLAk3WJY/a3pKp9qC91TVWFPjVkFlD6QZM6aHg654H5R
	Z3m7d2Rw3qjDNfHJ93mWBKfaInRH0T/PA/JrmxoMundcWUQUJvKl0BuUOzyFRPSLl7GJHQPNvdc
	U5RVUZtaloifDA903D/lQg3nVU4KHd5I1D2GRpbapkYVxYAFOoCiaScUotPw7KTK2vZrVZ4B+8X
	WbBHDsoiA==
X-Received: by 2002:a05:6830:2654:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7d586f55eb8mr1430172a34.28.1772120093644;
        Thu, 26 Feb 2026 07:34:53 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586226d14sm2041906a34.0.2026.02.26.07.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:34:53 -0800 (PST)
Message-ID: <e8421e61-c3fe-40de-a812-b0438f9d6c48@kernel.dk>
Date: Thu, 26 Feb 2026 08:34:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Extend Single User Mode (SUM) support in sed-opal.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-1-okozina@redhat.com>
 <5d95944b-b54f-45ce-8512-1e6c3438c404@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5d95944b-b54f-45ce-8512-1e6c3438c404@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 6:47 AM, Ondrej Kozina wrote:
> Hi,
> 
> a gentle ping: is there anything I can improve on in the patch set?

I can queue it up for 7.1.

-- 
Jens Axboe

