Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA623191BF
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432112; cv=none; b=o6YlLsCrX3aLgNFQln/uzPQgNPWDfKqSF6LPAlSaQp39F/wSaQttYVbQ9B9Bu76/Ae5sg9TYLbUCnd+e5LXr+LkBWWsrG4oAipB0gFvagcUcbgoP1gt68iCdD1hwL2OZmJJS336RPMaI6WA7NBMH1VXi/WHyg9LXbFfxUHlwxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432112; c=relaxed/simple;
	bh=PTmflmZ59yq7+U7Q27EQQY5SOqnJPJ7iSnqD/TNYnyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXQvXkjWhpK5MVOPft0S7JSkqhHY7eiCibiGZcrdtlFBrpCyZ4Sq3u0qQ8ss8bEx7fayckfjx1hFv89IncO3SxBd4p4IvfsdmEqcPrnfgVHStv6z9dpCO3DlqF0dMjmmVkJoyvreKezZsNRcERbU6WcOgHQfhmneiLlXBZSt0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FYItVq/I; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FYItVq/I"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso8079092a12.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763432109; x=1764036909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGMa27cxj+L83AG/Ch3KZQsv3/A1P3JcCisXJsT+KB0=;
        b=FYItVq/IYRr5/PlF74fxY+h0jeajipVGhTuOwUwIzu6BG1HbNR2gy+DDolGzIqoIrL
         Uulhac2nYyXLxGTNkiosUJBd2LuMd2vfagmOoUWn1GV81xUdWeVbWw5fM+LL2cp/uvPZ
         qhT0Hju2mogwmeONZwL4k3H2xaSieNtv2Xc/Xbku/2pCQI7q8s/UFp2nKg6OaXaMXRJI
         Tqv78WiL5QdQDxzsynnT5pgpeGIaB9bkFJv0p2Xd3xQ+/pI2d7v2Zc2I1zo7go7ItKdo
         FnqntG3+ihpT+v0MR5ictZTJWamMv/FpWQltAskePBiPiiIb2J9N2/HR/+2FHq6ydv97
         9hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432109; x=1764036909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGMa27cxj+L83AG/Ch3KZQsv3/A1P3JcCisXJsT+KB0=;
        b=Tg+lVFSnPksvAIE/1gFIKmaeaKwPugSoNtAgXoMoTIkdc13MlJCey0lXHAF6WanrQe
         c2HGTgtBSoR14v29Uy8Cqxv9I9bDlivyNGY7V9kKQDm/4aYZJFd2v6aOJAItqEnVCpq/
         md598F3z5ZWoTIc15Ds+7IP1zpUoYoRNo5m0rxrTj6iC8DiFC4bhjo9/yQlJKkYFK6L6
         bC5wIc6e8oQOa9t1efZ/g/PQ2/upPqrO/k1ZnIk10W49Ff1caqZSFIoBTDjcTX9uWxzG
         EVn7uDiMJReeQhx05IHVh76J+cZk+bR9tY7USVQB5GFFammYO4MnV0FIv7HhxJB+SAVq
         xdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxC1Hax8PcmdTH8JltajvGtevvMtOz5Au6+rvEnaINgxxqfgY9mco7pIPpFK7eKdb3ra6algoc0yEuLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UvcJIzk+5G2R3B0x0D05DO/YZbEfiro5f8nvFxVxJKoAPtiI
	YvZpa1pgD1qOeOFKZrjxoPT2JGnwJj3Br6HVhhgXj3njaz/q16Csh6hklzuPOWu63F8=
X-Gm-Gg: ASbGncsJBOk92P9i4V2f9lP9MMtqMB3CFMJ7zhEjMBUEUk0YCv2HzSO14C/85c+jAfb
	1nb9+PF9YRZco/Z2op1MnpIGUgTi0guaQep3WG4RR+iUjASlow498BIrry6t5Rn5DCNz+IY4I+A
	iTY+xElfq/JSSWL3mmRJK3EyrMqSkZ5juSzOzyH5ahG68wj0sTVdR30yCWEmZ2BLs+zB+iL6Ttf
	Xz2BRD6apL7mBKze3uCmJwWRCi9P+4D6nfL7inzkMXL3o4al3853RsLO7L+wJpwPC1KYqVbHdzc
	j8mpHrAW0T7UXIERz8YLtyflSLyoLNineaSDd7LhgBKDeoe+BlZafr7syK7dFx3lizFNjLswVb8
	YIsiTSWfEH1qYdGFg5z2mZ9yaAAvnEUk88fXSOu1YEbAV3M6IcPG8HuA9A/GHYxQdWUfPHvnl6+
	VUNTwou4nDwivOALi9tAFTEM3YanS7OnZ/tx3yCYemPA==
X-Google-Smtp-Source: AGHT+IEhsxRqYMWn9WCaeLlWRezRAzHORagLlYnSMXZULZHeBeD6LLRB1gCGYfGzQ1H6NKdpdLyKDA==
X-Received: by 2002:a05:6402:5112:b0:640:a356:e797 with SMTP id 4fb4d7f45d1cf-64350e2092amr12555421a12.13.1763432108722;
        Mon, 17 Nov 2025 18:15:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a4ce83dsm11546963a12.34.2025.11.17.18.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:15:08 -0800 (PST)
Date: Mon, 17 Nov 2025 18:15:04 -0800
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
Message-ID: <20251118021504.GC2197103-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvTM5LbnehQU77-@fedora>

On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> >  				     struct request_queue *q)
> >  {
> > -	mutex_lock(&set->tag_list_lock);
> > +	struct request_queue *firstq;
> > +	unsigned int memflags;
> >  
> > -	/*
> > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > -	 */
> > -	if (!list_empty(&set->tag_list) &&
> > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > -		/* update existing queue */
> > -		blk_mq_update_tag_set_shared(set, true);
> > -	}
> > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > -		queue_set_hctx_shared(q, true);
> > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > +	down_write(&set->tag_list_rwsem);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > +			queue_set_hctx_shared(q, true);
> > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > +		up_write(&set->tag_list_rwsem);
> > +		return;
> > +	}
> >  
> > -	mutex_unlock(&set->tag_list_lock);
> > +	/* Transitioning firstq and q to shared. */
> > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > +	downgrade_write(&set->tag_list_rwsem);
> > +	queue_set_hctx_shared(q, true);
> 
> queue_set_hctx_shared(q, true) should be moved into write critical area
> because this queue has been added to the list.
> 

I failed to see why that is the case. What can go wrong by running
queue_set_hctx_shared(q, true) after downgrade_write()?

After the semaphore is downgraded we promise not to change the list
set->tag_list because now we have read-only access. Marking the "q" as
shared should be fine because it is new and we know there will be no
users of the queue yet (that is why we skipped freezing it).
