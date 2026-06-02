Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3C360EC4;
	Tue,  2 Jun 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411598; cv=none; b=fGsgT+hx2CxNnWmeySTr4nO2ahdOBcR5kbFCEp23CIu9OuSjbLnTklGGRa6KKgHcYv7zltmyUkBNf8DzJkrtgAqP4vviRWUFvSghUE5HuVp2Yu8J97nT/pL+mDAkhQZyIauBPUno+t6V25XTh+8WPm/Y7ymDUQtzl4TLTB7uyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411598; c=relaxed/simple;
	bh=NTuVaCjECHf4Ct9I+q3M9mk7iCttpPGrNcGnrd4xFvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNwRUrLeSVu1JnL+opRHyrOUf/6nUgWIOocvTt+i2U6SwrfNelgaUQNrM39ghqXYgjB9zLGzUmCaru3t96oEaDZeVlX48bDIRuqRRq5D2gu+g3SJBY0RRq9Pjp9kVu8qPBw85iTQ/lJm27pyPK0AJJRQhsgODkip2a22FapBZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CB3468BFE; Tue,  2 Jun 2026 16:46:26 +0200 (CEST)
Date: Tue, 2 Jun 2026 16:46:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 8/9] block: add configurable error injection
Message-ID: <20260602144625.GA5333@lst.de>
References: <20260602054615.3788425-1-hch@lst.de> <20260602054615.3788425-9-hch@lst.de> <ah6li1JOGrpXor9W@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6li1JOGrpXor9W@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 02, 2026 at 10:42:35AM +0100, Keith Busch wrote:
> When nr_sectors is 0, it is reset to U64_MAX so overflows if start > 1.

Yeah.

> I think you want to remove overriding nr_sectors to U64_MAX and do:
> 
> 	if (!nr_sectors)
> 		inj->end = U64_MAX;
> 	else if (U64_MAX - nr_sectors < start )
> 		return -EINVAL;
> 	else
> 		inj->end = start + nr_sectors - 1;

I ended up ordering a bit differently for better readability, but
yes.

> > +	mutex_lock(&disk->error_injection_lock);
> > +	if (!disk_live(disk)) {
> > +		mutex_unlock(&disk->error_injection_lock);
> > +		return -EINVAL;
> 
> I think we've leaked 'inj' in this error case.

Yes.

> 
> > +	}
> > +	list_add(&inj->entry, &disk->error_injection_list);
> 
> The __blk_error_inject interates this list with
> "list_for_each_entry_rcu", so shouldn't this be list_add_rcu to match?

Yes.

> > +static const match_table_t opt_tokens = {
> > +	{ Opt_add,			"add",			},
> > +	{ Opt_removeall,		"removeall",		},
> > +	{ Opt_op,			"op=%s",		},
> > +	{ Opt_start,			"start=%u"		},
> > +	{ Opt_nr_sectors,		"nr_sectors=%u"		},
> 
> Shouldn't start and nr_sectors use %llu?

lib/parser.c doesn't use those prefixes, it's a bit weird.

> > +	if (!options)
> > +		return -ENOMEM;
> > +
> 
> On failure, memdup_user_nul returns an ERR_PTR rather than NULL.
> 
> 	if (IS_ERR(options))
> 		return PTR_ERR(options);

Aarg, annoying.  Because memdup_user does return NULL :(

> 
> > +	case Removeall:
> > +		if (option_mask & ~Opt_removeall)
> > +			return -EINVAL;
> 
> Leaking "options"? Should this be:
> 
> 		if (option_mask & ~Opt_removeall) {
> 			ret = -EINVAL;
> 			goto out_free_options;
> 		}
> 
> ?

Yes.

