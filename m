Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85B1DFD93
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398543; cv=none; b=MvU42Y1ElCnmh1uR9oWmxOK6Ahj+XseDdE6rTTtmAdJt7kOK1scXGyy8IZLhtERrwirVb1u0/KSsLgjy6gubfDGP4ZBQqhpTngEXgHOvTPv//pc/SkdvncnWUa9mJMj2kTBlH+0BI6ua1i792bfuRW7NORbSnZwpvlT338sL9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398543; c=relaxed/simple;
	bh=o6Cs+S4dLY3RcsYbinbcTb4X8WwMR++yo1PVH4PRV1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT7eEWIxh66HMihLQkwZonNYAAHwsapAzSWXWy1kwsEAj1QWhfW2N1bYiUqLMv5SKyncyn7jvIbW/1S9/ZM2Byi99ma9cSQ/BuIsCrawik0UDWtyYmUWKH1eIDlPePSuZS/Ax1Ye4XePx0CCK65bYP7BHSi/eeCQGRvwof7MatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nxqbp2r6; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nxqbp2r6"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-835393376e1so2159239f.1
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728398540; x=1729003340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfJXcyDI9iqVW74ae5e7Sy3x2feF3IZz7Y0c+ABg/kk=;
        b=Nxqbp2r64WucbxqfuamiLO+vyvajb3GqzEn9AaIr70E1uKeZDbsshqF9Z9SIwsckAx
         BeyvoNP9Q4TL22SjpTvRiE6M7yNAMloDBYteolLJd20fwhETzR4tRWQwqtrJiRby57P/
         1m95RTrYI2mcl+9/8BVEUns8qNZqbxxiRqwUFkYRz5mXe/9faPNIZtZyv9haaKoJ2zWG
         +YxoiZ5W0wmT9V+F4VRH7JsLm4hpx8mbiSY8+bp7PRFWKx/k0izGvD0tDq51BV5hWqft
         oVyHSoLDQ56CiBaEhljPuVRta1dPzBc9Na4xtNP1f1afhw+8fk0DBo6ORDtC/US1ERKM
         UjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398540; x=1729003340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfJXcyDI9iqVW74ae5e7Sy3x2feF3IZz7Y0c+ABg/kk=;
        b=hNcRmwvBTZET2V3ueSvO8htGAyUMyitfT51f5oU3jtHYmPiU4FE6Wvq7UWDmhKq585
         cVvm23LLVDMiOj8JpcZ+sCh+VkU5Ni2Q7SLSAmFs3ejKooT8A96SaZuNJJzkA2ZwszBV
         3sUZAndU7VGnRRmO/g8MG8gkYBlTE7H+uVgvrZkvr/lWwHnSFcEG8N1qeCmy13n5JPjf
         sfMNyD3DcqgmQcLrlix4yoxMBuD9Sf3kWz6VLvFIDGWIT4/DgyWkmeLO6d4oNDtdHuCe
         EESx88Sm+hsfVIW1ZttPRj0s+BXAWiwZ4zSalx6mETrcqxM/TZ4qQRM/nYVow/Rhusxw
         fUug==
X-Forwarded-Encrypted: i=1; AJvYcCULn+YS64SfYWKLNMeS7DMMGMl3EDb33ZE8H/2Ga84QgSV8cL+zY+QogI/z3jEYeHtMn3zH7xAJvz9uqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiS/9GByHw2kk71rDrAyNATuJuICyf6R0TXe6iamHaVdGNRMa
	imjCvJP4l4Ky32xAmp/PFkUuS8pdGThM7KJBqffrbq3DhiuucmmV0dQ6WqIPM0I=
