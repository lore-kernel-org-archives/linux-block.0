Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FB24169D
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866331; cv=none; b=BADM1DD9qH8wWRRkmlKtamG+H+Zf4xTTIV/Zdh+zLvrD15b0toXCm4ilvXAO3QV/P3/cwTXkiSUh7zzqYI4Oi+VhiEa1qVoC+CqtU15YePOKPZSZ6g1HFvP7vaPVFeX+zpI+ILxUq2nIUPHrkOapmpHp+9RGaEzI2AoI5x6SW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866331; c=relaxed/simple;
	bh=uyIXTX283OC1kScJiq1BmNvAstOmpxdr5HCMuNHi0fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh+26xgvEcb2R0WA+YfgUzu6lkTlyynDQuVyqYqhyj19UCj2MT1d3oLcD3qyaqY0ltBAyN3eqHceYT29iEQ3FyBZjcL8SL+f97uIa/rT0wnz74PyzEvTjNGtKT7J+vthvmUGJKeEHK6p7nUHIOeU/CM9J3NtHzNdeVs7luTPGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MjkRN0eU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MjkRN0eU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295018cbc50so15249405ad.3
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761866329; x=1762471129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCbSBxSr0lLm7sBF21gLzNw2k4fWMvq9RhDFJxnnKCU=;
        b=MjkRN0eUQYCY+pow13wzfHTyaRtLTZMsgpaIePm6uu+qnhlXj3rR535w+YrIxQ28h7
         TLI5cmdgr/ZDpm14ymS20tSuC2us1e0xaVwtFBCYnm2wanpXzlgo/OFSvPN4teLcf/YE
         /of6Mz40YLKckhLZ6V1NxZvGPGN5ttbCAeYsIGHIArq10p+wOOcOJGa9oTeeT4daqwyt
         G2Qhg7IzpEOUwQzT0V+09gZkgduXmCV+IJtrC/hkwYITTCbvwysP79wJFSbNg8Y2Rnh3
         fSFG8tN9e/wjgtIKjQDlK6Y4HzBOyQ8yMLQmL3Cn660PUQx7xKStnYKvtvqDpNB7oC37
         /waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761866329; x=1762471129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCbSBxSr0lLm7sBF21gLzNw2k4fWMvq9RhDFJxnnKCU=;
        b=FhB8UeeAHaNe3TMwqmpV9psdhLhUR4B39SyVUjxvqHxMvlEO6Y5VufbyoDzaadKEus
         Iq3YhYyBRV5ZVTyeNmCZC9tqKyvpl6fia8k6lscECCtVrlLA1sfYksAtmlEgUQ3kyoEO
         xvZ93KaB8OmgLlMhDREVfOGfBh9NELJBwwipU+UF9tRUA5E4fVap0rv0ef8Tz2qRCnvH
         4moxY3owVrP16k6s5Gj014uueluJQkbjZMgFp/xW7KOcCJ+RtLD6XfZn85dgm3ixTqwg
         2WWQtKjyDfYeig4fqHj6JZkmP0Xvc7X/N0HfYTuwcMS7oao5JBLsEWDz2dBtkeSo6SVC
         Azzg==
X-Forwarded-Encrypted: i=1; AJvYcCUvUpP+OGucW1ytKrIu1kTj8LL8GQnCC1W1Lz9XLIViP6Sih/PGA0XCBhZEKl5XkwhqSaG2Ud1ts2A/Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxksXO16w5DLK17TYbc0d5/sWzKIempXChuiVgEn2Z42ub7ID
	EbbuqtjBDrXh3T+u9B8zLbZCxr3+Zqj2BfAv87/+mz1vLjv4C0Rse9hpcvrTCXdpVoQ=
X-Gm-Gg: ASbGncsC6ZQO6+s01oLSmFAbsQ+gUCj6k72ST+AShmLsKgpwbVHP2vt3bDnXai8bZd1
	RVA7X9q2ZdKNcKTvDY8BxU8EDErogGUqeoJIrOWeA7lhlyq1ZOnDDsqL8SFfvwVoKcXy6pm8fAH
	jvDTr29jQifsmAzZBrneGf2Xfc7FQBPthpHvSu6bMal09Rf9Z27UoXUzQ2WE7Pyrv4zvXXpXAtN
	MmSu8L0zyUPZ6i54wlPZTxfI37usIVa/kDXQ3LXtvFqvDJdMqw/vJ2rV0fZV0Jeqq64RA+39mFC
	VhFyJw/t9f40kFSxIZtSczq1Kt8j91Nw3TMADIm6lu8B0TfuwItXq1//lgoAtljz0kIx4xeyHA5
	437uk64QPxE6TqEyzNGunDM/t7k++wd78+vbNHAD9XCbuDS/cauZWBJfnCnu0lIj7E90+mWEill
	ZEcbcnpyWrASehVAddALwKnHmJ1nAztSKc6Li/ehlA8xeBtR2SRjI=
