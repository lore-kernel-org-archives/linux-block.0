Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7B29ACC5
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161795; cv=none; b=oLc/fr9y2/IXmCQAziqHJxsB/dHvB29oklsReeYf1Z0eMnbhs2MEiOkf5X9KeUfSslY5dIwvXsrQx9QsgVtciK04qN/2TYy2E3/hN8/DlVo/3pvUfwHpOzSPtz/ozp5Unmfct2cj2fg7vjl4HGcc2IYUu1Ql8BW7Kr/tD4vfhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161795; c=relaxed/simple;
	bh=Cd+RsF6btowVElbYv9aSiRneAJ8q52hrabVV+WvR76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+fXYkULJwoi8nP6fdreUitdn08XXM742e1HijL5xet542Uxa995qv0BDDD8FhRXo6dQtOvk1CQ+uQrIkoqTRAq2sxDGhL3nA5UAxYhNYE14IRKGmFB8KjiYLFyUKeykRao9kpoRqhMN9Efvoy9j9c88+T9HaIAvnLPfDb/NAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL//q2ru; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL//q2ru"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdca9aa0bso4408588a34.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 20:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779161793; x=1779766593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LLThmBIreez7qxyD4aCOfjNqnYr+qNJSRpHn4blxlM=;
        b=AL//q2ruo2PzjULWWJaN0wIR7CcF8Vw8rhZ4PEgskBPC3ac4qE/c4o91F7WyojNStp
         R4TWQ8pIIZsD5/cK69pYrzt63JI/JQUa8EYOViEsCSgYjExxuInakJuhk7RLsDLe2Q5Z
         QuGQlboPEGxvGtm+NaXNiE/2GlPGwvbKa34decGa+62vIvBxAmpgjsNmj68tYbwALQDf
         iD/wjEqL2BOBW68VmTFLEHXKOYv8WQuaLjebiN07DZ4I14cpaN+ZE93TsnVb/cTvBZ12
         rZG36UENc6Xtv4yK1/02hPLtOpXF8ZsIm9/Jz+BMsXQ+kRPbcU0Tvi3Z1XJDiDNeP47M
         XXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779161793; x=1779766593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LLThmBIreez7qxyD4aCOfjNqnYr+qNJSRpHn4blxlM=;
        b=X/5W1FYt1mf4ze38n3lYFjhD1hDsD/Q7Q5tKCkDs6N6RBHRJ81a7kBmxQ2AP/T0qo+
         sThipiC02X6S3a7H2hTzT00WX3j2VQonYOvtrBYi4yXuir3bX55acvhpYQqO4rSXkzgC
         5AHyA74m4i1qtGfB9+5BxFiXmcMSkNH8ZvOocv8BExQ0M2aHZCsp4bdlpWnUz6TZTYix
         cUMeoHoZ79wq45ZU/H19XFfckmPU70Xt/QQKfVR0rUtTXh/xZAqtEy9nySZDOLbn/NDN
         kypG2asWcLibcIBW1dtDpI21MRSbH6j+dApk+dOloVPqIpQU0snHJWMbL3pbDV3gWQ22
         pn8A==
X-Forwarded-Encrypted: i=1; AFNElJ+VWkKvLE9f2j5OiMxeghZSZKRxJAG+/+iEJu6hSWXu5EXuhVVRzETm/v5O4flfBYGVmVY1KkSCuwrUZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyqr734+Q5CcFW3gFPS3ikY25sfp4ghFdnKvlmQV+E4bvorJmJ
	fHQXM6YZE5FBhRPPQh2tUITW+KlJvOwtrHSmzzXRwMb6G4j8Brt1kcYJ
X-Gm-Gg: Acq92OGg87cxsIC8cnVp7pnp69yO+C2BiqnMQulDJsb4dtGKsAjfjayuEujjq48O2OC
	825rsujFAovVCb69/M07nqHF4GV617iB3W2mw0P5fXRHH8Iq2KeEVKKEqaPK1yaqemEGUmW7QJg
	4xjR/wOxaVNk+/zbP4DM3FpXEAjSZfkfeYwKyElu2/W3n0IWSoZ73P2cPjy3Sa621jUDhPTVQ91
	qDr426d+EqK83OTIZz+Ssy8UtRJi5bBYYS0yojGhp8S6ojR66brb2VyZf/xPSLtkSuTTES0Leog
	BxMMomt5ps5m31g1aRs47wAxZCrk4Bjnd89E/DRPd3j/CSpQ9cqnDcNF/JrzX3rMo54AOuzOuu6
	b02pKKxiX41AhW/NRpjBU+Q2DUVgtIv4G1SHeGV3CMf+C2eYGLd5B+1FURQiCWzzmTaaFI9TwJO
	9GnS6zKck2YDpSaMSjuWwvJmMeAOd011sUuQgYe93qq/AbSbvCi8quUnacxWPfZRDXF4LqbX0oi
	spRvIrY1+1Bz/kObtL2
X-Received: by 2002:a05:6820:1606:b0:695:b571:de99 with SMTP id 006d021491bc7-69c5d3bab5fmr8923939eaf.1.1779161793374;
        Mon, 18 May 2026 20:36:33 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d046130cbsm6727950eaf.5.2026.05.18.20.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 20:36:33 -0700 (PDT)
Date: Tue, 19 May 2026 11:36:28 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2] blk-mq: check for stale cached request in
 blk_mq_submit_bio
Message-ID: <agvavGiivHKgL43h@fedora>
References: <20260501174120.403960-1-kbusch@meta.com>
 <agu74lMg10kxPXrl@fedora>
 <agvT6mMM5Tc2ABbk@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agvT6mMM5Tc2ABbk@kbusch-mbp>

On Mon, May 18, 2026 at 09:07:22PM -0600, Keith Busch wrote:
> On Tue, May 19, 2026 at 09:24:50AM +0800, Ming Lei wrote:
> > On Fri, May 01, 2026 at 10:41:19AM -0700, Keith Busch wrote:
> > >  
> > >  new_request:
> > >  	if (rq) {
> > > -		blk_mq_use_cached_rq(rq, plug, bio);
> > > +		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
> > > +			struct bio_integrity_payload *bip = bio_integrity(bio);
> > > +
> > > +			if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
> > > +				bio_integrity_free(bio);
> > > +			rq = NULL;
> > > +			goto retry;
> > > +		}
> > 
> > This way still looks fragile, given rq isn't guaranteed to be live.
> 
> Yeah. The current usage in this patch looks like it should work out, but
> not necessarily by design, so yes, fragile.
>  
> > Just wondering why not pop it from plug->cached_rqs from beginning, and
> > move it back in case of `queue_exit:`?
> 
> Not sure. I guess it's an optimization when the bio merges with a
> previous request in the plug? If we popped initially, a successful merge
> has to push it back. Maybe there's a better reason I'm not seeing.

Yes, this way may avoid potential perf regression for heavy merge cases.

Thanks,
Ming
