Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FC1E498
	for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836029; cv=none; b=jSivq9iRy2m0XrUKMpzT4mwi+0OPZ+/4joFZl5as5VlfEN/N5e8RjcvoDThnhBsn/PEbdLx0w/75HJrP/MvFbKhiOB9PM+aH9EG2S+CCNtNP42E7mW2lhfywVf/SwnfqltKWTupwBi7watcFlmiwn2aRZPA0tp4HXjmzKCkSlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836029; c=relaxed/simple;
	bh=q4/BIqY4njqvHVv2+iuLTLDB8guMw7qRfA1PrzlgKb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGXMTob6doxobxCnDtzgi0/OzAU9MY1oddaJx9uNV6GRp9NtzloKPfuc/KTySlrzTRHwlht0k6AA+fTOu8cnkWR67g9PA2NR8t21CxIdEYu3bpb8pnLeseWglYvEzLqsKYDKxNZIHCBvjvEJ3pjJqIjf7bA5v7LuAHE6yFw4MGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wDs2Ootu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wDs2Ootu"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso248853466b.3
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726836024; x=1727440824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiKowJe0HbnPow5P8xWO2DJd/woQKyyq0ClUMSBtZrU=;
        b=wDs2Ootu85NAu+i9fOnsV7ZU9vKx/VgA5WsNTzbPiitKhMDjhITdQ7+RP1btZCngA8
         tpynl8xn/KrjaMt0iWbnGajVk4CwqSNoHTiOqTEV/j0IOwMivFokvQYCNlleS6WM4xX0
         k28w673Y8zRekRi5XK56Y/cuPT8K3z00U4DrjmcyjFxIxz+FY1zUdwg1wyfwc8bGehYs
         GHsn+4tj5vRPTfMphFnA+tfHAW4rbjCFe2zl5GmAp0AjCRcajvOhSd0Pb2nmhg2blTEn
         Vt9a0JdvJ3QcjhSnilU4ljJ171HUqCOmmrOqXSsCvMEjq5PWTWP15WDG4V4ArffBV5JN
         /vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836024; x=1727440824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiKowJe0HbnPow5P8xWO2DJd/woQKyyq0ClUMSBtZrU=;
        b=EirVn+eDAkCUIikK25fpw9qSS7jTHAQ1zHo4EQxlffFelu7WW/cJYoDQtu/2ZOzERz
         WTJUfA2MfL9T+pq+arCR4lBmkKsduHmxF2NVdesLROabRm8CyqMO0ltktb4f7tUCOj4Y
         lKmmIalcyHo9NyNxa77k+9orN7uqwn6V0ZnmceW5EfRBzeG5i5Zq2hZhUixoWIacucru
         fb8WhueRAzc0oUkeM2ZqXd5SDoKewywGmJy8EopJRVu+JOXCeEdhNltmAHtTdxZ3uWPz
         C/cezBuLuEvSBNEPCMt2HZ5L+dOIIhIwJ8wWqz126KLxkfKEbqvgdjh4mg3r7Bkf7aQw
         1m1g==
X-Forwarded-Encrypted: i=1; AJvYcCXh823e0++ohFkliBRXxcGNbdF9aFmLiXUheasQqpsuuuc/i6QgZGntUyl5nZEDuavVA35gvZo/q2SECw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXai9GI+OwvjsWl3Dku0H4ULNCk/P6lPBBMnN8MCPX5GJxXHb
	dhxO5jviU9FDqdlxg4U6g84K2Nb/Epsx8hKnGGBMn5Nu6TajqMJ8Dcijr6Xi2UU=
X-Google-Smtp-Source: AGHT+IE81ecvGa811EkXoyxww1gN9FJ7ZQtA+4G8+0JY+jFcluigqv32wSHx83rVVcOb2/GjOEiFpg==
X-Received: by 2002:a17:907:3f9f:b0:a8d:4631:83a9 with SMTP id a640c23a62f3a-a90d4fdf292mr246651966b.3.1726836023713;
        Fri, 20 Sep 2024 05:40:23 -0700 (PDT)
Received: from [10.241.208.32] ([193.32.29.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613303b4sm838990666b.213.2024.09.20.05.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:40:22 -0700 (PDT)
Message-ID: <05c413ac-c020-4270-86b5-de407d878cd6@kernel.dk>
Date: Fri, 20 Sep 2024 06:40:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: fix PKTCDVD DRIVER to use L: for the
 list address
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 soc@lists.linux.dev
References: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
 <20240920-maintainers-m-to-l-tweak-v1-1-ea80b5cd3420@linuxfoundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240920-maintainers-m-to-l-tweak-v1-1-ea80b5cd3420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 5:03 AM, Konstantin Ryabitsev wrote:
> The PKTCDVD DRIVER subsystem has an M: entry that points at the
> linux-block mailing list. It is perfectly valid to have no M: entry for
> an orphaned subsystem, so change M: to L: so it properly indicates that
> the address is a mailing list, not a person.

In lieu of finally being able to delete this ancient thing, this looks
fine :-)

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