X-Google-Smtp-Source: AGHT+IGCGfP0IWbXjpKpFiO2EIcl6d55MTKqgA8ReFs8GKHUG4igFi9rEAY/xEAVF+O7aUhdVIl2Ew==
X-Received: by 2002:a17:902:fc45:b0:295:73f:90db with SMTP id d9443c01a7336-2951a524b7bmr20673395ad.41.1761866329403;
        Thu, 30 Oct 2025 16:18:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699cd48sm982535ad.83.2025.10.30.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:18:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEbuo-00000004Ia1-0Gmg;
	Fri, 31 Oct 2025 10:18:46 +1100
Date: Fri, 31 Oct 2025 10:18:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQPyVtkvTg4W1nyz@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030143324.GA31550@lst.de>

On Thu, Oct 30, 2025 at 03:33:24PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 10:20:02PM +1100, Dave Chinner wrote:
> > > use cases, so I'm not exactly happy about.
> > 
> > How many applications actually have this problem? I've not heard of
> > anyone encoutnering such RAID corruption problems on production
> > XFS filesystems -ever-, so it cannot be a common thing.
> 
> The most common application to hit this is probably the most common
> use of O_DIRECT: qemu.  Look up for btrfs errors with PI, caused by
> the interaction of checksumming.  Btrfs finally fixed this a short
> while ago, and there are reports for other applications a swell.

I'm not asking about btrfs - I'm asking about actual, real world
problems reported in production XFS environments.

> For RAID you probably won't see too many reports, as with RAID the
> problem will only show up as silent corruption long after a rebuild
> rebuild happened that made use of the racy data.

Yet we are not hearing about this, either. Nobody is reporting that
their data is being found to be corrupt days/weeks/months/years down
the track.

This is important, because software RAID5 is pretty much the -only-
common usage of BLK_FEAT_STABLE_WRITES that users are exposed to.
This patch set is effectively disallowing direct IO for anyone
using software RAID5.

That is simply not an acceptible outcome here.

> With checksums
> it is much easier to reproduce and trivially shown by various xfstests.

Such as? 

> With increasing storage capacities checksums are becoming more and
> more important, and I'm trying to get Linux in general and XFS
> specifically to use them well.

So when XFS implements checksums and that implementation is
incompatible with Direct IO, then we can talk about disabling Direct
IO on XFS when that feature is enabled. But right now, that feature
does not exist, and ....

> Right now I don't think anyone is
> using PI with XFS or any Linux file system given the amount of work
> I had to put in to make it work well, and how often I see regressions
> with it.

.... as you say, "nobody is using PI with XFS".

So patchset is a "fix" for a problem that no-one is actually having
right now.

> > Forcing a performance regression on users, then telling them "you
> > need to work around the performance regression" is a pretty horrible
> > thing to do in the first place.
> 
> I disagree.  Not corruption user data for applications that use the
> interface correctly per all documentation is a prime priority.

Modifying an IO buffer whilst a DIO is in flight on that buffer has
-always- been an application bug.  It is a vector for torn writes
that don't get detected until the next read. It is a vector for
in-memory data corruption of read buffers.

Indeed, it does not matter if the underlying storage asserts
BLK_FEAT_STABLE_WRITES or not, modifying DIO buffers that are under
IO will (eventually) result in data corruption.  Hence, by your
logic, we should disable Direct IO for everyone.

That's just .... insane.

Remember: O_DIRECT means the application takes full responsibility
for ensuring IO concurrency semantics are correctly implemented.
Modifying IO buffers whilst the IO buffer is being read from or
written to by the hardware has always been an IO concurrency bug in
the application.

The behaviour being talked about here is, and always has been, an
application IO concurrency bug, regardless of PI, stable writes,
etc. Such an application bug existing is *not a valid reason for the
kernel or filesystem to disable Direct IO*.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
