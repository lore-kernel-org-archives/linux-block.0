Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D43932C6
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908936; cv=none; b=M01G0VIVauhrv6w19HlPAeR930aMHNerFRwl+kEyuugtdVHJ9dpbzFy8evZICyg0fgRkTQLvGJTmVdjuj2FWAtlOB551fhqJxGY6nMkT8xyRdKM3JcoJUanS8sJbm51GsMe68Afc/02OwN2d2jgwbwq3771Iu4PEt62hn9s7wfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908936; c=relaxed/simple;
	bh=CJLgODrfV2Cp1dGKQQzoBAn4r52V04Ohp6JVxo0/bF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/4s/9IWjluHih8enEFR1sseAvuzHIBaw72aqJZLAjvHsKs2gdnGwhc0sib4g3mJC5Y4wD5wgGpsVK/NjC7HqabM1VkjXOUoEppqCD2u0lN2EdVgRw64SY9tH2hM5OK3cCoghpc9jEFZb98eIN73z6PHp254rPwz6csh50KBb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L12MpWWM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L12MpWWM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e041ea211so890947a91.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787908934; x=1788513734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3lLlM8Ydp+ABqyPX6Fa3ap8cVbB1qq0q8Y2hRhjdpUI=;
        b=L12MpWWMOZUt09UoFHsRWKPAJTpqXfi6VfEyIe25WREFacR0HNk5S9rXfiTBspm97u
         WfCZVE1kOE2ATN+3YK+Ub0ReFnxlH7rq2h2FKn5ekq6D8MphHZrxWXRfJeQppyutAKSM
         B6bmvkIr5VYLOIcZZCRcDulbUAb/816d4xl50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908934; x=1788513734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lLlM8Ydp+ABqyPX6Fa3ap8cVbB1qq0q8Y2hRhjdpUI=;
        b=hEvmRr+ugfKSuU28+xG2lzeRIbsVAB1fMTa9qZGDxrh7+UbciN34aEl6hBZSw1h3lS
         c5V6Zb4uzIPP4ojW3Ng0nlE4PIP8gzRulmljIKSv0KEoiaInxmYgGBWdCG6fGiwy5ylL
         NNTmDGlisJDe8EQnaZGrTOTcyHu76/8kGr4RVAwmdm0XI7H+A0WDreuzjqQ2CH23OvoO
         0X1V3KzXfS6wGgkR+pzjy3HM14mE0F07A8uohGGhRQvRQeUt/n5+STkv6MlfkErlM7VF
         +jm0tSIreJuryAMWjKzdcnChZQNhVGM22XJhaD47VLCB28nE0hIcbFG/yIP1nbiqIfFr
         Gbjg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2RfGvFkD/EHmB8AOsiHj4UCctl9Fyfz2Q9W5p1+dPCDPT6DrG4py+QgnTXGufPhx3TfMyRYQLrRjYPg==@vger.kernel.org
X-Gm-Message-State: AFuF++l+VJWxTzlBmHprjw2cWSul4awQXxfeWpHK0xQiZ2LBTifEbZET
	byUBp1bFOAT3pD7fGYgfajlKzCmqxBx+IEMsGkumPF1dVy9NTOSMf8Fo4ubdovEqsw==
X-Gm-Gg: AR+sD10CYmHNwsMPoX+3GqCexNoNbvK7Gxz4VyZszuSkdugZqEDpv6RFU7l8Wu+WhUI
	TqkTjIK7cvQwBBIZem29fcj3XIT4k6z8CgQU2VPo7kq/Q7DmtX+vMZIzm1t1uBGNnO1seP3qTiI
	Annvknj+QbRt3Lqzo1c/r4xcOMMltRl+bi4YLWi/D0YSCOABIXzYJAn66EVwSYBaRW+uh7u91Jo
	WZ+RZ132KJFp6AYKopN5OBDe7Tydl8/zXFU27SpIhAm4Y0shDc5Ef1il/GIHjeeF7s8ATCaA740
	2Me8hpZ15K2QJ55vTgtBMP8fsS79iYrLA9w10prQzDNrGPk10k0j/LD5oiQuWpUto5qJnJHfNXC
	iI2JnEaRn3vF6HWqdfTl1aSxKCqpijxOZgzZkWFTUTzATtcO/IPFmL8tZUzWGv27dsZKZrB+pNj
	wN2Xj7fHpdsev7x8yKGVk0W5ETuxffKz0z4PRkSFIjbthaqTZcdm7/al54uG9YHwoLhGeCkovvK
	3YMly0ejrRtQm2tMGW9SVXwheRoZw==
