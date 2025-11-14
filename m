Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85541865ED
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085211; cv=none; b=OJWHl5xR4PLwiVMNAO/kqHyyAJqx9m7D7sPAgzZ8IB+9AkZ+IvBGNooAf1WvKW+94qvurask383wQD+z/MCbVJu77kPkzQ+tj6B01a9Jw5fsZ6BZ4Z7OYagfvZbUhfbNIOcWfyq5PObwjTI9Sq7Ft6TgmO4VihPtS8z8ULOQ7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085211; c=relaxed/simple;
	bh=fpbe7+BYlw1Y671HcTH+ox5SS0E8eqH7WWACwS87yg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXBkiVKwq4H6z356rw5k4zDVKFq/9ylQWPMHEs8k0vyQLBJbRT43zpEkkv+uQjOs8A/h2vfXDVVt2nY3BLHKMMsg7KfNxyWoj1eG9GkuATwUAD85ILGOv19ddt2F4SokPyFJC6HdpAogC1GSudwzOdNrVitorLilIguiXAhDwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cEYQcZPb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cEYQcZPb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b991081160so1237209b3a.2
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 17:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763085209; x=1763690009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LDGlt5BP9HGrN5kDVPAodxjrvpp8sHxQXkzmFVXsTw=;
        b=cEYQcZPbjJTuskpL/5X0bBUx6GhOjc9fGC0vHOV2teFoRGiCuc9Ss8D6sUpWId4ZuR
         3PUNcFEYUK/WT9XPgPcbXbJknCbTSloLDvsqEad+eOvNj7r73mkqVDX42edXJSpV/YqU
         2rohYaeNO+RKf5mjxZEzhPQK89abFIeda3ReI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763085209; x=1763690009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LDGlt5BP9HGrN5kDVPAodxjrvpp8sHxQXkzmFVXsTw=;
        b=K+URU4zW3284WGtEaSxhsIP1gbY/J9fF5qRkILuy0rEH/gY5SCxNnr2rPefFOCceO4
         H8wRK96om57BCGX7AGX2hXQtfUQTsyjEWyiUYgTN11u7K0Tzpifjc37MAYzJAXdvfPa7
         jYSj65kFSaNYoQv6B5dVStJe7lDkZpIf3gd9X7N2XGcbGJM0eKFHgJxh99rtVNZmbzN6
         O9uGm2/JGY58P4asECutJlR5CmuWHALfe5nvSBSmQjhX6bz+jz10X+3j34lnffTotRZV
         vnuIREHEiAvf7jhSxPqwHailsc2Ag9EhoCD8QyhU06fV7Xp6tZYgJmOUfg5V6wWINGGG
         Qh1w==
X-Forwarded-Encrypted: i=1; AJvYcCWupITXr+jZgO8QThgfW2Jsz/vIWjl4qrtHBDx0DQ7ndvWu9xeJ0g+fqBe6P5BfqXnVJM+tIBM9VAX9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SfYosRI1C61fiITBs2t3mj+zJJ9T7YgwOz4NQ8Ut/MJutdph
	3TA7eAf2mFqET6BpgV4Zh/gKuGR2OQktPu+cLAvyM1EuG623RYB23uBSOiK4AJb3zw==
X-Gm-Gg: ASbGncshyhlV+Rth3pRzUuyd8ZA/NmMEfc2rgD58ZyikaGUusKTq/KSqjN6lE3GHw+X
	Z4d3o+dYyEj9EehW2Bonr5ewbfsWxr2DuKQz8Tc4aIGjFZIYP6ZPmVnIGVzkm5XufXKWzhPEkuz
	bbKUEVUF7bIXu0QwgHW3FXiCB+4gUpHp6mBz7sMqLBBBkJxDTBd+7m5vT4R9gBfYVbhTI17SuLX
	+Fi6DGX/v8O1hLabnBaEE6pbZDKXMeHzQAXjb/ZlI1fkmQyBd4+Q/fMJbaQZUUkNSeE4nOCAY0b
	TrebV4liQ9xJEmHyEsLMMuqNrh7u7ba2NEq5l8oQYDfVFczU3r3O8BUAxmqcYjJUBUDth2rhTCe
	vijv+UYdYyBzOFD4It7ClKmHD3CHkO/9UJ0s8z44tn74IoZznYSlN3bxB6RqQNcBPVm+Afsw90I
	mNi+iAi20VW9glfw4=
