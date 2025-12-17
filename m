Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCE2C1786
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000088; cv=none; b=YXxjGVAryg2xDIshufOtv/XNoT+BnZ2Xj+mVA+ZZS14c8NSsyJf/o00zX2SWQed8ZoWL4bWtJaAEVbLnD1y+2HjH8YAIHPlen+DME7DB4k7FRDXJd2ySUddWc8l5mo551eG5W7vbrOrK9ZnS/P8MnjWloXoi/JVJWDx7ALqHLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000088; c=relaxed/simple;
	bh=pW5XY+qz4bHWcxpu7dF3nTUnwroHaZVnAaaN4lQnnSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4fi6CBJYD5GIHMexbvdH7GeudTGeDT6DJe/0rDgzM5sF0zIxCak4gtSxHMbJQCsCGGaz7jyqgPstETYDHCbaFoaIsMU9sGNWxfdLnAKUlzsfb0uII2Z1MRM5VxvdGiuIYdRfOu0zhHt6hRRtWD4la4i70d7mzFB8ztHoxuHrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNuJpRVq; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNuJpRVq"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2940351f8f.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 11:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766000084; x=1766604884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Dox/IjhxlL5l7CCk2qZ8fasiOHF/NJHXR/kudrHvQ=;
        b=KNuJpRVqaybGsDZPiPBK5js9Xvey+xSXHdC/UG5/hL77yDj4cJp5iTGjw6MGDW7rYz
         UA2Jtmbtrq5JycAebSgffVN5tTTr/yYTIoUvdwOGOJskAKnSTIPSZgHIHrZq580WVhD3
         Q/WTbdudy5zojxgMq0K3BndrchYFrrI1DddHnoM34/ejV78wY694jDQac19aGNQDGmRs
         0gAl9ciQirgeNTfHIRE4e5WD0b2SRQzehzwQB1tXTTw7YSNnse0rcxsBPCVJHEdIuo2Z
         RLj/RMt8oZYN6pnPR0ZJQc1sIvm6e+3lkJ+5MdMdl0EikLtpHSLKR58jNXLRPfmIKV+2
         YxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766000084; x=1766604884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5Dox/IjhxlL5l7CCk2qZ8fasiOHF/NJHXR/kudrHvQ=;
        b=UK61rRrYJHdUTKOd1Wb77YjgPlAqjGw6mCa4N6ThZX06buoiWT/zgSNRYLBM4fpCMR
         m+g0NIGQLzftISJcoj7uvZ4gHX/DIApjbN2FPtl1sRJxP2dieV4zZAkmfjd5xdGyu3Yc
         VxciqN9LvI5viODaPTEySJrAVIxIxT44bab8FTAUQwlwtMCDbHxD3epHYr6vzTO0S35F
         Ode7pJvayyXOsB0hmA51E/J2qeDxi3uJ1lb6kSvynHbBqG+Y0v4d3UErYSQ1899rX8ld
         xAFy9kxbaKn+lrIJ6XKJG1ets2bRcbfTdnlueBgSiDDPJDlRn5Xt8SOVYrhj6LZxrAHW
         J71w==
X-Forwarded-Encrypted: i=1; AJvYcCXB+2AbMREZws4OscJAW97nr9mz2VjYhdZAVKG8yea+KDbeChFG1GBxqqdYkZVrVmG5lIKBh621hL3fXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmiG6qSPJpa5fQQfLSiLVdFTrA2OMBAnnTN0nZ/XpBfOoWr5Xg
	kONHTLc3zbbAPJXy5mATG8AThf1FZUiUnt7Twbaz8GcUGDXtrENGTKznYkXSNoMgXw0=
