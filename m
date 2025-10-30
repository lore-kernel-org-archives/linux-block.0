Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B82BEC30
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861769; cv=none; b=Uhhh7xcZJYtiXm+KNw8D4dsPTkC1CbEZHFWJeEB6cVXdVKhCwLN6sgtQnLWpOLZufupbFejWkekt02+UQGguGUVO3HW036YAp6SuiBWm5d1KMPjPTQ0KJgPws+bUbOerGXKtuaOXmOFbBMoPkjWIKE2tmGuYKtp2XUIyWCHD6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861769; c=relaxed/simple;
	bh=UvRyiZNqMNUKokDlWDsbCD3weBxD2oq5vMb44qnepsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZrbXlzYFq73m7XkqMHSndRG0pXlu3Bqvv0UcV+/tnUKyHbdtss8FNV5um3l9svBjKvMojX2Yf+wnjcfA2gtNqigJjygxhXPMJcWFOZqL0HyZk63rto7A0Ww//7SzBskLVhN17CIrEFq9Y7YgfwQUDu57CefMZCqwZhAqr66oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YW+HpKG9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YW+HpKG9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698384978dso12830365ad.0
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761861766; x=1762466566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5LA5B446ZeXEQHrU7Ra5D5BiNT5+4vY/ARHOc1M/cs=;
        b=YW+HpKG9ayD6GegW6NezJzkN0SqzwrSxdvOG4apPJFCam0i29cg6u7OEmBHmVMSo2m
         cw5WLbdYG5mbAfwc0d1f5Xy1bwdOlzt4WlWBwP4ITVf8/Ak3y4z9Rraa7vRLhoKSZALd
         0A/nlP1HKNhGW1hdFfr+fXnFb52FUNUNOkEZAi8tMw7ALeCyP5+adoXlVQxLKpFGNpv7
         WBTmq36FHtV9zCeSArzoi+0SqPZflrlyiE20uaF/RMRjoUoHHIBOQAx3M26Ulg+ku69m
         5Zg7PBRph9+HTG/HiDyAYoI2IExdn2859P4c+ueP9MnWc1OmXg109rVGCee5U321jzDd
         tCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861766; x=1762466566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LA5B446ZeXEQHrU7Ra5D5BiNT5+4vY/ARHOc1M/cs=;
        b=FA84vFjGUGGkDyN+kA5HzDe6wkLHB57h5IopSjR6N9bDfzs1ri2DJxrDF4an7dP6bM
         tbaLp2o3vLL5U6AwRfB11bfphxSeZ4DUTePMYNTvDeUC+CxLPXUcuEmVpjep0qu7o6Xp
         4bzl67IrD7Qb50TAdW6pSKAEWWJAk6+/SFOTSwLAAt6IgTHqxrS2GapiSa1yhO+hMYO/
         2gnHTSZD2xYUuXx3Dz/4Pyg7hIr4Jj7lxSLjLARuvYKtsnD5n/yA1a4qcUuEh9WoKai7
         6E/Mr3C3v7ifRv/2eo6qf9FoR+ayu9BU9HJt+LTmTzhZpxZ6b3+iDS2YxW2U2CDs5c2d
         q8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Nybsah2wuVYONFqkuKZ3s7QzgCK3UPp9rwE0gn/PX/vaciazb6TJeNiCsLgm2ZQrtVR1MwLTCSMdTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48oIg6pa9dUD3pRiktps6jKcnzK82v8RbcGYVRtJMdW92MzXp
	T1LoaN7HMfA5NX8AfrGYCscW2cSMfNyVnYSa+bXA/K1xIjgySZPs6z5BC3DAuKwjR/s=
X-Gm-Gg: ASbGncuGvu/bhBTB8TScoPO//A1IoBssX7jIjNJtk39TWZkqfKtMBciIPAKICvfCJVl
	VZpe0PXFXJnFxEA0Nqd0jLRe696855+BwZWC81mM/2TBz3Nc21iXsYfHwC81nQMvSxxBWn56qLk
	JGu5NGiItPu9t3W32VzKATjRk+Kv0e1MgNzGE3ePjrucVV59KHh5Z7xnmyIigA/a4U9BxOM2fXj
	GTJwfBionTPyyg/eMc69X5Mdp0h9SvfsIXDUPTmzMh5w/ZJ2P9YdGcLUgqEC87OKSXsplQjrytv
	J8Ex9YHz26nng2npMtFpso7FfcjVe0DxIuGbaWYt742G/Gb5o6+d/XKc0fMS0Ojs2aPrPQ1m/MN
	AOl2yqnk31u+iEtch0CYyJthAo5gBKHsQ8ne9Qt1O03lHmVuLIz3R0ZtwkKFRMXqaOSQHo4scxp
	lcMUiGOYNp7t2T6VLwXdkJ7Jbeip37O8ukRbK45QLnBhm63Ed2/Wk=
