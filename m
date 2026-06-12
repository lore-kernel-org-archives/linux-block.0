Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA092F3C3D
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262375; cv=none; b=Ft1qVBmNr6ILcnk2Ql8km6lPPgQW3BYdisyyFIAUjEgQ22WGeJvoRx7paGWzRBjZ0E4QrDEq+onnRyJlrdKrr+aWZkgkDcAHmgFGT5ObMoRGKmyT+rJfNm36Y41CB/9bSjEvkimNGzWUv0WgieKW1ZLSj8EkH/qerSwudiyq/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262375; c=relaxed/simple;
	bh=a31ONy7dvYGyEt6CcDFCS3l6iPLRau5Kac8mfJDoJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFbzLXrfs0CMk3hCOAdXgWFBcXljV5eR4rQH2kAi6P00jf/NueOcBsH2nCJJJKdopqhe1nhis2eZTn2xr6s2aOOYdog2NEP0oiEbFhp9yq94RTXe5lQtzIPMgZgIAXi4gC2e141zLF74uV6eBUXD9gJjeoEQqOG160sOBBXBiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NACJrMBd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NACJrMBd"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43d133d9a28so356059fac.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781262373; x=1781867173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WXsE46dyrXMZ7vtWuSr/UUEHUsjTggx+DaLYudzdb0=;
        b=NACJrMBd54X4f1Mv8ehjMI/1LkOP9qzhxiPgEvOsxzJdlqoS3gGMJrlgc8q4FIrTg2
         1h5mseNS8B7FgTd8ElcbM/YtAZ9U3ytBWS8hGvas+rQSNfUUMlE1eb9EcKOdEqR7W988
         GJgCUtlgzrQYJ6n7ZEaA5Y7STSG8PF4mCjMK8GKp+Mz8V9XOExG0WSdudxIDNpHzTzJm
         b/UR8KAc9+ArWiwEsWqYAze4/1Db1s1Eumczd/AtnfwyVlzo09XOg9/a7bpLWyfm6HEI
         COss0EtS/sLhTWrSfH7a1g4rKmDH0+f5E+xrOmk1jFCUCc2yfrhavtOy0rmyqhwtXn4E
         N7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262373; x=1781867173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WXsE46dyrXMZ7vtWuSr/UUEHUsjTggx+DaLYudzdb0=;
        b=Sx5wb8ynMurg1stCMLlGNcnkCRrM2A1yVn2n8dSw+Pj6zYF6GoiSfzmWfpfMbm5O46
         A9BN1cqItfyXpBai6n5sAxJliFQBlKEgYd/SpjWASvC8m0O6BpCudkLrWzdWw3S/j4ec
         nIzta7oiHoyDTnW0Xw8WZpJWxxqfisbj/dn7rvT7/WH1IhxuYfWAvck8A4E5rFH+o5AF
         rrg0HWc7vGfoqecH6kDj52JICgqcENPaj63SWyN8TMh35D7cmL0i/7Yuo21YyIlYIi8o
         oVUJpDkxuUBZmAYtB/gNnwmWiSp9+30r5F6RAc7v3zyH6cLd8BUWmjZRn9g7xhUTa9Si
         wLgg==
X-Gm-Message-State: AOJu0YyzJM7UOs146Edeq+t/LL0QYZkqvIrcN4mPZ554xLPdwaiSjeHt
	pnrn68mj23h7/aFFN8575ZzoG7CS6by65RnNidHbHjeuduZiqzkDm52d
