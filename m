Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AD1F941
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745724195; cv=none; b=K/W/3csJPpVR/vDtzqwR7LD0sQnTvwsop18RYSBwyHjVx2b3dUCLO3K0hh+aBRbhWyTgokcaRiXu+lc9reOH8PaPBx2Dt2ybxsJ0ZgbU4vJrTvg9jkHYkzF1AS6RlwLVBsKxfnCd5C8yFj8GZRj7ecgqeU7+jlQGKkDkv3Wn/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745724195; c=relaxed/simple;
	bh=Ne2HOVSaVadpphO61PCcSDq7y4wRMYieHhkEQg2lOAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9ZyCtWSI+MKSPGFYfWE8yM27KrixEwoDW5uoC2BZeT1lbySMHfLd8AkiOIqchh7RJJC73x7ocFwpxu/Sw6/Sgf37eXD4z95t1OvHlTkijoBFSUZETHSlVsx8J2g9UH6KX51uv1HV1m4JMzA5JfF6X4LV/JRLRIkpSGovvsjMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3QX6ojm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3QX6ojm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00139C4CEE3;
	Sun, 27 Apr 2025 03:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745724194;
	bh=Ne2HOVSaVadpphO61PCcSDq7y4wRMYieHhkEQg2lOAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3QX6ojmeO4b/EEo6wGrBAVlbD9hp2slZpyTA1aajww32we2Z2yuAmBWrO+Ci6+61
	 srYyinyA6yZOdXO2aiTUVUtSJ5oylzOnt1/UqIuz7tw/WCz9X2jXuymZ7V98I+LpWG
	 7RiJQQHVF+uxkFCRutgy+53X5S6+z4u7we/rSbZ2HpmeIKEZwW/aIdto84yxoSBka/
	 qlLy4iRA2fA5YogWNJL4EvWuhGHZecXtm3qe+sHJU43yM52I5haddJLeMgvkuO2JGu
	 kjIEED5qZcbAoRR7YgmPPMkKzXe0In+jhpaqwoHbRzJ3ke5BXMpS9FM1b2Lq6z+OL7
	 XX+AMdHvrJMjA==
Date: Sat, 26 Apr 2025 21:23:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Message-ID: <aA2jH6dw-f4h9cEY@kbusch-mbp.dhcp.thefacebook.com>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
 <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
 <aApJWu1KLw7607Vz@infradead.org>
 <790260c8-09b4-96b3-310f-f9c5a93ef7ff@gmail.com>
 <aAuSYhnxwpJns5Cs@infradead.org>
 <8d8fa127-3bf8-c6b2-71e6-90ce5abcc3df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8fa127-3bf8-c6b2-71e6-90ce5abcc3df@gmail.com>

On Sat, Apr 26, 2025 at 01:23:08AM -0400, Sean Anderson wrote:
> On 4/25/25 09:47, hch@infradead.org wrote:
> > On Fri, Apr 25, 2025 at 12:04:39AM -0400, Sean Anderson wrote:
> > > and in userspace that assumes 512-byte granularity. But there is no
> > > such deeply-ingrained assumption for zones. You just have to set the
> > > parameter correctly.
> > 
> > There are everywhere in software actually using zones.  You still
> > haven't answered whay your intended use case is, btw.
> 
> I'm working on testing... I thought I would send a few bug fixes upstream in advance...
> 
> who knew I would get such a hostile response

The constraints you're suggesting fly in the face of all conventional
wisdom from developing zone devices. It would be a bit naive to think
proposing such a thing wouldn't pique some skepticism. Whether the zones
you're talking about are coming from SSD flash erase blocks or HDD
shingled tracks, both work on granularities orders of magnitude larger
than kilobytes.

If there's something else we don't know about, then it would be quite a
novel device that warrants further discussion. If no such device
actually exists, then it's a bit of a moot point whether anything
supports it or not.
