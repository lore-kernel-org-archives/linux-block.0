Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD045354AC0
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480042; cv=none; b=m9xClQrnwY4Q+CEtMGUsCipplxY31pTdLDIRIt/DVxsY+gazKau1ECkaW2lMhILV6qWhHUcbCv4hDLtmtezX5/5h4dfHNlOXOpsh6kdXqeVV3dMux08FAx4fbCh3/agMmDqBmfJvjSPf47LIob/hxuvgHTIejs4KCPKtnyZg7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480042; c=relaxed/simple;
	bh=0mYoHNEPOrfsxdix8rt3n0Qim1vsyQhfc+FJB48gPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb5f2VljUeU2NxWbC4JwGbvXPd8yAEJnp21hIZPIJJAflilZpWKHgl3jJo4tXbbsw4v94CSEVakM3kiA2x5f1cilJ5wxRKCrL70f1GCBFur2SBvQOx7RlDUZALZAdr4ifaKRJPGAyxbFYRaAW+1iaWgQuDavaOUZoSmk+ZiYs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwEP6E3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwEP6E3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C886C19422;
	Tue, 18 Nov 2025 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480042;
	bh=0mYoHNEPOrfsxdix8rt3n0Qim1vsyQhfc+FJB48gPOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwEP6E3p4Vb0qHI2BH6GpEKrqAwvDcimLV3IPy9wr5j7WmmYcKbQURWBfvBJR0yul
	 ksIa+s9hSKvshu+iCMs8c19A5OBOI1c405wacUsCjViI42V8a9dRe/e7o525KWXuge
	 +q1rxjnMh1boZOVvOmL7HmPaxYA/m6S2GEb10Ib4tYWcgzhzhxd7q9Nafn3Q3/tlc4
	 qrPkN7my1l9RyNxonVk0VdcANMMRPnbM9ql/OxdB1UqP+viOJ3ez60mgpV40gA+0Cf
	 eZXZsNn2nvSj1QI8FPsfsQZ67hyj/8AV9SrOtVHF5z/ehtWQPDuyruo62ye9Z1Bo8a
	 hmVzllsUN8Sdw==
Date: Tue, 18 Nov 2025 08:34:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: nvme discard issue
Message-ID: <aRyR6MaF5-CoVRDW@kbusch-mbp>
References: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>
 <aRyPJtYJaEVRkBeM@kbusch-mbp>
 <0767437b-3861-479e-aee2-d4f5cce9f6eb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0767437b-3861-479e-aee2-d4f5cce9f6eb@kernel.dk>

On Tue, Nov 18, 2025 at 08:28:16AM -0700, Jens Axboe wrote:
> On 11/18/25 8:22 AM, Keith Busch wrote:
> > On Tue, Nov 18, 2025 at 07:24:59AM -0700, Jens Axboe wrote:
> >> commit 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e
> >> Author: Keith Busch <kbusch@kernel.org>
> >> Date:   Fri Nov 14 10:31:45 2025 -0800
> >>
> >>     block: consider discard merge last
> >>
> >> This was just doing an allmodconfig build, using XFS as per the trace
> >> above. The fs is mounted:
> > 
> > Huh, xfs was the only filesystem I tested, but obviously not enough. So
> > the segment accounting is off now, I'll take a look.
> 
> It's all very strange - reverted the above commit, and ran into other
> issues. So may be something else entirely and your commit is fine. My
> for-6.19/block branch seems fine (?!?), but merged into master it's not.

Interesting, I'll keep testing futher back too.

But I do see a non-trivial problem with my patch, so I think you should
either drop or revert it at this time. For the discard back merge case,
ideally we'd just adjust the bio's bi_size and drop the second bio
completely.

Anyway, sorry, that was my mistake. I was trying to get nvme to hit a
previous bug from merging data-less bio's that nvme had dodged.
