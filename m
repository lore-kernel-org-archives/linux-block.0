Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CA2CA8
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560478; cv=none; b=VvbE14tUKLVu+W9OH0Sa+9wlJz67vbK2vDjeN+cLv7J4hJSSEfnR8AJo6XP/ZffmJoGoSzEVQqj+CqCXIiG/MhvLTdr8QnSNeP3HDntfBh1xXSteSubD/h6dcL794JpitE2YizQpfhjljH64B/SgRkumzJOSe3WgVCpgjqjKrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560478; c=relaxed/simple;
	bh=gG67mmSHpWMDHGQ5B5/NBypiU12yaMpQ8Dyvpqk+GL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UveGrSMm5BepclPT4Ez4TZLlewEUifgLiX8VvQkgWDs7JTPoEbD8smfmZuwal77BvKXiApq+DOGgzmkZTF/mhyW1Ph4semacwAm4/99u0sb+/5PfR7fWyM+e1c6eBQTaeMgtcwiqufumh9/8oD9uOrClQMoRYmsAPg6hxvb1yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A83468AA6; Tue, 15 Jul 2025 08:21:12 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:21:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Message-ID: <20250715062112.GC18672@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org> <20250711171853.68596-3-bvanassche@acm.org> <20250715021810.GA426229@google.com> <20250715053735.GA18120@lst.de> <20250715061117.GA595531@sol>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715061117.GA595531@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 11:11:17PM -0700, Eric Biggers wrote:
> I've actually been thinking of going in the other direction: dropping
> the support for fs-layer file contents encryption from ext4 and f2fs,
> and instead just relying on blk-crypto.  That would simplify ext4 and
> f2fs quite a bit, as they'd then have just one file contents encryption
> code path to support.  Also, blk-crypto "just works" with large folios,
> whereas the fs-layer code doesn't support large folios yet.
> 
> But that will only work if blk-crypto-fallback continues to support all
> block devices.
> 
> So, effectively you are advocating for keeping the fs-layer file
> contents encryption code in ext4 and f2fs forever?

I think those two concerns are almost unrelated.

Dropping the fscrypt code and relying on blk-crypto is a good idea and
should be done.

But at the same time we should stop pretend that the block layer will
handle the fallback, and instead require drivers to explicitly support
blk-crypto either natively or the fallback, and else fscrypt or other
blk-crypto users simply aren't supported at all.

Note that with something like this series from Bart all drivers that call
bio_split_to_limits will just support blk-crypto, and that includes all
blk-mq drivers and device mapper.  So without further work you'll just be
left with a few random drivers that almost no one cares about left
uncovered.  If someone wants to run fscrypt on those they can wire it up
to manually call into the blk-crypto fallback, which should not be hard.
