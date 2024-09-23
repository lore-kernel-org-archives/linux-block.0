Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6ED79F5;
	Mon, 23 Sep 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106909; cv=none; b=bhxlri6Q4WvTI6BOD1/IGu11rvqZC/jebmFR9301JdLbAsJ2FjGeZYq4ZjyrxAfw7DYs2e1z5NJPGo7J96vxXBvwoWnEXOj6tnAHvfuWUqOY4abNpzipjYW2CfiSNrtdrxKq6b3WEtrVwNZ5WvvwgeRUDiouBEHJZVP8Bka78rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106909; c=relaxed/simple;
	bh=I4qqvKfI3qsxSjajX+axsxmMdK2WOz0a5Flac1Plv5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBEoASezDaOw2CpvC3snpflhZEbhPvBTQPvFwgIRsh+Bwl5v0nHX9gk+xNnv/hiIvJnKl1heEow0GvLM5/Eh428gFEgnLuzkBk7k+KjB0YG/lLJi0exPU5KGA/MQdeW+6AAAlUcL2ivcHctIiFmux9xoSD4UdNSJtoUcGajf7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OObR0qQr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OObR0qQr"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365928acd0so470930e87.2;
        Mon, 23 Sep 2024 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727106906; x=1727711706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J96D0VZp4OQWTWTHY+mSQGAMc4n2W7afLh9IPn5NwlU=;
        b=OObR0qQrDhnwIDZdtbec3cdJRZNsvS32WzU1Oh6Sb0/lR+v0xHuEQ0ygGc3G1e+ntv
         rbTZk9cewr78P5164cn0pDO+DuKBhNxBOjdd5ebLZzwqxoQa01WohvG5OyrTO/5+TnyM
         4L0rwSEshgx8DoQO4BMI+x40hB1kVfVxPKq+Wz6ZuhXnkp7eb606odXx0q97pyLDihHy
         i1P9hj9GKr2SePlCCQZi770e2pCoQ6pc8to6Piu7HKMWf+Xphnx1nuksAfrmTqgG+jc5
         YqiVkzGdmvWBfFBz+ykTFI/pwdITzFfPh0KQTfsYreCBtQmxFDFK1a85H1U07TYy6jap
         45jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106906; x=1727711706;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J96D0VZp4OQWTWTHY+mSQGAMc4n2W7afLh9IPn5NwlU=;
        b=TVNGtIwG2Ghv2JAeEExWAJBZnhT6OQ9nvlXxN6Q2f1b1pvw8Eye3ixiN9WlP9OkqV6
         0Z9uBGcdk3ZE+Synm4A5P7j3FHKfT/xWICKD8jRZz7qoarz7dKhCmYXBOpep94H19A1R
         jO4lXH9EFRy5dDnU7mbXpWrrlMu66lDPysM+qF7oCiTYhAGAoWq6U4/UYSfPxfep8hC0
         I2TYAVOjUjpLfBkWda9vTIfkhVrJJPRpsZrIirxsiag4ZlVFKM62wt8dlDfnsq3NQ/tj
         pVz7lNh1Q82cpROhv3ojWo0mmEBGlBe0k74j/LvLn7hg2cBSkG6MyxJrXhxP1eWdeD6T
         v+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4m79bXv+g1wMXoI9u1jwXKm+UaHDyiMAUbZs6W4iCfDHIgylLrYr0R8v8p7HkecJdpdwj6OYVJ3lB2w==@vger.kernel.org, AJvYcCURskPrtYR3ilP+TVxCmrcTxWQ8k43jVma3e1HfNbBW/se/aR1No58XbE8yoYdKQbgc4wRxDhi8u4O4fcFp@vger.kernel.org, AJvYcCWXkvdltA3li3NtXP6u/lIVv2yDWghff4jNsFWvSx/hf59/04xRK4zXNJnAUYHNZGqo/2kYhSVF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jKsIwVzPTBtzgbfK+K/cz0UeQ+xS9Rp8EgqOf/UNTjt6vDp1
	KQu/GeF5YPYnbq55+GH/1cdkzggM7oIamNk1gc0UVYEkqD53bFep9l3bKmNk
X-Google-Smtp-Source: AGHT+IG9eayZYDTNm5hjijheO6JpBCyT0OpbqAXtx9FxUMw7FEdoTZ3KlaMLsBGwM/PoIFtTAfY/Mg==
X-Received: by 2002:a05:6512:2251:b0:52c:8979:9627 with SMTP id 2adb3069b0e04-536acf6b73fmr6524718e87.3.1727106905782;
        Mon, 23 Sep 2024 08:55:05 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704c35esm3337263e87.77.2024.09.23.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:55:05 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:55:05 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <ZvGPWaXm26iq-8TI@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
 <20240923154738.GE38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923154738.GE38742@google.com>

Hi Sergey,

On 24-09-24 00:47, Sergey Senozhatsky wrote:
> ** Re-sending properly, somehow I managed to badly mess up
>    the headers the first time, sorry ***
> 
> 
> On (24/09/24 00:34), Sergey Senozhatsky wrote:
> > On (24/09/23 11:02), Andrey Skvortsov wrote:
> > >     for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > > -           kfree(zram->comp_algs[prio]);
> > > +           /* Do not free statically defined compression algorithms */
> >
> > We probably don't really need this comment.
> >
> > > +           if (zram->comp_algs[prio] != default_compressor)
> > > +                   kfree(zram->comp_algs[prio]);
> > >             zram->comp_algs[prio] = NULL;
> > >     }
> >
> > OK, so... I wonder how do you get a `default_compressor` on a
> > non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
> >
> > I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> > and below.  As far as I can tell, we only do this:
> >
> >       comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
> >
> > in zram_reset_device() and zram_add().  So, how does it end up in
> > ZRAM_SECONDARY_COMP...
> 
> Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
> so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
> Yeah, that all makes sense now, I haven't thought about it.

yes, I don't have CONFIG_ZRAM_MULTI_COMP set. I'll include your
comment into commit description for v2.

> Can you please send v2 (with the feedback resolved).

-- 
Best regards,
Andrey Skvortsov
