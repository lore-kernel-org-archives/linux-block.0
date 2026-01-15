Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B56277CA4
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446113; cv=none; b=uFwhDXDNJRBpcF6U9+IDNZtZSWH3z1ptWHMjXeUB77wE7hPDjApmJo0qpwdIVBG+49H8w5U5tjChIB5m8ApVkCgSqC0jCyLVx9UBqkLSUUH6uF3P2W+qIrKHeIGOVRpcJKWoLs0fl4hQvlaJsfEYa77SEjGw2xSVj2MRRs8QSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446113; c=relaxed/simple;
	bh=9Nl/Ia+i50raehXZ5jGaesfZCxSHLzwiDuNcQbi0L9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aodxPUX7XFYXoW2bZ9JPXvkR3yNdDjmbm0bV9sQ2Pq9KyQZXd5AH1KrwNvuIwh0alnSJxq7wSPMot9Hnv/JId+gnF/yCoSIV9g3S06amJ3ujdx2FcoyiXHouAK7xduG9nGECUOf4OWWep59eeZYp0mkCLU45ZiJPfP8rvSHqkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F4ZQAuVx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4ZQAuVx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07fac8aa1so3592525ad.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768446112; x=1769050912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0+ZcOVv4sxcyS2yzBUTaRcfAN/zT7QcdgRC28NNhvU=;
        b=F4ZQAuVxoy1Qw/jF862sLiDq1ChSSvWeD1QCvnlOsvITEgGfGiCyKcBeUKmQ0Q6OM5
         XlJT6t4hr3TPeDcGza8e5XxZBayY1s/BDWwSq1l0VypXT0rv4FKaT+2U0iEljq//fFfo
         3suI97qZYu8++2wwdkpjPboa6uxVaB2L+KlhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768446112; x=1769050912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0+ZcOVv4sxcyS2yzBUTaRcfAN/zT7QcdgRC28NNhvU=;
        b=l03CkZLhrIg6Usi3uncytBnQKGDc/v56vIdh0RorFqPcfy0RqxEokenJqCa4iHjqtX
         q0Sh8+QvmSfsCiyxyeDuKUUS+6zH5XZTKYrtKRazlDhj8GGPOjYDTKBwHIFOEZMe1Gpt
         hAqf1KH/+u5YZBtEw3t+vDSCqMWNsDHZzGOkvIihNCf2w5AdTKGIuVgNuPBYq0ALUTAB
         EdAyoKmhDXbdsJGYbcSQm9WZoci+3fKA06/3pgFP1D9VeF7u9B1zIIhgAVXNCDCAy1N9
         MlBL1OVSgAif8tCOfiVHV0c5I7k5SK0FfeixwXf86PejaW8tnnwZwnQoSTSt4pQR+A/1
         v0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUV4YfWF01YH8kR0HzwJBnNNqFFDrWaoApicv1M0Vv7Ali7fMQ9hML1aGZhEbqs/YfCOFeup9drsr+2uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnGtC1G1MvQcQMpVnIsIxoG/XRQSpCW1yBkcA5OdBuGpGV0p3
	mkPWwaNIZS/fDhzhPgGTeIj+fz5cU/W5IOKrL3wj7mOu1W504a18wGkMKneKgV+FsQ==
X-Gm-Gg: AY/fxX5ZGSk88giLVHoPkh5xHfVgWaJ2aLVqus1M4zTBXByM6RHfmKXHbr/ssi7VLmA
	2I1tpcHP2afTyxZgxLvaqG9gtt0UiL4UeJFYX22ON3ReYjBOJN0uYmilCTXtvQ4o/mDvqzGaw5y
	cTBJMdjuPyBbJv/EHgnQ3NZwFLmwXaoS6FMAlvGQDzap0WDB7Xewm42yu6IWMX1G0G7Fsaj3hh6
	Gbcqw9kpFfzpZhYVmjXSk20YqIiJEbDPSiLRvoi2qRDm7ZEAs08FvSBqcljGBgyX8s1qhGqk40l
	uSFpNjelREIS3LbJwg7fv81LD/9qjEdigbVmOWKpKYJlSN1mv8TGzUmb4Mv4YyoCMYIHtdb6pv5
	Iuvg3xwetuPAX2H3XfbDTLNNWWT/O0hZjfzQiTP1S7hQ5HRmM+NU5hE/Cawv5I4B2TsBuDNsNNZ
	AyhyeZxQAFXTIfTM6T2gZrb8mYSJz3gFnsybkAKus6cCc1/sKizo4=
X-Received: by 2002:a17:903:1111:b0:2a0:afeb:fbb6 with SMTP id d9443c01a7336-2a599ded0cdmr38869975ad.8.1768446111985;
        Wed, 14 Jan 2026 19:01:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:36c2:991a:5236:1fe5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48e8esm125169495ad.37.2026.01.14.19.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 19:01:51 -0800 (PST)
Date: Thu, 15 Jan 2026 12:01:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chris Mason <clm@meta.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] zram: rename internal slot API
Message-ID: <z6qsrmojsh5rcrlv2dggbjgyb5q5qmdgrafeq4zknpfwdrlaf6@zkcqyzrwpiro>
References: <775a0b1a0ace5caf1f05965d8bc637c1192820fa.1765775954.git.senozhatsky@chromium.org>
 <20260114123658.1231407-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114123658.1231407-1-clm@meta.com>

On (26/01/14 04:36), Chris Mason wrote:
> > +static void mark_slot_accessed(struct zram *zram, u32 index)
> > +{
> > +	clear_slot_flag(zram, index, ZRAM_IDLE);
> > +	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
> > +#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> > +	zram->table[index].attr.ac_time = ktime_get_boottime();

Hmm, this should have not happened.  Thanks for catching this.
Let me take a look.
