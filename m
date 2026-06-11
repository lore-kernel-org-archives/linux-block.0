Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD517A2EA
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146208; cv=none; b=LkBaRwVoWAiRwDwD03whc/c44p92v9pSYvKf0JN7DXnN/tcsU6XEMGbMCbyzEruJ5FOQ86/fkGtqdIZ0XXWbnnyXsSXBpuNOGs2KuMB+knU9PPNtVtJEYlU/w/NMNjJ7jP6S4Y4mJgTbmtJ5/OUScSrA19fEveCv1heSnjpfcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146208; c=relaxed/simple;
	bh=D/pIjIXYdcoFhHqErMoyM57Ci1HcSQ0ylr0VBmMckMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JueHFnAfkeITcqBMlylkuZ9fz8HNkjAoIbjRYS0f4rh2i6TsM6qqih0W3rzggNh9mwJCcf2B2J9fE/MTTdsbqmdV3P0dDPp9awwkQBQZg/3e91CHnSijXUfhF9Jh7S7IHtFrMVQgQNCxEGEsC+MXlOn8adbgRbgz2NrUXuCB1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beMU89qC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beMU89qC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91587626ae1so845857285a.3
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 19:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146206; x=1781751006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYqF+jgje8tkR0pyAxbhAw2OI8R6JpCjQ1aV6X3qSqY=;
        b=beMU89qCNAqBi76Dq9XnucsLKkQuR6H3CqG/iU052f3OgAX9ZUc93zy6wfZhboGoLc
         x5gNML8xbhF2U6gg3nUYEtDpHPA9d/2XmhhxSRt/rQF4rkLmXcdMfA1VsO5apAZBaByO
         c/F+pjk3Lwr9Hglwpkb6s/25vnUAutLP8qVAHK1TrbgKZOlER9w3/4RVrng9kRiKwXGX
         E8d1EQ2DHl/kfHi3lhEQffCxdDEsLC1Bvhmak55XZ1Fu94+pdCtQ/Dgb8KWDSYlDfhaI
         oXhPHKeOEYWPKShRXs0adc+eoX1pSMsKz06HnNDWpoPpyToOZDbNbswxj+3nYqWrLP6T
         9adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146206; x=1781751006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYqF+jgje8tkR0pyAxbhAw2OI8R6JpCjQ1aV6X3qSqY=;
        b=Vorurwg1IibRIk2zadgRabwhALrANpB1UBbg1YbXJIskqHHdCvx562OGkwortCAikv
         ndZvHP45gb8dGhnY93xfMq+rAjC19qJfj6FJ7EJEcSwbbfvIQEaWt8+RgRznTibdekuq
         DGc504KwqnHGoGTSZ/yUgaqbX77uYYhxTDvTkcgtuy2xclMexT8fYabshcOdKOSmoPgv
         Q8+RnXvIU2a9Sz7c/nlUES4/mPVGCcTZJrcbjuDurlveHv++cYGkaOWy3ZWwhLL337xF
         XDpckKGsYNH8SdZ2krFuTA1dwryPayjcD765DuxhgpGHapki3WwgHAPVBqhlwbMLclU8
         dhVg==
X-Forwarded-Encrypted: i=1; AFNElJ+ECKT+T2C6l1vyiU+WS7W3w3aaIZcycPYub4nNWTQTmIWfI5aLmZyLqV9iMBl2g0xNdDLL97USb//0Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3uMqTUkksa6TC88HtL0nsnJ/6tVHFvGf9PhvkK5Vox3kbr7B
	wipQhob4dpOpWmHh9oaTY97NiWdzb4fNRq7gZ9CCEDtH8p3fS4N0YmBp
