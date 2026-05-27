Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24B372ED3
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850860; cv=none; b=B2aCyUFkJC05RIwjCa1EQRLdROeyhNu14I0NiXXkLsNAXd7hDn5hChdGKVRqjoQx0xtAlFh634pBmTvO4eRjYuU5J+mubX2dJcIxJgRc5jZJRMLXuV6IMBrfbawYN28c+IW6s1eFtWNKbgAaoDr97VgP5Pfg1CG0+zR98lxHEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850860; c=relaxed/simple;
	bh=l24Cx1MrKrvp4Q2cUKmT1CDQC1RwyjfAflDdCsjh3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZV97ZQPifMUC6VDbHBKwg8mE8+srS79wQLXklb6mhh2t6z2YUwGpKyIxfB+1ZIYwjyVeEM9PiXaKUOuuXZvvuUBOQOBfPeUoUlIjH9bHThxGTVJbZqKeVq0eNysyBV+/odOdnTRAaN299eQZ3uLoO5tgSlsEzAEHP19x67AX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otPOjawa; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otPOjawa"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b7105dfb35so145627376d6.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850858; x=1780455658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LW74ifQIEMw9K0LJrVq6jLhT79y6ZRMrtmCmy57465k=;
        b=otPOjawas0BUAfr7T7mWO/WO2cE9MqQwXaLT1vnDh7uBqVDWlQ2LzgkXovUMs3I5xK
         hI3emTeseBOhS4+I7/IBi8+P4GZ0RxFZKb/a5WvujLn5k6v/34AmyenTjzCeCdJbg32T
         mlHQ0xigGqGFb8VGAkB6pHqB0l7XbFEqw+ETuaIqQHKYCvP6DXRofuaFs4/aeANIvPDH
         de33rYv4z2KOJcLwuM6+TeylcJmBEaD5T08oFieNjlNn494zPrLIe8rGNP/N6tPOtPG5
         2WE2mrnc6zEJy8CYtxH4udIJGEDa4kVLTsM7U9McNlfe95D/MytXxo5sO4VPh+4uVCiD
         eLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850858; x=1780455658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW74ifQIEMw9K0LJrVq6jLhT79y6ZRMrtmCmy57465k=;
        b=PyxuyLeWSNMY+GHVrlqmKAM3eQgpy9z3DSroSOy1f8HVgex0zdPYEZgdieF7PfrPFQ
         l2vCJLDSoUhkFRxPh7Vkty9shjo3VCGrFi00LSVYMypiMpgrC3pBOx4EpacpqTXGJYK7
         qbM3HgHIiSc5iEn39QIaCMpjhiem2wm4VIBnOaqibA6XYDfuIQBV+oLpAb4C4syujATp
         TeyBtBqP5QfbDnrilyeTx9TpcHrILAqFCi6UoynG+p0yogfA5mRxKAWdJrwPmp2n9Xs9
         IGcA5H/odda/ZSVBpndh1QGlyqCrP6VecCLHpHhSV3eynbfTpr3nHsCHbPA8iphWOs1t
         kNOg==
X-Forwarded-Encrypted: i=1; AFNElJ9OGKqqVd0/JqB5pc1b0tbigp+mcVkB2Dpzje2nmcUkNzuO1x4dPoCsUBGbi0DGgdIAj8XyM9MV8gPIow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZiFCRGs3hIzEfPmcDtilOo4QYqifl4bALaPTGKVzcTCeQNcC
	21rCWoc5JM0Qn3EKqBXVYqoqMHkMPxcvKjZtIAe/2lAo+K3i9hgNygM4
X-Gm-Gg: Acq92OGTINBNrObKx3zCufSCe9SaGqZEngPHvjALzF1p53gTwHlXTnaqU5l3VtuHU3w
	EH49jyjlmN62MbNsc6rcKpkDiOoQE07tCZDpvoBNqLJT7ZQyGbrrrusotDDm9QWoUAR9RihzLIv
	LvMr7HI6GTqfXKFGxrS+F+xYCFseX5kx22AF/6d912cbJEwall2FMIlX47hHjuaNLxZqGrBnBw/
	bFf9XD3bACHI0m3LecsN4znO2zUHltcYTU2XvG6eEKd3FcST8pSxnARIUHXpomezY5Zt6hpOW7o
	63qs5LJL5eLdcW8p0nVNTGgQpDL5VlZjjD1mNhfX8m+EkcIHLxtjP1TLyJ3He8fQQZmrAmMNpJZ
	FbAtNA29FgA4XTg/I6qZIO18r2T6FzCFhDMhvonp3WLbRTmgUWQQFpnTpnwyQRyPFvDGHn//xUH
	RwG7HQSEWqH6eH7BsrOnbr8J7tiQjhbKEpuTjM8fr25saKNYSukfB0RbibyfIOEs+L+i6Y3NRsk
	GiJs1lzmOmqfhpMRE/9FQ==
X-Received: by 2002:a05:6214:5093:b0:8a0:3bd8:5950 with SMTP id 6a1803df08f44-8cc7b5c0bb4mr338124896d6.23.1779850858174;
        Tue, 26 May 2026 20:00:58 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81302a98sm153788216d6.33.2026.05.26.20.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:00:57 -0700 (PDT)
Date: Tue, 26 May 2026 22:00:49 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ahZeYQ0cLE1i8TGs@fedora>
References: <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora>
 <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora>
 <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>

On Wed, May 27, 2026 at 10:35:56AM +0900, Tetsuo Handa wrote:
> On 2026/05/27 10:20, Ming Lei wrote:
> >> Of course we should try to figure out the root cause first, but how can we do?
> > 
> > Definitely unexpected write IO(after umount & loop closed) from btrfs is more serious,
> > which may cause data loss, so CC btrfs list and maintainer.
> 
> Why do you assume that the culprit is btrfs?
> 
> https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 indicated that
> this similar race is also happening with jfs.

I just didn't see the above report on jfs.

It doesn't change anything, the same question still stands: unexpected write IO is issued
or crosses umount & last closing of loop disk.



Thanks,
Ming
