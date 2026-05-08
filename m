Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89918EFD1
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208009; cv=none; b=kdGJ9nnDBtP3/AmoD/b3McL06xE+ZEz67xj+HbJ+isKWQUNrN0d36r114Oq+0Sk3ODl3d3hNzst9QGz3keNtNBkZmdEC9qwpaerT5kvRzXV3xBPGuK7AKfpiRxJ6F8ej3paKKwsAX/AgGbBklV1tkISrQPDf9O8o/oXS86H70Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208009; c=relaxed/simple;
	bh=cRRUJ15AsoPYdI6y/ghArfrGQ2ztB9tme1uXn13cHSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edSrbGnTmAy1zgvcqHMKiU4apG3nz07PxPkVydpz9wf8cEywaW8NfPnBlb0X/ifLrMgQIjajwMXbff4cHrpYnqwBE5RPlfaPdazMmm/QRkM8l934qyKV1msfes9sCNbBkCe1ycfA62gX3qZeInkE0slkSzzYZ07wzNRPLuMRdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=heoVFtad; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heoVFtad"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-838d0b7c950so981629b3a.3
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778208007; x=1778812807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgIxBzyqVLhoNqsOJWVNuFvzEo5Cnm2Tdi9qM5pIjSw=;
        b=heoVFtad6tqmZlC2Vom8OVWpm3MTStjeCVaZgUUCK38Muf9EnyTYrRb1Z/hcOCyahb
         WdAygYmzkx1XXKKjIxTddpqtj8DQP5TX+JiPIyK+rnveC2c2WdL1n4OT9yxBdqCOG19G
         5nXMaWyr0L+2AKtn4NxBILeARmR2zZxFcZfj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778208007; x=1778812807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgIxBzyqVLhoNqsOJWVNuFvzEo5Cnm2Tdi9qM5pIjSw=;
        b=OJHhfyLK4x4ecB+cPPxuJyk6h/ysMAtogTMKe3QkvLDNbr3TRZswSaSk02C/CeD9v+
         G2cqo2vQmS/a4+YAVZ8FNuD5Gj2cy3slEZUyd0SISZFvMdEgOO7sN3BRUU04NPaR3Djs
         6z3Flgbsi+dyeqbRKUUVQ8Nj//6BGMgmqWUN9DQz4C4MfVpQSRFGX6ILsLE14Aw/DWGt
         qZdA7GsJPV2g85AA6NGIc6GmyS+pJ13x+tE/PPVkWYW9w5LTMKYS3tEFpLDwQZUN5QpX
         SbXl9z8GOpp/COnqSh/SBxV3CzgH2CBlrXG1skPQX2K7PTTOVthfuJkVCcLR7sfuZV23
         4sdQ==
X-Forwarded-Encrypted: i=1; AFNElJ91jWsgHM585HqMLfJINh2cqp9QsW9MU3hx3qQyUjWuN1uxk5TUSSegnXhes0GBGX7+RAdn+X4TYrHskA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYo/VA/tZMqSoqPjMOXFlZaEcM3EOh8HBP8nRLBZEl9QjNmEWv
	PTeOE2MsGgk5slYyPHkoyy1DuI/RgR8zTezJIrB2mj9w6Y3yMKvjVtAhVLRkbiYR1w==
X-Gm-Gg: AeBDiesbRn8uK/43xK+vJaCWYbwgcLG78ENrgIZ/3PZYnXJZ6SZ2WJ5ULqPoaLvGRWA
	7j3y0mXtHVvQE42rKfPdDXX/yWJ80ojHWI6ORZn/vI6lSdppw/ac62V2nhXkdV6uRVvlJKR6klq
	MJPLZwBt78ggIH+EefjsJkbcuCi9HTt0vWspwUp6eR5/KD2w0XbMKZ1RrfXvOpIcFDXnT7PzkmF
	p/nYxbBHM/1xq6h07K7bKrI9MUvOKcNrAge4rvBBHNoa9Cb3BVqZvl3EOgPOYO6rs3radQfx9oh
	o4dgMOVrsiAgWd/2jqzvIOREt3pXVneNCTU29wlP272TFvmrpzvaHSRvpM5q+dGDRYMDkZWkVZG
	coUwluKMTEGuKJFi/6D+PL0DNTrlabSI5xQLP3uBMdLcheyX8xSa455nBtgm/TCTmwqWY3ITPf6
	Z29sW0H3Mcl+uZW+YHrn9cAU6e7GIJo7FyFZNL2oaNacj+ywHfz2/tiKjX864fzkw=