X-Gm-Gg: Acq92OEmRXjU6Ut+JQw0LU1NB3ZR2hb8IP8WJgrjhnfupuvBp8adv4kW9cp7hA/Crop
	k/0mLEUO6ckVBFwE5iDoreKCyLN4jinNpn92vF6CVqyfq24roLCjGkQWbOrMCk4EnhVvaQFT/N+
	0Cenx0PUVjlgXgas3yngy49EB+h1R0P/3gtkjx64KcEG3MV4jH1IWRzMTpN9WltnoDNMjaU1t3K
	eNO0YbN34mB8zfenfQ47ko/6rqlyMh0Che+83aSF0S8F3RzzQ58xQfosDFTA6f3l+0/zBdzm56/
	v0QBdDITkOWEVyuFg2sUE4ZbuBMwF/fHOCJu+06ei02os9nmZLC1kgBffN2BeivskmtXEa3epF3
	cYjdpcJ+DHNacw1BvrdNONImVOuinvg74bV87Py3u/uIX+8EFsecOpcO9IZOY+pNLBCRvq5YtU5
	rYt3FsG+1dOeCFeM5DHv6AasDDGhJfHDxLAjX8F9ujhwruWSFl9IgBFJa3BChBc0foxh/WjMdEf
	LvEARJHL+jXx7OaLx3DGKHAQPVymys=
X-Received: by 2002:a05:620a:26a2:b0:915:c48b:af54 with SMTP id af79cd13be357-9160b0ac0dbmr99712685a.57.1781146205906;
        Wed, 10 Jun 2026 19:50:05 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160ae26238sm50394985a.33.2026.06.10.19.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:50:05 -0700 (PDT)
Date: Wed, 10 Jun 2026 21:49:59 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, brauner@kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aioiV9_AgaIBB6cB@fedora>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
 <aimErft1NoW-4Map@kbusch-mbp>
 <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>
 <aimbdmqC10uXrZuo@kbusch-mbp>
 <aimn3kipMHdRmTTe@nidhogg.toxiclabs.cc>
 <ainBCDneRqNvmMT_@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainBCDneRqNvmMT_@kbusch-mbp>

On Wed, Jun 10, 2026 at 01:54:48PM -0600, Keith Busch wrote:
> On Wed, Jun 10, 2026 at 08:19:53PM +0200, Carlos Maiolino wrote:
> > On Wed, Jun 10, 2026 at 11:14:30AM -0600, Keith Busch wrote:
> > > 
> > > It does require that someone calls the bio split-to-limits routine,
> > > which I had taken for granted as a given, but I realize that some
> > > drivers don't do that. What block device are you using for your test?
> > 
> > In the PPC machine, it's a virtual scsi vdasd device from one of the
> > virtual nodes
> > 
> > NAME HCTL       TYPE VENDOR   MODEL  REV SERIAL                             TRAN
> > sda  0:0:1:0    disk AIX      VDASD 0001 000a508a00007a0000000175dcba35ac.5
> > 
> > ibmvfc                262144  0
> > ibmvscsi              196608  2
> > 
> > For my x86 machine (remind I reduce the buffer size to 512 on x86), it's
> > a commodity sata samsung SSD:
> 
> Okay, these are under blk-mq so always call __bio_split_to_limits.
> However, I see there's an optimization to skip the checks we're
> depending on if bio_may_need_split doesn't think it needs to be split,
> which is a problem for your observation. I don't think the current
> expecations can allow us to take this optimization anymore when page
> offsets are used.
> 
> This should fix it:
> 
> ---
> diff --git a/block/blk.h b/block/blk.h
> index 1a2d9101bba04..3731f3c5ed140 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -404,7 +404,7 @@ static inline bool bio_may_need_split(struct bio *bio,
>  	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>  	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
>  		return true;
> -	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
> +	return bv.bv_offset || bv->bv_len > lim->max_fast_segment_size;
>  }

This should work for the un-aligned DMA buffer, but might hurt perf for
any sub-page IO.

Given you have switched to validate dio buffer alignment to bio splitting, it
should be fine to check ->dma_alignment here by putting the three limits
fields into same cache line.


Thanks,
Ming
