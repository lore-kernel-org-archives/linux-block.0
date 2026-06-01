Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81237F010
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352890; cv=none; b=W2jhxnYVNtq3rq1hsTr2Htxp6swBFvb1SYn8CIpUcgDiDArFDz4KimpqvZp4jkCq0PmBnCU4X9QspWC8OkE0K3ZDVOuj2RUS5GHucYf/RJAYRSj1NKLcCq5DUZVRWqEIyaE8IVRdsyxc3ZbN2XPQZtkLSP8mIxuPZAulnS12xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352890; c=relaxed/simple;
	bh=09QywNMFB9xJQgcS3lv2RJl/+8KF5z2gwtaAl6Sdmzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgODkL2vBv7pbGtQ+P1SfaliIH3lsb/s/H+cMs5X272SUNmpnNKMQVE9HrP0IqXFCafDjYfm6glMGo82eReuCF2otUTBnup5u+5Rui3TknkqnvhzGl0LFr2vcxfUP3nEen3mXN6/UeO5JLk+v1cUY5o8o9Wg52qDPrXxNQfd34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qq8uywH7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qq8uywH7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a762db7aso13516715e9.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780352888; x=1780957688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=giYcafd3I2mpvPflYmwbLiEG2gQ+vD7xawf2mxGjHFw=;
        b=Qq8uywH74vqrKhYC/8U636f2URWfcor0TFBdCnOcw8VTY6wahkKvu3avM1zyDUvK+C
         Hh5G0RFIi7OusASlQLRcTKW19BvQ8HTYJRrgtZfUzHAnSCd02JVCfg7ec1R6bRBH3up6
         nDmfKJ6pDYOZr2JjQtIKPcziFDG4HABu9V2UUyWlJRjoaIjDNTxFvoU41J69hbKpIHKg
         z+qTQaI2uRRLTmcSQl7jAOElGRz9k/6YBJm2jzehOOifPEhfeMBsHIc4wEkRK7cMbcyb
         DZXZBGfihxqwJmE6WG3WvyIRoBMzzONFwNy4FKMH5o0E/XXiXMgGboyNqHwJkRV2koCb
         koEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780352888; x=1780957688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giYcafd3I2mpvPflYmwbLiEG2gQ+vD7xawf2mxGjHFw=;
        b=pmcV9d5iB+lk3FMdVWajaW5xmwW4CVPlA9pQmxxkch8WguvGYKZ6JEZTnzGkHasEC5
         d0aijGNTLr9IQ81LmdM/j6MdxuyGbIAuIh13KEvhTD71+NCYKeZrSjT+arux/jGFkbUW
         Jajk8ku9KuFM9TjFQ52mv0Y+9qujW3wlhYQiPRoDA0p18O6KBWrRbZ/Ff69rhKTTY83u
         ay+IFznDuYEY+R4fnv5bGUf4slVeLrK00zML4AnXq1yFI4rYV9gWpE6MAwVy4BnRiwmU
         EUoxJnRuolg/Yv7fOf92SYhrxTXrXA/pkH/gUWmXHWOjdadEwQ9F7JNzUeh3BvloyfYe
         YctA==
X-Forwarded-Encrypted: i=1; AFNElJ+uRPtPxAovuUYc+pfQkfo2a2Lm7VikJGMekJiGoPssdm1uJVFDIr2EvX9sIm6ZW2939u0k2kS9zjeXoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46w9UBtmTSGLnpL14qAbjFKYrHdz7nppNBRPSbUD0XdMTpZ+t
	OaIEdoAQ3nNQD+M8zgDVzLB5j+3XMmMWE2AT1BxUfeCvf49DzE7TgT8qxuEEbz5EPIo=
X-Gm-Gg: Acq92OGL/Dxye/6LZR9YRi6zTGTkT00mImygkV4iEMt1DZaTcL5CEXXi2Jtan0Mn2ta
	OaFA7pVz+1hV+diY8fG7KZ9LNAfMnnAIRrKTnCmzWvIDG39boRFrxptzYLv5U2j1/n2AjVkxFUe
	OVaSl4FTVFVjE3cYHEH6G8aeFaSpRdYOM4uR8G6bjyBg+wLbpRnOIYr8C/gkoIySsIPWAHeywS+
	54sC40XQ2c42r148Kei0EBZeCXBGMFEPBoumJb9rMQerqbNawVnS7T5ZId0tF4whvhFuy/v/Ti8
	gOJce7T+2o+alk0HpEUmFGQWEnU6lN3IfJdviL7VCXFRhDHoWpuHi3/HC88zrzSJSoW6zqDNsjX
	v7MXvUwwLRBc17UD61TF8Wlm6r4yKYoO83ED9OSPETM45BW+gBs3jjFk0u4Vmo7W/EZUzCeGylX
	OVBEkt4585J7fLVI04hM/41AmBKNiSj041lKhjq+u97hk9xGdo/Kz+QwXahwcXp8qACzNNkXMCR
	GIuVYG6K8BCrnJySISp3iHcYiLZzR1TsLyIUZ94nRLEsqQBN0huGLYu7w==
X-Received: by 2002:a05:600c:5395:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490a2904b29mr282295395e9.1.1780352887955;
        Mon, 01 Jun 2026 15:28:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd90415besm774673a91.0.2026.06.01.15.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 15:28:06 -0700 (PDT)
Message-ID: <d5d2ae2c-5b9a-4c33-8dca-6f2f15a7877a@suse.com>
Date: Tue, 2 Jun 2026 07:57:59 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>,
 linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <ahRocb0Vs_m6RF_O@fedora>
 <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora>
 <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
 <ahZeYQ0cLE1i8TGs@fedora>
 <fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp>
 <ab5492b6-a053-4e3b-8c59-2e836ae85bc4@kernel.org>
 <20260528083848.GA7694@lst.de>
 <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
 <20260601144034.GA4918@lst.de> <ah2zdCQ0WA6ol2Gn@bfoster>
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
In-Reply-To: <ah2zdCQ0WA6ol2Gn@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/6/2 01:59, Brian Foster 写道:
> On Mon, Jun 01, 2026 at 04:40:34PM +0200, Christoph Hellwig wrote:
>> On Thu, May 28, 2026 at 07:46:24PM +0930, Qu Wenruo wrote:
>>>> e.g. 9c7504aa72b6 ("xfs: track and serialize in-flight async buffers against
>>>> unmount")
>>> Considering the xfs fix is pretty old, it's before the fix hint thus no
>>> such mention in fstests.
>>>
>>> Do you happen to know which test case is for that fix?
>>> I'd like to adapt it for btrfs as a reproducer.
>>
>> No.  Adding Brian who authored that commit.
>>
> 
> I haven't followed through the full thread here... But if you're just
> looking for an existing test case associated with the commit above on
> XFS, I did some quick digging and xfs/311 is the original reproducer for
> that one.

Thanks a lot! I'll use the same delayed umount to verify the behavior of 
btrfs.

Thanks,
Qu

> 
> Brian
> 