X-Received: by 2002:a05:6a00:8e09:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-83a5d873ebemr10437527b3a.29.1778208007495;
        Thu, 07 May 2026 19:40:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7ba2:1dc2:ed3e:1484])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f111sm10182262b3a.4.2026.05.07.19.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:40:07 -0700 (PDT)
Date: Fri, 8 May 2026 11:40:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Richard Chang <richardycc@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, liumartin@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_writeback_endio
Message-ID: <af1BNwmyHK6aU_uT@google.com>
References: <20260504123230.3833765-1-richardycc@google.com>
 <afoc5qLvK2PDQKb-@google.com>
 <afw2919RiZje9xzq@google.com>
 <af0YtJOLGvO-LJow@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0YtJOLGvO-LJow@google.com>

On (26/05/07 15:56), Minchan Kim wrote:
> > -	while (atomic_read(&wb_ctl->num_inflight) > 0) {
> > -		wait_event(wb_ctl->done_wait, !list_empty(&wb_ctl->done_reqs));
> > +	while (atomic_read(&wb_ctl->num_inflight) ||
> > +	       !list_empty(&wb_ctl->done_reqs)) {
> > +		wait_event_timeout(wb_ctl->done_wait,
> > +				   !list_empty(&wb_ctl->done_reqs),
> > +				   HZ);
> >  		err = zram_complete_done_reqs(zram, wb_ctl);
> >  		if (err)
> >  			ret = err;
> 
> I understand why you used a timeout here, but I still don't think it's a good
> idea since the user could wait for up to a second unnecessarily during the
> race.

Well, sure, it doesn't have to be a full HZ, we only need to wait
for propagation of atomic_dec() from another CPU.  That's very fast,
orders of magniter faster than a full second.  Just saying.

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a324ede6206d..28ab4a24e77f 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -33,6 +33,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/part_stat.h>
>  #include <linux/kernel_read_file.h>
> +#include <linux/kref.h>
>  
>  #include "zram_drv.h"
>  
> @@ -504,6 +505,7 @@ struct zram_wb_ctl {
>  	wait_queue_head_t done_wait;
>  	spinlock_t done_lock;
>  	atomic_t num_inflight;
> +	struct kref kref;
>  };

Yeah okay, it overlaps with ->num_inflight, but we can live with that.
Maybe can get rod of ->num_inflight in future patches.

[..]
> @@ -864,6 +875,7 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
>  	atomic_set(&wb_ctl->num_inflight, 0);
>  	init_waitqueue_head(&wb_ctl->done_wait);
>  	spin_lock_init(&wb_ctl->done_lock);
> +	kref_init(&wb_ctl->kref);
>  
>  	for (i = 0; i < zram->wb_batch_size; i++) {
>  		struct zram_wb_req *req;
> @@ -985,6 +997,7 @@ static void zram_writeback_endio(struct bio *bio)
>  	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
>  
>  	wake_up(&wb_ctl->done_wait);
> +	kref_put(&wb_ctl->kref, release_wb_ctl_kref);
>  }
> 
>  
>  static void zram_submit_wb_request(struct zram *zram,
> @@ -996,6 +1009,7 @@ static void zram_submit_wb_request(struct zram *zram,
>  	 * so that we don't over-submit.
>  	 */
>  	zram_account_writeback_submit(zram);
> +	kref_get(&wb_ctl->kref);
>  	atomic_inc(&wb_ctl->num_inflight);
>  	req->bio.bi_private = wb_ctl;
>  	submit_bio(&req->bio);
> @@ -1276,8 +1290,8 @@ static ssize_t writeback_store(struct device *dev,
>  
>  	wb_ctl = init_wb_ctl(zram);
>  	if (!wb_ctl) {
> -		ret = -ENOMEM;
> -		goto out;
> +		release_pp_ctl(zram, pp_ctl);
> +		return -ENOMEM;
>  	}
>  
>  	args = skip_spaces(buf);

So I think we also need to do kref_put(&wb_ctl->kref, release_wb_ctl_kref)
at the end of writeback_store(), because otherwise it just kfree()
wb_ctl and we have the same race condition:

@@ -1330,7 +1340,7 @@ static ssize_t writeback_store(struct device *dev,
 
 out:
 	release_pp_ctl(zram, pp_ctl);
-	release_wb_ctl(wb_ctl);
+	kref_put(&wb_ctl->kref, release_wb_ctl_kref);
 
 	return ret;
 }

And indirect release in init_wb_ctl() as well:

@@ -895,7 +903,7 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 	return wb_ctl;
 
 release_wb_ctl:
-	release_wb_ctl(wb_ctl);
+	kref_put(&wb_ctl->kref, release_wb_ctl_kref);
 	return NULL;
 }
