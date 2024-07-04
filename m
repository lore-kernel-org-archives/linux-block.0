Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422125779;
	Thu,  4 Jul 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095553; cv=none; b=WWbg8P5I+a5AFJNLlp39RzYhsPJdpVSFY/p6uqvsr6/EzLGsDRlvJn9tgmn9J2jl93jcknvRvCEHezJ4DBFpHcgyLVEM/hGMYC+oNS/mffXaJkG0TcJr2xtQuKK6HYdYMAen/93pQL/U8wzqbMm6dsXjk0zBp89F1Eobxd4t9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095553; c=relaxed/simple;
	bh=Nnlx2nHqz0VPl3CWDgzgXFLf1nEKUzyfRv56y/zLLtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVugdObJ0oJ7hePlLpFnHhrrdN/uXPPBCggYD3sknKQxt6ee/uGrG2UyDMAQfHPNRzBpkEQOdihPAcDDnWEJiSXgtTCMJjoeamm6DXuc5+ljFzxktehFk72w4l+WQ9AsCglQtP5pi4kxcJuTx5k4stATvcoIwKeJlzFWPdz3zpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zibf5UeN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FC/+YWlj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zibf5UeN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FC/+YWlj"
Date: Thu, 4 Jul 2024 14:19:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720095550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAv0pawrlTY1HxGYFhyoC+vPlRm/ofgkenUj6RqKG+8=;
	b=zibf5UeNO2SvoaMy/Fmrk4rG1LXq+drMULDUKoNV6B+MZA48UpRCtUHeIQn/ldsIIuSzRw
	cZ01KjDKWumFaAUsS6sX66QtiHZz5kv7CuEdVTKT50Wr/9rf4opT7YxX7Qj2Zm35BgXb2m
	RK3lVo7CIwuWojjs2FnKAkl7HyAVeDfQUYtoC0hDUXOrob/zcSlVOKRHv8GApU/vQkXfac
	4Vk7n7TeEO7PoCDeWFcF59q0ySjvPkd3IbL0RkkCcpVcwPTABI16F1VQeE0jZjsxE4bJw9
	+eDizpmcHjC1bpBnw4+U3DVsh9d1nhbDp14mu2bOnwwZ6DRJOB9c91LXpMsH9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720095550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAv0pawrlTY1HxGYFhyoC+vPlRm/ofgkenUj6RqKG+8=;
	b=FC/+YWljnqh8L9IpnFdXPnrZooaGcGd0M3aqtJvVZcnn5x4cuq2m5MiBfXOp16JkGNWTwj
	2M1MLhCUOSF5V0Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240704121908.GjH4p40u@linutronix.de>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>

On 2024-07-04 13:38:04 [+0200], Alexander Lobakin wrote:
> > index 3acd7006ad2cc..036845cd4f25e 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -57,19 +57,34 @@ static void zram_free_page(struct zram *zram, size_t index);
> >  static int zram_read_page(struct zram *zram, struct page *page, u32 index,
> >  			  struct bio *parent);
> >  
> > +static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
> > +{
> > +	size_t index;
> > +
> > +	for (index = 0; index < num_pages; index++)
> 
> Maybe declare @index right here?

But why? Declarations at the top followed by code. 

> 
> > +		spin_lock_init(&zram->table[index].lock);
> > +}
> 
> [...]
> 
> Thanks,
> Olek

Sebastian
