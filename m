Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4619C553
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300604; cv=none; b=aPKNI7hhkokVBCZ2ebfM68Ak3nfKizHxOizZ7RlaZl72qkom05ZHya1N64Aqps5zRefcuANIVQlkSYhvYa77EBZ9TUMSvOwrh+mSYViY1jG6JaUC9x+dKWq12BBrFcdTnswCiaADmtKybhuHvr8Y3odvnEZZubiXZ1OTKlp6SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300604; c=relaxed/simple;
	bh=SJzilvlcJHcTHqGyliveyZnTHMFGNELamBtaiVkxn2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDxL9w0XOT1xz9cpIIB3krPRZFv5DhlI7P1cBhBJE5XBLrT4tsv3v59yw4iG5s3Im/Cb71qN8D01+ILEcVhVqNXvZQscZmrYhCx8D/v91S6wCfE4qwYv4QCQ3gaGNjRUYQuPnXXaEe7wTZwlnkzN3f9LXgGj2vKHJNKCR/4YwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PrNaLLki; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrNaLLki"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso559828b3a.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785300603; x=1785905403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfToxm6QEw8mqwMRQS66uT/M13nI1gMKV9iwpsUtdmw=;
        b=PrNaLLkimMpnwZxfwJjE2fY1EsZZszXOLeBYa3y3IZun4yyChr2ZoZEjbdyN84iqPe
         9hqw/yvXmbvLZY15rrmBFEjNgX+Yeplu1HEIYnQRH0s9c+xdaQCNKXtwZ1AvnWHuRPLJ
         sJ1NlZ+uY8wejD6IbCCG3pDmmOjGB7lqAopa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300603; x=1785905403;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfToxm6QEw8mqwMRQS66uT/M13nI1gMKV9iwpsUtdmw=;
        b=pUIjPoefdl+XPS/ncMB0ild18oiW9UE0Bi8vUXjcrmzC3r0+EsKgkWRJ/7S+4Jn1tN
         IWTZP63QKO4IbdCLPlPVRyk+p1bzwYHAMPMk7B5tLBFKzBBI5cLJtW2XfOULp8/nu7WP
         67XoxJ5GKTwH/LlBLzd5yGB6/ae5JsG4O3SKifQBvOT7lzpjCy7lVpuhlfuUA/9o7m10
         Om8couIKYkQH6iQ5xj25HbAluUBI1LnIAGfgdqEQ1isF0hLY7VLdnBqbV0jyRCPpvj+m
         TP8iSN1yFPiZMU+7uH86EbGVkKEOHREbardz1OujLdGzgFE0SRunJ1GBLVZfWQRgL6N1
         Uuyg==
X-Forwarded-Encrypted: i=1; AHgh+RqaRNpL6eJslcz4/3t3qNyZKRNks2np6fi8YRK35bNiKNMrMuEBnTighbBjTPTrKftPYbo3s71eu92A2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcH/hHgNf7M5uMS0889UpidakJ6IQs11q1AGmrlkYuNSVxH45q
	38cqrm6Qen9ZnKfWz3JsauOHNEeePQTFeAjL65ikGBxwQnX02Hpd7vX4+mJCpQuMPzIDSDEJjmW
	sVp8=
X-Gm-Gg: AR+sD12jWekm9qfYahtt9DeHQaEzfUFpCNWQtVwSnYD7tRg4uO78XKYuvryBbUVl0O5
	IE1+Mo989hQ/+UcoNRTJHWLe1eOIXVNQgMdUNeTNoENnGgoXe9OcNJYk4+lnWEo58Z7zJXAixG0
	2Kb69jMX6qtoVxg4TTpniak7uZM00aB2V1JwxG6PxxqCst4wU6QcDqY5/Br5dnBe7ohbqcwI8cQ
	GkWYvPGzGSeuWxfKsKkymgLmZX+Mj7eII6/5fxFwl1gFcjF2Zo6DMuB/znOHXA53mfEaCix4lQj
	FMKXDbDRKh0t0baDV+UPoQFRrZ6L+DBPMJUR3H9suldOdxiHx7XblBBQQpR848GASliCUqUUeSv
	ru1eP/UWMS15e0rA+J2sVXnVtCuJzY4WFPwJ1YVzIaqpQvhes++wXd4K2mUG1u/r2DE7oUSGhlF
	70KWNDwnvBeGlK/ZnFll/ajSuasPnSjyv4zyCj9X26PF9M5gigQflhU6KKQE6t1nrzf2+4uyRyF
	mj9kqH+7srixXNrSm2aQAIJkDUv
X-Received: by 2002:a05:6a00:10ca:b0:848:2a55:7110 with SMTP id d2e1a72fcca58-84e932ed557mr5142666b3a.36.1785300602949;
        Tue, 28 Jul 2026 21:50:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea7344ca8sm260156b3a.21.2026.07.28.21.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:50:02 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:49:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
Message-ID: <ammFplxvg_6BQRD8@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-3-haoqinhuang7@gmail.com>
 <amltU9PgLGZYCD-1@google.com>
 <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>
 <aml_aEB6BDBqgIRH@google.com>
 <CAEjiKSmLSrfbtBukdC+fRqDY0tOVnyPtnxBEUyhrvrrwLbaxMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjiKSmLSrfbtBukdC+fRqDY0tOVnyPtnxBEUyhrvrrwLbaxMA@mail.gmail.com>

On (26/07/29 12:32), haoqin huang wrote:
> > > > > -#define ZSTD_MAX_CLEVEL     22
> > > > > -
> > > > >  __attribute__((__unused__))
> > > >
> > > > Sashiko made a good point.  Can we use zstd_max_clevel() instead?
> > >
> > > Good point, I'll drop this patch and use zstd_max_clevel() instead
> > > in v3.
> > >
> > > Since it's a runtime function and can't be used for static struct
> > > initialization, I plan to set backend_zstd's level_max to -1 as a
> > > sentinel value, and query the actual maximum in
> > > zcomp_validate_params():
> > >
> > >     s32 max = backend->level_max;
> > >     if (max < 0)
> > >         max = zstd_max_clevel();
> > >
> > > Do you think this approach is feasible?
> >
> > Hmm, no, that doesn't look good. zcomp should not include
> > zstd.h or any other libs directly.  Should params validation
> > be a per-backend callback then?
> 
> Good point, zcomp.c shouldn't include library headers.  A per-backend
> callback would be cleaner.
> 
> I'll add an optional validate_params to zcomp_ops: the zstd backend
> implements it using zstd_max_clevel() internally, while lzo/deflate
> and others just rely on the static caps check (no callback needed).
> zcomp.c stays free of any library headers.

I'm actually leaning towards validation in .setup_params() now.
It's not immediate but, first, it doesn't matter that much, we still
don't create zram with invalid params configuration and, second, it
sort of makes sense to do validation in .setup_params().  We already
started doing that for deflate winbits (a patch from earlier today).

Can you please add your validation to per-backend .setup_params()?
