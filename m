Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF03E1681
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368098; cv=none; b=DNeiYarV6SRzLcB+tfTimv32rywndrdsQKJmlMPQYUYNJMZ8lmelWD0lJWPQvRftqPqVBNEpeYMYBKHlmF5H3In3Kylf8KXqobTnADswh3w2gOyeVcFSX1QiFYgU6qCYtZ1qt2Q5BiwhtkiRoaX260uWNyJh2emfXxGkLTnD+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368098; c=relaxed/simple;
	bh=RB9HtFl61EAJfv6VC2+ERAfKhcFBRkXCobO4AlkIj4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6bGBtZQ3m/clxbu0Qz3c16OzELwj7njky/GrEpbkrAg2YI6BKcMwMiwqqTh4aal7YT17IAmplzTH5xj0718JhNnr7ADthrbCIgwD2PVm73JaQUEYWTFcWjPfnX8eLhgWHYEIIFJSaBGq56PQHWaBuAu/1d8H/0uy07vmheyVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jjVK0bYE; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jjVK0bYE"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6ab021f1daeso619051eaf.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785368095; x=1785972895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uzflvLSuPG8CH9KOQG8sh8lUY8SKMS16BLacdgskhM=;
        b=jjVK0bYEjfCQLj+ksJlNqWT57nGaGb3ye1tsu16Hjz3FQbuSh6aNtFoHClwbsVt8FT
         Vu5/TCWMbG7k9NYnq51BW2ZRaYt1CP+ucaCkFXlknZTa43TXqYneCVckAhVreZW15gai
         2NGqjmfaHXYz0RkSibHuKr4Q5bcrlgam0i+GUi77pHoJbDxz1GU7A9FYC1JjDm+q4/AX
         zYRh0RYNcZjwKkcN+9sp3WKz6tczCS6POfKks32hYWVtMOeFBdbDDOalQMkj71+7a+T3
         JItbUxICJlTLIAv1dEznP3s7haMY9F5SOh7zqJ/CHi56zTbRSwu5PsNzky1lJK59ffCL
         Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785368095; x=1785972895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uzflvLSuPG8CH9KOQG8sh8lUY8SKMS16BLacdgskhM=;
        b=CLTa2ZevoEmcOgY+kg2U6EmITu5RKHmZl+gri//+6juVauF0iZwRe8jnCGkOtKD3KV
         JH0lBwMTS1Vgkk4CpC/VicerjiWBD/rAxhDbTVWJqMaSxZqTmxR8bTJhk7MHuHdJtqMj
         HvcmFxAi7jvRHIg5le8CB1J3MlJchAVRkbgxTq71+mg+MzbDflEKpczTMYLjEtyVcXqg
         Q0wh3cSbnCowcQC2P+iF3mgQ5JYg1QDarB2SCZhk1YjZVr37kI2JVzOo6WA/QX0Q8Wtb
         Y2HjPbROvJ5jajUn0W+SuncfIljLXQH/yDZA4NtpHfLd9K840rzDtYM5hEjnVGEe3gYu
         xnXg==
X-Forwarded-Encrypted: i=1; AHgh+RoO+WLk4977UCwqjvNlFyXW4nPLma+fhqLmiaBr59G+ohn9/nzj3W3pWNYKnbQUH5Xlo+wZ3PPXYKQp1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1oSbGT/0n0/tIcsFzUlqBtMXT6ykedHiJxNMyUXVqns8fiLa
	mn8GGWhBfQTdYWBqwv/yUa1BdJIEtnq2ajNffoY/sCEAHFua66GKwJYLCOVPWZxd338=
X-Gm-Gg: AR+sD10bu7iNyIM5ER/+kTIWhjatOpfniC7kXZfSKp/flR7Xb01yYIFlyrohi4/z6Ig
	T464T875bi0DNz3hOSo+At5Vhs5YAKwIgRWybhNE31htr9jpQfs0oHp0N7d4iYj4hgwqHdqC3Z4
	XdA9U9lKq9rOXeWp8scqN1b+fslT3ZlvNFgQBWzPt+3FKkeWzBFX7jH9Fj5wX1Y6c+8nypMPNvE
	ONOxp+AUIyh1s39WrtzxrHUPxuyMQOXukfXezW6NAnxoJxv52Jo1ZcnLMPuQHzU3GNFSLSugsn2
	xIJF6eH11VNPzUERlSa2Fdvw34In+7SRyyDmlD7qt5C8LLjv35SMl6FTXlnGStrcgaMY4sNDVMh
	nBMoggiX7DzH2yLc4goCmkqODePL55z0SXXwYP6n5eKHaQpHmDjHzwyCCqjCulrVoFkb9jdGc75
	GlTe9cTnam1uLBeVHwvGMyacxVwKdMJ5fJhpYUCPSxqYiG/f1fBKXNk5ow08+MQ0/Ivr6hEn8qX
	mrVxMdhm1OIsgnzpnJEMUJhDCjFcGbHf3Y355PF/ENTg6M=
X-Received: by 2002:a05:6820:80c1:b0:6aa:e844:fb22 with SMTP id 006d021491bc7-6acbbcfa066mr243418eaf.11.1785368095394;
        Wed, 29 Jul 2026 16:34:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6acbc29be1asm222785eaf.5.2026.07.29.16.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 16:34:53 -0700 (PDT)
Message-ID: <831ba530-b6a0-42ed-b636-10b1f89b6142@kernel.dk>
Date: Wed, 29 Jul 2026 17:34:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, hch@lst.de,
 brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
 <ampce7mxSmxAwAiu@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ampce7mxSmxAwAiu@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 2:03 PM, Keith Busch wrote:
> On Wed, Jul 29, 2026 at 01:18:40PM -0600, Jens Axboe wrote:
>> On 7/29/26 1:15 PM, Keith Busch wrote:
>>> On Mon, Jul 20, 2026 at 01:10:52PM -0700, Keith Busch wrote:
>>>> This addresses the misaligned direct-io problem behind various threads:
>>>
>>> Hi Jens, have you had a chance to look at this one yet? This addresses
>>> previous issues with certain device mappers under direct io.
>>
>> I they look fine, but at this point we should toss them into 7.3. Yes
>> I know there are regressions around this, but from 6.1x days. And the
>> series doesn't apply to the current block-7.2 anyway.
> 
> This series is kind of old at this point, but yes, it's not fixing a new
> regression either. I'm okay if this goes to the next window, and I will
> handle the stable follow-up.

OK good, let's do that then.

> Are you planning to start the for-7.3/block branch soon? I can rebase
> the series if there's a conflict, and would be great to get this exposed
> to linux-next.

Pushed one out - send a new version and I'll get it applied when it
shows up.

-- 
Jens Axboe
