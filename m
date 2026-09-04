Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DD51A728;
	Fri,  4 Sep 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547039; cv=none; b=elncLdzbECiwLtikfGGJnucaLyAMB75J6W5U1lDjfT9eaBrT/5/Ks6K8vqS0zUUtXBpnXTmWypDcp0X99D5C3+P8L+WwSMR6/h99G4JLfzBk9inutUaz4Gxwu9tA8e0qoI/OKCefQ7dZQCxBHS/nTA7mMFfdOB7lUxVgQUkiL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547039; c=relaxed/simple;
	bh=20knYJ5kSJdybW2OL3KieqRhYUryt/YoaxKP7rodUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzunAnvARjHU9PW+QV/omTqomJO8IEed6weUZbs3MR4XWy9sUfuR+5ykxiWeRRuIDaUSepRoYjfJqtcT1yLzxqaJkw1UPL0Tk/AOr/D1hbj0CiuMl7OeS7CuX/BIWFSfFSmW1RdD7Ymw/IaRz3/Y9WZs6javVMoYbuYYvOzwwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA70/Ths; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA70/Ths"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0911F00A3D;
	Fri,  4 Sep 2026 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547038;
	bh=tq1bzaVVS005rlNGqBmwELrctgsquIOpohXUFR8o3os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KA70/ThsogUrSwsr0vLQri/0uHT0I+4zLVmICigdYk410ZTFMY8Ihb7dh/vILAYxC
	 /jOUTh62vNrwJdstU63gq6VSAAK0IsSRKp6NEeqVFDc4m8SFtFddcMnmxyQPrsc03m
	 5i5HOw+9ZyEX0bffrt5iTiAjJ4GhxFvqRz1k1mMG6R7NCw37/HijQPl2YSxuJSXVF7
	 Srjs5IqSodTlobydzrl+qvTlyqTKS0BBnfa5a+3AuHx1ItTAgsNM/6R8ShxFmSZmjE
	 M/rrbng1ooPu4HcPIUwwtLW9PXrPUs2DTjcKKWclhMArYr0ce346OSK+vDf+JQ7e0i
	 8CCYzFJ9hAsUg==
Date: Fri, 4 Sep 2026 12:37:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <apsP3Hvlw-fpd6uF@kbusch-mbp>
References: <20260902112743.GA11999@lst.de>
 <1819786.1787768317@warthog.procyon.org.uk>
 <1895550.1787777192@warthog.procyon.org.uk>
 <350212.1788514937@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350212.1788514937@warthog.procyon.org.uk>

On Fri, Sep 04, 2026 at 10:42:17AM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Should this grow a comment explaining why for non-iov/kvec/ubuf
> > we check the alignment of every sector instead of just the
> > start alignment?
> 
> There should possibly be a comment explaining the need for an address
> alignment at all.  Is it mandatory for all devices?  Or are we being a bit
> over restrictive?  I don't think NICs capable of RDMA are so restricted, for
> example.

If a block device behind an RDMA NIC really wants to DMA a single byte
at a time, we can't describe that capability today. That would require a
0 mask, which is currently treated as "unset" and overridden with a
default 512b mask.