X-Received: by 2002:a17:90a:da83:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-396d0e7cd03mr10652759a91.5.1787908933848;
        Fri, 28 Aug 2026 02:22:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a804:e404:4b31:580b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea808csm6454217a91.2.2026.08.28.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:22:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:22:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brian Geffon <bgeffon@google.com>, minchan@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apFS2a3lkskcZaag@google.com>
References: <20260825092316.69658-1-jiahao.kernel@gmail.com>
 <apEK-yRTQR8VdT3e@google.com>
 <apEkQSC5PLQAsrqj@google.com>
 <55c09f16-4b0d-58a8-9413-f88279ed69fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c09f16-4b0d-58a8-9413-f88279ed69fe@gmail.com>

On (26/08/28 16:38), Hao Jia wrote:
> On 2026/8/28 14:02, Sergey Senozhatsky wrote:
> > On (26/08/28 13:23), Sergey Senozhatsky wrote:
> > > On (26/08/25 17:23), Hao Jia wrote:
> > > > After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> > > > idle_store() computes the idle cutoff as follows:
> > > > 
> > > > 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> > > > 
> > > > Because the left operand is cast to a 32-bit unsigned integer, when
> > > > age_sec exceeds the current uptime, the subtraction wraps modulo 2^32
> > > > and the huge result is zero-extended into the s64 cutoff.  mark_idle()
> > > > subsequently marks every entry as idle instead of matching nothing,
> > > > breaking the intended semantics of /sys/block/zramX/idle.  For instance,
> > > > running echo 86400 > idle on a machine up for only two minutes causes
> > > > all newly written pages to be marked as idle and handed over to idle
> > > > writeback and recompression.
> > > > 
> > > > Drop the explicit cast to perform the subtraction in signed arithmetic
> > > > again, restoring the previous behavior: an age_sec greater than uptime
> > > > yields a negative cutoff, and one equal to uptime yields 0. Since a
> > > > cutoff of 0 is now a valid computed value, it can no longer double as
> > > > the "all" sentinel. Switch to KTIME_MIN instead, which no ac_time can
> > > > be after.
> > > 
> > > Can we instead just reject such cases?   It should be an error to
> > > request writeback of pages that are 2y old on a system that has
> > > uptime of 2d.
> > > 
> > > Maybe something like this:
> > > 
> > > +             time64_t uptime;
> > > 
> > > -             if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
> > > -                 !kstrtouint(buf, 0, &age_sec))
> > > -                     cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
> > > -                                        age_sec);
> > > -             else
> > > +             if (!IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) ||
> > > +                 kstrtouint(buf, 0, &age_sec))
> > >                        return -EINVAL;
> > > +
> > > +             /* No slot can be older than the system uptime */
> > > +             uptime = ktime_get_boottime_seconds();
> > > +             if (age_sec >= uptime)
> > > +                     return -ERANGE;
> > 
> > Or perhaps, instead "return len" and make it a fast path out, w/o the
> > need to iterate any slots, take locks, etc.
> 
> Thanks for the feedback! I've sent out v2 of the patch. Please take a look
> when you get a chance.
> 
> https://lore.kernel.org/all/20260828083149.45760-1-jiahao.kernel@gmail.com

Thanks, looks good.
