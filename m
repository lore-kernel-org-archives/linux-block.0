Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841082866
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693879; cv=none; b=JnE0HM7EuIU9kp1ErsV40ZEd7g0I344VAFUeWKRkaMJoVsI7pkUzt14TcYwoFSOJsP2/Ig5+YlqiGzGLHZ+F+KZGrQav1lf19Ts/kp9yq+2MnMlxXd2drnNJWprmUXLpOLnjlbFlHi8Be6Lwkay76pv8c7lVDX6ldGTKhy1ZfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693879; c=relaxed/simple;
	bh=h2VXYtemE1C5y7Tdzs487OaWnAgk6sPyBPTqJtqpEQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpONTz0evQDnE/vUofxEwTRhRiWiLOJmscwdoJHG4XuAh6zS8ScfPuPDaLrbzUPG2GRgvWk6LZcUQ7OQOdrVqkMr55VC7CirVZ4oq8s9ZO6JJUkJEkVnv2FiQWXfBwoFNVNe8NE+TnE+mJQgmw4+OMtw9pBWRaG9XHGcwLcR7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SiRs3lqg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SiRs3lqg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-485409ab264so572325e9.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773693876; x=1774298676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ggRONPuFqqcaG1Wz/ZsfPgnHZc/yWyaUJQeBEum4qI=;
        b=SiRs3lqgPmBQPSeCTpSDkAUnmmNjJ+6bPEvj4A3Y8ayv+q1igCI0vAMfAPEyJS4eo+
         mGXqYdhqC1INVeSSj1evD781bhh+yVc1+S1zaFb16V0q2oIoiio4QQ3kiAtrsH4jVg/l
         1mNWk1CWawWhSOtk8RMkFICw6im6fTeW5L18RP/A/nGq6Nl6NbdzbymXqXTQIDY5lHOf
         SmPGX+rDN7zPQhfPoziTx8eJQIVFRSSyy3cafXEST6ZEBZ9VinpMK28kTL+Xr6Gvow/z
         70vBS/8OF5XGcGlvxQWEMaPvvjEU/ZMgbK2PvDII3DIxnPtlWyCgbpKIzYtEf5ZD8jXG
         MRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693876; x=1774298676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ggRONPuFqqcaG1Wz/ZsfPgnHZc/yWyaUJQeBEum4qI=;
        b=qk/UfTvzbGlffavnR6HV9U+EKzV48X5f9sVWdha1vETHAjIlp6zrlEb+i+mfbNeWFK
         BYY2zKJ7HwG0WpWb4vXGDdRPkqfUeWPYSgMSFi2cQaSpUXn4Xr8365X029J1CUSougHE
         2eJs5OZ12kJ/qPkcFTtq5jUckCxVfXddZuprCg197bnS6d84hcUBR8GjgXrRD65iOBJh
         kl3uRhAv0yDzU2Y6XiW4YljmeVRu9IodcggfGDqYeoEQEeg1QcubV7G3Fz4W9cb+S3IY
         rAPJZ+00v2eUbDlpUzsShnpk7eQxjyv/EggACh46B4COCQXHg5GI8SJ/RmLxX/+yxwBo
         67OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyzFwSNDmbBwcuhPPXa3ffXMiy59LeQpc0Kn2fjIcTzLZZWEh+EDl1a6TWKvOe6GvpOHkVDMCqpBsjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQZ71eY2FbpWSnNaJisHnNj7+hs7VrpwDujq+LSzAdldKHHBc
	bZVR5fMS0HTyd47Gyr3NDKdNzVdGJHmjyQqRCwuwPwtY2mb+QCmaYJr7oW9x7cGXO3M=
X-Gm-Gg: ATEYQzykQ/LL2HAF5CpZfgZGJKhbnvfOiCuB5L4iKdbUFFQtXL+yhVje3LHmsrh/Zkh
	jSMkJeYqvixCq3NaNV1yA0m9Kj6Oq4fyfHbx8APKIEsDn49PFzyho3YVGcTnrEXjVzoqOPQFXGT
	r6SFu/7zV3uwVWUeWyQTSNIiBX/WDxf2l6lzBFOG5RjIhoRzeeYPaCf7q1DxLUVbikF4zfWxcNi
	baQdb6vgnkuU6+JxGIhePMOzwUd4dQCiLyoL/SEgotaYoXoeNJ3p7yojGX8JES1ziOqtKXKyLvH
	pmtB8p12XI4nMOl6t0kegkoWF/TH/RxNNAEvpcVwF8AszFJI4rQzYhe2VCDkNnYU8EOgjrqkvpv
	Ae2kW9cShNlIi/ruSQlKn3T8HDay2C1cyf5k7H14YwItWtPEDF6qYDEnlUY3hIPyP5/t7596a9S
	pdtVD931MJ3nzSMAGegYWO2404RhbuGC1XZmYm02poWoWtXUfNwjQ=
X-Received: by 2002:a05:600c:304a:b0:485:3f1c:d89b with SMTP id 5b1f17b1804b1-4856ea9f24amr11578435e9.4.1773693876139;
        Mon, 16 Mar 2026 13:44:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56ca0csm125056015ad.4.2026.03.16.13.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:44:35 -0700 (PDT)
Message-ID: <32d99dc8-964e-44ee-a8eb-566886546bd5@suse.com>
Date: Tue, 17 Mar 2026 07:14:28 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: reject zero length in bio_add_page()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
References: <f3db373bad065ae6251892acd15993f5dd56dfe1.1773368732.git.wqu@suse.com>
 <abgwAPMckUrmsnUx@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <abgwAPMckUrmsnUx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/17 02:59, Christoph Hellwig 写道:
> I'm a bit worried about adding more an more checks, but this seems like
> an actually useful one.
> 
> On Fri, Mar 13, 2026 at 12:55:55PM +1030, Qu Wenruo wrote:
>> [BUG]
> 
> However this [TAG] style commit message is a bit weird.  Can you
> rewrite it like a normal kernel commit message?
> 

Sure, I'll check the history commits of block layer and follow them.

I thought the usual chapter splits of BUG/CAUSE/FIX would make it clear 
to read, but if it's not following the subsystem's requirement, I can 
definitely change it.

Thanks,
Qu
