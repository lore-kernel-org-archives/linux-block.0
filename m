Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B6156C76
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054443; cv=none; b=YTxhPvmwOLMGteFbyVQtu92JSti6OFvLHoFGZybiI0khpBHINm8ChQes4urX6NURAhNKhgOfWHKrf48NP8/pktzdPRLP0Bj3fSDEb41YqnwHGz/6p83WNQG9Uo0cVOdHLDBM9ZzYr3gPrhvzWcBVro7PoBN6SLl8S1GAseEU2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054443; c=relaxed/simple;
	bh=65qteFEhlJkfEJHajsEeIUVaNND/sMGS27EzH//MlBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWY5tNkYH9CpApNFNkMOrDeaqOmL+HkTEBb92yh3GAa4eS54q4r2Dtr9KTTwbj5r3IaNvfIggwxg11Qj1BEEnGihyvr5PRAXPjtYPX15KVzMFrNL1h7PjyRC3/QsPvf9YIyF3EJKOmtBKICeGSZg4LBE1Kw5o+fSjY5BAo1lJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qYAtXQQg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qYAtXQQg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22374f56453so85690055ad.0
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 18:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741054441; x=1741659241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sK0gfp+tfIRPtJrzvnT/QgeAtUCdjlbqmvBwODDMg9Q=;
        b=qYAtXQQgb/+k+Zwz/QWATD4Iazb35dyykPMiWFJn7DDoW+KvNMsa3DzosIyrueXtZq
         W+s89GRoUTce62mMvE5EtqPQjSUy5iWOpo1ss9bW2o3Vuvg1kzxe5yaT5C6n/ifhy+Ep
         nNUSL/gVsyz5AIXtXesjwDU6PEPMtL23SCUQQgtIw47vkHo9y4kAHy7Z6kkCM0JLsEVm
         WauVni36K0r1N5c4XdOC6uxPaWxosICdX4fC/FYy9oS6N/3kQ06IEE89S9ucOIzevdfv
         1gr1e9uNu5cJwETJU/lETeZy5VsCDlSYfBrd1xXRiEUVu4oTomKiZDIhgfU0lc7VQGhC
         Fiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741054441; x=1741659241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK0gfp+tfIRPtJrzvnT/QgeAtUCdjlbqmvBwODDMg9Q=;
        b=XX/yVUJr2Z4VrO54XupnPQy0RLAx7FTyzOZWpFfo7sIc5Rg+ZfnitmszU8DLLkPdrD
         PehKaDdTs4VMavFl2kj2pO7Qv2mV9tXFFfOLw+lh4xYLhpOY0iU6PcX+DPPRhMBDi0UO
         U7cXm2UImHS+Tr4nUvarwqX3/vkW7F8OHD3cgFPji26WNUf06BUnYvsSoOE7uHO2P/MZ
         p0mVmvC6+E7qdp1SoSLAnueEhbstl6Ob3dlA11cjiaH3i1sUQLUpH1+FYEJgQCbyOAGa
         SPhVwqVc4kjRsRVNp3a7UgX0Wp5AjtIZZORVealVyds+4EuzBpYtWJVMDCRR57qiPQdq
         N8hw==
X-Forwarded-Encrypted: i=1; AJvYcCXcgoeWgWWk3iNtVH+X05DjdJ2L25LvUDggGxvgVf/Rp/Rbkb1femeEpyZC5+r9Bco7AF0nbNmiJQ6YLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbUTyH4jPN+fCms+A/USRUJElZ4diH8jUCUoYmpefFZDNd8RU
	uZHW0ExuwuOvkvKn92YMjS+EDhnjvlOwqoe8xMVMBsJnKCfZlEu296rjCOCVoCw=