X-Google-Smtp-Source: AGHT+IETAiC1jlX8BMFN+l2CkCK2B5e9aBFzl2skka3yQGKdlkuUC0WqcWQi62+N2pbEqUuG2/CaYw==
X-Received: by 2002:a05:6602:6c09:b0:82d:13ce:2956 with SMTP id ca18e2360f4ac-834f7d620e9mr1534160839f.10.1728398540377;
        Tue, 08 Oct 2024 07:42:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b308b6sm179730639f.50.2024.10.08.07.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:42:19 -0700 (PDT)
Message-ID: <fe18edf0-dea7-49fa-a646-e06afddc84ee@kernel.dk>
Date: Tue, 8 Oct 2024 08:42:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] block: partition table OF support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 INAGAKI Hiroshi <musashino.open@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Riyan Dhiman <riyandhiman14@gmail.com>,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian
 <lizhijian@fujitsu.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com,
 Christoph Hellwig <hch@infradead.org>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
 <CAPDyKFoueMwVfN+P+tG7zT+-iUs=hghsRu+i9mNiHGw_9tcwBw@mail.gmail.com>
 <fe10ee8f-1220-4a1d-a25b-efaaa314699a@kernel.dk>
 <CAPDyKFpoFP3v8XneMoY5_DEVssYkDyK03QpikBdsZseO4_MLPw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFpoFP3v8XneMoY5_DEVssYkDyK03QpikBdsZseO4_MLPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 8:33 AM, Ulf Hansson wrote:
> On Tue, 8 Oct 2024 at 15:24, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/8/24 3:10 AM, Ulf Hansson wrote:
>>> On Mon, 7 Oct 2024 at 22:22, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>
>>>> On Thu, 03 Oct 2024 00:11:40 +0200, Christian Marangi wrote:
>>>>> this is an initial proposal to complete support for manually defining
>>>>> partition table.
>>>>>
>>>>> Some background on this. Many OEM on embedded device (modem, router...)
>>>>> are starting to migrate from NOR/NAND flash to eMMC. The reason for this
>>>>> is that OEM are starting to require more and more space for the firmware
>>>>> and price difference is becoming so little that using eMMC is only benefits
>>>>> and no cons.
>>>>>
>>>>> [...]
>>>>
>>>> Applied, thanks!
>>>>
>>>> [1/6] block: add support for defining read-only partitions
>>>>       commit: 03cb793b26834ddca170ba87057c8f883772dd45
>>>> [2/6] docs: block: Document support for read-only partition in cmdline part
>>>>       commit: 62adb971e515d1bb0e9e555f3dd1d5dc948cf6a1
>>>> [3/6] block: introduce add_disk_fwnode()
>>>>       commit: e5f587242b6072ffab4f4a084a459a59f3035873
>>>> [4/6] mmc: block: attach partitions fwnode if found in mmc-card
>>>>       commit: 45ff6c340ddfc2dade74d5b7a8962c778ab7042c
>>>> [5/6] block: add support for partition table defined in OF
>>>>       commit: 884555b557e5e6d41c866e2cd8d7b32f50ec974b
>>>> [6/6] dt-bindings: mmc: Document support for partition table in mmc-card
>>>>       commit: 06f39701d0666d89dd3c86ff0b163c7139b7ba2d
>>>>
>>>
>>> I think we may need another merging strategy for this as I quite big
>>> changes in the pipe for the mmc block device this cycle.
>>>
>>> Would it be possible for you to drop the mmc patches and instead share
>>> an immutable branch with the block changes that I can pull in, so I
>>> can take the mmc changes?
>>
>> I mean we can, but the mmc changes in here are pretty self contained.
>> I'd rather avoid rebasing the block tree for that, given how small the
>> changes are. If it conflicts, should be easy enough to resolve.
> 
> Okay, let's give it a try and see how it goes.
> 
>>
>> You an also just pull in the block tree now and resolve the conflict.
>> There's not a whole lot in there yet outside of this series.
> 
> Let's wait and see. If we get some conflicts, you can always set a tag
> to the latest of the mmc commits in your tree that I can pull instead.

Yep, sounds like plan!

-- 
Jens Axboe
