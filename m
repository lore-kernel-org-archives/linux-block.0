Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1B199E84;
	Wed, 20 Nov 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094300; cv=none; b=lr9tOexaX+arrPV69lBxasS5BqSuiobItsIcISkCR12IUkYEU5wcBbjwiYHsumAgjCyHho1cB0hLYDUmFcHA0DMDsRAKLXEN8kAZ27qQK5aWfZ4ooK+3FXvd4aoKdoJeDA2BkR0c94f6cWkUsKlCymFXjTs+d96r6z8zu1tstvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094300; c=relaxed/simple;
	bh=RQe4qxk3Ec1zQwrzOpzqrFQ+eM9ByiUfT2lAu5S2CTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLO7hxmScgXfl97MEAjWYIOCIjt+n2ZzeutxU7u3zEd0wUdQRBw8gYR/5HmxytUfpeqHWEL199Q+4SRH8U2iQ7el2nOfr5N8dVU3NTh4WgD+6FYiuIVRcDBtpLQl1RFOeYQqo8q8E96WZbuJmdCnFUP7zGV2zu/UUV40EwZaI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3+muXXx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3+muXXx"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso3043273a12.2;
        Wed, 20 Nov 2024 01:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732094298; x=1732699098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcVN3Jdae/34UfDNTnVWZvRwthuxsod5WOI/U7hm32s=;
        b=P3+muXXxdBmsPSDQ0eA8kd2BEtSwMo4cpxyNPDZuer2Y4hUkcb3IQXDqZXKWTcIp7x
         jxAifGrBb6ZO0ldubzclIjkoa3VKE7mberVl0753ftOdvq3LlGme6y+My4Mt+5ZJNwhK
         0N0qLzeP4nVJlmzcpNeA73gLzb/Oj9eyjdOofTq+1cMEK00YQQ6NFb5D05wYHrB+YcJ+
         njFR6gXvP7SdcDGQsNRyK1PjYAULi0gVqRYHO5jSmTzNjOEHLdErVwSJCGED2WnhEIT+
         +GVmdb4GNusy5mKonj6XDILdDqNENpvj7guTAQ34uQPuS9tTHQcKkQbqiwIZCxCVVmoR
         yZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094298; x=1732699098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcVN3Jdae/34UfDNTnVWZvRwthuxsod5WOI/U7hm32s=;
        b=P0IDLw2d2Hm+544LP6ftGmfeYKg1VrSWUGD7Wg9nbpYvt07Fn1azB9hCa0GBcgAvc/
         149by/Uo9F6bdoIgcwt9TZM/9ZGUzw7yXja3v6j8WX4Oc2F7Lf+20VuB35xqJ+DvRpB4
         43AoLOlESH3hjdoHTPJA2dxRaLzdqnykcl4IWXJoX/rYymPGlVbDKPK6jrf7HhhXSwJ1
         l9lh5WlOx+7UV1kTJFSlmyJJrdIs2YDvxIZLh/gQ4cjphBsJ8k8nSlCEJwyGr7NeBy8r
         uwTcYDbRkYWSqtrrMtdTyVb0pUmvlS4b0nQJZhqa/2tvSR7XMujQp/v1KrJDQdMQI4Sv
         QIcw==
X-Forwarded-Encrypted: i=1; AJvYcCUiIKMYdAaxnAosOP5PuvgeE4Oed6PpM42gwTOER+CYYKaJoQXTUGjfm1zBanSwZIw7ygqjMObE3uLEQyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+B8nN/6ZfBkTAbLIrL6h6ybCNij/NovQCn0u1+J06vGpvEOKh
	GTygvHr5k0ttbzbg6R0sjnWMMxh3ho03suRgSTjrEW7NTXtndl99
X-Google-Smtp-Source: AGHT+IE5qBNpPrE4P+vZYRI/OV6G5NqY568aGUhN8/36GNPvukImlh0PPDNwOf2dfGXkozRvvB8w0w==
X-Received: by 2002:a05:6a20:6a06:b0:1db:e508:cf68 with SMTP id adf61e73a8af0-1ddaebd6caemr3201947637.24.1732094298245;
        Wed, 20 Nov 2024 01:18:18 -0800 (PST)
Received: from ?IPV6:2409:40c0:11a2:6510:b9eb:15c5:a64d:93da? ([2409:40c0:11a2:6510:b9eb:15c5:a64d:93da])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c176b0sm9217732a12.2.2024.11.20.01.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 01:18:17 -0800 (PST)
Message-ID: <3a73d963-36ef-44db-8fd0-7b4a5c73609c@gmail.com>
Date: Wed, 20 Nov 2024 14:48:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: blk-mq: fix uninit-value in blk_rq_prep_clone
 and refactor
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org, hare@suse.de, kbusch@kernel.org
References: <20241119164412.37609-1-surajsonawane0215@gmail.com>
 <173206838768.183842.958207443357457539.b4-ty@kernel.dk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <173206838768.183842.958207443357457539.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/24 07:36, Jens Axboe wrote:
> 
> On Tue, 19 Nov 2024 22:14:12 +0530, Suraj Sonawane wrote:
>> Fix an issue detected by the `smatch` tool:
>>
>> block/blk-mq.c:3314 blk_rq_prep_clone() error: uninitialized
>> symbol 'bio'.
>>
>> This patch refactors `blk_rq_prep_clone()` to improve code
>> readability and ensure safety by addressing potential misuse of
>> the `bio` variable:
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: blk-mq: fix uninit-value in blk_rq_prep_clone and refactor
>        commit: dcbb598e689e30d4636201d35582e167d1b8dfa4
> 
> Best regards,

Thank you for applying the patch and for your time reviewing it.