X-Gm-Gg: Acq92OGIxKOoE8L6Z38kkV6wImLqMtExGBAYdRdi62I505nG0tB72ePAmzJbEymbe9K
	0J8cpV65gOdsvSWLEn92pCYNzPhtZ8c8aVtapBaOqpkftzvkI1uYyGJ8HmWZthq8wNqzqY+60wm
	dLoo8kEbI+sRqr05lwueDpgAiCfrdWgoX6aSgv8ZiHsWFLDhljSaE9UtAr/WlpUlZdF4pSKHlh3
	vtiMRXsXcrQ6qenawbqe4Sxzuk16uUClR6GX2Fw6yoH/5jzK1ihifoq/yBpEhO6LZ3n7jBA62V4
	alzzvA2xk0pKia3ANzASMAITG8C/UA5CdGmEeX0szePhy/HntTVOa7KGga+r+1xNhG1HZUCSkUC
	uXGY9kQp8Uosj1vXZqTY4jmGLNJveWfdd7ofFhAX49O1YPrBv6LysZSv/DC4UIIRnO/w5fGq+s8
	k5oQ2SgbEBx9Peksh83uth1EAp1TdZlexnff3aWVoy11Oq+wPW0hgoRxVpXjPdZBpX8EJWt1OwE
	YENBm+w3hCbTIKNYEGl
X-Received: by 2002:a05:6870:5d85:b0:43d:3b08:5f92 with SMTP id 586e51a60fabf-4426dcea35bmr1470157fac.13.1781262373159;
        Fri, 12 Jun 2026 04:06:13 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426b394f26sm1562177fac.17.2026.06.12.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:06:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:06:06 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Message-ID: <aivoHk4DE_pkKkDm@fedora>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora>
 <aivMxPCd305WbBsk@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aivMxPCd305WbBsk@shinmob>

On Fri, Jun 12, 2026 at 06:47:50PM +0900, Shin'ichiro Kawasaki wrote:
> On Jun 11, 2026 / 06:22, Ming Lei wrote:
> > Hi Shin'ichiro,
> 
> Hi Ming, thanks for the comments.
> 
> > 
> > On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
> > > I observed that the blktests test case block/005 hangs on a specific
> > > server hardware using a specific HDD as a block device. During the test
> > > case run, the kernel reported a KASAN null-ptr-deref (and other memory
> > > corruption symptoms) [2]. This failure looked sporadic and hardware-
> > > dependent.
> > > 
> > > From the kernel message, I noticed that udev-worker wrote to the
> > > queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
> > > The test case block/005 also wrote to the same sysfs attribute, which
> > 
> > sysfs write is supposed to be serialized...
> 
> I checked the sysfs write handler elv_iosched_store() in block/elevator.c.
> I found elevator_change() call is guarded with the rw_semaphore
> "set->update_nr_hwq_lock", but the guard is not the writer lock but the reader
> lock. This does not serialize the sysfs writes.

Please see kernfs_fop_write_iter(), in which mutex is held before calling
->write().

> 
> I tried the patch below to replace the reader lock with the writer lock. With
> a quick trial, it looks working. The kernel message is no longer observed and
> the new test case does not cause hangs. I will do further testing to confirm
> that this change does not trigger other new lockdep WARNs. Assuming it does not
> have such side effects, I hope this fix approach is acceptable. It doesn't add
> the new lock, so I think it's the better.
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 3bcd37c2aa34..b03185a217ff 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>  	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>  	 */
> -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	} else {
>  		ret = -ENOENT;
>  	}
> -	up_read(&set->update_nr_hwq_lock);
> +	up_write(&set->update_nr_hwq_lock);
>  
>  out:
>  	if (ctx.type)
> 
> [...]
> 
> > blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
> > fix could be check & avoid the null-ptr-deref.
> 
> Actually, null-ptr-deref is one of the failure symptoms. KASAN slab-user-after
> free is also observed [3]. Then I'm guessing adding null checks may not be
> enough.
> 
> > Adding new lock should be the last straw usually, especially this one is
> > depended by queue freeze.
> 
> Got it, thanks.
> 
> 
> [3] KASAN slab-use-after-free

Then you need to figure out the exact slab type and check if the pointer is cleared
during free.

Anyway, there is guard already, not see reason to add new lock for covering
it.


Thanks,
Ming