X-Gm-Gg: ASbGncsiOyPva7jIXI5S0khWYPk32ynon5pm5motVZTQ/wXy0+5/f1cHDMXUWYaBQgk
	0dCM56aWgsbc1Rtwr5iZ9KVpaIWd4JaD3tIctU7qOxbfNjMZEGHcZ7kzxLz+vDsle52AxAWE0U5
	exOIcDZE42ATtE4/ZnDVQZiovrjc91yNYXM4CDuG2VlwpcxPGo/qYlNncPRoqMua8VvxyOoFCbQ
	sCDzmHcpvWJsBJUejSKXXBLGXsOF4KSGA/5t+WbaCDtYwAY7BvsPfnGJ4ABJ9fuHyG+aJZQl6j0
	bRFfHiIb4e1UAQfB1W2JIf3S+hyLooIwTc2a6EZEK95FStes54DLqId7rM/7GtiEeQyahe5g9qg
	LRFd97S88dQ==
X-Google-Smtp-Source: AGHT+IHyS8XI7dQracLy9dzzwN9VnTebYLZcAjwtproeAmBp0VUFPFDoIsd/L7rBrZtQKzPw1kpc7Q==
X-Received: by 2002:a17:903:3b85:b0:220:caf9:d027 with SMTP id d9443c01a7336-22368fbeb7cmr225661495ad.23.1741054440675;
        Mon, 03 Mar 2025 18:14:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bd2sm84882545ad.111.2025.03.03.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 18:14:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpHnB-00000008Ys6-2dlU;
	Tue, 04 Mar 2025 13:13:57 +1100
Date: Tue, 4 Mar 2025 13:13:57 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>

On Mon, Mar 03, 2025 at 10:03:42PM +0100, Mikulas Patocka wrote:
> 
> 
> On Mon, 3 Mar 2025, Christoph Hellwig wrote:
> 
> > On Mon, Mar 03, 2025 at 05:16:48PM +0100, Mikulas Patocka wrote:
> > > What should I use instead of bmap? Is fiemap exported for use in the 
> > > kernel?
> > 
> > You can't do an ahead of time mapping.  It's a broken concept.
> 
> Swapfile does ahead of time mapping. And I just looked at what swapfile 
> does and copied the logic into dm-loop. If swapfile is not broken, how 
> could dm-loop be broken?

Swap files cannot be accessed/modified by user code once the
swapfile is activated.  See all the IS_SWAPFILE() checked throughout
the VFS and filesystem code.

Swap files must be fully allocated (i.e. not sparse), nor contan
shared extents. This is required so that writes to the swapfile do
not require block allocation which would change the mapping...

Hence we explicitly prevent modification of the underlying file
mapping once a swapfile is owned and mapped by the kernel as a
swapfile.

That's not how loop devices/image files work - we actually rely on
them being:

a) sparse; and
b) the mapping being mutable via direct access to the loop file
whilst there is an active mounted filesystem on that loop file.

and so every IO needs to be mapped through the filesystem at
submission time.

The reason for a) is obvious: we don't need to allocate space for
the filesystem so it's effectively thin provisioned. Also, fstrim on
the mounted loop device can punch out unused space in the mounted
filesytsem.

The reason for b) is less obvious: snapshots via file cloning,
deduplication via extent sharing.

The clone operaiton is an atomic modification of the underlying file
mapping, which then triggers COW on future writes to those mappings,
which causes the mapping to the change at write IO time.

IOWs, the whole concept that there is a "static mapping" for a loop
device image file for the life of the image file is fundamentally
flawed.

> > > Dm-loop is significantly faster than the regular loop:
> > > 
> > > # modprobe brd rd_size=1048576
> > > # dd if=/dev/zero of=/dev/ram0 bs=1048576
> > > # mkfs.ext4 /dev/ram0
> > > # mount -t ext4 /dev/ram0 /mnt/test
> > > # dd if=/dev/zero of=/mnt/test/test bs=1048576 count=512

Urk. ram disks are terrible for IO benchmarking. The IO is
synchronous (i.e. always completes in the submitter context) and
performance is -always CPU bound- due to the requirement for all
data copying to be marshalled through the CPU.

Please benchmark performance on NVMe SSDs - it will give a much more
accurate deomonstration of the performance differences we'll see in
real world usage of loop device functionality...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
