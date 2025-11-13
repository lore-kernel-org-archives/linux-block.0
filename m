Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5902877F2
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065319; cv=none; b=ebR0WwmyjOSadaSWX1nzDmIpVbw4IC7CjHWGLMTC5DolJIboamyWKz8E3lHsD9lmpvzC15EhoCKUutF8sk9lVhPVpHJuzvo0nZ2h0YRUtzRwGmqEh+B+GNyx2EpKpGk4xKpBcF/xWm8S/zGsz1iLH8TFhjfjyJCn5B9VZ1CHf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065319; c=relaxed/simple;
	bh=Jev1AxLrJC0u05gxK3mVR2UgjC1wGPZZAg9G3RBEf94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOyW1iemTFMhGJtM5f84EJPGcD28pye5s27TQYWpmgQjIbx8YDBF7ZVRsVANWbDhmOtVoXOMjJNlaGztQ4H6EgLoWQuLV1usOa9lR1noICcY1by8rj0fiOFzDoiORrQRhU0NJialf3wvgcNQx84q6V+O3NST3riomDfy2rb7oVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1RdbU1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1RdbU1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59154C2BC86;
	Thu, 13 Nov 2025 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763065319;
	bh=Jev1AxLrJC0u05gxK3mVR2UgjC1wGPZZAg9G3RBEf94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1RdbU1a8IHrIgbYKu53b98FP/EZMtKZV2mw2tgp7Fm1bimgnVaXp6NV+TNcOiA4E
	 5+6De3ARcEjwMdec7N2FSmm4pPbdJ6u6c4neFGw66tFa5y2e/8LfwNU9KfLWMDLuwA
	 NVPvTDmhBjMMSIwA3u5T12MjM1g9GeXEAsI+RHBAytxszae9GYnXA4bRkGx3cvF8re
	 g098KuCbOhAAL/NGKure1ilJsh9EGExKgWhtsuz3hVVn6POy/bOuADmgWwcfwFpWSZ
	 8SKB7cR6UpWXJhk05GSTPUAAW6I7VCBhIGEYhYqfGxuUfST6bRLLkmlTKvgk8OQZgK
	 9yPee0PKdHVRQ==
Date: Thu, 13 Nov 2025 15:21:56 -0500
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRY95C3oCIMA532x@kbusch-mbp>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
 <aRY2G6xEgEVqLBgb@kbusch-mbp>
 <20251113200237.GB3971299@google.com>
 <aRY7jDVt2jpLCWoO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRY7jDVt2jpLCWoO@kbusch-mbp>

On Thu, Nov 13, 2025 at 03:11:56PM -0500, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 08:02:37PM +0000, Eric Biggers wrote:
> > On Thu, Nov 13, 2025 at 02:48:43PM -0500, Keith Busch wrote:
> > > Like on real hardware? I'm a bit at a loss as to how, I've never seen
> > > anything subscribe to this format, not even in emulation. The only thing
> > > I can readily do to test this is run random data through the old code,
> > > print the result, then run the same data through the new code and see if
> > > they're the same. That test is successful. Not good enough?
> > 
> > ip_compute_csum() returns a folded 16-bit checksum, whereas
> > csum_partial() returns an unfolded 32-bit checksum.
> 
> Sorry, I must be missing something. do_csum() returns an unfolded 32-bit
> result, and it is just getting down cast to a 16-bit result. Where does
> the folding happen?

My apologies, please disregard that. I see where I am mistaken. It
happened to be working based on how the data was lining up in my tests.
