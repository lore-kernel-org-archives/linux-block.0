Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2A1A9B32
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665776; cv=none; b=NYKW0eZx6Fs0PQlbPHAo4UchgMMpnseHX+cF1t0eXQyxfj/7/hfYthvIk/VgoTWwL3iJRblV8qEQMIubt5NDHByhVXbmNgfhkLd7+gaw2QdwFE9GsszzKgCxjxV4IFssFzF2BuHvjWSjdnB5OHoD4iyJEnGAcxHtJCVeccmvSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665776; c=relaxed/simple;
	bh=EaH6KHiQmhrjHF+PmOyITSEkkZYJGe2a030RQsc4RnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgZS/JjyA8/ePcVAsI3ygoWZkmEyIaNRF7EHjtZmrAi8GVo1Nie+jMx45dcZ2HkJS5tHUF10D5Tn0xaGY5oIKwXW3X92acHslciCLzD+4+a3EqTfpS8dYSDbfMqidL5ruZATDTIzBNMjQroGtXSKXO7LGvONJh524J0kD9JLRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGa/W6UJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGa/W6UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A70C4CEE3;
	Wed, 11 Jun 2025 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749665775;
	bh=EaH6KHiQmhrjHF+PmOyITSEkkZYJGe2a030RQsc4RnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGa/W6UJXPDy4kEctRgnbAP/zIw+wopsWzEUfJxAgnNAB4WxzDKxMMyu0mDsKUOuT
	 asI3CGzub/giO5JY2B7oczkiEHjgkR8nxScpXAoocg6aldISK0xdyiFYxAncBuG/Y5
	 8NuHOERKzej0HF+yEivd3YGB+ABTo6QrONVSIwu14OQnPIFs52s3SABXfJucTdPIqA
	 rQHF0Ja1PcCw5JN42fMH6DO7VrGdJ5Ll16UJiOmobq2yDInZXpd2Im+MCR5mCgi2XR
	 ODZ/DwCItcln57OmLqGsq+lENi/VZbhdJcO+RudwFrfrVzMMIrN0ajnLgCGoEOqtai
	 aPdUHdlw1rCLQ==
Date: Wed, 11 Jun 2025 11:15:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250611181551.GB1254@sol>
References: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
 <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <20250611034031.GA2704@lst.de>
 <20250611042148.GC1484147@sol>
 <1853d37f-b7b1-4266-b47f-8c2063f36b7d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1853d37f-b7b1-4266-b47f-8c2063f36b7d@acm.org>

On Wed, Jun 11, 2025 at 09:15:05AM -0700, Bart Van Assche wrote:
> On 6/10/25 9:21 PM, Eric Biggers wrote:
> > blk-crypto-fallback runs at the top layer, so yes it's different from native
> > inline encryption support where the encryption is done at the bottom.  (But the
> > results are the same from the filesystem's perspective, since native support
> > only gets passed through and used when it would give the expected result.)
> 
> Although I'm not sure Keith realizes this, his patch may move encryption
> from the top of the block driver stack (a device mapper driver) to the
> bottom (something else than a device mapper driver). This may happen
> because device mapper drivers do not split bios unless this is
> essential, e.g. because the LBA range of a bio spans more than one entry
> in the mapping table.
> 
> Is my understanding correct that this is acceptable because the
> encryption IV is based on the file offset provided by the filesystem and
> not on the LBA where the data is written?

The IV is provided in the bio_crypt_context.  The encryption can be done at a
lower layer, like how hardware inline encryption works, if the layers above are
compatible with it.  (E.g., they must not change the data.)

Ultimately, the data that's actually written to disk needs to be identical to
the data that would have been written if the user encrypted the data themselves
and submitted a pre-encrypted bio.

> 
> > Just keep in mind that blk-crypto-fallback is meant to work on any block device
> > (even ones that don't have a crypto profile, as the profile is just for the
> > native support).  So we do need to make sure it always gets invoked when needed.
> 
> I propose that we require that bio-based drivers must call
> bio_split_to_limits() to support inline encryption. Otherwise the
> approach of Keith's patch can't work. Does this seem reasonable to you?
> 
> As far as I can tell upstream bio-based drivers already call
> bio_split_to_limits().

Well, again it needs to work on any block device.  If the encryption might just
not be done and plaintext ends up on-disk, then blk-crypto-fallback would be
unsafe to use.

It would be preferable to have blk-crypto-fallback continue to be handled in the
block layer so that drivers don't need to worry about it.

- Eric
