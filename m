Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570828C2BF
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034550; cv=none; b=mW8LAMzhUMczK53Vz5jLI0cG8eFJu2aWCQPRCMlz8MrIKevULo2piRXElEcRcqhGaiOk/x2JQ01cSr+UOSud/2x1cfYx68Vrql2Qx8rWjZ1XgVGSlt+IaViiKEgdgE4W4+tiA9NlYnmOwe63KqW1XjPTkmuQNKVaQLgR+YE2CEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034550; c=relaxed/simple;
	bh=zVftnVBzK8rt+bdggo8IGbxD/AJcc2cHbCdfPnYtwWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz4Xk4nyF+HWfYwatjJiAq/wgch9dzZwUyv365scEvuuuF/ycrDoY9DOJOu8cPG4M+x6yOGF4e7jBgl0torPHYjh2p5jrbpOUXbRHJyTH8pE0Eonc9H1uy9dvBT3gvEN6G+/3lYQzB1V7IgpsaEibG274cm10FzokKClO7Py1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdMA9tFm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdMA9tFm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso35586945e9.2
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761034546; x=1761639346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kHcZuzFp72N7RUBqQIuIU6WTtqLSl7qFxgRoCA9ftI4=;
        b=WdMA9tFm7VuQZIcV3jB3wZS31vjAkMWLYPFvm8ruZAE2sB0XIHJDzrHvzzuc5xiI7U
         ddo1uRSWKe9V5ENjaQE4NlMo/oSabyhGtEDGBoD52/VWkBQIVwe5oIFTPbZD/fh/dtzp
         Il8zFnpqYBCTZM2ZRyCtJpJg2Cupkj54towPZpFz5+HcVRVsWdWWkXZAhOuF/0p8zxsB
         8q8lhHhaK/NkCiyOjflAdO9T89AphH/wLVZsDudzoorTIiguJsf8XkLYZrJrsQgfj3hK
         eW52cWXWiF6ZjHKvtyWFAzzLcqRsmfeC1SQHVdW7N7Qnu+l8AwJXDriCtAii5t0Y+0cc
         anDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034546; x=1761639346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHcZuzFp72N7RUBqQIuIU6WTtqLSl7qFxgRoCA9ftI4=;
        b=SssaDCJm3Y3oYkRUAWelKavjTib+/I5G4N166vMgFlrjGsk9n0GTIl0Wtuk8H93HQz
         noPgwA/beIqErnboBtZqGagXuGkaQxLrhUdon8X26LPBzxLM2VIENR2mEMY9/rkfGduV
         WD1ELqIOpMVrE9qRWvFgv6XPh+RJf73WCi4u1JzuGELYTJuU4PRgU/W4Med+yqUrNtG4
         snWrUwSk1WhlPMel4SiRd81c3fWtCxnKSXqFv7p8xjSqAI+odKwVQeP02PKXa2K6JK6+
         M1WdZPneTTy/QtKcXpn7aP+84IF0NrE+Kf/Fbc/Vr9+NpoLTd2GhHmN3+PEKDPF4I0KF
         gMjg==
X-Forwarded-Encrypted: i=1; AJvYcCUloVgPia/cYK2c9iFqOa65tHLJi3KJ5Csp0WC9PG8M+yRKweroaNe5tpjpTfUft6Z/1csADyvjrtqlGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5baLCUqK+yC6AqP1ylwgwHbMkt+Aw0HmsnuwuF//5ODfcDJWq
	TNoeQEyM8RMqnsmGfhx0MqpnTVtEut9VO0uG5hbY6JsVkdUDpF8j6QDoSFjsaJUT12A=
X-Gm-Gg: ASbGncvx1AROyxref4wp1abMrwBa7ERIWB1kE4wLREIhvSlRTAj+DAXXNEuK/aOhIHw
	lGSlVvtCtSlq+zTaC6qRiGwUGJAqOMYGA+CJBk2vuaM+via5VJpYk/B/d7SnBMHyJHTo80+wg4p
	injT0fETUEe2jJ5ObfouYrWa/NU6/UF/gT9b8DfCRdGSmQ6Piz9CQyYTB2jxSJZHrF7At4xKbmO
	qiEW3sxdtpYSryomb/M7Dft5q1Jn8pmgAYE0MjyjuF6LuscC2aIaMbFDZmAMKYqPcQEegH+pcc0
	oDfPuJr9QiM24g+gr20YOvnN+XED15aiFBnygD08FCagsZ5s1JsziyLBcHbwL6iTDAZY2jZrbU8
	UrLw2qNx9/qDVbyEOmu3pmT2jail4GMAS4/0gvcJ2VCa0iDgIvUcS8rqm3V+q7glTrsigvpLrSV
	DE6RVud+mBoZJy1DiCaj/nW70srMFHIgOGYTcgRrc=
X-Google-Smtp-Source: AGHT+IFaWIBoJi3XK2l2Na+ZDX2sj+oZzA5h4ZX6OeFEPtXSgG1fCm9Tbf7ohSg/qKEJQ1ymWULiPw==
X-Received: by 2002:a5d:5d08:0:b0:427:a34:648c with SMTP id ffacd0b85a97d-4270a34652cmr9043168f8f.58.1761034546186;
        Tue, 21 Oct 2025 01:15:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff4f779sm10584512b3a.32.2025.10.21.01.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:15:45 -0700 (PDT)
Message-ID: <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
Date: Tue, 21 Oct 2025 18:45:37 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com,
 jack@suse.com
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
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
In-Reply-To: <aPc6uLKJkavZ_SkM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/21 18:18, Christoph Hellwig 写道:
> On Tue, Oct 21, 2025 at 01:47:03PM +1030, Qu Wenruo wrote:
>> Off-topic a little, mind to share the performance drop with PI enabled on
>> XFS?
> 
> If the bandwith of the SSDs get close or exceeds the DRAM bandwith
> buffered I/O can be 50% or less of the direct I/O performance.

In my case, the DRAM is way faster than the SSD (tens of GiB/s vs less 
than 5GiB/s).

> 
>> With this patch I'm able to enable direct IO for inodes with checksums.
>> I thought it would easily improve the performance, but the truth is, it's
>> not that different from buffered IO fall back.
> 
> That's because you still copy data.

Enabling the extra copy for direct IO only drops around 15~20% 
performance, but that's on no csum case.

So far the calculation matches your estimation, but...

> 
>> So I start wondering if it's the checksum itself causing the miserable
>> performance numbers.
> 
> Only indirectly by touching all the cachelines.  But once you copy you
> touch them again.  Especially if not done in small chunks.

As long as I enable checksum verification, even with the bouncing page 
direct IO, the result is not any better than buffered IO fallback, all 
around 10% (not by 10%, at 10%) of the direct IO speed (no matter 
bouncing or not).

Maybe I need to check if the proper hardware accelerated CRC32 is 
utilized...

Thanks,
Qu

