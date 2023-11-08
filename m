Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44F1375
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfLCvm8I"
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9D18C
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 19:32:49 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b565e35fedso3767368b6e.2
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 19:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699414369; x=1700019169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwPD+Rde1MAFpdeY2SR3+ww4lp4GJVbxz+U6acIXKwY=;
        b=FfLCvm8Ij7q/sxuITqYw5FTWkYM+GlJBqedyN8yL0R5xJfGm7qc1UaNPASqR/5A0cC
         I0RNgPX4a6pEGcnZ9s/Q9y9QS+PSA9g2H9fS5SWXpYRSs8AiYjP42yERBAVRqVhPfm0U
         a4hfe/4S4lgsqfcvuqK7tNZJkHLSHWxYsLyao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699414369; x=1700019169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwPD+Rde1MAFpdeY2SR3+ww4lp4GJVbxz+U6acIXKwY=;
        b=Dm7spyg63z6T2pz4s/d7unGEH86xvrLixa5uGpPDZbqG70NDKdN+OcyND5EKs1hrfw
         RdpOu2Eo1Sp9jWw0mnApQBZGtqBYN6KS52MYtXOJtw6UOUwRHqHQb9HuHbMLFX3Yn/2/
         1I4+AcNm/xtFi9OcZjsrF2xWIkcW9wfvg6fnELV+3tF9hKoOV4/c9nU2vokLjkGUzWWF
         9SRQN6XbKmOv/Eccn4nQJAS9XqFS3hmq0ulvwjhn8KQReEtiPAcxLntfIShkNJYCNiTr
         NmTnv6w5RNYWJcy+Cy2e7Nx+EfiYTvQaGZ+Tz7dAAgqSkyDDEP7anzyzM9WUss06HxbR
         AT6g==
X-Gm-Message-State: AOJu0Ywn+b60yGrE6SOKywPTKIxHDQCIeakO0MN52VzRWu0PhmZcblbM
	ZO6gGUcHFI7+p1GYAAJDFq47ww==
X-Google-Smtp-Source: AGHT+IHRiu7ZQ+WxmBy4YGnFBFYynW3enn5vUtc0CeHsG9PUIyFzicmBmBNmm3FH7375+t4CCzqJPg==
X-Received: by 2002:a05:6808:168e:b0:3ab:73a6:1469 with SMTP id bb14-20020a056808168e00b003ab73a61469mr1163417oib.14.1699414368883;
        Tue, 07 Nov 2023 19:32:48 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006bf43e5619bsm7846598pfd.195.2023.11.07.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 19:32:48 -0800 (PST)
Date: Wed, 8 Nov 2023 12:32:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vasily Averin <vasily.averin@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Message-ID: <20231108033244.GH11577@google.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
 <20231108024924.GG11577@google.com>
 <b87ff5e2-156f-4bf8-9001-9cfbb79871ae@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87ff5e2-156f-4bf8-9001-9cfbb79871ae@linux.dev>

On (23/11/08 06:16), Vasily Averin wrote:
> On 11/8/23 05:49, Sergey Senozhatsky wrote:
> > On (23/11/06 22:55), Vasily Averin wrote:
> >>
> >> 'element' and 'handle' are union in struct zram_table_entry.
> >>
> >> Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
> > 
> > Sorry, what exactly does it fix?
> 
> It removes unneeded call of zram_get_element() and unneeded variable 'value'.

Yes, what the patch does is pretty clear. It doesn't *fix* anything per se.

> zram_get_element() == zram_get_handle(), they both access the same field of the same struct zram_table_entry,
> no need to read it 2nd time. 
> 'value' variable is not required, 'handle' can be used instead.
> 
> I hope this explain why element/handle union should be removed: it confuses reviewers.

I do not agree with "union should be removed" part.

In this particular case - using handle as the page pattern (element)
is in fact quite confusing. The visual separation of `handle` and `element`
is helpful.
