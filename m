Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693714F61
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VdhpRJya"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28bae84fc2eso1331010a91.1
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 15:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703891817; x=1704496617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHjuYhnakk0zIc7pPlGsNQv2zuEmQiuEbwY7MUfZxMc=;
        b=VdhpRJyahCrZ7HVky4qXdm0IdQxSwlA1mX+mF7M+vYNYiBCVxPutl1ZTvIOOt7/R6t
         kjDC1NUEbjFlcfoNu4Cqa7N2rk1Dkhp+8S0O+cEkvJyWcs3skkcizQZawf3Kw+cnu2Pm
         6Zo9EF3k+/p29xjv1gnnxP6OVhOHDov6Z2KpdHnpC+suUuSshrBw7wlwS5sgcbaP45lX
         52m8WeGG+ju4XT2hig93WVusOTl7ExtRwOHXr+mZhxzfgEirQ9B8eiWHtqgRc16J4TwN
         HzqUt4OfHDP7qp2ZwPGQdek4d2jn0dX5Pb9RDRju1mq/WJchGVajr7D+uooK3Pb1n8BQ
         b8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703891817; x=1704496617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHjuYhnakk0zIc7pPlGsNQv2zuEmQiuEbwY7MUfZxMc=;
        b=I7qKVDY0iTNUi/N0f6QCzEygO79ZnG0OOQk83ZkLlj0kycNUdbHBwrWerhhaTwUpPK
         QG/cpXi8uu/ni9ovn8jkt9p1ggzrTvovYvjZICY1bvpdHXzyO1ixT/6+sWcA+gW94PHY
         Aq8sewgJ6N38mHV7Jwd+yfMY99lQrZL+DHGcF//KJ5SXTqdw2CQ7HpBRkkInGDlMfAAq
         3NeulG9s08dCNfUjBun1dwgArAj3c+haVrqziqcYWiwi+tv5hPfLT9BIlHi7Qv5/Z1Ab
         I1EjQTFReXNR+f31OwiAyfT1xSLWt599VQYyTZM1qAQvhMYgZPtrpS51+ukKKyA4duWf
         7btw==
X-Gm-Message-State: AOJu0YwmfB99huoj9OzLmPllDhGS9qUTRpIHLwZ8xavoduZeNY7MJE63
	w6QM8QP4kjthxYFidiEMteBuorAq3y40WA==
X-Google-Smtp-Source: AGHT+IHKehadvZona/UAjIOBIM0zu+bA9KxgzpLaoWb0I6w2QAijKkrazwlloHBjxcV4nY28p6jYtA==
X-Received: by 2002:a17:902:b68c:b0:1d4:9769:b468 with SMTP id c12-20020a170902b68c00b001d49769b468mr4825408pls.4.1703891816759;
        Fri, 29 Dec 2023 15:16:56 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902ee9300b001cfb14a09a4sm16235677pld.126.2023.12.29.15.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 15:16:55 -0800 (PST)
Message-ID: <f2de6069-6126-4e38-96ad-70873b2de2f7@kernel.dk>
Date: Fri, 29 Dec 2023 16:16:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block fixes for 6.7-rc8
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
 <CAHk-=wiZt=323ca+Fp6rUNHHzPn65krYx=pZ5REbdxuUeRGfdQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiZt=323ca+Fp6rUNHHzPn65krYx=pZ5REbdxuUeRGfdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 12:45 PM, Linus Torvalds wrote:
> On Fri, 29 Dec 2023 at 07:57, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Christoph Hellwig (1):
>>       block: renumber QUEUE_FLAG_HW_WC
> 
> Lol. How the heck did that even happen? What an odd typo. Admittedly
> '8' and '3' can look a bit similar if you squint and have bad
> eyesight, but still...

Christoph is not as young as he once was ;-)

-- 
Jens Axboe


