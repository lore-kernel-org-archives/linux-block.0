Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D936C580
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260683; cv=none; b=VjLQKYWaETKIYaz/PuN1PCvEV/NpkenOyplFkvh90wPRhdIZp7p7rnmqn/gTxL8hOcXK4E9bmu70De0jKfKhDeAAcjhKfnzGOy1HV8uOw+pu7AuKksVnadPjYSYy/lXdQH5S0gCSu0ONXQLAxnijLOceKvC0An5BMlhtFIT4mTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260683; c=relaxed/simple;
	bh=1ebZfbM4X603XE/sdZ/ON5ikeZRpPVo7q4h0RtA/jMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi9lFP5HVi2j0OUiVKd+UENlJtZouQt0dW++S6Nha89Z3kyxUFiRBcaZxnTv+DtMBs2MTsfHs1lgxUgyjOV89oR8RTNZUcRCZZI9dr0R/t2Pzi566+49mH/MeX1ZeVfLPt/j41VAnlVFefKlvKOcodfW4Cbi1Ew+H/ZtRAKDqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McOcEVag; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McOcEVag"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4671cbce626so170397b6e.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260681; x=1773865481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VjrInrO/cbuWkSTY+7vTnSbrX2Q7GpHHflnugtvKto=;
        b=McOcEVagGHS7MoGWx5kH7DTu++OAvU6GUZiVYF2guwYMEuQbpYI5TmhWHEwpu5eahT
         JoucF9v8UEcly9vNLRiSpLyBsvdY+iDmW/5q78/P0/wcEoC7TFGAUav3WqbPz2vaeQQS
         B90PzXyrsXPrYXlnkk/fRmS/bkatmFI97jaaOHgGBTmotTBpNwjRrtf8eHZknlcgpRx+
         81B/xD5Ozuee7K3UBqgsFipKZSmhxQxLKAcgYIwOb7fLqrtfHC0/NDwhMMmUotZ2Iv36
         dxx2OraPGQw/MlWBt4PsFbnNmCx93AK1c2qopuiQktjyE8d3x8vA5bDRPvs938jehSaj
         f0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260681; x=1773865481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VjrInrO/cbuWkSTY+7vTnSbrX2Q7GpHHflnugtvKto=;
        b=XtMDgrotI6E8/uH4iaBZDGCOIjCSCT0KzGFzlI+pPmOh0/LI+u+c7ihYMSY9d0+Eay
         bGz/9dMxNA/ihhYJqEIvU6FhVPxPPXddswaZSos2RDM138Fynf0Oumzp7RXktU3f+Aas
         vswCDJEf+Tn2sOHmxJFAuoUb8FM2oMsOhe6jZx3ybXoIWXrcDrWMD35RviiRijEU+o42
         QR3tC4kEJcD9GDQ+R4vDiIbgcX4Ze4httPCFmeqy50rY6MOtrM9PpkwxXG7xX3vzzRiA
         /wr5vk+oCmBraRrtnXbLCLaadr32wCNRPuBRGHpmo5l6zGy6eG1TJJnnWsvm0WckHrI4
         ddWg==
X-Forwarded-Encrypted: i=1; AJvYcCX6TY7rhE8sKoq31v05Y6GiTrfOUmIF2zZaGzlakAiLlq1+2qLkZEFOWX7omeh8U4gQDKd44a+J+rCt3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvzL01PbHnfu4i8395hwgxcpGBo39ucCqYCyiyPvx5+oSotY3
	gUfCGDBEWWXVZZlgWj4TFDvUjgQZODN3rCsjj1zS6hoEar8z7cPrSpPN
X-Gm-Gg: ATEYQzz3BrTFHGbWRd3/GCxdrEZn+nk7kHW+jelp4wDsfRBOJKkjXY/ivicm0jSqVmX
	ELUKk8AKUK30ZBWtw095G536MLH0FCqe6xLrvpEYCRB5N5RYvJyUEl/vrngTM2jvGpC0I7C7fEm
	2GhFwnfrE0BjGK2aHYZH7wE4Zkg6ClO2uzyYb80UaRIhYO/jpIlFDnID/MHXgwv48GsVskSMsiz
	TjFnmpFRJZWaepIYQXP/VCCHn1OTjucLunzJcFyWTJTu1zaz8yp6HuiyzdD2/xwRYLadLDN621R
	1uUG+hTSwj3ejodYN9DcDu5QBZ8xnTdLhYE3HkS2eU6NcC7kcmyTt142rCvwsFrZIQahW2guqAD
	UI2VCQ93KAhPuepotud4LHHzVKH+74jxZdsteUNtE3sEztSKnA9vJsii2rJa3xVXdbiJ7cJym1I
	0qhrZZzBUnQgQdpn6bxbE5Yw==
X-Received: by 2002:a05:6808:1927:b0:467:880:7441 with SMTP id 5614622812f47-4673346153cmr2131673b6e.18.1773260681119;
        Wed, 11 Mar 2026 13:24:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e9f53sm3382611fac.13.2026.03.11.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 13:24:40 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 05/11] mm/zsmalloc: Store obj_cgroup pointer in zspage
Date: Wed, 11 Mar 2026 13:24:38 -0700
Message-ID: <20260311202439.324081-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAO9r8zMRwFTbv4jWWNf2sEc+SkUawxPtnvOc7LKsJr5R3vkZjQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 13:17:26 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> [..]
> > @@ -1216,6 +1216,11 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> >         class = zspage_class(pool, zspage);
> >         off = offset_in_page(class->size * obj_idx);
> >
> > +       if (objcg) {
> > +               WARN_ON_ONCE(!pool->memcg_aware);
> > +               zspage->objcgs[obj_idx] = objcg;
> > +       }

Hello Yosry,

I hope you are doing well. Thank you for reviewing this series! : -)

> If pool->memcg_aware is not set the warning will fire, but the
> following line will write to uninitialized memory and probably crash.
> We should avoid the write if the warning fires.
> 
> Maybe:
> 
> if (objcg && !WARN_ON_ONCE(!pool->memcg_aware))
>        zspage->objcgs[obj_idx] = objcg;

Ack. 

> Not pretty, but the same pattern is followed in many places in the kernel.
> 
> > +
> >         if (!ZsHugePage(zspage))
> >                 off += ZS_HANDLE_SIZE;
> >

Definitely better than writing garbage and crashing : -)
I'll make this change in the next version, I think I should also sprinkle
these WARN_ON_ONCEs in a few other places as well. I'll be more
mindful of this for those cases as well.

Thank you again Yosry, I hope you have a great day!
Joshua
