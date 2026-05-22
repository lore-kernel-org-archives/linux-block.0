Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9416132A
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423146; cv=none; b=MNDyYYAM1ezSqfyi6FxDRyuDyZNCOEnvMbYQkPaybNjf/T7bXwM99qcabs90aisUV2RbId78JF/Y1sr1NkS+rMSTnmiviAZyJHZAETu93Tg0ah33FzuOxNTAUbkMa4nmcIGjzgmQnNf9LW6Me4DxLqVuoXfHFW7Ia5A6ACQLzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423146; c=relaxed/simple;
	bh=Nhc1BnjpBSRSBpTsCCT6VXPe5npryGmY7ZYo95gy2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPKt174M1cYUtZbCswHjPN0SknYcvBOyxvRK9aHI4mw1fkijsfzRdMCDpSBlnips9/5G7EaFHbz8FidwphjstaDrkzGM0hbzL4rhohUkKj4eR2OTtWX53f0wVOBbfogapObUMdDOWOQzFjdGF9T/6AxZZ0WIwyh7JiwnbTlsBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXXbZgXL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXXbZgXL"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9102e90bcbeso751649885a.1
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 21:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779423144; x=1780027944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/S6RZX/KL6TSmEDJPw6DIQgfIslrg3igSrhqiRfjKk=;
        b=CXXbZgXL28ZsnLLt4DAPwd4ELn20j0KmHnBPNHJzX/a/O4enRPb3PRXGgIBDoXIjC3
         Zp9gC8vPk7r48Plf2JhhdPqGeQGaGWAXKfh4uEnm0Go/tmSLieXOBCE+u4rCOQYoP7iX
         WzZfxI7CmREJhIcPEBjWQUfdbzL0+rNa7q8ip37inzXwDD0IPmDcH4aMLem38+v+StEk
         NZYdOy+8U8lH80th51kjIEdgwefngBJxd8A56okQvlmNilBOxSOIYzau5nx+3bR2XYdW
         MGeYYXCmVFn1QaDoGBEHgBv4Yr7p/hpLIRQYs3t1ZjMbp4K7F7nquuQJKgcD3otUgRhY
         y78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779423144; x=1780027944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/S6RZX/KL6TSmEDJPw6DIQgfIslrg3igSrhqiRfjKk=;
        b=YxkSz2RFk42tESIz+OU5H33WgFw3FCH2fY1CZW2RHO48pjVOVK9joJ0Z/jTy4mpTy1
         OlDy84jLolira+zksCGidyollggnCh9snT9Q5Y9butqWyB6OH+9esEf5Uysf32Oehl2G
         39CViKthjMKgsyNSpPvDbOiW4E1vPbXkQ36jxb1BwOrLo42hVw7gPVtI/XRomGSzoVcl
         gRKrHcYMQ5fg3mkyr8SOCPwUSBfLPhYM2ufZq9DB3kgBhfAiYNs2J5fyqG+nYA1CLD+J
         QCmRoIuXOvildrY2vrdzLFiKQiph4GRtjLtA+hyNujAlAs4jXc60uKCT16eBn3aAQPOh
         Apjw==
X-Forwarded-Encrypted: i=1; AFNElJ9bqQxj5y8xxmV6/hDbcgnYsDDrI5CeE66lB4dSdOgdTyFFpVqhx2mMQ8FQ2oJHsyZeM/HQ+SauWGQyXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvROAkNWf9Z6EhjW+hoGnD31HBOd1gnstmGBw5WmDoOjb1uCbR
	cr5Co9ctcy3reYzXy8em0WyDc8zz0bE84bTWVDgdtG36ZlMFZwgJ8XKmdMRPq/WL
X-Gm-Gg: Acq92OG191OrRyF1JbIWPb8Bcd4hh857CQLJelQocxAWFOX5mRxCMA06PYWwVteGBkK
	Q50XDg95UX/m3f4H/AopzZVKO+0tka39u9zrFVBVaxnFqrhBSEMdGPdYIcFhBV1ip/HYk6hD6gG
	TVfaKKVFYqH42ZJ6NTx2oQlBUywhT/FIXYNtHq7gvxsZ648fuR/MWFhk8kflSwXzGCsc6LNKj1H
	hDMaHkgziLNnPa+FnhZsP3vd4l4OgmJuBVlQkvonQWwj+h6ufSDYUQEUMgU24LupUDUscwN2ABy
	1WF3Q6wUSSKa1mcGfIFI2/yFI2J+Ezmyl/Sq0UXvTLAmf2Lk51dnHTLyNJBjSbQGrWNb9lutauS
	GrdgJSF+KsXij2aV0j1+57WySCaWh4xCl4wRiL7DE4BlEiBy54whRCZEi0M+cc8uQsUOf5fmOeb
	CVhvbROgtAIQlQuoHR97cTnvfQqws0eux7yIQ+5HMHq7b2UcXEeUkEe1cT/mtBn1n0feXfpWWWK
	HM6Nky/FNAuTHZjnskq
X-Received: by 2002:a05:620a:2a0f:b0:914:b012:fc91 with SMTP id af79cd13be357-914b48fb940mr337372885a.4.1779423144396;
        Thu, 21 May 2026 21:12:24 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d6b1dsm7875785a.26.2026.05.21.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:12:23 -0700 (PDT)
Date: Fri, 22 May 2026 12:12:18 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ag_XoloTHEgt3Y8s@fedora>
References: <20260521190253.242065-1-kbusch@meta.com>
 <ag-WUymW2vwVyMJB@fedora>
 <ag-1EoopSdp0JZR5@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag-1EoopSdp0JZR5@kbusch-mbp>

On Thu, May 21, 2026 at 07:44:50PM -0600, Keith Busch wrote:
> On Fri, May 22, 2026 at 07:33:39AM +0800, Ming Lei wrote:
> > 
> > BTW, as mentioned in v2, the request may be added back in case of merge,
> > but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
> > in batch.
> 
> We could introduce a special goto label for the merge case to push it

It can be done simply by replacing the added `blk_mq_free_request` with moving
it back to plug list.

> back to the cached requests, but it's not clear that it's worth it. The
> cached requests are preallocated to match what is about to be dispatched
> (up to a limit), so if a merge happens, there may not be another
> subsequent bio submissions to use it, so it would just get freed as an
> unused request later anyway. And if we block on the split bio allocation
> such that it frees the cached rq list, I think we've already lost the
> optimization battle, so no need to complicate things.

I mean plain sequential IO workload, in which batch allocation is taken, and
just the 1st request is used, all others are freed one by one, which may
be improved to batch release too in theory.


Thanks,
Ming
