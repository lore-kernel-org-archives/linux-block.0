Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46381EFF9B
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711233; cv=none; b=u69b2qlrODLp/9bf0CIlzfkj27nKyVGvU1Qpml0r3Dvlcg6lctsZ717rX+nJy2hMOo33HVQG2E6Q0f13kf+k+cl9LZbaa450WpxLLToMX363LoSrhb1ojpnc9JHj4MOGHAPeRWQRUnYKpZLD6RjnS5l5rldYgiNO7QB4vQ/sLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711233; c=relaxed/simple;
	bh=rUNDhOW8ASoTLPukFGzkBN+YAJQZ5p884c0V3WJeQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prtHnEJnqC2U72BZPFKxJv3380h9qgCB4fFv6OpyYrPjdAdHoE+P0TZPrWfvvIC5Xt4A03sF9qerkK3ZtOoDktACcRA8+/pfJ/EkyQtlkSo56mUltv5nvuAoltprT6+f8JPhBOJwvgaqe1qY4yQeJw4sC4/WUt972+5VLIgZ5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i46A+sqO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i46A+sqO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e239baecso22967185ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 23:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763711231; x=1764316031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qchs2neNeJ+pT407GR8IfWvCXYGTWBsYqw1z/CNcSjE=;
        b=i46A+sqOSjF9HUjJknqZ6yrTLaVUJVrnb1p360omBBIDrIxollnMQHZc3mOZ7BHo43
         VZS0Yb1y6zrFzDpT+KlTFogmrMhQczDoONnoTuhL7VBoy6fvLKv81RcJ2lNGxAMzZVWn
         RI0+07LfJSG83kZbZsAT1irFCRY7Lr3DbsFVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763711231; x=1764316031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qchs2neNeJ+pT407GR8IfWvCXYGTWBsYqw1z/CNcSjE=;
        b=sstr+qg26bNN3VSRIhcsN3QB+bDXrqPPwyX1U2TqBS8T1pOOBOkgiTtBluZR0n4+EP
         XytTy3v55QYvWE7q0ly7DQ1POOyz5mDwcyc8XI4zGK8arhJyzFAlq1v1eUr8EB0gGGKS
         Jzt+ivHeTpi+NLBAxcqvptD0slS4WO1fgU4/NVev98zG5JCxCPv6TryqtSl8UZ4u6H0g
         sRnzGrPRTkzyQeqOXfqjDN3J+JvQ9B7HNWoirEUhA7z0RfT7PZTlbFAZuzFDbEPx+rL+
         N4Q5EbQZVzy3r49lFnFRFFa42z2OzOx8JhzXMvXJcMdIqD0uZ680JmEWyplq1UyYtAkq
         tncg==
X-Forwarded-Encrypted: i=1; AJvYcCXFO2C1LZt3wzJeoAwiLg4bY6WSp8Edr9/QigCrQsskgDGnirVOgQii4DVm2J8EtUSQj2cK8KtL6DyrgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCfo5Z78eIy15d6yDoGIvioN/2Ls3KkpJTHrtNCuw12CZrsi0
	QZJfF02I3x4ion/FLiI/NWse96kpJXR/yFOnT/06fBq1jjhHp9ozLy5jIoKxv1EhVA==
X-Gm-Gg: ASbGncspEh+HGNmu93j7uc/EpLBmEwSnNlyLvs6gJEYhPiVZxZrcCXcHCqnqlMTkMYW
	exGe9kipVzrSKHlSe1B5X9pFtlXWdOCGZY37XUaWAo5s/HgWcZPfZGoCSZHVB0NeQWcj3L70g/e
	zSCPLNA7wEHEHony9wFo9uPIafxN/7N1GvA7CBIs7lOWZRZViFCFXiQ3Z/rSLP9Q8SKWQmzhdHs
	1pHECYD4RvJU+IiWhB/Di0W58l52FEix4Y0vgHpP8H9d7uMryEnjqDoA8pYg09yCbVPpj+stFXc
	7g6n7p0hc/Nq5txPwctXXTJFN2nQvwt+thmfCrQup/l6+eQHggTxJqpP+UenbZ18y/ON3wgvfQO
	/W9JI9MI8qfr0QMFxr1mLhP5LFqGO2alEZk0/wTXZEVemkd/N5kBU3qK5EWsOfuzAphF5IM56sm
	dDVaSTdtKptlFUVA==
X-Google-Smtp-Source: AGHT+IERlPIR7f/KYSSe+hXGKVpwH6YQfYqAT+vYeEopjrPnED6e4Dd4YOHg16rCMKqdZL/q+sSp3g==
X-Received: by 2002:a17:903:384f:b0:29a:4a5:d688 with SMTP id d9443c01a7336-29b5e38c2efmr72888255ad.15.1763711231236;
        Thu, 20 Nov 2025 23:47:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af1e7c9dsm5602910a91.1.2025.11.20.23.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:47:10 -0800 (PST)
Date: Fri, 21 Nov 2025 16:47:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [RFC PATCHv5 1/6] zram: introduce writeback bio batching
Message-ID: <6yyispyqlczqeu2jjiwb5ypg26jq6gbnyxnmibtztl5ivzw6qa@h7abf3e5twqn>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
 <20251120152126.3126298-2-senozhatsky@chromium.org>
 <90c06ff6-009f-430a-9b81-ca795e3115b0@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c06ff6-009f-430a-9b81-ca795e3115b0@suse.de>

On (25/11/21 08:40), Hannes Reinecke wrote:
> > +static int zram_complete_done_reqs(struct zram *zram,
> > +				   struct zram_wb_ctl *wb_ctl)
> > +{
> > +	struct zram_wb_req *req;
> > +	unsigned long flags;
> >   	int ret = 0, err;
> > -	u32 index;
> > -	page = alloc_page(GFP_KERNEL);
> > -	if (!page)
> > -		return -ENOMEM;
> > +	while (1) {
> > +		spin_lock_irqsave(&wb_ctl->done_lock, flags);
> > +		req = list_first_entry_or_null(&wb_ctl->done_reqs,
> > +					       struct zram_wb_req, entry);
> > +		if (req)
> > +			list_del(&req->entry);
> > +		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> > +
> > +		if (!req)
> > +			break;
> > +
> > +		err = zram_writeback_complete(zram, req);
> > +		if (err)
> > +			ret = err;
> > +
> > +		atomic_dec(&wb_ctl->num_inflight);
> > +		release_pp_slot(zram, req->pps);
> > +		req->pps = NULL;
> > +
> > +		list_add(&req->entry, &wb_ctl->idle_reqs);
> 
> Shouldn't this be locked?

See below.

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static struct zram_wb_req *zram_select_idle_req(struct zram_wb_ctl *wb_ctl)
> > +{
> > +	struct zram_wb_req *req;
> > +
> > +	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
> > +				       struct zram_wb_req, entry);
> > +	if (req)
> > +		list_del(&req->entry);
> 
> See above. I think you need to lock this to avoid someone stepping in
> here an modify the element under you.

->idle_reqs list is mutated by one and one task only: the one that
does writeback.  ->done_reqs list, on the other hand, is accessed
both from IRQ (bio completion) and from the writeback task.
