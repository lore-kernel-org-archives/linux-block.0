Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77761A7AF6
	for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614373; cv=none; b=bncNvVC9xR+WbAR58c7lrTaDWctz+3NjK0JayfRL7lYZvy0EkEwlpTavNUOwBAYfMrLx1dPS7bmF8AhIdZcrNm3KuK7uFchWh7B6EZF57bjY/lt8b7Rxczh0Volmaj7bnC9XbaesO7E/qgIhKDvN5JH6BqRVx2r/ZQD47JWv7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614373; c=relaxed/simple;
	bh=H287lDYthdc77qSw5Z5/Phmq0rtxNLmCcq1CkVNWHj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdPdLBrRhkKzzg9o8j8xfpmXxks9IvKqDrZRJgnH35mMfk+frGat0EkHscffUcB9KKj7NA/qA5YtKWO9Ae5KDdQzzujYAb0qEK7YqM53Tkh2+KLTLXU3UkfGN3LHhFGSEzGTdopRt4TjjM8zFLdOSUZgJr+8PltxUg89Pru2XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YthmldjE; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YthmldjE"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc52deca0so549110eaf.3
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731614370; x=1732219170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkFjS2wPJFkqdQm4cnKrH9Ovi0c7v3pS/9u3vIqGMDM=;
        b=YthmldjE8fcn/KsTGQ1YDd2SXqNgZmzwg2dBUE4WaE5zizJ5eqVzSxjFa/QOCTn9Nl
         nM1AADWYnpr9+7x5NfO2tCxUQhsD8QRw2Vu5dfcEMht4GQon/29upkszLwQ1ifZswegL
         RVBN7hKXW9+OnAaVbM9qAezsfl09aqiNTVD0ejensa4phB1H2WJ5lfrhWCKrRblgQpQS
         RsyhzmmRO/veIUlZMaxnSJcwDmOdBX2X35ycJ5f8JnTq/PAhFl2L4fkEn22ECyXgtuDF
         35kldiYBRw+Lzh0rupQ23kNQ9YsT9ktU09v+zVSSUSLeaup1CvxnKHgjWLBxDVbIj0Vj
         /21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614370; x=1732219170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkFjS2wPJFkqdQm4cnKrH9Ovi0c7v3pS/9u3vIqGMDM=;
        b=QBAbsIamgijzH9Uawew3lyMdeiDXJ0UmKX2O6Q/P4gUdFqlq3pY7+27j0LE4Ac/DFd
         qjPYw8VnJ6tPyRHAs+XgVG0ZSkw4RXAaxMXdHeeRC1P/rqsHN2m9BaGwOcaoy9WlaNd5
         PuaHQpCn0H8INtu3Cl5tX1t20bAkhKRLui+3vajKLPDwYc8hW37llJOzxDB72Bs8/VBM
         G9LdN8DBWCBG9v3Pol33yKaGxtzweddm3U0SjxsPvqBoEnodmarhp1V+ohA65JORqLTP
         4tfS8we7+kl5snzt2dx9GacCiRs9lj6ssYC2SZYPMssKPRomPDL9Vg0vwvkpFuYMBrXS
         JEmw==
X-Forwarded-Encrypted: i=1; AJvYcCU7sD7vfjt/MEpsboVrnZK+1nJesXbvd7Fd83+CBOwlmo/boakSCQPJiREeXcBysijGq91Rk3F2ZS50cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9m9gaoMm0AlySPlIUH6cCz00pXbTD2wPR0kYAH2uIGaAuyLK
	EoAY5FdG0X/7V7tCxY8sLnegIDMgP0hTj/KiJHahIRNVMQmiJplrvCrqh3dPTmk=
X-Google-Smtp-Source: AGHT+IGYhSYu010tZ5icXn0iop521N+VU/nDnRxmg9olvNYFuvdTUYp7rwb3W1+U+IQY2nDuJqyK5w==
X-Received: by 2002:a05:6820:3107:b0:5eb:8488:c80b with SMTP id 006d021491bc7-5eeab4d76a1mr159546eaf.6.1731614369724;
        Thu, 14 Nov 2024 11:59:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea0120029sm586318eaf.16.2024.11.14.11.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 11:59:28 -0800 (PST)
Message-ID: <4ee9df47-c84e-44ca-9ab6-f655bfda7481@kernel.dk>
Date: Thu, 14 Nov 2024 12:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add larger order folio instead of pages for
 passthrough I/O
To: Christoph Hellwig <hch@lst.de>, Chinmay Gameti <c.gameti@samsung.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com, kundan.kumar@samsung.com, gost.dev@samsung.com
References: <CGME20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410@epcas5p3.samsung.com>
 <20241114135335.21327-1-c.gameti@samsung.com> <20241114161744.GA2078@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114161744.GA2078@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 9:17 AM, Christoph Hellwig wrote:
>> @@ -313,21 +314,35 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>  		if (unlikely(offs & queue_dma_alignment(rq->q)))
>>  			j = 0;
>>  		else {
>> -			for (j = 0; j < npages; j++) {
>> +			for (j = 0; j < npages; j += num_pages) {
>>  				struct page *page = pages[j];
>> -				unsigned int n = PAGE_SIZE - offs;
>> +				struct folio *folio = page_folio(page);
>>  				bool same_page = false;
>>  
>> -				if (n > bytes)
>> -					n = bytes;
>>  
>> -				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
>> -						     max_sectors, &same_page))
>> +				folio_offset = ((size_t)folio_page_idx(folio,
>> +						page) << PAGE_SHIFT) + offs;
> 
> I'm not sure if Jens want to rush something like this in for 6.13, but if
> we're aiming for the next merge window I actually have a 3/4 done series
> that rips out bio_add_hw_page and all the passthrough special casing by
> simply running the 'do we need to split the bio' helper on the free-form
> bio and return an error if we do.  That means all this code will go away,
> and you'll automatically get all the work done for the normal path for
> passthrough as well.

I'd rather it simmer a bit first, so I'd say we have time since 6.13 is
coming up really soon.

-- 
Jens Axboe
