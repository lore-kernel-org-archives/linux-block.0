Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FB2D879D
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898271; cv=none; b=fFrc4UC6OjgIFvu4/3IaXz145S4/drKvTf6VQ1FPjjneOwSAlH2RjPq5T+gYCNsIKJ0DFmUb5eyhj6ElewMEvG519VRdw0CWmECVfS4M53HAEJPUXQRktwjj+KmvJj99DejgCb9gKsjlOU9GktqeQ0lZ+zten39kKLJpFjRFB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898271; c=relaxed/simple;
	bh=Pe0Mos0PMM22VufbyPJTrr0R+UR662fysYzPLzi8JD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4h5yOig0wWW0Q7t5x6hJhsE8v0Sy8hGighlhQ0Q+lp5TgwUuK9LSkurIk57fihx8x+jFQTqg30004DXvpQ9J1I+iOnlBKbYZiT+wwBKPg3P5DmKMV9WAZIUcfOBfHk7wCndOsavvLNTFRsVwPtu41GDe459/cI1decIyX0XOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcOEGt7l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcOEGt7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71860C4CEE3;
	Mon,  7 Jul 2025 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751898270;
	bh=Pe0Mos0PMM22VufbyPJTrr0R+UR662fysYzPLzi8JD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcOEGt7l2Mn3kkpMNxemia37CEyOQSsyo69Q/e4Y1jK2rJYfTyVqZhZlvZm3WLC7Y
	 G70jXepNmc3yY891EivmFRunF89p+VKzTq76zeggA+Y/Bb01Xp5DImfT/480ATs4Ok
	 8PdbyaseQhChfkk3D0dvCuskgz7+gCzBc12fDmMz4UDEQtBWHKd5z+UYye66OaJK4P
	 IAiVwm9EmLcqS+Se7HCUl7UlPciZCwzOUiRcdo9eep27CwGElkHleIljjNzFwRThe5
	 FJRPeEkR4YSLelgVJZgntfe2prfzJWY8XEk2DMnp8VZysyzBK5DCdKN+vTpQJz0tiQ
	 wH/86rjj8r7JQ==
Date: Mon, 7 Jul 2025 08:24:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGvYnMciN_IZC65Z@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> We could:
> 
>  I.	 revert the check and the subsequent fixup.  If you really want
>          to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>  II.	 limit the check to multi-controller subsystems
>  III.	 don't allow atomics on controllers that only report AWUPF and
>  	 limit support to controllers that support that more sanely
> 	 defined NAWUPF
> 
> I guess for 6.16 we are limited to I. to bring us back to the previous
> state, but I have a really bad gut feeling about it given the really
> bad spec language and a lot of low quality NVMe implementations we're
> seeing these days.

I like option III. The controler scoped atomic size is broken for all
the reasons you mentioned, so I vote we not bother trying to make sense
of it.
