Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RW4NtGgg"
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA86CA
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 10:41:02 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35d559a71d8so2986825ab.1
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701715261; x=1702320061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nF/2go7Oh+X36EEMP+OJQ3WMJQXuy7RxDAu7l6pxwI=;
        b=RW4NtGggQhTrYZK1Qmc1d7zjjg5dEmVgaCD4soCV4Mvw7euO4WY6i6Qk+4dKfK2Rxy
         z/hn93scfymepBPSqhCTdv38L9X1m46DxWENw51nUTf7eJdL85kZZUoK+34aT34MIkRl
         vok1BDPx/c1Mx4VeDoNMSG/EMgfMikG7RFLNW7NWOMB6Q+Egcys6R9/4em9kUTbplSkv
         LsDZYabo8pR6Q4RatjhBsuOiyi8zJ5R64tnmMXhVpUxGCkBIE0RzpTGXEf77FXSiB2sf
         HxNkl3hIPRKUvIIETKcxebNYhsxmzve9jTMpL69LCiA+O26NxRMmw/kZIFgZ5uRelEen
         oY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715261; x=1702320061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nF/2go7Oh+X36EEMP+OJQ3WMJQXuy7RxDAu7l6pxwI=;
        b=f73pqreJobEMqLBR5ZHe+MUZ6OQZTt94IHKlo4zgKn9jyEB8BSxI2C8Q1K6rGSdAwV
         UixDN8NuA32sLsVxZ1RBMOf7pvhMioxqCvVazBP+QVbmfgJWhC7g0KFrhEKz35Yr+Aeb
         vWE3ebFrjpT5u60KmM3rwQWxIHFf5m+yjVYj4ottu0pNW4bF98YU0HwMXNXU3jL17lAz
         nuKyBanKA5EK8moAsxrGBqqUH7VDrpm+m3gBCzc8ihbRvI7Z8u/WkuvHQfOM6CsbTWQL
         Emd3PvtCQZTggx6x3IJaZ7cCknw59ZXgbZkhV/mtcFT5NSiukiduz2MpGwCeaN524jFI
         TbTg==
X-Gm-Message-State: AOJu0YzyBQHZR0p5IGAHsXKTFLVJU6XxLIgKwfRRtwM0dlPcYH+fSq1g
	W+ED0txMDojKUDyDG+Cf8T+FLQ==
X-Google-Smtp-Source: AGHT+IFwnXzSZ6zMUt3RFVhl4mWAcRHCUZgHbMqGp/IAkapXbe/q1AgrqU1/KeEhU/TQrREsFzf9Jg==
X-Received: by 2002:a6b:660f:0:b0:7b3:58c4:b894 with SMTP id a15-20020a6b660f000000b007b358c4b894mr30267653ioc.1.1701715261426;
        Mon, 04 Dec 2023 10:41:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fn20-20020a056638641400b0045812e7b8bbsm2621977jab.25.2023.12.04.10.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:41:00 -0800 (PST)
Message-ID: <f5ba61c7-aae8-407c-90e9-4d6d9316d33d@kernel.dk>
Date: Mon, 4 Dec 2023 11:40:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/35] lib/sbitmap; make __sbitmap_get_word() using
 find_and_set_bit()
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, Matthew Wilcox <willy@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Alexey Klimov <klimov.linux@gmail.com>, Bart Van Assche
 <bvanassche@acm.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-2-yury.norov@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231203193307.542794-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/23 12:32 PM, Yury Norov wrote:
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d0a5081dfd12..b21aebd07fd6 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -133,38 +133,11 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_resize);
>  
> -static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
> +static inline int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  			      unsigned int hint, bool wrap)
>  {
> -	int nr;
> -
> -	/* don't wrap if starting from 0 */
> -	wrap = wrap && hint;
> -
> -	while (1) {
> -		nr = find_next_zero_bit(word, depth, hint);
> -		if (unlikely(nr >= depth)) {
> -			/*
> -			 * We started with an offset, and we didn't reset the
> -			 * offset to 0 in a failure case, so start from 0 to
> -			 * exhaust the map.
> -			 */
> -			if (hint && wrap) {
> -				hint = 0;
> -				continue;
> -			}
> -			return -1;
> -		}
> -
> -		if (!test_and_set_bit_lock(nr, word))
> -			break;
> -
> -		hint = nr + 1;
> -		if (hint >= depth - 1)
> -			hint = 0;
> -	}
> -
> -	return nr;
> +	return wrap ? find_and_set_bit_wrap_lock(word, depth, hint) :
> +			find_and_set_next_bit_lock(word, depth, hint);
>  }

Please make this:

	if (wrap)
		return find_and_set_bit_wrap_lock(word, depth, hint) :
	return find_and_set_next_bit_lock(word, depth, hint);

so this is a lot more readable.

-- 
Jens Axboe

