Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8D824B3
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140243; cv=none; b=gxWB7YfAQG9cfbL3cKilWBvYUL5aPeamFnH75pND/RSS9+K/1Sl+en8GaJPuJhywRkvH6l4JGr6sjCFdTWXgXwg2RkYY5OwDy7KUhMadEKz9naVHRZIa/K9ZP4isFpoEP/Vm+F4XbokS5ehKynF8KBNP+e7YCOR0x8jugs93E0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140243; c=relaxed/simple;
	bh=h/J7twGRur9aBHsSPmDqo+ywdluzKu5kHd4BTWVRp5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnyeH/tv6kHSn25wNN6kkr/mCTegdH/seYiWS/dCvvso0DekeneVrXUiGcQryY+t50GIoJ60AlMoeE2S+9ReI0V+MGuCj6d+PNi8mwmrXjR5RM95DReZt8KIyjXcfruDKJPvD+G/Vg9YWFi44iKDiFzwlAdJSd+5Rm2dUhzRcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gpOmN2ld; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gpOmN2ld"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6b362115eso16114739f.0
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714140239; x=1714745039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDc53xWuazKBGr/FceqrAJBEEOghszc+n8JFKn5zUvk=;
        b=gpOmN2ldphB75f/vAf95buYH1E69VqZsL7bWGHj7SdF9UwN3D0LDyPQZ8l1CwLg6xl
         V5q1IyGcJfl4ZpjtvKuCzHRgrRZ7Rv3KiT3Wg1JKUAZGrkDVphhd+Nd24y8CoIG272vo
         HIxTrJ70v5g/d1u/bpmfYMobx/Dqq51KFft9t1m25sJT+G7EGibuzD9JOo9hQJG0VoOw
         MgCvOtP3fr10dB+xv5+7egAYPeZlLhGQvQOrGkhwXqjBNtlX+hTyXN/9KzlYFbHCJT0H
         F0xK43B1bh9NsrkuIw817BUZ64H4n5OA7x4H6zF8BWEqb7v/6Lmeu4UbsQjuWmbTzIZc
         zw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714140239; x=1714745039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDc53xWuazKBGr/FceqrAJBEEOghszc+n8JFKn5zUvk=;
        b=swu5HVA54Kd/K4Gpof/sErvrn+zFv2u8IOcsTvLJ6hdRjAC04V6l3P0hHzCiv5wMnZ
         vkQ1aJTWVAV95+npgt/LmutNkdEvQhV/qFvMB2Z8MC/TRjHyD00GyB+yP4XTjKg1L4f4
         AdTyJhX2wkWll7vQInI/lW0AZuMfe7cIescfiom/KfMTBjGXxY10ipNyEeHNcMgftTty
         88PwGeTh0dwYidMiE/qarX8ZKDoTS42saiLcowxry6ETdA0z8s4iZDOUNJyUqjnZAKqI
         RayjXtYfqXOjZXvnj5TxV0EbUYo3BNZwMKEUA6E5jgv3RhZ1m971+9yEh/rpXhWQ0CEq
         4ddA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ee2jkGaSI/oncIJH0REe2m6wyAHpTFs8+5gRYPU4QA09g0vNh2aRBf/eT723vcs/DWQ8SkyGvOtaOJKGtZENMwUbC4N6r9e+Ct4=
X-Gm-Message-State: AOJu0YwVUL++b9GwMBub1UZSV/YPzmSscgRKNDu1Q4WNsy2kfONuR1IE
	tJPH3vkrNFqysVZnp53QowvHeCa3uyJCHEDaiTVMAIYG/6Ex41UQaD9ABmT6Wi4=
X-Google-Smtp-Source: AGHT+IEdpX+0wXPD+kgf8q+QDarb8FL08jaCwO5m3yJkVnv2sU21aBliSCE1h7asaIymPZjLuz/pzQ==
X-Received: by 2002:a05:6e02:eea:b0:36c:3827:58a6 with SMTP id j10-20020a056e020eea00b0036c382758a6mr1031261ilk.1.1714140237360;
        Fri, 26 Apr 2024 07:03:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z9-20020a056638240900b00484f607bd09sm4121123jat.99.2024.04.26.07.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:03:56 -0700 (PDT)
Message-ID: <3604bf42-16a9-438e-a68a-05f3c81383a4@kernel.dk>
Date: Fri, 26 Apr 2024 08:03:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bio: Export bio_add_folio_nofail to modules
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: David Sterba <dsterba@suse.cz>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, linux-block@vger.kernel.org
References: <20240425163758.809025-1-willy@infradead.org>
 <aba5fed0-9f0c-4857-927d-d2cdccf8ca88@kernel.dk>
 <Ziu0But3Q6kc1DhK@casper.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ziu0But3Q6kc1DhK@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 8:02 AM, Matthew Wilcox wrote:
> On Fri, Apr 26, 2024 at 07:41:29AM -0600, Jens Axboe wrote:
>> On 4/25/24 10:37 AM, Matthew Wilcox (Oracle) wrote:
>>> Several modules use __bio_add_page() today and may need to be converted
>>> to bio_add_folio_nofail().
>>
>> Confused, we don't have any modular users of this. A change like this
>> should be submitted with a conversion.
> 
> Thank you for reinforcing my point.
> 
> https://lore.kernel.org/linux-fsdevel/ZiqHIH3lIzcRXCkU@casper.infradead.org/
> 
> Can I have an Acked-by so David can take it through the btrfs tree?

Yeah that's fine, makes more sense now than the standalone one:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


