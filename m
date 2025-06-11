Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D917BBF
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603647; cv=none; b=bg7Elod6lkKbVCqsIL+D7ckTaX9uoN1JVVK43X/vpytdTCmRibz7rhzXbU7jhIzLPNGM7niaI9MzBgE6J7I7XQas2BbXmf4J1WZm9cPkl4G1QdrwCRsuSZ8KcZ4GcJJDZR0Jx3cDjkbXV5Ab0oMfziPyIeY8sau6Y6tMl8jmwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603647; c=relaxed/simple;
	bh=pgL+rUTSG8eE9HHFVmcaXdhR9g2c0bfIwYbbpeSMNyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qijNUXiFns9dZhgQl8vTUCFeIiSJQ68CULQQtzK01znOTbW/N/UyVNmWjvlcw65D3cDLhs47oCy7nNfaXYfpbcoPqPiQPVB/PIh7asP+MIGcs1KB67FPlJWM+qNF9k3elun14E1I5qeQl+yiDENRIviN+UftUfOMpzRNa154PB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUUBVMo0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUUBVMo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23923C4CEED;
	Wed, 11 Jun 2025 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603646;
	bh=pgL+rUTSG8eE9HHFVmcaXdhR9g2c0bfIwYbbpeSMNyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUUBVMo09aIcQFpyJUMkDP5SBRMzK3hNkxVato3aEzZ1Ilp1WkrVXY6j9hpgfsaIY
	 LMiGNy59HSDhrNlgPM+oCCdjdZZhqNbi89+4PmILfYDVx+aiFrirYHyb60opSUnSar
	 SCD2UZ1fCXqY7naQWXGmwh/UkAmij/X3xp2XYTrw9aI5f77WRvk+2dkcUq7tlhGQXN
	 saUeSENHgi03Lx5vfEkfIk0on/xwRNRSVLPyV+iu8ylKXUdW36ONY4v9JnQdHJasAJ
	 LtPkWDkzqLICcRLrq3ontvEQPMLNbiZqVleUjbc5EgVl7ejQmlUDQOsJeu2+AMys5H
	 jlayNDd+9E7cw==
Date: Tue, 10 Jun 2025 19:00:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <aEjVPK9Xdo8P5Um0@kbusch-mbp>
References: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
 <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <c98e6252-c0af-4d25-8995-5b808b0c6da5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98e6252-c0af-4d25-8995-5b808b0c6da5@kernel.org>

On Wed, Jun 11, 2025 at 09:46:31AM +0900, Damien Le Moal wrote:
> On 6/11/25 8:18 AM, Keith Busch wrote:
> > 
> > I think you could just prep the encryption at the point the bio is split
> > to its queue's limits, and then all you need to do after that is ensure
> > the limits don't exceed what the fallback requires (which appears to
> > just be a simple segment limitation). It looks like most of the bio
> > based drivers split to limits already.
> 
> Nope, at least not DM, and by that, I mean not in the sense of splitting BIOs
> using bio_split_to_limits(). The only BIOs being split are "abnormal" ones,
> such as discard.
> 
> That said, DM does split the BIOs through cloning and also has the "accept
> partial" thing, which is used in many places and allows DM target drivers to
> split BIOs as they are received, but not necessarilly based on the device queue
> limits (e.g. dm-crypt splits reads and writes using an internal
> max_read|write_size limit).
> 
> So inline crypto on top of a DM/bio-based device may need some explicit
> splitting added in dm.c (__max_io_len() maybe ?).

Ah, thanks for pointing that out! In that case, could we have dm
consider the bio "abnormal" when bio_has_crypt_ctx(bio) is true? That
way it does the split-to-limits for these, and dm appears to do that
action very early before its own split/clone actions on the resulting
bio.
