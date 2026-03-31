Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6D3BED15
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942082; cv=none; b=prhpN8i181qt+EEv5qfqc44vF2NeG87koEbTvNo/rMwkwEcb+8xieZIfH056f0mnnun1R6MJEyfPEdvRj2z9esjyZObdvpNXELcCSvrOxKQdDQCGresvpmc1pk1hBIQzuZYzx2KIGVFSzJcVHwPZcvj9ZqDDxvV7RioK8DXVXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942082; c=relaxed/simple;
	bh=SmAFEtt6ZgaLjNsWDevM178FgEnxBFzRT51o7p+tE/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nItF+G+4i6jROktA03FUNkXGgVZaNSpotjeSn2lExycBKLTSHlfhh1PjepXR015Wecf9J6wDwvDmD3yNH+alWwvsy0eAlLXtOGE+ngyJH7uBpYsAjk/7B+j1oXNk8pjddhRArVpq8JFuJwYOA3cVOg9iK3fb+gK5b/2li/2fDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rad9HP/M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rad9HP/M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fdac394so20600135ad.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774942081; x=1775546881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wagPPFB0kk3KhuNLW9TIEMtF81ktdb45BmYJ3ltM5R4=;
        b=Rad9HP/Mjlx3gvI82tThpheGSEDXyhJflA63+EjRXH/cZpIjCRxtcPnw7K9P5YhT/6
         +csBRZfJ7JARqlMpaf9xOZN08MI2DvCzXfKDxZdhuGgf41lVPiZk4il/iu62wY+m1r8i
         q9oIgqs0YVLnkqsuySzzblxLnjn7qRJyG6x4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942081; x=1775546881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wagPPFB0kk3KhuNLW9TIEMtF81ktdb45BmYJ3ltM5R4=;
        b=NQTNZB9lS0Q1+g3hlz0p/5In+6hNnvK5gd2ahAGRIlwvla+5uVL2GYuFUpsRbEUFYv
         oufD89q64JgGOTLDaFHdkRm3uavlZmxNh2ZA/T4KVn3vkFA2oBdb6cyWuItzfowjb3d0
         ke55Al7ejm/X42Wc9lp+v0YTP3AIgL/o8xjbaEQTgh18f7uHiAO+RZys2w1rJmt0m8xa
         zmAEzT9OOPp/XILVEjqNPvBCR6ZcZJbz2X9rgWbqTd6/S8SawACV9xGNZ7ppG4zWfM9W
         5kMZi52NB4kxa654EIxB8R9/qJIHPJa0BarOVzAwJwV3+ECWZYavKh4nyYyV0wsN0Ff0
         TWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFlmhscmdAsXgbYhmkva7UUDHsSkbJfe1ts4xDMnN8CAvjENaMhExwD/vPB6ByL1FcYe6KCcj4NLYGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZwMVPNmZcTPM8mUDZJCH925hXKUzkHwXfzXhpY5esWsB3agu
	mByJTMrfjEes6k//ZCY5fU+W5SQNPono12VEjF7YVyGiICnp6FzEOjsEpQNS3iuJ+Q==
X-Gm-Gg: ATEYQzyTBCESRc3o3+MgcqvX3MK2iD0+Dfr4ERe7ySVwVmULUA483GTsU2ITmkRiuHs
	9GXbEVOsyHeelDSqqr3b398ZesUngM43Lz9YdI8FQy3/IxF0t0e4bw/A8NB+QTFBIxiWhyzp22h
	vglzTWtCPP2WK1nn4bhs/rJWKfiqdpfM0ApwWd2FTNAtxz0Fq+BltdlTyvwdKr+QhX5PjeL26l7
	1qsG0CiGtZFCZsIXbHSZtLy1vpMkZTZ1tqgfNy7gkR8TYAP2OIOI3PpyZ4FpnXHaP4HQ/IrTU0i
	tc2Si5A7e6UzkCNr5Stq91J1ciiv5DPkWdZ1HpHsbQSNz7d8EZlT5jlmgy/IqNRyo78pb2BNMkp
	2ztBZpFxBwJiowrTwkzLgN64SidZ0MgytLejqPu0EX//eSdZ9hzLZTWknBSDSCnau3ektUHBBdg
	SxB/Sblx4gLlHV+/PuuErk/2FuEauHnXkQNqf49cHeoXnDyC2GOO7FmznjJCVxulviVryPjOYag
	A==
X-Received: by 2002:a17:902:d487:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2b0cdc5d700mr165997155ad.23.1774942080640;
        Tue, 31 Mar 2026 00:28:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277e8d3sm101197635ad.55.2026.03.31.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:28:00 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:27:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] zram: do not forget to endio for partial discard requests
Message-ID: <act3bNgya8n4nVcj@google.com>
References: <20260331071537.706139-1-senozhatsky@chromium.org>
 <20260331072633.GA5494@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331072633.GA5494@lst.de>

On (26/03/31 09:26), Christoph Hellwig wrote:
> On Tue, Mar 31, 2026 at 04:15:06PM +0900, Sergey Senozhatsky wrote:
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2683,8 +2683,10 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
> >  	 * skipping this logical block is appropriate here.
> >  	 */
> >  	if (offset) {
> > -		if (n <= (PAGE_SIZE - offset))
> > +		if (n <= (PAGE_SIZE - offset)) {
> > +			bio_endio(bio);
> >  			return;
> > +		}
> 
> Use goto end_bio and share the code with the final completion at the
> end of the function?

OK, will do in v2.
