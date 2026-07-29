Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F526ED4F
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298984; cv=none; b=HOwzCCjoKoZtIxJocmiVVvvAMFv+ALH5puXEmHaOhFPrqwWSbE0FXDcaN4lkrl4mReEHiSuXU62TAM4cIxwYHKJe0KAlzlkvh2fuKbrEzphCS1V/70Uh7MflOCqmwe9J4KsnQW22x4blOWx3uJOdDjD1iZNDwSSJCaQ0zRwR7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298984; c=relaxed/simple;
	bh=PLTR4EXpxcF2cWVOgYXJ6zBxJeCnM5K6x5xa2NAh9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5RKM3z+LnOb7z3kLPnvD25SeCG4i1GHAlTxFiJFn1vatIKu8gwUZ5YILx1z1dGAuFoQBBiRKBSD9w4ngzFZwjA47oy97kUTpCRL+qaWxsXno40vZ1mgwoIFH6/XBGIjb+iiaMiELSKl4HANo7RP5o3NZD1hVxc998uLuHolqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j3MyIfVH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3MyIfVH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383cb94f742so583069a91.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785298982; x=1785903782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98kWooReTYS/Hw3LVutl5nhi/UI1GUChmjWWNJfzP20=;
        b=j3MyIfVH/EwsDZzJwcQOpCCdLVICVc0olj3O7CeRgmSJjsCsgT9c1Y9r93VIf1V0qE
         NRK7JwVi0ZfL2V5fmoKhjHtrUGWExVb6/OilsLsp1eTZqykAQ6m5lRCMjaN81g0qz0QY
         s7qhq3kqbwlUMUevVFxE6EnT4gU4ejA+KnfDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298982; x=1785903782;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98kWooReTYS/Hw3LVutl5nhi/UI1GUChmjWWNJfzP20=;
        b=P2AXzy98tdL5jSn6tvbh8OXLQpAjxOWQ6WPLXYGRCBEFtEMFePxJ9kmZakWG1aO0Ge
         kTGfz0wog1dD5/8SNeJ+unvz/y5IukaowiechY6RvbPnlqpwKreW2A7g6n+61gMNdeCJ
         WqtK9rqeHBqYRG0f68ag1HXfwARkD5vKnA7PzXdmRFhQVJByjrwbQFXEiRkwUlP73azS
         BI04fKOYAXtMJCI9oJy+XdgtCl5pa4WApQQN1qr8kq5JKIDUEGO37XINyy4UoPU1qbi8
         fySqOZYjqP/FGBZ1N5ULyqm6+gPJhHv0pVu2G0tjT8GsSmIVZbjx4MYvPTAOrCuJ8Al2
         dCBg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/OFAPKh7B0hRD7L0t1eOxfymaqk8rURLL1PqnvB8yx3ybvrDi3sLjCvG7esfD92dkXGnsxeSRB/lOrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8XR5XCDNJQOBhOLkM6ccXkcqnMrluw6SLFonToGFqgb+TKBc
	tW9N18+xNh4sSaQAAP2nFegu3ZdSQfqjRx/HWuWsgLbN129hiGj+NqCMa2mYCmfIkqnmdDg2V14
	jtsY=
X-Gm-Gg: AR+sD13RL8ewTX3bBnYG2UcGSmryS+13G756KM4jvJVy3ggH8eJ3s4sB2cWPM9Cd6si
	NJArPtCJhzO+swizUh3oojVFpZ2ZU9nb1qbiGqmoXh6CpyahQKTQezJKZ/iBMS1eia90foeKcTi
	F2l5w+VFtl3v4XlsXmyhyLkMGRclJM59m2dfs7Rbu9X+cimoH7fCb7jRO11zL9uazFFbNGDltqT
	LOIIEBbMY+RDUT6yl5LLg1kzjrcGaUvgePV8E4YdAa2THTDCo0G0nof6cXaOWOVpxw4et8uCGow
	sA4QAMkZFpXCEOrXCLQQojEewrFF0ll7+fMsHf+mz+3JJCvYYwIitTRTiuVYWq9YjxYKdCZ39Ac
	XuqK8z8iAGFxH7T0oe86CkvGY9PWnvquQgFpGXp1GN7zffFHrA9vd5kKeXOC6xNA6qFNOAIRWLK
	wjWbfFWYM9fHnOCLu6AMrmfD4pdLtpd+L6V1m0r0yMOEkVv9CcEjrWgqhnVziUUfLbs5isX3kR8
	PRyAwvxexxTIGVM1lGwfUKoyvcN2gXL+SMbYEE=
X-Received: by 2002:a17:90b:4c42:b0:38e:a555:8fc3 with SMTP id 98e67ed59e1d1-38f6a484cf7mr5395408a91.41.1785298982331;
        Tue, 28 Jul 2026 21:23:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f0ed140sm723275a91.1.2026.07.28.21.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:23:01 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:22:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
Message-ID: <aml_aEB6BDBqgIRH@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-3-haoqinhuang7@gmail.com>
 <amltU9PgLGZYCD-1@google.com>
 <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>

On (26/07/29 12:16), haoqin huang wrote:
> > On (26/07/28 17:29), Haoqin Huang wrote:
> > [..]
> > >  #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other strategies are limited to 6 */
> > >  #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster strategies are limited to 4 */
> > > +#define ZSTD_MAX_CLEVEL              22
> > >  #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
> > >  #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constant to an unsigned results in a tautological test */
> > >  #define ZSTD_STRATEGY_MIN        ZSTD_fast
> > > diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
> > > index 6ab8be6532ef..06565e064456 100644
> > > --- a/lib/zstd/compress/clevels.h
> > > +++ b/lib/zstd/compress/clevels.h
> > > @@ -17,8 +17,6 @@
> > >
> > >  /*-=====  Pre-defined compression levels  =====-*/
> > >
> > > -#define ZSTD_MAX_CLEVEL     22
> > > -
> > >  __attribute__((__unused__))
> >
> > Sashiko made a good point.  Can we use zstd_max_clevel() instead?
> 
> Good point, I'll drop this patch and use zstd_max_clevel() instead
> in v3.
> 
> Since it's a runtime function and can't be used for static struct
> initialization, I plan to set backend_zstd's level_max to -1 as a
> sentinel value, and query the actual maximum in
> zcomp_validate_params():
> 
>     s32 max = backend->level_max;
>     if (max < 0)
>         max = zstd_max_clevel();
> 
> Do you think this approach is feasible?

Hmm, no, that doesn't look good. zcomp should not include
zstd.h or any other libs directly.  Should params validation
be a per-backend callback then?
