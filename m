Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C327329E4B
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354295; cv=none; b=pOqMjn1RysSTZiKMmviMbbZEl50VDRl3lz+nLM8F2VyWEWrecmr/whnr5c8i/KAHSeJdQ/rkrsQwo+TaNKhio2t+3AxHMAkF1dCLAuEfb/grhQYQxq0cfBQYrDOSzEFrvYuA9yWRR50L+ssuAxvbwKxASdBrWBHMtL9Bl+NzdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354295; c=relaxed/simple;
	bh=pv5uSwS+JX7GbE8nm5cy2PnqwZKV1EyNWL6NvJ7hUj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmLb/PggDbTM4cTt/zVtQFy9GTseHMWmtq7r9dbjrF7x+AF5yKxpvb+/thGHPFABmhGNHLlxXgQHvGJbk97LHihL0BIBk8HWzUFxTxMBOM/dI0vt7YuQmAFw24x79GglzfZXgIapPfQUZq5QlQBtyFA0G8AyQOm2kFWSMY+KUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdSXdIeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdSXdIeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EF3C4CEF8;
	Wed,  5 Nov 2025 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354294;
	bh=pv5uSwS+JX7GbE8nm5cy2PnqwZKV1EyNWL6NvJ7hUj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdSXdIeOxFNYHiSR+D7DzaXJFZStoRnYjVqTEPRgfjSUPn2I2RA4t1BcxbSbEfFpd
	 Jdi3rlo+DyZiWkOsPfCHDmwk5e8ekUhJuJ9c7IcNI0Jd2mQbpHjhzOhYL+4bO3Ss0x
	 0M2KP25uQLtM0BHXhTD908Pk1BDFIkXm/JMbwJFdzq8atGG3HlyICGmlGylfCRnwJB
	 fwT7p8J3XQ7YwgjBFqmwYdRDP+Pc/NyjJT60JFx/R7Rb8RXuRO9N2DLNHjtxQHAc4Z
	 i25S9NAF4wRm/gJp5deOPjR8pThuZPpvcu3DIX1OgL/bwmxYJzZ/WJw3Zi777uEoqS
	 Mq+UVPHvghYzw==
Date: Wed, 5 Nov 2025 07:51:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, axboe@kernel.dk
Subject: Re: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <aQtkdNQOA1Twvoeh@kbusch-mbp>
References: <20251104224045.3396384-1-kbusch@meta.com>
 <20251105141504.GC22325@lst.de>
 <aQtiYd69E-3G_PC4@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtiYd69E-3G_PC4@kbusch-mbp>

On Wed, Nov 05, 2025 at 07:42:41AM -0700, Keith Busch wrote:
> On Wed, Nov 05, 2025 at 03:15:04PM +0100, Christoph Hellwig wrote:

... 

> > What does that union of two pointers 

...

>  Using a union ensures that it's definitely big enough for any
>  checksum type.

Oh geez, it should have been a union of the structs, not pointers to
those types... So this is a mistake in the code, but I hope the
intention is more clear.
