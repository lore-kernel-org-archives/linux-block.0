Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7453E51F7
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832100; cv=none; b=NHGQuO5NBnBMOgucikepBhpPW/bxDRkE9VNLcWVXWknw078HtkXgj0mC0Lume67dU60J5QTWQOW4Tdj2kQlyZWxSMlWoVZRjA1UQvQvYwRxgRXFHszReHcW/ISNOibn4B7YSISys1/YI7lB0ZPUcFYauTLK6fyUw341VzRqrdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832100; c=relaxed/simple;
	bh=nF4NvLVoQBbGm+ZFEUOPls1LdJRIauzpamd6js2UHA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwAolvod8BfmYaHgB3EejuuGB8XVhNbXy/Fa1v4PPqIfZWyVlQOqnWyF84TkV1eoOrZIQwSaEBMkaYdk5oZEr9Vp6oeP0wYhUitttFyPo/i7q/6Mnc+xfNIjO5TFeAm+zBh3S8RZP20sQuyueSqdnrFziMYKFlDX0qKEQe9m6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RrJm+iso; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrJm+iso"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso4825560b3a.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832098; x=1786436898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPrQPRocwwjsS1Bxc2vb0MbVfLzDa+jZnRkoUPiZQAs=;
        b=RrJm+isosDIETVrV7+jlnJ9de8Ro4k0cDD6+vNTp6DBT3SnX9aGttPxs5CRAMwWaTr
         mllq/kWy2xwIKhHyHU7mZyU3oR2nUEUihGrnOUSAK4nDIcJBfDt+tcH6kIKXj3nLBlNE
         5lvuE24HyN4i5diulIEXEWYvF0Pv31He8Qd6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832098; x=1786436898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPrQPRocwwjsS1Bxc2vb0MbVfLzDa+jZnRkoUPiZQAs=;
        b=X7zi0RdQjYED7kFycn5Yf4UxCFiEfBICHLWHND7xKJMCnTfII2qQrG/yLnb07hHMQK
         u6LnwvLRX6uBJVsC/PayqK8sBd8g4HgxXSHMUbAujWAQ3hE74EvrLGDqc73sFTV5zZlk
         QgogIX2/qpwG4zDACYDXheD2z+OXnb5T2XUadm8JcnQlc/1TTiNK8OdXwWKztLtVGEKy
         OPWs12obfGKxWdecvBMtVW4rIJUtJWPJcCG0ucMTsGv8kfxhszqiOovp/g8+24ZFPen3
         Th1B2xHWhmALBe6ISvLzGkGAlrFYl9w2qK2U96NJRGe+3HGlcrE25RSYURZ+FwH0/pcp
         z76A==
X-Forwarded-Encrypted: i=1; AHgh+RqJBMMIkUuD36HnNCsX0MDxNTfGIFHTIFG8KyWZHYFZcJptYZl69u3hj4/SyVWMz9S5OI1Pb/vlb8UMRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbbXTt/beDdZZ7Ojy8QPuJVwS99IOfhSxHW9/cI7T2m5gCxn4
	AQx6eJJqLTZe1EjDqu6RlzTeXMH0EeEoFcWNRgIB9+7hu9PjSwGR3IYHqUXEV7CgqA==
X-Gm-Gg: AR+sD13HvqtisbWq///0qwEC5omvZ8Wxdjlu5FWpcQOj2u9akvIhiUMGJdcEBcdxwhh
	aPF2R3/Q8Vu6s/5JpJZ2xIIVIfZVuGoTsF6LhmFUx2m3mzcD3BBcZbm/OK2CdQ7KLkVkJTuErQz
	B+dZnwF9ytW7VN/bhHxFLtEGXmGo3pRBG9ouqQ+GUzoiaP1Kudp5z/T9NwaKrCKjhi7W5VvxcB/
	6NkD2obZ6HxECF6x8LeL6pyng9XcrR+Si9aFCLrmRFDdsCeFvL4zREZsvv8wEuK91hsxE2Ba8TQ
	fz/9A5bPgu8h6ghMTsANF51F9n3Rua0/yVd5+EITdyq6ps0OOf3rmGmgO7c8jQTWxbwNQCg0Rpi
	jG4WFOHb0mLYo3WaimR6iJGo2b8C+wI2NEnQnKE0aPIumwWi5wCne6MahRiOSmd2nOQhcu2pJLc
	Y/DSQU84OPUHsM6mNSM5+sGdBfdGKvFzyJKe/enp6HJIpr5QuImWIJGG3ezkNBvbMGDL9r1afhl
	KRasU6BHjs4HPOz6R3o2EqKE/CvivGhJQjJDmg=
X-Received: by 2002:a05:6a00:4fca:b0:84c:4bf4:10c3 with SMTP id d2e1a72fcca58-84ee490ac3bmr11205167b3a.38.1785832097849;
        Tue, 04 Aug 2026 01:28:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc51cc95sm4847726b3a.60.2026.08.04.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:28:17 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:28:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anGiZM7hFRnzeO1B@google.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-4-haoqinhuang7@gmail.com>
 <anF8tcbifysw7v9_@google.com>
 <CAEjiKSn3q55VrsB3mufdA5q+MUUdrJQuSevqo3f_-3gEK=NLCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjiKSn3q55VrsB3mufdA5q+MUUdrJQuSevqo3f_-3gEK=NLCQ@mail.gmail.com>

On (26/08/04 15:13), haoqin huang wrote:
> > On (26/08/03 22:12), Haoqin Huang wrote:
> > [..]
> > >  static int setup_params_842(struct zcomp_params *params)
> > >  {
> > > +     if (params->dict_sz) {
> > > +             pr_err("842: dictionary is not supported\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +     if (params->level != ZCOMP_PARAM_NOT_SET) {
> > > +             pr_err("842: compression level is not supported\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > >       return 0;
> > >  }
> > [..]
> > >  static int deflate_setup_params(struct zcomp_params *params)
> > >  {
> > > +     if (params->dict_sz) {
> > > +             pr_err("deflate: dictionary is not supported\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > >       if (params->level == ZCOMP_PARAM_NOT_SET)
> > >               params->level = Z_DEFAULT_COMPRESSION;
> > > +     else if (params->level < Z_DEFAULT_COMPRESSION ||
> > > +              params->level > Z_BEST_COMPRESSION) {
> > > +             pr_err("deflate: invalid compression level %d\n", params->level);
> > > +             return -EINVAL;
> > > +     }
> >
> > This is purely optional, if you add per-backend pr_fmt() with backend
> > name e.g. "zstd:","lz4:" and so on (in a separate patch) then you don't
> > need to explicitly prefix every pr_err().
> 
> I considered adding pr_fmt, but the existing winbits message already
> has "deflate" inline:
> 
>     pr_err("invalid deflate winbits: %d\n", wb);

Feel free to remove it, if you add per-backend pr_fmt().

> which would become "deflate: invalid deflate winbits:" and look redundant.
> I can add pr_fmt in a separate patch and clean that up to just
> "invalid winbits %d" at the same time though, if you prefer.

Sounds good.
