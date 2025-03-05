Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B947485
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132874; cv=none; b=mCueHxuWQex9y+Nq4b4McUp6fhkYQzRd3cqk1WrxzUMqYJTuntVnfIMqYxhesxO07MfwdvpxM8xtbsughQoXuBPS1lcWRRvOOGMQao02KRc35B7b2wk+tLexrSaVjG+mvpS/KlixW1gTrd6LJILLQwQiTx4TW4GigHUv1UMaKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132874; c=relaxed/simple;
	bh=rRf1I8v2mb7cp/ZXvd0fvfOTQ6ljFLMAqB8offpuq4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIrnMUPI5MKv3Mf0o7JBd4hCh3W9WrExI3yJnpW0ckJ2hK8qfN/9o/iaaAHkzMuf/m6Etmxb7ROMtU/qp5dNERpwxv6xHqatIgi6RaxHs0l9HAXMesJNuYgwgnHIoIhborG4Ke0NZT7rKeCEEQWk3MU77iEg6cCjlq5QS6SkxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=D0WM61TA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="D0WM61TA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349dc31bcso109793045ad.3
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741132871; x=1741737671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r789Q1jlfKz3IK8/NvqMNawojmvOfE2LdKKMhm7xExQ=;
        b=D0WM61TA9FB8swQjFL1CzfZyjl7LmDGGTzl6els6uEzt7+oUA8MTvnxMclBGaKfKN8
         ZEEv1I5BiCJdIv6ECjNxcSvtlyrWuKuQmsqG8HQ/BOwv29zMbJYh2DE0B3HBxAv39gxG
         MN0l2O61xJ07ZLf6wP6g8UzTu1k1YTR+M4SDEQsoQNEx3omrq3e1gxBcmSlPOJnpq2xV
         GNwRSRbKH8gzX5CE9Jv8s2wHQaZw46qOClSRIc9SwlhSqWTHBiyQxrndycXZS149FyUx
         YPQpL10YMae3dd6AFCkt68ol/y1xwQftqNkpX/PAffvEdikO08rvrtjfaeRtCwWTHFff
         sA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741132871; x=1741737671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r789Q1jlfKz3IK8/NvqMNawojmvOfE2LdKKMhm7xExQ=;
        b=bGPCuUkvdM7J9K/u89FrZMa/aBl4RhQo17JBRCvLZmAVou7ylVqpluVYZEdfO687nE
         o67FyjbdjYR8o8BhG9+W3mkVY4dcMXWk05C9mUJ3BqxrDcqznpDVFM16iWoMqrGfS1Ml
         1uJ706Ga0kJnWMlnQNp+HXKgbVC8zZLfVoXSahe7O+jqR27sZbkHikJWLr8Gkr5Xf1Li
         3tEPSjzIWXWsBeRH4N/kNotaKE+PG22daeFb/oCG8fceyeCPQjOohuvSHhcCKVpLZP5t
         1Be+WpiQv6Iwp9B0bJOv3qawGBTcLAaY8zUwZnkobF24PTP+dEzDAHk481obYKrpVyuG
         2zmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5cbyv27zB97Pe/IfHtykrtaGVpojrDw97xjh7ivOtENWzPcNy5Y2ok1nya5qWbwvO2dev1OF/rq6z3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5ts229YpMqQZzsiZhndYcd2aAXgqq0ncFuuSlxkHbqDLrMP9
	Nu3ivUreOmrl4ZRUKH5IM+MuskBaOHcB3pU7l9Z8YGG3T5yRhBjinSOEZShPo94=
X-Gm-Gg: ASbGncukmIiWtvEJzdzp0+/JkLXuTBRH3qvO9Ohk9/FPLATydX79jzOgbHA495Pao0W
	4N3VGM24K9AO5sMubHLQDp8Wkwc+zVIaxYige0+NwmpQIjMazDPo78QmbiY85v5OsOf4BwmS1i0
	CRvyfOByuSU1jRuFO7dspPlzqyMk1HeywI1Xu3wNbXfgtzIw2dnRtMh4oOmtNEUEm/Jr2sb0P2l
	kU9mUIQhtObZAJtnAWzhfbVwumywP3K5/P2gmOPU539Q0wKD6qHtjWuOfXoQ1qSYQLOZvBJ7e8e
	6Pm0Y8i36jTNr63mtOTAYn4FodwOzMZroU6425Ym+tbJ6kah5ZoYIvkDW8RuPXOXwWfMkKgcC5Z
	QNSN90Hmx7w==
X-Google-Smtp-Source: AGHT+IHWgVZhwTqjUW79RBkAyQLg9bvckDYTsLtUpYchpTAMxRfLmyPz7j2sZ2jjWwFHd2M8cA6aqg==
X-Received: by 2002:a17:902:d486:b0:21f:522b:690f with SMTP id d9443c01a7336-223f1d15117mr17904215ad.46.1741132871461;
        Tue, 04 Mar 2025 16:01:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d5247sm101040415ad.26.2025.03.04.16.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:01:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpcCC-00000008xBG-1vBY;
	Wed, 05 Mar 2025 11:01:08 +1100
