Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70301A00F0
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005818; cv=none; b=HAeT0kyVtjhAVaGPeMPIL2yPYSUsKMfqjNqj+9pbo0chjmdez5yfEquWa3pR12Jt4eF/cSa8Qu9OdsSyjnRwPcfPLqYxGkan7z4mUsRX8ScALpgAXkXfodUzq8M/eGWY7g2e6h1t3k5xLWG0gu4C9Hi6xNH/wTJSo+0rOJ6JJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005818; c=relaxed/simple;
	bh=8b72W4EX1oGh4aAqhJFdf7rlfU54Kqa1uD89rMusV2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKT3ZNWkIkGG8IWgxQ5bJRO5psXrAKYYE1CLTOhQBGwg9MFJfPsjmk9u6tUx8YND29rr+PrI6VNyPQblSIHWqsE51tZzDQ/k+KVLX10p0o+dGnbBtZO/Cl/ewPE3/fo62Zl/1iJwOGg3nVHL4/bgX8StIkiT+2kFtl6UVKXRC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BSOl/zvv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSOl/zvv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2532431a12.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775005816; x=1775610616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0n+PXr9OzThVuja6Hb1iu9lamcpcjJRqduJBuh1qgM=;
        b=BSOl/zvvJWdqlBzH6tCpYPSMytwAcz2j5idp44O2+77/Mz1fV3j+qwtR2z0n41IZQd
         3dKWnjYc4g8xn0uMZ9On8Seo5n9151HYXebkUh2DRhI//MocGS9ScxvTLuNFKFTQyG+L
         CHf+remf1i81A8+Sd0P8TrWmWK+lJjGFAgcqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775005816; x=1775610616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0n+PXr9OzThVuja6Hb1iu9lamcpcjJRqduJBuh1qgM=;
        b=k6O/yR3NM2UZTTTAg13k7vnIm6Ql45pk4//nxScJR8U8TrsoQP+eAvRiba1p9L1Tdy
         3XbJbykPOhOzRjFPqhpb7+qzxjgVY9b9z5o01PJlU4WMwDxC971i2Jwg0p0ojo0TG/Rt
         QsgSY8CP5YHGqBDN3u4vPG1A/9xPAgPzJ9eelgRrBGipeosL/bLRVB+ztnS8Or8F25+e
         xgpK8twejzjNjl0KCHXFhRWcuWdRg3KhJPGLRhqKI5xx8dUlCJAsSS2q9bZX3IC99y0v
         VvzfJUwh4B3BEFKIxPd1ROAExHNKb+zS6yWTWUOVe2tv3pOXwUEpGLfW4/M1MGELWFle
         unLA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Fgh8IW0/abHIjTnXEWs58Oi1UcL7KWciIvjaxl/16VOJNFGE5H21/icj/+0eye4fmjhbLPAxgRDQ2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qe4sjO/Of2h6rm8nDE0DUNqnOA6JrqWg3KCpHDQ0XXwZqeys
	WwfFlfhLYh4DHdxxREAmsMMSvto3WaJlXXbjz23i0RQUI/qReErd/jmRxZ4ettGwTQ==
X-Gm-Gg: ATEYQzx5l/J+DNfWq3IOEoPXeECgJOTBckcHzT1rm5Ah6CPql4XJnlnwFYqS0sAS9O4
	BzoTRP7PivgGMY2561IWt7h3kEMtCfcwW14/yYFVjRAsD8lfJfEXyoc76lt27TjkllPFu+7UIUw
	5yR+F9rNQBYu74UvEqG5l2O3SUGOWfoKIweRlLfEjXJcND572sFiVt1fDF1/QNkb9XFjhylwRSD
	Ss26QUbWiEspxeBJikhCbpAkDH2gxKjze2eIFV7KG8QEJ195gnfN8xJMekKVc/J9bg9xZ62PPgI
	nG5oTEhf3JW/TJSchlRuaxDKxPnevqgxDgFJpsdoEfnjzjPbFDTpCeZKcnwgXawR4QCzMw62Qnn
	8BX0wXxt2r9nxrQbM8nufic5rtngl1kVR8zGFtJQsg0ab5iS9VwFyBSP6QK3eEofsh/RBghNKtD
	p7v2FRFP3us8H87nnwLg0eiP8jOxaoEekPceMBYAubhT+RQ0FTTKsRoDax+r/nSQM=
X-Received: by 2002:a05:6a00:4fce:b0:82c:20ba:156d with SMTP id d2e1a72fcca58-82ce8943bc6mr1497769b3a.5.1775005816060;
        Tue, 31 Mar 2026 18:10:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdaa4c3basm3551673b3a.37.2026.03.31.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:10:15 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:10:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, Qu Wenruo <wqu@suse.com>, Avinesh Kumar <avinesh.kumar@suse.com>, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] zram: do not forget to endio for partial discard
 requests
Message-ID: <acxwQXhma2s-e7dF@google.com>
References: <20260331074255.777019-1-senozhatsky@chromium.org>
 <20260331174926.58ef8dc4d40ac12f8ce3905d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331174926.58ef8dc4d40ac12f8ce3905d@linux-foundation.org>

On (26/03/31 17:49), Andrew Morton wrote:
> On Tue, 31 Mar 2026 16:42:44 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > As reported by Qu Wenruo, the following
> > 
> >  getconf PAGESIZE
> >  65536
> >  blkdiscard -p 4k /dev/zram0
> > 
> > takes literally forever to complete.
> 
> I'm wondering how you measured this interval ;)

:)

> > zram doesn't support
> > partial discards and just returns immediately w/o doing any
> > discard work in such cases.  The problem is that we forget
> > to endio on our way out, so blkdiscard sleeps forever in
> > submit_bio_wait().  Fix this by jumping to end_bio label,
> > which does bio_endio().
> > 
> > Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Reported-by: Qu Wenruo <wqu@suse.com>
> > Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
> > Test-by: Qu Wenruo <wqu@suse.com>
> > Cc: Avinesh Kumar <avinesh.kumar@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> 
> Thanks.  I made several changes to the changelog from the earlier
> discussion (Anivesh Reported-by:/Closes:) and added a cc:stable.

Thank you, sir!

> 
> 0120dd6e4e202 was a few years ago so no need to rush this into mainline
> - target this to the upcoming merge window.

Sounds good to me.
