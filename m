Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271F5F554
	for <linux-block@vger.kernel.org>; Fri,  8 Mar 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932602; cv=none; b=EutcCaDuReWtxhe1eUl3nfthoU/UJx5FARlb9JwstljOQT9sB+MBeykdHmfMlAEOoTa2noedCOipxoa5B+g4XX3qZrn6++qzNUVLNQ7rGiFwkUEeMU74Cn/f9x0Wx+cTAEfL7P4B6hCBOHHTFOTq3WDM7IU29BMt0STfa2/sFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932602; c=relaxed/simple;
	bh=IenFXebXJ4regZ2xtu/rDq0RU983nSAZ/6TT2IWaaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCE/4KOzpaSykkmV5XaabgvYZf2wBgy4nfmPXlXXI1y8z0HefszqhkOM3U0Th9SbdR+CfI1rZNvVY5PsnyIH4ykuKEUgXsc8d67+ITFkhNlO8roDhE11BQVGR9AfCXzvAscNUP4g3nIrP9abXbb2jAldc22DdgrOhzOzx2rzbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ut4Q5ctH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ut4Q5ctH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so21444905ad.2
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2024 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709932600; x=1710537400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr9eYKTRVVDN7ldqya3Dbl7nbSqPQXaDetUbrNqdQwk=;
        b=ut4Q5ctHP9/qT9IOZ8holijo/71/xddcJohucWPaOdiYplf6VsaurFfDvgmh1YlLXW
         4hSeO9v3Sr/0W2LlaFXgqhg6BZ1WdY03A17mASTHoyDgIa3zV9BOr6ZKnxoa7aqGzP7u
         43OBQVXr9TjXh3n6jiYOgEGui87ozEKfKm5Kp5zcVaMiHm/lEdojviLIff5QP2hV09ZY
         Itio9iwPW1ke7IDka6wBweb1DR/UgkoFCFDz37sSZ4Myw1WEEVNx2X7WLHLoB5+KwPrf
         5KIcuii/y9X+cdlPsCNie6ebWJZNAz+9LupfuXhFvEeeK2P5EGbF72z+zkWcPzDvNOxD
         LNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709932600; x=1710537400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr9eYKTRVVDN7ldqya3Dbl7nbSqPQXaDetUbrNqdQwk=;
        b=Yv/SZ+RxsuiDLfpzxLGaIylcaJAc3EC3v0QPNyrCK7wvcdA1pIxWzhoy6ri81ztFwp
         sLKFIYdtOT1H6RKtXyt3EIE7T3eRUfExpluhz7j5lY2nEiZxptUH/ipz6cISc46kRJV7
         ztFxBpX3SX9f5KUeDTVKon/3bT4E0Riv5BbaU83GhwHy7q/ihpX+tNsW5V14MOvp+L7Z
         R1xPvWx68drNmgd2l6YciHRtN3coVFD0B1DkcnTZgQaizr3Nt3fo1BjEmUMXv0LpjBmM
         dKEnkJtrDsB/swK+0xm8bXGuEHExqkvVf54gLWAI9VByiuQFoBI6+0YoLCAmmqEXiDBW
         FI5g==
X-Forwarded-Encrypted: i=1; AJvYcCV0Fw2Bh3YojyX0s0omAzTiLfriQekDwDFWZ/W+yUL195i+ZHN6BNhfR6B9PpuR0Wek9/UIgGC3D+je8rMLbEoTAKa6Ts0hddxd57c=
X-Gm-Message-State: AOJu0YyaalpIXv7KF1iJXk0tH+mmswh2d/IfhnDlWY6LUzrskpyS7LVt
	0dKjIgVna121Gu5oMYMmoSI7M7D+DyyepdLR0aXPR/RIgDU5o4Zaq3+rzJNYGB0=
X-Google-Smtp-Source: AGHT+IGC5toWvVymL2e4YI/lheIXtWwXJD0bcxn5Ysx/cu1diLDacyRuT/F5EyLXKOmgYPFjhR64QA==
X-Received: by 2002:a17:902:f551:b0:1dc:518e:45b7 with SMTP id h17-20020a170902f55100b001dc518e45b7mr343328plf.49.1709932599964;
        Fri, 08 Mar 2024 13:16:39 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001dbcfb23d6csm83177plv.267.2024.03.08.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:16:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riha0-00Grxy-1h;
	Sat, 09 Mar 2024 08:16:36 +1100
Date: Sat, 9 Mar 2024 08:16:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/10] block: move discard checks into the ioctl handler
Message-ID: <ZeuANC+r7TOSGHmd@dread.disaster.area>
References: <20240307151157.466013-1-hch@lst.de>
 <20240307151157.466013-3-hch@lst.de>
 <ZeoylEeVMt2fXT2R@dread.disaster.area>
 <20240308152244.GC11963@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308152244.GC11963@lst.de>

On Fri, Mar 08, 2024 at 04:22:44PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 08:33:08AM +1100, Dave Chinner wrote:
> > >  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
> > >  		unsigned long arg)
> > >  {
> > > +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> > > +	sector_t sector, nr_sects;
> > 
> > This changes the alignment checks from a hard coded 512 byte sector
> > to the logical block size of the device. I don't see a problem with
> > this (it fixes a bug) but it should at least be mentioned in the
> > commit message.
> 
> Before the exact block size alignment check as done down in
> __blkdev_issue_discard, it just moves up here now.  I guess I need to
> make that more clear in the commit message.

Ah, eyeball pattern matching fail on my part - you changed it from a
hard coded '9' to SECTOR_SHIFT as it moved (which is fine!), I just
missed that. All good!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
