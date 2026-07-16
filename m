Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4216414A04
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198006; cv=none; b=W7m5tPxoRcUTWr7iZlMMZC9RC02ewskUvW2/0kuMWSO2j4wr1fvnxoiLL+kvENNuZKsvblCG4VGgBKigaKt/75Y09yEcCkqTkZysbvojZgM2pqf93poJgyMDh4CHf5K9ifwdWgdjikzl40cd7wxgV1/ziI+uRT35VTxcrO0PM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198006; c=relaxed/simple;
	bh=uLyUUCEYVf5dUuQD4VVStlzoppk/nyTFiJdHU9un7RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4QZIzCmVtUydlUj0Nrhn37iGixizCcXh9mP5F5Jsop4YQjWZGRGSq+uFH4hraob33ktvLIOW72AIT+VMsvTTh9EmFURXETNFrCEldoJWcPAbk9TKDhfhDhrsORcbrQ/02ItIQyEZOuxOPt6JUV+OVfHp/xJkgxO5uPdDVLJyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vll3ds2F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vll3ds2F"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so23759815e9.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784198003; x=1784802803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBW772IIzN3rpC8gm1mWVIDJyHthIxVrQHVZAttG0Rw=;
        b=Vll3ds2FlxHMcJS6Tsn47Omt/RqUgX8ZYuDcQQDdc4oBMRoxuxpDtpn2g/PP9iXeRq
         ToKSw6idfM1aJ/9TWKwnLlBTgBE7WTjA20hqnOQjRjtxofvcmYri7tAj3+09KucIofme
         WbtC9p4hQCDRd9DEIkF2p6hEuaLRMVmCNSNV/GhBjzMeuWBVxOkTSHjRYLkwMPTwT7lv
         1Rg0TwY1ht8k+QrBpAXPDZYO8no8lpHoVCgzyKq9HMtnIMFfmyXA9Gkz5/kB8BvcUvxA
         iceDuLveq6wDYz0FjTuOJtygyh/UUZGqdFUBxYMBznvMg6+KkVV/O4Z+KtVZ5fcpKz53
         LMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198003; x=1784802803;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBW772IIzN3rpC8gm1mWVIDJyHthIxVrQHVZAttG0Rw=;
        b=VQdc3JfKJZkQu4jbJqBHeJDowxC6vSVuyDJRV/Bnd+7b04Z4CpM+iqYttZGpbXQ6R+
         p1tlskXwbupME643Nt5O84rNvHTi3dfAEwsrFRJ7ilnvZyF3jp83nbVHDydGlqlI14oD
         YG9UIVErZPfqSpy+I/ZuoAC69SdAsMGGl8+Kqeu8+1q6OV82hzWoDzM8+9iiB57CL6jU
         Mt3ox/RviELEuO6HPr0t5+1HRp2FCcijy41dULW4UmDp+oXq4TrGhWnbbqy3fgPD7HxH
         rvRLRLWPzih6syq/C2tr642ts+Ku597vn1sj6cDnqNJZv35sIclz8EP/ceuEEbVuL09g
         aWlQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+d70EOwQVxRKP6dPRUoF5Q8jSBEd31hxP2609g/QNBDVHqljRobBjH3+DBjxjalMtUv4fHmpwTKzz4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AGMn3CmXysP+YappXlUvzQfl7Se2Nsbyq0okbsCgienPfzPr
	pQ2wpE9/RmgEWVupYLUBQ/5SVX4Z3h6G3wdom1ce51lY65wZtUqRL0nJOeaoxQqTGg8=
X-Gm-Gg: AfdE7ckmr/xg47qryAEocbbtVyEvNGXKlHwgJrt1zmuGZG+tSnTUgg3gf9SoMCej/Ii
	72Mftw0bl6VtDlmWf35tfYdOr9NTNt/DhqnMW73r9jflCsZPcyQiXtSqjMR8++1dyzObdamy6Zo
	ZKIUoNeQn4MxLeVG+DzYibVgJutqALqPUbDyf3+Pg+76x0brapsR/JbVljccMFPC9AOJbgGAvRd
	v2x5WHKHoryx/48Z9k5uW7E2H3KkljwTUvecLBRgGb2g67TY/Ej6URVwKdCr00ZwV3Xv6/u5Wx4
	Kmbk1zVCC1cTX7Ja7Dnwr0boPWfEyyjHYy6oSMpx+jUH8gdExVfE/pq/UZySmbEiXx2bLRI0UpW
	5MPs1j8ySj0eDbKPNQgzy2UrfrDOwhdB5h9ZQwqe2fM/ECFA54KxK9E8GEY1DmdDGVLDfaaA=
X-Received: by 2002:a05:600c:16ca:b0:493:c1bc:79bd with SMTP id 5b1f17b1804b1-493f88180f9mr142497875e9.20.1784198002781;
        Thu, 16 Jul 2026 03:33:22 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e538368sm14920979eec.12.2026.07.16.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 03:33:21 -0700 (PDT)
Message-ID: <929ed316-664e-47d9-a4cf-7ec8750fbfb0@suse.com>
Date: Thu, 16 Jul 2026 20:03:14 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: do not warn when doing greedy allocation in
 folio_alloc_greedy()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org
References: <d10571445ee505d95ba6eaad7558fc1f556d2921.1784020005.git.wqu@suse.com>
 <alikjtke-YNWdd1I@infradead.org>
 <eb4d4f50-f60f-4a4e-8e9b-6dbb69b8e0e4@kernel.org>
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
In-Reply-To: <eb4d4f50-f60f-4a4e-8e9b-6dbb69b8e0e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/7/16 19:35, Vlastimil Babka (SUSE) 写道:
> On 7/16/26 11:29, Christoph Hellwig wrote:
>> On Tue, Jul 14, 2026 at 06:37:39PM +0930, Qu Wenruo wrote:
>>>   	while (*size > minsize) {
>>> -		folio = folio_alloc(gfp | __GFP_NORETRY, get_order(*size));
>>> +		folio = folio_alloc(gfp | __GFP_NORETRY | __GFP_NOWARN,
>>> +				    get_order(*size));
>>
>> I though I read somewhere that we now don't have to specify
>> __GFP_NOWARN when using __GFP_NORETRY, but a quick dive into the page
>> allocator suggest that no such thing exists.
> 
> There was a change a while ago that added __GFP_NOWARN to GFP_NOWAIT, maybe
> that's what you read about?
> 
>> But can we make it happen?  Having to specify __GFP_NOWARN when the
>> caller clearly indicated that failure is perfectly fine using
>> __GFP_NORETRY is silly.  The same probably applies to
>> __GFP_RETRY_MAYFAIL.
> 
> It makes sense to me. The risk of missing some useful warning due to a
> coding error (conjuring up an unexpected __GFP_NORETRY/__GFP_RETRY_MAYFAIL
> in whatever way and then silently failing) is probably low here and it makes
> the API better.

Yep, making NORETRY and NOWAIT to imply NOWARN looks very reasonable to 
me too.

Thanks,
Qu
