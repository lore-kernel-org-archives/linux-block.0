Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4A34A790
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958915; cv=none; b=q6rdQPAsgmC+tZBM2hGVJgHRbSG8aGNxy4gnUB6HlyTlq7hQdLs0GnBaltkhJYkVmJtqwT8PirqCxuOBHATkZXYdFIphleADjaRDF3YMqfhSBCv6HxYZglTya4JEjHJ/+5cbdjAoJ7p5aKvOd3zWoJAwWMRfUmUX3LfZeHIsJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958915; c=relaxed/simple;
	bh=KDCfzB1K1pmB9yczCcmjfU43Kjr3Bxk3yaOfrbYmnE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWlfr4HbMPNH2kl6P/RrleieZzc4AWboV+A0YHoEgUbKBONkv4U73yL3au5NKa1ZqAsAQpRID0QjNAMYTO5yXRcktyWXwEQRHlJnuGoz5jYACpc+4uEPSpZ43vuUp/Ei2uUXw4IwlFge/z7SjZA88jXSLOoQDX1zaf6rV0ZTXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=waq1V5Ip; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="waq1V5Ip"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-43377ee4825so4943185ab.2
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762958911; x=1763563711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ljt/lZt1kXe7ijwrwYUr0jAa+SPZ5mKrRg32sJwrvpw=;
        b=waq1V5IpSEE48OHCq7wg/VA/1njZjhALIddU0eO6TtPMZ1Wq2nakDv4J4q6HXFKJQl
         TYSp5ZhUR2WaQksP4p1CLOWFsee3P+KHD8kFrQC7IEkmMiqsBGLqKgI8etGfz/L/CG7m
         irElMl0fOwdp9Ir3UnYsugRzcGgd8AUfRJRCYG+/JSCwW8/Yn93j+mWf2NbMXJjO+HZq
         CeRa6pyxwNB13TqQX3sSlzmH9D9ILOsq2DjQIceFQszXya311+ij9pTtZrH13ZB9Mw+a
         k0Fq5iId/NdChdb8GPi67hggRMtcwv0jPWv2iFulb2fCNwGkKYf7i0+V+jsQolNqauvL
         TbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958911; x=1763563711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ljt/lZt1kXe7ijwrwYUr0jAa+SPZ5mKrRg32sJwrvpw=;
        b=ZuShsTtp0ZWBU6MCjEBCeTSuLuqGenOch5MMf85PH6XgxR4RU2xyiyve1PjR1XzlRu
         E/dilJrdqB78ZShiC75Ug+pKK9G2oMuBkKSu6UtpWYl0cHRLmnG52wUhksd0K19Hf4Ka
         wKWQ0prgsaL2ohNNrzmkmhJ9PYE20HT0xZnJVRIxb2zcHuBJBkk6M/xm+wQKlMxTc5Qn
         En3OQrkUpF12S4rmEIgHDWAF3F9xg1NchT5Ayx8Swq27tnrb+6B1xwvXxTH4Pf5tsG0x
         8hRz/WwdTBI2bxbVNdybAseIOfT5HOSYwmJzkkHot1xaUUE9q6myZ+WjsSmLIGUa+2QD
         H1/Q==
X-Gm-Message-State: AOJu0Yyfg2Soh8lguuEU8eSfXZsrWvmEGy4DzYMN2kNdIvaMBK3Katve
	IPTcRBf4/XWqJi4fcR1hteuV1yal3ZssZZtL00ls54V62OEM1+qBYXSb5VUbE+bUD08=
X-Gm-Gg: ASbGncuqqUo9ESjkALIa3JlnWlIZdNUg7OZ3Ocr+b4LU9q0JZ9SevIXhLGX7R0PohhF
	lQvX2HCviyNr6GYUI57xcBGviAD6wMF+uhphqCKFP6nvovlaaiCnrcInbXzXOijaiwNKUZzQOYa
	/HS1uV2A3KnbdiY4kdZah34ODupxYw927TFqAcSUJIApnwgQ5AgE8xMVn2bJrc95ztkkaf4h4Fd
	8ve0hyyq8AsQGQ0SQ6FtDsF/1++BX3cQahceQluOmR1v5NkwWk8bfs20ldnN9BgdvdQIelkLWyr
	yMaTXFusQw8E90yQ7moL8AHucBD705VhO28r5BfcMgybW5xhnmsCJcJ7YfidmvLsQEsP8c75J7G
	zmPetfGphMnF/e+g/s5IGg/ZefDOGsl2CR5On4z3t6P7lJee/I/KpwC6vcSdpsMKTCRYbVRscTg
	==
X-Google-Smtp-Source: AGHT+IHcc/Cp1sIPUe4sx5LGGwFaod2DXKn4PmhzV2Ivvm/MMfm490FJLMqmg1/QLp2ui2nU34uO9A==
X-Received: by 2002:a05:6e02:1d99:b0:433:2d5b:96ce with SMTP id e9e14a558f8ab-43473d1b803mr45529145ab.14.1762958911636;
        Wed, 12 Nov 2025 06:48:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d458sm11014395ab.19.2025.11.12.06.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:48:29 -0800 (PST)
Message-ID: <fe3cde84-ed9a-40dd-ae78-25fbc1fb6aeb@kernel.dk>
Date: Wed, 12 Nov 2025 07:48:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zheng Qixing <zhengqixing@huawei.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20251111220838.926321-1-bvanassche@acm.org>
 <aRPqoinLQjYFBJsO@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRPqoinLQjYFBJsO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 7:02 PM, Keith Busch wrote:
> On Tue, Nov 11, 2025 at 02:08:33PM -0800, Bart Van Assche wrote:
>> This reverts commit 3451cf34f51bb70c24413abb20b423e64486161b and fixes
>> the following KASAN complaint when running test zbd/013
> 
> Can I please just get one chance to fix it before a kneejerk revert??

Yes let's please just fix the issue, this seems overly eager for no
reason at all rather than to appease a test case.

-- 
Jens Axboe

