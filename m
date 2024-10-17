Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B53227B8D;
	Thu, 17 Oct 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199006; cv=none; b=Enbf+ov8XyzRkSWU8Fjky5PHLBZARuh3XYJu6orCl9qWpWksoA7b5G6zQuY21nWHKDEAiUbiyZMTGhOMTTC+SLFDoWZMZPJ/wYPwf8pxWednqE8hfFcaV1Irt6kI1m+Cvzf4BqFsn4HPcLOh+WTUdUApBatTCKrx474sz0LxzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199006; c=relaxed/simple;
	bh=5c0OzaK5IWI8SBVrSXjzsZwgOScIKtQWIl0UEi3SCkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY/rFmLFjZIUEkzJ469a5g5Qy6mjScyx1D+7Nq8GJ2NIBfQVCbeAM/Uq9OZ5ke9iY9vQDA6ibhwDA7B9QOO+vfL7dNHZAED1Gi+x4wom8UqMsIYgsyxsextZ77WO/OFEMX5gcy6c+50tgkyUUwyQzMM7LWnPEf5cOOKpDrK/BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHYdLZTh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHYdLZTh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a4031f69fso191475566b.0;
        Thu, 17 Oct 2024 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729199003; x=1729803803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xwi/jLdpwjlMfrJap3Pht6f++ggFG8vC8WGAVFQM4q8=;
        b=HHYdLZTh8ueCttj7/ujrjfXwN8iLKIXhKAHLXIR0R25KBYsDVNNsTrqefZolx2t7Zb
         apetRblrDI0UGRcAlkMvEdnBuSVHQisvGJQtzmef1LAaLAQSTizu/QQfLgxPNEXdPbnO
         phZWZlgd5oBbLB7cZkjwbNPNPDnaqjhSezV0HKDCAPWabt5QKcjbyoxN+AhD4Xz/uu5h
         UE8oNN3Ggwnd1197NInSlHjp2G9Kiy4DU53TCNwKCqa47sHgTT0PAs53nUrH2XK/SCcd
         6asvNn8KwkoSCQeV2GmWhB8anWsOKeD4R/Vq+9JENJhnSCHTYDUUSUPBU6Ec4CinDHFH
         R8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199003; x=1729803803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwi/jLdpwjlMfrJap3Pht6f++ggFG8vC8WGAVFQM4q8=;
        b=lvqJE1I074alX8QccNgBBAcSF9jGjJnFmxv2k1vKYHBzgHNeujz8ThkZguXikNCScR
         RqC9NGTzwk3jTyXrMDv4l5hk6WQoVouHt5u5Kr1IgzNmMo8Fubw/o1hMuOR7+8ycTbUA
         945nL9HShVd9k17nTkKtKBLQ5XlUlDIIkdlv50hm1A6rcvwyHvsyHTZWHoD5R9CjMCRr
         3F7+na21c2BaKeoTznQJ3Ia29wqFTeBzVXe/hp1GaiwNr28m+j3a8hg6cRT2cH1R/yh1
         ShQcko0bwix5fBgO0TQ48KnJBY/mO3YIlM32EYyzm/MT9FuaoaS3psfilxxq2kogIxAq
         cRtw==
X-Forwarded-Encrypted: i=1; AJvYcCUNN4h8VtWwdtHnMAJYM8g6Vlxy6mBreD3MIqwmT4o+bnd4AaSSwmhGFv92DMVV5Cm8VFUy0A5fe74YrA==@vger.kernel.org, AJvYcCWq6K31bdUi9P7xEwM65wm4oVdC0vFvNHqkSokifcjxaYIUxDjThA565paYRtWthiAjwX9rFAdbFGqeVSNk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+PCelxPhzKiqkpI8Dz1+72t5tJWSCl2pWRa1qrBWGqDhUJcE
	9zCdLbJw3BHx4H8aiLe21WEy0GfXiIFqeF/seH2yrquRBfdcFsaW
X-Google-Smtp-Source: AGHT+IEzlb6TE6aNf7mV+L4jKpcVBGJHExhpZbaDN5yuxFRd+LKyEMVSD+59YXqLRCLPt9ghRmRv3w==
X-Received: by 2002:a17:907:7252:b0:a9a:134:9887 with SMTP id a640c23a62f3a-a9a69c9eb2dmr9383766b.41.1729199003273;
        Thu, 17 Oct 2024 14:03:23 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ad4dd7sm13201666b.68.2024.10.17.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:03:22 -0700 (PDT)
Message-ID: <ba4880b2-0569-4125-9670-0119d37d57b0@gmail.com>
Date: Thu, 17 Oct 2024 23:03:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 2/2] dm-inlinecrypt: add target for inline block
 device encryption
