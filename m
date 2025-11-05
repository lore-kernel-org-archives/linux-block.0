Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C9344043
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372114; cv=none; b=WGuLqgrqL12HcN4jaYazMGh45vj9sBrtAPSCWm+JYPckNIHG7PAqh4Ri4SaKu4VanOmc7EW8E01bPHbN3Bb7CE9HTSQvm8epJc7ecD7Xn7AXdj9eoboFFSDASNg4bn6vyfafEz6KMh2ggnNe35Xx3o4JBA1GV5WQrnrx6ZeDDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372114; c=relaxed/simple;
	bh=956QxLveF26BLzvHFDRgU5QySf3OVWu7fWyI1sjmP54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOhyZusNMKFKz3jv2d+yMTO+1FNSdKMzl13nkkso6zqUw/1gt8jsEPH11/ZHoKDLXo/i9XNuuDKb8MWRySDk3r7Ih22CfnhpOi8ChAViMtd44iXzfpW+ggAB2eEO79OjnHIrjgAF2VL8ZK3o137Z8I/4MuW+h3t+Y4rd0ghuTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jFm8QOOm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jFm8QOOm"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330d78f935so1071625ab.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762372111; x=1762976911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgXgLebZBvjcS5h4SUC3TtLVW39jiXefGJC7jFeRiOQ=;
        b=jFm8QOOmQ+J5eUt4htGeh9FkRnzU6voPc30WpTarpCgHZlLWSB+dHiHYWgv3X0DdJI
         HfugruiBNWKeY0Gej9oTWefPSxpyf93iijJkKd7Y6Af0mISaNB9NYYz1y5r8D6GHpf9v
         27aRnHWXDx348JIKk/YXAqPDy645Uw6GZSnGItmD2YGO0/c+EzCPzr7g8pendqvG5k2d
         Z6oCFfKGrxrYCXD6ghNrYE4P+Mt3KmD4K5RPQRpwf+52bQFbm4TEhTqB1tau35nRmwJM
         OCV//gM1kYSejYGK0d3wfkXNkXDa4n/hm8cXqN3ukPYXSyPnNCb/MvvYNBURzYcw+bhP
         m8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372111; x=1762976911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgXgLebZBvjcS5h4SUC3TtLVW39jiXefGJC7jFeRiOQ=;
        b=pZGoLnoYhNt5/zJJMC42oPacneX1rpzkriTwJoCoTc1eblnRoKHESt/yoqkkanw7yP
         Au1ikvYgTxDoxUz7weQ0Zwbusm9v7Fgm+itv5lO2RwW42aMfcicdlh0nHizyq7SKFoPk
         P3SXi2cfKorFelfIWQpaJyxp+XbHq1baUfzaPVhZe1NVdlfTzVb98J8smX87pCOJtO8F
         dGTduOyXlEQGZyB06C3cUp+hCTsTIxe5ZPYDNeM/2qHbwVhq1Lw9LQCKf7bzIiGifsZd
         Rf5/FNK59jAMq+U4hj/fDc725VCjp0fQYkhp8ngEUtvt6ynNZrBVs8TfVaLjUt949Zw7
         WTcA==
X-Forwarded-Encrypted: i=1; AJvYcCVGhd46LdWi3spIC3EupRCrRjfyX/n/kX2YkOn4o8DPUSuWjYRwgEbHsdIPvPZXcLxcEjiwvwMPoA48QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ceIgQ+iosMTe1Bg8JynzJhPb6dQyq2tUE2k2BEvAVqQo8fgr
	l9W9j89/hRo1yBc7K8SSUFC425JJStqDI7l+T915PhJhfZxU7JLVipWca4pU81j+uCM=
X-Gm-Gg: ASbGncst4xfZh9eIiDQuK3GIpopO97+NBX5jnDQgffndOihPoyjiMOOABk95Qs2/ZGy
	YC1sGEhEt+wgmtQdS6n5FE3YDJ8B5sNO76bQLH/VUlB8SA04sqoh4MuiZ116NLmA/MurjWCkTax
	FO5e9k1coja7XRV67fFhd+OuxeBm72Za5gXLvojQQ41x9E4XFO0CE1Bexf15BymUbrTM1E/SX/e
	J2n9VOHl/wR+5YodC3tFSkyZAFqzxVrkC3JQtdf2W/62ndVZmlwxdmp+SIWV3WCRVNzoslWA9AD
	p1oYaWwrGRMaIYKSR0BnMBG3JZXAoJGyBADli23xMmwAFsRloeTyQFEiTD3QQ3Dkea6WvIju93K
	RUElwkRHqvzeW+/KOahuvinXCpFfDzZL8d0yn5oHPew==
X-Google-Smtp-Source: AGHT+IHv98NDF7fSRYRJTWVK4RZf+UzBwNucSfDPDwqMPu0Q5q5IPRe2snxpRREKAlDF8qVP2fsM6Q==
X-Received: by 2002:a05:6e02:216b:b0:433:2aac:c540 with SMTP id e9e14a558f8ab-433407a409emr71237525ab.14.1762372111210;
        Wed, 05 Nov 2025 11:48:31 -0800 (PST)
Received: from [172.19.0.90] ([99.196.133.153])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7467d5a20sm48355173.4.2025.11.05.11.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:48:30 -0800 (PST)
Message-ID: <ca3ef246-4df2-4ff9-958b-58b659d4c2a1@kernel.dk>
Date: Wed, 5 Nov 2025 12:48:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make block layer auto-PI deadlock safe v3
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org
References: <20251103101653.2083310-1-hch@lst.de>
 <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk>
 <20251105132345.GA19731@lst.de>
 <a18092a0-da9c-430b-80a4-5951501f94ef@kernel.dk>
 <20251105194652.GB5780@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251105194652.GB5780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 12:46 PM, Christoph Hellwig wrote:
> On Wed, Nov 05, 2025 at 08:03:57AM -0700, Jens Axboe wrote:
>>> This is 6.19 material.  That's just a heads up that you need a merge
>>> (or rebase which I was hoping for as of the first round, but it's probably
>>> too late now)
>>
>> But why not generate it against the 6.19 tree then? As-is, I have to
>> first resolve the conflict in that tree, then resolve it again when
>> merging to for-next. Not a huge issue, just don't quite follow the logic
>> behind generating it against block-6.18.
> 
> Mostly because I though you'd rebase when I did the first version and
> then didn't really think about the base more after that.

Gotcha, yeah would've perhaps made sense back then, but way too late at
this point.

> Btw, we'll need the merge anyway for Keith's unaligned PI patch if we
> end up adding that for 6.19.

Yep did notice that. But since we already have a conflict, not big deal.

-- 
Jens Axboe
