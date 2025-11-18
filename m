Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00031D723
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437452; cv=none; b=LI2cGPF8piUlss+ctnZDnwR2m7gNdM0NErDXK8u7bFStK5+U4sxusdRNjbyL1uYLZgilv7o9O4DvxNER33RVsFgn53VVrtPknQXEvdJZIEdBQEtW6Um3zgOcqM9mZBRxvS0XuL3d1NRdreATpHPxjEMlV+x8usc1uE0BQFNgQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437452; c=relaxed/simple;
	bh=/US2JXP4kF/4wCz3UaGOCWVf6rXm3OEtoFNFplpN7Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNO1igWD5wlq6SxQwXqofB+4eR2jBYEZlbGdC5elskvt9EddmjrED83CTYLR+Fw8WXHhqq2T6loowrSzPQ0J6I67qmQYvFLkoRdxNqdfudn5B7Rp89KUbKcuEblKzqaOjbm5FfzSSp7nCh/+/hokQKlH5AY9B0S+9TUScg0sS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GGYxNG6X; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GGYxNG6X"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so3483450a12.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763437448; x=1764042248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuMDq3EAHV9Hf5tDPdEXp65geuqpRY/9VYhZBt32+nI=;
        b=GGYxNG6XP6PdxvRpT7UTFBoyfBOaX5NoT6tfKQ4vFoqeMh5z0i6XFaAjpE97y4eWCQ
         vVBk7PSImFAbVa156SyZUJ4Y1kgFGUDFMgYRsHgoqntugYj6uLCr0ppg7PNGwyPyV6e9
         2/hUqzk45jPa14X0Glnsu53+slZnOfDD2pzu9R8Fcrw+oDrS1Vf/WRT4Dp0TK+sWKYuf
         OuhyHERNgEb5gXIj2TUrI2c9QQ8Z2KPW5WvqBQLj/Vk+CxB3bJF1iqwxFVgz8jWyJGnK
         YzZeohPPCOeEHfp8yt6U1n9VV6/e0fkaHoYS3flE+CVEFH75cT61W9zRb/sBHK5r5bve
         GbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437448; x=1764042248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuMDq3EAHV9Hf5tDPdEXp65geuqpRY/9VYhZBt32+nI=;
        b=P42HZ70AfOjAYrgSFfGpbfpG6zpb4tCNRYf2lUzrV9F50wUgiLYY6Yht/JcDteMvKt
         rqh5CJx1V8fpWAETpmlZH71+iT46wjjLBMrqP5wUpi3tsf6Fct3bOI7UugBk9UiHUij0
         2kFNeJGfG6eOoPK3WygrnsXbUxMbAoCPuzi3VfzxTntGiQf2u3dwDJKcAtbCAU7B5Qw1
         LJNamIpiSPvO1uJoTh/oYe43bgB9ZRLPWwgA0256DlSPE9qeixZqMThhjXw4OId+jszg
         qT44OUI/bqrLm8mtK1Ogdkl/zYzywbIF7hXSiOKvkRhqg2xKLsUhxYZCUBVkggXUIHhs
         J4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXv/9dEOz/Q5GozZGvX6W9ZpE2MArxy03lZuE+DN3NN8ZwE2I+WmFMZLEzWJaLaBRHSJeSVOdAk3gUsmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzXL6z0/8MKxd6uzj8FSQ1UObMgGpQDhTS1EBPhwQ01eqga7h
	yRBGjIsh1l+aI6cTBSsLO/gGh8IPj6Fi/DDUufhAHh5dhWJBDehEGpVntQ1/d0HQWB0=
