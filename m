Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224B2E6CC8
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823208; cv=none; b=KqmL04oYkwnuwc8yldT+FZqyMdO7+f+9vxBxQKa+tZIzMiSJtRJa88vYgMJi74OcLCdSeHP7sl5p81Zf49uD6U83zy+CiyUBQSNZ252OmjyECVMDnaWQDW5z14yKZDpyfiHRj76hlVlw/RZc3WjtiosTa7UAJMZPSVxSYRUFY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823208; c=relaxed/simple;
	bh=B71bbQUME6bPFSPnTl2rUk+zM8rJpRXJqWB0RdN61nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9jkS79JmsMJgz95o5/zlYtuvItQEKR9gPppKqBLuZ/IzQ2PVLDS64j9aZuZRo1NeldpV5vB5D3+/gUWiBGLQ4GNkvd+DvcckxOQOab9dLEAB4caTqdKuDwTdHfPSK1BZyHA1zSB7W+0heGW7hHJ71iUOY+k1GNNk8ZGR7r5rwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FATxVZY5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FATxVZY5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so1142902b3a.0
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761823206; x=1762428006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNDVGLdLslRPQnKZM2E9zoqPqU4j8KmV4lXjwMAwzP8=;
        b=FATxVZY52eiue2vTxnTXS9XbrgsPWcr82oXbq5fsVvXrS6fYt5UiVwU0LotBphrnXZ
         gHYM4G9IRmiF7UaIj72aKzZnX6KklO9uQfDfb6nQCBIiHHuFduw7Ar2I6qeoBkbSodZz
         09PNJ4tssChmILY10vyK0YUnBTH1Syl95PAmh9fgI/+icc/04QpDT1qekgpKZd4WLD63
         ZmUTKWelBL8CzoRZki9MU5nC0BT+qE4eChtXTbX3fHyt5WC9PXp3SrQo3zWnPlBYrfCl
         YBLv/58eGx3eWztGvRBsy7RARPcA7ewb8Y5vuFT8oRD+14CXLTNCF+2JpfnUvr04TRRq
         rk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823206; x=1762428006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNDVGLdLslRPQnKZM2E9zoqPqU4j8KmV4lXjwMAwzP8=;
        b=RRyBrXNLI4PVo1NbiqNcNLGngzV6Oh9EoEd3ub85v/xixF7T7zASgDonQivJX3TjuN
         f3CTfhbKjHXQBFJm6ilei5NtdxhZb7m7hxKN4Zu+M+lCwlkNAlixAnDDDyu6vyRDqfy2
         lPa2zMkBEQ6EaQ9R2m311ckh4H+3KQooBIi7WAPVJfjloc0GxLNltBdvtB231jWzPurs
         CgfPE6/pcaeuPsIbZN8AMrfNFDs3RL9U4rKm7G9seBuFvQpUJuGtLVTF9gENSX2vjP2M
         oyHA3dSSwfF4DamuneSz0Tkq6DHc+W8W01/iJzsMSlIHNNBw6myg2lsNC/xAQJkU1xPP
         SsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWeVQR+HIrS3YuPBglS9IxQyTuMNw+gMuMUZb/XPkdqdLChLV41ALEN/Ya6/F+Q5dsw0EFau7E0J9ygew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXU1NL4//yg6gpEf53UHM/1OBItt+ISNzWK90NX9eIxwxXZmL
	StMoxQMPe0sty3HiDjjRwzguXamqvue0/3kOLle8NXOOHIPsZnrZ1DNqr/uXNtQOwEw=
X-Gm-Gg: ASbGncvRfKwJU5B5zVb1lHyVZUyspQ5mtP8Qauf4fyoDubz3RbWGoPnVdE74Bqrs7MV
	n9+SRN/3+HIg7g4Vb1SBT3aaCN40CXyghbmchrYjyfTsPkFOnYNwprqE+43RGvv24qczjMYoTGP
	j4tsoiOJAOlpqysSFIIa14IJuJK5QndM+Jbkd7Em/oOQTUP5gqpQs97QS1LzFr/YktVfXhni2IK
	uQKATtjlekpCnaf7Zl9AcmYJ6htZ68YXpLzSGxXy9jv1Ckt2yHU4aevLfdOjaHURvd5bJ9/LyUy
	r/tATys3pNPp290RRhRudnSajU64gMgXhXhKSsyVFaKKwlZGCla7B2QOkbDMaIR9ZVNyP3+sN7/
	6dBfUzgNH6Fifjw2F+9J/hp67W+qMDdDtdk1u+7ccjV0Fiba8xVNapYgJMMhIpK83VZ4QCdnzU9
	1sna7gb0FikdG6UNKwpEIX+r9p7yxxpZxM9xLWWKxnEBt1WpICoEU9wGRGuK/EPA==
X-Google-Smtp-Source: AGHT+IF/l5E8cKKK2vFaTAZgp/ZGb4MjtxoPBEtVt6VeAi8ECm9tlqHfB9lmTROZ9cINQrgWB7grkQ==
X-Received: by 2002:a05:6a00:9507:b0:7a4:24af:e16f with SMTP id d2e1a72fcca58-7a612eb8487mr3627141b3a.3.1761823205858;
        Thu, 30 Oct 2025 04:20:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a51bbc1b6csm5620722b3a.10.2025.10.30.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:20:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEQhG-000000044v1-299E;
	Thu, 30 Oct 2025 22:20:02 +1100
Date: Thu, 30 Oct 2025 22:20:02 +1100
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
Message-ID: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>

On Wed, Oct 29, 2025 at 08:15:01AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> we've had a long standing issue that direct I/O to and from devices that
> require stable writes can corrupt data because the user memory can be
> modified while in flight.  This series tries to address this by falling
> back to uncached buffered I/O.  Given that this requires an extra copy it
> is usually going to be a slow down, especially for very high bandwith
> use cases, so I'm not exactly happy about.

How many applications actually have this problem? I've not heard of
anyone encoutnering such RAID corruption problems on production
XFS filesystems -ever-, so it cannot be a common thing.

So, what applications are actually tripping over this, and why can't
these rare instances be fixed instead of penalising the vast
majority of users who -don't have a problem to begin with-?

> I suspect we need a way to opt out of this for applications that know
> what they are doing, and I can think of a few ways to do that:

....

> In other words, they are all kinda horrible.

Forcing a performance regression on users, then telling them "you
need to work around the performance regression" is a pretty horrible
thing to do in the first place. Given that none of the workarounds
are any better, perhaps this approach should be discarded and some
other way of addressin the problem be considered?

How about we do it the other way around? If the application is known
to corrupt stable page based block devices, then perhaps they should
be setting a "DIO is not supported" option somewhere. None of them
are pretty, but instead of affecting the whole world, it only
affects the rare applications that trigger this DIO issue.

That seems like a much better way to deal with the issue to me;
most users are completely unaffected, and never have to worry about
(or even know about) this workaround for a very specific type of
weird application behaviour...

-Dave.

-- 
Dave Chinner
david@fromorbit.com
