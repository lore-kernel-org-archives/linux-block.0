Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435D377541
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959925; cv=none; b=Q8WpiW52CpWig+89SYMzHSmeE6VeoBN9qH2G0aIscfZfpuePGdz34PSiq2BEeQT9fMkDdNifq4t1Imb3pXmd6R0Nrr3gP/sIXsGanHSGUbueHjppmajknfOzwq3uPTjjWOErVcPmN4U/dt9Stz2j+19i9W1GtYNpmavINLSA24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959925; c=relaxed/simple;
	bh=n0piFM6td5YJ9rza+hALM8wmLUATqcbERTab/tcG3dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLlOLgVQj5WmtVeLNDzGK7pQDYnnA0O87fRRdYFBCUBFoYG7Af6NtAxhm6Ve9WMlNlZHyRjPtUeBSM2XSoXJEdp4igXJbsMnUAKTCW11t7PTiPcR5zjZEzE/zp8CTTwYCOM0phYQhtDNjXzf5Ec/w/BiVQXbl12oQBvbM2FyB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KAEtsuPn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KAEtsuPn"
Received: from macsyma.thunk.org (pool-173-48-112-174.bstnma.fios.verizon.net [173.48.112.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62VCP8rd022421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774959911; bh=fdOP8visk7cKRiZ6NwhJ4cEjsgJGX4FIeq89aIz+x5Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KAEtsuPn7PaE96gEM2V5Xf2XkfNYuLS3McikeWBsQ0TBhXtledxhmuRUB1ZTToA8n
	 EqOUU7V4obue9/6YOhNUV0+qcGC3C92GkbCoYMSG1U8WRzupPyxnIVQ/5gbgxd+FTL
	 CyHtLtPFTaBggMRblQIj2gh53A9DISKB9qg1dKgewGStRyTnW6JcaiYbcdb5JGy7lq
	 nxwwA0HFXUuvXJrIPIToiT5Dt4nfhNYWTORjYRgrAm0gI0omVZx8Z2JIjtN8W48DuT
	 rbSCqstrRn1/cy24a1ssQ61ajGnp7QmPS+6e1c6H1/bII+s51wLzHHCFDw/wXQKkfP
	 uyiaZ6F77Ilfg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0F6316029A7B; Tue, 31 Mar 2026 08:24:08 -0400 (EDT)
Date: Tue, 31 Mar 2026 08:24:08 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, axboe@kernel.dk,
        dvyukov@google.com, adilger.kernel@dilger.ca,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] loop: block changing lo_offset/lo_sizelimit on
 mounted device
Message-ID: <20260331122408.GB74409@macsyma-wired.lan>
References: <20260331054648.4548-1-kartikey406@gmail.com>
 <act2Kh8u2I5HPVlv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act2Kh8u2I5HPVlv@infradead.org>

On Tue, Mar 31, 2026 at 12:22:18AM -0700, Christoph Hellwig wrote:
> 
> And I would not be surprised if this breaks something in blktests or
> xfstests as they heavily rely on resizing block devices.  Did you
> do full runs of those?  Especially with xfs and btrfs for xfstests
> as they do a lot more loop based tests?

Do we expect people to seriously be running with
!CONFIG_BLK_DEV_WRITE_MOUNTED?  I view this as a syzkaller noise
suppression only.  As I mentioned earlier this option will very likely
break grub.

I do think that we need to have a way of disabling write access on a
per-super or per-file system type basis, eventually.  Perhaps we need
to get there sooner rather than later?  Would that make you happier?

					- Ted