X-Gm-Gg: ASbGnctCusOe29tUSRToa32e6TE0oIn7q8JR3WbA7J8OMlyPaQwUmcSXzqMyhuM2uWM
	ACzL7BkHsidne+0ZVQjNjQSlm8iATBVncPDkSVIjljeHLxa1pAJTdLXDrC5JvxaGBp/mpEMmOzb
	0RxmiOk/zdixztLtF3g3CuM9Dmmme1JzrTXC0ytq/+bGYo4eR9QRGTtp7CZyYN90xODvqiPNdSr
	wKfeX4sAN8YLFzZjw4XK5CW5NIuAzZsq7HLCh7SuRDnj9EK+RoIQxkRU4t3ZV0Jl6XxYZzEzC0l
	zcNXOQ0NKbaRPpIHJT6FMNxbHwhC+f87LgiWPN1+I68Lsn/VOhhhYrrk/ICcIaw+GYGtDSSLVi7
	jKT05SGstxfrm1VsLATpwpzlfo6pcSCZqONyOTOq23nLGvRrueyYPL4unSJZOwESeEeZ8ofnKor
	h/MYCLBycitFBqrmdT
X-Google-Smtp-Source: AGHT+IFfQz7Ek6tvG3wigeBakizxwVFmYJ3H2HNKhxbtlVrj11hKdPLnYxrjN2OWgodPVTXUuCGF5w==
X-Received: by 2002:a05:7300:e607:b0:2a4:3594:72da with SMTP id 5a478bee46e88-2a4aba9f1a8mr6635089eec.9.1763437447193;
        Mon, 17 Nov 2025 19:44:07 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2a49d9ead79sm69675621eec.1.2025.11.17.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:44:06 -0800 (PST)
Date: Mon, 17 Nov 2025 19:44:05 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251118034405.GB2376676-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
 <20251118021504.GC2197103-mkhalfella@purestorage.com>
 <aRvaXFA9mG2WDIXA@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvaXFA9mG2WDIXA@fedora>

On Tue 2025-11-18 10:30:52 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 06:15:04PM -0800, Mohamed Khalfella wrote:
> > On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> > > On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> > > >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> > > >  				     struct request_queue *q)
> > > >  {
> > > > -	mutex_lock(&set->tag_list_lock);
> > > > +	struct request_queue *firstq;
> > > > +	unsigned int memflags;
> > > >  
> > > > -	/*
> > > > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > > > -	 */
> > > > -	if (!list_empty(&set->tag_list) &&
> > > > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > > > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > -		/* update existing queue */
> > > > -		blk_mq_update_tag_set_shared(set, true);
> > > > -	}
> > > > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > -		queue_set_hctx_shared(q, true);
> > > > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +	down_write(&set->tag_list_rwsem);
> > > > +	if (!list_is_singular(&set->tag_list)) {
> > > > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > +			queue_set_hctx_shared(q, true);
> > > > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +		up_write(&set->tag_list_rwsem);
> > > > +		return;
> > > > +	}
> > > >  
> > > > -	mutex_unlock(&set->tag_list_lock);
> > > > +	/* Transitioning firstq and q to shared. */
> > > > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +	downgrade_write(&set->tag_list_rwsem);
> > > > +	queue_set_hctx_shared(q, true);
> > > 
> > > queue_set_hctx_shared(q, true) should be moved into write critical area
> > > because this queue has been added to the list.
> > > 
> > 
> > I failed to see why that is the case. What can go wrong by running
> > queue_set_hctx_shared(q, true) after downgrade_write()?
> > 
> > After the semaphore is downgraded we promise not to change the list
> > set->tag_list because now we have read-only access. Marking the "q" as
> > shared should be fine because it is new and we know there will be no
> > users of the queue yet (that is why we skipped freezing it).
>  
> I think it is read/write lock's use practice. The protected data shouldn't be
> written any more when you downgrade to read lock.
> 
> In this case, it may not make a difference, because it is one new queue and
> the other readers don't use the `shared` flag, but still better to do
> correct things from beginning and make code less fragile.
> 

set->tag_list_rwsem protects set->tag_list. It does not protect
hctx->flags. hctx->flags is protected by the context. In the case of "q"
it is new and we are not expecting request allocation. In case of
"firstq" the queue is frozen which makes it safe to update hctx->flags.
I prefer to keep the code as it is unless there is a reason to change
it.
