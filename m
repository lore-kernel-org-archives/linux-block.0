Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BD23E349
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778234; cv=none; b=FaoFNtpmgXr0lkE1DDhwVojdrJz/Ds23UxxrF8RAn6KZbfml8Pb5O1VAKWbdHwpCLY9/gCWUxHkxQUx+mF8EDxVenGT6+HE8528IqaVmfYyPPcq79Y3U1JSJ3LAXR1EMtc5nIjNkGnw6HPfQ5o3nbU+yB2AjCOf2yuZDesj59R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778234; c=relaxed/simple;
	bh=GfhLQQC/OyjSvxbDTIa4IlhmV9FGKKw6mD5UcA59XHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIF6sEzXyP2s5Xn37LLaLXBaQuSlhPONLnMhUmtCXmrT27agb+2faFzS8MXpjDVutr1X/JbmndG0stqUdtcRvbcnCEJf+AfTBr887DXa8V5B/YUSaoQPy8++gMVwWxzXecB6z3hAav0ypL52YTgsM2hRa1Qi38ZLhpDLmZkxWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDiUeDQc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDiUeDQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741778231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qx0N5U2clkaO9864aUlR/geic3GlcVkf3+K3kPRHuaE=;
	b=ZDiUeDQckPz9MsyNgSvoKSd40PgRJ92C2w5bZL0v8CPCmoXPE3UO5zexpR1TS0ccqbkVWa
	aj7HV8aLYlzN7wwDyZLyxyRhBaJbX3gP+JqkubaTVaIFvwImSC0K5zS5ZHrinbfPj4uZv9
	/Cu7qIAQCxwOXvTxqwhGwmcC6FrfIHE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-Nx2c-Y6OOwqLIguX7WDZXQ-1; Wed, 12 Mar 2025 07:17:09 -0400
X-MC-Unique: Nx2c-Y6OOwqLIguX7WDZXQ-1
X-Mimecast-MFC-AGG-ID: Nx2c-Y6OOwqLIguX7WDZXQ_1741778229
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac29f1e54baso329414066b.3
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 04:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778228; x=1742383028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx0N5U2clkaO9864aUlR/geic3GlcVkf3+K3kPRHuaE=;
        b=YUCc4UvwcK8RHDC/NwGJYM4RJy1lLlBq6auxHOM5Ec+AVFWmgCBBnkqWTzxM/Tn4Jt
         mVXN0meMnDMSFiNiyyxW67XJ1bGThlkfYMUFoTjlF0LsZ1qiWeQUFNfS6hWDp2DoKQ+Q
         NqmPgRyuhCk8baJAfYd+hdQNIGwWnlqjUsO5ZT28RQN+ke9VYnA72X6P7FYbQJEOBr8s
         GONsKRl6lH7Ji1P9AQmgZMIJ6KvLDJFYZvRLkgVfDSlDz9uigUvrFf0Z8yZEnEDVCHQF
         X3PUQHssnMVudrvcpInn02F2noVHcizBpldYdL5bssfjt7foFEbfXGJoQBnu83M3Ptuk
         ti8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXu4w1Z8cKzee2q6yIHTu/w7Wp0V78EHdGrNGaZKI6EnXxNd/u41L5MohInwWGVnMobWx5wsyvDhnPUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEqxSl1Zcjn1bu/9nRVqrvRHepZwrXvFVy60N0ul1B2Wwwu8F
	6cVxKinW0VkBNsB9RI5W6PdmF88LsCNv9a5HVPAVyhdft+2tfTSlKcJVaMjGXITEauPJ+ZXm1Xd
	JsLM1TgFw2A3HlwJd9Pcl15LDm1nAx+U9HL89Cgf+iX83W+UIqljiBfO5mjcUlru8R+SABw==
X-Gm-Gg: ASbGncsWbWGr4QeiwZtHLkjAQdoymMmRQrPd+ByyU4/1D9xcKureBJkKW8POjLZ7RCd
	5wddBPkL0TG2idLjSIAIBw2Xwz8D6x+bR7iU+/9UoLCUaa+Zk8dQ/LIFJmL4F0yL8szPHHRnNpb
	aVCNdD1BXDJ7n9MN4B+xGLP/pJKagcgwdpvCb35hnZ95nDgC3XkCe/EWckDsVupgiGkvvRSl7HQ
	ms2Hap6+lNJw1Tqf8enkttsSIUQL0qRDiY47UK4HsgSulNlVwlzNugB4yTkPzsSjg77/udm6Lry
	km/6mODnXQo7EhfR5TQy7NbsesbNfCIi6IOlytju
X-Received: by 2002:a17:907:940a:b0:ac2:d1b2:72a with SMTP id a640c23a62f3a-ac2d1b20967mr590516166b.11.1741778228442;
        Wed, 12 Mar 2025 04:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELJQOZfrd9piCnFE8L4fLyvo/SXCGu+jxcflkv01UyvfG64ed9kIJ3LPE+8zo+Go1f1oJTPQ==
X-Received: by 2002:a17:907:940a:b0:ac2:d1b2:72a with SMTP id a640c23a62f3a-ac2d1b20967mr590512966b.11.1741778227947;
        Wed, 12 Mar 2025 04:17:07 -0700 (PDT)
Received: from [192.168.50.107] (85-193-35-249.rib.o2.cz. [85.193.35.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239736806sm1061599666b.114.2025.03.12.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:17:07 -0700 (PDT)
Message-ID: <82ead8c5-0869-470e-9719-918481a9ab8e@redhat.com>
Date: Wed, 12 Mar 2025 12:17:06 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Milan Broz <gmazyland@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Alan Adamson <alan.adamson@oracle.com>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
 <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
 <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
Content-Language: en-US
From: Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2025 04:03, Shinichiro Kawasaki wrote:
> 
> I created fix candidate patches to address the blktests nvme/039 failure [1].
> This may work for the failures Ondrej and Milan observe too, hopefully.
> 
> Jens, Alan, could you take a look in the patches and see if they make sense?
> 
> [1] https://lkml.kernel.org/linux-block/20250311024144.1762333-1-shinichiro.kawasaki@wdc.com/
> 

Hi,

I've tested with both Shinichiro's patches [1] applied and it fixed the 
issue for me.

Thank you!

[1]
- 
https://lkml.kernel.org/linux-block/20250311024144.1762333-2-shinichiro.kawasaki@wdc.com/
- 
https://lkml.kernel.org/linux-block/20250311024144.1762333-3-shinichiro.kawasaki@wdc.com/