To: Eric Biggers <ebiggers@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Israel Rukshin <israelr@nvidia.com>, Mikulas Patocka <mpatocka@redhat.com>
References: <20241016232748.134211-1-ebiggers@kernel.org>
 <20241016232748.134211-3-ebiggers@kernel.org>
 <20241017194415.GA11717@sol.localdomain>
 <b8670e11-61d4-4831-8a21-2dda3c5db131@gmail.com>
 <20241017202852.GB11717@sol.localdomain>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 xsFNBE94p38BEADZRET8y1gVxlfDk44/XwBbFjC7eM6EanyCuivUPMmPwYDo9qRey0JdOGhW
 hAZeutGGxsKliozmeTL25Z6wWICu2oeY+ZfbgJQYHFeQ01NVwoYy57hhytZw/6IMLFRcIaWS
 Hd7oNdneQg6mVJcGdA/BOX68uo3RKSHj6Q8GoQ54F/NpCotzVcP1ORpVJ5ptyG0x6OZm5Esn
 61pKE979wcHsz7EzcDYl+3MS63gZm+O3D1u80bUMmBUlxyEiC5jo5ksTFheA8m/5CAPQtxzY
 vgezYlLLS3nkxaq2ERK5DhvMv0NktXSutfWQsOI5WLjG7UWStwAnO2W+CVZLcnZV0K6OKDaF
 bCj4ovg5HV0FyQZknN2O5QbxesNlNWkMOJAnnX6c/zowO7jq8GCpa3oJl3xxmwFbCZtH4z3f
 EVw0wAFc2JlnufR4dhaax9fhNoUJ4OSVTi9zqstxhEyywkazakEvAYwOlC5+1FKoc9UIvApA
 GvgcTJGTOp7MuHptHGwWvGZEaJqcsqoy7rsYPxtDQ7bJuJJblzGIUxWAl8qsUsF8M4ISxBkf
 fcUYiR0wh1luUhXFo2rRTKT+Ic/nJDE66Ee4Ecn9+BPlNODhlEG1vk62rhiYSnyzy5MAUhUl
 stDxuEjYK+NGd2aYH0VANZalqlUZFTEdOdA6NYROxkYZVsVtXQARAQABzSBNaWxhbiBCcm96
 IDxnbWF6eWxhbmRAZ21haWwuY29tPsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AWIQQqKRgkP95GZI0GhvnZsFd72T6Y/AUCYaUUZgUJJPhv5wAKCRDZsFd72T6Y/D5N
 D/438pkYd5NyycQ2Gu8YAjF57Od2GfeiftCDBOMXzh1XxIx7gLosLHvzCZ0SaRYPVF/Nr/X9
 sreJVrMkwd1ILNdCQB1rLBhhKzwYFztmOYvdCG9LRrBVJPgtaYqO/0493CzXwQ7FfkEc4OVB
 uhBs4YwFu+kmhh0NngcP4jaaaIziHw/rQ9vLiAi28p1WeVTzOjtBt8QisTidS2VkZ+/iAgqB
 9zz2UPkE1UXBAPU4iEsGCVXGWRz99IULsTNjP4K3p8ZpdZ6ovy7X6EN3lYhbpmXYLzZ3RXst
 PEojSvqpkSQsjUksR5VBE0GnaY4B8ZlM3Ng2o7vcxbToQOsOkbVGn+59rpBKgiRadRFuT+2D
 x80VrwWBccaph+VOfll9/4FVv+SBQ1wSPOUHl11TWVpdMFKtQgA5/HHldVqrcEssWJb9/tew
 9pqxTDn6RHV/pfzKCspiiLVkI66BF802cpyboLBBSvcDuLHbOBHrpC+IXCZ7mgkCrgMlZMql
 wFWBjAu8Zlc5tQJPgE9eeQAQrfZRcLgux88PtxhVihA1OsMNoqYapgMzMTubLUMYCCsjrHZe
 nzw5uTcjig0RHz9ilMJlvVbhwVVLmmmf4p/R37QYaqm1RycLpvkUZUzSz2NCyTcZp9nM6ooR
 GhpDQWmUdH1Jz9T6E9//KIhI6xt4//P15ZfiIs7BTQRPeKd/ARAA3oR1fJ/D3GvnoInVqydD
 U9LGnMQaVSwQe+fjBy5/ILwo3pUZSVHdaKeVoa84gLO9g6JLToTo+ooMSBtsCkGHb//oiGTU
 7KdLTLiFh6kmL6my11eiK53o1BI1CVwWMJ8jxbMBPet6exUubBzceBFbmqq3lVz4RZ2D1zKV
 njxB0/KjdbI53anIv7Ko1k+MwaKMTzO/O6vBmI71oGQkKO6WpcyzVjLIip9PEpDUYJRCrhKg
 hBeMPwe+AntP9Om4N/3AWF6icarGImnFvTYswR2Q+C6AoiAbqI4WmXOuzJLKiImwZrSYnSfQ
 7qtdDGXWYr/N1+C+bgI8O6NuAg2cjFHE96xwJVhyaMzyROUZgm4qngaBvBvCQIhKzit61oBe
 I/drZ/d5JolzlKdZZrcmofmiCQRa+57OM3Fbl8ykFazN1ASyCex2UrftX5oHmhaeeRlGVaTV
 iEbAvU4PP4RnNKwaWQivsFhqQrfFFhvFV9CRSvsR6qu5eiFI6c8CjB49gBcKKAJ9a8gkyWs8
 sg4PYY7L15XdRn8kOf/tg98UCM1vSBV2moEJA0f98/Z48LQXNb7dgvVRtH6owARspsV6nJyD
 vktsLTyMW5BW9q4NC1rgQC8GQXjrQ+iyQLNwy5ESe2MzGKkHogxKg4Pvi1wZh9Snr+RyB0Rq
 rIrzbXhyi47+7wcAEQEAAcLBfAQYAQgAJgIbDBYhBCopGCQ/3kZkjQaG+dmwV3vZPpj8BQJh
 pRSXBQkk+HAYAAoJENmwV3vZPpj8BPMP/iZV+XROOhs/MsKd7ngQeFgETkmt8YVhb2Rg3Vgp
 AQe9cn6aw9jk3CnB0ecNBdoyyt33t3vGNau6iCwlRfaTdXg9qtIyctuCQSewY2YMk5AS8Mmb
 XoGvjH1Z/irrVsoSz+N7HFPKIlAy8D/aRwS1CHm9saPQiGoeR/zThciVYncRG/U9J6sV8XH9
 OEPnQQR4w/V1bYI9Sk+suGcSFN7pMRMsSslOma429A3bEbZ7Ikt9WTJnUY9XfL5ZqQnjLeRl
 8243OTfuHSth26upjZIQ2esccZMYpQg0/MOlHvuFuFu6MFL/gZDNzH8jAcBrNd/6ABKsecYT
 nBInKH2TONc0kC65oAhrSSBNLudTuPHce/YBCsUCAEMwgJTybdpMQh9NkS68WxQtXxU6neoQ
 U7kEJGGFsc7/yXiQXuVvJUkK/Xs04X6j0l1f/6KLoNQ9ep/2In596B0BcvvaKv7gdDt1Trgg
 vlB+GpT+iFRLvhCBe5kAERREfRfmWJq1bHod/ulrp/VLGAaZlOBTgsCzufWF5SOLbZkmV2b5
 xy2F/AU3oQUZncCvFMTWpBC+gO/o3kZCyyGCaQdQe4jS/FUJqR1suVwNMzcOJOP/LMQwujE/
 Ch7XLM35VICo9qqhih4OvLHUAWzC5dNSipL+rSGHvWBdfXDhbezJIl6sp7/1rJfS8qPs