X-Gm-Gg: AY/fxX6zfDpVHEilOuMCGSe2ttBX3TTClBGYL1sWGulljk1S7UN/6w5IKeyiZ7Vu3Uo
	Q1tPshv/pWDR2F0zMuWtCLd1BOf2SmH7LMwbrQKntzHH48EY9gq28/P207+DJu3cvcCHyxUMSAV
	ciHuv9gHL0Gsrqv8HMjGHhekv/WWCCD5HdvQ3g/2/s34sP/jfq4wo8a6Zmw5U7vgIKYqYLAZaBZ
	8CAYR5Clbq2p4kK9O59cPuJ185g0XtI7Jzpi44e6ZskKPMsScebO7yjqY+zmn8Mgcw+sAaWsXxm
	nHKwfKfDtoKthnVGuVHu8oyNk2phkgfkmKdS1TszQPWirTwH2lxaVclhSUOUqpmJuiMnlAK2tbm
	hhutlIrd6llxfwTNjKRh8TgeI95/aNIFDTkOiHBohxI+9+/kETkpotCvaoJINN01kJBnpeUl/F1
	Q0cqpD7pJIhTzuqyVnzfeBh42X
X-Google-Smtp-Source: AGHT+IGjdgNTy6ao/8/rTdokdqhsyqjO1onI/y/VT9z4i621T9Q6cGxvoTUWH6j/q9xfqIewkjNhOA==
X-Received: by 2002:a05:6000:4287:b0:430:fdfc:7dde with SMTP id ffacd0b85a97d-430fdfc810fmr11095010f8f.36.1766000084277;
        Wed, 17 Dec 2025 11:34:44 -0800 (PST)
Received: from localhost (109-81-92-149.rct.o2.cz. [109.81.92.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449346c9sm641020f8f.5.2025.12.17.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:34:43 -0800 (PST)
Date: Wed, 17 Dec 2025 20:34:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <aUMF0jVexy08S14T@tiehlicka>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
 <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216185201.GH905277@cmpxchg.org>

On Tue 16-12-25 13:52:01, Johannes Weiner wrote:
> On Mon, Dec 15, 2025 at 11:41:07PM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 15, 2025 at 03:08:38PM -0500, Johannes Weiner wrote:
> > > Debated whether to add some sort of deprecation sysctl handler, but at
> > > least systemd-sysctl just prints a warning and still applies other
> > > settings from the same config file.
> > 
> > In general dropping sysctl will break things.  So I think we'll need
> > a stub, at which point it might as well warn for a while.
> 
> Fair enough, I added that.
> 
> Jens, that change seemed small enough that I carried your Ack, but
> please let me know if you feel otherwise ;)
> 
> > > Laptop mode was introduced to save battery, by delaying and
> > > consolidating writes and maximize the time rotating hard drives
> > > wouldn't have to spin. Needless to say, this is a scenario of the
> > > (in)glorious past.
> > 
> > Maybe expand on this a bit by mentioning that reclaim now never does
> > file system writeback, and fs writeback is already very lumpy by
> > design.  And of cours that hard disk with their high spinup latency
> > and extra power draw are a thing of the past in laptops or other mobile
> > devices.
> 
> Sounds good. Can you take a look at the new version below?
> 
> Andrew, absent any further objections, would you be able to take this
> through the -mm tree?
> 
> Thanks!
> 
> >From 087f10b8046864f71ebc3a3f3316b097932cbded Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 15 Dec 2025 12:57:53 -0500
> Subject: [PATCH] mm/block/fs: remove laptop_mode
> 
> Laptop mode was introduced to save battery, by delaying and
> consolidating writes and thereby maximize the time rotating hard
> drives wouldn't have to spin.
> 
> Luckily, rotating hard drives, with their high spin-up times and power
> draw, are a thing of the past for battery-powered devices. Reclaim has
> also since changed to not write single filesystem pages anymore, and
> regular filesystem writeback is lumpy by design.
> 
> The juice doesn't appear worth the squeeze anymore. The footprint of
> the feature is small, but nevertheless it's a complicating factor in
> mm, block, filesystems. Developers don't think about it, and it likely
> hasn't been tested with new reclaim and writeback changes in years.
> 
> Let's sunset it. Keep the sysctl with a deprecation warning around for
> a few more cycles, but remove all functionality behind it.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Message-ID: <aT-xv1BNYabnZB_n@infradead.org>
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