X-Google-Smtp-Source: AGHT+IEUK4VY3vlv2EG4ggLi7rfSvrtgNznZMJVA1McqV5dhVhLohhKpNsIroL+zzWYFGo32TwDWLg==
X-Received: by 2002:a17:903:2312:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2951a420e44mr15402805ad.6.1761861765826;
        Thu, 30 Oct 2025 15:02:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2951ab8c1dfsm6755835ad.75.2025.10.30.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:02:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEajC-00000004HIE-0S7o;
	Fri, 31 Oct 2025 09:02:42 +1100
Date: Fri, 31 Oct 2025 09:02:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Geoff Back <geoff@demonlair.co.uk>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQPggv2LK4kkXj3L@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>

On Thu, Oct 30, 2025 at 12:00:26PM +0000, Geoff Back wrote:
> On 30/10/2025 11:20, Dave Chinner wrote:
> > On Wed, Oct 29, 2025 at 08:15:01AM +0100, Christoph Hellwig wrote:
> >> Hi all,
> >>
> >> we've had a long standing issue that direct I/O to and from devices that
> >> require stable writes can corrupt data because the user memory can be
> >> modified while in flight.  This series tries to address this by falling
> >> back to uncached buffered I/O.  Given that this requires an extra copy it
> >> is usually going to be a slow down, especially for very high bandwith
> >> use cases, so I'm not exactly happy about.
> > How many applications actually have this problem? I've not heard of
> > anyone encoutnering such RAID corruption problems on production
> > XFS filesystems -ever-, so it cannot be a common thing.
> >
> > So, what applications are actually tripping over this, and why can't
> > these rare instances be fixed instead of penalising the vast
> > majority of users who -don't have a problem to begin with-?
> I don't claim to have deep knowledge of what's going on here, but if I
> understand correctly the problem occurs only if the process submitting
> the direct I/O is breaking the semantic "contract" by modifying the page
> after submitting the I/O but before it completes.  Since the page
> referenced by the I/O is supposed to be immutable until the I/O
> completes, what about marking the page read only at time of submission
> and restoring the original page permissions after the I/O completes? 
> Then if the process writes to the page (triggering a fault) make a copy
> of the page that can be mapped back as writeable for the process - i.e.
> normal copy-on-write behaviour

There's nothing new in this world - this is pretty much how the IO
paths in Irix worked back in the mid 1990s. The transparent
zero-copy buffered read and zero-copy network send paths that this
enabled was one of the reasons why Irix was always at the top of the
IO performance charts, even though the CPUs were underpowered
compared to the competition...

> - and write a once-per-process dmesg
> warning that the process broke the direct I/O "contract". 

Yes, there was occasionally an application that tried to re-use
buffers before the kernel was finished with them and triggered the
COW path.  However, these were easily identified and generally fixed
pretty quickly by the application vendors because performance was
the very reason they were deploying IO intensive applications on
SGI/Irix platforms in the first place....

> And maybe tag
> the process with a flag that forces all future "direct I/O" requests
> made by that process to be automatically made buffered?
>
> That way, processes that behave correctly still get direct I/O, and
> those that do break the rules get degraded to buffered I/O.

Why? The cost of the COW for the user page is the same as copying
the data in the first place. However, if COW faults are rare, then
allowing DIO to continue will result in better performance overall.

The other side of this is that falling back to buffered IO for AIO
is an -awful thing to do-. You no longer get AIO behaviour - reads
will block on IO, and writes will block on reads and other writes...

> Unfortunately I don't know enough to know what the performance impact of
> changing the page permissions for every direct I/O would be.

On high performance storage, it will almost certainly be less of an
impact than forcing all IO to be bounce buffered through the page
cache.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