X-Google-Smtp-Source: AGHT+IF8knbLFGnSfk91LbrxqoXrIXu987LpSYmuVrZv5LzQ+C4wG/KgOmFWJ7dRbgMRz0JhH+7PxA==
X-Received: by 2002:a05:6a20:6a1d:b0:355:1add:c298 with SMTP id adf61e73a8af0-35ba047db16mr2310631637.21.1763085208913;
        Thu, 13 Nov 2025 17:53:28 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782d39bsm3518611b3a.63.2025.11.13.17.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 17:53:28 -0800 (PST)
Date: Fri, 14 Nov 2025 10:53:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
 <aRZttTsRG1cZoovl@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZttTsRG1cZoovl@google.com>

On (25/11/13 15:45), Minchan Kim wrote:
[..]
> > +struct zram_wb_req {
> > +	unsigned long blk_idx;
> > +	struct page *page;
> >  	struct zram_pp_slot *pps;
> >  	struct bio_vec bio_vec;
> >  	struct bio bio;
> > -	int ret = 0, err;
> > +
> > +	struct list_head entry;
> > +};
> 
> How about moving structure definition to the upper part of the C file?
> Not only readability to put together data types but also better diff
> for reviewer to know what we changed in this patch.

This still needs to be under #ifdef CONFIG_ZRAM_WRITEBACK so readability
is not significantly better.  Do you still prefer moving it up?

[..]

> > +/* XXX: should be a per-device sysfs attr */
> > +#define ZRAM_WB_REQ_CNT 1
> 
> Understand you will create the knob for the tune but at least,
> let's introduce default number for that here.
> 
> How about 32 since it's general queue depth for modern storage?

So this is tricky.  I don't know what number is a good default for
all, given the variety of devices out there, variety of specs and
hardware, on both sides of price range.  I don't know if 32 is safe
wrt to performance/throughput (I may be wrong and 32 is safe for
everyone).  On the other hand, 1 was our baseline for ages, so I
wanted to minimize the risks and just keep the baseline behavior.

Do you still prefer 32 as default?  (here and in the next patch)

[..]
> > +	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
> > +		struct zram_wb_req *req;
> > +
> > +		/*
> > +		 * This is fatal condition only if we couldn't allocate
> > +		 * any requests at all.  Otherwise we just work with the
> > +		 * requests that we have successfully allocated, so that
> > +		 * writeback can still proceed, even if there is only one
> > +		 * request on the idle list.
> > +		 */
> > +		req = kzalloc(sizeof(*req), GFP_NOIO | __GFP_NOWARN);
> 
> Why GFP_NOIO?
> 
> > +		if (!req)
> > +			break;
> > +
> > +		req->page = alloc_page(GFP_NOIO | __GFP_NOWARN);
> 
> Ditto

So we do this for post-processing, which allocates a bunch of memory
for post-processing (not only requests lists with physical pages, but
also candidate slots buckets).  The thing is that post-processing can
be called under memory pressure and we don't really want to block and
reclaim memory from the path that is called to relive memory pressure
(by doing writeback or recompression).

> > +		if (!req->page) {
> > +			kfree(req);
> > +			break;
> > +		}
> > +
> > +		INIT_LIST_HEAD(&req->entry);
> 
> Do we need this reset?

Let me take a look.

> > +static void zram_account_writeback_rollback(struct zram *zram)
> > +{
> > +	spin_lock(&zram->wb_limit_lock);
> > +	if (zram->wb_limit_enable)
> > +		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
> > +	spin_unlock(&zram->wb_limit_lock);
> > +}
> > +
> > +static void zram_account_writeback_submit(struct zram *zram)
> > +{
> > +	spin_lock(&zram->wb_limit_lock);
> > +	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> > +		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> > +	spin_unlock(&zram->wb_limit_lock);
> > +}
> 
> I didn't think about much about this that we really need to be
> accurate like this. Maybe, next time after coffee.

Sorry, not sure I understand this comment.

[..]
> > +static int zram_writeback_slots(struct zram *zram,
> > +				struct zram_pp_ctl *ctl,
> > +				struct zram_wb_ctl *wb_ctl)
> > +{
> > +	struct zram_wb_req *req = NULL;
> > +	unsigned long blk_idx = 0;
> > +	struct zram_pp_slot *pps;
> > +	int ret = 0, err;
> > +	u32 index = 0;
> > +
> > +	blk_start_plug(&wb_ctl->plug);
> 
> Why is the plug part of wb_ctl?
> 
> The scope of plug is in this function and the purpose is for
> this writeback batch in this function so the plug can be local
> variable in this function.

ACK, that's a leftover from when I manipulated plugs outside of this
function.  Now it's completely local.

[..]
> > +		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
> > +			 REQ_OP_WRITE | REQ_SYNC);
> 
> Can't we drop the REQ_SYNC now?

Good catch, I suppose we can.
