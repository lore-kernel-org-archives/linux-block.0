Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBE1D5145
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903816; cv=none; b=TWOXo39AhqZjY2UJKB8l2alryFa4+TR9JiNP+peMTHTztlHMqygQE+lZcW59P3C5Sn3W3WV997kQ8/zwlyxGa9Ps7FfptfRcuAkja0y5y8PyGKvpaHv3t/Vd4R4go7I1kipwhY35ez7ANyhzFO7GE7mUdUX+VtrNYQgjol/+A70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903816; c=relaxed/simple;
	bh=K4TsgEfbZBCaB5T+UtpxvoxOzf99yOdPJVsE+Cw+Y0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8ykAA3Q192Ok+YnrsqP7ufidqq0EV0z+rzxLS4S4dT2gZOqzlkkvSXbZDnDqUvtsxj15m9VDg4c8+GI3OfAOPdbadeb75IvtLNF7HQxo61EHiRZ3MT1zi1uV4RBnYmoM1ufS1TSlIsbUy8xJ7JTq0RxAK9ql3VDnMIfVMogDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5AcbnHd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5AcbnHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014CCC4CEE3;
	Mon,  7 Jul 2025 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903815;
	bh=K4TsgEfbZBCaB5T+UtpxvoxOzf99yOdPJVsE+Cw+Y0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5AcbnHd8RRLiGwhKyQCEKRiHwDNnLOxKiGli9/0YhEm80kN3aq/ruts5qIlYk5A6
	 6LpG+1G1+nv05A1Wxr2wUxcViszbUUm6gRJ2PqKzMEPDftjSXMsLAnPx0t/HtgU+st
	 aqb4rtSXW2NfYnQuUwDRBiTdswIlRVJchl73ewkVGZ+x5/szVxEYKqT3RhUV5sw1pF
	 R6nLYOibtMPyw1r6GIReKmpLlJCUhkTQUuSks/bAkErPer/csYqicOpJusESYU0MBH
	 v/28k6znhy+zdn7NhyN02dMIM1MVXWXuUzUAXgK81kQxg1bzeeefYX5fR8CSVJrZ7d
	 5OAt+Oi6Olaxw==
Date: Mon, 7 Jul 2025 09:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGvuRS8VmC0JXAR3@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGvYnMciN_IZC65Z@kbusch-mbp>
 <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>

On Mon, Jul 07, 2025 at 05:26:46PM +0200, Hannes Reinecke wrote:
> On 7/7/25 16:24, Keith Busch wrote:
> > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > We could:
> > > 
> > >   I.	 revert the check and the subsequent fixup.  If you really want
> > >           to use the nvme atomics you already better pray a lot anyway
> > > 	 due to issue 1)
> > >   II.	 limit the check to multi-controller subsystems
> > >   III.	 don't allow atomics on controllers that only report AWUPF and
> > >   	 limit support to controllers that support that more sanely
> > > 	 defined NAWUPF
> > > 
> > > I guess for 6.16 we are limited to I. to bring us back to the previous
> > > state, but I have a really bad gut feeling about it given the really
> > > bad spec language and a lot of low quality NVMe implementations we're
> > > seeing these days.
> > 
> > I like option III. The controler scoped atomic size is broken for all
> > the reasons you mentioned, so I vote we not bother trying to make sense
> > of it.
> > 
> Agree. We might consider I. as a fixup for stable, but should continue
> with III going forward.

I think the NVMe TWG might want to consider an ECN to deprecate or at
least recommend against AUWPF, too.

Just to throw AWUPF a lifeline for legecy devices, we could potentially
make sense of the value if Identify Controller says:

  1. CMIC == 0; and
  2. OACS.NMS == 0; and
  3.
    a. FNA.FNS == 1; or
    b. NN == 1

And if those conditions are true, then the controller and namespace
scopes resolve to a single namespace format, so the values should be one
in the same. The only way it could change, then, is a format command,
which means there couldn't be an in-use filesystem depending on it not
changing.