In-Reply-To: <20241017202852.GB11717@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 10:28 PM, Eric Biggers wrote:
> On Thu, Oct 17, 2024 at 10:17:04PM +0200, Milan Broz wrote:
>> On 10/17/24 9:44 PM, Eric Biggers wrote:
>>> On Wed, Oct 16, 2024 at 04:27:48PM -0700, Eric Biggers wrote:
>>>> Add a new device-mapper target "dm-inlinecrypt" that is similar to
>>>> dm-crypt but uses the blk-crypto API instead of the regular crypto API.
>>>> This allows it to take advantage of inline encryption hardware such as
>>>> that commonly built into UFS host controllers.
>>>
>>> A slight difference in behavior vs. dm-crypt that I just became aware of:
>>> dm-crypt allows XTS keys whose first half equals the second half, i.e.
>>> cipher key == tweak key.  dm-inlinecrypt typically will not allow this.  Inline
>>> encryption hardware typically rejects such keys, and blk-crypto-fallback rejects
>>> them too because it uses CRYPTO_TFM_REQ_FORBID_WEAK_KEYS.
>>>
>>> IMO, rejecting these weak keys is desirable, and the fact that dm-inlinecrypt
>>> fixes this issue with dm-crypt will just need to be documented.
>>
>> Hm, I thought this is already rejected in crypto API (at least in FIPS mode)...
>>
>> It should be rejected exactly as you described even for dm-crypt,
>> just the check should be (IMO) part of crypto API (set keys), not dm-crypt itself.
>>
>> And here I think we should not be backward "compatible" as it is security issue,
>> both XTS keys just must not be the same.
>>
> 
> In "FIPS mode" such keys are always rejected, but otherwise it is opt-in via the
> flag CRYPTO_TFM_REQ_FORBID_WEAK_KEYS.  dm-crypt doesn't use that flag.
> 
> We could certainly try to fix that in dm-crypt, though I expect that some
> dm-crypt users have started relying on such keys.  It is a common misconception
> that XTS is secure when the two halves of the key are the same.

Ah, ok, I missed that weak keys flag.

We never did that in cryptsetup (including LUKS and plain with hashed passwords),
with the exception for benchmark (where it it was not a real key, just all zeroes,
and was fixed years ago as it did not work in FIPS) -- and obviously the case when
user set the key explicitly.

The same check is now in VeraCrypt (that uses dm-crypt on Linux).
I know about several broken HW crypto, but actually no dm-crypt user.

IMO we should set CRYPTO_TFM_REQ_FORBID_WEAK_KEYS by default. We can always introduce
flag to disable it, but I would really like to know if there are any real users....

Milan