Date: Wed, 5 Mar 2025 11:01:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8eURG4AMbhornMf@dread.disaster.area>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>

On Tue, Mar 04, 2025 at 12:18:04PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 4 Mar 2025, Dave Chinner wrote:
> 
> > On Mon, Mar 03, 2025 at 10:03:42PM +0100, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Mon, 3 Mar 2025, Christoph Hellwig wrote:
> > > 
> > > > On Mon, Mar 03, 2025 at 05:16:48PM +0100, Mikulas Patocka wrote:
> > > > > What should I use instead of bmap? Is fiemap exported for use in the 
> > > > > kernel?
> > > > 
> > > > You can't do an ahead of time mapping.  It's a broken concept.
> > > 
> > > Swapfile does ahead of time mapping. And I just looked at what swapfile 
> > > does and copied the logic into dm-loop. If swapfile is not broken, how 
> > > could dm-loop be broken?
> > 
> > Swap files cannot be accessed/modified by user code once the
> > swapfile is activated.  See all the IS_SWAPFILE() checked throughout
> > the VFS and filesystem code.
> > 
> > Swap files must be fully allocated (i.e. not sparse), nor contan
> > shared extents. This is required so that writes to the swapfile do
> > not require block allocation which would change the mapping...
> > 
> > Hence we explicitly prevent modification of the underlying file
> > mapping once a swapfile is owned and mapped by the kernel as a
> > swapfile.
> > 
> > That's not how loop devices/image files work - we actually rely on
> > them being:
> > 
> > a) sparse; and
> > b) the mapping being mutable via direct access to the loop file
> > whilst there is an active mounted filesystem on that loop file.
> > 
> > and so every IO needs to be mapped through the filesystem at
> > submission time.
> > 
> > The reason for a) is obvious: we don't need to allocate space for
> > the filesystem so it's effectively thin provisioned. Also, fstrim on
> > the mounted loop device can punch out unused space in the mounted
> > filesytsem.
> > 
> > The reason for b) is less obvious: snapshots via file cloning,
> > deduplication via extent sharing.
> > 
> > The clone operaiton is an atomic modification of the underlying file
> > mapping, which then triggers COW on future writes to those mappings,
> > which causes the mapping to the change at write IO time.
> > 
> > IOWs, the whole concept that there is a "static mapping" for a loop
> > device image file for the life of the image file is fundamentally
> > flawed.
> 
> I'm not trying to break existing loop.

I didn't say you were. I said the concept that dm-loop is based on
is fundamentally flawed and that your benchmark setup does not
reflect real world usage of loop devices.

> But some users don't use COW filesystems, some users use fully provisioned 
> files, some users don't need to write to a file when it is being mapped - 
> and for them dm-loop would be viable alternative because of better 
> performance.

Nothing has changed since 2008 when this "fast file mapping" thing
was first proposed and dm-loop made it's first appearance in this
thread:

https://lore.kernel.org/linux-fsdevel/20080109085231.GE6650@kernel.dk/

Let me quote Christoph's response to Jen's proposed static mapping
for the loop device patch back in 2008:

| And the way this is done is simply broken.  It means you have to get
| rid of things like delayed or unwritten hands beforehand, it'll be
| a complete pain for COW or non-block backed filesystems.
| 
| The right way to do this is to allow direct I/O from kernel sources
| where the filesystem is in-charge of submitting the actual I/O after
| the pages are handed to it.  I think Peter Zijlstra has been looking
| into something like that for swap over nfs.

Jens also said this about dm-loop in that thread:

} Why oh why does dm always insist to reinvent everything? That's bad
} enough in itself, but on top of that most of the extra stuff ends up
} being essentially unmaintained.
} 
} If we instead improve loop, everyone wins.
} 
} Sorry to sound a bit harsh, but sometimes it doesn't hurt to think a bit
} outside your own sandbox.

You - personally - were also told directly by Jens back then that
dm-loop's approach simply does not work for filesystems that move
blocks around. i.e. it isn't a viable appraoch.

Nothing has changed - it still isn't a viable approach for loopback
devices for the same reasons it wasnt' viable in 2008.

> The Android people concluded that loop is too slow and rather than using 
> loop they want to map a file using a table with dm-linear targets over the 
> image of the host filesystem. So, they are already doing what dm-loop is 
> doing.

I don't care if a downstream kernel is doing something stupid with
their kernels.

Where are the bug reports about the loop device being slow and the
analysis that indicates that it is unfixable?

The fact is that AIO+DIO through filesystems like XFS performs
generally within 1-2% of the underlying block device capabilities.
Hence if there's a problem with loop device performance, it isn't in
the backing file IO submission path.

Find out why loop device AIO+DIO is slow for the workload you are
testing and fix that. This way everyone who already uses loop
devices benefits (as Jens said in 2008), and the Android folk can
get rid of their hacky mapping setup....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
