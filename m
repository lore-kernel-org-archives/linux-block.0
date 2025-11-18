Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EE2ECD1A
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431660; cv=none; b=Aw9P0fP7ZMN91IIwyNmdXWHeY4ckiBLLNW/Hq8V0sih4p10OQtRXaBlGWkE9eL7uSiUaK96guOL9p2KATs9mkDqdRrnjot+hIb4sptCbIVH+J8P8DlbMNL028rjdurd8IM03Rj6ionBr14pryISeOGuE2XJH3dzTy/eVTCVHl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431660; c=relaxed/simple;
	bh=6P73Fu2n2ybgpsjg+frMe8gtm50pWSpVSEfs0WoHSt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELfOAjRdsqm9zpBSyooH4vujg2ZIwZf1bYkXIWLoyf1AJ4iXD8fyKEPeGAbdkNG2r+8SFYk/GxwobKG8UasYvX3mjz+4r5lNJkcGKhxRuDlmdS94ITxqdGE3zzHShb/Wvnb3ocXZwRNxEsTrqGMKv6yRqzefXqRdwf0nM52yS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NQgwTUdj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NQgwTUdj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso7353438a12.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763431657; x=1764036457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S97KCJ0/M+iebNYM5SPjKQEoYZVp3EkSmik6GozuJgM=;
        b=NQgwTUdjsWEVevkgCp19cjP5jI7BTCR2IvRwsDks7D4gFmo4rGOuQwsXD4/q3gzeF7
         mEGuHuVfVHmESOzxEfNiISrGnDRMAbtgCQonQPY+lSFZKu7sHyfv6jmoyMNoUk5T6J/1
         bwbQa6AA9k0uv2WeYkY1x9oEsCxtsh1Aayq3Ek0VvmEqihr1SgNlgmCwYa/ED/xc8/Jq
         sJR18iUESjbNbSSi2kgwvYTfA84u/4D2KXvf2oWkkLGPHjUvn7Q0qUlJHzFwGyy826G+
         zuS+wqXs/xMibb7WR8ZF3FVXWyvuQJmhXPRB/XXA4elSX3cB7+YjFZepCLYutasznMay
         hxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431657; x=1764036457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S97KCJ0/M+iebNYM5SPjKQEoYZVp3EkSmik6GozuJgM=;
        b=eWy+cCIwYKNlViNKZzVK4t8n5c4QBnOof4y424VjEFgf/YFdOO8+krBffhY8R7w9WJ
         VR3bD1jLba9JWKbUyJixz0QMoYrAXdzvHqcl+gjC1yuH2bUS5rUKc594FwVgqw2wsiUo
         A16Yoy0cfwNa9VT9EfN46eh2M7/u2VyunYS2XAhQu+xstDfffxlJicrvsaUzIpfXmdnX
         nVVgP2ifjVjhRdHyM/582F2UhOahwGeP42oWIDFHesOtPUb7RzI16tyUFkq7NPaUsdrz
         2k+XdJmLc22BL7fw4ejTHMEL/s9OWvC6UfUI+yDC2+eYztzb4uz46doVUw4SAkmDgZhq
         do+g==
X-Forwarded-Encrypted: i=1; AJvYcCVCybuZKYrQJwcUKb4wCb/uNfmQu5OwPWaN0LaZQmZOiVPuGouX+C0GmTsXyfyjb7lU5v7jvVzqixo/UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgv/ELB9UPDH0NwyV2+Pj6j39ClFSOaU746Ad6M1fd4ruKq5D
	vBNQVlbrQNcOc4ulEyDEcqPiVpbfTqfvt1l8bxhw04mfTuugqAFleuS9CWR1kpAeTtA=
X-Gm-Gg: ASbGncunHlAtDxVmJ5LJO00HB4cjQHsyTKryiGg0ZZvBt0+0PhxHLK/FC7AifmGZ8MY
	O8ghouxBbfnOGOA8KRCjeKm9gidIs9ckdTFpSIMlAryqguWEwJ1YnRowOhel/FwfK429Fepegn7
	6C7C5IHLQoUCG+WznAnXp457X+Mm0uOTXChwidnlnYqM42gl46pz9Uo+/O5guRT70LlEK4yGnDP
	zK2g4OBwzX7jCR0jY7dzefkIVLrisKF53P/R+WtLzR0RrrMMrCm8ZOU+16/seRLeGTOf84ubZx+
	vDGeL4up7Ed6G8vA/YUUgfK7OGlHUkx/JxXRjuIsv7FVFL0RgOGwTvpu/vUwwtZLmL3qurehnA6
	p8Fwr1pq7yCBoiLbI626H1FQfVenJj8op7mnlLjNGN8e0S8oc40li3WSectl3cMmYwfxemS3Rvj
	0JHWc3uZC/B7UxcHZZIyr8KgXjTj9psbY=
X-Google-Smtp-Source: AGHT+IFbl3JzHP+VT8lA2rcee7YupyauKZyKg+dpdXz8GrX8My5LD9qHQc9USZ3iiBkLaLHMiT9+uw==
X-Received: by 2002:a17:907:6d29:b0:b73:8b7f:8c48 with SMTP id a640c23a62f3a-b738b7f8f60mr843574666b.37.1763431656972;
        Mon, 17 Nov 2025 18:07:36 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b734fa80cb6sm1224468466b.7.2025.11.17.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:34 -0800 (PST)
Date: Mon, 17 Nov 2025 18:07:31 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251118020731.GB2197103-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118013442.9414-1-hdanton@sina.com>

On Tue 2025-11-18 09:34:41 +0800, Hillf Danton wrote:
> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
> >  static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >  {
> >  	struct blk_mq_tag_set *set = q->tag_set;
> > +	struct request_queue *firstq;
> > +	unsigned int memflags;
> >  
> > -	mutex_lock(&set->tag_list_lock);
> > +	down_write(&set->tag_list_rwsem);
> >  	list_del(&q->tag_set_list);
> > -	if (list_is_singular(&set->tag_list)) {
> > -		/* just transitioned to unshared */
> > -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > -		/* update existing queue */
> > -		blk_mq_update_tag_set_shared(set, false);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		up_write(&set->tag_list_rwsem);
> > +		goto out;
> >  	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +
> > +	/*
> > +	 * Transitioning the remaining firstq to unshared.
> > +	 * Also, downgrade the semaphore to avoid deadlock
> > +	 * with blk_mq_quiesce_tagset() while waiting for
> > +	 * firstq to be frozen.
> > +	 */
> > +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > +	downgrade_write(&set->tag_list_rwsem);
> 
> If the first lock waiter is for write, it could ruin your downgrade trick.

How is that possible? If the first waiter or the only waiter is for
write then they should not take the semaphore because it has not been
fully released yet, right?

