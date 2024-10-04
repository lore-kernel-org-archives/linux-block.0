Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A101ADFE7;
	Fri,  4 Oct 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069713; cv=none; b=Jzbhf2MoHI4+fY4scFnoZ1aZO/JP1S++3z48/XmeLFb0bM3XCYyBg42d8NuXV9rIkaZzIkvSdVMlmhaKUuDqZx/lYQVW2zHlmDWhyI6diFbTcTea5A3fhjbl5+gbp1dwx4Q7LvSVTUOveJrrxtNH+YH4z0AQdBZhevgSWOUoEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069713; c=relaxed/simple;
	bh=346A+svTjdFHO6vDd1VqvxiF054q2dvBKRFDsvXD2hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyCaO2Or1zGMzQFM2OEhpXZ92h/uUsjji2Rl7MvsJtPtqPr0qfs5+ksE8hUcvDevMyEy2GSeF1cpJvAydwDqehM+Wv3f5GaurW1hTj/EhUli8ZWIKpGW+3WpRsMXCUdePlDTpswOW11uoJ38tMDnwxUvUoe1Zzg2Rwq8rCvXoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP93C78Q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP93C78Q"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so2198669f8f.1;
        Fri, 04 Oct 2024 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728069711; x=1728674511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ccNtOw2mhq5kf0US4XfxiOdXqYI8basj0T13qKTL6/U=;
        b=KP93C78Qtu8qFPx8qZmqo4gqpM4m1WAMzrCgzekWcvlSVDwmjKWN25t7pq00+ElkEJ
         k5LY8jIBzrvBUut3vXQkwIhDCZk8UZfpmYx+sGiK0I6bJyFnpUohqbu0u07hPjB9PG5J
         0Aeb1MZJGcgyiAiBlHpl7FTcDEvhkP1eAdpOADPUL2a/TQTvnTGGTN6TWSd1HUfXdvlY
         X9qZiTglINzLkUPOzgyGD5pGrnmmBguqrLIH+zt1ChZbF+DO9R+sOQKoFdp8TeGlwsXl
         OZRThvhjHRM1ZXkX8pDYQDa73ewKAMJ/DkLAMHKEAjFJW8II8OPPUyzkCryMXv1Y6hhU
         sJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069711; x=1728674511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccNtOw2mhq5kf0US4XfxiOdXqYI8basj0T13qKTL6/U=;
        b=oj8DVKAKcwnVHqxXT46jdZUrZsy7u9OtAT6jO9cNnECs1VxgOU0Bs2KPCIskV60c/v
         0SkX+5yj8itJyN08L0dVOLVUv7gogxncDQmaet0iGDfWQFWAo5z7eC81hHbk0Q9+osJq
         MvyQ0gtOGXxYaiu8R+h0ixVXtRR4EEEANjQTDdusNSFaKd22UekfonpBhX4reGHPPEHa
         JYWnPcKEQ1HZWgMUlbQRhSPXxXBt3pT6QJhVDfr1lMAMK7/iJ+dZ8PmweOWRXNKCvoKx
         QToEQQjQCguwjKhea8JtdGAmlk/8MFH8bzALzA8Kz3dsM2JQ2W8F6lCwneh6nSHYYCk7
         0UPA==
X-Forwarded-Encrypted: i=1; AJvYcCUptrjo++kmXLTAQnn2QD7Bi54cZgaVzKUzXiMeqyjPRruiACejfQTEjkMXZHGZUZtm6rccIJYYD9lWEQ==@vger.kernel.org, AJvYcCWRvdKU8n8e9h6p9K+LhSDjV2Zgfped3bzqUTV6T6YUS0SGOjmTgMydn3B9d9IShA3FbM1ftUfos1cBTyqO@vger.kernel.org
X-Gm-Message-State: AOJu0YwibeQHtQvctAE/+JMDXqGyILnfa7g1CqRsFOmnhjUJnM85//rX
	S7sJmEN63Wa1LOpSjR3roqxajl8HGpdjFoJGIfkac/jGgLHUOnOm
X-Google-Smtp-Source: AGHT+IFXxjVm7FyWVzAx21xIqrQ6IYoyVnE6yaOvrZa2p6pa+yQz5BtS3AAiAg9eL+sb9Mglr4X28Q==
X-Received: by 2002:adf:8bd4:0:b0:37c:d53a:612e with SMTP id ffacd0b85a97d-37d0e8f13b8mr3340069f8f.51.1728069710377;
        Fri, 04 Oct 2024 12:21:50 -0700 (PDT)
Received: from [192.168.8.101] (78-80-113-112.customers.tmcz.cz. [78.80.113.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cd2sm273374f8f.62.2024.10.04.12.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:21:49 -0700 (PDT)
Message-ID: <f335366a-3752-4272-8592-fe1ed9f43aee@gmail.com>
Date: Fri, 4 Oct 2024 21:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH] dm-inlinecrypt: add target for inline block device
 encryption
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Israel Rukshin <israelr@nvidia.com>
References: <20241004004152.8845-1-ebiggers@kernel.org>
 <Zv-Ap9E2r1bRT2Wm@infradead.org> <20241004184819.GA86456@google.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20241004184819.GA86456@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 8:48 PM, Eric Biggers wrote:
> On Thu, Oct 03, 2024 at 10:44:07PM -0700, Christoph Hellwig wrote:
>> On Thu, Oct 03, 2024 at 05:41:52PM -0700, Eric Biggers wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> Add a new device-mapper target "dm-inlinecrypt" that is similar to
>>> dm-crypt but uses the blk-crypto API instead of the regular crypto API.
>>> This allows it to take advantage of inline encryption hardware such as
>>> that commonly built into UFS host controllers.
>>>
>>> The table syntax matches dm-crypt's, but for now only a stripped-down
>>> set of parameters is supported.  For example, for now AES-256-XTS is the
>>> only supported cipher.
>>
>> Maybe I'm stepping into a mine-field here, but if this simply uses
>> blk-crypto to accellerate a subset of dm-crypt, why isn't dm-crypt
>> simply enhanced to use blk-crypto when available?
>> compatible,
>>
> 
> Milan Broz (cryptsetup maintainer) has said that he prefers a separate dm
> target.  See
> https://lore.kernel.org/dm-devel/9ef95bbc-4eee-4c00-f199-0daa3cdd03ed@gmail.com/
> 
> That was a couple years ago though, and this discussion seems to have gone
> around in a circle.  Maybe things have changed.

There was another discussion recently. I also discussed this with Mikulas
as DM maintainer, and we agreed this is the best way.

Extending dm-crypt is possible, but the dm-crypt threat model should not allow
pushing plaintext down the level.
(I am currently investigating several issues with Opal hw encryption that just
cannot happen with sw dm-crypt. We opened can of worms supporting it in LUKS. :)

Actually, I like the inline encryption logic (and the sw fallback), just I would
prefer we clearly separate the code here (and dm-crypt is already complicated enough).

> A dm-crypt extension sounds fine to me too, though keep in mind there will
> eventually be inline crypto exclusive features such as hardware-wrapped keys.

Milan

